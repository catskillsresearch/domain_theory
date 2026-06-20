# Handoff — Part II, Scott 1981 (PRG-19): Lecture III (§3) — products, sums, function spaces

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Lecture I is COMPLETE (43 Pass).** **Lecture II is COMPLETE (22 Pass).** **The Lecture III (§3)
spine is COMPLETE (13 Pass): Def 3.1 → Theorem 3.13(i)** (`lake build Domain` green, zero `sorry`s).
Current total: **78 Pass**. **This session's remaining Lecture III work:** Theorem 3.13(ii)(iii)
(pointwise bounded sups) and Exercises 3.14–3.28 (`arxiv.md §4.2.III`).

---

## What just landed (Lecture III §3 — the cartesian-closed spine)

| Result | Module | Key Lean names |
| ------ | ------ | -------------- |
| **Def 3.1 / Prop 3.2** (product) | `Product.lean` | `prod`, `prodNbhd` (`Sum.inl '' X ∪ Sum.inr '' Y`), `prodNbhd_inter`/`_subset_iff`/`_injective` (choice-free), `pair`, `Element.fst`/`snd`, `pair_le_pair_iff`, `prodEquiv : |𝒟₀×𝒟₁|≃o|𝒟₀|×|𝒟₁|` |
| **Def 3.3 / Prop 3.4** (proj/pair) | `Product.lean` | `proj₀`/`proj₁`, `paired`, `proj_comp_paired`, `toElementMap_paired_apply` (`⟨f,g⟩(w)=⟨f(w),g(w)⟩`) |
| **Thm 3.5 / Lemma 3.6** (joint⟺separate) | `Product.lean` | `constMap`, `toElementMap_constMap`, `toMap₂`/`ofMap₂`/`map₂Equiv` (`ApproximableMap (prod V₀ V₁) V₂ ≃ ApproximableMap₂ V₀ V₁ V₂`) |
| **Prop 3.7** (substitution) | `Product.lean` | `substitution_toElementMap` |
| **Def 3.8** (function space) | `FunctionSpace.lean` | `step`/`stepFun`/`funSpace`; `step_inter_right`/`step_subset`/`step_master_eq`/`step_mem`; `mem_stepFun_iff` |
| **Prop 3.9** (least map) | `FunctionSpace.lean` | `interYs`, `leastMap` (cond. (ii)), `leastMap_mem_stepFun`, `rel_interYs`, `leastMap_le` (minimality), `stepFun_subset_step_iff` (remark after 3.9) |
| **Thm 3.10** (completeness, the crux) | `FunctionSpace.lean` | `toApproxMap`/`toFilter`, `funSpaceEquiv : |𝒟₀→𝒟₁|≃o ApproximableMap V₀ V₁` |
| **Thm 3.11** (eval) | `FunctionSpace.lean` | `eval` (`ApproximableMap₂`), `evalMap`, `evalMap_apply` (`eval(f,x)=f(x)`) |
| **Thm 3.12** (curry) | `FunctionSpace.lean` | `curry`/`uncurry`, `toElementMap_curry_apply`, `uncurry_curry`/`curry_uncurry`, `eval_comp_curry`/`curry_eval_comp`, `curryEquiv` (adjunction `≃o`) |
| **Thm 3.13(i)** (pointwise order) | `FunctionSpace.lean` | `le_iff_toElementMap_le` (`f⊑g ⟺ ∀x f(x)⊑g(x)`) |

**Axiom audit (Lecture III spine).** Every *construction* is choice-free `[propext, Quot.sound]`:
`prod`, `prodEquiv`, `proj₀`, `paired`, `map₂Equiv`, `funSpace`, `funSpaceEquiv`, `eval`, `curry`,
`curryEquiv`, `leastMap`, `interYs`. The few equational identities proved by elementwise
extensionality (`ext_of_toElementMap`) or the `X⊆Xᵢ` case split (`leastMap_le`,
`stepFun_subset_step_iff`, `eval_comp_curry`, `curry_eval_comp`) pull in `Classical.choice` — these
are documented classical *proof* steps, not constructions.

---

## What landed earlier (Lecture II — complete)

