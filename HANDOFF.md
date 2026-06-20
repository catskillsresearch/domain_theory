# Handoff — Part II, Scott 1981 (PRG-19): Lecture III (§3) — products, sums, function spaces

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Lecture I is COMPLETE (43 Pass).** **Lecture II is COMPLETE (22 Pass)** (`lake build Domain`
green, zero `sorry`s). **This session: begin Lecture III (§3) — the domain constructions:** products
(Def 3.1–Prop 3.4), separate continuity (Thm 3.5 / Lemma 3.6), substitution (Prop 3.7), the
**function space** `(𝒟₀→𝒟₁)` (Def 3.8–Thm 3.13), and Exercises 3.14–3.28. Current total: **65 Pass**;
Lecture III is **28 rows, all Not Yet** (`arxiv.md §4.2.III`).

---

## What just landed (Lecture II — now complete)

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

## Recommended order and dependencies

The core spine (3.1 → 3.13) builds the cartesian-closed structure; do it in order, then the exercises.

```
Def 3.1 / Prop 3.2  (product system 𝒟₀×𝒟₁; ⟨x,y⟩; |𝒟₀×𝒟₁| ≅ |𝒟₀|×|𝒟₁|)   ← foundation
Def 3.3 / Prop 3.4  (projections p₀,p₁; pairing ⟨f,g⟩; pᵢ∘⟨f,g⟩=f/g)
Lemma 3.6           (constant maps) ─┐
Theorem 3.5         (joint ⟺ separate approximability)  ← uses Lemma 3.6
Prop 3.7            (substitution / multivariate composition closed)
Def 3.8             (function space (𝒟₀→𝒟₁): tokens = approximable maps; nbhds ⋂[Xᵢ,Yᵢ])
Prop 3.9            (consistency of [Xᵢ,Yᵢ] families; finite elements)
Theorem 3.10        (function space complete: filters ↔ approximable maps)   ← the crux
Theorem 3.11        (eval approximable; eval(f,x)=f(x))
Theorem 3.12        (curry; eval∘⟨curry g∘p₀,p₁⟩=g — the CCC adjunction)
Theorem 3.13        (f⊑g ⟺ ∀x f(x)⊑g(x); pointwise ⊔)
Exercises 3.14–3.28 (tagged products, 𝒟^∞, sums 𝒟₀+𝒟₁, functoriality, CCC, fix, …)
```

| Order | Result | New module (suggested) | Depends on |
| ----- | ------ | ---------------------- | ---------- |
| 1 | **Def 3.1 / Prop 3.2** | `Product.lean` | `Basic.lean` (`NeighborhoodSystem`, `Element`, `≃o`) |
| 2 | **Def 3.3 / Prop 3.4** | `Product.lean` | `Approximable.lean` (`comp`/`idMap`), `ApproximableMap₂` |
| 3 | **Lemma 3.6 + Theorem 3.5** | `Product.lean` | Prop 3.2, `ApproximableMap₂` (Ex 2.19) |
| 4 | **Prop 3.7** | `Product.lean` | Prop 3.4, `comp_assoc` |
| 5 | **Def 3.8 / Prop 3.9 / Thm 3.10** | `FunctionSpace.lean` | `Approximable.lean` (maps as tokens), `Theorem110/111` |
| 6 | **Thm 3.11 / 3.12 / 3.13** | `FunctionSpace.lean` | Thm 3.10, Product, `sSupDirected` |
| 7 | **Ex 3.14–3.28** | `Construction3xx.lean` (one per exercise) | the spine above + Ex 2.22 (for 3.27), 2.13/1.21 (3.25) |

Add every new file to `Domain.lean`.

---

## Spine-by-spine deliverables

### Def 3.1 / Prop 3.2 — the product system (vision 939–999)

**Scott:** with disjoint `Δ₀,Δ₁`, `𝒟₀×𝒟₁` has neighbourhoods `X ∪ Y` (`X∈𝒟₀, Y∈𝒟₁`), and element
pairing `⟨x,y⟩ = {X∪Y ∣ X∈x, Y∈y}`. Prove it is a neighbourhood system, that `⟨x,y⟩⊑⟨x',y'⟩ ⟺
x⊑x' ∧ y⊑y'`, and the order-iso `|𝒟₀×𝒟₁| ≅ |𝒟₀|×|𝒟₁|`.

