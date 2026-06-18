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
