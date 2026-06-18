# Source transcriptions (human-verified)

The original Scott-domain papers are **scanned PDFs** or have **unreliable text layers**.
Each source is transcribed to Markdown with **LaTeX math**, verified page-by-page against
the PDF.

## Papers (chronological order)

| # | PDF | Vision OCR output | Legacy pdftotext draft |
| --- | --- | --- | --- |
| 1 | `ScottContinLatt1972.pdf` | `ScottContinLatt1972_vision.md` | `ScottContinLatt1972.md` |
| 2 | `PRG19.pdf` | `PRG19_vision.md` | `PRG19.md` |
| 3 | `Domains_for_Denotational_Semantics.pdf` | `Domains_for_Denotational_Semantics_vision.md` | `Domains_for_Denotational_Semantics.md` |
| 4 (stretch) | `DTR97-1.pdf` | `DTR97-1_vision.md` | `DTR97-1.md` |

**Prefer the `*_vision.md` files** for formalization — they use Cursor vision OCR with
LaTeX notation. The older `*.md` drafts (pdftotext/OCR) remain as fallbacks.

---

## Recommended workflow: vision OCR (3-pass + merge)

Uses the **Cursor API** (local agent + vision) with your key in
`../tokens_ssto.yaml` (`CURSOR_API_KEY`). **Do not commit that file.**

### One-time setup

```bash
python3 -m venv .venv-ocr
.venv-ocr/bin/pip install -r scripts/requirements-ocr.txt
```

### Run (per PDF)

```bash
# Segment PDF → PNGs, OCR each page 3×, merge, stitch
bash scripts/ocr_pdf_pipeline.sh ScottContinLatt1972.pdf

# Partial run (resume skips pages that already have merged.md)
bash scripts/ocr_pdf_pipeline.sh ScottContinLatt1972.pdf --pages 3-40 --skip-render

# Failed page retry
bash scripts/ocr_pdf_pipeline.sh ScottContinLatt1972.pdf --pages 20 --force

# PNGs only (no API calls)
bash scripts/ocr_pdf_pipeline.sh ScottContinLatt1972.pdf --png-only

# Re-stitch after manual edits to sources/pages/<pdf>/page-NN/merged.md
bash scripts/ocr_pdf_pipeline.sh ScottContinLatt1972.pdf --merge-only
```

Transient API errors are retried automatically (5 attempts, exponential backoff from
15 s). Progress is logged to `sources/ocr_<PDF-stem>_run.log`. The stitched
`*_vision.md` updates after each completed page.

### What the pipeline does

1. **Segment:** `pdftoppm` → `sources/pages/<PDF-stem>/page-NN.png` (200 dpi default).
2. **Triple OCR:** Each page is sent to the Cursor vision model **3 times** with different
   instructions (literal / math-first / conservative `[?]` flags) — approximating
   multiple OCR seeds.
3. **Merge:** A 4th vision call compares the 3 transcripts against the PNG and writes
   `sources/pages/<PDF-stem>/page-NN/merged.md`.
4. **Stitch:** All completed `merged.md` files → `sources/<PDF-stem>_vision.md`.

Intermediate files (`pass1.md`, `pass2.md`, `pass3.md`) are kept for audit. Page PNGs
and the venv are gitignored (large/regenerable).

**Timing:** ~2–4 minutes per page (4 API calls, ~30–90 s each). A 40-page paper ≈ 1.5–2.5 hours.

### Human verification

1. Open the PDF beside `sources/<stem>_vision.md` (or per-page `merged.md`).
2. Fix LaTeX, theorem numbers, and any remaining OCR glitches.
3. Update YAML front matter:

   ```yaml
   verification_status: verified
   verified_by: Your Name
   verified_date: 2026-06-18
   ```

---

## Legacy workflow: pdftotext draft + cleanup

Faster but **no reliable LaTeX**; useful only as a rough index:

```bash
python3 scripts/pdf_to_source_md.py ScottContinLatt1972.pdf
python3 scripts/clean_source_md.py ScottContinLatt1972.md
```

---

## Formalization follows verification

Lean proofs cite the **verified** `*_vision.md` (theorem numbers, definitions) — not raw
PDF extraction.