**Lean targets (`Product.lean`):**

| Target | Content |
| ------ | ------- |
| `prod (V₀ V₁) : NeighborhoodSystem (α ⊕ β)` | use `Sum` for disjointness; token `α⊕β`, `master = inl⁻¹? …` — neighbourhoods are `(inl '' X) ∪ (inr '' Y)`. `inter_mem` from the two factors' `inter_mem`. |
| `pair (x y) : (prod V₀ V₁).Element` | `⟨x,y⟩`; `mk`-style filter. |
| `pair_le_pair_iff` | `⟨x,y⟩ ⊑ ⟨x',y'⟩ ↔ x ⊑ x' ∧ y ⊑ y'`. |
| `prodEquiv : (prod V₀ V₁).Element ≃o V₀.Element × V₁.Element` | the iso; `fst`/`snd` are the components. |

**Pitfall:** the disjoint-union token type is the cleanest model of Scott's "disjoint `Δ₀,Δ₁`".
Mathlib's product order on `V₀.Element × V₁.Element` is componentwise — match it exactly.

### Def 3.3 / Prop 3.4 — projections and pairing (vision 1003–1047)

**Scott:** projections `p₀,p₁`, paired map `⟨f,g⟩`; `pᵢ` and `⟨f,g⟩` approximable;
`pᵢ∘⟨f,g⟩ = f/g`; `h = ⟨p₀∘h, p₁∘h⟩`; `⟨f,g⟩(w) = ⟨f(w),g(w)⟩`.

**Lean targets:** `proj₀`/`proj₁ : ApproximableMap (prod V₀ V₁) Vᵢ`, `paired (f g) :
ApproximableMap W (prod V₀ V₁)`, then `proj₀_comp_paired`, `proj₁_comp_paired`,
`paired_proj` (`⟨p₀∘h,p₁∘h⟩=h`), and `toElementMap_paired` (`⟨f,g⟩(w)=⟨f(w),g(w)⟩`). Reuse
`comp`/`comp_assoc` from `Approximable.lean`.

### Lemma 3.6 + Theorem 3.5 — separate vs. joint approximability (vision 1081–1112)

**Scott:** constant maps are approximable (`X b Y ⟺ Y∈b`); `f:|D₀×D₁|→|D₂|` is approximable iff it
is approximable separately in each argument.

**Lean targets:** `constMap (b) : ApproximableMap V₀ V₁` + `toElementMap_constMap`; then
`approximable_iff_separately` linking `ApproximableMap (prod V₀ V₁) V₂` to `ApproximableMap₂ V₀ V₁ V₂`
(you already have `ApproximableMap₂` from Ex 2.19 — this theorem is the bridge `ApproximableMap (prod …)
≃ ApproximableMap₂`). Likely the **payoff** that justifies the Ex 2.19 work.

### Prop 3.7 — substitution closed (vision 1124–1158)

Multivariate approximable functions are closed under substitution (composition + projections). Mostly
`comp`/`paired`/`proj` bookkeeping once 3.4 is in place.

### Def 3.8 / Prop 3.9 / Theorem 3.10 — the function space (vision 1164–1282)

**Scott (the heart of §3):** `(𝒟₀→𝒟₁)` has *tokens = approximable maps* (really the step functions
`[X,Y]`), neighbourhoods `⋂ᵢ [Xᵢ,Yᵢ]` where `[X,Y] = {f ∣ X f Y}`. Prop 3.9 characterizes when a
family `{[Xᵢ,Yᵢ]}` is consistent (`{Xᵢ}` consistent ⟹ `{Yᵢ}` consistent). **Theorem 3.10:** the
function space is *complete* and its elements (filters) correspond bijectively, inclusion-preservingly,
to approximable maps `𝒟₀→𝒟₁`.

**Lean targets (`FunctionSpace.lean`):**

