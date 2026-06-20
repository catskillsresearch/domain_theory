# Handoff — Part II, Scott 1981 (PRG-19): Exercises 1.23–1.27 (finishing Lecture I)

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Part I (Scott 1972) is complete: 38 Pass.** **Part II Lecture I is at 38 Pass** (`lake build Domain`
green). The infrastructure you need is now all in place:

- **`IsPositive` / `ofPositive`** (Ex 1.19, in `Basic.lean`),
- **`FinitelyConsistent`, `sInf`, `leastFilter`, `appendSeq` / `interUpTo_appendSeq`** (Ex 1.18,
  `Exercise118.lean`) — **directly reused by Ex 1.27**,
- **`Element.mem_interUpTo` / `mem_interUpTo_iff`** (`Basic.lean`),
- **`tokenSystem` positive + complete**, `IsComplete` (Ex 1.21, `Exercise121.lean`),
- power system + iso (Ex 1.20), cofinite system ≅ 𝒫(ℕ) (Ex 1.16), rational intervals (Ex 1.17).

**Your task this session:** formalize **Exercises 1.23 through 1.27** — the last five exercises of
Lecture I (`arxiv.md §4.2`, currently the only remaining **Not Yet** rows of Part I Lecture I).
Recommended order below — **1.27 first** (pure order theory on `|𝒟|`, reuses 1.18 directly), then
**1.23** (greedy total element, countable + decidable), then the three "for X-ists" exercises
**1.25** (ordinals/final segments), **1.26** (ideals of a ring), **1.24** (AC ⟹ total extension).

Target: **38 → 43 Pass**. Update `arxiv.md` (§4.2 rows, §4.3 graph, §4.4 tally, §4.5 notes) and
rewrite this file when done.

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build Domain`.
- **Axiom footprint:** keep *constructions* and *structural* lemmas choice-free
  (`[propext, Quot.sound]`); audit with `#print axioms` in a scratch file, then delete it.
  Classical steps are OK where genuinely needed (1.24 *is* AC; 1.23 uses `Classical`/`Nat.rec` on a
  decidable predicate; ordinal/ring classification may be classical) — **document** in the module
  docstring and `arxiv.md §4.5`. NB: concrete finite systems already pull `Classical.choice` through
  `simp`/`fin_cases` (so does Example 1.2) — that is acceptable and pre-existing.
- **Do not commit or push** unless explicitly asked.
- **Read the source first:** `sources/PRG19_vision.md` lines 509–547 (Exercises 1.23–1.27).
- **Update docs on completion:** mark each exercise **Pass** in `arxiv.md §4.2`; add §4.5 proof notes;
  refresh §4.3 dependency graph and §4.4 tally (**43**).

---

## Recommended order and dependencies

```
1.27 (bounded sets, ⊔X = lub, consistency ⟺ boundedness) ── reuses 1.18 (FinitelyConsistent, sInf)
1.23 (countable + decidable consistency ⟹ greedy Yₙ total) ── reuses Consistent / interUpTo
1.25 (Δ = ordinal, final segments) ── new system, classify |𝒟|
1.26 (commutative ring, ideals) ── new system, iso to ideals under ⊆
1.24 (AC ⟹ partial extends to total; union of chain of filters is a filter) ── set theory / Zorn
```

| Order | Exercise | New module | Depends on |
| ----- | -------- | ---------- | ---------- |
| 1 | **1.27** | `Exercise127.lean` | `sInf`, `FinitelyConsistent` (1.18), `principal` |
| 2 | **1.23** | `Exercise123.lean` | `Consistent`, `consistent_iff_interUpTo_mem`, `IsTotal` |
| 3 | **1.25** | `Exercise125.lean` | Def 1.1, `IsTotal`, ordinals (`Mathlib.SetTheory.Ordinal`) |
| 4 | **1.26** | `Exercise126.lean` | Def 1.9, ring/ideal API (`Mathlib.RingTheory.Ideal`) |
| 5 | **1.24** | `Exercise124.lean` | Zorn's lemma (`Mathlib.Order.Zorn`), `Element` |

Add each new file to `Domain.lean`.

---

## Exercise-by-exercise deliverables

### Exercise 1.27 — bounded sets and least upper bounds (vision lines 541–547)

**Scott:** `X ⊆ |𝒟|` is *bounded* iff `∃ y, ∀ x ∈ X, x ⊑ y`. Define `⊔X = ⋂{y ∣ x ⊑ y all x∈X}`.
(1) Bounded ⟹ `⊔X` is the least upper bound. (2) For `U,V ∈ 𝒟`: `{U,V}` consistent ⟺ `{↑U,↑V}`
bounded. (3) **Using 1.18:** `X` bounded ⟺ every finite subset of `X` is bounded.

