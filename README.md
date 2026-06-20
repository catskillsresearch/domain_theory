[![Lean 4](https://img.shields.io/github/actions/workflow/status/catskillsresearch/hybrid_logic_lean_revisited/build.yml?label=Lean%204)](https://github.com/catskillsresearch/domain_theory/actions/workflows/build.yml)
# domain_theory

A **Lean 4** formalization of Dana Scott's domain theory via **Scott Information
Systems**, with an accompanying paper.

Rather than building domains out of the Scott topology and directed-complete partial
orders directly — which carries a large amount of order-theoretic and topological
overhead — this development follows Scott's *information systems*: a discrete,
inductive, combinatorial presentation in which Scott domains are built from sets of
*tokens* together with a consistency predicate and an entailment relation. The domain
is recovered as the poset of *ideals* (consistent, entailment-closed sets of tokens)
ordered by inclusion.

The mathematics follows:

- Dana Scott, *"Domains for Denotational Semantics"* (ICALP, 1982) — the paper that
  introduced information systems.
- Glynn Winskel, *The Formal Semantics of Programming Languages*, Chapter 8
  (*Information Systems*) — a compact, self-contained construction of the domain of
  ideals, the function space `D → E`, product `D × E`, and sum `D + E`.

The article-length narrative, background, motivation, and the formalization plan live
in **[`arxiv.md`](arxiv.md)**. Background notes are in `domain_notes.txt`.

## Building

Requires **Lean v4.30.0** and **mathlib v4.30.0** (pinned in `lean-toolchain` and
`lake-manifest.json`).

```bash
lake exe cache get   # fetch prebuilt mathlib oleans
lake build
```

## Layout

- `Domain.lean` — root module (imports the library in dependency order).
- `Domain/` — the Lean library.
- `sources/` — **human-verified Markdown transcriptions** of the source PDFs (see
  [`sources/README.md`](sources/README.md)). Formalization follows verified text.
- `arxiv.md` — the paper narrative.
- `scripts/` — arXiv build pipeline and `pdf_to_source_md.py` (PDF → draft MD).

## Status

- Build environment: Lean v4.30.0 / mathlib v4.30.0.
- **Source transcriptions:** draft MD generated for all four PDFs under `sources/`;
  human verification in progress (see `sources/README.md`).
- Lean formalization: paused until transcriptions are verified page-by-page.

## License

Apache License 2.0 (see `LICENSE` and `NOTICE`).

## Contributions and Collaboration

This repository functions strictly as a unilateral broadcast of public code for educational and research purposes.

* **Pull Requests and Issues:** This project does not accept external Pull Requests, code contributions, or modifications, and tracking features have been disabled. Any external collaboration vectors are closed.
* **Forks:** Users are entirely free and encouraged to fork or clone this repository to modify the code on their own profiles in accordance with the repository's Apache 2.0 License.

## Regulatory and Liability Disclaimer

* **Limitations:** The code provided herein is for theoretical research and academic simulation purposes only.
* **Liability Protection:** In accordance with Section 8 of the Apache 2.0 License, this software is provided "AS IS" without warranties of any kind. Catskills Research Company disclaims all liability for any direct, indirect, or consequential damages resulting from the use, misuse, or deployment of this simulation code.