| Result | Module | Key Lean names |
| ------ | ------ | -------------- |
| Def 2.1, Prop 2.2, Thm 2.5/2.6/2.7 | `Approximable.lean` | `ApproximableMap` (`rel`/`master_rel`/`inter_right`/`mono`), `toElementMap`, `rel_iff_mem_principal`, `idMap`/`comp`/laws, `ofIso`, `exists_principal_eq_apply_principal`, `sSupDirected` |
| Ex 2.8–2.12, 2.19 | `ApproximableExercises.lean` | `ofMono`, `eq_of_toElementMap_principal`, `toElementMap_mem_iff_principal`, `interMap`, `iSupDirected`, `iSupMap`, `ApproximableMap₂`/`toElementMap₂`/`rel₂_iff_mem_principal`/`toElementMap₂_mono` |
| Ex 2.16, 2.17 | `Exercise216.lean`, `Example24.lean` | `sigmaMap`; `runMap`/`out`/`del`/`out_append`/`out_mono` |
| **Ex 2.13** (continuous = approximable) | `Exercise213.lean` | `continuous_toElementMap`, `continuous_monotone`, `mem_iff_principal_of_continuous`, `ofContinuous`, `toElementMap_ofContinuous` — **choice-free** |
| **Ex 2.14** (`φ` of an iso) | `Exercise214.lean` | `phi`/`phi_spec`, `rel_ofIso_iff`, `phi_inter` |
| **Ex 2.15** (Sierpiński/opens) | `Exercise215.lean` | one-token `O` (`Fin 1`), `topElt`/`botElt`, `openToMap`/`mapToOpen`/`openSet_equiv_map` |
| **Ex 2.18** (spacing map) | `Exercise218.lean` | `hOut`/`kOut`, `hMap`/`kMap`, `kMap_comp_hMap` (`k∘h=I`), `kMap_not_injective`, `hMap_not_surjective` — **choice-free** |
| **Ex 2.20** (powerset domain) | `Exercise220.lean` | `powerSet` (cofinite nbhds / `ℕ`), `equivSetNat` (`≃o Set ℕ`), `unionMap`/`interMap₂`, `succMap`/`predMap` |
| **Ex 2.21** (system `C`, juxtaposition) | `Exercise221.lean` | `C`, `singletonElt`/`isTotal_singletonElt`, `bot_lt_Lambda`, `juxtapose`/`juxtapose_cone`/`juxtapose_singleton_mem` — **choice-free** |
| **Ex 2.22** (abstract representation theorem) | `Exercise222.lean` | `Cl`, `IsTok`, `reprSystem`, `toC`/`ofC`, `mem_nbhd_iff`, `reprIso` (`≃o C`) — classical |

**Axiom audit (Lecture II this session).** Choice-free `[propext, Quot.sound]`: 2.13, 2.18, 2.21.
Classical (`Classical.choice`, documented as intrinsic): 2.14, 2.15, 2.20, 2.22. Details in
`arxiv.md §4.5`.

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build Domain`.
- **Axiom footprint:** keep *constructions* and *structural* lemmas choice-free
  (`[propext, Quot.sound]`); audit with `#print axioms` in a scratch file, then delete it. Classical
  steps are OK where genuinely needed — **document** in the module docstring and `arxiv.md §4.5`.
- **Do not commit or push** unless explicitly asked.
- **Read the source first:** `sources/PRG19_vision.md` lines **939–1642** (Def 3.1 → Exercise 3.28).
- **Update docs on completion:** mark rows **Pass** in `arxiv.md §4.2.III`; refresh the §4.4 tally and
  the report-card module list; add §4.5 proof notes; update this file.

---

## Remaining spine work — Theorem 3.13(ii)(iii) (vision 1385–1399)

The spine **Def 3.1 → Thm 3.13(i)** is done (see the table above). What is left of the spine:

**Theorem 3.13(ii)(iii):** for `F ⊆ |𝒟₀→𝒟₁|`, `F` is bounded iff `{f(x) ∣ f∈F}` is bounded in
`|𝒟₁|` for each `x`; and then `(⊔F)(x) = ⊔{f(x) ∣ f∈F}` (the sup is pointwise). Scott's proof
preserves directed unions (cf. 2.9, 2.11).

