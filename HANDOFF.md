# Handoff — Part II, Scott 1981 (PRG-19): Lecture II (Approximable mappings)

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Lecture I is COMPLETE: 43 Pass** (`lake build Domain` green, zero `sorry`s). Def 1.1 → Exercise
1.27 are all formalized. This session **opens Lecture II (§2): approximable mappings** — the
morphisms between neighbourhood systems, and the heart of the "domains as a category" story.

---

## What just landed (Lecture I finale, 1.23–1.27)

| Exercise | Module | Headline results | Axioms |
| -------- | ------ | ---------------- | ------ |
| **1.23** | `Exercise123.lean` | `greedyElement`, `greedyElement_isTotal` (greedy total elt in a countable `[DecidablePred V.mem]` system, via `Y_prefix_consistent`); `filters_sequence_determined` | greedy: choice-free; seq-determined: classical |
| **1.24** | `Exercise124.lean` | `chainUnion` (union of a chain of filters is a filter), `le_chainUnion`; `exists_total_ge` (Zorn ⟹ every elt extends to a total one, `IsMax = IsTotal`) | classical (AC) — expected |
| **1.25** | `Exercise125.lean` | `finalSegmentSystem` (non-empty upper sets of a well-order); `finalSegmentClassify : Element ≃o {non-empty lower sets}`; `topElement` is the unique total elt, not finite when no max | classical |
| **1.26** | `Exercise126.lean` | `ringSystem` (`IFamily F = {G ∣ F ⊆ ⟨G⟩}`); `ringIso : Element ≃o Ideal A` (via `idealOf`/`ofIdeal`) | classical |
| **1.27** | `Exercise127.lean` | `Bounded`, `sSup`/`le_sSup`/`sSup_le`; `consistent_pair_iff_bounded`; `bounded_iff_finite_bounded` (uses 1.18) | bounded/consistency: choice-free |

All five imported in `Domain.lean`; `arxiv.md` §4.2 rows + §4.4 tally updated to **43**.

---

## Your task this session: Lecture II core + exercises

Source: `sources/PRG19_vision.md` lines **563–927** (Def 2.1 through Exercise 2.22). Full inventory
in `arxiv.md §4.2.II`. **Planned root module: `Domain/Neighborhood/Approximable.lean`** (not yet
created) for the core theory; exercises can go in `Exercise2N.lean` files mirroring Lecture I.

**Recommended order** (core first — exercises depend on it):

```
Def 2.1  ApproximableMap (relation f ⊆ 𝒟₀×𝒟₁; 3 axioms)         ── new core file
Prop 2.2 toElementMap f(x)={Y∣∃X∈x, X f Y}; rel_of_map           ── elementwise action
Thm 2.5  category: identity I_D, composition g∘f, associativity   ── the category structure
Prop 2.6 I_D(x)=x, (g∘f)(x)=g(f(x))                               ── elementwise functoriality
Thm 2.7  every domain iso |𝒟₀|≅|𝒟₁| comes from an approximable map ── ties back to Def 1.9
then exercises 2.8–2.22 (2.9 elementwise ⋃-formula, 2.11/2.12 directed ⋃, 2.10 lub of maps, …)
```

| Order | Scott | New module | Depends on |
| ----- | ----- | ---------- | ---------- |
| 1 | **Def 2.1** | `Approximable.lean` | `NeighborhoodSystem`, `Element` (`Basic.lean`) |
| 2 | **Prop 2.2** | `Approximable.lean` | Def 2.1, `principal`, `Element.mem_*` |
| 3 | **Thm 2.5 / Prop 2.6** | `Approximable.lean` | Def 2.1, Prop 2.2 |
| 4 | **Thm 2.7** | `Approximable.lean` | `DomainIso` / `≃o` (`Basic.lean`, Def 1.9), Thm 1.10 |
| 5 | **Ex 2.8–2.22** | `Exercise2N.lean` | the above; `iUnion`/directed-⋃ (Thm 1.11) |

Add each new file to `Domain.lean`.

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build Domain`.
- **Axiom footprint:** keep *constructions* (the relation, identity, composition, `toElementMap`)
  and *structural* lemmas choice-free (`[propext, Quot.sound]`); audit with `#print axioms` in a
  scratch file, then delete it. Classical steps are OK where genuinely needed (directed-⋃ existence,
  set-theoretic exercises like 2.22) — **document** in the module docstring and `arxiv.md §4.5`.
