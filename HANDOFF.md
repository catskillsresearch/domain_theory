# Handoff — Part II, Scott 1981 (PRG-19): Definition 1.8 (⊥, total) + Factoids 1.8a/1.8b

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19, "the blue pamphlet") in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Part I (Scott 1972, *Continuous Lattices*) is complete: 38 Pass · 0 Stuck · 0 Not Yet.**

**Part II is live.** The §1 Goal List in `arxiv.md §4` tracks a *biblical*, line-by-line parse of
PRG-19 Lecture I: Definitions, Theorems, **Factoids** (unnamed prose assertions), **Examples**, and
**Exercises** are all first-class deliverables. **Proof notes** in `arxiv.md §4.5` are part of the
monograph deliverable — update them as each result lands.

**Just landed (last sessions):**
- **Exercise 1.22** — topology on `|𝒟|` (`Exercise122.lean`): `basicOpen [X]`,
  `instTopologicalSpaceElement`, `isOpen_iff_upper_basic`, `le_iff_isOpen_imp`, `specializes_iff_le`.
- **Def 1.7 + Factoids 1.7a/1.7b** — principal filters (`Basic.lean`): `principal` (`↑X`),
  `mem_principal`, `principal_le_iff` (`↑X⊑↑Y ⟺ Y⊆X`, inclusion-reversing), `principal_injective`,
  `eq_iUnion_principal` (`x = ⋃{↑X∣X∈x}`). **All constructive `[propext, Quot.sound]`.**
