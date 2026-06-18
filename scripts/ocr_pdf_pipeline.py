#!/usr/bin/env python3
"""
Segment a source PDF into PNGs and OCR each page via Cursor vision (3 passes + merge).

Requires:
  - pdftoppm (poppler)
  - Python venv: .venv-ocr/ with cursor-sdk, pyyaml
  - API key in ../tokens_ssto.yaml (CURSOR_API_KEY) — never commit that file

Usage:
  .venv-ocr/bin/python scripts/ocr_pdf_pipeline.py ScottContinLatt1972.pdf
  .venv-ocr/bin/python scripts/ocr_pdf_pipeline.py ScottContinLatt1972.pdf --pages 1-3
  .venv-ocr/bin/python scripts/ocr_pdf_pipeline.py ScottContinLatt1972.pdf --png-only
  .venv-ocr/bin/python scripts/ocr_pdf_pipeline.py ScottContinLatt1972.pdf --merge-only
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path

import yaml
from cursor_sdk import Agent, AgentOptions, LocalAgentOptions, SDKImage, UserMessage

ROOT = Path(__file__).resolve().parent.parent
TOKENS = ROOT.parent / "tokens_ssto.yaml"
VENV_PY = ROOT / ".venv-ocr/bin/python"
PAGES_ROOT = ROOT / "sources" / "pages"

# Three prompt variants (approximate "different seeds" — vary instruction, not RNG).
PASS_PROMPTS = [
    """Transcription pass A (literal): Transcribe this page exactly as printed.
Output Markdown only. Reflow broken lines into sentences/paragraphs.
Use LaTeX for math: $T_0$, $\\ll$, $\\sqcup$, $\\lambda$, etc.
Do not add commentary.""",
    """Transcription pass B (math-first): Transcribe this page; prioritize correct
mathematical notation as LaTeX (inline $...$ or display $$...$$).
Prose as normal paragraphs. Reflow line breaks. Markdown only.""",
    """Transcription pass C (conservative): Transcribe this page; mark any character
you are not confident about as [?x]. Use LaTeX for math symbols.
Reflow paragraphs. Markdown only.""",
]

MERGE_PROMPT = """You are reconciling three independent OCR transcriptions of the same
PDF page (image attached). Each pass may differ on OCR glitches.

Pass 1:
---
{pass1}
---

Pass 2:
---
{pass2}
---

Pass 3:
---
{pass3}
---

Produce ONE final Markdown transcription:
- Where all three agree, use that text.
- Where they disagree, use the image to decide; if still uncertain, use [?…].
- Proper LaTeX for all mathematics.
- Reflowed prose paragraphs; preserve section headings and numbered statements.
- Output ONLY the final page content (no meta-commentary)."""


@dataclass
class PageJob:
    pdf_stem: str
    page_num: int
    png_path: Path
    work_dir: Path


def load_api_key() -> str:
    if not TOKENS.exists():
        raise SystemExit(f"Missing API key file: {TOKENS}")
    data = yaml.safe_load(TOKENS.read_text())
    key = (data.get("CURSOR_API_KEY") or data.get("cursor_api_key") or "").strip()
    if not key:
        raise SystemExit(f"No CURSOR_API_KEY in {TOKENS}")
    return key


def pdf_page_count(pdf: Path) -> int:
    out = subprocess.check_output(["pdfinfo", str(pdf)], text=True)
    for line in out.splitlines():
        if line.startswith("Pages:"):
            return int(line.split(":")[1].strip())
    raise RuntimeError(f"Could not read page count: {pdf}")


def render_pdf_to_png(pdf: Path, out_dir: Path, dpi: int = 200) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    prefix = out_dir / "page"
    subprocess.run(
        ["pdftoppm", "-png", "-r", str(dpi), str(pdf), str(prefix)],
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    pngs = sorted(out_dir.glob("page-*.png"))
    if not pngs:
        raise RuntimeError(f"No PNGs produced in {out_dir}")
    return pngs


def parse_page_range(spec: str | None, total: int) -> list[int]:
    if not spec:
        return list(range(1, total + 1))
    pages: set[int] = set()
    for part in spec.split(","):
        part = part.strip()
        if "-" in part:
            a, b = part.split("-", 1)
            pages.update(range(int(a), int(b) + 1))
        else:
            pages.add(int(part))
    return sorted(p for p in pages if 1 <= p <= total)


def vision_prompt(api_key: str, png: Path, text: str) -> str:
    result = Agent.prompt(
        UserMessage(text=text, images=[SDKImage.from_file(png)]),
        AgentOptions(
            api_key=api_key,
            model="composer-2.5",
            local=LocalAgentOptions(cwd=str(ROOT)),
        ),
    )
    if result.status != "finished":
        raise RuntimeError(f"OCR failed ({png.name}): status={result.status}")
    body = (result.result or "").strip()
    # Strip markdown fences if model wrapped output.
    body = re.sub(r"^```(?:markdown|md)?\s*\n", "", body)
    body = re.sub(r"\n```\s*$", "", body)
    return body.strip() + "\n"


def ocr_page_triple(api_key: str, job: PageJob, force: bool) -> None:
    job.work_dir.mkdir(parents=True, exist_ok=True)
    passes: list[str] = []
    for i, prompt in enumerate(PASS_PROMPTS, start=1):
        out = job.work_dir / f"pass{i}.md"
        if out.exists() and not force:
            print(f"  pass{i}: cached", file=sys.stderr)
            passes.append(out.read_text(encoding="utf-8"))
            continue
        print(f"  pass{i}: OCR...", file=sys.stderr)
        text = vision_prompt(api_key, job.png_path, prompt)
        out.write_text(text, encoding="utf-8")
        passes.append(text)
        time.sleep(1)  # gentle rate limit

    merged = job.work_dir / "merged.md"
    if merged.exists() and not force:
        print("  merge: cached", file=sys.stderr)
        return
    print("  merge: reconciling 3 passes...", file=sys.stderr)
    merge_text = MERGE_PROMPT.format(pass1=passes[0], pass2=passes[1], pass3=passes[2])
    final = vision_prompt(api_key, job.png_path, merge_text)
    merged.write_text(final, encoding="utf-8")


def stitch_document(pdf_stem: str, page_nums: list[int] | None, out_md: Path) -> None:
    png_dir = PAGES_ROOT / pdf_stem
    available: list[int] = []
    for d in sorted(png_dir.glob("page-*")):
        if not d.is_dir():
            continue
        m = re.match(r"page-(\d+)$", d.name)
        if m and (d / "merged.md").exists():
            available.append(int(m.group(1)))
    if page_nums:
        # After OCR, stitch everything completed so far (incremental builds).
        stitch_pages = sorted(set(available))
    else:
        stitch_pages = available
    if not stitch_pages:
        print("WARN: no merged.md files to stitch", file=sys.stderr)
        return
    meta = f"""---