- **Do not commit or push** unless explicitly asked.
- **Read the source first:** `sources/PRG19_vision.md` lines 563–927.
- **Update docs on completion:** mark each result **Pass** in `arxiv.md §4.2.II`; add §4.5 proof
  notes; refresh the §4.4 tally; rewrite this file for the next block.

---

## Lecture II deliverables (core)

### Def 2.1 — approximable mapping (vision 563–569)

**Scott:** an *approximable mapping* `f : 𝒟₀ → 𝒟₁` is a relation `f ⊆ 𝒟₀ × 𝒟₁` (write `X f Y`) with:
(i) `Δ₀ f Δ₁` (the master sets are related);
(ii) `X f Y` and `X f Y'` ⟹ `X f (Y ∩ Y')` (intersectivity on outputs);
(iii) `X' ⊆ X`, `X f Y`, `Y ⊆ Y'` ⟹ `X' f Y'` (monotone: smaller input / larger output).

**Lean target (`Approximable.lean`):**

```lean
structure ApproximableMap (V₀ : NeighborhoodSystem α) (V₁ : NeighborhoodSystem β) where
  rel : Set α → Set β → Prop
  rel_mem_left : ∀ {X Y}, rel X Y → V₀.mem X      -- only defined on 𝒟₀
  rel_mem_right : ∀ {X Y}, rel X Y → V₁.mem Y
  master_rel : rel V₀.master V₁.master            -- (i)
  inter_right : ∀ {X Y Y'}, rel X Y → rel X Y' → rel X (Y ∩ Y')   -- (ii)
  mono : ∀ {X' X Y Y'}, X' ⊆ X → rel X Y → Y ⊆ Y' → V₀.mem X' → V₁.mem Y' → rel X' Y'  -- (iii)
```

(Check the exact monotonicity packaging against vision 563–569; some statements split (iii) into
left-narrowing and right-widening.)

### Prop 2.2 — elementwise action (vision 581–605)

**Scott:** for an approximable `f` and a filter `x ∈ |𝒟₀|`, define `f(x) = {Y ∣ ∃ X ∈ x, X f Y}`.
Then `f(x) ∈ |𝒟₁|`, the action is monotone in `x`, and `X f Y ⟺ Y ∈ f(↑X)` (recovers the relation
from the elementwise map). Two approximable maps are equal iff they induce the same elementwise map.

