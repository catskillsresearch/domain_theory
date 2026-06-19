# Handoff — Part II, Scott 1981 (PRG-19): Definition 1.7 + Factoids 1.7a/1.7b

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19, "the blue pamphlet") in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Part I (Scott 1972, *Continuous Lattices*) is complete: 38 Pass · 0 Stuck · 0 Not Yet.**

**Part II is live.** The §1 Goal List in `arxiv.md §4` tracks a *biblical*, line-by-line parse of
PRG-19 Lecture I: Definitions, Theorems, **Factoids** (unnamed prose assertions), **Examples**, and
**Exercises** are all first-class deliverables. **Proof notes** in `arxiv.md §4.5` are part of the
monograph deliverable — update them as each result lands.

**Your task this session:** formalize **Definition 1.7** (principal filters `↑X`) and the two
"obvious" Factoids about them, **1.7a** (the map `X ↦ ↑X` is one-one and inclusion-*reversing*) and
**1.7b** (`x = ⋃ {↑X ∣ X ∈ x}` for every element `x`). These are general **core** results → put
them in `Basic.lean` and keep them **constructive** (`[propext, Quot.sound]`).

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** Def 1.7 / Factoids 1.7a/1.7b are §1 *core* → keep **constructive**
  (`[propext, Quot.sound]`). No `fin_cases`/`decide`/classical `simp`. Audit with `#print axioms`
  in a scratch file, then delete it.
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** add to `Domain/Neighborhood/Basic.lean` (general, parametric in `α`/`V`).
- **Read the source first:** `sources/PRG19_vision.md` lines 251–269 (Def 1.7 at 251–257, Factoid
  1.7a "obvious … one-one & reversing" at 259–265, Factoid 1.7b "also obvious" at 265–269).
- **Update docs on completion:** mark Def 1.7 / Factoids 1.7a/1.7b **Pass** in `arxiv.md §4.2`,
  refresh §4.3 graph and §4.4 tally (**→ 16 Pass**), add §4.5 proof notes. Rewrite this
  `HANDOFF.md` for the next item.

---

## Current status (Part II §1)

| Block | Status |
| ----- | ------ |
| Vision / OCR | Partial — through **Def 1.9** (`sources/PRG19_vision.md`, ~880 lines and growing) |
| Lean modules | `Basic.lean`, `Example12.lean`, `Example13.lean`, `Example14.lean`, `Example15.lean` |
| Report card | **13 Pass** · rest queued (see `arxiv.md §4.2`) |

**Already Pass:**

| Scott | Lean |
| ----- | ---- |
| Def 1.1 | `NeighborhoodSystem` |
| Factoids 1.1a, 1.1b | `interUpTo`, `interUpTo_zero`, `interUpTo_succ` |
| Theorem 1.1c | `interUpTo_mem`, `consistent_iff_interUpTo_mem`, `Consistent`, `interUpTo_subset` |
| **Factoid 1.4a** | `NestedOrDisjoint`, `NeighborhoodSystem.ofNestedOrDisjoint` (choice-free) |
| Def 1.6 | `Element`, `Element.ext` |
| **Factoid 1.5b** | `limitFamily`, `SeqEquiv`, `limitFamily_eq_iff` (choice-free) |
| Def 1.8 (order) | `instance : PartialOrder Element` (choice-free) |
| Example 1.2 | `Example12.*` (fork, one partial / two total) |
| Example 1.3 | `Example13.*` (chain, two partial / one total) |
| Example 1.4 | `Example14.*` (binary tree, 7 filters, branching) |
| **Example 1.5 / Factoid 1.5a** | `Example15.neighborhoodSystem` (all non-empty subsets of `Fin 4`), `consistent_iff_inter_nonempty` — fully constructive |

`lake build Domain` is green today.

---

## The mathematics — Definition 1.7 + Factoids 1.7a/1.7b (vision OCR)

Scott (lines 251–269):

> **DEFINITION 1.7.** For `X ∈ 𝒟`, the *principal filter* determined by `X` is
> `↑X = {Y ∈ 𝒟 ∣ X ⊆ Y}`. The principal filters form the *finite elements* of `|𝒟|`.
>
> It is obvious that the correspondence between `X` and `↑X` is one-one and inclusion *reversing*:
> `X ⊆ Y  iff  ↑Y ⊆ ↑X`, for all `X, Y ∈ 𝒟`.
>
> … it is also obvious from the definitions that for each `x ∈ |𝒟|`,  `x = ⋃ {↑X ∣ X ∈ x}`.

### Notes on the formalization

1. **`↑X` is an `Element`.** For `X ∈ 𝒟`, `principal X` should be a `V.Element` with
   `mem Y := V.mem Y ∧ X ⊆ Y`. Check the four filter fields:
   - `sub`: `mem Y → V.mem Y` — first projection.
   - `master_mem`: `X ⊆ master`. **You need `X ⊆ Δ` for all neighbourhoods.** Currently `master`
     is an arbitrary field, *not* hard-wired to `Set.univ`, so `X ⊆ master` is **not** automatic.
     Add a field/hypothesis or a lemma. Cleanest: it is reasonable to require neighbourhoods be
     subsets of `Δ` — consider adding `sub_master : ∀ {X}, mem X → X ⊆ master` to
     `NeighborhoodSystem` (Scott's `𝒟 ⊆ 𝒫(Δ)`), then revisit Examples 1.2–1.5 (each `master` is
     `Set.univ`, so the new field is `fun _ => Set.subset_univ _`). **This is a structure change —
     confirm with the user before doing it**, or instead state Factoid 1.7b/1.7a with an explicit
     `X ⊆ master` hypothesis where needed and defer the structural fix.
   - `inter_mem`: from `X ⊆ Y₁`, `X ⊆ Y₂` get `X ⊆ Y₁ ∩ Y₂` (`Set.subset_inter`); `V.mem (Y₁∩Y₂)`
     via `V.inter_mem` with witness `X` (since `X ⊆ Y₁ ∩ Y₂`).
   - `up_mem`: `X ⊆ Y ⊆ Z` ⟹ `X ⊆ Z` (transitivity).