source_pdf: {pdf_stem}.pdf
ocr_method: cursor-vision-triple-merge
verification_status: draft
---

# Transcription (LLM vision OCR)

"""
    parts = [meta]
    for n in stitch_pages:
        merged = PAGES_ROOT / pdf_stem / f"page-{n:02d}" / "merged.md"
        if not merged.exists():
            print(f"WARN: missing {merged}", file=sys.stderr)
            continue
        parts.append(f"\n<!-- page {n} -->\n\n")
        parts.append(merged.read_text(encoding="utf-8"))
        if not parts[-1].endswith("\n"):
            parts.append("\n")
    out_md.write_text("".join(parts), encoding="utf-8")
    print(f"Stitched {out_md} ({len(stitch_pages)} pages)", file=sys.stderr)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("pdf", type=Path, help="PDF in repo root")
    ap.add_argument("--pages", help="Page range, e.g. 1-5 or 1,3,7")
    ap.add_argument("--dpi", type=int, default=200)
    ap.add_argument("--png-only", action="store_true")
    ap.add_argument("--merge-only", action="store_true", help="Skip OCR; stitch existing merged.md")
    ap.add_argument("--force", action="store_true", help="Re-OCR even if pass*.md exist")
    ap.add_argument(
        "--out",
        type=Path,
        help="Output stitched MD (default: sources/<stem>_vision.md)",
    )
    args = ap.parse_args()

    pdf = args.pdf if args.pdf.is_absolute() else ROOT / args.pdf.name
    if not pdf.exists():
        raise SystemExit(f"PDF not found: {pdf}")

    stem = pdf.stem
    png_dir = PAGES_ROOT / stem
    out_md = args.out or (ROOT / "sources" / f"{stem}_vision.md")

    total = pdf_page_count(pdf)
    page_nums = parse_page_range(args.pages, total)

    if not args.merge_only:
        print(f"Rendering {pdf.name} ({total} pages) at {args.dpi} dpi...", file=sys.stderr)
        pngs = render_pdf_to_png(pdf, png_dir, dpi=args.dpi)
        if len(pngs) != total:
            print(f"WARN: expected {total} PNGs, got {len(pngs)}", file=sys.stderr)

        if args.png_only:
            print(f"PNG-only: wrote {len(pngs)} files to {png_dir}", file=sys.stderr)
            return

        api_key = load_api_key()
        for n in page_nums:
            png = png_dir / f"page-{n:02d}.png"
            if not png.exists():
                print(f"SKIP missing {png}", file=sys.stderr)
                continue
            print(f"Page {n}/{total}...", file=sys.stderr)
            job = PageJob(stem, n, png, png_dir / f"page-{n:02d}")
            ocr_page_triple(api_key, job, force=args.force)

    stitch_document(stem, page_nums if not args.merge_only else None, out_md)


if __name__ == "__main__":
    main()