**Why it is deferred:** this needs **bounded-`sSup` infrastructure for `Element`** that does not yet
exist. The codebase has `sSupDirected` (directed families, `Approximable.lean`) and
`Bounded`/`sSup` for a *pair* (`Exercise127.lean`), but not the least upper bound of an arbitrary
**bounded** subset of `Element` (bounded-complete sups). The cleanest route:

1. Build `NeighborhoodSystem.sSupBounded (S : Set V.Element) (hbdd : ∃ u, ∀ s∈S, s ≤ u) : V.Element`
   — e.g. the filter generated by `⋃ S` (its up-closure under finite meets, which the bound keeps a
   neighbourhood), with `le_sSupBounded`/`sSupBounded_le`. Verify it is choice-free.
2. Define `⊔F` on maps via `funSpaceEquiv` (transport the `Element` sup), or directly as the map
   with relation `X (⊔F) Y ↔ Y ∈ sSupBounded {f(↑X) ∣ f∈F}`.
3. (ii) is then `le_iff_toElementMap_le` (Thm 3.13(i), done) applied pointwise; (iii) is
   `toElementMap_sSup_apply`.

---

## Exercises 3.14–3.28 (after the spine)

| Exercise | One-liner | Key dependency |
| -------- | --------- | -------------- |
| 3.14 | tagged product `0Δ₀∪1Δ₁`; `diag:D→D×D`; `n`-fold products | Def 3.1 |
| 3.15 | product isos: comm/assoc/empty/functoriality | Prop 3.2 |
| 3.16 | `𝒟^∞` over `Δ^∞`; `𝒟^∞ ≅ 𝒟×𝒟^∞` | 3.14 |
| 3.17 | `B→T^∞`, `T^∞→B`; section/retraction | 3.16, `ExampleB` |
| 3.18 | **sum** system `𝒟₀+𝒟₁`; `inᵢ`/`outᵢ`; `outᵢ∘inᵢ=I` | Def 3.1 (dual) |
| 3.19 | functorial `f×g`, `f+g` | 3.18, Prop 3.4 |
| 3.20 | (cat) `+`,`×` functors; `×` categorical product | 3.19 |
| 3.21 | `[Y,Z]` determines `Y,Z` when `Z≠Δ₂` | Def 3.8 |
| 3.22 | composition `(D₁→D₂)×(D₀→D₁)→(D₀→D₂)` approximable | Thm 3.11/3.12 |
| 3.23 | (cat) domains+approximable maps are CCC | Thm 3.11/3.12 |
| 3.24 | more function-space isos | Thm 3.12 |
| 3.25 | (top) open subsets of `\|D\|` form a domain | Thm 3.10, Ex 1.21, **Ex 2.13** |
| 3.26 | `fix:(D→D)→D` least fixed point, approximable | Thm 3.10/3.11 |
| 3.27 | (set) alt proof `(D₀→D₁)` is a domain via **Ex 2.22** | `Exercise222.lean` |
| 3.28 | minimal element of `⋂[Xᵢ,Yᵢ]`: `f₀(x)=⊔{↑Yᵢ∣x∈[Xᵢ]}` | Def 3.8, `sSupDirected` |

---

## Reusable infrastructure (in the codebase)

