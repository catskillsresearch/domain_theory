# Handoff — Part II, Scott 1981 (PRG-19): Example 1.4

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19, "the blue pamphlet") in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Part I (Scott 1972, *Continuous Lattices*) is complete: 38 Pass · 0 Stuck · 0 Not Yet.**

**Part II is live.** The §1 Goal List in `arxiv.md §4` tracks a *biblical*, line-by-line parse of
PRG-19 Lecture I: Definitions, Theorems, **Factoids** (unnamed prose assertions), **Examples**, and
**Exercises** are all first-class deliverables. **Proof notes** in `arxiv.md §4.5` are part of the
monograph deliverable — update them as each result lands.

**Your task this session:** formalize **Example 1.4** (Scott's binary-tree neighbourhood system).
Follow the pattern established in `Domain/Neighborhood/Example12.lean` and
`Domain/Neighborhood/Example13.lean`.

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** the §1 *core* in `Basic.lean` stays **constructive** (`[propext, Quot.sound]`
  only). Concrete finite **examples** may use `Mathlib.Tactic` (`fin_cases`/`simp`) and therefore
  audit to classical `[propext, Classical.choice, Quot.sound]` — document this honestly in the
  example's module docstring and in `arxiv.md §4.5` proof notes.
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** one new file `Domain/Neighborhood/Example14.lean` + one import line in
  `Domain.lean`. Reuse `Basic.lean`; do **not** refactor Examples 1.2/1.3 into a shared helper
  module unless duplication becomes painful *and* you have budget.
- **Read the source first:** `sources/PRG19_vision.md` lines 172–193 (vision OCR — verify against
  the prose; OCR is ongoing). Do **not** rely on the older `sources/PRG19.md` pdftotext draft for
  this page.
- **Update docs on completion:** mark Example 1.4 **Pass** in `arxiv.md §4.2`, refresh the §4.3
  dependency graph and §4.4 status tally, and **add a proof note** in §4.5. Rewrite this
  `HANDOFF.md` for the next item (Factoid 1.4a, Example 1.5, or whatever the user directs).

---

## Current status (Part II §1)

| Block | Status |
| ----- | ------ |
| Vision / OCR | Partial — through **Def 1.9** (`sources/PRG19_vision.md`, 686 lines and growing) |
| Lean modules | `Domain/Neighborhood/Basic.lean`, `Example12.lean`, `Example13.lean` |
| Report card | **8 Pass** · rest queued (see `arxiv.md §4.2`) |

**Already Pass:**

| Scott | Lean |
| ----- | ---- |
| Def 1.1 | `NeighborhoodSystem` |
| Factoids 1.1a, 1.1b | `interUpTo`, `interUpTo_zero`, `interUpTo_succ` |
| Theorem 1.1c | `interUpTo_mem`, `consistent_iff_interUpTo_mem`, `Consistent`, `interUpTo_subset` |
| Def 1.6 | `Element`, `Element.ext` |
| Def 1.8 (order) | `instance : PartialOrder Element` (choice-free) |
| Example 1.2 | `Example12.neighborhoodSystem`, `element_classification`, `bot_is_unique_partial`, … |
| Example 1.3 | `Example13.neighborhoodSystem`, `element_classification`, `bot_lt_elemTwelve`, `elemTwelve_lt_elemTwo`, `elemTwo_maximal` |

`lake build Domain` is green today.

---

## The mathematics — Example 1.4 (vision OCR cleaned)

Scott (lines 172–193):

> Let `Δ = {Λ, 0, 1, 00, 01, 10, 11}` and let
> `𝒟 = {Δ, {0,00,01}, {1,10,11}, {00}, {01}, {10}, {11}}`.

Tokens are finite binary sequences (length ≤ 2) with `Λ` the empty sequence; they form a **binary
tree**. Neighbourhoods are **subtrees** rooted at nodes (all nodes at or below a given node).

```
                    Λ  (= Δ)
                   / \
                  0   1
                / |   | \
              00 01  10 11   ← total elements (leaves)
```

Scott's commentary (informal deliverables):

1. **First branching example.** Unlike 1.3's unique direction, approximation here involves
   **choice** — at the partial element `{Δ, left-subtree, right-subtree}` one can refine toward
   `00`, `01`, `10`, or `11`.
2. **Total elements** correspond to the four leaves `00`, `01`, `10`, `11`.
3. **Partial elements** correspond to non-leaf nodes: `Λ` (bottom), `0`, `1`, and the fork above
   the leaves.
4. **Nested-or-disjoint** (Factoid 1.4a preview): any two neighbourhoods are nested or disjoint —
   the intersection table has no inconsistent pairs.

### Expected domain elements (filters)

There are **seven** filters, with a fork at the second level:

| Element | Role | Approximation |
| ------- | ---- | ------------- |
| `bot` | bottom (`Λ` only) | least partial |
| `elemZero` | partial (`0`-branch decided) | below `00`/`01` fork |
| `elemOne` | partial (`1`-branch decided) | below `10`/`11` fork |
| `elemZeroZero` | **total** (leaf `00`) | maximal |
| `elemZeroOne` | **total** (leaf `01`) | maximal |
| `elemOneZero` | **total** (leaf `10`) | maximal |
| `elemOneOne` | **total** (leaf `11`) | maximal |

Partial-order shape: `bot` is below both `elemZero` and `elemOne`; each partial is below its two
leaf totals; leaves are incomparable with each other.

### Filter classification sketch

Any filter `x` must contain `Δ`. Case on the **minimal** non-master neighbourhood contained in `x`
(following the 1.2/1.3 pattern):

- If a leaf neighbourhood (e.g. `{00}`) is in `x`, upward closure pins down the branch and `x` is
  the corresponding total filter.
- Else if `{0,00,01}` ∈ `x` but no leaf yet, `x = elemZero` (symmetric for the `1`-branch).
- Else `x = bot`.

---

## Goal (recommended Lean shape)

New file `Domain/Neighborhood/Example14.lean`, namespace `Domain.Neighborhood.Example14`.

**Token type:** seven tokens — e.g. an inductive `Token` with constructors `lam`, `zero`, `one`,
`zeroZero`, `zeroOne`, `oneZero`, `oneOne`, or a finite enumeration with named defs.

**Neighbourhoods** (seven sets over `Token`):

- `master` = all tokens (`Δ`)
- `left` = `{0, 00, 01}` (Scott's `{0,00,01}`)
- `right` = `{1, 10, 11}`
- `leaf00`, `leaf01`, `leaf10`, `leaf11` = singletons

```lean
def neighborhoodSystem : NeighborhoodSystem Token := ...

namespace neighborhoodSystem
  def bot : neighborhoodSystem.Element := ...
  def elemZero / elemOne / elemZeroZero / ... := ...

  theorem element_classification (x) :
      x = bot ∨ x = elemZero ∨ x = elemOne ∨ ... := ...

  -- order: bot below branches; branches below their leaves; leaves maximal
end
```

### Report-card target for this session (all **Pass**, sorry-free)

| # | Scott | Lean target | Notes |
| - | ----- | ----------- | ----- |
| 1 | Example 1.4 (system) | `Example14.neighborhoodSystem` | Def 1.1; `mem_iff`; `inter_eq` + `inter_mem` |
| 2 | Example 1.4 (elements) | `bot`, branch partials, four leaf totals | explicit filter witnesses |
| 3 | Example 1.4 (classification) | `element_classification` | exactly seven filters |
| 4 | Example 1.4 (order) | strict-order lemmas + leaf maximality | fork; four total elements |

**Stretch:** a named lemma that incompatible branches cannot coexist in one filter (the fork
property). Leave **Factoid 1.4a** and **Exercise 1.1** as separate goals unless the user directs
otherwise.

---

## Template: copy from Examples 1.2 / 1.3

| Prior example | Example 1.4 analogue |
| ------------- | ------------------ |
| 3 tokens / 3 neighbourhoods | 7 tokens / 7 neighbourhoods |
| Linear chain (`inter_eq` 3 outcomes) | Tree fork (`inter_eq` — nested or `∅`; 49 cases but many symmetric) |
| 3 filters | 7 filters |
| `bot_is_unique_partial` / linear maximality | fork + four maximal leaves |

Import: `import Domain.Neighborhood.Basic` and `import Mathlib.Tactic`.

Add to `Domain.lean` after the Example13 import:

```lean
import Domain.Neighborhood.Example14
```

---

## Pitfalls

1. **Token `Λ`.** Scott writes `Λ` for the empty sequence; pick a readable Lean name (`lam`, `eps`,
   `empty`) and document the mapping in the module docstring.
2. **Neighbourhood names.** Scott's `{0,00,01}` is the left subtree — name it `left` (not `zero`)
   to avoid confusion with the token `0`.
3. **`inter_eq` scale.** Seven neighbourhoods ⇒ 49 pairwise cases; all intersections are nested
   (yield a neighbourhood) or empty. Group by symmetry; no inconsistent witness can arise.
4. **Classification.** A filter cannot contain both `{00}` and `{01}` (intersection `∅`); use this
   in the case split as in 1.2's `{0}` vs `{1}` argument.
5. **Proof notes are a deliverable.** Contrast 1.2 (fork at bottom), 1.3 (chain), 1.4 (tree with
   choice) in `arxiv.md §4.5`.

---

## Workflow

1. Reread `sources/PRG19_vision.md` lines 172–193; skim Example 1.2/1.3 Lean for the pattern.
2. Create `Domain/Neighborhood/Example14.lean`; add import to `Domain.lean`.
3. Implement deliverables 1–4 above, sorry-free.
4. `lake build Domain` (green); `#print axioms` on the example deliverables via a scratch file; delete
   scratch file.
5. Update `arxiv.md`: Example 1.4 → **Pass**, §4.3 graph (add `E14` node), §4.4 tally (**9 Pass**),
   new §4.5 proof note. Rewrite this `HANDOFF.md` for the next item.

---

## What comes after Example 1.4 (context, not this session)

| Next item | Notes |
| --------- | ----- |
| **Factoid 1.4a** | nested-or-disjoint ⟹ neighbourhood system (covers 1.2–1.4) |
| **Example 1.5** | all non-empty subsets of a 4-element set |
| **Def 1.7 / Factoids 1.7a–1.7b** | principal filters `↑X` |
| **Def 1.8 (⊥)** | abstract `bot` in `Basic.lean` |
| **Exercise 1.1** | generalize Example 1.3 (forward ref at line 281) |
| **Example 1.B** | binary sequences `B = {σΣ* ∣ σ∈Σ*}` |

---

## Key reference files

| File | Role |
| ---- | ------ |
| `sources/PRG19_vision.md` | **primary source** (lines 172–193) |
| `Domain/Neighborhood/Basic.lean` | `NeighborhoodSystem`, `Element`, `Element.ext`, `PartialOrder` |
| `Domain/Neighborhood/Example12.lean` | fork template (two totals) |
| `Domain/Neighborhood/Example13.lean` | chain template (linear order) |
| `Domain/Neighborhood/Example14.lean` | **new next session** |
| `Domain.lean` | module index |
| `arxiv.md` | Goal List (§4.2), dependency graph (§4.3), status (§4.4), proof notes (§4.5) |

The Part I → Part II gate is **open** — all prerequisites green.
