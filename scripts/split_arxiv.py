#!/usr/bin/env python3
"""Rough-split domain_theory/arxiv.md into per-repo arxiv.md files."""

from __future__ import annotations

import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "arxiv.md"
DESKTOP = ROOT.parent

REPOS = {
    "scott1972": DESKTOP / "scott1972",
    "scott1980": DESKTOP / "scott1980",
    "scott1982": DESKTOP / "scott1982",
    "scott_models": DESKTOP / "scott_models",
}


def lines() -> list[str]:
    return SRC.read_text().splitlines(keepends=True)


def slice_lines(start: int, end: int) -> str:
    """1-based inclusive line numbers."""
    return "".join(lines()[start - 1 : end])


def renumber_h2(text: str, old: str, new: str) -> str:
    return text.replace(f"## {old}", f"## {new}", 1)


def patch_1972(body: str) -> str:
    body = body.replace("## 3. Part I", "## 1. Part I", 1)
    body = body.replace("### 3.", "### 1.")
    body = body.replace("Domain/ContinuousLattice/", "Scott1972/ContinuousLattice/")
    body = body.replace("`Domain.lean`", "`Scott1972.lean`")
    body = body.replace("lake build Domain", "lake build Scott1972")
    return body


def patch_1980(body: str) -> str:
    body = body.replace("## 4. Part II", "## 1. Part II", 1)
    body = body.replace("### 4.", "### 1.")
    body = body.replace("Domain/ContinuousLattice/*", "Scott1972/ContinuousLattice/*")
    body = body.replace("Domain/Neighborhood/", "Scott1980/Neighborhood/")
    body = body.replace("`Domain.lean`", "`Scott1980.lean`")
    body = body.replace("lake build Domain", "lake build Scott1980")
    return body


def patch_1982(body: str) -> str:
    body = body.replace("## 5. Part III", "## 1. Part III", 1)
    body = body.replace("### 5.", "### 1.")
    body = body.replace("Domain/InfoSys.lean", "Scott1982/InfoSys.lean")
    body = body.replace("Domain/Constructive.lean", "Scott1982/Constructive.lean")
    body = body.replace("`Domain.lean`", "`Scott1982.lean`")
    body = body.replace("lake build Domain", "lake build Scott1982")
    return body


def patch_models(body: str) -> str:
    body = body.replace("## 6. Part IV", "## 1. Part IV", 1)
    body = body.replace("### 6.", "### 1.")
    body = body.replace("Domain/Constructive.lean", "Scott1982/Constructive.lean")
    body = body.replace("Domain/Equivalence/", "ScottModels/")
    body = body.replace("Domain/ContinuousLattice/", "Scott1972/ContinuousLattice/")
    body = body.replace("Domain/Neighborhood/", "Scott1980/Neighborhood/")
    body = body.replace("Domain/InfoSys.lean", "Scott1982/InfoSys.lean")
    body = body.replace("lake build Domain", "lake build ScottModels")
    return body


HEADER_1972 = """# Scott 1972 *Continuous Lattices* in Lean 4 (Part I)

---

## Abstract

Lean 4 / mathlib formalization of Dana Scott's **1972** *Continuous Lattices* (LNM 274):
injective `T₀`-spaces, Scott topology, way-below, function spaces, inverse limits.

This repository is **Part I** of a four-part monograph. Equivalence theorems (Parts I–III)
live in [`scott_models`](https://github.com/catskillsresearch/scott_models).

**Inventory source of truth:** this file (`arxiv.md`). Do not use generated `arxiv_with_code.md`.

---

"""

HEADER_1980 = """# Scott 1981 PRG-19 Neighborhood Systems in Lean 4 (Part II)

---

## Abstract

Lean 4 / mathlib formalization of Dana Scott's **1981** PRG-19 *Lectures on a Mathematical
Theory of Computation* — neighbourhood systems (filters on a master set Δ; domain elements as
filters), approximable maps, and the full PRG-19 exercise spine through Lecture VII.

This repository is **Part II** of a four-part monograph. Equivalence theorems live in
[`scott_models`](https://github.com/catskillsresearch/scott_models).

**Inventory source of truth:** this file (`arxiv.md`).

---

"""

HEADER_1982 = """# Scott 1982 Information Systems in Lean 4 (Part III)

---

## Abstract

Lean 4 formalization of Dana Scott's **1982** *Domains for Denotational Semantics* (ICALP) —
information systems (finite consistency + entailment on tokens), developed **constructively**
(`#print axioms ⊆ {propext, Quot.sound}`).

This repository is **Part III** of a four-part monograph. Equivalence theorems live in
[`scott_models`](https://github.com/catskillsresearch/scott_models).

**Inventory source of truth:** this file (`arxiv.md`).

---

"""

HEADER_MODELS = """# Scott Domain Theory: Equivalence of the Three Presentations (Part IV)

---

## Abstract

**Part IV** of the Scott domain theory monograph: explicit Lean bridge theorems showing Scott's
1972 continuous-lattice, 1981 neighbourhood-system, and 1982 information-system presentations
determine the same class of domains (up to isomorphism), with constructivity audits at the
classical frontier.

Depends on [`scott1972`](https://github.com/catskillsresearch/scott1972),
[`scott1980`](https://github.com/catskillsresearch/scott1980), and
[`scott1982`](https://github.com/catskillsresearch/scott1982).

**Inventory source of truth:** this file (`arxiv.md`).

---

"""