- **Structure change:** `NeighborhoodSystem` gained a field `sub_master : ∀ {X}, mem X → X ⊆ master`
  (Scott's `𝒟 ⊆ 𝒫(Δ)`). `ofNestedOrDisjoint` takes it as an argument; Examples 1.2–1.5 supply
  `fun _ => Set.subset_univ _`. **This unblocks `⊥ = ↑Δ`.**

**→ 17 Pass.** `lake build Domain` is green.

**Your task this session:** formalize **Definition 1.8's `⊥` and total elements**, plus the two
Factoids around it: **1.8a** (`⊥ = {Δ} = ↑Δ` is the least element of `|𝒟|`) and **1.8b** (in a
*finite* system every explicitly given filter is principal — "Examples 1.2–1.5 revisited"). The
approximation order itself (Def 1.8's `x ⊑ y ⟺ x ⊆ y`) is **already done** (`PartialOrder Element`).

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** `⊥` and Factoid 1.8a are §1 *core* → keep **constructive**
  (`[propext, Quot.sound]`). Audit with `#print axioms` in a scratch file, then delete it.
  - **The total/maximal-element notion is the classical frontier** (Scott: maximal filters need
    Zorn/choice in general). Defining the *predicate* `IsTotal x := ∀ y, x ≤ y → y ≤ x` (maximal) is
    constructive; only *existence* of total extensions (Exercise 1.24) needs choice. Do **not** prove
    existence this session.
  - Factoid 1.8b is about *finite* systems; if it drags in `Fintype`/`Classical`, scope it to a
    clearly-labelled lemma and note the footprint (it is a "revisited" remark, not §1 core proper).
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** add to `Domain/Neighborhood/Basic.lean` (general, parametric in `α`/`V`).
- **Read the source first:** `sources/PRG19_vision.md` line 277 (Def 1.8) and 279 (Examples revisited
  = Factoid 1.8b). `⊥ = {Δ}`; total = maximal under `⊑`.
- **Update docs on completion:** mark Def 1.8 (⊥/total) / Factoids 1.8a/1.8b **Pass** in
  `arxiv.md §4.2`, refresh §4.3 graph and §4.4 tally, add §4.5 proof notes. Rewrite this
  `HANDOFF.md` for the next item (Example 1.B, or Def 1.9 isomorphism).

---

## The mathematics — Definition 1.8 (vision OCR)

Scott (line 277):

> **DEFINITION 1.8.** For `x, y ∈ |𝒟|`, we say that `x` *approximates* `y` iff `x ⊆ y`. The element
> that approximates all others, `{Δ}`, is called `⊥` (read: *bottom*); it is the "least defined"
> element… Elements maximal with respect to the approximation relation are called *total elements*.

Examples revisited (line 279, **Factoid 1.8b**):

> The examples as given were all finite, so any explicitly given filter `x` is principal, the element
> is finite, the minimal `X ∈ x` tells us all we need to know.

### Notes on the formalization

1. **`⊥ = ↑Δ` (`bot`).** Define `bot : V.Element := V.principal V.master_mem` — Scott's `{Δ}`.
   Sanity factoid: `(V.bot).mem Y ↔ Y = V.master` (forward: `bot.mem Y` gives `V.mem Y ∧ Δ ⊆ Y`, and
   `V.sub_master` gives `Y ⊆ Δ`, so `Y = Δ` by `Set.Subset.antisymm`; backward: `Y = Δ` gives
   `⟨V.master_mem, subset_rfl⟩`). So `↑Δ = {Δ}` literally, matching Scott.
2. **Factoid 1.8a (`⊥` is least).** `bot_le : ∀ x : V.Element, V.bot ≤ x`. Given `bot.mem Y` =
   `V.mem Y ∧ Δ ⊆ Y`, conclude `x.mem Y` from `x.master_mem` (`Δ ∈ x`) + `x.up_mem` along `Δ ⊆ Y`.
   Consider also giving `OrderBot V.Element` (with `bot := V.bot`, `bot_le := bot_le`) so `⊥` notation
   works — check it stays `[propext, Quot.sound]`.
3. **Total elements.** `def IsTotal (x : V.Element) : Prop := ∀ y, x ≤ y → y ≤ x` (maximal). Keep it a
   predicate; the *existence* of total elements above a given `x` is Exercise 1.24 (choice) — out of
   scope. You can sanity-check `IsTotal` against the finite examples (their maximal filters
   `elemXY_maximal` are already proved) if cheap, but it is optional.
4. **Factoid 1.8b (finite ⟹ principal).** "Every explicitly given filter is principal." The honest
   general statement needs a finiteness hypothesis (e.g. `x` has a least/`⊆`-minimal member `X` with
   `x = ↑X`). Likely cleanest: assume the filter's neighbourhood family has a minimum and show
   `x = principal`. If this balloons, scope it narrowly or defer with a note — it is a "revisited"
   remark, not a numbered result.

### Report-card target

| # | Scott | Lean target | Notes |
| - | ----- | ----------- | ----- |
| 1 | Def 1.8 `⊥` | `bot : V.Element` (`= principal master_mem`); `mem_bot` (`↑Δ = {Δ}`) | core, constructive |
| 2 | Factoid 1.8a | `bot_le` (+ optional `OrderBot Element`) | `⊥` least |
| 3 | Def 1.8 total | `IsTotal x := ∀ y, x ≤ y → y ≤ x` | predicate only; no existence |
| 4 | Factoid 1.8b | finite ⟹ principal (scoped/optional) | classical frontier OK if needed |

---

## Pitfalls

1. **`sub_master` is now available** (the previous blocker is gone): `V.sub_master hX : X ⊆ Δ`. Use it
   for `↑Δ = {Δ}`.
2. **Stay constructive for `⊥`/1.8a.** Use `Set.Subset.antisymm`, `Element.ext`, `x.up_mem`; avoid
   classical `simp`. Verify `#print axioms` ⊆ `{propext, Quot.sound}`.
3. **Don't prove maximal-element *existence*.** Only the *predicate*. Existence (Exercise 1.24) is
   explicitly choice-dependent and not this session.
4. **Order direction.** `⊥ = ↑Δ` is the *largest* principal filter (`Δ` is the largest neighbourhood),
   yet the *least* element — the information/inclusion reversal. Keep the variance straight
   (`principal_le_iff` is the lemma that pins it down).

---

## Workflow

1. Reread `sources/PRG19_vision.md` lines 277–279.
2. Add `bot`, `mem_bot`, `bot_le` (and optional `OrderBot`), `IsTotal` to `Basic.lean`.
3. Attempt Factoid 1.8b; scope or defer if it needs heavy finiteness machinery.
4. `lake build Domain` (green); `#print axioms` audit via scratch file → core `[propext, Quot.sound]`;
   delete scratch.
5. Update `arxiv.md` (§4.2 Pass rows, §4.3 graph, §4.4 tally, §4.5 notes) and rewrite this
   `HANDOFF.md` for the next item (**Example 1.B** binary sequences, lines 281–315; or **Def 1.9**
   isomorphism, lines 321–322).

---

## Current status (Part II §1)

| Block | Status |
| ----- | ------ |
| Vision / OCR | Partial — through **Def 1.9** (`sources/PRG19_vision.md`) |
| Lean modules | `Basic.lean`, `Example12.lean`, `Example13.lean`, `Example14.lean`, `Example15.lean`, `Exercise122.lean` |
| Report card | **17 Pass** · rest queued (see `arxiv.md §4.2`) |

**Already Pass:**

| Scott | Lean |
| ----- | ---- |
| Def 1.1 | `NeighborhoodSystem` (`mem`, `master`, `master_mem`, `inter_mem`, **`sub_master`**) |
| Factoids 1.1a, 1.1b | `interUpTo`, `interUpTo_zero`, `interUpTo_succ` |
| Theorem 1.1c | `interUpTo_mem`, `consistent_iff_interUpTo_mem`, `Consistent`, `interUpTo_subset` |
| **Factoid 1.4a** | `NestedOrDisjoint`, `NeighborhoodSystem.ofNestedOrDisjoint` (choice-free) |
| Def 1.6 | `Element`, `Element.ext` |
| **Factoid 1.5b** | `limitFamily`, `SeqEquiv`, `limitFamily_eq_iff` (choice-free) |
| **Def 1.7** | `principal` (`↑X`), `mem_principal` (choice-free) |
| **Factoid 1.7a** | `principal_le_iff` (`↑X⊑↑Y ⟺ Y⊆X`), `principal_injective` (choice-free) |
| **Factoid 1.7b** | `eq_iUnion_principal` (`x = ⋃{↑X∣X∈x}`, choice-free) |
| Def 1.8 (order) | `instance : PartialOrder Element` (choice-free) |
| Example 1.2 | `Example12.*` (fork, one partial / two total) |
| Example 1.3 | `Example13.*` (chain, two partial / one total) |
| Example 1.4 | `Example14.*` (binary tree, 7 filters, branching) |
| **Example 1.5 / Factoid 1.5a** | `Example15.*` (all non-empty subsets of `Fin 4`) — fully constructive |
| **Exercise 1.22** | `Exercise122.*` (topology on `|𝒟|`; `⊑` = specialization order) |

---

## What comes after (context, not this session)

| Next item | Notes |
| --------- | ----- |
| **Example 1.B** | binary sequences `B = {σΣ* ∣ σ∈Σ*}`, generalizing 1.4 (lines 281–315); incl. `B`-is-a-system exercise, `σx∈|B|` exercise, `σ₀⊥⊆σ₁⊥ ⟺ initial segment`, `x = ⋃ₙ σₙ⊥` |
| **Def 1.9** | `𝒟₀ ≅ 𝒟₁`: order-iso of `\|𝒟₀\|` and `\|𝒟₁\|` (lines 321–322) |
| **Theorem 1.10** | `[X]` element-token system (basic opens already in `Exercise122.lean`); `𝒟 ≅ {[X]}` |
| **Theorem 1.11** | closure of `\|𝒟\|` under `⋂` and ascending `⋃` |
| **Exercises 1.1, 1.21, 1.23–1.26** | statements as OCR exposes them |

---

## Key reference files

| File | Role |
| ---- | ------ |
| `sources/PRG19_vision.md` | **primary source** (Def 1.8 at line 277, Factoid 1.8b at 279) |
| `Domain/Neighborhood/Basic.lean` | core: `NeighborhoodSystem` (+`sub_master`), `Element`/`Element.ext`, `PartialOrder`, `NestedOrDisjoint`/`ofNestedOrDisjoint`, `limitFamily`/`SeqEquiv`/`limitFamily_eq_iff`, **`principal`/`principal_le_iff`/`principal_injective`/`eq_iUnion_principal`** — **add `bot`/`IsTotal` here** |
| `Domain/Neighborhood/Example12–15.lean` | the four finite worked examples (each now supplies `sub_master`) |
| `Domain/Neighborhood/Exercise122.lean` | topology on `|𝒟|` (Exercise 1.22) |
| `Domain.lean` | module index |
| `arxiv.md` | Goal List (§4.2), dependency graph (§4.3), status (§4.4), proof notes (§4.5) |

The Part I → Part II gate is **open** — all prerequisites green.