2. **Factoid 1.7a (one-one + reversing).** State as
   `principal X ≤ principal Y ↔ Y ⊆ X` (the order on `Element` is inclusion of membership
   predicates; recall `≤` here means `∀ Z, (principal X).mem Z → (principal Y).mem Z`). Injectivity
   then follows: `principal X = principal Y → X = Y` (use antisymmetry / `Element.ext` + the iff).
   Beware the **reversing** direction: `X ⊆ Y ↔ ↑Y ⊆ ↑X`.
3. **Factoid 1.7b (`x = ⋃ ↑X`).** For `x : V.Element`, every `Z ∈ x` satisfies `Z ∈ ↑Z` (`Z ⊆ Z`)
   and `Z ∈ x` is in the union; conversely if `Z ∈ ↑X` for some `X ∈ x` then `X ⊆ Z` and `X ∈ x`
   so `Z ∈ x` by `up_mem`. Phrase the union membership concretely as
   `x.mem Z ↔ ∃ X, x.mem X ∧ (principal X).mem Z` to avoid wrangling `⋃` over a `Set (Set α)`.

### Report-card target (all **Pass**, sorry-free, constructive)

| # | Scott | Lean target | Notes |
| - | ----- | ----------- | ----- |
| 1 | Def 1.7 | `principal : ∀ {X}, V.mem X → V.Element` | needs `X ⊆ master` (see pitfall) |
| 2 | Factoid 1.7a | `principal_le_iff` (`↑X ≤ ↑Y ↔ Y ⊆ X`) + `principal_injective` | inclusion-reversing |
| 3 | Factoid 1.7b | `eq_iUnion_principal` (`x.mem Z ↔ ∃ X, x.mem X ∧ X ⊆ Z`) | density of finite elements |

---

## Pitfalls

1. **`master = Set.univ` is not assumed.** The `principal` filter's `master_mem` field needs
   `X ⊆ master`. Decide up front: (a) add `sub_master` to the `NeighborhoodSystem` structure (clean,
   but touches Examples 1.2–1.5 — each supplies `fun _ => Set.subset_univ _`; **ask the user**), or
   (b) thread an `X ⊆ V.master` hypothesis through the 1.7 lemmas. Option (a) is more faithful to
   Scott (`𝒟 ⊆ 𝒫(Δ)`) and unblocks Def 1.8's `⊥ = ↑Δ`.
2. **Stay constructive.** Use `Set.subset_inter`, `Set.Subset.trans`, `Element.ext`; avoid classical
   `simp`. Verify `#print axioms` ⊆ `{propext, Quot.sound}`.
3. **Order direction.** Scott's approximation order is inclusion; `↑` is inclusion-*reversing*, so
   smaller neighbourhood ⇒ larger principal filter ⇒ more information. Keep the variance straight.

---

## Workflow

1. Reread `sources/PRG19_vision.md` lines 251–269.
2. Decide the `master`/`sub_master` question (pitfall 1) — **ask the user if structural**.
3. Add `principal`, `principal_le_iff`, `principal_injective`, `eq_iUnion_principal` to `Basic.lean`.
4. `lake build Domain` (green); `#print axioms` audit via scratch file → `[propext, Quot.sound]`;
   delete scratch.
5. Update `arxiv.md` (§4.2 Pass rows, §4.3 graph, §4.4 tally **16 Pass**, §4.5 notes) and rewrite
   this `HANDOFF.md` for the next item (Def 1.8 `⊥`/total, or Example 1.B binary sequences).

---

## What comes after (context, not this session)

| Next item | Notes |
| --------- | ----- |
| **Def 1.8 (⊥, total)** | abstract `⊥ = {Δ} = ↑Δ` least element; total = maximal filters (classical frontier) |
| **Factoids 1.8a/1.8b** | `⊥` is least; in finite systems every element is principal |
| **Example 1.B** | binary sequences `B = {σΣ* ∣ σ∈Σ*}`, generalizing 1.4 (lines 281–315) |
| **Def 1.9** | `𝒟₀ ≅ 𝒟₁`: order-iso of `\|𝒟₀\|` and `\|𝒟₁\|` |
| **Exercises 1.1, 1.21, 1.22** | statements to pin down as OCR exposes them |

---

## Key reference files

| File | Role |
| ---- | ------ |
| `sources/PRG19_vision.md` | **primary source** (lines 251–269) |
| `Domain/Neighborhood/Basic.lean` | core: `NeighborhoodSystem`, `Element`, `Element.ext`, `PartialOrder`, `NestedOrDisjoint`/`ofNestedOrDisjoint`, `limitFamily`/`SeqEquiv`/`limitFamily_eq_iff` — **add Def 1.7 here** |
| `Domain/Neighborhood/Example12.lean` | fork (two totals) |
| `Domain/Neighborhood/Example13.lean` | chain (linear) |
| `Domain/Neighborhood/Example14.lean` | binary tree (branching, 7 filters) |
| `Domain/Neighborhood/Example15.lean` | all non-empty subsets of `Fin 4` (fully constructive) |
| `Domain.lean` | module index |
| `arxiv.md` | Goal List (§4.2), dependency graph (§4.3), status (§4.4), proof notes (§4.5) |

The Part I → Part II gate is **open** — all prerequisites green.