**Lean targets (`Exercise127.lean`):**

| Target | Content |
| ------ | ------- |
| `Bounded (X : Set V.Element) : Prop` | `∃ y, ∀ x ∈ X, x ≤ y` |
| `sSup (X) (h : Bounded X) : V.Element` | `sInf {y ∣ ∀ x∈X, x≤y}` — the upper-bound family is non-empty (it has `y`), so reuse **`sInf`** from 1.18 |
| `le_sSup` / `sSup_le` | `⊔X` is the lub: `x∈X → x ≤ ⊔X`; and `(∀x∈X, x≤z) → ⊔X ≤ z` (both via `sInf_le`/`le_sInf`) |
| `consistent_pair_iff_bounded` | `{U,V}` (i.e. `Consistent ![U,V] 2`) consistent ⟺ `Bounded {principal hU, principal hV}` — relate via `principal_le_iff` and `consistent_iff_interUpTo_mem` |
| `bounded_iff_finite_bounded` | `Bounded X ⟺ ∀ finite S ⊆ X, Bounded S` — dual of `FinitelyConsistent`; `←` is the content (build a bound from finite bounds + `leastFilter`) |

**Pitfall:** `sSup` should be defined as `sInf` of the (non-empty, because bounded) set of upper
bounds — this *immediately* gives the lub laws from `sInf_le`/`le_sInf`. The hard direction of
`bounded_iff_finite_bounded` is the analogue of Scott's "consistency is finitary"; mirror the
`leastFilter` argument from 1.18.

---

### Exercise 1.23 — greedy total element in a countable, decidable system (vision lines 509–525)

**Scott:** `𝒟 = {X₀,X₁,…}` countable; consistency of finite sequences **decidable**. Define
`Y₀ = X₀`; `Y_{n+1} = X_{n+1}` if consistent with `Y₀…Yₙ`, else `Yₙ`. Show `{Yₙ}` is a **total**
element. *Hint:* first show `Y₀,…,Y_{n-1}` is consistent for all `n`. Also: all filters are
sequence-determined.

**Lean targets (`Exercise123.lean`):**