**Lean targets:** `toElementMap f x : V₁.Element` (prove the four filter axioms — `inter_mem` uses
(ii) + `x`'s directedness, `up_mem` uses (iii)); `toElementMap_mono`; `rel_of_map`
(`X f Y ↔ (toElementMap f (principal hX)).mem Y`); `ApproximableMap.ext` (extensionality via the
elementwise map).

### Theorem 2.5 / Prop 2.6 — the category (vision 677–732)

`idMap : ApproximableMap V V` with `rel X Y ↔ X ⊆ Y` (check `V.mem` side conditions); `comp g f`
with `rel X Z ↔ ∃ Y, rel f X Y ∧ rel g Y Z`; `comp_assoc`, `id_comp`, `comp_id`. Prop 2.6:
`toElementMap idMap x = x` and `toElementMap (comp g f) x = toElementMap g (toElementMap f x)`.

### Theorem 2.7 — isos come from approximable maps (vision 738–760)

Every `DomainIso V₀ V₁` (`≃o`, Def 1.9) is induced by an approximable map, and finite elements map
to finite elements. Reuse `bracket` / `tokenIso` machinery from `Theorem110.lean`.

---

## Exercises 2.8–2.22 (after the core)

Highlights (full list in `arxiv.md §4.2.II`):

- **2.9** `f(x) = ⋃ {f(↑X) ∣ X ∈ x}` — Scott's elementwise-as-union-over-finite-approximants formula.
- **2.11 / 2.12** directed `⋃`: directed family of elements / of approximable maps has a filter / an
  approximable map as its union (reuse `iUnion` / `Monotone` from `Theorem111.lean`; directedness ≈
  the chain-union pattern from **1.24** `chainUnion`).
- **2.10** lub of two maps `f ⊔ g` (pointwise), via 2.11/2.12.
- **2.8** approximable map determined by its action on finite elements (`principal`).
- **2.13 / 2.15** (topologists) approximable = continuous between the Ex 1.22 topologies.
- **2.19** multivariate `f : D₀ × D₁ → D₂` as a ternary relation.
- **2.22** (set theorists) families closed under `⋂` + directed `⋃` are inclusion-iso to a domain.
- **2.3 / 2.4 / 2.16 / 2.17 / 2.18** concrete maps on `B` (binary tree) and `T` (two-token domain).

---

## What is already in the codebase (reusable for Lecture II)

| Need | Where |
| ---- | ----- |
| `NeighborhoodSystem`, `Element` (filter axioms), `principal`, `principal_le_iff`, `IsTotal`, `bot` | `Basic.lean` |
| `Element.mem_interUpTo`, `mem_interUpTo_iff`, `Consistent`, `consistent_iff_interUpTo_mem` | `Basic.lean` |
| `DomainIso`, `Isomorphic`, `≅ᴰ`, `≃o` reflects `⊑` (`map_rel_iff`) | `Basic.lean` |
| `IsPositive`, `ofPositive`; `ofNestedOrDisjoint` builder | `Basic.lean` |
| `bracket`, `tokenSystem`, `toToken`/`ofToken`, `tokenIso`; `bracket_inter`, `bracket_subset_iff` | `Theorem110.lean` |
| `iInter` / `iUnion` (countable ⋂, ascending ⋃) + GLB/LUB lemmas — **for directed ⋃ in 2.11/2.12** | `Theorem111.lean` |
| `FinitelyConsistent`, `sInf`, `leastFilter`, `appendSeq` | `Exercise118.lean` |
| `Bounded`, `sSup`, `consistent_pair_iff_bounded` — **lub of elements, for 2.10** | `Exercise127.lean` |
| `chainUnion`, `le_chainUnion`, `exists_total_ge` — **chain/directed ⋃ pattern, for 2.11** | `Exercise124.lean` |
| `IsComplete`, `tokenSystem_complete` | `Exercise121.lean` |

**Not yet defined:** `ApproximableMap`, `toElementMap`, `idMap`, `comp`, the category laws, anything
in §2.

---

## Workflow

1. Read `sources/PRG19_vision.md` lines 563–927 (especially 563–760 for the core).
2. Create `Domain/Neighborhood/Approximable.lean`: `ApproximableMap` (Def 2.1) → `toElementMap`
   (Prop 2.2) → `idMap`/`comp`/laws (Thm 2.5, Prop 2.6) → Thm 2.7.
3. Add exercises in `Exercise2N.lean` files (start with 2.9, 2.11, 2.12 — they unlock 2.8/2.10).
4. Add every new file to `Domain.lean`; keep `lake build Domain` green after each.
5. `#print axioms` scratch audit (constructions choice-free; directed-⋃/set-theory classical OK) →
   delete scratch.
6. Update `arxiv.md` §4.2.II rows to **Pass**, refresh §4.4 tally and §4.5 notes.
7. Rewrite this `HANDOFF.md` for the next block (remaining Lecture II exercises, or Lecture III §3 —
   products/sums/function spaces, `arxiv.md §4.2.III`).

---

## Key reference files

| File | Role |
| ---- | ---- |
| `sources/PRG19_vision.md` | **Primary source** — Def 2.1 at 563, Prop 2.2 at 581, Thm 2.5 at 677, Thm 2.7 at 738, exercises 764–927 |
| `Domain/Neighborhood/Basic.lean` | `Element`, `principal`, `DomainIso`/`≃o`, `Consistent` — the substrate for `ApproximableMap` |
| `Domain/Neighborhood/Theorem110.lean` | `bracket`/`tokenIso` — reuse for Thm 2.7 (isos ↔ approximable maps) |
| `Domain/Neighborhood/Theorem111.lean` | `iUnion` / directed-⋃ lemmas — for 2.11/2.12 |
| `Domain/Neighborhood/Exercise124.lean` | `chainUnion` — the directed-union-of-filters template |
| `Domain/Neighborhood/Exercise127.lean` | `sSup` / lub of elements — for 2.10 (lub of maps) |
| `Domain.lean` | Add `Approximable` + `Exercise2N` imports |
| `arxiv.md` | Goal List §4.2.II (Lecture II) — all rows currently **Not Yet** (lines ~1207–1228) |