| Need | Where |
| ---- | ----- |
| `ApproximableMap`, `toElementMap`, `rel_iff_mem_principal`, `idMap`/`comp`/`comp_assoc`/laws, `ofIso`, `exists_principal_eq_apply_principal`, `sSupDirected` | `Approximable.lean` |
| `ofMono`, `toElementMap_mem_iff_principal` (**Ex 2.9**), `interMap`, `iSupDirected`/`iSupMap`, **`ApproximableMap₂`/`toElementMap₂`/`rel₂_iff_mem_principal`/`toElementMap₂_mono`** (**Ex 2.19 — central to 3.5/3.11**) | `ApproximableExercises.lean` |
| `continuous_toElementMap`/`ofContinuous` (continuity bridge — **3.25**) | `Exercise213.lean` |
| `reprSystem`/`reprIso`/`Cl`/`IsTok` (abstract representation — **alt proof for 3.27**) | `Exercise222.lean` |
| `basicOpen`, topology of `\|𝒟\|`, `le_iff_isOpen_imp`, `specializes_iff_le` (**3.25**) | `Exercise122.lean` |
| `bracket`/`tokenSystem`/`tokenIso`; `iUnion`/`iInter` closure | `Theorem110.lean`, `Theorem111.lean` |
| `FinitelyConsistent`/`sInf`/`leastFilter`; `Bounded`/`sSup`/`consistent_pair_iff_bounded` | `Exercise118.lean`, `Exercise127.lean` |
| `B`/`cone`/`prepend`; `runMap`/`out`/`del` | `ExampleB.lean`, `Example24.lean` |
| `principal`, `principal_le_iff`, `IsTotal`, `bot`, `DomainIso`/`≃o`, `ofNestedOrDisjoint`, `ofPositive` | `Basic.lean` |
| **continuous-lattice analogue of the function space** (structural reference for Thm 3.10) | `Domain/ContinuousLattice/FunctionSpaceTower.lean` |

---

## Workflow

1. Read `sources/PRG19_vision.md` lines **1385–1642** (Thm 3.13 + Ex 3.14–3.28). The §4.2.III
   inventory in `arxiv.md` has the exact vision line ranges per row.
2. **Theorem 3.13(ii)(iii):** build the bounded-`sSup` infrastructure for `Element` (see "Remaining
   spine work" above), then `(⊔F)(x) = ⊔{f(x)}` via `funSpaceEquiv` and `le_iff_toElementMap_le`.
3. Then the exercises 3.14–3.28, one module each (`Construction3xx.lean` or grouped sensibly).
   `Product.lean`/`FunctionSpace.lean` already provide the products, sums-precursors, `eval`,
   `curry`, `leastMap`, etc. Note 3.28 = `leastMap`'s elementwise formula `f₀(x)=⊔{↑Yᵢ∣x∈[Xᵢ]}`,
   which connects directly to the already-built `leastMap`/`interYs`.
4. Add each file to `Domain.lean`; keep `lake build Domain` green; `#print axioms` scratch audit
   (delete the scratch file after).
5. Update `arxiv.md`: §4.2.III rows → **Pass**; §4.4 tally (Lecture III count, total); report-card
   module list; §4.5 proof notes. Update this `HANDOFF.md` for whatever remains (Lecture IV is
   partially OCR'd from line 1646 but not yet inventoried).

---

## Key reference files

| File | Role |
| ---- | ---- |
| `sources/PRG19_vision.md` | **Primary source** — Thm 3.13 @1385, Ex 3.14–3.28 @1405–1642 (spine Def 3.1–Thm 3.12 already formalized) |
| `arxiv.md §4.2.III` | full Lecture III inventory; spine rows **Pass**, Thm 3.13(ii)(iii) + Ex 3.14–3.28 **Not Yet** |
| `Domain/Neighborhood/Product.lean` | **§3.1–3.7** — `prod`/`prodEquiv`, `proj`/`paired`, `constMap`, `map₂Equiv`, `substitution_toElementMap` |
| `Domain/Neighborhood/FunctionSpace.lean` | **§3.8–3.13(i)** — `funSpace`/`funSpaceEquiv`, `leastMap`, `eval`/`evalMap`, `curry`/`uncurry`/`curryEquiv`, `le_iff_toElementMap_le` |
| `Domain/Neighborhood/Approximable.lean` | `ApproximableMap`, `comp`, `ofIso`, `sSupDirected` |
| `Domain/Neighborhood/ApproximableExercises.lean` | `ApproximableMap₂` (Ex 2.19) — central to products/eval |
| `Domain.lean` | already imports `Product`, `FunctionSpace`; add `Construction3xx` imports for the exercises |

The §3 **spine (3.1 → 3.13(i)) is formalized**, so the cartesian-closed-category structure of
domains (`eval`, `curry`, `curryEquiv`) is in place. The exercises then fill in sums, infinite
products, `fix`, and the categorical statements; Thm 3.13(ii)(iii) needs bounded-`sSup` infra.