| Target | Content |
| ------ | ------- |
| Hypotheses | `(V : NeighborhoodSystem α)`, `(enum : ℕ → Set α)`, `(henum : ∀ n, V.mem (enum n))`, surjectivity onto `𝒟`, and `[DecidablePred (fun s => …consistent…)]` (or a decidable consistency predicate) |
| `Y : ℕ → Set α` | The greedy sequence by strong recursion: `Y (n+1) = if Consistent (extend Y with enum (n+1)) then enum (n+1) else Y n` |
| `Y_prefix_consistent` | `∀ n, Consistent (the prefix Y₀…Y_{n-1}) n` (the hint — by induction) |
| `greedyElement : V.Element` | `{X ∣ ∃ n, interUpTo Y n ⊆ X ∧ V.mem X}` (the filter generated by all `Yₙ`); reuse the `leastFilter`-style construction or `iUnion` of principals |
| `greedyElement_isTotal` | Maximality: any consistent `Xₖ` is eventually included, so `greedyElement` admits no proper extension |
| `filters_sequence_determined` | Every filter equals the greedy element of *some* enumeration of its members (Scott's last clause) |

**Pitfall:** Encode "consistency is decidable" as `DecidablePred` over finite prefixes so the `if` in
`Y` is legitimate and the construction stays as choice-free as possible (classical only where the
enumeration/surjectivity forces it). The "consistent with `Y₀…Yₙ`" check is
`Consistent (Fin.snoc … ) (n+2)` or an `interUpTo`-membership test.

---

### Exercise 1.25 — final segments of an ordinal (vision line 531)

**Scott:** `Δ` a well-ordered set (ordinal). `𝒟 =` non-empty *final* segments of `Δ`. Describe
`|𝒟|`. Are all elements finite? Is every approximation to a finite element finite?

**Lean targets (`Exercise125.lean`):**

| Target | Content |
| ------ | ------- |
| `finalSegment` / `finalSegMem (X : Set Δ) : Prop` | `X` non-empty and upward-closed (`a ∈ X → a ≤ b → b ∈ X`); for `Δ` linearly ordered these are `Ici a` ∪ `univ` |
| `finalSegmentSystem : NeighborhoodSystem Δ` | Final segments are closed under (non-empty) `∩` — intersection of two `Ici` is the larger `Ici`; **nested**, so consider `ofNestedOrDisjoint` |
| `finalSegmentElement_classify` | Filters ↔ "cuts": describe `|𝒟|` (likely ≅ `Δ ∪ {⊤}` / the Dedekind-style completion). Use a concrete small ordinal (`ω·3`, or just a `LinearOrder`) if the general case is heavy |
| `finalSegment_total_*` | Which elements are total / finite (answer Scott's two prose questions) |

**Pitfall:** Start with a general `LinearOrder Δ` (final segments = up-sets); you may not need full
ordinal machinery. `Set.Ici a ∩ Set.Ici b = Set.Ici (max a b)` keeps `inter_mem` nested-or-disjoint.
Classification may be classical.

---

### Exercise 1.26 — ideals of a commutative ring (vision lines 533–539)

**Scott:** `A` commutative ring with unit. `Δ =` finite subsets `F ⊆ A`. `I(F) = {G ∈ Δ ∣ F ⊆ ⟨G⟩}`
(ideal generated by `G`). Show `{I(F)}` is a neighbourhood system and `|𝒟| ≅` (ideals of `A`, `⊆`).

**Lean targets (`Exercise126.lean`):**

| Target | Content |
| ------ | ------- |
| `IFamily (F : Finset A) : Set (Finset A)` | `{G ∣ (F : Set A) ⊆ Ideal.span (G : Set A)}` |
| `ringSystem : NeighborhoodSystem (Finset A)` | master `I(∅)` or `I({0})` = everything; `inter_mem` via `Ideal.span` monotonicity |
| `idealOf (x : ringSystem.Element) : Ideal A` | `Ideal.span (⋃ {F ∣ I(F) ∈ x})` or `{a ∣ I({a}) ∈ x}` |
| `ringIso : ringSystem.Element ≃o Ideal A` | Order iso to `(Ideal A, ⊆)`; inverse sends ideal `J` to `{F ∣ ↑F ⊆ J}` |
| (optional) | "exclude `F` with `I(F)=I({1})`" remark — removes the top/improper ideal |

**Pitfall:** Use `Ideal.span`, `Ideal.span_le`, `Submodule.mem_span` from mathlib. The token order is
**reverse**: bigger `F` ⟹ smaller `I(F)`. Heavy in ring API; budget accordingly or restrict to a
concrete ring if needed.

---

### Exercise 1.24 — AC ⟹ partial extends to total (vision lines 527–529)

**Scott:** Using AC, every partial element extends to a total element. Is this equivalent to AC?
*Hint:* the union of every (transfinite) chain of filters is again a filter.

**Lean targets (`Exercise124.lean`):**

| Target | Content |
| ------ | ------- |
| `sUnion_chain_isElement` | The union of a **chain** (`IsChain (·≤·)`) of filters is a filter — the key lemma (`mem` = `∃ x∈chain, x.mem`); `inter_mem` uses chain-directedness to find one filter containing both |
| `exists_total_ge (x : V.Element) : ∃ t, IsTotal t ∧ x ≤ t` | Zorn's lemma (`zorn_le` / `zorn_subset`) on `{y ∣ x ≤ y}`; maximal element is total (`IsTotal`) |
| (discussion) | Equivalence-to-AC is prose; do **not** attempt the reversal formally unless easy |

**Pitfall:** This is the explicitly **classical / AC** exercise — `Classical.choice` is expected and
correct here. Use `zorn_le_nonempty` or `zorn_subset`; the chain-union lemma is the real work.

---

## Report-card targets (this session)

| Scott | Lean module | Key defs / thms | Pass when |
| ----- | ----------- | --------------- | --------- |
| **Ex 1.27** | `Exercise127.lean` | `Bounded`, `sSup`/`le_sSup`/`sSup_le`, `consistent_pair_iff_bounded`, `bounded_iff_finite_bounded` | all compile, audited |
| **Ex 1.23** | `Exercise123.lean` | greedy `Y`, `Y_prefix_consistent`, `greedyElement`, `greedyElement_isTotal` | all compile |
| **Ex 1.25** | `Exercise125.lean` | `finalSegmentSystem`, classification + total/finite answers | all compile |
| **Ex 1.26** | `Exercise126.lean` | `ringSystem`, `ringIso` to `(Ideal A, ⊆)` | all compile |
| **Ex 1.24** | `Exercise124.lean` | `sUnion_chain_isElement`, `exists_total_ge` (Zorn) | all compile |

Marking all five takes Lecture I **38 → 43 Pass**, completing Lecture I's exercise block (1.12–1.27,
plus 1.22).

---

## Workflow

1. Read `sources/PRG19_vision.md` lines 509–547.
2. **1.27:** `Exercise127.lean` — `Bounded`, `sSup := sInf (upper bounds)`, lub laws, finitary
   boundedness (reuse 1.18 `sInf` / `FinitelyConsistent`).
3. **1.23:** `Exercise123.lean` — greedy sequence via `Nat.rec` on a `DecidablePred` consistency test.
4. **1.25:** `Exercise125.lean` — final-segment system (nested-or-disjoint), classify `|𝒟|`.
5. **1.26:** `Exercise126.lean` — ideal system, `ringIso` to `(Ideal A, ⊆)`.
6. **1.24:** `Exercise124.lean` — Zorn + chain-union-of-filters lemma.
7. `lake build Domain` (green); `#print axioms` scratch audit → delete scratch.
8. Update `arxiv.md` (§4.2 rows 1.23–1.27, §4.3 nodes `E123`–`E127`, §4.4 tally **43**, §4.5 notes).
9. Rewrite this `HANDOFF.md` for **Lecture II** (Approximable maps: Def 2.1, Prop 2.2, … — the
   `arxiv.md` Lecture II inventory begins at the §4.2 "Part II Lecture II" table).

---

## What is already in the codebase (new this round in **bold**)

| Need | Where |
| ---- | ----- |
| `NeighborhoodSystem`, `Element`, `Consistent`, `interUpTo`, `consistent_iff_interUpTo_mem` | `Basic.lean` |
| `principal`, `principal_le_iff`, `principal_injective`; `IsTotal`, `bot`, `OrderBot` | `Basic.lean` |
| **`IsPositive`, `ofPositive`, `ofPositive_isPositive`** | `Basic.lean` |
| **`Element.mem_interUpTo`, `Element.mem_interUpTo_iff`** | `Basic.lean` |
| `DomainIso`, `Isomorphic`, `≅ᴰ` | `Basic.lean` |
| `bracket`, `tokenSystem`, `toToken`, `ofToken`, `tokenIso`; `bracket_inter`, `bracket_subset_iff` | `Theorem110.lean` |
| `iInter`, `iUnion`, GLB/LUB lemmas | `Theorem111.lean` |
| **`FinitelyConsistent`, `sInf`, `sInf_le`, `le_sInf`, `leastFilter`, `subset_leastFilter`, `leastFilter_le`** | `Exercise118.lean` |
| **`appendSeq`, `interUpTo_appendSeq`, `interUpTo_subset_master`** | `Exercise118.lean` |
| **`IsComplete`, `tokenSystem_isPositive`, `tokenSystem_complete`, `consistent_iff_iInter_bracket_nonempty`** | `Exercise121.lean` |
| **`upSet`, `powerSystem`, `powerIso`, `isomorphic_powerSystem`** | `Exercise120.lean` |
| **`cofiniteSystem`, `ofExcluded`, `cofiniteIso`, `mem_compl_of_finite`** | `Exercise116.lean` (`Cofinite` ns) |
| **`ratIntervalSystem`, `filterAt`, `filterAt_injective`** | `Exercise117.lean` (`RatInterval` ns) |
| Nested-or-disjoint builder (`ofNestedOrDisjoint`) | `Basic.lean` |

**Not yet defined:** `Bounded` / `sSup` for elements, greedy total element, final-segment system,
ring/ideal system, transfinite chain-union of filters.

---

## Key reference files

| File | Role |
| ---- | ---- |
| `sources/PRG19_vision.md` | **Primary source** — Ex 1.23 at 509, 1.24 at 527, 1.25 at 531, 1.26 at 533, 1.27 at 541 |
| `Domain/Neighborhood/Exercise118.lean` | **`sInf` / `FinitelyConsistent`** — the core reuse for 1.27 |
| `Domain/Neighborhood/Basic.lean` | `IsTotal`, `principal`, `ofNestedOrDisjoint`, `Consistent` |
| `Domain/Neighborhood/Exercise116.lean` | template for "system + `≃o` to a known poset" (cofinite ≅ 𝒫(ℕ)) — mirror for 1.26 (≅ ideals) |
| `Domain/Neighborhood/Exercise117.lean` | template for `filterAt` point-filters — pattern for 1.23 generated filters |
| `Domain.lean` | Add `Exercise123`–`Exercise127` imports |
| `arxiv.md` | Goal List §4.2 rows for 1.23–1.27 currently **Not Yet** (lines ~1189–1193) |

Lecture I's exercise block is otherwise complete (1.12–1.22 **Pass**). After 1.23–1.27, pivot to
**Lecture II (Approximable maps)** — Def 2.1 onward is fully inventoried in `arxiv.md §4.2`.