FOOTER_1972 = """
---

## Build

```bash
lake exe cache get
lake build Scott1972
```

## Appendix — Lean source index (Part I)

| File | Role |
| --- | --- |
| `Scott1972.lean` | Root import graph |
| `Scott1972/ContinuousLattice/Injective.lean` | Scott §1 |
| `Scott1972/ContinuousLattice/WayBelow.lean` | Scott §2 |
| `Scott1972/ContinuousLattice/Specialization.lean` | Scott §2 |
| `Scott1972/ContinuousLattice/ScottMaps.lean` | Scott §2 |
| `Scott1972/ContinuousLattice/MilnerCorrection.lean` | March 1972 correction |
| `Scott1972/ContinuousLattice/Constructions.lean` | Scott §2.8–2.12 |
| `Scott1972/ContinuousLattice/FunctionSpaces.lean` | Scott §3 |
| `Scott1972/ContinuousLattice/Theorem212.lean` | Theorem 2.12 |
| `Scott1972/ContinuousLattice/InverseLimits.lean` | Scott §4 |
| `Scott1972/ContinuousLattice/FunctionSpaceTower.lean` | Theorem 4.4 |

Vision transcript: `sources/ScottContinLatt1972_vision.md`.

---

## References (Part I)

- **[Sco72]** D. Scott. *Continuous Lattices*. LNM 274, Springer, 1972.
- **[GHKLMS03]** Gierz et al. *Continuous Lattices and Domains*. Cambridge, 2003.
- **[Kel55]** J. L. Kelley. *General Topology*. 1955.
"""

FOOTER_1980 = """
---

## Build

```bash
lake exe cache get
lake build Scott1980
```

## Appendix — Lean source index (Part II)

All modules under `Scott1980/Neighborhood/`, wired from `Scott1980.lean` in dependency order.

Vision transcript: `sources/PRG19_vision.md`.

---

## References (Part II)

- **[Sco81]** D. Scott. *Lectures on a Mathematical Theory of Computation*. PRG-19, Oxford, 1981.
- **[Win93]** G. Winskel. *The Formal Semantics of Programming Languages*. MIT Press, 1993.
"""

FOOTER_1982 = """
---

## Build

```bash
lake exe cache get
lake build Scott1982
```

## Appendix — Lean source index (Part III)

| File | Role |
| --- | --- |
| `Scott1982.lean` | Root import graph |
| `Scott1982/Constructive.lean` | Choice-free `Finset` prelude |
| `Scott1982/InfoSys.lean` | Scott Def 2.1 + elements (stub) |

Vision transcript: `sources/Domains_for_Denotational_Semantics.md`.

---

## References (Part III)

- **[Sco82]** D. Scott. *Domains for Denotational Semantics*. ICALP 1982, LNCS 140.
- **[Win93]** G. Winskel. *The Formal Semantics of Programming Languages*. MIT Press, 1993.
"""

FOOTER_MODELS = """
---

## Build

```bash
lake exe cache get
lake build ScottModels
```

Requires sibling packages `scott1972`, `scott1980`, `scott1982` (Lake path deps in `lakefile.toml`).

---

## Related work

- mathlib: `Topology.Order.ScottTopology`, `Order.ScottContinuity`, `Order.OmegaCompletePartialOrder`.
- Abramsky–Jung, *Domain Theory* handbook chapter.
- Gierz et al., *Continuous Lattices and Domains*.

---

## References

- **[Sco72]**, **[Sco81]**, **[Sco82]** — the three source presentations.
- **[AJ94]** Abramsky–Jung. *Domain Theory*.
- **[GHKLMS03]** Gierz et al. *Continuous Lattices and Domains*.
"""


def write_arxiv(repo: str, content: str) -> None:
    path = REPOS[repo] / "arxiv.md"
    path.write_text(content)
    print(f"Wrote {path} ({len(content.splitlines())} lines)")


def main() -> None:
    # Line ranges from grep on monolith arxiv.md (1-based inclusive).
    part_i = slice_lines(369, 1326)
    part_ii = slice_lines(1328, 2415)
    part_iii = slice_lines(2417, 2465)
    blueprint_22_23 = slice_lines(310, 367)  # §2.1–2.3 for models context
    part_iv = slice_lines(2467, 2506)
    related = slice_lines(2509, 2515)

    write_arxiv(
        "scott1972",
        HEADER_1972 + patch_1972(part_i) + FOOTER_1972,
    )
    write_arxiv(
        "scott1980",
        HEADER_1980 + patch_1980(part_ii) + FOOTER_1980,
    )
    write_arxiv(
        "scott1982",
        HEADER_1982 + patch_1982(part_iii) + FOOTER_1982,
    )
    models_body = patch_models(blueprint_22_23 + part_iv + related)
    write_arxiv(
        "scott_models",
        HEADER_MODELS + models_body + FOOTER_MODELS,
    )

    for repo in REPOS:
        if not (REPOS[repo] / ".git").exists():
            print(f"skip commit: no git in {repo}")
            continue
        subprocess.run(["git", "add", "arxiv.md"], cwd=REPOS[repo], check=True)
        status = subprocess.run(
            ["git", "diff", "--cached", "--quiet"],
            cwd=REPOS[repo],
        )
        if status.returncode == 0:
            print(f"no changes to commit in {repo}")
            continue
        subprocess.run(
            [
                "git",
                "commit",
                "-m",
                "Add Part-specific arxiv.md split from domain_theory monolith.",
            ],
            cwd=REPOS[repo],
            check=True,
        )


if __name__ == "__main__":
    main()