| Target | Content |
| ------ | ------- |
| `step (X Y) : Set (ApproximableMap V₀ V₁)` (the `[X,Y]`) | `{f ∣ f.rel X Y}`; neighbourhoods = finite `⋂`. Decide the token type — likely `Σ X Y, …` step-function data or a `Set` of `(X,Y)` pairs. |
| `funSpace V₀ V₁ : NeighborhoodSystem …` | the system; `inter_mem` via Prop 3.9 consistency. |
| `consistent_step_iff` (Prop 3.9) | `{[Xᵢ,Yᵢ]}` consistent ⟺ (`{Xᵢ}` consistent ⟹ `{Yᵢ}` consistent). |
| `funSpaceEquiv : (funSpace V₀ V₁).Element ≃o ApproximableMap V₀ V₁` (Thm 3.10) | the bijection; **inclusion-preserving**. This is the technical crux — budget the most time here. |

**Pitfall:** mirror `Domain/ContinuousLattice/FunctionSpaceTower.lean` (the continuous-lattice analogue)
for proof structure, but the *token* model is Scott's neighbourhood-system one. The order on
`ApproximableMap` is `rel`-inclusion; `funSpaceEquiv` must be an `≃o` for that order.

### Theorem 3.11 / 3.12 / 3.13 — eval, curry, pointwise order (vision 1286–1399)

`eval : (𝒟₁→𝒟₂)×𝒟₁ → 𝒟₂` approximable with `eval(f,x)=f(x)` (3.11); `curry(g):𝒟₀→(𝒟₁→𝒟₂)` with the
adjunction `eval∘⟨curry g∘p₀, p₁⟩ = g` (3.12); `f⊑g ⟺ ∀x f(x)⊑g(x)`, bounded sups pointwise (3.13).
Together these give the **cartesian-closed category** (Ex 3.23). Use `ApproximableMap₂` for `eval`,
`toElementMap₂`, and the product `paired`/`proj` from step 2.

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

1. Read `sources/PRG19_vision.md` lines **939–1642** (Def 3.1 → Ex 3.28). The §4.2.III inventory in
   `arxiv.md` has the exact vision line ranges per row.
2. Build the product first: `Product.lean` — Def 3.1/Prop 3.2 (system + `prodEquiv`), then Def 3.3/
   Prop 3.4 (`proj`/`paired`), Lemma 3.6 (`constMap`), Theorem 3.5 (`approximable_iff_separately`),
   Prop 3.7.
3. Build the function space: `FunctionSpace.lean` — Def 3.8 (`funSpace`), Prop 3.9
   (`consistent_step_iff`), **Theorem 3.10** (`funSpaceEquiv`, the crux), then eval/curry/pointwise
   (Thm 3.11/3.12/3.13).
4. Then the exercises 3.14–3.28, one module each (`Construction3xx.lean` or grouped sensibly).
5. Add each file to `Domain.lean`; keep `lake build Domain` green; `#print axioms` scratch audit
   (delete the scratch file after).
6. Update `arxiv.md`: §4.2.III rows → **Pass**; §4.4 tally (Lecture III count, total); report-card
   module list; §4.5 proof notes. Update this `HANDOFF.md` for whatever remains (Lecture IV is
   partially OCR'd from line 1646 but not yet inventoried).

---

## Key reference files

| File | Role |
| ---- | ---- |
| `sources/PRG19_vision.md` | **Primary source** — Def 3.1 @939, Prop 3.2 @953, Def 3.3 @1003, Prop 3.4 @1031, Thm 3.5 @1081, Lemma 3.6 @1089, Prop 3.7 @1124, Def 3.8 @1164, Prop 3.9 @1176, Thm 3.10 @1268, Thm 3.11 @1286, Thm 3.12 @1322, Thm 3.13 @1385, Ex 3.14–3.28 @1405–1642 |
| `arxiv.md §4.2.III` | full Lecture III inventory (line ranges + Lean-target sketches), all rows **Not Yet** |
| `Domain/Neighborhood/Approximable.lean` | `ApproximableMap`, `comp`, `ofIso`, `sSupDirected` |
| `Domain/Neighborhood/ApproximableExercises.lean` | `ApproximableMap₂` (Ex 2.19) — central to products/eval |
| `Domain/ContinuousLattice/FunctionSpaceTower.lean` | structural reference for the function-space completeness theorem (3.10) |
| `Domain.lean` | add `Product`, `FunctionSpace`, `Construction3xx` imports |

When the §3 spine (3.1–3.13) lands, the cartesian-closed-category structure of domains is formalized;
the exercises then fill in sums, infinite products, `fix`, and the categorical statements.
