# Handoff — Scott 1981 (PRG-19): Lectures I–IV COMPLETE (IV spine Thm 4.1/4.2, Ex 4.3/4.4, Def 4.5 + Thm 4.6, **all Exercises 4.7–4.25**); **Lecture V COMPLETE** (Table 5.5, Thm 5.1/5.2/5.6, Prop 5.3/5.4, **Exercises 5.7–5.16 — including 5.16's full Thue–Morse `t`: unfolding, digit-sum-mod-2 (Lambek), and overlap-freeness**); **Lecture VI: Example 6.1 (D<sup>§</sup> ≅ D + (D<sup>§</sup>×D<sup>§</sup>)), Example 6.2 (`B ≅ B+B`, `C ≅ {{Λ}}+C+C`, the generalization `A ≅ Aⁿ + Aⁿ`, and eventually-periodic trees ↔ regular events via Myhill–Nerode) + categorical spine (Defs 6.3–6.5, Props 6.6–6.7) Definition 6.8 (functors *continuous on maps*, over the strict function space), and **Theorem 6.9 (homomorphisms out of a fixed point `D ≅ T(D)`)**, and **Theorem 6.14 (initial `T`-algebra: existence + uniqueness/initiality among strict algebras)**, **Lemma 6.15 (projection pair ⟹ `D ⊴ E`)** and **Theorem 6.16 (an initial `T`-algebra embeds in every solution: `D ⊴ E` for all `E ≅ T(E)`)** COMPLETE**; rest of VI + VII–VIII transcribed & inventoried

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`, Lean toolchain per `lean-toolchain`.

## Resume Protocol (read this first)

A session may begin after a context reset; chat memory is not durable, these files are. To resume:

1. Read this `HANDOFF.md` top-to-bottom (it is the source of truth for status + recent work).
2. For the inventory of every item and its status, **`Grep` `arxiv.md`** for the item (e.g.
   `Theorem 6.9`) and read only that row — do **not** read `arxiv.md` whole (~2.5k lines).
3. Per-item details live in the relevant `Domain/Neighborhood/*.lean` docstring/proof notes.
4. Build with `lake build Domain` (filter output: `| grep -vE 'LEAN_PATH|trace:' | tail`).
5. Follow `.cursor/rules/handoff-discipline.mdc` (choice discipline, axiom audits, and the
   end-of-item checklist that keeps this file + `arxiv.md` current).

**Next concrete target:** **Lecture VII — Definition 7.2** (*computable map* = `REPred` of the
neighbourhood relation `Xₙ f Yₘ`). **Definition 7.1 is COMPLETE** (`Definition71.lean`, ns
`Domain.Neighborhood`): `ComputablePresentation V` (enumeration `X:ℕ→Set α` onto 𝒟 + Scott's two
`ComputablePred` relations interEq/cons), `incl_computable`, `eq_computable`,
`NeighborhoodSystem.IsEffectivelyGiven`, sanity inhabitant `unitSys_isEffectivelyGiven`. **CHOICE
NOTE for all of Lecture VII:** the user chose genuine mathlib recursion theory
(`Computable`/`ComputablePred`/`REPred`), which is *classical at its foundation* (`Computable.const`
already depends on `Classical.choice`). So every Lecture-VII computability result audits as
`{propext, Classical.choice, Quot.sound}` — this is **unavoidable & expected**, not a discipline
slip: the *data* (enumerations, index functions) stays explicit/constructive, only the computability
*witnesses* are classical. **Exercise 6.29 is COMPLETE** (`Exercise629.lean`,
ns `Exercise629`): infinitary `∏_i D_i` (`iprod`, cylinders + finite support; headline
`iprodEquiv : |∏_i D_i| ≃o ∀ i, |D_i|`), `∑_i D_i` (`isum`, separated sum + `isum_trichotomy`),
`⊕_i D_i` (`ioplus`, coalesced) — these **generalize**; `⊗_i D_i` (`iotimes`) **degenerates** over an
infinite index (`iotimes_subsingleton`: only the basepoint). So `+`,`×`,`⊕` generalize, `⊗` does not.
Finite support is the *positive* `List` form `∀ i, i∉l → X i = master` (keeps `FinSupp.inter`/recon
choice-free). Data + `isum_summand_unique` are `⊆ {propext, Quot.sound}`; only `isum_trichotomy` (EM)
and the `⊗` degeneracy (classical `Set.Finite`) use `Classical.choice` (Prop-level, flagged). See the
dated checkpoint at end.
**Exercise 6.28 is COMPLETE** (`Exercise628.lean`, namespace `Domain.Neighborhood`): the finite
Cantor–Schröder–Bernstein Plotkin suggested — if `|𝒟|,|ℰ|` are finite and `𝒟 ⊴ ℰ ⊴ 𝒟` then
`𝒟 ≅ᴰ ℰ` (`isomorphic_of_trianglelefteq_both`; faithful nbhd-count version
`isomorphic_of_finite_system`). Crux: `⊴` already yields an **order embedding** `|D| ↪o |E|`
(`Trianglelefteq.elementEmbedding`, via Prop 6.12's `i,j` and `projElementEmbedding`); mutual
embeddings of finite types ⟹ iso (`orderIso_of_embeddings`, `Fintype.card` antisymm). Infinite
question answered **No** (finite cardinality count, no infinite analogue) — counterexample as prose.
Relational core choice-free; the finite count uses `Classical.choice` (extract `Fintype`). See dated
checkpoint at end.
**Exercise 6.27 is COMPLETE** (`Exercise627.lean`, namespace `Domain.Neighborhood.Exercise627`):
which `⊴` subsystem relations hold — **the first five hold for all `𝒟,ℰ`, the sixth `𝒟 ⊴ 𝒟⊗ℰ`
fails in general**. `(1) (𝒟⊗ℰ)◁(𝒟×ℰ)`, `(3) (𝒟⊕ℰ)◁(𝒟+ℰ)` are literal subsystems; `(2) 𝒟⊴𝒟×ℰ`,
`(4) 𝒟⊴𝒟⊕ℰ` are projection pairs (Lemma 6.15); `(5) (𝒟→⊥ℰ)⊴(𝒟→ℰ)` is the inclusion/strictification
pair `inclMap`/`strctMap` (choice-free, general systems); `(6)` is refuted by `ℰ=𝟙` collapsing
`𝒟⊗𝟙` to a one-point lattice. Part 4's `oplus_mem_leftN` (the `X=Δ₀?` split) is the **only**
`Classical.choice` use; rest `⊆ {propext, Quot.sound}`. See dated checkpoint at end.
**Exercise 6.26 is COMPLETE** (`Exercise626.lean`, namespace `Domain.Neighborhood.Exercise619`):
the **lift** `liftTok D _hD = {{Λ}∪0Δ}∪{0X∣X∈𝒟}` over `Str={0,1}*` (`∅`-free, packaged `ScottSys.lift`).
**Elements** `|𝒟_⊥|≅|𝒟|_⊥`: fresh bottom `liftBot`, embedding `liftUp` with `liftBot_le`,
`liftUp_le_liftUp_iff`, `liftBot_lt_liftUp`, `unlift`/`liftUp_unlift`, covering `eq_liftBot_or_exists_liftUp`
(its lone `Classical.choice`, for the `z.mem 0Δ?` split; everything else choice-free). **Functor** (yes,
strict): `liftMapTok`, `liftMapTok_isStrict`/`_id`/`_comp`. **`𝒟_⊥⊕ℰ_⊥≅ᴰ𝒟+ℰ`** (`lift_oplus_lift_iso_sum`,
elementwise `OrderIso` `toSumLift`/`fromSumLift`, deletes the inner `0`). **`𝒟_⊥⊗ℰ_⊥≅ᴰ(𝒟×ℰ)_⊥`**
(`lift_otimes_lift_iso_lift_prod` — answer to Scott's `??`; `toLiftProd`/`fromLiftProd`). See dated
checkpoint at end. **Exercise 6.25 is COMPLETE** (`Exercise625.lean`, namespace `Domain.Neighborhood.Subsystem.ProjectionPair`):
the projection pair `g=inj`, `h=proj` of `ProjectionPair D E` carries the two laws on elements
(`proj_inj_apply : h(g x)=x`, `inj_proj_apply_le : g(h y)⊑y`); from them the **Galois connection**
`galois : g(x)⊑y ↔ x⊑h(y)` (monotonicity in each direction), the two **extremal formulas**
`proj_eq_sSup : h(y)=⊔{x∣g(x)⊑y}` (the set is the down-set of `h(y)` — bounded + `lowerSet_directed`)
and `inj_eq_sInf : g(x)=⊓{y∣x⊑h(y)}` (the up-set of `g(x)` — `upperSet_nonempty`), and finally `g`
**maps consistent (=bounded) sets to consistent sets** (`inj_bounded`) and **preserves all lubs**
`inj_sSup : g(⊔S)=⊔{g(s)}` (lower-adjoint property, proved via `galois`). Choice-free; see the dated
checkpoint at the end. **Exercise 6.24 is COMPLETE**
(`Exercise624.lean`, namespace `Domain.Neighborhood.Exercise624`): the **double fixed-point** method
for the coupled system `D ≅ D+(D×E)`, `E ≅ D+E`. Tokens `Str={0,1}*`; token recursions
`gTok p q = insert [] (0p ∪ 1q) = tok(D+E)` and `fTok p q = gTok p (gTok p q) = tok(D+(D×E))`; the
pair Kleene iteration `pIter` gives `GammaD/GammaE` with `fTok_GammaD_GammaE`/`gTok_GammaD_GammaE`
(continuity = each token references ≤1 coordinate, so a single stage suffices, no merge). Object level:
`Dsol={Γ_D}`, `Esol={Γ_E}`, `Dsol_subsystem : {Γ_D} ◁ D+(D×E)` and `Esol_subsystem : {Γ_E} ◁ D+E`
simultaneously (`exists_simultaneous_subsystems`) — the joint hypothesis of the simultaneous Thm 6.14.
Choice-free; see the dated checkpoint at the end.
**Exercise 6.23 is COMPLETE — all four phases** (`Exercise623.lean`: the concrete solution domain
`Exp` for `Exp ≅ N ⊕ ((Exp×Exp)+(Exp×Exp))`; the strict-map `Category ScottSys` + `Texp` as an
`Endofunctor` + the algebra `ExpAlg`; the **evaluation homomorphism** `descAlgHom : AlgHom (ExpAlg N
hN) B` for every algebra `B` (Scott's `val(s)`, existence), built as the Kleene fixed point
`⋃ₙ k∘T(·)∘j`; and **uniqueness/initiality `ExpInitial : IsInitial (ExpAlg N hN)`** via the projection
chain `ρₙ = iₙ∘jₙ`, the functor-carries-the-projection-pair crux `GExpr.map_inj/map_proj`, the key
equation `key_rho : ρₙ₊₁ = i∘T(ρₙ)∘j`, and `g`-independence `gcomp_rho_eq : g∘ρₙ = valₙ` ⟹
`descMap_eq_algHom`). Choice-free `{propext, Quot.sound}`. **Exercise 6.24 is COMPLETE**
(double fixed point — see above and the dated checkpoint). **Exercise 6.22 is
COMPLETE** (`Exercise622.lean`: the three domain equations recognised as `GExpr` fixed points).
**Exercise 6.21 is COMPLETE** (`Exercise621.lean`: coalesced sum `⊕`, smash product `⊗`, the
6-constructor functor algebra `GExpr`, its 6.20 fixed point, and the n-ary generalization). Earlier completed milestones below
for context. **Exercise 6.17 is COMPLETE — both parts** (`Exercise617.lean`,
`Exercise617Gen.lean`). Part 1: `CisInitial : IsInitial Calg`, `C` is the initial `T`-algebra for
`T(X)=𝟙+X+X`. Part 2 (`Exercise617Gen.lean`): the development is generalized over an arbitrary
alphabet `A : Type [DecidableEq A]` — domain `Cn A` of finite/infinite `A`-sequences, endofunctor
`Tsig(X)=𝟙+Σ_{a:A}X` (`sumSig`/`sumMapSig`/`Tsig`), iso `Cn_domain_equation : Cn A ≅ᴰ 𝟙+Σ_a Cn A`,
and **initiality `CnisInitial : IsInitial Cnalg`**; instantiating `A := Fin (n+1)` gives Scott's `Cₙ`
(`Cfin_domain_equation`, `CfinIsInitial`), and `n=1` (`Fin 2 ≃ Bool`) recovers the binary case. See
the dated checkpoint at the end of this file. **Exercise 6.18 is COMPLETE** (`Exercise618.lean`,
`iterIsInitial : IsInitial (iterAlg Dom)` — `𝒟^∞` is the initial algebra of `T(X)=𝒟×X`, the
domain-equation half being Exercise 3.16's `iter_isomorphic`; see the dated checkpoint at the end).
**Exercise 6.19 Part A is COMPLETE** (`Exercise619.lean`): the concrete `{0,1}*` sum/product
`sumTok`/`prodTok` and their *"correct up to isomorphism"* results `sumTok_iso_sum`,
`prodTok_iso_prod` (see the dated checkpoint at the end). **Part B is COMPLETE**
(`Exercise619PartB.lean`): the functor algebra `FExpr` (constants/identity/sum/product over the fixed
token type `{0,1}*`), with `FExpr.map_id`/`map_comp`/`map_isStrict` (functors), `FExpr.map_mono` +
`FExpr.map_continuous` (continuous on maps = approximable in `f`), `FExpr.obj_subsystem` (monotone on
domains) and `FExpr.obj_continuous` (continuous on domains); see the dated checkpoint at the end.
**Theorem 6.16 is COMPLETE** (`Theorem616.lean`,
`trianglelefteq_of_isInitial`). **Exercise 6.20 is COMPLETE** (`Exercise619PartB.lean`):
`λΓ. tok(T({Γ}))` is continuous on `{Γ ∣ Λ∈Γ}` (`mFun`/`mFun_mono`/`mFun_continuous`), its Kleene
fixed point gives `Γ=tok(T({Γ}))` (`exists_tok_fixedPoint`) and `{Γ}◁T({Γ})`
(`exists_singleton_subsystem`), so Thm 6.14 applies; see the dated checkpoint at the end.
**Lemma 6.15 is COMPLETE**
(`Lemma615.lean`, the converse of Prop 6.12: a projection pair `i,j` with `j∘i=I_D`, `i∘j⊆I_E`
between systems over *possibly different* token types ⟹ `D ⊴ E`). **Theorem 6.14 is COMPLETE** (existence *and* uniqueness/initiality —
`Theorem614.lean`). `key_rho`, the `gₙ=g∘ρₙ` recursion,
`g`-independence and initiality-among-strict-algebras all build green and choice-free.
**Definition 6.13 is now DONE** (`Definition613.lean`, the
functor predicates *monotone on domains* `D◁E ⟹ T(D)◁T(E)` with `i,j` carried to `T(i),T(j)`, and
*continuous on domains* `λD.T(D)` on `{D∣D◁E}` approximable = preserves directed unions of
subsystems) — see the checkpoint at the end of this file. **Proposition 6.12 is also DONE**
(`Proposition612.lean`, the projection pair `i,j` from `D◁E`). **Proposition 6.11**
(`Proposition611.lean`, the subsystems `{D ∣ D ◁ E}` form a domain), **Definition 6.10**
(`Definition610.lean`, the subsystem relation `D ◁ E`) and **Theorem 6.9** (`Theorem69.lean`) are
also DONE.

## Where things stand

- **`lake build Domain` is green, zero `sorry`s** (≈3082 jobs). **Lecture VI's categorical spine is
  now formalized** — see the "Lecture VI" section below. **Theorem 5.6 is now complete
  end-to-end**: `Theorem56Full.lean` proves *every partial recursive function is λ-definable*
  (`partrec_lamDef`) against Mathlib's `Nat.Partrec'`, plus Scott's 1-ary corollary `partrec_one`.
- **Lecture I (43), Lecture II (22), Lecture III (29) = 94 numbered results/exercises are Pass.**
  Lecture III is now **complete end-to-end**: the spine (Def 3.1 → Thm 3.13) *and* every §3 exercise
  (3.14–3.28).
- **Lecture IV spine is Pass.** Theorems 4.1/4.2 are in `Domain/Neighborhood/Theorem41.lean`
  (`fixElement`, `fixMap`, both choice-free; only `fixMap_unique` uses `Classical.choice` via the
  permitted `ext_of_toElementMap`); Example 4.3 (`Example43.lean`), Example 4.4 (`Example44.lean`),
  and Definition 4.5 + Theorem 4.6 (`Theorem46.lean`). The §4 exercises 4.7–4.25 are all Pass —
  **the most recent work (4.21–4.25) is detailed in the "What's next" section below.**
- **Lectures IV–VIII are fully transcribed** in `sources/PRG19_vision.md` (152/152 OCR pages,
  ≈5365 lines) **and inventoried** in `arxiv.md` §4.2.IV–VIII as Goal Lists. **Lecture IV is now
  complete end-to-end**: the spine (Theorems 4.1/4.2, Examples 4.3/4.4, Definition 4.5 + Theorem 4.6)
  *and* **every §4 exercise (4.7–4.25)** are **Pass**. **Lecture V is now COMPLETE end-to-end**
  (including all of Exercise 5.16's Thue–Morse `t` follow-up — see next section); **Lecture VI's
  Example 6.1 (the tree algebra `D`<sup>§</sup> + the domain equation D<sup>§</sup> ≅ D + (D<sup>§</sup>×D<sup>§</sup>)), Example 6.2
  (the concrete equations `B ≅ B + B` and `C ≅ {{Λ}} + C + C`, the generalization `A ≅ Aⁿ + Aⁿ`, and
  the eventually-periodic-tree ↔ regular-event aside via Myhill–Nerode), and categorical
  spine (Defs 6.3–6.5, Props 6.6–6.7) and Definition 6.8 (continuous on maps) are now Pass**; the rest of VI and VII–VIII are `—`.
  Pages 108–111 were re-OCR'd to fix a page-order scramble
  (Thm 6.14 tail, Lemma 6.15, Thm 6.16, Exercises 6.17–6.20 now in correct order).

### Lecture VI — categorical spine 6.3–6.7 + Definition 6.8 (most recent work)

Lecture VI ("Introduction to domain equations") is heavily category-theoretic. The cleanly tractable,
self-contained chunk — the abstract categorical vocabulary plus the two abstract propositions — is now
formalized. All three modules build alone, are **choice-free** (`#print axioms` reports *no* axioms at
all), and are imported from `Domain.lean`; the full `Domain` build is green.

- **`Definition63.lean`** — the abstract framework, generic over an arbitrary `Category` (a bespoke
  lightweight `class Category` with `Hom`/`id`/`comp` + the three laws; `⊚` is the composition
  notation, "`g` after `f`", matching `ApproximableMap.comp`).
  - **Definition 6.3** — `Endofunctor` (`obj`/`map` + `map_id`/`map_comp`). Named `Endofunctor`
    (not `Functor`) to avoid shadowing Lean core's `Functor`.
  - **Definition 6.4** — `TAlgebra T` (`carrier`, `str : T(carrier) → carrier`) and `AlgHom A B`
    (`hom` + the commuting square `comm : hom ⊚ A.str = B.str ⊚ T.map hom`). Helpers `AlgHom.id`,
    `AlgHom.comp` (the `T`-algebras form a category) with `@[simp]` projections `id_hom`/`comp_hom`.
  - **Definition 6.5** — `IsInitial A` (data: `desc B : AlgHom A B` for every algebra + `uniq`), and
    `Iso X Y` (mutually inverse morphisms).
  - **The concrete category** `instance : Category DomainObj` where `DomainObj` bundles a token type
    with a `NeighborhoodSystem`; `Hom = ApproximableMap`, laws = Theorem 2.5 (`idMap_comp`/
    `comp_idMap`/`comp_assoc`). This witnesses that the abstract definitions are non-vacuous (Scott's
    prose before 6.3: the systems "form quite an interesting category").
- **`Proposition66.lean`** — **Proposition 6.6**: any two initial `T`-algebras are uniquely
  isomorphic. `comp_desc_eq_id` (the round-trip `g∘f` equals `id` by uniqueness), `initialIso`
  (the `Iso` on carriers), `iso_hom_unique` (the realising homomorphism is the only one).
- **`Proposition67.lean`** — **Proposition 6.7 (Lambek's lemma)**: the structure map `i : T(D)→D` of
  an initial algebra is an isomorphism. `tStr` (the algebra `(T D, T i)`), `strHom` (`i` is a
  homomorphism `(TD,Ti)→(D,i)`), `str_comp_desc` (`i∘j = id_D`), and the capstone `lambek` (the `Iso
  (T.obj D) D`, with `j∘i = id` via functoriality `T(i∘j)=T(id)` + the `j` homomorphism square — done
  by an explicit `calc`, since `rw [j.comm]` failed to match on implicit composition args).
- **`Definition68.lean`** — **Definition 6.8**: a functor `T` is *continuous on maps* when, for all
  domains `D, E`, the induced `λf. T(f)` on Scott's **strict** function space `(D →⊥ E)` is
  approximable. Stated verbatim over strict maps by reusing `Exercise510.lean`'s `strictFun`/
  `StrictMap`/`strictFunEquiv` (the `(D →⊥ E)` domain, whose elements are exactly the strict maps).
  "is approximable" = ∃ a representing `Φ : ApproximableMap (strictFun D E) (strictFun (TD) (TE))`
  with `(toStrictMap (Φ.toElementMap (toStrictFilter f))).1 = T.map f.1` (Prop 2.2 / Thm 3.10).
  `ContinuousOnMaps.isStrict_map` shows this forces `T` to preserve strictness (LHS is a `StrictMap`'s
  underlying map), so `T` restricts to Scott's strict subcategory. `continuousOnMaps_id` (witness via
  `idEndofunctor` + `idMap`) gives non-vacuity. **Choice-free** `[propext, Quot.sound]`.

**Theorem 6.9 — DONE (`Theorem69.lean`, fully choice-free `[propext, Quot.sound]`).** *Statement:* if
`T` is continuous on maps and `D ≅ T(D)` (so `D` is a `T`-algebra via `i : T(D) → D`, inverse
`j : D → T(D)`), then for any `T`-algebra `k : T(E) → E` (taken **strict**, as a morphism of Scott's
strict category) there is a homomorphism `h : D → E`. Formalized as
`nonempty_algHom_of_continuousOnMaps … : Nonempty (AlgHom ⟨D, iso.hom⟩ B)` (Scott's *existence*).
*How:* the design point resolved in favour of the **strict** function space `(D →⊥ E)` throughout
(matching Def 6.8). A homomorphism satisfies `h = k ∘ T(h) ∘ j`, the least fixed point of
`Op = homOp ∘ Φ` on `strictFun D.sys E.sys`:
- `Φ` is Def 6.8's witness that `λf. T(f)` is approximable (`(toStrictMap (Φ.toElementMap (toStrictFilter
  f))).1 = T.map f.1`);
- `homOp` (Ex 2.8 `ofMono`) is the post/pre-composition `g ↦ k ∘ g ∘ j : (T(D)→⊥T(E)) → (D→⊥E)`;
  `homOpComp` is the strict composite (strictness of `k∘g∘j` needs `j` strict — `isStrict_of_comp_eq_id`
  from `j∘i=I`, any split iso preserves `⊥` — and `k` strict by hypothesis), and the **action lemma**
  `homOp_apply_filter : homOp(f̂) = (k∘f∘j)^` is proved by reducing to single step nbhds `[X,Z]` **via
  `strictFunEquiv` injectivity** (so the only "finite factoring" needed is `N := [Y₁,Y₂]` — no list
  induction);
- `Op.fixElement` (Thm 4.1) represents `h`; `toElementMap_fixElement` + `Φ`'s eq + `homOp_apply_filter`
  give `h = k∘T(h)∘j`, rearranged via `j∘i=I` (`comp_assoc`, `comp_idMap`) into the `AlgHom` square
  `h∘i = k∘T(h)`. The `Nonempty` conclusion lets `Φ` be pulled from the `Prop`-valued `ContinuousOnMaps`
  by `Exists.elim` — **no `Classical.choice`**.
*New reusable helpers (top of `Theorem69.lean`):* `isStrict_comp`, `isStrict_of_comp_eq_id`,
`comp_mono_gen` (general-arity composition monotonicity), `toStrictMap_mono`, `toStrictFilter_mono`,
`toStrictFilter_toStrictMap` (the left-inverse mirror of `toStrictMap_toStrictFilter`).
*Pitfall:* `rw [toStrictFilter_toStrictMap]` can fail to fire under `set`-introduced let-vars (implicit
`V₀/V₁` metavariables) — close with `exact (toStrictFilter_toStrictMap _).symm` instead.

**Pitfalls (Lecture VI):** (1) name the functor `Endofunctor`, not `Functor` (core clash). (2) For the
`AlgHom.comp` commuting square, the rewrite chain is
`assoc, α.comm, ←assoc, β.comm, assoc, ←map_comp`. (3) `rw [(desc …).comm]` can fail to find its own
LHS pattern (implicit object-args of `⊚` elaborate differently); use the equation as the first step of
a `calc` instead. (4) `(tStr A).str` is *defeq* but not *syntactically* `T.map A.str` — bridge with a
`rfl` `calc` step or `show`.

### Lecture VI — Example 6.1, the tree algebra `D`<sup>§</sup> and its domain equation (most recent work)

**`Example61.lean` — DONE, fully choice-free `[propext, Quot.sound]`** (even the equation iso and the
order-injection lemmas; no `ext_of_toElementMap` needed). Scott's `D`<sup>§</sup> over a fixed domain `D`:
- **Tokens** `Γ = {1,2}* 0 Δ` modelled as `List Bool × α` (`true=1`, `false=2`), master
  `Gamma D = {t ∣ t.2 ∈ Δ}`. Three set embeddings `embZero X = 0X`, `embL P = 1P`, `embR Q = 2Q`,
  `embPair P Q = 1P ∪ 2Q` (set-builder, *not* `Set.image` — membership lemmas are `Iff.rfl`), with a
  tight intersection/subset/injectivity/disjointness API (`embPair_inter`, `embPair_subset`,
  `embZero_inter_embPair`, `embPair_injective`, …).
- **The system** `Dsharp D hD` (`hD : ∀ X, 𝒟.mem X → X.Nonempty` = Scott's standing `∅∉𝒟`). Its `mem`
  is the inductive `MemS D` (least family with `Γ`, `0X`, `1P∪2Q`). The crux **`memS_inter`** is
  Scott's "induction on the number of steps to put `X`,`Y` into `𝒟`<sup>§</sup>": cross cases collapse to `∅`,
  killed by `memS_nonempty` (every member non-empty, the only use of `hD`); the `0A∩0B` case uses
  `𝒟`'s own closure, the `(1P∪2Q)∩(1P'∪2Q')` case recurses. Inversions `memS_embZero_inv`/
  `memS_embPair_inv` recover the constructor from the shape (the `generalize … cases` idiom).
- **The domain equation** `dsharp_domain_equation : Dsharp D hD ≅ᴰ sum D (prod (Dsharp D hD)
  (Dsharp D hD)) hD (prod_dsharp_nonempty D hD)` — i.e. D<sup>§</sup> ≅ D + (D<sup>§</sup> × D<sup>§</sup>) against the project's
  `+` (Ex 3.18) and `×` (Def 3.1). Built as the explicit order-iso `dsharpEquiv` from the filter maps
  `toS` (forward) / `fromS` (inverse), inverse laws `fromS_toS`/`toS_fromS`, and `map_rel_iff'`. The
  three-way branch (⊥ / `0`-branch / pair-branch) is forced by non-emptiness; sum-side inversions
  `sum_mem_inj₀_inv`/`sum_mem_inj₁_inv` and the helper iffs `toS_mem_inj₀`/`toS_mem_inj₁`/
  `fromS_mem_embZero`/`fromS_mem_embPair` keep the inverse-law proofs short.
- **Injections** `inSharp` (x<sup>§</sup> = {Γ}∪{0X∣X∈x}, `inSharp_le_iff`) and `pairSharp`
  (`⟨x,y⟩ = {Γ}∪{1P∪2Q∣P∈x,Q∈y}`, `pairSharp_le_iff`) — Scott's *isomorphic injections*
  λx.x<sup>§</sup> : D→D<sup>§</sup> and λx,y.⟨x,y⟩ : D<sup>§</sup>×D<sup>§</sup>→D<sup>§</sup>; `⊥ = {Γ}` is the system's own `bot`.
- **Pitfalls (re)learned:** (1) section `variable`s used *only in a proof body* (e.g. `hD` in the
  `≠`-shape lemmas whose statement mentions only `D`) are **not** auto-included — add `include hD`.
  (2) `Set.notMem_empty` (not `not_mem_empty`). (3) feeding a member `(p',a)∈P` to `hP : P ⊆ Gamma D`
  when the goal is `(p,a)∈Gamma D` fails elaboration order (it unifies `?x` from the goal) — bind
  `have h := hP …; exact h` so the membership is elaborated first and `exact` closes by defeq.

**What's NOT done in VI (good stopping point):** the
*initial-algebra/homomorphism* g : D<sup>§</sup> → E part of Example 6.1 (the `out`/`proj`/`atom` predecessors
and the fixed-point `g` — connects `D`<sup>§</sup> to the 6.4 `T`-algebra spine, but needs the `cond`-style
recursion over `D`<sup>§</sup>), and everything from Definition 6.8 onward (functors continuous on maps, Theorem
6.9, the subsystem relation `D◁E` and its lattice 6.10–6.12, monotone/continuous functors 6.13, the
existence Theorem 6.14, Lemma 6.15, Theorem 6.16, and Exercises 6.17–6.29) — these need substantial new
domain-theoretic machinery (continuous functors, the subsystem lattice, projection pairs, and the
iterated-functor colimit construction).

### Lecture VI — Example 6.2, the domain equations `B ≅ B+B`, `C ≅ {{Λ}}+C+C`, the generalization `A ≅ Aⁿ + Aⁿ`, and the eventually-periodic ↔ regular aside (most recent work)

Scott's Example 6.2 exhibits his two running concrete domains as solutions of domain equations. Both
modules build alone, are **fully choice-free** (`#print axioms` reports `[propext, Quot.sound]` for the
systems, the order-isos, and the equation theorems), and are imported from `Domain.lean`; the full
`Domain` build is green.

- **`Example62.lean` — `B ≅ B + B`** (`B` = `ExampleB`, binary streams over `Str = List Bool`).
  - The single-bit prepend `embBit b X = bX` (`= prepend [b] X`) with its API: `embBit_cone`,
    `embBit_inter`, `embBit_inter_ne`, `embBit_injective`, `memB_embBit`, and the inversion
    `memB_embBit_inv` (if `embBit b W ∈ B` then `W ∈ B` — this fixes the type-mismatch when feeding
    `x.sub` into the sum's `inter_mem`). `B_nonempty` (every `B`-nbhd is non-empty).
  - The neighbourhood-shape classifier `memB_cases`: any `B`-nbhd is the master `Σ*` (`Set.univ`),
    `embBit false X`, or `embBit true Y`. This three-way split drives the iso.
  - `BB := sum B B B_nonempty B_nonempty` (the project's `+`, Ex 3.18, over `Option (Str ⊕ Str)`).
    Inversions `sum_mem_inj0_inv`/`sum_mem_inj1_inv`/`sum_mem_nonempty`.
  - The filter maps `toBB : |B| → |BB|` (its `inter_mem` is a 9-case analysis over the three shapes ×
    three shapes) and `fromBB : |BB| → |B|`, mutual-inverse laws `fromBB_toBB`/`toBB_fromBB`, bundled
    as `bbEquiv : |B| ≃o |BB|`; capstone `B_domain_equation : B ≅ᴰ BB`.
- **`Example62C.lean` — `C ≅ {{Λ}} + C + C`** (`C` = `Example44`, finite+infinite binary streams;
  `{{Λ}} = unitSys`, the one-point domain `𝟙`, Exercise 3.15).
  - **The genuine three-way separated sum** `sum3 V₀ V₁ V₂ : NeighborhoodSystem (Option (α ⊕ β ⊕ γ))`
    — built fresh rather than nesting binary `sum`, because `(𝟙 + C) + C` would add a **spurious extra
    bottom** that breaks the iso (`C` has exactly three atoms above its bottom). Tags `t0`/`t1`/`t2`,
    injections `j0`/`j1`/`j2`, master `master3`, with the full disjointness/intersection API
    (`jX_inter_jX`, `jX_inter_jY`, `master3_inter_jX`, `eq_master3_of_subset`, …) and a 16-case
    `inter_mem`. Inversions `sum3_mem_j1_inv`/`sum3_mem_j2_inv`/`sum3_mem_nonempty`.
  - `C`-side helpers: `embBit` reused for `C` (`memC_embBit`/`memC_embBit_inv`, `embBit_singleton`),
    the `{Λ} = {[]}` terminator lemmas (`singleton_nil_inter_embBit`, `singleton_nil_ne_univ`,
    `singleton_nil_ne_embBit`), `C_nonempty`/`unitSys_nonempty`, and the four-way classifier
    `memC_cases`: any `C`-nbhd is the master `Σ*` (`Set.univ`), the terminator `{Λ}`, `embBit false X`,
    or `embBit true Y`.
  - `CC := sum3 unitSys C C …`; the filter maps `toCC : |C| → |CC|` (the `{Λ}` terminator goes to the
    unit summand `j0`, `0X`/`1X` to the two `C` copies `j1`/`j2`; `inter_mem` is the 16-case analysis)
    and `fromCC`, mutual-inverse laws `fromCC_toCC`/`toCC_fromCC`, bundled as `ccEquiv : |C| ≃o |CC|`;
    capstone `C_domain_equation : C ≅ᴰ CC`. **Pitfall:** `fromCC`'s `sub` field has goal `C.mem univ`,
    an `Or` (two constructors) — the anonymous `⟨…⟩` constructor fails; write `Or.inl ⟨[], cone_nil.symm⟩`.
- **`Example62A.lean` — the generalization `A ≅ Aⁿ + Aⁿ`** (Scott's "simple, yet interesting
  generalization of `B`", now done).
  - **`npow V n` — the flat `n`-fold product `Vⁿ`** over `Fin n × β`: neighbourhoods are the proper
    products `prodN X = ⋃_j {j}×X_j` (each `X j ∈ V`), with the API `prodN_inter`/`prodN_subset`/
    `prodN_injective`. `inter_mem` is **componentwise** — there are no tags to disambiguate, so unlike
    the sum it needs **no** non-emptiness. `npow_nonempty` (needs `0<n`, a coordinate to witness).
  - **Scott's domain `A` over `{0,1}*`**: the slot prefix `slotPre i j = i 1ʲ0` with the parsing/
    uniqueness lemmas `slot_list_inj`/`slotPre_inj` (the first `0` after the `1`-run pins down the slot),
    the tag-`i` tuple `embTuple i X = i ⋃_{j<n} 1ʲ0 X_j` and its API (`embTuple_inter`,
    `embTuple_inter_ne` for distinct tags, `embTuple_subset`, `embTuple_injective`, `embTuple_ne`).
    The inductive least family `MemA n` (`univ` ∣ `tuple i X`), `memA_nonempty`/`memA_inter`
    (`tag_eq_of_subset` recovers the tag from a non-empty witness) and the inversion `memA_tuple_inv`,
    packaged as `Asys n hn : NeighborhoodSystem Str` (needs `0<n`).
  - `Apow hn := npow (Asys n hn) n`, `AAsys hn := sum (Apow hn) (Apow hn) …`; the filter maps
    `toAA`/`fromAA` (9-case `inter_mem`, mirroring `Example61.toS`/`fromS`, with `embTuple false X ↦
    inj₀ (prodN X)`, `embTuple true Y ↦ inj₁ (prodN Y)`), mutual inverses, bundled as
    `aaEquiv : |A| ≃o |Aⁿ + Aⁿ|`; capstone `A_domain_equation : Asys n hn ≅ᴰ AAsys hn`. `n=1` recovers
    `B ≅ B+B`. **Fully choice-free** `[propext, Quot.sound]`.
- **`Example62Regular.lean` — eventually-periodic trees ↔ regular events** (Scott's closing aside).
  - Scott's total `+/−`-labelled `n`-ary trees are `Tree n = List (Fin n) → Bool`; `pos a = a []`, the
    subtree selector `select a σ` (Scott's `aσ`, with the recursion `aΛ=a`, `a(iσ)=(aᵢ)σ` and
    `select_append`), and the language `treeLang a = L_a = {σ ∣ pos(aσ)=true}`.
  - The bridge `treeLang_select : L_{aσ} = (treeLang a).leftQuotient σ` identifies the subtree reached
    by reading `σ` with the residual/left quotient ("`a` is the initial state, `aσ` the state after
    reading `σ`"), and `treeLang` is injective. Hence `EventuallyPeriodic a` (`{aσ}` finite) iff
    finitely many left quotients iff regular — `eventuallyPeriodic_iff_isRegular` +
    `isRegular_iff_exists_eventuallyPeriodic`, i.e. **Myhill–Nerode** via Mathlib's
    `Language.isRegular_iff_finite_range_leftQuotient`. (Prop-level; uses `Classical.choice` through
    Mathlib, which is fine for a regularity statement.)

### Lecture V §5 completed (most recent work)

All nine modules build alone, pass the audit, and are imported from `Domain.lean`; the full `Domain`
build is green. Lecture V is interpreted **semantically** inside the approximable-map framework
(closure properties + combinator identities), matching Scott's informal presentation rather than
building a separate λ-syntax.

- **Table 5.5** (`Table55.lean`) — the combinators as approximable maps with value equations: `P₀`,
  `P₁`, `pairC`, `diagC` (`= λx.⟨x,x⟩`), `swapC`, `evalC`, `constC`, `curryC`, `compC` (`= g∘f`,
  `compC_eq_comp`), `funpairC` (`= ⟨f,g⟩`), `fixC` (`= fixMap`). Internal uncurried helpers are
  `compMapTbl`/`funpairMapTbl` (**renamed** from `compMap`/`funpairMap` and `diag→diagC` to avoid
  clashes with `Exercise322.compMap` / `Exercise314.diag` at the `Domain.Neighborhood` namespace).
- **Theorem 5.1** (`Theorem51.lean`) — every typed λ-term denotes an approximable map: closure of the
  interpretation under variables/constants/tuples/application/abstraction.
- **Theorem 5.2** (`Theorem52.lean`) — the β/substitution rule as combinator identities (`beta`,
  `beta_tuple`, `beta_abs`) via `curry`/`eval`.
- **Proposition 5.3** (`Proposition53.lean`) — Bekić: least fixed point of `⟨τ,σ⟩` is
  `⟨!x.τ(x,!y.σ(x,y)), !y.σ(!x.τ(x,y),y)⟩` (`fixElement_paired_eq`).
- **Proposition 5.4** (`Proposition54.lean`) — `λx.!y.τ(x,y) = !g.λx.τ(x,g x)`
  (`pfix_eq_fixElement_recOp`).
- **Exercise 5.7** (`Exercise507.lean`) — multi-variable λ/application from one-variable forms:
  surjective pairing `⟨p₀ z,p₁ z⟩=z`, `uncurry_apply` / `app_two_args` (apply one arg at a time),
  `lam_two_vars` (= `curry`), and the three-variable generalisation `curry₃`.
- **Exercise 5.8** (`Exercise508.lean`) — **combinatory completeness** (bracket abstraction). The
  combinators `I = idMap`, `K = curry(p₀)`, `S = curry(curry(eval∘…))` as elements (`Ielem`/`Kelem`/
  `Selem`) with value equations `I(x)=x`, `K(c)(x)=c`, `S(F)(G)(x)=F(x)(G(x)`. An intrinsically-typed
  syntax `Poly X A` of λ-bodies with one free variable (`var`/`con`/`app`) and a variable-free
  combinator syntax `CL A` (`con`/`app` — application is the *only* mode of combination). `bracket :
  Poly X A → CL (X.arrow A)` is `[x]x=I`, `[x]c=K c`, `[x](f a)=S([x]f)([x]a)`, and the capstone
  `bracket_spec` proves `(bracket t).denote` denotes exactly `λx.t` — turning Table 5.5 around.
  Domains bundled as `Dom` over `Type` (covers `N`/`T`/`C`); fully choice-free (`[propext,
  Quot.sound]`). **Pitfall:** bundling universe-polymorphic systems (`NeighborhoodSystem`/
  `ApproximableMap`) into a `Type u`-polymorphic `Dom` produced unsolvable `max u u` universe
  constraints in the inductives — monomorphise `Dom` to `Type 0`. Also `rw [toElementMap_curry_apply]`
  can fail to match a `toApproxMap`-wrapped curry even when displayed identically (elaboration-order
  term differences); prove via `have h := toElementMap_curry_apply …; … ; exact h` (defeq) instead.
- **Exercise 5.9** (`Exercise509.lean`) — commuting `f∘g=g∘f` ⟹ least common fixed point;
  `f(⊥)=g(⊥) ⟹ fix f = fix g`; `fix f = fix f²`.
- **Exercise 5.11** (`Exercise511.lean`) — D<sup>∞</sup> = iterSys D as stacks: `head`/`tail`/`push` from
  `iterProdIso` with the stack laws (`head_push`, `tail_push`, `push_head_tail`); `diag` by the
  recursion `diag x = push(x,diag x)` with **all components `= x`** (`component_diag`); and `map` by
  recursion with `component_map` (`map(⟨fₙ⟩,x)ₙ = fₙ(x)`). **Fully choice-free** (`[propext,
  Quot.sound]`).
- **Exercise 5.12** (`Exercise512.lean`) — the `while` combinator as the least fixed point of
  `Wop(w) = λx.cond(p x, w(f x), x)`: recursion `whileMap_rec`, the three unfoldings
  `whileMap_true/false/bot`, and leastness `whileMap_least`. `cond` from Exercise 3.26, so the data
  inherits `Classical.choice` only through the truth domain `T` (Example 1.2), exactly as `cond` does.
- **Theorem 5.6** (`Theorem56.lean`) — recursive functions are λ-definable, formalised as the
  constructive heart of Scott's proof over `N` (Example 4.3) and `cond` (Exercise 3.26):
  - **strict starting functions** `λx.cond(zero x, x, x)`: `strictId` (`strictId_natElem`/`_bot`) and
    `strictProj₀` (strict in *both* args: `strictProj₀_natElem`/`_bot_left`/`_bot_right`);
  - **primitive recursion** `primRec f g = !k λx,y.cond(zero x, f y, g(pred x, y, k(pred x, y)))`
    with the scheme equations `primRec_zero` (`h̄(0,m)=f m`), `primRec_succ`
    (`h̄(n+1,m)=g(n,m,h̄(n,m))`), `primRec_bot` (strict);
  - **μ-scheme** `muRec f = !g λx,y.cond(zero(f(x,y)), x, g(succ x, y))`, `muMap = λy.ḡ(0,y)`, with
    `muRec_found`/`muRec_step`/`muRec_bot` and the **capstone** `muMap_eq_least` (least zero of
    `f(·,m)` ⟹ `μ(m) = n₀`, via the `muRec_climb` run-of-positives induction).
  Helper `T_bot_eq : T.bot = botElt` bridges `zeroMap_bot` (lands in `T.bot`) and `cond_bot` (phrased
  with `Example23.botElt`) since `bot` is not reducible. All `cond`-based maps inherit
  `Classical.choice` structurally from `T`, as `cond`/`zeroMap` already do.
- **Theorem 5.6 — the FULL meta-theorem** (`Theorem56Full.lean`, **done, no `sorry`**) — *every
  partial recursive function is λ-definable*, wired against Mathlib's arity-aware inductive predicates
  `Nat.Primrec'`/`Nat.Partrec'` (over `List.Vector ℕ n`), whose constructors are exactly Scott's
  generation grammar.
  - **Universal argument domain** `𝒩 := iterSys N` (`N`<sup>∞</sup>, Exercise 3.16): a `k`-ary function is one
    map `φ : 𝒩 → N` depending only on coordinates `0..k-1`. Builders `optElem`/`argElem`/`vecElem`,
    `ArgLike`, components through `push` (`component_push_zero/succ`).
  - **Spec** `LamDef φ f` (very strict): `defined` (value on totals), `undef` (`⊥` where `f↑`),
    `strict` (`⊥` on any arg-like input with a `⊥` in coords `0..n-1`). Strictifier
    `guard1`/`strictGuardN` (Scott's `cond(zero ·,·,·)` device) makes `strict` automatic via the
    **master constructor** `lamDef_of_inner`.
  - **Primrec' closure** `primrec_lamDef`: `zero`/`succ`/`get` (base), `lamDef_(prim)comp` via
    `tupleMap` + `mem_mOfFn`, and `lamDef_prec` (the `recOp`/`recMap` fixed point with `recMap_eval`
    by induction on the recursion variable).
  - **Partrec' closure** `partrec_lamDef`: `prim` reuses `primrec_lamDef`; `comp` reuses
    `lamDef_comp`; `rfind` is the μ-search `searchMap = fix(findOp)` started at counter `0` by
    `findMap`, with `searchMap_step_found/next`, the `searchMap_climb` capstone (least zero ⟹ value),
    and the **divergence** lemma `searchMap_diverge` — the one genuinely hard step: push evaluation
    through the directed sup `fix = ⊔ₙ Sⁿ(⊥)` (Thm 4.2(iii) `fixElement_eq_iSupDirected` +
    continuity `toElementMap_iSupDirected` via `evalAt`), then show every approximant is `⊥` along the
    no-zero trace (`iterVal_bot`, with helper `toApproxMap_bot`).
  - **Scott's 1-ary corollary** `partrec_one`: any partial recursive `h : ℕ →. ℕ` is denoted by a
    single `τ : N → N` correct on values, divergent where `h↑`, and strict (`oneArg` inject + the
    three `LamDef` clauses). Axiom profile `[propext, Classical.choice, Quot.sound]` — identical to the
    `Theorem56` baseline (choice enters only via the flat-domain `zeroMap`/`cond` primitives and
    Mathlib's `Nat.rfind`; all combinator *data* is choice-free).

- **Exercise 5.10** (`Exercise510.lean`) — the **smash product** `D₀⊗D₁`, the **strict function
  space** `D₀→⊥D₁`, and the **adjunction** between them. Three pieces:
  - `smash V₀ V₁ : NeighborhoodSystem (α ⊕ β)` — neighbourhoods are the master `Δ₀∪Δ₁` together with
    the *proper* product nbhds `X∪Y` (both factors `≠` their masters); the strict pairing
    `smashPair x y` collapses to `⊥` whenever a coordinate is `⊥` (`smashPair_eq_bot_iff`), realising
    Scott's bottom-gluing. Key `inter_mem` case: two proper nbhds with a consistency witness `Z`
    force `Z` proper (`inter_ne_master_*`).
  - `strictFun V₀ V₁ : NeighborhoodSystem (StrictMap V₀ V₁)` — tokens are the **strict** approximable
    maps (`IsStrict f ↔ f(⊥)=⊥`), nbhds are non-empty finite intersections of step sets `sstep`.
    `strictFunEquiv : |D₀→⊥D₁| ≃o StrictMap` is the strict mirror of Theorem 3.10; strictness is
    automatic because `[Δ₀,Y]` with `Y≠Δ₁` is empty, hence never a nbhd.
  - `smashCurryEquiv : StrictMap (smash V₀ V₁) V₂ ≃o StrictMap V₀ (strictFun V₁ V₂)` — the adjunction,
    via `smashCurryMap`/`smashUncurryMap` and the decisive computation `section_uncurry_rel`
    (`g(⟨x,y⟩⊗) = curry⊥(g)(x)(y)`, with boundary collapse handled by strictness). **Axioms:** all
    *data* (`smash`, `strictFun`, `smashCurryMap`, `smashUncurryMap`) and `strictFunEquiv` are
    choice-free `[propext, Quot.sound]` (the `⊥`-collapse uses one-directional choice-free lemmas
    `smashPair_bot_left`/`_right`); `Classical.choice` enters only the `smashCurryEquiv` *proof* via
    the genuinely-classical `X=Δ₀?`/`Y=Δ₁?` boundary case split.

- **Exercise 5.13** (`Exercise513.lean`) — the one-one pairing `num : N × N → N`. `num n m =
  (n+m)(n+m+1)/2 + m` (Cantor's diagonal enumeration via triangular numbers `tri`), verifying Scott's
  three recurrences (`num_zero_zero`, `num_succ_right`, `num_succ_left`) and one-one-ness
  (`num_injective`). In fact a **bijection** `numEquiv : ℕ × ℕ ≃ ℕ`, built **choice-free** from an
  explicit inverse `unnum` (iterate the diagonal walk `nextCell` from `(0,0)`; `numP_nextCell`,
  `numP_unnum`, then `unnum_numP` by injectivity). Power-set domains modelled as `(Set A, ⊆)` (per
  Exercise 4.17); the generic order-iso `setCongr : (α ≃ β) → (Set α ≃o Set β)` (choice-free — proves
  `map_rel_iff'` by hand to avoid the choice-y `Set.image_subset_image_iff`) gives the three
  isomorphisms `PN_orderIso_PNN` (`P N ≅ P(N×N)` via `numEquiv`), `PN_orderIso_prod`
  (`P N ≅ P N × P N` via `Equiv.natSumNatEquivNat` + Mathlib's `Set.sumEquiv`), and
  `PNN_orderIso_prod`. **Fully choice-free** (`[propext, Quot.sound]`). **Pitfall:**
  `Nat.even_mul_succ_self` is proved by `grind` (pulls `Classical.choice`) — proved `2 ∣ k(k+1)` by
  hand (`two_dvd_mul_succ`) to keep `tri`/`num`/`numEquiv` choice-free.

- **Exercise 5.14** (`Exercise514.lean`) — the Scott **`Pω` graph model**. The coding device is the
  **tag** `tag [n₀,…,n_{k-1}] m = [n₀+1,…,n_{k-1}+1,0,m]`, built from 5.13's `num`
  (`tag [] m = num 0 m`, `tag (n::ns) m = num (n+1) (tag ns m)`); it is a **bijection**
  `(List ℕ)×ℕ ≃ ℕ`: `tag_injective` (induction + `num_injective`) and `tag_surjective` (strong
  induction on the value, decreasing via `num_succ_left_gt : b < num (n+1) b`). With `entries ns`
  the finite set of list entries, `Fun u x = {m ∣ ∃ ns⊆x, tag ns m ∈ u}` and
  `Graph f = {tag ns m ∣ m ∈ f(entries ns)}`, and `IsApprox f` (monotone + finite-approximation):
  `Fun_Graph` (`fun∘graph = λf.f` for continuous `f`), `id_le_Graph_Fun` (`graph∘fun ⊇ λx.x`,
  genuinely `⊇`), and `Fun_isApprox` (every `Fun u` is approximable). `Pω = (Set ℕ, ⊆)` per 4.17/5.13.
  **Fully choice-free** (`[propext, Quot.sound]`). **Pitfall:** phrasing `IsApprox` with Mathlib's
  `Monotone f` (over `Set ℕ`) pulls `Classical.choice` — the `≤` resolves through the
  `CompleteLattice (Set _)` instance, whose construction uses choice — so *any* lemma merely
  *mentioning* such an `IsApprox` is choice-tainted. Phrase monotonicity as an explicit
  `∀ ⦃x x'⦄, x ⊆ x' → f x ⊆ f x'` (`⊆` = `Set.Subset`, defeq to `≤` but instance-free) to stay
  choice-free.
- **Exercise 5.15** (`Exercise515.lean`) — the **free-semigroup powerset + Arden's lemma**. Works in
  the **Kleene algebra** `(Set S, ∪, ·, ∅, {1})` for *any* monoid `S` (`open Pointwise`). `star z = ⋃ₙ zⁿ`
  is defined by an explicit recursion `kpow` (not `⋃`) with `star_eq : z* = Λ ∪ z·z*`. The engine is
  **Arden's lemma** `arden : lfpSet (λw. z·w ∪ v) = z*·v` (least solution of `w = z·w ∪ v`), proved
  *without* `Monotone`: the `⊆` half is `lfpSet_least` applied to the fixed point `star_mul_isFixed`,
  the `⊇` half is `star_mul_subset_prefixed` (induction `zⁿ·v ⊆ w₀` into the lfp intersection).
  **(1)** `part1`: `lfpSet (λz.{e}·z ∪ {e'}) = star{e}·{e'}`, with `mem_star_singleton` showing
  `star{e} = e* = {Λ,e,e²,…}`; specialised to `S = FreeMonoid Bool = {0,1}*` (`part1_freeMonoid`).
  **(2)** David Park: the explicit `parkX = (a ∪ b·a*·b)*·(c ∪ b·a*·d)`, `parkY = a*·(b·x₀ ∪ d)`
  *solve* the system (`park_solves`, via `star_mul_isFixed` + Kleene-algebra `simp`) and are *below*
  every solution (`park_least`, Gaussian elimination: solve the 2nd eq for `y` by `arden`, substitute,
  apply `arden` again) — i.e. the **least** solution. **Fully choice-free** (`[propext, Quot.sound]`).
  **Major pitfall (this toolchain):** Mathlib's `Set`-level `mul_assoc`/`Set.union_mul`/`Set.mul_union`/
  `Set.singleton_mul_singleton`, the order lemmas `Set.subset_iUnion`/`Set.iUnion_subset`, `Set`-power
  (`pow_succ'` on `Set`), `Submonoid.mem_powers_iff`, and `Monotone`-over-`Set` **all pull
  `Classical.choice`** (they route through `Set.image2`/`CompleteLattice` choice machinery). The
  *membership* iffs (`Set.mem_mul`/`mem_union`/`mem_one`/`mem_singleton_iff`) and *element-level*
  monoid lemmas are choice-free. So reprove the needed Kleene slice (`smul_assoc`/`sunion_mul`/
  `smul_union`) by membership `ext`, define `star` by recursion, and avoid `Monotone`/`⋃`-order
  lemmas/`Submonoid.powers` entirely.

**Lecture V exercises 5.7–5.16 are formalized — Lecture V is now COMPLETE end-to-end, including all of
Exercise 5.16's Thue–Morse `t` follow-up (see the next two subsections).** Exercise
5.16's `neg`/`merge`/`d` core (`Exercise516.lean`):

- **`tailMap : C → C`** (`tail(bx)=x`, `tail(Λ)=⊥`, Example 4.4's "left to the reader" item) via
  `Exercise419.liftC` (`tail_hcone`/`tail_hsing`).
- **`negMap : C → C`** (`neg(0x)=1·neg(x)`, `neg(1x)=0·neg(x)`) solved in closed form via `liftC`:
  `neg(σ⊥)=(flip σ)⊥`, `neg(σ)=flip σ` with `flip = List.map not`. Recursion eqs `neg_cons_false`/
  `neg_cons_true` (it is *the* solution) and the involution **`negMap_negMap : neg(neg x)=x` for all
  `x∈|C|`**. The continuity argument flagged in the old plan was **avoided**: instead of "agreement on
  the sup-dense basis + continuity", use Exercise 2.8's `eq_of_toElementMap_principal` — a map is
  determined by its values on the finite elements `σ⊥`, `σ`, so `neg∘neg=id` reduces to `flip∘flip=id`
  on those (helper `map_ext_C`). Much shorter than the directed-sup route.
- **`dMap : C → C`** (`d(0x)=00·d(x)`, etc.) via `liftC` (`d(σ)=double σ`).
- **`mergeMap : C × C → C`** (`merge(εx,δy)=ε·δ·merge(x,y)`) built **directly** as an `ApproximableMap
  (prod C C) C` from an explicit interleave value function `mergeVal` on tagged strings `(b,σ)`
  (`b`=total/partial flag), with output element `mergeElem`. **Scott's boundary trouble resolved**: the
  *only* monotone convention is `merge(Λ,y)=Λ`, `merge(⊥,y)=⊥`, and `merge(εx,y)=ε⊥` once `y` runs out
  (NOT `merge(εx,Λ)=Λ`, which breaks monotonicity since `⊥⊑Λ` but `ε⊥⋢Λ`). The crux is the
  monotonicity lemma `mergeVal_SLe`/`mergeElem_mono` (order `SLe` on tagged strings, `shapeElem_le_iff`).
  Value-on-pairs lemma `mergeMap_pair` (the product analogue of `liftC_strBot`), product
  extensionality `prodMap_ext` (via `prod_principal_pair`), recursion eq `mergeMap_cons` (all `x,y`),
  and **`mergeMap_diag : merge(x,x)=d(x)`** (only needs the *diagonal* principals — `mergeVal_diag`).
- **Choice:** all *data* (`tailMap`/`negMap`/`dMap`/`mergeMap`) is `[propext, Quot.sound]`; the map
  equalities pull `Classical.choice` only via `eq_of_toElementMap_principal` (the sanctioned exception).

### Exercise 5.16 follow-up — the Thue–Morse sequence `t` (DONE)

The whole Thue–Morse follow-up is now formalized across two modules. **No `sorry`; full `Domain` build
green (≈3064 jobs).**

**`Exercise516ThueMorse.lean` — Step 0 + property (a) (digit-sum mod 2).** Fully choice-free even at the
`Prop` level (`[propext, Quot.sound]`).
- **Step 0.** `tmOp = Φ = (consMap false).comp (mergeMap.comp (paired negMap tailMap))`,
  `tElt = t = tmOp.fixElement`, and the unfolding `tElt_unfold : 0·merge(neg t, tail t) = t`.
- **The bridge (the real idea).** The fixed-point approximants are exactly the iterates of the
  **Thue–Morse morphism** `expand` (`0 ↦ 01`, `1 ↦ 10`): `iterElem_succ_eq : Φᵏ⁺¹(⊥) = (expandᵏ[0])⊥`.
  The crux `tmOp_strBot_expand` shows `Φ` *is* `expand` on a partial element `(0σ)⊥` (computed from
  `mergeMap_pair` + the interleave lemma `weave_head`: `merge((flip σ)⊥,(tail σ)⊥) = (expand σ minus
  head)…`). The key shortcut that makes the bridge work: `step σ = false :: weave σ` equals `expand σ`
  **whenever `σ` starts with `0`**, and every approximant string does.
- **The parity bit-function** `tm n := (Nat.bits n).foldr xor false` (= ⊕ of the binary digits of `n`),
  with recurrences `tm_zero`, `tm_two_mul : tm(2n)=tm n`, `tm_two_mul_add_one : tm(2n+1)=¬tm n`
  (proved from Mathlib's `Nat.bit0_bits`/`bit1_bits`). The prefix `tmList n = (List.range n).map tm`,
  and `expand_iterate_eq : expandᵏ[0] = tmList(2ᵏ)` (via `expand_tmList : expand(tmList m)=tmList(2m)`,
  which is the even/odd recurrence in disguise).
- **Property (a)** = `tElt_mem_cone_iff : tElt.mem (cone σ) ↔ σ = tmList σ.length` — a string is a prefix
  of `t` *iff* it is the length-matched Thue–Morse parity prefix. So the `n`-th digit of `t` is `tm n`,
  Lambek's digit-sum-mod-2 description. Corollary `tElt_digit : (tmList n ++ [tm n])⊥ ⊑ t`.

**`Exercise516Overlap.lean` — property (b), overlap-freeness.** A self-contained combinatorics-on-words
theorem (no domain theory; `Prop`-level so `Classical.choice` is fine).
- `Overlap i p := 1 ≤ p ∧ ∀ k ≤ p, tm(i+k)=tm(i+p+k)` (a factor of length `2p+1` with period `p`).
- Base facts: `odd_of_consec_eq` (`tm x = tm(x+1) ⟹ x` odd, since `tm(2m)≠tm(2m+1)`) and
  `no_three_consec` (no three equal in a row — the period-1 case).
- **`no_overlap : ∀ i p, ¬ Overlap i p`** by strong induction on `p`: **even `p=2q`** contracts to a
  period-`q` overlap (subsample even/odd positions, `tm_two_mul`/`tm_two_mul_add_one`); **odd `p≥5`**
  forces a run of three equal symbols (relations at `k=0..4`); the corner **`p=3`** is a direct
  4-relation `Bool` contradiction; **`p=1`** is `no_three_consec`.
- Scott's literal cube form: `no_cube` (no `a·a·a` in `tm`, since a cube is an overlap) and
  **`tElt_cube_free : a ≠ [] → ¬ (u·a·a·a)⊥ ⊑ t`** (`t ≠ u·a·a·a·v`), via `tElt_mem_cone_iff` + the
  bit-reading lemma `tmList_getElem?` + the periodicity lemma `append_three_period`.

**Mathlib reality check (still accurate, mathlib `v4.30.0`):** there is **no** `ThueMorse` /
combinatorics-on-words development to reuse; `tm` was built on `Nat.bits` (`bit0_bits`/`bit1_bits`),
and property (b) was proved entirely from scratch.

**Available API (all verified, in `Exercise516.lean`):** `negMap`/`negMap_strBot`/`negMap_strElem`,
`tailMap`/`tailMap_strBot`/`tailMap_strElem`/`tailMap_consMap_strElem`, `mergeMap`/`mergeMap_cons`
(the recursion `merge(εx,δy)=ε·δ·merge(x,y)`)/`mergeMap_pair`/`mergeMap_diag`, `dMap`, `consMap`
(Example 4.4), `Theorem41.fixElement`/`toElementMap_fixElement`/`fixElement_eq_iSupDirected`, and the
`Example44`/`ExampleB` element/prefix lemmas. Thue–Morse-side API now in `Exercise516ThueMorse.lean`
(`tmOp`/`tElt`/`expand`/`tm`/`tmList`, `tElt_mem_cone_iff`) and `Exercise516Overlap.lean`
(`Overlap`/`no_overlap`/`no_cube`/`tElt_cube_free`).

<details><summary>Original 5.16 formalization plan (superseded — kept for reference)</summary>

### Exercise 5.16 — formalization plan (`neg`/`merge` on `C`; the Thue–Morse sequence)

**Statement.** On `C` (Example 4.4, finite+infinite binary sequences): give fixed-point definitions of
`neg : C → C` (`neg(0x)=1·neg(x)`, `neg(1x)=0·neg(x)`) and `merge : C × C → C`
(`merge(εx,δy)=ε·δ·merge(x,y)`); prove `neg(neg x)=x`, `merge(x,x)=d(x)` (`d` = the bit-doubling map of
4.4), and study `t = 0·merge(neg t, tail t)` (its `n`-th digit = digit-sum-of-`n`-in-binary mod 2 — the
**Thue–Morse** sequence, Lambek's suggestion — and `t` is overlap-free: `t ≠ u·a·a·a·v`, `a ≠ Λ`).
Suggested module `Exercise516.lean`, `import Domain.Neighborhood.Exercise419`.

**Available API (verified) — and a correction.** Unlike 5.14/5.15 this exercise lives entirely in the
**approximable-map / neighborhood framework** (no raw `Set` pointwise algebra), so the `Classical.choice`
taints discovered in 5.14/5.15 (`Set` `mul_assoc`/`union_mul`/`subset_iUnion`/`Monotone`-over-`Set`/
`Submonoid.powers`) **do not apply here**. What actually exists to reuse:
- `Exercise419.liftC V coneVal singVal hcone hsing : ApproximableMap C V` — the head-test combinator
  (a map out of `C` fixed by its values `coneVal σ` on `σ⊥` and `singVal σ` on `σ`); **choice-free
  data**, with computation rules `liftC_strBot`/`liftC_strElem`. The tests are `Exercise419.emptyMap`/
  `zeroMap`/`oneMap : ApproximableMap C T` (note: named `…Map`, **not** `empty`/`zero`/`one`).
- `Exercise326.cond V : ApproximableMap (prod T (prod V V)) V` — the conditional (instantiate at `V=C`);
  `condT_bot` (`cond(⊥,x,y)=⊥`) is in Exercise419.
- `Example44`: `C`, `consMap b : C → C` (`consMap_strElem`/`consMap_strBot`), `strElem`/`strBot`,
  `altElt`. `Exercise314.diag V : V → prod V V` (also `Table55.diagC`).
- **`tail` is NOT yet implemented** — Example 4.4/Exercise 4.19 only *note* it ("left to the reader").
  So **step 0** of 5.16 is to *build* `tail : C → C` (`tail(bσ)=σ`, `tail(Λ)=⊥`) via `liftC`
  (drop-the-head: `coneVal []`/`singVal [] = ⊥`, `coneVal (b::σ)=strBot σ`, `singVal (b::σ)=strElem σ`),
  with value lemmas `tail_consMap`/`tail_strElem`/`tail_strBot`/`tail_bot`.

**The combinators (the tractable core).**
- `tail` first (see step 0).
- `neg := fixElement` of `Nop(g) = λx. cond(zero x, cons true (g (tail x)), cons false (g (tail x)))`
  (flip the head bit, recurse on the tail) — build via `Theorem41.fixMap`/`fixElement` on
  `funSpace C C`. Computation rules `neg_cons0`/`neg_cons1` from `consMap`/`tail`/`cond` value eqs;
  `neg_bot`/`neg_strBot σ` for the partial elements.
- `merge` similarly as a fixed point on `funSpace (prod C C) C`, with the boundary choice for
  `merge(Λ, y)` made explicit (Scott flags it — pick `merge(Λ,y)=Λ`, i.e. strict in the first coord, or
  document the alternative).
- `d := merge ∘ diag` (so `merge(x,x)=d(x)` is then *definitional*) — or define `d` independently and
  prove the equation.

**`neg(neg x)=x` — the hard (continuity) step.** Prove first on finite approximants by induction on
`σ : Str`: `neg (neg (strBot σ)) = strBot σ` and `neg (neg (strElem σ)) = strElem σ` (head-bit flips
twice = identity; `tail`/`cons` bookkeeping). Then extend to **all** `x ∈ |C|` by continuity: every
element is the directed sup of its finite approximants (the cone/singleton principals), and
`neg ∘ neg` is continuous (`toElementMap` of a composite of approximable maps preserves
`iSupDirected`, cf. `Theorem41.fixElement_eq_iSupDirected` / `toElementMap_iSupDirected`), so agreement
on the sup-dense basis forces `neg∘neg = id` on `|C|`. This continuity/approximation argument is the
crux flagged in the status notes.

**The Thue–Morse properties (stretch / optional).** `t = 0·merge(neg t, tail t)` is a fixed point in
`|C|`; proving (a) `t`'s `n`-th digit `= (Nat.digits 2 n).sum % 2` and (b) overlap-freeness
(`t ≠ u·a·a·a·v`, `a ≠ Λ`, `u` finite) are real **combinatorics-on-words** theorems about Thue–Morse,
largely orthogonal to domain theory. Recommend landing `tail`/`neg`/`merge`/`neg∘neg=id`/`merge(x,x)=d(x)`
first as the "Pass" core, and treating (a)/(b) as a separate follow-up (they may warrant their own
module and a `Nat.digits`/word-combinatorics detour).

**Choice discipline.** `tail`/`neg`/`merge`/`d` *data* are choice-free except the structural
`Classical.choice` inherited from `cond`/`T` (Example 1.2), exactly as Exercise 4.19's `oneDef` and
Theorem 5.6's `cond`-based maps already are — not new choice (the `liftC`-built `tail` is itself
choice-free). Prefer the choice-free relational `ApproximableMap.ext` for map equalities; fall back to
`ext_of_toElementMap` (the standing allowed exception) only when comparing via `toElementMap`. Audit
each result with the scratch file as usual.

</details>

### Lecture IV §4 completed (most recent work)

- **Example 4.3** (`Example43.lean`) — the natural-number domain `N` (flat domain over `ℕ`, tokens
  `{n}`/`ℕ`, built by `ofNestedOrDisjoint`); total elements `natElem n = n̂`. One reusable strict-lift
  combinator `constLiftN V val : ApproximableMap N V` (sends `n̂ ↦ val n`, `⊥ ↦ ⊥`) with computation
  rules `constLiftN_natElem`/`constLiftN_bot`; from it `succMap`, `predMap` (codomain `N`,
  choice-free) and `zeroMap : N → T` with all the value equations (`succMap_natElem`,
  `predMap_natElem_succ`/`_zero`, `zeroMap_natElem_zero`/`_succ`, `*_bot`). **Pitfall:** `le_antisymm`
  on `Set` pulled `Classical.choice` — use `Set.Subset.antisymm` to stay choice-free.
- **Example 4.4** (`Example44.lean`) — the binary-sequence domain `C = {σΣ*} ∪ {{σ}}` over
  `Str = List Bool` (again `ofNestedOrDisjoint`, reusing `ExampleB.cone`/`prepend`); elements
  `strBot σ = σ⊥`, `strElem σ = σ`. The two successors `consMap b` (prepend a bit) with
  `consMap_strElem`/`consMap_strBot`, and the fixed-point element `altElt = a = 01a`
  (`((consMap false).comp (consMap true)).fixElement`, equation `altElt_eq`). `tail` and the tests
  `empty`/`zero`/`one : C → T` are Scott's own "left to the reader" (Exercise 4.19) — out of scope.
- **Definition 4.5 + Theorem 4.6** (`Theorem46.lean`) — `PeanoModel N` (zero, succ; `0 ≠ n⁺`,
  injective succ, induction). Theorem 4.6 `peano_models_isomorphic`: any two models are isomorphic.
  Scott's least-fixed-point relation `r` is realized as the inductive `Graph` (the least relation
  with `(0,□)` and closed under `(n,m) ↦ (n⁺,m#)`); `exists_unique_right`/`exists_unique_left`
  (induction 4.5(iii) + inversions from 4.5(i)/(ii)) show it is a one-one correspondence.
  **Pitfall:** inverting an indexed inductive whose indices are *abstract terms* (`P.zero`,
  `P.succ m`) — plain `cases` fails ("dependent elimination failed"); first
  `generalize hz : P.zero = z at h`, then `cases h`, recovering the equation `hz` to refute the
  impossible constructor. Everything is choice-free except the final packaging of the bijection
  `M ≃ N` (which must pull `Classical.choice` from a functional+total relation — a Dedekind/
  recursion theorem).

### Lecture IV §4 exercises completed (most recent work)

All six build alone and pass the audit; the full `Domain` build is green. Each is one module
`Domain/Neighborhood/Exercise<NN>.lean`, imported from `Domain.lean`.

- **Exercise 4.7** (`Exercise407.lean`) — *a fixed point above `a` when `a ⊑ f(a)`*. `iterFrom f a n
  = fⁿ(a)`; `fixAbove f ha = ⊔ₙ fⁿ(a)` (`iSupDirected`), with `fixAbove_isFixed` (continuity
  `toElementMap_iSupDirected`), `le_fixAbove`, `fixAbove_least`. **Pitfall (re)learned:**
  `monotone_nat_of_le_succ` pulls `Classical.choice` — for a choice-free *data* construction, prove
  the chain monotone by hand via induction on `n ≤ m` (`iterFrom_mono`, mirroring `rel_master_mono`).
  All `[propext, Quot.sound]`.
- **Exercise 4.8** (`Exercise408.lean`) — *fixed-point induction*. `fix_induction (P ⊥; P x→P(f x);
  closure under monotone-chain sups `supChain`) ⟹ P(fix f)`, via `fixElement_eq_supChain` +
  `iterElem_zero`/`iterElem_succ`. Corollary `fix_induction_eq` for `S={x∣a(x)=b(x)}`
  (`a(⊥)=b(⊥)`, `f∘a=a∘f`, `f∘b=b∘f` ⟹ `a(fix f)=b(fix f)`). Choice-free.
- **Exercise 4.10** (`Exercise410.lean`) — *the relativized domain `Dₐ`*. `relSystem a` (neighbourhoods
  = members of the filter `a`); `relIso : |Dₐ| ≃o {x∣x⊑a}` from `embed`/`restrict` (note the `V.mem X`
  guard in `embed`). When `f(a)=a`: `relMap f ha : Dₐ→Dₐ` restricts `f` (codomain check via
  `↑X⊑a ⟹ Y∈f(↑X)⊑f(a)=a`), agreeing by `relMap_toElementMap_embed`. `f'` over `D_{fix f}` has a
  **unique** fixed point (`relMap_unique_fixed`, from `fixElement_below_unique`). Choice-free.
- **Exercise 4.12** (`Exercise412.lean`) — *no maximum fixed point*. `I_T` on Example 1.2 has 3 fixed
  points; the two total ones are incomparable (`elemZero_not_le_elemOne` + converse) so
  `no_greatest_fixedPoint`. Classical only through Example 1.2's finite classification.
- **Exercise 4.18** (`Exercise418.lean`) — *the assertions about `N`*. `element_classification` (`|N|`
  is `⊥` + the numerals `n̂` — flat; classical), plus choice-free Peano facts `natElem_injective`,
  `succMap_injective`, `natElem_zero_ne_succ`/`zero_ne_succMap`. (`pred∘succ=id` already in
  `Example43`.)
- **Exercise 4.20** (`Exercise420.lean`) — *`fix(f∘g)=f(fix(g∘f))`*. The rolling rule
  `fixElement_comp_comm`, pure element-level algebra (`toElementMap_comp`, `toElementMap_fixElement`,
  `fixElement_le_of_toElementMap_le`, `toElementMap_mono`). Choice-free.

### Lecture III exercises completed (earlier work)

- **3.16** (`Exercise316.lean`) — the infinite iterate `𝒟`<sup>∞</sup> over `ℕ × Δ` via fibers + cofinite-`Δ`
  bound: `iterSys` is a system, iterSeqEquiv : |𝒟<sup>∞</sup>| ≃o (ℕ → |𝒟|), and 𝒟<sup>∞</sup> ≅ 𝒟 × 𝒟<sup>∞</sup>
  (`iter_isomorphic`); plus `component`, `ofSeq`, `projN`.
- **3.17** (`Exercise317.lean`) — `B` is a **retract** of `T`<sup>∞</sup>: section f : B → T<sup>∞</sup>, retraction
  g : T<sup>∞</sup> → B, with `gf_eq_id : g ∘ f = I_B`, fg_le_id : f ∘ g ⊑ I_{T<sup>∞</sup>}, and `f_injective`.
  Encoding `encSet σ` pins copy `i` to `bitNbhd σ[i]`; key lemma `prefix_of_encSet_subset`.
- **3.24(ii)** (`Exercise324Iter.lean`) — (𝒟₀→𝒟₁<sup>∞</sup>) ≅ (𝒟₀→𝒟₁)<sup>∞</sup> (`funIter_isomorphic`), via
  `mapOfSeq` and a local `piCongrOrderIso`.
- **3.24(iii)(iv)** (`Exercise324Distrib.lean`) — canonical **mapping relationships** (not isos, due
  to the separated-sum bottom): `copair : (D₀+D₁)→D₂` with section/retract packaging `copairProj`,
  plus the distribution map `distribMap` for (iii).
- **3.25** (`Exercise325.lean`) — open subsets of `|𝒟|` form a domain: `openIso` matches opens to
  approximable maps `𝒟 → 𝒪` (Sierpiński), then `funSpaceEquiv` (Thm 3.10) gives
  `opensReprIso : {U // IsOpen U} ≃o |𝒟 → 𝒪|`.
- **3.27** (`Exercise327.lean`) — alternate proof that `(D₀→D₁)` is a domain via the Ex 2.22
  representation theorem: the family `C` of graphs is closed under non-empty intersections
  (`meetMap`) and directed unions (`joinMap`), giving `funSpaceReprIso`.

*Note on choice for 3.26:* `cond`/`condSum`/`whichMap` report `Classical.choice` in their audit, but
this is inherited structurally from the truth domain `T = Example12.neighborhoodSystem` (whose own
`inter_mem` uses `fin_cases`/`simp`), exactly as `Example23.parityMap` does — not new choice.

---

## What's next: Lectures V–VIII (transcribed, NOT yet formalized)

The Goal Lists are in `arxiv.md`:

| Lecture | arxiv § | Rows | Theme | Source lines |
| ------- | ------- | ---- | ----- | ------------ |
| IV  | §4.2.IV   | 25 | Fixed points & recursion (**25/25 done — Lecture IV complete**) | 1647–2382 |
| V   | §4.2.V    | 16 | Typed λ-calculus, λ-definability of partial recursive (**16/16 formalized — Lecture V COMPLETE**, incl. 5.16's full Thue–Morse `t`: unfolding, digit-sum-mod-2, overlap-freeness) | 2383–3207 |
| VI  | §4.2.VI   | 29 | Domain equations, functors, initial `T`-algebras (**14/29: Example 6.1 (D<sup>§</sup>≅D+(D<sup>§</sup>×D<sup>§</sup>)), Example 6.2 (`B≅B+B`, `C≅{{Λ}}+C+C`, the generalization `A≅Aⁿ+Aⁿ`, eventually-periodic ↔ regular), Defs 6.3–6.5, Props 6.6–6.7, Def 6.8 (continuous on maps), Thm 6.9 (homomorphisms out of a fixed point), Def 6.10 (the subsystem relation `D◁E`), Prop 6.11 (the subsystems of `E` form a domain), Prop 6.12 (`D◁E` ⟹ a projection pair `i,j`), Def 6.13 (monotone / continuous on domains), Thm 6.14 **existence half** (the colimit `𝒟=⋃ₙTⁿ({Γ})`, `T(𝒟)=𝒟`, the algebra, homomorphism existence via 6.9, and the `⋃ₙρₙ=I_𝒟` chain; **uniqueness/initiality still TODO** — the `T(ρₙ)=ρₙ₊₁` HEq lemma) — categorical spine + concrete equations + the homomorphism-existence theorem + the subsystem relation + its domain structure + the projection pair + the domain-level functor continuity conditions + the iterated-functor colimit solution + Lemma 6.15 (projection pair ⟹ `D⊴E`, the converse of 6.12)**) | 3208–4188 |
| VII | §4.2.VII  | 24 | Computability in effectively given domains, power domain | 4189–4728 |
| VIII| §4.2.VIII | 27 | Retracts of the universal domain `U` | 4729–5336 |

**Done so far in §4 (ALL of Lecture IV):** Theorems 4.1/4.2 (`Theorem41.lean`), Examples 4.3/4.4
(`Example43.lean`, `Example44.lean`), Definition 4.5 + Theorem 4.6 (`Theorem46.lean`), and Exercises
**4.7–4.25** (`Exercise407/408/409/410/411/412/413/414/415/416/417/418/419/420/421/422/423/424/425.lean`).

**Most recent batch (4.9, 4.11, 4.13–4.17, 4.19):**
- **4.9** (`Exercise409.lean`) — `bigPsi = curry(eval∘⟨π_G,eval⟩) : E→E` (E=(D→D)→D), the operator
  `Ψ(θ)(f)=f(θ(f))` (`bigPsi_apply`); `fix_eq_fixElement_bigPsi : fix = fix(Ψ)` from `bigPsi_fix` +
  `bigPsi_least`. Operator data choice-free; equalities go through `ext_of_toElementMap`/`funSpaceEquiv`.
- **4.11** (`Exercise411.lean`) — Plotkin uniqueness. `fixElement_uniform` (fix satisfies (iii) via
  `h(fⁿ⊥)=fⁿ⊥` + directed-union preservation); `fix_unique_of_uniform` applies (iii) along the
  inclusion `inclMap : Dₐ↪D` and Ex 4.10's unique fixed point of `f'`. `inclMap` choice-free.
- **4.13** (`Exercise413.lean`) — `monoFix = ⋂{x∣f(x)⊑x}` (monotone least fixed point, choice-free);
  `exists_unique_nat_rec` / `nat_iterate_unique` (primitive recursion, kills the 4.1↔4.6 circularity).
- **4.14** (`Exercise414.lean`) — Knaster–Tarski `gfpSet`/`lfpSet` on `PA`, choice-free.
- **4.15** (`Exercise415.lean`) — `exists_maximal_fixedPoint` (Zorn on post-fixed points) +
  `exists_least_fixedPoint`. Classical.
- **4.16** (`Exercise416.lean`) — `f_sInf_le : f(⋂S)⊑⋂S`; `optimalFix` below/consistent with every
  fixed point in `S`. Data choice-free.
- **4.17** (`Exercise417.lean`) — `lfpSet_eq_closure` (least solution = `Submonoid.closure {a,b}`);
  `fixedPoint_not_unique` (`Set.univ` also fixed).
- **4.19** (`Exercise419.lean`) — Peano axioms for `{0,1}*`; reusable head-test `liftC`; `empty`/`zero`/
  `one : C→T`; `one_def_strElem`/`one_def_strBot` define `one` from `empty`,`zero`,`cond` (`oneDef`
  inherits only the accepted structural `Classical.choice` from `cond`/`T`).

**Most recent batch (4.21–4.25 — finishing Lecture IV):**
- **4.21** (`Exercise421.lean`) — `≤` as a *unique* fixed point. Operator `leOp` on `P(ℕ×ℕ)`;
  `leRel_isFixed` + `leOp_unique` (induction on the 2nd coordinate; the `(n,m⁺)` clause never yields
  a `0`, so the relation is pinned down). The 4.13(3) function `[m] = upSet m` (`upSet_zero`/`_succ`/
  `_unique`); the addition iso `addIso : ℕ ≃ {k//m≤k}` is `n ↦ m+n` (`addIso_apply`/`_zero`/`_succ`);
  multiplication `mulOp_lfp_eq_multiples` (least solution = multiples of `n`). Data choice-free.
- **4.22** (`Exercise422.lean`) — carving a full Peano model from a partial one. `nats = lfpSet
  ({0}∪x⁺)` in `P(N*)` (choice-free membership facts `zero_mem_nats`/`succ_mem_nats` proved *directly
  from the `lfpSet` def*, not via the monotone fixed point, to stay choice-free); `nats_induction`
  (minimality). `peanoSub : PeanoModel {m // m∈nats}` (all three axioms; (i)/(ii) inherited, (iii) by
  minimality) ⟹ `exists_peano_submodel`. Existence of `N*` = axiom of infinity (`natPeano`).
- **4.23** (`Exercise423.lean`) — Eilenberg's criterion. `f_unique_fixedPoint`: under the scheme
  `aₙ` ((i) `a₀=⊥`, (ii)+(iii) packaged as pointwise `IsLUB {aₙ(x)} x`, (iv) `aₙ₊₁∘f=aₙ₊₁∘f∘aₙ`),
  `fix f` is the unique fixed point. Hint realized as `approx_le : aₙ(x)⊑aₙ(fix)` by induction (uses
  (iv) twice). Choice-free.
- **4.24** (`Exercise424.lean`) — Schröder–Bernstein via Tarski. `sbSet = lfpSet ((A−g B)∪g(f X))`
  (choice-free); `sbFun` (= `f` on `sbSet`, `g⁻¹` off it) with `sbFun_injective`/`sbFun_surjective`
  ⟹ `schroeder_bernstein` + `schroeder_bernstein_equiv : A ≃ B`. Inherently classical.
- **4.25** (`Exercise425.lean`) — the unary domain `C₁` over `{1}* ≅ ℕ`. Nested-or-disjoint `C1`
  (tails `tail n = {m∣n≤m}` + singletons `{n}`); elements `oneElem n = 1ⁿ`, `oneBot n = 1ⁿ⊥`;
  successor `consMap` (shift, `consMap_oneElem`/`_oneBot`). Key point of the exercise: `C₁` is
  *non-flat* — the successor has an infinite fixed point infElt = 1<sup>∞</sup> (`infElt_eq`) absent from the
  flat `N` — so `C₁` (= unary analogue of `C₂`) is **not** analogous to `N`. Relating map
  `relateNToC1 : N → C₁` (`n̂ ↦ 1ⁿ`, strict) via `Example43.constLiftN`. Data choice-free.

Reusable API now also: `Exercise414.lfpSet`/`gfpSet` (Knaster–Tarski on `P A`), `Exercise413.monoFix`
+ `exists_unique_nat_rec`, `Theorem46.PeanoModel`, `Example43.constLiftN` (strict lift `N → V`).

**OCR anomalies to be aware of (documented in arxiv.md notes):**
- Lecture V: "Table 5.5" is a combinator table, not a numbered theorem.
- Lecture VI: `Example 6.1` (line 3214) is not bold-tagged; Scott labels **Lemma 6.15** (3952) but
  later calls it **Theorem 6.15** (4863) — same item, original inconsistency.
- Lecture VIII: item 8.4 is `EXAMPLES 8.4` (plural, line 4773); `7.9` has a double period (4461).

**Parallel track (not keyed to PRG-19 numbering):** `Domain/ContinuousLattice/*` already explores
fixed points / domain equations / inverse limits (`FunctionSpaceTower.lean`, `InverseLimits.lean`,
`Theorem212.lean`). Consult these for proof ideas before building Lecture IV/VI from scratch, but the
deliverable is a `Domain/Neighborhood/Exercise<NN>.lean`-style module keyed to PRG-19.

---

## Working rules (read first)

- **One module per exercise**, named `Domain/Neighborhood/Exercise<NN>.lean` (or `Exercise<NN>Foo.lean`
  for a second piece). Add `import Domain.Neighborhood.Exercise<NN>` to `Domain.lean` (keep imports in
  numeric order). For theorems/definitions you may use `Theorem<NN>.lean` / `Definition<NN>.lean`.
- **Goal:** `lake build Domain` green, **zero `sorry`**.
- **Choice discipline:** keep every *data construction* (a `NeighborhoodSystem`, `ApproximableMap`,
  `OrderIso`/`≃o`, `Equiv`) choice-free: `#print axioms <name>` must be `⊆ {propext, Quot.sound}`.
  Map/structure *equalities* and *uniqueness* lemmas may pull `Classical.choice` **only** through the
  project's established `ApproximableMap.ext_of_toElementMap` and the `leastMap`/`rel_interYs` case
  split. Do not introduce *new* choice in constructions.
- **Prefer relational extensionality** `ApproximableMap.ext` (compares `.rel`) — it is choice-free,
  unlike `ext_of_toElementMap`.
- After each module: build it alone, run the axiom audit, then update `arxiv.md` (flip the row from
  `—` to **Pass** with the module name) and the status section of this file.

### Commands

```bash
cd /home/catskills/Desktop/domain_theory
lake build Domain.Neighborhood.Exercise<NN>      # build one module
lake build Domain                                 # full build (≈3016 jobs)
```

Axiom audit (scratch file, delete after):

```bash
cat > scratch_axioms.lean <<'EOF'
import Domain.Neighborhood.Exercise<NN>
open Domain.Neighborhood
#print axioms <name1>
EOF
lake env lean scratch_axioms.lean ; rm -f scratch_axioms.lean
```

---

## Reusable API cheat-sheet

### Core (`Basic.lean`)
- `structure NeighborhoodSystem (α)`: `mem : Set α → Prop`, `master : Set α`, `master_mem`,
  `inter_mem : mem X → mem Y → mem Z → Z ⊆ X∩Y → mem (X∩Y)`, `sub_master`.
- `V.Element` = filters: `mem`, `up_mem`, `master_mem`, `inter_mem`; `Element.ext` (by `mem`),
  order `x ≤ y ⟺ x.mem ⊆ y.mem`.
- `V.principal (hX : V.mem X) : V.Element`, `V.bot`, `mem_bot`.
- `DomainIso V₀ V₁ := V₀.Element ≃o V₁.Element`; `Isomorphic V₀ V₁` (`V₀ ≅ᴰ V₁`).
  **Pitfall:** superscript `ᴰ` is fine in *notation* `≅ᴰ` but **cannot** appear in identifiers — use `D`.

### Approximable maps (`Approximable.lean`, `ApproximableExercises.lean`)
- `structure ApproximableMap V₀ V₁`: `rel`, `rel_dom`, `rel_cod`, `master_rel`, `inter_right`, `mono`.
  `ApproximableMap.ext` (relational), `ext_of_toElementMap`.
- `toElementMap f`, `rel_iff_mem_principal`, `idMap`, `comp`
  (`(A.comp B).rel x z = ∃ y, B.rel x y ∧ A.rel y z`), `toElementMap_comp`, `ofIso`.
- `ofMono`, `interMap`, `iSupMap`, `ApproximableMap₂` (curried two-arg), `toElementMap₂`.

### Products (`Product.lean`)
- `prod V₀ V₁ : NeighborhoodSystem (α ⊕ β)`; `prodNbhd X Y = Sum.inl '' X ∪ Sum.inr '' Y`.
- `pair x y`, `Element.fst`/`.snd`, `prodEquiv : (prod V₀ V₁).Element ≃o V₀.Element × V₁.Element`.
- `proj₀`/`proj₁`, `paired`, `constMap`, `toMap₂`/`ofMap₂`/`map₂Equiv`, `substitution_toElementMap`.

### Sum (`Exercise318.lean`, `Exercise319Sum.lean`)
- Tokens `Option (α ⊕ β)`: `Λ = none`, `il a = some (inl a)`, `ir b = some (inr b)`.
- `inj₀`/`inj₁`, membership simp lemmas, `sum V₀ V₁ (h₀) (h₁)` (non-emptiness drives `inter_mem`).
- `inMap₀`/`inMap₁`, `outMap₀`/`outMap₁`, `sumMap` (`f+g`).

### Function space (`FunctionSpace.lean`, `Exercise321.lean`, `Exercise328.lean`)
- `step X Y = {f | f.rel X Y}` (`[X,Y]`), `stepFun L`, `step_inter_right`, `step_subset`, `step_mem`.
- `funSpace V₀ V₁`, `funSpaceEquiv : (funSpace V₀ V₁).Element ≃o ApproximableMap V₀ V₁`.
- `interYs`, `leastMap L hL hcons`, `leastMap_rel`, `rel_interYs`, `leastMap_le`.
- `eval`/`evalMap`/`evalMap_apply`, `curry`/`uncurry`/`curryEquiv`, `le_iff_toElementMap_le`,
  pointwise-bdd/sup (`mapsBounded_iff_pointwiseBounded`, `sSupMaps`, `toElementMap_sSupMaps`).
- 3.15 helpers (`Exercise315.lean`): `unitSys` (terminal `𝟙`), `prodCongrOrderIso`,
  `prodUniqueOrderIso`, `uniqueProdOrderIso`. **mathlib lacks `OrderIso.prodCongr`/`prodUnique` for
  non-lex products** — use these.

### Infinite iterate (`Exercise316.lean`) — for Lecture IV/VI recursion work
- `iterSys V : NeighborhoodSystem (ℕ × α)` (the `𝒟`<sup>∞</sup>), `component n`, `ofSeq`, `projN`,
  `iterSeqEquiv : |iterSys V| ≃o (ℕ → V.Element)`, `iter_isomorphic : iterSys V ≅ᴰ prod V (iterSys V)`.

### Fixed points (`Theorem41.lean`) — Lecture IV §4, Theorems 4.1 & 4.2
- `f.iterMap n` (`fⁿ`, `f⁰=idMap`, f<sup>n+1</sup>=f.comp (fⁿ)); `iterMap_mono_map`, `iter_comm`,
  `rel_master_mono` (extend `Δ fⁿ X` chains).
- `f.fixElement : V.Element` (least fixed point `{X ∣ ∃ n, Δ fⁿ X}`); `toElementMap_fixElement`
  (`f(x)=x`), `fixElement_le_of_toElementMap_le` (least pre-fixed), `fixElement_mono`.
- `f.iterElem n = fⁿ(⊥)`, `iterElem_eq_iterate` (`= (f(·))^[n] ⊥`), `fixElement_eq_iSupDirected`.
- `fixMap V : ApproximableMap (funSpace V V) V` (the operator); key bridge
  `fixMap_toElementMap : fix.toElementMap φ = (toApproxMap φ).fixElement` (Scott's eq. ∗), proved via
  `exists_principal_iterMap` (a finite `f`-chain factors through one finite approximant `F ∈ φ`).
  Then `fixMap_fixed` (i), `fixMap_least` (ii), `fixMap_eq_iSup` (iii), `fixMap_unique`, and
  `fixMap_toElementMap_toFilter` (bridge to "for any `f`"). **All data choice-free**; `fixMap_unique`
  uses `Classical.choice` only via `ext_of_toElementMap`.

### Natural numbers / binary sequences / Peano (`Example43.lean`, `Example44.lean`, `Theorem46.lean`)
- **`Example43`**: `N : NeighborhoodSystem ℕ` (flat, `memN X ↔ X = univ ∨ ∃ n, X = {n}`); `natElem n`
  (`= n̂`), `mem_natElem_iff`, `N_bot_mem`. Strict-lift `constLiftN V val : ApproximableMap N V`
  with `constLiftN_natElem` (`f(n̂)=val n`) / `constLiftN_bot` (`f(⊥)=⊥`). Maps `succMap`,
  `predMap` (codomain `N`), `zeroMap : N → T` + value equations. Helpers `univ_ne_singleton`,
  `singleton_nat_inj`.
- **`Example44`**: `C : NeighborhoodSystem Str` (`memC X ↔ (∃σ,X=cone σ) ∨ (∃σ,X={σ})`); `strBot σ`
  (`σ⊥`), `strElem σ` (`σ`). Successors `consMap b` + `consMap_strBot`/`consMap_strElem`; fixed-point
  element `altElt` (`a=01a`, `altElt_eq`). Reuses `ExampleB.cone`/`prepend`; new `prepend_singleton`,
  `prepend_mono`, `memC_prepend`.
- **`Theorem46`**: `PeanoModel N` (`zero`, `succ`, `zero_ne_succ`, `succ_injective`, `induction`).
  `Graph` (least-fixed-point relation), `exists_unique_right`/`_left`, `peano_models_isomorphic`
  (Theorem 4.6). Inversions `graph_zero_right`/`graph_succ_right` use the `generalize`-then-`cases`
  idiom for abstract indices.

### Examples reused
- **`Example12.lean`** (`= Example23.T`): truth domain `T` over `Token = Fin 2`, `{master, zero={0},
  one={1}}`; `mem_iff`, `elemZero`/`elemOne`. `Example23`: `trueElt`, `falseElt`, `botElt`.
- **`ExampleB.lean`**: binary system `B` over `Str = List Bool`; `cone σ = {w | σ <+: w}`.
- **`Exercise222.lean`**: abstract representation theorem — `reprSystem`, `reprIso` (`≃o C`).
- **`Exercise213.lean`**: continuous ⟺ approximable, topology bridge for `|D|`.

---

## Pitfalls learned (don't relearn)
- **`monotone_nat_of_le_succ` pulls `Classical.choice`** (so does `Monotone` packaging through it).
  For a *choice-free* directed-sup data construction (e.g. `Exercise407.fixAbove`), prove the chain
  `n ≤ m ⟹ sₙ ⊑ sₘ` by hand: a one-step lemma `sₙ ⊑ sₙ₊₁` (induction on `n`) + induction on `n ≤ m`
  (`induction hnm with | refl | step`), exactly as `Theorem41.rel_master_mono` does. The
  directedness witness fed to `iSupDirected` is then `⟨max i j, …, …⟩`.
- **`ᴰ` in identifiers fails to parse.** Notation `≅ᴰ` is fine; names must use `D`.
- **`simpa`/`simp` can pull `Classical.choice`** into a construction. In choice-free lemmas use
  explicit term-mode or `simp only [...]`. `Set.image_mono`/`image_subset` were choice-y — unfold and
  `obtain ⟨a, ha, rfl⟩`.
- **`rw` needs syntactic match:** `(sum …).master` is defeq but not syntactically `sumMaster …`.
- **`OrderIso.prodCongr`/`prodUnique`/`uniqueProd` don't exist for plain `Prod`** — use `Exercise315`
  helpers. `OrderIso.prodAssoc` is `(A×B)×C ≃o A×(B×C)`; `.symm` for the other way.
- **Don't `choose` from existentials in a construction** (pulls choice). Carry witnesses as data.
- **`map_rel_iff'` may not reduce definitionally** — open the proof with an explicit
  `show <lhs map> ≤ <rhs map> ↔ a ≤ b` to force reduction (learned in `Exercise325`/`Exercise327`).
- **Subset/`≤` on `ApproximableMap`** needs `import Domain.Neighborhood.FunctionSpace` for the
  `PartialOrder` instance.

## Files map
- New work: `Domain/Neighborhood/Exercise<NN>.lean` (or `Theorem<NN>.lean`), imported from `Domain.lean`.
- Source statements: `sources/PRG19_vision.md` — Lecture IV from 1647, V 2383, VI 3208, VII 4189,
  VIII 4729 (exact per-item line numbers are in the arxiv.md Goal Lists §4.2.IV–VIII).
- Inventory/status: `arxiv.md` (§4.2.IV–VIII Goal Lists; flip `—` → **Pass** as you formalize).
- `arxiv_with_code.md` is generated from `arxiv.md` by `scripts/generate_arxiv_with_code.py`.
- This file: update the status section as you complete modules.

---

## Checkpoint 2026-06-21 — Theorem 6.9 (homomorphisms out of a fixed point) DONE

`Domain/Neighborhood/Theorem69.lean` formalizes **Theorem 6.9**: a continuous-on-maps functor `T`
with `D ≅ T(D)` admits a homomorphism `D → E` into any (strict) `T`-algebra `(E, k)`. Statement:
`nonempty_algHom_of_continuousOnMaps (T) (hT : ContinuousOnMaps T) (iso : Iso (T.obj D) D)
(B : TAlgebra T) (hk : IsStrict B.str) : Nonempty (AlgHom ⟨D, iso.hom⟩ B)`.

- **Construction.** The homomorphism is the least fixed point of `λh. k ∘ T(h) ∘ j` (`j = iso.inv`)
  on Scott's **strict** function space `strictFun D.sys E.sys`. The operator is `Op = homOp ∘ Φ`:
  `Φ` is Definition 6.8's witness (`λf.T(f)` approximable), `homOp` is the post/pre-composition
  `g ↦ k∘g∘j` (Ex 2.8 `ofMono`). The crux is the action lemma `homOp_apply_filter` — proved by
  collapsing to **single** step neighbourhoods `[X,Z]` through `strictFunEquiv` injectivity, so the
  finite factoring is just `N := [Y₁,Y₂]` (no list induction). `Op.fixElement` gives `h`; the
  fixed-point equation rearranges (`j∘i=I`, `comp_assoc`, `comp_idMap`) to the `AlgHom` square.
- **Strictness inputs.** `j` strict is *derived* (`isStrict_of_comp_eq_id`: a split iso preserves `⊥`);
  `k` strict is a hypothesis (`k` is a morphism of Scott's strict-map category). New general helpers:
  `isStrict_comp`, `isStrict_of_comp_eq_id`, `comp_mono_gen`, `toStrictMap_mono`, `toStrictFilter_mono`,
  `toStrictFilter_toStrictMap`.
- **Choice.** Conclusion is `Nonempty` (a `Prop`), so `Φ` is pulled from the `Prop`-valued
  `ContinuousOnMaps` by `Exists.elim` — `#print axioms` is `[propext, Quot.sound]` (and so are `homOp`,
  `homOpComp`). Wired into `Domain.lean`; full `lake build Domain` green (3077 jobs, zero `sorry`).
- **Next:** Definition 6.10 (`D ◁ E`), Props 6.11/6.12 (subsystem domain + projection pair), Def 6.13
  (monotone/continuous on domains), then the existence Theorem 6.14 — these need the new subsystem
  lattice / projection-pair machinery flagged earlier.

## Checkpoint 2026-06-21 — Definition 6.10 (the subsystem relation `D ◁ E`) DONE

`Domain/Neighborhood/Definition610.lean` formalizes **Definition 6.10**: the subdomain relation
`D ◁ E` between two neighbourhood systems over the same token type.

- **The relation.** `structure Subsystem (D E : NeighborhoodSystem α) : Prop` (notation `D ◁ E`,
  `infix:50`) with exactly Scott's three pieces: `master_eq : D.master = E.master` (same `Δ`),
  `sub : D.mem X → E.mem X` (`D ⊆ E`), and the essential `inter_closed : D.mem X → D.mem Y →
  E.mem (X∩Y) → D.mem (X∩Y)` ("consistency in `D` is the same as in `E`").
- **API (Scott's prose).** `Subsystem.refl`, `Subsystem.trans` (the `inter_closed` clause threads
  through `E`: `X,Y∈D⊆E`, `X∩Y∈F`, `E◁F` puts `X∩Y∈E`, `D◁E` puts `X∩Y∈D`), `Subsystem.antisymm`
  (`D◁E ∧ E◁D ⟹ D=E`), and **`Subsystem.subsystem_iff_subset_of_common`** — Scott's remark that once
  `D₀◁E` and `D₁◁E`, `D₀◁D₁ ↔ D₀⊆D₁` (the `←` direction's `inter_closed` routes `X∩Y∈D₁⊆E` back into
  `D₀` via `D₀◁E`). New general helper `NeighborhoodSystem.ext` (equal `mem` + equal `master` ⟹ equal
  system; the other three fields are `Prop`s).
- **Choice.** `refl` and `subsystem_iff_subset_of_common` depend on **no axioms**; `antisymm`/`ext`
  are `[propext, Quot.sound]`. Wired into `Domain.lean`; full `lake build Domain` green (3078 jobs,
  zero `sorry`).
- **Next:** Proposition 6.11 (the directed-union remark ⟹ `{D ∣ D ◁ E}` forms a domain), then
  Proposition 6.12 (the projection pair `i(x)={Y∈E ∣ ∃X∈x, X⊆Y}`, `j(y)=y∩D`, with `j∘i=I_D`,
  `i∘j⊆I_E`), Def 6.13 (monotone/continuous on domains), and the existence Theorem 6.14.

## Checkpoint 2026-06-21 — Proposition 6.11 (the subsystems of `E` form a domain) DONE

`Domain/Neighborhood/Proposition611.lean` formalizes **Proposition 6.11**: for a neighbourhood
system `E`, the set of subsystems `{D ∣ D ◁ E}`, ordered by the subdomain relation `◁`, *forms a
domain in its own right*. Capstone:
`subsystemReprIso (E) : {D // D ◁ E} ≃o (reprSystem (subFam E) …).Element`.

- **Route.** Scott derives this as a one-line corollary of the directed-union remark, "as a
  consequence of this remark". We use the project's **abstract representation theorem** (Exercise
  2.22, `Exercise222.reprIso`) — the same "forms a domain" route as Ex 3.25 (open sets) / Ex 3.27
  (function space). A subsystem `D ◁ E` is *determined by* its neighbourhood-family `{X ∣ D.mem X}`
  (by `NeighborhoodSystem.ext` + the standing `D.master = E.master`), so the poset is represented by
  `subFam E = {{X ∣ D.mem X} ∣ D ◁ E} ⊆ 𝒫(𝒫(Δ))` ordered by `⊆`.
- **`subIso : {D // D ◁ E} ≃o {𝒮 // 𝒮 ∈ subFam E}`.** Forward `D ↦ {X ∣ D.mem X}`, inverse `ofMem`
  (rebuild the system from `𝒮`: `mem := (· ∈ 𝒮)`, `master := E.master`, proofs from `subFam`
  membership). Order is preserved *and reflected* by Scott's remark
  `Subsystem.subsystem_iff_subset_of_common` (`◁` between subsystems-of-`E` = `⊆` of their
  neighbourhood-families). A `PartialOrder {D // D ◁ E}` instance (`subPartialOrder`) gives the
  `◁`-order (refl/trans/antisymm from Definition 6.10's API).
- **The two Exercise 2.22 hypotheses.** `subFam E` is closed under **non-empty intersections**
  (`subFam_sInter_mem`: the intersection subdomain `interSys`, nbhds = the *common* nbhds) and
  **directed unions** (`subFam_sUnion_mem`: the union subdomain `unionSys` — Scott's remark;
  directedness is used *exactly* to verify closure under consistent intersection). Both `interSys`
  and `unionSys` are full `NeighborhoodSystem`s with `master := E.master`; their inter-closure goes
  through `E.inter_mem` + `inter_closed` (so the `inter_mem` only needs `X,Y` in a *single* member,
  not the witness `Z` — `Z` only supplies `E.mem (X∩Y)`). Reusable extraction lemmas
  `subFam_master_mem`/`subFam_mem_E`/`subFam_inter_closed` (Definition 6.10's data out of `subFam`
  membership) keep the system proofs short.
- **Choice.** The combinatorial core is **choice-free**: `subFam`, `interSys`, `unionSys` depend on
  *no* axioms; `subFam_sInter_mem`/`subFam_sUnion_mem`/`subIso` on `[propext, Quot.sound]`. The final
  `subsystemReprIso` reports `[propext, Classical.choice, Quot.sound]`, the `Classical.choice`
  entering **solely** through Exercise 2.22's `reprIso` (the documented "for set theorists"
  exercise — `hne.choose` for the bottom token + finite-set induction), exactly as Ex 3.27. Wired
  into `Domain.lean`; full `lake build Domain` green (3079 jobs, zero `sorry`).
- **Next:** Proposition 6.12 (`D ◁ E` ⟹ the projection pair `i, j`), Def 6.13 (monotone/continuous
  on domains), then the existence Theorem 6.14.

## Checkpoint 2026-06-21 — Proposition 6.12 (`D ◁ E` ⟹ a projection pair) DONE

`Domain/Neighborhood/Proposition612.lean` formalizes **Proposition 6.12**: every subdomain relation
`D ◁ E` gives a *projection pair* `i : D → E`, `j : E → D` with `j ∘ i = I_D` and `i ∘ j ⊆ I_E`.
Scott leaves the proof "for the exercises"; done here directly at the level of the neighbourhood
relations (Definition 2.1), which keeps everything **choice-free**.

- **The two maps (in `namespace Subsystem`, taking `h : D ◁ E`).**
  - `Subsystem.inj h : ApproximableMap D E` — the relation `X i Y ↔ D.mem X ∧ E.mem Y ∧ X ⊆ Y`;
    element-wise `Subsystem.toElementMap_inj` gives Scott's `i(x) = {Y ∈ E ∣ ∃ X ∈ x, X ⊆ Y}`.
    `master_rel` uses `h.master_eq.subset` (same `Δ`).
  - `Subsystem.proj h : ApproximableMap E D` — the relation `Y j X ↔ E.mem Y ∧ D.mem X ∧ Y ⊆ X`;
    element-wise `Subsystem.toElementMap_proj` gives Scott's `j(y) = y ∩ D` (the `D`-neighbourhoods
    already in `y`; the `←` of the elementwise iff takes `Y := X`, the `→` uses `y.up_mem`). **The
    `inter_right` law of `proj` is the one place Definition 6.10's `inter_closed` is used:** from
    `X,X' ∈ D` and `Y ⊆ X∩X'` with `Y ∈ E`, `E.inter_mem` puts `X∩X' ∈ E`, then `h.inter_closed`
    returns `X∩X' ∈ D`.
- **The two laws.**
  - `Subsystem.proj_comp_inj : h.proj.comp h.inj = idMap D` — proved with the **choice-free**
    relational `ApproximableMap.ext` (+ `comp_rel`/`idMap_rel`). Forward: a round trip `X ⊆ Y ⊆ Z`
    collapses to `X ⊆ Z`. Backward: `X ⊆ Z` factors through the witness `Y := Z`.
  - `Subsystem.inj_comp_proj_le : h.inj.comp h.proj ≤ idMap E` — the `≤` is the `FunctionSpace`
    `PartialOrder` (inclusion of relations). A round trip `Y ⊆ X ⊆ Y'` through a common
    `D`-neighbourhood `X` is in particular `Y ⊆ Y'` on `E`; the reverse fails (not every consistent
    `E`-pair factors through `D`), so this is genuinely only `⊆`.
- **Bundled.** `Subsystem.ProjectionPair D E` (fields `inj`/`proj`/`proj_comp_inj`/
  `inj_comp_proj_le`) + `Subsystem.projectionPair h : ProjectionPair D E`, ready for Def 6.13 /
  Thm 6.14 reuse.
- **Choice.** All of `inj`/`proj`/`proj_comp_inj`/`inj_comp_proj_le`/`toElementMap_inj`/
  `toElementMap_proj`/`projectionPair` report `[propext, Quot.sound]`. Wired into `Domain.lean`;
  full `lake build Domain` green (3080 jobs, zero `sorry`).
- **Next:** Definition 6.13 (functors monotone / continuous *on domains*, phrased via this
  projection pair) and the existence **Theorem 6.14** (the iterated-functor colimit `𝒟 = ⋃ₙ Tⁿ({Γ})`
  with the `ρₙ = iₙ∘jₙ` chain `⋃ₙρₙ = I_𝒟` for homomorphism-uniqueness).

## Checkpoint 2026-06-21 — Definition 6.13 (functors monotone / continuous on domains) DONE

`Domain/Neighborhood/Definition613.lean` formalizes **Definition 6.13**: the two domain-level
continuity conditions on a functor `T : Endofunctor DomainObj` (Definition 6.3). Both are `Prop`
predicates; the identity functor satisfies both (`monotoneOnDomains_id`, `continuousOnDomains_id`),
witnessing non-vacuity. **Fully choice-free** `[propext, Quot.sound]`.

- **The carrier-type subtlety (the one design decision).** `D ◁ E` (Definition 6.10) requires `D, E`
  over the **same** token type `α`; the abstract `T` need not preserve token types, so
  `T.obj ⟨α,D⟩` and `T.obj ⟨α,E⟩` may have *different* carriers and "`T(D) ◁ T(E)`" does not even
  typecheck until the carriers are identified. So **monotone on domains** is packaged pointwise as
  `structure MonotoneAt T (h : D ◁ E)` with fields: `carrier_eq` (`(T.obj⟨α,E⟩).carrier =
  (T.obj⟨α,D⟩).carrier`), `sub` (the transported `(T.obj⟨α,D⟩).sys ◁ carrier_eq ▸ (T.obj⟨α,E⟩).sys`),
  and `inj_heq`/`proj_heq` (Scott's "the pair `i,j` is mapped to `T(i),T(j)`": the canonical 6.12
  pair `sub.inj`/`sub.proj` equals `T.map h.inj`/`T.map h.proj`, up to the carrier transport — hence
  `HEq`). `MonotoneOnDomains T := ∀ {α D E} (h : D ◁ E), MonotoneAt T h`.
- **Continuous on domains.** Scott's `λD.T(D) : {D∣D◁E} → {D'∣D'◁T(E)}` *approximable* is rendered,
  in the concrete neighbourhood framework, as **preservation of directed unions of subsystems**:
  `ContinuousOnDomains T := ∃ hmono : MonotoneOnDomains T, ∀ {α E} (ℱ : Set (NeighborhoodSystem α))
  (hℱ : ∀ D∈ℱ, D◁E) (hne) (hdir : DirectedOn (·◁·) ℱ) {U} (hUE : U◁E) (hU : U's family = ⋃ℱ's),
  targetFam T hmono hUE = ⋃ D∈ℱ, targetFam T hmono (hℱ D)`. Here `targetFam T hmono (h : D◁E) :
  Set (Set (T.obj⟨α,E⟩).carrier)` is the neighbourhood family of `T(D)` pushed to `T(E)`'s carrier
  via `MonotoneAt.carrier_eq` (a `▸`-transport of the test set; legal as data because it goes through
  `Eq.rec`'s large elimination, even though `MonotoneAt` is a `Prop`). This is exactly the continuity
  Scott invokes in 6.14: `T(⋃ₙ Tⁿ{Γ}) = ⋃ₙ T(Tⁿ⁺¹{Γ})`.
- **Identity-functor proofs.** `idEndofunctor` fixes objects/maps, so `carrier_eq := rfl`, `sub := h`,
  `inj_heq/proj_heq := HEq.rfl`; `targetFam (idEndofunctor) _ h` collapses (proof-irrelevance makes
  `carrier_eq` defeq `rfl`, so `carrier_eq ▸ Y = Y`) to the plain family `{Y∣D.mem Y}`, and
  continuity becomes the union hypothesis `hU` after `simp [targetFam, Set.mem_iUnion, exists_prop]`.
- **Pitfall.** `∃ D ∈ ℱ, P` desugars to `∃ D, D∈ℱ ∧ P` (an `And`), whereas the bounded union
  `⋃ D, ⋃ hD : D∈ℱ, …` unfolds (via `Set.mem_iUnion`) to `∃ D, ∃ _:D∈ℱ, …` (an `Exists`); bridge
  them with `exists_prop` in the simp set so the final `exact hU Y` unifies by defeq.
- **Choice.** `MonotoneOnDomains`/`MonotoneAt`/`targetFam`/`ContinuousOnDomains`/`monotoneOnDomains_id`/
  `continuousOnDomains_id` all report `[propext, Quot.sound]`. Wired into `Domain.lean`; full
  `lake build Domain` green (3081 jobs, zero `sorry`).
- **Next:** the existence **Theorem 6.14** (`{Γ}◁T({Γ})` ⟹ initial `T`-algebra via the iterated
  colimit `𝒟 = ⋃ₙ Tⁿ({Γ})`, `𝒟≅T(𝒟)` the identity, uniqueness via the `ρₙ = iₙ∘jₙ` chain
  `⋃ₙρₙ = I_𝒟`). It will *use* `MonotoneOnDomains` (to get each `Tⁿ{Γ} ◁ 𝒟` and `T(ρₙ)=ρₙ₊₁`) and
  `ContinuousOnDomains` (to get `T(𝒟)=𝒟`).

## Checkpoint 2026-06-21 — Theorem 6.14 EXISTENCE HALF done (`Theorem614.lean`)

`Domain/Neighborhood/Theorem614.lean` formalizes the **existence half** of Theorem 6.14: the
iterated-functor colimit `𝒟 = ⋃ₙ Tⁿ({Γ})` is a `T`-algebra with `T(𝒟) = 𝒟` (the iso is the
identity), and it admits a homomorphism into every strict `T`-algebra (Theorem 6.9). Full
`lake build Domain` green (3082 jobs, zero `sorry`); **all data choice-free** `[propext, Quot.sound]`
(audited: `colim`, `Dsys`, `colimIso`, `colimAlg`, `rho`, `iSupRho`, `iSupRho_eq_id`,
`Tcolim_eq_colim`, `nonempty_algHom`).

- **Hypotheses bundled in `Setup`**: `T` (an `Endofunctor DomainObj.{w}`), `hmaps : ContinuousOnMaps`,
  `hmono : MonotoneOnDomains` (kept separate from `hcont` so it is usable in **data**, choice-free,
  rather than `Exists.choose`-extracted), `hcont : ContinuousOnDomains`, token type `Tok`, generating
  system `Γ`, the carrier identification `ceq : (T.obj⟨Tok,Γ⟩).carrier = Tok`, and Scott's
  `hsub : Γ ◁ (ceq ▸ T(Γ).sys)` (`= {Γ}◁T({Γ})`).
- **The carrier-transport toolkit (the crux difficulty).** The abstract `T` need not preserve token
  types, so each `Tⁿ({Γ})` a priori lives over a different carrier. Four **choice-free** transport
  lemmas (all proved by `cases`/`subst` on a *generalized* carrier-eq variable `β = α`) tame this:
  `subsystem_cast` (transport `D◁E`), `rec_trans` (`e'▸(e▸x)=(e.trans e')▸x` for systems),
  `mem_cast` (`(e▸V).mem X ↔ V.mem (e.symm▸X)`), `set_rec_trans` (the `Set` analogue). **Key trick:**
  carrier-eq proofs into the *same* type are `Prop`s, so **proof irrelevance makes them defeq** —
  e.g. `carrier_eq.trans (Dceq s n)` and `colimCeq s` are interchangeable for free, which is what
  makes `Dsys_sub_Tcolim` close by a bare `exact h` after `rw [rec_trans]`.
- **The tower** `iter s n : Σ' S, Σ' (ceq : (T.obj⟨Tok,S⟩).carrier=Tok), S ◁ (ceq ▸ T(S).sys)`
  (structural recursion; the successor step feeds `chainₙ` to `s.hmono` to get the next `carrier_eq`
  and `MonotoneAt.sub`, transported by `subsystem_cast`+`rec_trans`). Accessors `Dsys`/`Dceq`/`Dchain`
  (`Dsys_succ : Dsys(n+1) = Dceq n ▸ T(Dsys n).sys` is `rfl`), `Dsys_master` (all over `Δ=Γ`),
  `chain_le` (`Tⁿ◁Tᵐ` for `n≤m`).
- **The colimit** `colim s` (`mem X := ∃n, (Dsys s n).mem X`; `inter_mem` lifts `X,Y,Z` to one level
  `max …` via `chain_le` then uses that level's own `inter_mem`). `Dsys_sub_colim` (`Tⁿ◁𝒟`),
  `colimCeq` (`(T.obj⟨Tok,𝒟⟩).carrier = Tok`, from `MonotoneAt` of `T⁰◁𝒟`), `Tcolim` (`=T(𝒟)` over
  `Tok`), `Dsys_sub_Tcolim` (`Tⁿ⁺¹◁T(𝒟)`), `Tcolim_master`, `colim_sub_Tcolim` (easy `𝒟⊆T(𝒟)`).
- **The continuity step** `Tcolim_sub_colim` (the only use of `ContinuousOnDomains`): apply the
  directed-union-preservation to `ℱ := Set.range (Dsys s)`, `E=U=𝒟`, `hUE = Subsystem.refl 𝒟`.
  Pull `X : Set Tok` back to `Y₀ := colimCeq.symm ▸ X` on `T(𝒟)`'s carrier; `X∈T(𝒟)` ⟺ `Y₀ ∈
  targetFam(refl)` (the `carrier_eq ▸ Y₀ = Y₀` step is defeq by proof irrelevance), rewrite by the
  continuity equation, and read off `∃n, (Dsys s (n+1)).mem X` (the `set_rec_trans` + proof-irrel
  identification `ceqₙ ▸ Y₀ = (Dceq s n).symm ▸ X` is the `key` step). Hence `Tcolim_eq_colim`
  (`T(𝒟)=𝒟` via `NeighborhoodSystem.ext` + mutual `⊆`), the `DomainObj` equality `colimObj_eq` (via
  `domainObj_ext`: carrier-eq + transported-sys-eq ⟹ `⟨c,σ⟩=⟨Tok,𝒟⟩`), the identity iso
  `colimIso : Iso (T.obj⟨Tok,𝒟⟩) ⟨Tok,𝒟⟩` (via `isoOfEq`, an object-equality ⟹ identity iso in any
  `Category`), and `colimAlg`.
- **Existence** `nonempty_algHom s B hk : Nonempty (AlgHom (colimAlg s) B)` for strict `B` — directly
  `nonempty_algHom_of_continuousOnMaps s.T s.hmaps (colimIso s) B hk` (Theorem 6.9). Capstone
  `exists_algebra_with_hom`.
- **The projection chain (uniqueness engine, ready)** `rho s n := iₙ.comp jₙ` (`iₙ,jₙ` from
  Prop 6.12 on `Dsys_sub_colim s n`), `rho_rel` (`X ρₙ Y ↔ ∃z∈Tⁿ, X⊆z⊆Y`), `rho_mono` (`ρₙ⊆ρₘ`),
  `iSupRho` (`⋃ₙρₙ` via `ApproximableMap.iSupMap`), and **`iSupRho_eq_id : ⋃ₙρₙ = I_𝒟`** (forward
  `X⊆z⊆Y⟹X⊆Y`; reverse factors the identity step `X⊆X⊆Y` through the level witnessing `X∈𝒟`).

**What remains for full 6.14 (uniqueness ⟹ initial `T`-algebra among strict algebras).** The gate is
`key_rho : rho s (n+1) = (colimIso s).hom ∘ T.map (rho s n) ∘ (colimIso s).inv` — i.e. Scott's
`T(ρₙ)=ρₙ₊₁`. This is a heavy **heterogeneous-equality** lemma: it must thread `MonotoneAt.inj_heq`/
`proj_heq` (`HEq (T.map iₙ) sub.inj`, `HEq (T.map jₙ) sub.proj`) through the carrier transports and
the `colimObj_eq` cast. The structural obstacle: `colimObj_eq : T.obj⟨Tok,𝒟⟩ = ⟨Tok,𝒟⟩` is between
**non-variable terms**, so it cannot be `subst`/`cases`-eliminated to collapse the casts. A promising
de-risk already noted: `Subsystem` is a `Prop` and `Subsystem.inj`/`proj`'s `rel` fields depend only
on `(D,E)` (not on the proof), so the *transported* `sub.inj` is **defeq** to `(Dsys_sub_colim s
(n+1)).inj = iₙ₊₁`; the remaining work is converting the `T.map iₙ` HEq into a map equality over
`Tok` (an `ApproximableMap` cast lemma). With `key_rho` in hand: for any strict `AlgHom g`,
`gₙ := g.hom ∘ rho s n` satisfies `g₀=⊥` (`g` strict, `ρ₀=⊥`-map) and `gₙ₊₁ = k∘T(gₙ)` (via `key_rho`
+ `g.comm` with `str=colimIso.hom`), so the sequence is `g`-independent; then
`g.hom = ⋃ₙ gₙ` (continuity of comp + `iSupRho_eq_id`) forces any two strict homomorphisms equal.
This re-uses no new external API beyond exposing the fixed-point sup, but the `key_rho` HEq surgery is
comparable in size to Theorem 6.9 itself — budget it as its own work item.

---

## Checkpoint — 2026-06-21: **Theorem 6.14 COMPLETE (uniqueness/initiality)**

`lake build Domain` green (3082 jobs, zero `sorry`). Axiom audit of `exists_unique_strict_algHom`,
`exists_algebra_with_hom`, `key_rho`, `gcomp_eq`, `algHom_unique` ⟹ all `[propext, Quot.sound]`
(**choice-free**, including the `Prop`-level uniqueness). The uniqueness half of 6.14 is finished;
`Theorem614.lean` now proves `𝒟 = ⋃ₙ Tⁿ({Γ})` is the **initial** `T`-algebra among strict algebras.

- **`key_rho : rho s (n+1) = (colimIso s).hom ⊚ T(ρₙ) ⊚ (colimIso s).inv`** (Scott's `T(ρₙ)=ρₙ₊₁`,
  conjugated by the structure iso). Built bottom-up from `HEq` surgery:
  - `transport_heq` (`HEq (e ▸ f) f` for an endo-`Hom` along an object-eq) and `isoOfEq_conj`
    (`(isoOfEq e).hom ⊚ f ⊚ (isoOfEq e).inv = e ▸ f`, by `cases e` + id-laws). Since `colimIso = isoOfEq
    colimObj_eq`, conjugation by it **is** the carrier-transport along `colimObj_eq`.
  - `map_comp_proj_heq` (**the crux**): given the *monotone-on-domains* data `Tmi/Tmj` HEq-equal to the
    Prop-6.12 pair `sub.inj/sub.proj` of the image subsystem, `Tmi ∘ Tmj` is HEq to `iₙ₊₁ ∘ jₙ₊₁`. Proof:
    `subst` the two carrier equalities (`cn : Pc=Tok`, `cc : Qc=Tok`), then `obtain rfl` the two
    transported-system equalities; **proof irrelevance** collapses the two `Subsystem` proofs so
    `eq_of_heq` turns the `HEq`s into `Tmi=sub.inj`, `Tmj=sub.proj` and `rw` closes.
  - `map_rho_heq : HEq (T(ρₙ)) ρₙ₊₁` = `T.map_comp` (`T(iₙ∘jₙ)=T(iₙ)∘T(jₙ)`) then `map_comp_proj_heq`
    fed with `s.hmono (Dsys_sub_colim s n)`'s `carrier_eq`/`sub`/`inj_heq`/`proj_heq`.
  - `key_rho` = `isoOfEq_conj` to turn the RHS into `colimObj_eq ▸ T(ρₙ)`, then `eq_of_heq` against
    `map_rho_heq.symm.trans (transport_heq …).symm`.
- **The `g`-independent recursion** (`g₀=⊥`, `gₙ₊₁=k∘T(gₙ)∘j`):
  - `rho_zero_rel` (needs **`{Γ}` one-point**, `hΓ : ∀X, Γ.mem X → X=Γ.master`): `ρ₀` relates `X` only
    to `𝒟.master`. `strict_rel_master` (`g.rel master Z ↔ Z=master` for strict `g`) then gives
    `gcomp_rho_zero_rel` and `gcomp_rho_zero_indep` (the base case, `g`-independent).
  - `gcomp_rho_succ : g∘ρₙ₊₁ = k ∘ T(g∘ρₙ) ∘ j` — proved as a `calc` **at the categorical `⊚` level**
    (so the implicit args are concrete `DomainObj`s, dodging the system-level `rw` fragility): `key_rho`,
    then `Category.assoc` term-mode steps + `g.comm` (`g∘str = k∘T(g)`, `str=colimIso.hom`) + `T.map_comp`.
    The two congruence steps use `congrArg (g.hom ⊚ ·)`/`congrArg (fun m => B.str ⊚ (m ⊚ inv))` so `calc`
    bridges by **defeq** rather than syntactic match.
  - `gcomp_rho_indep` (induction on `n`), `gcomp_eq` (`g = g∘I = g∘⋃ρₙ = ⋃(g∘ρₙ)` g-independent, via
    `iSupRho_eq_id` + `comp_idMap`), `algHom_ext` (commuting square is a `Prop`), `algHom_unique`.
- **Initiality**: `exists_unique_strict_algHom` — for every strict `T`-algebra `B`, a **unique** strict
  homomorphism `𝒟 → B`. Required strengthening `Theorem69.nonempty_algHom_of_continuousOnMaps` to return
  `Nonempty {g // IsStrict g.hom}` (the Theorem-6.9 homomorphism is in fact strict), threaded through
  `nonempty_strict_algHom`.
- **Lean gotcha logged**: `rw` with explicit args at the `ApproximableMap`/`NeighborhoodSystem` level
  repeatedly failed "did not find pattern" on **defeq-but-not-syntactic** implicits (`colim s` vs
  `(colimAlg s).carrier.sys` vs `(objColim s).sys`; abbrev `objColim` vs literal `⟨Tok,colim s⟩`). Fixes:
  work at the `⊚`/`Category.assoc` level (object-indexed, concrete), prefer `congrArg`/`calc` term-mode
  proofs (defeq-tolerant), and bind `comp_idMap`/etc. facts via a `have` with the *desired* `colim s`
  type (the `have` unifies by defeq) before rewriting.

---

## Checkpoint — 2026-06-21: **Lemma 6.15 COMPLETE (converse of Prop 6.12)**

`Domain/Neighborhood/Lemma615.lean` formalizes **Lemma 6.15**: a projection pair `i : D → E`,
`j : E → D` with `j ∘ i = I_D` and `i ∘ j ⊆ I_E` — for `D, E` over **possibly different** token
types — exhibits `D` as a subdomain of `E`. Capstone
`trianglelefteq_of_projectionPair (i) (j) (hji : j.comp i = idMap D) (hij : i.comp j ≤ idMap E) :
D ⊴ E`. Full `lake build Domain` green (3083 jobs, zero `sorry`); **fully choice-free**
`[propext, Quot.sound]` (audited: `trianglelefteq_of_projectionPair`, `Dprime`, `Dprime_subsystem`,
`dprimeEquiv`, `Subsystem.trianglelefteq`).

- **`Trianglelefteq` (`⊴`, `infix:50`).** Scott's `D ⊴ E := ∃ D' : NeighborhoodSystem β, D' ◁ E ∧
  (D ≅ᴰ D')` ("`D ≅ D'` for some `D' ◁ E`"). Note `◁` (Definition 6.10) needs the **same** token
  type, but `⊴` does not — the witness `D'` lives over `E`'s tokens `β`.
- **The whole proof is relational** (Definition 2.1 level) — *cleaner than Scott's* filter-by-filter
  argument. The one idea: the predicate `IsGen i j X Y := i.rel X Y ∧ j.rel Y X` ("`Y` generates
  `i(↑X)`", i.e. `i(↑X) = ↑Y`). Everything follows from:
  - **`isGen_exists`** (uses `hji`): every `X ∈ D` has a generator — apply `j∘i = I_D` to the identity
    relation `X I_D X` (`(j.comp i).rel X X` after `rw [hji]`, then `comp_rel` gives `∃Y, …`).
  - **`isGen_mono`** (uses `hji`) / **`isGen_mono'`** (uses `hij`): the correspondence is `⊆`-monotone
    both ways — `Z ⊆ W → X ⊆ X'` (widen `X i Z` to `X i W`, compose with `W j X'`, read off via
    `j∘i=I_D`) and the dual via `i∘j⊆I_E`. Their two-way use gives uniqueness in each argument
    (`isGen_fst_unique` needs only `hji`, `isGen_snd_unique` only `hij`).
  - **`isGen_inter`** (just `mono`/`inter_right` of `i,j`; the `E.mem (Y∩Y')` hypothesis licenses the
    `j.mono` steps): generators are closed under `∩`, generating `X∩X'`. **`D.mem (X∩X')` is obtained
    from `j.inter_right` — not from `D`'s own closure** (no need for a `D`-consistency witness).
- **`Dprime i j`** (`mem Y := ∃ X, IsGen i j X Y`, `master := E.master`): a nbhd system (condition
  (ii) from `isGen_inter`, deriving `E.mem (Y₁∩Y₂)` from the witness via `E.inter_mem`), with
  **`Dprime_subsystem : Dprime i j ◁ E`** whose `inter_closed` clause is *literally* `isGen_inter`.
- **`dprimeEquiv : D.Element ≃o (Dprime i j).Element`** = `toEl x = {Y ∣ ∃ X ∈ x, IsGen X Y}`,
  `ofEl y = {X ∣ ∃ Y ∈ y, IsGen X Y}`. Filter laws: `up_mem` of `toEl`/`ofEl` is `isGen_mono`/
  `isGen_mono'` (+`isGen_exists`); inverse laws + `map_rel_iff'` are generator uniqueness +
  existence. (`map_rel_iff'`: apply the `≤` positionally — the Element-order binder is named `X`, so
  `h (Y := …)` fails; use `h Y _`.)
- **`Subsystem.trianglelefteq : D ◁ E → D ⊴ E`** (take `D' = D`) — so together with the capstone,
  `D ⊴ E ↔ ∃` projection pair `D ⇄ E` (Prop 6.12 ⇆ Lemma 6.15).
- **Pitfall (re)learned:** a `theorem`/`def` binder list with an **unused implicit** (`{X Y X' Y' :
  Set α}` when only `X, X'` appear) leaves the spurious metavariable **unsolved** at every call site,
  surfacing as a stray `⊢ Set α` goal in the *caller*. Trim binders to exactly what the statement
  mentions.
- **Next:** **Theorem 6.16** (initial `T`-algebra `D` ⟹ `D ⊴ E` for any `E ≅ T(E)`) is the natural
  consumer: `h:D→E`, `g:E→D` from Theorem 6.9, `g∘h=I_D` by initiality (Thm 6.14), then `h∘g⊆I_E` via
  a `gₙ/hₙ` directed-sup argument, and finally `trianglelefteq_of_projectionPair`.

## Checkpoint — 2026-06-21 — Theorem 6.16 COMPLETE (`Theorem616.lean`, choice-free)

**`trianglelefteq_of_isInitial (T) (hT : ContinuousOnMaps T) (Dalg) (hinit : IsInitial Dalg) (E)
(isoE : Iso (T.obj E) E) : Dalg.carrier.sys ⊴ E.sys`** — Scott's Theorem 6.16 verbatim: an initial
`T`-algebra embeds as a subdomain of every solution of the domain equation. `lake build Domain` green,
zero `sorry`, axiom audit `[propext, Quot.sound]` (incl. the `Prop`-level initiality use).

How the proof goes (it reuses Theorem 6.9's machinery rather than re-deriving it):

- **Setup.** Lambek (Prop 6.7) gives `isoD := lambek Dalg hinit : T(D)≅D`, so `i=isoD.hom` (which is
  *defeq* `Dalg.str`), `j=isoD.inv`; `u=isoE.hom`, `v=isoE.inv`. All four maps are strict via
  `isStrict_of_comp_eq_id` applied to the split-iso laws. The Definition-6.8 witnesses `Φ` for the
  three strict hom-spaces `(D,E)`, `(E,D)`, `(E,E)` are `obtain`-ed from `hT` (choice-free since the
  goal `D ⊴ E` is a `Prop`).
- **`opStep` (the shared per-step lemma, top-level).** For Theorem 6.9's operator
  `Op = (homOp T D E j k)⊚Φ`, `toStrictMap(Op x).1 = k ∘ T(toStrictMap x).1 ∘ j`. Pure
  `homOp_apply_filter` + the defining property `hΦ` of `Φ`; no `T`-strictness needed (it comes from
  `hΦ`). This is the *only* place the 6.9 internals are touched.
- **Three approximant chains** `H,G,K n := (toStrictMap (Op·.iterElem n)).1`. Base
  `iterElem 0 = ⊥` (local `iterElem_zero`) + **`botStrict_rel`** (top-level: `⊥`'s strict map relates
  `X↦master`, i.e. it is the constant-`⊥` least map). Recursions `Hₙ₊₁=u∘T(Hₙ)∘j` etc. via
  `iterElem_succ`+`opStep`.
- **Ladder** `Hₙ∘Gₙ=Kₙ` by induction. Step rewrites with **`key`** (`(u∘a∘j)∘(i∘b∘v)=u∘(a∘b)∘v`,
  using `j∘i=I_{T(D)}`) then functoriality **`hTcomp`** (`T(p)∘T(q)=T(p∘q)`) + IH. Base by
  `ApproximableMap.ext` + the three `botStrict_rel`s.
- **`⊔`-decomposition** `*_fix_rel` (`fixElement_eq_iSupDirected`+`mem_iSupDirected`, `toStrictMap_rel`
  is `Iff.rfl`). Gives **`hgk : h∘g = k`** by diagonalizing the doubly-indexed directed family at
  `max m n` (monotonicity `H_mono`/`G_mono` from `iterElem_mono`+`toStrictMap_mono`).
- **`hk_le : k ≤ I_E`** because `I_E` is a fixed point of `Op_k` (`opStep`+`T.map_id`+`u∘v=I`, then
  `fixElement_le_of_toElementMap_le`).
- **`hgh_id : g∘h = I_D`** by initiality: `h,g` are `AlgHom`s (`h_comm`/`g_comm` derived from the
  fixed-point equations `h_fixeq`/`g_fixeq` via `toElementMap_fixElement`), so both `g∘h` and `id`
  equal `hinit.desc`.
- **Capstone:** `trianglelefteq_of_projectionPair h g hgh_id (le_of_eq_of_le hgk hk_le)` (Lemma 6.15).

**`⊚`-vs-`.comp` friction (the main time sink, as warned for 6.14):** `opStep`/`homOpComp` produce
`ApproximableMap.comp`, but the categorical laws (`Iso.hom_inv_id`, `T.map_id`, `T.map_comp`,
`AlgHom` comm) are stated with `⊚`/`Category.id`. These are *defeq* but `rw` needs syntactic matches.
Fix: keep everything in `.comp` and make **defeq `.comp`-form copies** of each law up front —
`hji`/`hvu`/`huv` (iso laws), `hmapid` (`T.map_id`), `hTcomp` (`T.map_comp`). `Iso.hom`/`Dalg.str`
agree by defeq (lambek's `hom := A.str`), so the `AlgHom` comm fields typecheck without conversion.

**Reusable bits worth remembering:** `opStep` and `botStrict_rel` are general (any `T`, `j`, `k`, `Φ`)
and would serve any future "run 6.9 and read off the approximant ladder" argument (e.g. Exercises
6.17–6.19).

## Checkpoint — 2026-06-21 — Exercise 6.17 scaffold COMPLETE (`Exercise617.lean`, choice-free; initiality pending)

**What is green now** (`lake build Domain.Neighborhood.Exercise617` ✓, axiom audit `[propext, Quot.sound]`
on `sumMap3`/`sumMap3_id`/`sumMap3_comp`/`isStrict_sumMap3`/`Tc`/`Calg`/`cStr`):

- **Bespoke `∅`-free category `StrictDomainObj`** (`carrier : Type w`, `sys`, `nonempty : ∀X, sys.mem X → X.Nonempty`),
  `instance : Category StrictDomainObj` with `Hom := StrictMap`, id/comp from Thm 2.5 +
  `isStrict_idMap`/`isStrict_comp`. **Why bespoke and not `DomainObj`:** the separated sum needs `∅∉𝒟`
  (an empty nbhd of one summand becomes a spurious consistency witness for the other tag, breaking
  `inter_mem`), so `T(X)=𝟙+X+X` is **not** a total endofunctor of `DomainObj` ⟹ **Theorem 6.14 cannot
  be invoked**. This is exactly Scott's "category of strict maps" (Ex 6.19). (User chose this "bespoke"
  route over rebuilding the whole 6.9/6.14 spine over the `∅`-free subcategory.)
- **Endofunctor `Tc = 𝟙+X+X`** complete: `tcObj` (reuses Example 6.2 `sum3 unitSys D D`, `∅`-free by
  `sum3_nonempty`); the three-way sum map **`sumMap3 = f₀+f₁+f₂`** (full `inter_right`/`mono`; shape
  lemmas `mem_subset_jᵢ_inv` say a nbhd `⊆ jᵢ` is itself a `jᵢ`-copy); `isStrict_sumMap3`; and
  **functoriality** `sumMap3_id`/`sumMap3_comp` ⟹ `Tc : Endofunctor StrictDomainObj` (`tcMapHom` =
  `I_𝟙 + f + f`). `@[simp] Tc_obj`/`Tc_map_val`.
- **`C` is a `Tc`-algebra** `Calg = ⟨Cobj, cStr⟩`: `Cobj = ⟨Str, C, C_nonempty⟩`,
  `cStr = ⟨ofIso ccEquiv.symm, isStrict_ofIso _⟩` (Example 6.2's iso `C ≅ 𝟙+C+C`, inverse direction;
  strict because an `OrderIso` preserves `⊥` — `isStrict_ofIso` via `isStrict_iff_apply_bot` +
  `toElementMap_ofIso` + `OrderIso.map_bot`).

**Remaining to finish Ex 6.17 (precise, validated plan):**

1. **`desc : C → E` (existence)** via **`Exercise419.liftC`** (build a map out of `C` from per-string
   values, NO function-space fixed point needed because the recursion is on the *finite* string σ, not
   on `desc`). For a `Tc`-algebra `B=(E,k)` (`k : 𝟙+E+E → E`):
   - `e := k.toElementMap term` (the terminator element; `term :=` element of `sum3 unitSys E E` gen'd by `j0 univ`).
   - `f_b y := k.toElementMap (inj_b y)` where `inj1,inj2 : E.Element → (sum3 unitSys E E).Element` are
     the canonical sum injections (NEW: build them like Example62C `toCC`, ~40-60 lines each;
     `inj1(y).mem W := W=master3 ∨ ∃Y, W=j1 Y ∧ y.mem Y`).
   - `singVal [] = e`, `singVal (b::σ) = f_b (singVal σ)`; `coneVal [] = E.bot`, `coneVal (b::σ) = f_b (coneVal σ)`.
   - `hcone`/`hsing` monotonicity by `peano_induction` on σ using `f_b` monotone (`toElementMap` mono)
     + `coneVal σ ≤ singVal σ`.
2. **AlgHom square** `desc ⊚ cStr = k ⊚ Tc(desc)`. Prove on **elements**: every `s ∈ |𝟙+C+C|` is
   `toCC x` (ccEquiv onto), and `cStr.toElementMap (toCC x) = fromCC(toCC x) = x`, so the square ⟺
   **`desc(x) = k(Tc(desc)(toCC x))` for all `x∈|C|`** (★). Case on `x` via `memC_cases`:
   - `x=Λ̂`: `toCC Λ̂ = term`; `sumMap3 id desc desc` fixes the unit copy ⟹ `term`; `k term = e = desc Λ̂`.
   - `x=0·y` (`= consMap false y`): **`toCC (consMap false y) = inj1 y`** (key lemma:
     `toCC(0y).mem(j1 X) ↔ (0y).mem(0X) ↔ y.mem X`); `sumMap3 id desc desc (inj1 y) = inj1 (desc y)`;
     `k(inj1(desc y)) = f₀(desc y) = desc(0y)`. Likewise `1·y` with `inj2`/`f₁`.
   - NEW supporting lemmas: `toCC_consMap_eq_inj` and `sumMap3` toElementMap action on `term`/`inj_b`.
3. **Uniqueness** ⟹ `IsInitial Calg`: any `AlgHom h'` satisfies the same recursion equations
   (`h'(Λ)=e`, `h'(b·x)=f_b(h' x)` — read off the square the same way), so `h'` agrees with `desc` on
   every finite generator `strElem σ`/`strBot σ` by `peano_induction`, hence `h'=desc` by
   `map_ext_C` / `eq_of_toElementMap_principal` (Ex 2.8; cf. `Exercise516` neg∘neg).
4. **Generalization `Cₙ ≅ 𝟙 + Cₙⁿ + Cₙⁿ`** matching `A ≅ Aⁿ + Aⁿ` (Example 6.2's `A`): same recipe with
   an `n`-fold sum/product; the algebras are domains with a point + `2n` (or `n`-ary) strict ops.
5. Wire is **already done** (`Domain.lean` imports `Exercise617`); on completion run the axiom audit on
   `desc`/`IsInitial Calg` and flip `arxiv.md` 6.17 row to **Pass**.

**Reusables for step 1–2:** `liftC`/`liftC_strBot`/`liftC_strElem` (`Exercise419`), `toElementMap_ofIso`,
`Example62C.{toCC,fromCC,ccEquiv, toCC_mem_j0/j1/j2, fromCC_mem_nil/embF/embT, memC_cases}`,
`Example44.{consMap, strElem, strBot, embBit_*}`.

---

## Checkpoint — Exercise 6.17 part 1 (initiality) COMPLETE (2026-06-21)

`Exercise617.lean` builds green, zero `sorry`. **`CisInitial : IsInitial Calg`** — `C` is the initial
`T`-algebra for `T(X)=𝟙+X+X`. The plan above was executed with one simplification: the AlgHom square is
*not* proved by `memC_cases` on a general element (that fails for infinite `x`), but by showing
`descMap = M` for `M := (k ⊚ T(desc)) ⊚ ofIso ccEquiv` via **`map_ext_C`** (agreement on every finite
`strBot σ`/`strElem σ`), which then yields the square by iso-cancellation.

**What was built (in `Exercise617.lean`, namespace `Domain.Neighborhood` / section `Initial`):**
- **Separated-sum element injections** `sinj0/sinj1/sinj2 : Vᵢ.Element → (sum3 …).Element` with
  `sinjᵢ_mem_jᵢ` (membership iff), monotonicity `sinj1_mono`/`sinj2_mono`, and the **action of the
  three-way sum map** `sumMap3_sinj0/1/2` (`(f₀+f₁+f₂)(injᵢ x) = injᵢ(fᵢ x)`).
- **C-side bridges** (`namespace Example62C`): `ccEquiv_apply` (`ccEquiv x = toCC x`),
  `consMap_mem_embBit` (`(b·z).mem(bX) ↔ z.mem X`), the cross-tag/terminator emptiness lemmas, and the
  headline **`toCC_consMap : toCC(b·z) = condᵇ (inj₂ z)(inj₁ z)`** and **`toCC_strElem_nil : toCC Λ̂ = inj₀ ⊤`**.
- **`descMap : C→E`** via `liftC` with `descVal z` (head-recursion `z`, `b::σ ↦ f_b(descVal z σ)`),
  `e := descE = k(inj₀ ⊤)`, `f_b := descF b = k∘cond_b(inj₂,inj₁)`. Monotonicity helpers `descF_mono`,
  `descVal_mono_z`, `descVal_append` ⟹ `hcone`/`hsing`. `descMap_strict` (uses `C_bot_eq_strBot_nil`).
- **`genKey`/`genKey0`/`genKeyBot`** — the one-step computation `k(T(g)(toCC(b·w))) = f_b(g w)` (and the
  `Λ̂`/`⊥` analogues) for an arbitrary `g`; `ccEquiv_symm_comp`/`ccEquiv_comp_symm` (iso cancellation).
- **`rec_determines`** (any `g` solving the recursion `g = (k⊚T(g))⊚ofIso ccEquiv` equals `descMap`, by
  induction on σ + `genKey` + `map_ext_C`), **`descMap_satisfiesRec`**, **`descComm`** (the square),
  **`descAlgHom`**, **`descAlgHom_uniq`**, and **`CisInitial`**.

**The algebras (answer to part 1):** a `Tc`-algebra `k:𝟙+E+E→E` is exactly a domain `E` with a point
`e` and two strict unary ops `f₀,f₁`; `C` is initial since every finite/infinite binary string is the
unique `f`-word, `desc(b₀b₁… ) = f_{b₀}(f_{b₁}(…))` over `e`/`⊥`.

**Axiom audit:** data is choice-free — `descMap`, `Calg`, `Tc`, `sumMap3`, `sinjᵢ` are
`[propext, Quot.sound]`. The Prop obligations `descComm`, `descAlgHom_uniq`, `CisInitial` are
`[propext, Classical.choice, Quot.sound]`; the choice comes **only** from the project's foundational
map-extensionality `ApproximableMap.ext_of_toElementMap`/`eq_of_toElementMap_principal` (choice-bound
because nbhd-membership is not decidable), shared by every map-equality result in the repo — genuinely
unavoidable, permitted by the choice rule for Prop-level results.

**Gotcha for future edits:** `rw` of lemmas whose statement carries explicit `sum3`/`sumMap3` nonempty
proof args (`genKey`, `ccEquiv_symm_comp`) often fails to match syntactically even when display-equal;
use `exact`/`erw` (defeq-aware) instead — see the `exact h.symm` / `erw [ccEquiv_symm_comp]` sites.

**Remaining (part 2):** generalization `Cₙ` (n-ary sequences `Cₙ ≅ 𝟙 + n·Cₙ`; algebras = point + `n`
strict unary ops). Conceptually answered; Lean formalization deferred pending a scope decision (it
duplicates the binary development for arbitrary `n`).

## Checkpoint — Exercise 6.17 part 2 (generalization to `Cₙ`) COMPLETE (2026-06-21)

`Exercise617Gen.lean` builds green (`lake build Domain` ✓, ≈3086 jobs), zero `sorry`. The binary
Example 6.2 development is generalized over an **arbitrary alphabet** `A : Type` `[DecidableEq A]`,
answering part 2 in full Lean.

**What was built (in `Exercise617Gen.lean`, namespace `Domain.Neighborhood.Exercise617Gen`):**
- **Generic domain.** `Strn A := List A`; cones `coneN`/`memCn`; `Cn A : NeighborhoodSystem (Strn A)`
  of finite-or-infinite `A`-sequences; `strBotN`/`strElemN` elements; `prependN`; and the prepend map
  `consMapN a : Cn A → Cn A`. (Direct generalization of Example 6.2's `Bool`-indexed `C`/`consMap`.)
- **`A`-indexed separated sum.** `SigTok A β := Option (Unit ⊕ A×β)` token type with injections
  `jU`/`jc a`, master `masterSig`, system **`sumSig A V h`** (`h : ∀ X, V.mem X → X.Nonempty`, since the
  separated sum needs `∅∉𝒟`), element-injections `sinjU`/`sinjC a`, and the functorial map
  **`sumMapSig f = id + Σ_a f`** with `isStrict_sumMapSig`, `sumMapSig_id`/`_comp`. This packages as the
  endofunctor **`Tsig(X) = 𝟙 + Σ_{a:A} X : Endofunctor StrictDomainObj`** on the same bespoke `∅`-free
  category reused from part 1.
- **Domain equation.** `embA a` (generic `embBit`), `toCC`/`fromCC`, and the order-iso
  **`ccEquiv : (Cn A).Element ≃o (CCn A).Element`** with `CCn A = sumSig A (Cn A) Cn_nonempty`; packaged
  as `Cn_domain_equation : Cn A ≅ᴰ CCn A` and the algebra `Cnalg = (Cnobj, cnStr)`,
  `cnStr = ofIso ccEquiv.symm`. `[Inhabited A]` supplies the non-emptiness witnesses
  (`singleton_nil_ne_univ`, `embA_ne`) that were concrete (`true ≠ false`) in the binary case.
- **Initiality.** Same recursion skeleton as part 1: `liftCn` (choice-free head-recursion
  `φ(Λ)=e`, `φ(a·x)=f_a(φ x)`, `f_a = k∘sinjC a`), `map_ext_Cn` (C-extensionality), one-step `genKey`,
  `rec_determines`, giving `descAlgHom : AlgHom Cnalg B` and `descAlgHom_uniq`, hence
  **`CnisInitial : IsInitial Cnalg`**.
- **Instantiation.** `A := Fin (n+1)` recovers Scott's `Cₙ`: `Cfin_domain_equation`
  (`Cn (Fin (n+1)) ≅ᴰ 𝟙 + (n+1)·Cₙ`) and `CfinIsInitial`. `n=1` (`Fin 2 ≃ Bool`) reproduces Example 6.2.

**The algebras (part-2 answer):** a `Tsig`-algebra `k : 𝟙 + Σ_a E → E` is a domain `E` with a
distinguished point `e = k(jU)` and **`A`-many strict unary operations** `f_a = k∘sinjC a`; `Cn A` is
initial because every finite/infinite `A`-sequence is the unique `f`-word over `e`/`⊥`.

**Axioms:** data (`Cn`, `sumSig`, `sumMapSig`, `Tsig`, `ccEquiv`, `Cnalg`, `Cn_domain_equation`) is
`[propext, Quot.sound]` (choice-free); the Prop-level `descAlgHom`/`CnisInitial`/`CfinIsInitial`
inherit `Classical.choice` only from the foundational map-extensionality, exactly as in part 1.

## Checkpoint — Exercise 6.18 (`𝒟^∞` as an initial algebra) COMPLETE (2026-06-21)

`Domain/Neighborhood/Exercise618.lean` builds green (`lake build Domain` ✓, 3087 jobs), zero `sorry`,
wired into `Domain.lean`. Exercise 6.18 asks to discuss `𝒟^∞` (Exercise 3.16) **as an initial algebra**
and **as a solution of the domain equation `𝒟^∞ ≅ 𝒟 × 𝒟^∞`**.

**Domain-equation half** is already Exercise 3.16 (`iter_isomorphic`, `iterProdIso`). This module
supplies the **initial-algebra half** for the product endofunctor `T(X) = 𝒟 × X` over a fixed `∅`-free
domain `𝒟`, in the bespoke `StrictDomainObj` category (Exercise 6.17), where `IsInitial` is Scott's
universal property among strict algebras. (Theorem 6.14's same-carrier colimit tower does **not**
apply: `T(X)=𝒟×X` grows the token set `ℕ×Δ`, so `𝒟^∞` is built directly à la Exercise 3.16.)

**What was built (namespace `Domain.Neighborhood.Exercise618`):**
- **Element helpers.** `prod_nonempty`/`iterSys_nonempty` (`∅`-freeness preserved); the head/tail
  reading `iterProdIso_apply` and its inverse "cons" `iterProdIso_symm_pair` (`consSeq`); bottom
  computations `iterBot_eq`, `component_bot`, `pair_bot`.
- **Structure maps.** `jmap = ofIso iterProdIso`, `imap = ofIso iterProdIso⁻¹` (the algebra map),
  `isStrict_imap`, `jmap_comp_imap : j∘i = I`.
- **Existence.** Operator `descOp k f = k∘(id×f)∘j`, descent chain `descSeq` (`h₀=⊥`,
  `hₙ₊₁=descOp k hₙ`), and **`descMap = iSupMap descSeq` (choice-free data)**. `descMap_fix`
  (`descMap = descOp descMap`, via continuity of `k` over directed unions), `descMap_strict`, and the
  homomorphism square **`descMap_comm : descMap∘i = k∘T(descMap)`** (from `descMap_fix` + `j∘i=I`).
- **Uniqueness.** Truncation chain `ρₙ = descSeq imap` with closed form
  `rho_apply : ρₙ(z) = ⟨z₀,…,z_{n-1},⊥,…⟩` and **`iSupRho_eq_id : ⋃ₙ ρₙ = I`** (cofinite-`Δ`
  structure of `𝒟^∞`). `g`-independence (`gcomp_rho_zero`, `gcomp_rho_succ`) gives
  **`comm_unique`**: any two strict homomorphisms into `(E,k)` agree on every truncation, hence are
  equal.
- **Categorical packaging.** `isStrict_prodMap`; `prodObj`/`prodMapHom`/**`prodFunctor Dom`** (the
  endofunctor `T(X)=𝒟×X`); `iterObj`/**`iterAlg Dom`** (`(𝒟^∞, i)`); `descAlgHom`; and
  **`iterIsInitial Dom : IsInitial (iterAlg Dom)`** — `𝒟^∞` is the initial `T`-algebra.

**Axioms:** the data map **`descMap` is choice-free `[propext, Quot.sound]`**; the Prop-level
`descMap_comm`/`comm_unique`/`iSupRho_eq_id`/`iterIsInitial` inherit `Classical.choice` only from the
foundational directed-suprema membership lemmas — exactly the same precedent as Exercise 6.17's
`CisInitial` (`#print axioms CisInitial = [propext, Classical.choice, Quot.sound]`).

---

## Checkpoint — 2026-06-21: Exercise 6.19 **Part A** COMPLETE (`Exercise619.lean`)

**Exercise 6.19** ("sum and product on the category of strict maps") asks to (A) define Scott's
*uniform* token-level sum/product on systems over `Δ ⊆ {0,1}*` (`Λ∈Δ`, `∅∉𝒟`) and answer *"Are these
correct up to isomorphism?"*, then (B) generate all `T(X)` from constants/identity/sum/product and show
they are functors, continuous on maps, monotone + continuous on domains. **Part A is done; Part B is
deferred** (it needs the Definition 6.8/6.10/6.13 notions re-expressed over this bespoke `{0,1}*` strict
category + closure-by-grammar-induction — a separate work item).

**What was built (namespace `Domain.Neighborhood.Exercise619`, `Str := List Bool`, `Λ = []`):**
- **Concrete sum `sumTok D₀ D₁ h₀ h₁`** over `Str`: `mem W := W = {Λ}∪0Δ₀∪1Δ₁ ∨ (∃X∈𝒟₀, W=0X) ∨
  (∃Y∈𝒟₁, W=1Y)`, with `0X = embBit false X`, `1Y = embBit true Y` (reusing Example 6.2's `embBit` and
  its disjointness/intersection algebra: `embBit_inter`, `embBit_inter_ne`, `embBit_subset`,
  `embBit_injective`, `embBit_nonempty`, `embBit_ne`). Master `sumTokMaster := insert [] (0Δ₀ ∪ 1Δ₁)`;
  closed under consistent `∩` exactly as the abstract `sum` (Exercise 3.18). `∅`-free via
  `sumTok_nonempty`.
- **`sumTok_iso_sum : sumTok D₀ D₁ h₀ h₁ ≅ᴰ sum D₀ D₁ h₀ h₁`** — the answer is **yes**. The order-iso
  `sumTokEquiv` is a *generalisation of `Example62.bbEquiv`* from `B` to arbitrary `∅`-free `D₀,D₁`:
  `toSum`/`fromSum` (mutually inverse `fromSum_toSum`/`toSum_fromSum`) with `@[simp]` bridges
  `toSum_mem_inj₀/₁`, `fromSum_mem_embF/T`. Generic inversion helpers `sum_mem_inj₀_inv`/`inj₁_inv`/
  `sum_mem_nonempty` and `sumTok_mem_embF_inv/embT_inv` carry the tag-disjointness through.
- **Concrete product `prodTok D₀ D₁`** over `Str`: `mem W := ∃ X∈𝒟₀ Y∈𝒟₁, W = {Λ}∪0X∪1Y`
  (`prodTokNbhd X Y := insert [] (0X ∪ 1Y)`). Membership simp lemmas `mem_prodTokNbhd_nil/false/true`
  reduce everything to coordinatewise facts: Scott's (2) `prodTokNbhd_inter`, (1)
  `prodTokNbhd_subset_iff`, uniqueness `prodTokNbhd_injective`. `∅`-free (`prodTok_nonempty`; every
  nbhd contains `Λ`). Note `prodTokNbhd D₀.master D₁.master = sumTokMaster` (same top as the sum).
- **`prodTok_iso_prod : prodTok D₀ D₁ ≅ᴰ prod D₀ D₁`** — yes. Built as
  `prodTokEquiv.trans (prodEquiv D₀ D₁).symm`, where `prodTokEquiv : |prodTok| ≃o |D₀|×|D₁|` mirrors
  Scott's Proposition 3.2 at the token level: components `fstTok`/`sndTok`, splitting `prodTok_mem_split`
  (Scott's (3)), pairing `pairTok`, with `pairTok_fstTok_sndTok`/`fstTok_pairTok`/`sndTok_pairTok`.
- **Axioms.** `sumTok`, `prodTok`, `sumTok_iso_sum`, `prodTok_iso_prod` all
  `#print axioms ⊆ {propext, Quot.sound}` (choice-free). Wired into `Domain.lean`; full `Domain` build
  green (3088 jobs).

**Next concrete target after 6.19A:** either **Exercise 6.19 Part B** (the functor algebra), or
**Exercise 6.20** (`tok(T({Γ}))` continuous on `{Γ ⊆ {0,1}* ∣ Λ∈Γ}` ⟹ a `Γ` with `Γ = tok(T({Γ}))`,
so `{Γ}◁T({Γ})` and 6.14 applies) — both build on this module's `sumTok`/`prodTok`.

## Checkpoint — 2026-06-21: Exercise 6.19 **Part B** COMPLETE (`Exercise619PartB.lean`)

Scott's ask: the constructs `T(X)` built from constants, identity, sum, and product are *"all
functors, continuous on maps, and monotone and continuous on domains."* All four properties are now
formalized and choice-free (`#print axioms ⊆ {propext, Quot.sound}`); wired into `Domain.lean`, full
`Domain` build green (3089 jobs).

**The category.** Rather than fight the universe-polymorphic `Endofunctor DomainObj` (Defs 6.8/6.13),
I work in the *concrete* category whose objects are `structure ScottSys` = `∅`-free neighbourhood
systems over the single token type `Str = {0,1}*` (Part A's setting). Because every object lives over
the same carrier, `◁` is a relation between systems on a common type and the domain conditions need
**no carrier transport**. Morphisms are `ApproximableMap`s between the underlying `.sys`.

**Object/map algebra (reusing Part A).**
- `ScottSys.sum`/`ScottSys.prod` repackage `sumTok`/`prodTok` so the result is again a `ScottSys`.
- `sumMapTok f₀ f₁ : (A₀+A₁) → (B₀+B₁)` and `prodMapTok f₀ f₁ : (A₀×A₁) → (B₀×B₁)` are the actions on
  maps, each a full `ApproximableMap` (the long cases: `rel_dom`/`rel_cod`/`master_rel`/`inter_right`/
  `mono`, all driven by `embBit` tag-disjointness via the new `embBit_not_subset_cross`).
- Strictness: `sumMapTok_isStrict` (always strict — `0X∪1Y` can only map nil to the master);
  `prodMapTok_isStrict` (strict iff both factors are).
- Bifunctor laws: `sumMapTok_id`/`sumMapTok_comp`, `prodMapTok_id`/`prodMapTok_comp`.

**The functor-expression grammar.** `inductive FExpr := const ScottSys | var | sum FExpr FExpr |
prod FExpr FExpr`; `FExpr.obj : FExpr → ScottSys → ScottSys`, `FExpr.map` on morphisms.

**The four properties (all by induction on `FExpr`).**
- *Functors:* `FExpr.map_id` (`T(I)=I`), `FExpr.map_comp` (`T(g∘f)=T(g)∘T(f)`), and
  `FExpr.map_isStrict` (so `T` restricts to the strict-map category of Def 6.8).
- *Continuous on maps:* `FExpr.map_mono` (`f ≤ f' ⟹ T(f) ≤ T(f')`) **and** `FExpr.map_continuous`
  (`λf. T(f)` sends `⨆` of a directed family of maps to `⨆` of the images). Monotone + preserves
  directed sups = approximable in the argument (Ex 2.13), which is Scott's "continuous on maps."
- *Monotone on domains:* `FExpr.obj_subsystem` (`X ◁ Y ⟹ T(X) ◁ T(Y)`), built on
  `sumTok_subsystem`/`prodTok_subsystem`.
- *Continuous on domains:* `FExpr.obj_continuous` (with forward half `obj_continuous_mp`):
  `λD. T(D)` preserves directed unions of subsystems — the form used in Theorem 6.14.

**Gotchas for the next session.** `DirectedOn` unfolds to an explicit `∀ x ∈ S, ∀ y ∈ S, …`, so feed
it as `hdir D₁ hD₁ D₂ hD₂` (not `hdir hD₁`). The `sumTok`/`prodTok` membership inversions need the
`∅`-freeness witnesses passed explicitly (`h₀ := B₀.ne`, etc.) since defeq won't surface them.

**Next concrete target after 6.19B:** **Exercise 6.20** (`tok(D)` on systems; the `Γ = tok(T({Γ}))`
fixed point feeding 6.14).

## Checkpoint — 2026-06-21: Exercise 6.20 COMPLETE (`Exercise619PartB.lean`)

Scott's ask: for the category of 6.19, show `λΓ. tok(T({Γ}))` is continuous on the domain
`{Γ ⊆ {0,1}* ∣ Λ∈Γ}` (`T` any functor from 6.19), and conclude there is a `Γ = tok(T({Γ}))`, so
`{Γ}◁T({Γ})` and Theorem 6.14 applies. All done choice-free (`⊆ {propext, Quot.sound}`); appended to
the existing 6.19B module, full `Domain` build green (3089 jobs).

**Setup.** `tok(𝒟) := 𝒟.master` (the master neighbourhood *is* the token set `Δ`, since `𝒟⊆𝒫(Δ)`);
`{Γ} := singletonSys Γ h` is the one-neighbourhood system (only nbhd `Γ`, master `Γ`, `∅`-free iff
`Γ` non-empty — supplied by `Λ∈Γ`).

**The crucial simplification.** Computing the whole system `T({Γ})` is unnecessary — only its master
is needed, and that obeys a tiny token-level recursion `mFun : FExpr → Set Str → Set Str` with **no**
neighbourhood data: `const C ↦ C.master`, `var ↦ Γ`, and *both* `sum`/`prod ↦ insert Λ (0·mFun T₀ Γ ∪
1·mFun T₁ Γ)` (recall `sumTokMaster = prodTokNbhd` agree on masters — same root `Λ`, same tags). The
bridge `mFun_eq_master : mFun T Γ = (T.obj (singletonSys Γ h)).sys.master` is by induction.

**Continuity on the domain.** `mFun_mono` (monotone) and `mFun_continuous` (preserves directed unions
— in fact *fully additive*: preserves arbitrary non-empty unions, so directedness is not even needed
at the master level, though the statement is the directed-sup form). Both go through the shared
tagged-union helpers `insertTag_mono`/`insertTag_continuous`.

**Fixed point = explicit Kleene union.** `mIter T 0 = {Λ}`, `mIter T (n+1) = mFun T (mIter T n)`;
`nil_mem_mIter` (`Λ∈` each), `mIter_mono_step`/`mIter_mono` (increasing chain) ⟹ `mFun_iter_fixed :
mFun T (⋃ₙ mIter T n) = ⋃ₙ mIter T n` (apply `mFun_continuous` to `Set.range (mIter T)`). Hence
`exists_tok_fixedPoint : ∃ Γ, Λ∈Γ ∧ mFun T Γ = Γ`, and the object-level capstone
`exists_singleton_subsystem : ∃ Γ h, (singletonSys Γ h).sys ◁ (T.obj (singletonSys Γ h)).sys` — the
6.14 hypothesis. `FExpr.RootedConst` (each constant `C` has `Λ∈C.master`; automatic for sum/prod)
keeps the bottom `{Λ}` and the whole chain inside `{Γ ∣ Λ∈Γ}`.

**Choice-discipline gotchas (important — these silently pull `Classical.choice`).** `Eq.le` on `Set`
(i.e. `(h : X = Y).le : X ⊆ Y`) and `monotone_nat_of_le_succ` both depend on `Classical.choice`.
Replaced the former with a `rw`-based `sub_master` in `singletonSys`, and the latter with a hand-rolled
`mIter_mono` (`induction hmn` on `m ≤ n`). Also hand-rolled `insertTag_mono` (the
`Set.insert_subset_insert`/`union_subset_union` combo was fine, but the by-hand `rintro` version is
clearly clean). Audit each new lemma with `#print axioms` — the whole 6.20 development is
`⊆ {propext, Quot.sound}`.

**Next concrete target:** **Exercise 6.21 is COMPLETE** (`Exercise621.lean`) — see the checkpoint
below. Next open Lecture VI items: **Exercise 6.22** (comment on the domain equations
`N ≅ {{0},{0,Λ}} ⊕ N`, `M ≅ {{Λ}} + M`, `N* ≅ N ⊕ (N ⊗ N*)`), **Exercise 6.23** (initial solution of
`Exp ≅ N ⊕ ((Exp×Exp)+(Exp×Exp))` as a syntactic domain + evaluation `val(s)`), **Exercise 6.24**
(simultaneous double fixed point `D ≅ D+(D×E)`, `E ≅ D+E`).

## Checkpoint — 2026-06-21: Exercise 6.21 COMPLETE (`Exercise621.lean`)

Scott's ask: *"do the same as 6.19 and 6.20"* for the **coalesced** sum `⊕` and **smash** product
`⊗` (p. 113), and *"generalize all of `+,×,⊕,⊗` to combinations of several terms."* All done
choice-free (`#print axioms ⊆ {propext, Quot.sound}`); wired into `Domain.lean`, full `Domain` build
green (3090 jobs). New module `Exercise621.lean` (namespace `Domain.Neighborhood.Exercise619`, so it
reuses Part A/B `sumTok`/`prodTok`/`embBit`/`ScottSys`/`sumMapTok`/`prodMapTok`/`singletonSys`/
`insertTag_*` directly).

**The operations.** `oplusTok D₀ D₁ h₀ h₁` is literally `sumTok` with the two improper copies `0Δ₀`,
`1Δ₁` deleted (proper rows now demand `X ≠ Δ₀`, `Y ≠ Δ₁`); `otimesTok D₀ D₁` is `prodTok` with proper
rectangles demanding `X ≠ Δ₀ ∧ Y ≠ Δ₁`, keeping only the full top `M = prodTokNbhd Δ₀ Δ₁` on the
boundary. Both keep the **same master** `M = {Λ}∪0Δ₀∪1Δ₁` as `+`/`×`. The domain meaning: `⊕`/`⊗`
**identify the two bottoms** (coalesced/smash), whereas `+`/`×` keep them apart. Closure is the
`sumTok`/`prodTok` proof + the helper `inter_ne_of_ne_left/right` (`X ⊆ Δ, X ≠ Δ ⟹ X∩X' ≠ Δ`).

**The map actions (the subtle part).** `oplusMapTok`/`otimesMapTok`'s relations add a
**master/collapse row** — *every* `W` in the domain relates to the top `M` — on top of the proper
rows (with `≠Δ` on both input and output components). The collapse row is what makes the map
total/approximable even when `f₀(X)` hits the top `Δ₀'` (which would land on the *deleted* copy
`0Δ₀'`): such a hit collapses to `M`, exactly the coalesced bottom. Both maps are **always strict**.
**Crucial gotcha:** the bifunctor *composition* laws `oplus/otimesMapTok_comp` need **`g₀,g₁`
strict** (`hg₀ : IsStrict g₀`, …). Reason: if the intermediate `f₀(X)=Δ₀'` (top) and `g₀` then
produces proper info from it, the RHS `(g⊕)∘(f⊕)` routes `X → M → M` (g⊕ sends the top only to the
top) while the LHS `(g∘f)⊕` would produce proper output — mismatch. Strictness of `g` forbids exactly
this (`g₀.rel Δ₀' Y → Y = Δ_C`). This is the formal reason Scott restricts to the **strict-map
category**, and it is why `GExpr.map_comp` (below) carries `IsStrict g` (whereas `FExpr.map_comp` for
`+`/`×` alone did not).

**The extended algebra `GExpr`** = `FExpr` + two constructors `oplus`/`otimes`. `GExpr.obj`,
`GExpr.map`, and the four properties all by induction over the **six** constructors, delegating
`sum`/`prod` to Part B's combinators and `oplus`/`otimes` to the new ones: functors
(`map_id`/`map_comp`/`map_isStrict`), continuous on maps (`map_mono`/`map_continuous`), monotone on
domains (`obj_subsystem`), continuous on domains (`obj_continuous`). The `obj_continuous_mp` and
`map_continuous_mp` forward inductions carry the `≠Δ` side-conditions across via the subsystem
`master_eq` (`fun heq => hXne (heq.trans (…).master_eq)`).

**6.20 for `GExpr`.** Because all four binary masters agree (`sumTokMaster = prodTokNbhd` on masters),
the token recursion `gFun` has the **same body** in all four binary cases, so `gFun_mono`/
`gFun_continuous` reuse Part B's generic `insertTag_mono`/`insertTag_continuous` verbatim. Capstones
`gExists_tok_fixedPoint` and `gExists_singleton_subsystem` (`{Γ} ◁ T({Γ})`, so Thm 6.14 applies).

**Several terms.** Key observation: `GExpr` is **closed** under the binary ops, so every finite
combination `T₀ ⋆ T₁ ⋆ ⋯ ⋆ Tₙ` (any `⋆`, any nesting) is *already* a `GExpr` and inherits every
result with zero extra work. `GExpr.naryOp op a l` packages the right-nested n-ary fold;
`narySum`/`naryProd`/`naryOplus`/`naryOtimes` are the four instances; `naryOp_rootedConst` preserves
the `Λ∈tok` side-condition; `{narySum,naryProd,naryOplus,naryOtimes}_singleton_subsystem` give each
n-ary construct a fixed point `Γ = tok(T({Γ}))`.

**Reusable gotchas for next session.** (1) `oplusTok_mem_embF`/`_embT`/`_inv` have **implicit**
`h₀ h₁` (the `∅`-freeness witnesses) that defeq won't surface — pass `(h₀ := B₀.ne) (h₁ := B₁.ne)`
explicitly (matches the Part-A gotcha). `otimesTok` takes **no** such args, so its helpers
(`otimesTok_mem_prod`/`_master`/`_prod_inv`) need none. (2) The collapse row's `W' = master` makes
`isStrict`/`id`/`comp` proofs hinge on `nil ∈ sumTokMaster` vs `nil ∉ embBit`; coerce the master
equality with `have heq' : sumTokMaster … = … := heq` before `▸` (defeq through `(A.oplus B).sys.master`
won't rewrite directly). (3) `prodTokNbhd_injective` needs its arg retyped to the literal
`prodTokNbhd …` shape (same coercion trick) before use on a `.sys.master`.

## Checkpoint — 2026-06-21: Exercise 6.22 COMPLETE (`Exercise622.lean`)

Scott's *"Comment on these domain equations"* — `N ≅ {{0},{0,Λ}} ⊕ N`, `M ≅ {{Λ}} + M`,
`N* ≅ N ⊕ (N ⊗ N*)`. This is a *comment-on* exercise, so the formal content is to recognise each RHS
as a construct `T(X)` of the **`GExpr`** algebra (Exercise 6.21) with **rooted** constants, hence
`gExists_singleton_subsystem` gives a solution `Γ = tok(T({Γ}))` with `{Γ} ◁ T({Γ})` and **Thm 6.14
applies**. Built green (full `Domain`, 3091 jobs), axiom audit `⊆ {propext, Quot.sound}`, wired into
`Domain.lean`. New module reuses everything from 6.21 (namespace `Domain.Neighborhood.Exercise619`).

**The two new constant domains.** `Cnat = {{0},{0,Λ}}` (`0 = [false]`, `Λ = []`): the **two-point
chain** `{0} ⊏ Δ={0,Λ}`. Built as a bare `NeighborhoodSystem` with the nested pair `{0} ⊆ {0,Λ}`;
`inter_mem`'s four cases discharge with `Set.inter_self` / `Set.inter_eq_self_of_subset_left` /
`…_right` off the single fact `hAB : {[false]} ⊆ {[false],[]}` (`Set.singleton_subset_iff.mpr
(Set.mem_insert ..)`). `∅`-free + rooted (`nil_mem_Cnat`, via `Set.mem_insert_iff.mpr (Or.inr rfl)`).
`Cone = singletonSys {Λ}` is the one-point `𝟙` (`nil_mem_Cone := rfl`).

**The three equations & their meaning (the "comment").** `NExpr = ⊕(const Cnat, var)` → `N` = the
**vertical naturals** (coalesced `⊕` *identifies* bottoms ⇒ a chain `⊥⊑0⊑1⊑⋯⊑∞`). `MExpr =
+(const Cone, var)` → `M` = the **lazy naturals** (separated `+` *keeps* the stop/continue choice
apart ⇒ branching). `NStarExpr N = ⊕(const N, ⊗(const N, var))` → `N*` = **strict streams over `N`**
(cons-cell functor `X ≅ N ⊕ (N ⊗ X)`, smash `⊗` = strict head/tail pair). The only `+`-vs-`⊕`
difference (coalesced vs separated) is *exactly* what distinguishes `N` from `M` — a nice payoff of
having both in `GExpr`.

**Theorems.** `N_eq_solution`, `M_eq_solution`, `NStar_eq_solution (N) (hN : Λ ∈ tok N)` — each is
`gExists_singleton_subsystem _ <rooted>`. `NStar_over_N_exists` **chains** them: eq-1's solution is a
rooted domain (its token set is the fixed point `Γ₁ ∋ Λ`, extracted via `gExists_tok_fixedPoint`), so
it is a legitimate datum domain for eq-3 — `N*` exists over the very `N` from eq-1.

**Gotchas / reuse for next session.** (1) `RootedConst` of these small expressions is just nested
`⟨…, trivial⟩` and elaborates fine without unfolding (`def`s are semireducible; `exact` unfolds
`NExpr`/`RootedConst` during defeq). (2) To get `Λ ∈ Γ` from a `GExpr` fixed point, use
`gExists_tok_fixedPoint` (exposes `hnil`), **not** `gExists_singleton_subsystem` (hides it). (3) Set
literals: `{[false],[]}` is `insert [false] {[]}`; `Λ ∈ master` is `Set.mem_insert_iff.mpr (Or.inr
rfl)`, and for a `singletonSys Γ` the master *is* `Γ` so `Λ ∈ {Λ}` is `rfl`. (4) `Cnat`/`Cone` are
the reusable "small constant domains" — `Cone` is the terminal object `𝟙`, handy for 6.23/6.24.

## Checkpoint — 2026-06-21: Exercise 6.23 **Phase 1** COMPLETE (`Exercise623.lean`)

Scott 6.23 asks to (a) *construe the initial solution of `Exp ≅ N ⊕ ((Exp×Exp)+(Exp×Exp))` as a
syntactic domain of expressions* (variables from `N`, two binary op-symbols `u,v`), and (b) show any
strict `s : N → D` + ops `u,v : D×D → D` determine a **unique** evaluation `val(s) : Exp → D`. User
chose the **full domain-theoretic initiality** route (à la Exercise 6.17), with `N` an **arbitrary
rooted `ScottSys`** parameter.

**Key architectural decision (important for whoever continues).** Theorem 6.14 (`Theorem614.lean`)
already builds the initial algebra abstractly as the colimit `⋃ₙ Tⁿ({Γ})` — *but* it is stated over
`Endofunctor DomainObj` with arbitrary carriers, so it is drowning in `HEq` carrier-transport, and
the `GExpr` operations `⊕,⊗,+,×` are **`Str`-specific** (not a total endofunctor of `DomainObj` — the
same obstruction `Exercise617` flagged). So we **cannot** instantiate the abstract Theorem 6.14. The
chosen path is to **re-derive Theorem 6.14 concretely in the `ScottSys` framework**, where the token
type is fixed at `Str` and every carrier equality is `rfl` (no `HEq`). The `GExpr` concrete
continuity lemmas (`obj_subsystem`, `obj_continuous`, `map_continuous`, `map_id`, `map_comp` [needs
`IsStrict g`], `map_isStrict`) are *exactly* the hypotheses needed and plug straight in.

**Phase 1 delivered (a generic, reusable colimit fixed point for ANY rooted `GExpr` — also the engine
for 6.24).** All choice-free; full `Domain` green (3092 jobs).
- `gFix T = ⋃ₙ gIter T n` — the 6.20/6.21 token fixed point `Γ=tok(T({Γ}))`, as **explicit data**
  (use this, not `gExists_*`, to stay choice-free when you need the witness).
- `gGen T = {Γ}` (`singletonSys`); `gBase : {Γ} ◁ T({Γ})` (inlined `gExists_singleton_subsystem` body
  at the explicit `Γ`).
- tower `gTower T n = Tⁿ({Γ})` (`gChain` base `gBase`, step `obj_subsystem`); `gTower_le`;
  `gTower_master` (all levels share master `Γ`).
- `gColim T hT = ⋃ₙ Tⁿ({Γ})` (∅-free `ScottSys` over `Str`; `inter_mem` via `gTower_le`+`max`);
  `gTower_sub_colim : Tⁿ({Γ}) ◁ 𝒟`.
- **`gColim_obj_eq : T(gColim)=gColim`** (`ScottSys` equality). Membership half from `obj_continuous`
  on the directed tower (`T(⋃Tⁿ)=⋃Tⁿ⁺¹`, and the `n=0` level is absorbed by one `gChain` step);
  master half from `obj_subsystem (gTower_sub_colim 0)`. Helper `ScottSys.ext` (sys-equality ⟹ object
  equality; `ne` is a `Prop`).
- Instantiation: `Texp N = .oplus (.const N) (.sum (.prod .var .var) (.prod .var .var))`;
  `Texp_rooted (hN:Λ∈tok N)`; `Exp N hN := gColim (Texp N) _`; **`Exp_structure_eq : Texp(Exp)=Exp`**
  — the domain-equation iso (structure map = `idMap`).

**Phases 2–4 remaining (the evaluation map + initiality). Recommended plan:**
- **Phase 2 — algebras & decomposition.** Build a `Category` of `ScottSys` + **strict** maps (mirror
  `Exercise617`'s `StrictDomainObj` instance but over fixed `Str`; `GExpr.map_comp` needs strict `g`,
  so the strict-map category is forced). Make `Texp N` an `Endofunctor` of it (reuse `GExpr.map_id`,
  `map_comp`, `map_isStrict`). A `Texp`-algebra `(D,k)` decomposes — via element-level injections of
  `⊕`/`+`/`×` — into `s:N→D` (strict), `u,v:D×D→D`. The project has the *map* actions
  `sumMapTok`/`prodMapTok`/`oplusMapTok`/`otimesMapTok` (6.21) already; element-level injections may
  need adding (cf. `Exercise617`'s `sinj0/1/2`).
- **Phase 3 — descent `val(s)`.** Mirror `Theorem614` lines ~285–362 concretely: `colimAlg` = `Exp`
  with structure map `idMap` (from `Exp_structure_eq`); existence of a strict hom via the project's
  concrete **Theorem 6.9** (`Theorem69.lean`, homomorphisms out of a fixed point `D ≅ T(D)`). `val(s)`
  is that hom for the algebra `(D,s,u,v)`.
- **Phase 4 — uniqueness ⟹ `IsInitial`.** Mirror `Theorem614` lines ~303–598 concretely: projections
  `ρₙ = iₙ∘jₙ` from `gTower_sub_colim n` (Prop 6.12), `T(ρₙ)=ρₙ₊₁` (here MUCH easier than the abstract
  `map_rho_heq`: no `HEq`, just `GExpr.map_comp`/`map_id`), `⋃ₙρₙ=I` (`iSupMap`), and `g∘ρₙ` is
  `g`-independent (base `ρ₀=⊥` since `{Γ}` is one-point; step: homomorphism square). Conclude
  uniqueness of strict homs ⟹ `IsInitial`.
- **Known gotcha:** `oplusMapTok_comp`/`otimesMapTok_comp` (so `GExpr.map_comp`) REQUIRE strict `g` —
  stay in the strict category; the `⊕` `N`-summand injection must respect the coalesced bottom
  (collapse row), cf. 6.21's `oplusMapTok`.

## Checkpoint — 2026-06-21: Exercise 6.23 **Phases 2–3 COMPLETE + Phase 4 partial** (`Exercise623.lean`)

Continuing 6.23. Everything choice-free (`#print axioms ⊆ {propext, Quot.sound}`); full `Domain`
green (3092 jobs). New content all in namespace `Domain.Neighborhood.Exercise619`; added
`import Domain.Neighborhood.Theorem69` and `open Domain.Neighborhood.Exercise510` (for `StrictMap`,
`IsStrict`, `isStrict_idMap`, `isStrict_constBot`, `isStrict_comp`).

**Phase 2 — the strict-map category, the endofunctor, the algebra.**
- `instance : Category ScottSys` — objects = `ScottSys` (∅-free systems over the *fixed* token type
  `Str`), morphisms = `StrictMap A.sys B.sys`; `id`/`comp`/laws from Theorem 2.5 (`idMap_comp`,
  `comp_idMap`, `comp_assoc`) + `isStrict_idMap`/`isStrict_comp`. The fixed carrier `Str` is exactly
  what removes the `HEq` carrier-transport that made the abstract `Endofunctor DomainObj` (Thm 6.14)
  unusable. Simp lemmas `ScottSys.id_val`/`ScottSys.comp_val` (both `rfl`).
- `gFunctor (T : GExpr) : Endofunctor ScottSys` — `obj := T.obj`, `map := gFunctorMap T` (a strict
  `f ↦ ⟨T.map f.1, T.map_isStrict …⟩`), functoriality from `GExpr.map_id`/`map_comp` (the latter's
  `IsStrict g` is automatic — every morphism here is strict). `TexpF N := gFunctor (Texp N)`.
- `isoOfObjEq` (identity iso from an object equality), `ExpIso : T(Exp)≅Exp` (= `isoOfObjEq
  Exp_structure_eq`), and `ExpAlg N hN : TAlgebra (TexpF N)` with structure map `ExpIso.hom` (the
  identity, since `T(Exp)=Exp`). This is the "construe the initial solution as a syntactic domain"
  half.

**Phase 3 — the evaluation homomorphism `val(s)` (existence).** Since the structure map `i` is the
**identity** (`Exp_structure_eq`), the homomorphism equation `val∘i = k∘T(val)` is the fixed-point
equation `val = k∘T(val)∘j`. Solved by **Kleene iteration directly** (no need to re-derive Thm 6.9's
`homOp`/`strictFun` machinery):
- raw helpers `algStr B := B.str.1`, `expHom`/`expInv` (the iso's `i`/`j` as raw maps, ascribed
  through `StrictMap`), with `expInv_comp_expHom`/`expHom_comp_expInv` from the iso laws.
- `descRel : ℕ → ApproximableMap Exp.sys D.sys` (`val₀ = constMap ⊥`,
  `valₙ₊₁ = (algStr B)∘(T(valₙ))∘expInv`); `descRel_isStrict`, `constBot_le` (the `⊥` map is least),
  `descRel_le_succ`/`descRel_mono` (increasing), `descDir`/`descDirLe`.
- `descMap := iSupMap descRel descDir` (= `⋃ₙ valₙ`), `descMap_isStrict`.
- `descMap_fix : descMap = (algStr B)∘(T(descMap))∘expInv` — the decisive step, via
  `GExpr.map_continuous` (`T(⋃valₙ)=⋃T(valₙ)`) and the index-shift `⋃valₙ₊₁=⋃valₙ`.
- `descComm : descMap∘expHom = (algStr B)∘T(descMap)` (conjugate `descMap_fix` by `i`, using
  `j∘i=I`), packaged as **`descAlgHom : AlgHom (ExpAlg N hN) B`** — Scott's evaluation map exists.

**Phase 4 (partial) — `descAlgHom` is the *least* homomorphism.**
- `algHom_fix (g)` : every hom `g` is itself a fixed point `g = (algStr B)∘T(g)∘expInv` (from
  `g.comm` rearranged by `i∘j=I`).
- `descRel_le_algHom`/`descMap_le_algHom` : `val ≤ g` for every hom `g` (the Kleene iterates lie
  below any fixed point; induction + monotonicity of `λh.k∘T(h)∘j`).

**Phase 4 remaining — the reverse `g ≤ val` ⟹ `IsInitial`. Precise roadmap:**
- Build `ρₙ = iₙ∘jₙ : Exp → Exp`, `iₙ = (gTower_sub_colim n).inj`, `jₙ = (gTower_sub_colim n).proj`
  (Prop 6.12, `Subsystem.inj`/`proj`; these depend only on the two systems, not the `◁` proof).
- **Crux lemma** `GExpr.map (h.inj) = (obj_subsystem h).inj` and the `proj` analogue, by induction
  over the 6 constructors (this is the *concrete* `MonotoneAt.inj_heq`/`proj_heq` of Def 6.13). The
  `const`/`var` cases are immediate (`idMap = refl.inj` by `idMap_rel`); the four binary cases need
  `sumMapTok hA.inj hB.inj = (sumTok_subsystem hA hB).inj` etc. (match the tagged-token relations;
  `⊕`/`⊗` carry the `≠Δ`/collapse-row conditions). From it, `GExpr.map ρₙ = ρₙ₊₁` (use
  `GExpr.map_comp` [needs `iₙ` strict] + the equality `T(Exp)=Exp` = `gColim_obj_eq` to retype the
  codomain; recall `gTower (n+1) = T.obj (gTower n)` is `rfl`).
- Then mirror `Theorem614` concretely: `key_rho` (`ρₙ₊₁ = expHom∘T(ρₙ)∘expInv`), `⋃ₙρₙ = I`
  (`iSupMap` + `rho_rel`-style description), `ρ₀ = ⊥` (since `{Γ}` is one-point), `g∘ρₙ`
  `g`-independent and `= descRel n` (homomorphism square + `algHom_fix`), hence `g = ⋃ g∘ρₙ = ⋃
  descRel n = descMap` ⟹ uniqueness ⟹ **`IsInitial (ExpAlg N hN)`**.
- Optional (Scott's "explain the algebras"): decompose a structure map `k : T(D)→D` into `s:N→D`
  (strict), `u,v:D×D→D` via element-level injections of `⊕`/`+`/`×` (cf. Ex 6.17's `sinj0/1/2`); then
  `descAlgHom` for `(D,s,u,v)` *is* `val(s)`.

**Lean gotchas this session (reuse next time).** (1) `f.1` on a `Category.Hom`-typed term often fails
to reduce through the class projection (`instCategoryScottSys.1 X Y` "not of the form `C …`"); fix by
**typing helpers with `StrictMap` directly** (defeq to `Hom`) or **ascribing** `(f : StrictMap _ _).1`.
The `ScottSys.id_val`/`comp_val`/`gFunctorMap_val` simp lemmas (all `rfl`) bridge `⊚`/`id`/`gFunctor`
to raw `.comp`/`idMap`/`GExpr.map`. (2) `congrArg Subtype.val g.comm` lands the categorical comm
square at the raw `.comp` level **by defeq** — use it (and `show …`) instead of fighting `simp`.
(3) `rw [hcomm]`/`rw [comp_assoc]` repeatedly failed with "pattern not found / unsolved `X=X`" on
defeq-but-not-syntactic implicits (the `↑g.hom` vs `g.hom.1` display is a tell) — switch to
**term-mode `calc` with `congrArg (fun m => m.comp …)`** and `(comp_assoc _ _ _).symm`, which bridge by
defeq. (4) `StrictMap`/`isStrict_idMap`/`isStrict_constBot` live in `Exercise510`; `isStrict_comp`/
`comp_mono_gen` in `Theorem69` — both imported/opened now.

## 2026-06-21 — Exercise 6.23 Phase 4 COMPLETE (`ExpInitial`), green, choice-free

`Exercise623.lean` builds green, **zero `sorry`**, wired in `Domain.lean`. Phase 4 (uniqueness ⟹
initiality) is done; `#print axioms ExpInitial = {propext, Quot.sound}` (and likewise
`descMap_eq_algHom`, `key_rho`, `GExpr.map_inj/map_proj`, `iSupRho_eq_id`, `gcomp_rho_eq`, and all 8
token `*MapTok_inj/proj` lemmas).

What landed (all in the `Uniqueness`/crux sections of `Exercise623.lean`):
- `Subsystem.inj_isStrict`/`proj_isStrict`/`self_inj`/`self_proj` (Prop 6.12 helpers).
- The **8 token lemmas** `sum/prod/oplus/otimesMapTok_inj` + `_proj`: the functor's token actions
  carry Prop-6.12 projection pairs, e.g. `otimesMapTok h0.inj h1.inj = (otimesTok_subsystem h0 h1).inj`.
- **Crux** `GExpr.map_inj : T.map h.inj = (T.obj_subsystem h).inj` and `GExpr.map_proj` (induction over
  the 6 constructors; `const/var` immediate, 4 binary cases discharged by the token lemmas).
- The projection chain `expSub n : (gTower (Texp N) n).sys ◁ (Exp N hN).sys`, `rho n = iₙ.comp jₙ`,
  `rho_rel`, `rho_mono`, `iSupRho`, **`iSupRho_eq_id : ⋃ₙ ρₙ = I_Exp`**, `rho_zero_rel` (`ρ₀ = ⊥`).
- `map_rho_eq : T(ρₙ) = i'ₙ∘j'ₙ` and **`key_rho : ρₙ₊₁ = expHom∘T(ρₙ)∘expInv`**.
- `gcomp_rho_zero/_succ/_eq` (`g∘ρₙ = descRel n`, `g`-independent), `descMap_eq_algHom`
  (`g.hom.1 = descMap`), `algHom_ext`, and **`ExpInitial : IsInitial (ExpAlg N hN)`**.

**Bug fixes this session (the build that was red on resume).** (a) `gTower` takes `(T : GExpr)` then
`(n : ℕ)` — it does **not** take the `RootedConst` proof; `expSub`/`rho_rel` had a stray
`(Texp_rooted hN)` arg (`gTower_sub_colim`/`gTower_le`/`gColim_master` *do* take it). (b) `key_rho`:
chained `rw [comp_rel, comp_rel, …]` is brittle on nested comps — use
`rw [map_rho_eq]; simp only [comp_rel, rho_rel, expInv_rel, expHom_rel, Subsystem.proj_rel,
Subsystem.inj_rel, hsyseq]`. (c) the `rw [hcomm]`/`rw [map_comp …]` calc steps: replace with
term-mode `congrArg (fun m => …) hcomm` / `…map_comp …).symm` (gotcha #3). (d) `descMap_eq_algHom`'s
final `rw [← comp_idMap, ← iSupRho_eq_id]` failed on `idMap (ExpAlg…).carrier.sys` vs `idMap (Exp…).sys`
(defeq, not syntactic) — replace with a `calc … := by rw [iSupRho_eq_id hN]; exact (comp_idMap _).symm`
that closes by **defeq via `exact`**.

**NEW gotcha — `Eq.le` on `Set` drags in `Classical.choice`.** `(h : s = t).le` to get `s ⊆ t`
silently depends on `Classical.choice` (the `Set` `Preorder`/`le_of_eq` path). This is what made the
sum/oplus/otimes token lemmas (and everything downstream incl. `ExpInitial`) non-choice-free. **Fix:
use `(h : s = t).subset`** (`Eq.subset`, choice-free) — or `subset_rfl`. `prodMapTok_*` was already
clean precisely because it had no master case and never used `.le`. Bisect choice provenance with
`#print axioms` + temporarily `sorry`-ing branches (setup vs. branch bodies).

---

## Checkpoint — Exercise 6.24 COMPLETE (double fixed point) — 2026-06-22

**Status:** `lake build Domain` green (3093 jobs), zero `sorry`. New module `Exercise624.lean`
(namespace `Domain.Neighborhood.Exercise624`), wired into `Domain.lean`. Axiom audit on
`exists_double_fixedPoint`, `exists_simultaneous_subsystems`, `Dsol_subsystem`, `Esol_subsystem`
all `⊆ {propext, Quot.sound}` (choice-free).

**What Exercise 6.24 asks.** Show there exist domains with `D ≅ D+(D×E)` and `E ≅ D+E` *by a double
fixed-point method*: decide the tokens, then define `D, E` by simultaneous fixed points. This is the
**simultaneous** analogue of 6.20/6.21 — those exercises deliver a single `Γ` with `{Γ} ◁ T({Γ})`
("so 6.14 applies"); 6.24 delivers a **pair** `(Γ_D, Γ_E)` solving two coupled token equations at
once, whence the two singleton systems are subsystems of the two right-hand sides simultaneously =
the joint hypothesis of the simultaneous Theorem 6.14.

**Design (concrete, no bivariate `FExpr` needed).** Both `D, E` are `∅`-free systems over the single
token type `Str = {0,1}*`. Over `{0,1}*` the sum `+` and product `×` share the master shape
`{Λ} ∪ 0·(…) ∪ 1·(…)`, so the two token recursions collapse to:
- `gTok p q = tok(D+E) = insert [] (embBit false p ∪ embBit true q)`;
- `fTok p q = tok(D+(D×E)) = gTok p (gTok p q)`  (the inner `gTok p q` is `tok(D×E)`).

**Key continuity insight.** `mem_gTok_iUnion`/`mem_fTok_iUnion`: every token of `*Tok (⋃ aₙ)(⋃ bₙ)`
lands in some *single* `*Tok aₙ bₙ`. Reason: each concrete token (`[]`, `0w'`, `1[]`, `1(0u')`,
`1(1u')`) references **at most one** of the two coordinates, even in `fTok`'s nested `true`-branch —
so **no directedness merge is needed** (unlike the abstract continuity-on-domains lemmas). This makes
the fixed point fall out from just monotonicity + this additivity; the chain need not even be proved
increasing.

**The double fixed point.** `pIter : ℕ → Set Str × Set Str`, `Φ(p,q) = (fTok p q, gTok p q)` from
`({Λ},{Λ})`; `GammaD = ⋃ₙ (pIter n).1`, `GammaE = ⋃ₙ (pIter n).2`. `fTok_GammaD_GammaE`,
`gTok_GammaD_GammaE` (⊇: `fTok_mono`/`gTok_mono` + `pIter_*_subset_*`; ⊆: additivity lemma landing at
stage `n+1`). Capstone `exists_double_fixedPoint`.

**Object level.** `Dsol = {Γ_D}`, `Esol = {Γ_E}` (`singletonSys`); `Fsol D E = D.sum (D.prod E)`,
`Gsol D E = D.sum E`. `master_Fsol`/`master_Gsol` are **`rfl`** (the sum/product masters defeq-expand to
`fTok`/`gTok`). `Dsol_subsystem : {Γ_D} ◁ D+(D×E)` and `Esol_subsystem : {Γ_E} ◁ D+E` by the
singleton-subsystem pattern (cf. `exists_singleton_subsystem`); `exists_simultaneous_subsystems`
packages both.

**Choice-discipline gotcha (reuse).** `Set.subset_iUnion` is **classical** (drags in
`Classical.choice`). For a choice-free `(s i) ⊆ ⋃ i, s i`, prove it by hand:
`fun _ hx => Set.mem_iUnion.mpr ⟨i, hx⟩` (here `pIter_fst_subset_GammaD`/`pIter_snd_subset_GammaE`).
`Set.mem_iUnion` itself is choice-free. (Also: `(pIter 0).1` does not match `{·}` for
`Set.mem_singleton_iff`; use `have hw0 : w = [] := hn` — singleton membership is defeq to `=`.)

**Next concrete target:** Exercise 6.25 (projection-pair `g,h` identities on elements:
`g(x) ⊑ y ↔ x ⊑ h(y)`, the Galois connection, and the two extremal formulas for `h`/`g`).

---

## Checkpoint 2026-06-22 — Exercise 6.25 COMPLETE (`Exercise625.lean`)

**Status:** `lake build Domain` green (3094 jobs), zero `sorry`. All 7 results choice-free
(`#print axioms ⊆ {propext, Quot.sound}`). Wired into `Domain.lean` after `Exercise624`.

**What it proves.** Exercise 6.25 is entirely *element-level* reasoning about an abstract projection
pair, so I reused `Subsystem.ProjectionPair D E` (from `Proposition612.lean`) directly — no new
domain construction. Scott's `g = P.inj`, `h = P.proj`. Namespace
`Domain.Neighborhood.Subsystem.ProjectionPair`.

- **Two laws on elements** (the only inputs to everything else):
  - `proj_inj_apply : h(g x) = x` — `rw [← toElementMap_comp, P.proj_comp_inj, toElementMap_idMap]`.
  - `inj_proj_apply_le : g(h y) ⊑ y` — `le_iff_toElementMap_le.mp P.inj_comp_proj_le` then
    `rw [toElementMap_comp, toElementMap_idMap]`.
- **`galois : g(x) ⊑ y ↔ x ⊑ h(y)`** — `→` apply monotone `h` then `h(g x)=x`; `←` apply monotone
  `g` then chain through `g(h y) ⊑ y`. (`toElementMap_mono` is Prop 2.2(iii).)
- **`proj_eq_sSup : h(y) = ⊔{x ∣ g(x) ⊑ y}`** — `lowerSet y := {x ∣ g(x)⊑y}`; by `galois` it is the
  down-set `{x ∣ x⊑h(y)}`, so `lowerSet_bounded` (bound `h(y)`) and `lowerSet_directed` (top `h(y)`,
  membership = `inj_proj_apply_le`). Equality by `le_antisymm` of `D.le_sSup`/`D.sSup_le`
  (Exercise 1.27's bounded `sSup`).
- **`inj_eq_sInf : g(x) = ⊓{y ∣ x ⊑ h(y)}`** — `upperSet x := {y ∣ x⊑h(y)}`; `upperSet_nonempty`
  contains `g(x)` (since `x ⊑ h(g x)=x`). Equality by `le_antisymm` of `E.le_sInf`/`E.sInf_le`
  (Exercise 1.18's `sInf`; needs only `Nonempty`, not bounded).
- **`inj_bounded`** — `g` maps consistent (=bounded, per Ex 1.27) sets to bounded sets: image of a
  set bounded by `b` is bounded by `g(b)` (monotone). True of any approximable map; the real content
  is the next one.
- **`inj_sSup : g(⊔S) = ⊔{g(s) ∣ s∈S}`** — `g` (lower adjoint) preserves **all** lubs, not just
  directed ones. `⊒` is monotonicity; `⊑` is the adjoint trick: `(galois ..).mpr` reduces to
  `⊔S ⊑ h(⊔{g s})`, then `sSup_le` reduces to each `s ⊑ h(⊔{g s})`, then `(galois ..).mp` reduces to
  `g(s) ⊑ ⊔{g s}` = `le_sSup`.

**Lessons / reusable facts.**
- `le_iff_toElementMap_le` (Thm 3.13(i), top-level in `Domain.Neighborhood`, *not* inside
  `ApproximableMap`) is the bridge from a `≤` between approximable *maps* to a `≤` between their
  element images — exactly what turns `inj_comp_proj_le : g∘h ≤ I` into `g(h y) ⊑ y`.
- Two bounded-sup APIs coexist: `sSupDirected` (`Approximable.lean`, directed families, the lub used
  by continuity) vs. `Bounded`/`sSup` (`Exercise127.lean`, *any* bounded set, built from `sInf` of
  upper bounds). Exercise 6.25's "not just directed unions" needs the **`Exercise127` `sSup`**.
- `ProjectionPair` lives over a *single* token type `α` (both `D E : NeighborhoodSystem α`), so
  `D.Bounded`/`D.sSup`/`E.sInf` all apply with no cross-type plumbing.

**Next concrete target:** Exercise 6.26 (`𝒟_⊥` lift, functoriality, `𝒟_⊥ ⊕ ℰ_⊥ ≅ 𝒟 + ℰ`).

---

## Checkpoint — Exercise 6.26 (the lifting `𝒟_⊥`) COMPLETE

`Domain/Neighborhood/Exercise626.lean`, namespace `Domain.Neighborhood.Exercise619` (reopened, as
`Exercise621` does, to reuse `sumTok`/`oplusTok`/`otimesTok`/`prodTokNbhd` + their membership lemmas).
Wired into `Domain.lean`; `lake build Domain` green.

**Object.** `liftTok D _hD` over `Str = {0,1}*` with master `liftTokMaster D = insert [] (embBit false D.master)`
(`= {Λ}∪0Δ`) and proper neighbourhoods `embBit false X = 0X` for every `X∈𝒟` (incl. `0Δ`, strictly above
the new bottom). `∅`-free (`liftTok_nonempty`); packaged as `ScottSys.lift`. (The nonempty hypothesis is
unused inside the system itself — hence the binder `_hD` — but carried for the `ScottSys` packaging.)

**Elements — `|𝒟_⊥| ≅ |𝒟|_⊥`.** `liftBot` (mem `W ↔ W = master`) is the fresh least element
(`liftBot_le`); `liftUp x = {master}∪{0X∣X∈x}` is an order embedding (`liftUp_le_liftUp_iff`) sitting
strictly above it (`liftBot_lt_liftUp`, via `embF_ne_liftTokMaster`). `unlift z hz = {X∣0X∈z}` (needs
`hz : z.mem 0Δ`) with `liftUp_unlift`, and the covering `eq_liftBot_or_exists_liftUp`. The covering is the
**only** non-`{propext,Quot.sound}` result: it case-splits on `z.mem 0Δ` (excluded middle), unavoidable.

**Functor — "is this a suitable functor?" yes (strict).** `liftMapTok f` (rel: a *collapse-to-master*
row `(W∈𝒟_⊥ ∧ W'=master)` ∨ a copy row `0X→0X'` from `f.rel X X'`), with `liftMapTok_isStrict` (for any
`f`), `liftMapTok_id`, `liftMapTok_comp` — the one-summand analogue of 6.19's `sumMapTok`.

**`𝒟_⊥ ⊕ ℰ_⊥ ≅ᴰ 𝒟 + ℰ`** (`lift_oplus_lift_iso_sum`). Element `OrderIso` `sumLiftEquiv` built from
`toSumLift`/`fromSumLift`: the `⊕` of the lifts has tokens `00X'` (`X'∈𝒟`) / `10Y'` (`Y'∈ℰ`) over the
shared bottom; the iso *deletes the inner `0`* (`00X'↔0X'`, `10Y'↔1Y'`). Cross-tag (`0`vs`1`) intersections
vanish by `∅`-freeness — structurally exactly 6.19's `toSum`/`fromSum` with one extra `embBit false`.

**`𝒟_⊥ ⊗ ℰ_⊥ ≅ᴰ (𝒟 × ℰ)_⊥`** (`lift_otimes_lift_iso_lift_prod`) — the answer to Scott's `??`. The smash
of the lifts has proper rectangles `prodTokNbhd (0X') (0Y')`; the lift of the product has `0(prodTokNbhd X' Y')`.
`liftProdEquiv` (`toLiftProd`/`fromLiftProd`) transports one to the other; purely rectangular (no
cross-empties), so cleaner than the sum.

**Gotcha for future work (recorded once).** The reused membership/closure lemmas for `oplusTok`/`sumTok`
(`oplusTok_mem_master`, `sumTok_mem_embF`, `*_mem_embF_inv`, `oplusTok_nonempty`, …) carry the `∅`-free
witnesses `h₀ h₁` as *implicit* arguments that appear **only under `.mem`** — which the unifier reduces
away — so they are **not** inferred from the goal/expected type. Pass them explicitly
(`(h₀ := D.ne) (h₁ := E.ne)`, or use the packaged `(D.lift.oplus E.lift).ne`), or just use `Or.inl rfl`
for master membership. Likewise pass `(D₀ := …) (D₁ := …)` to `sumTokMaster_inter_embF/T` when the goal
spells the system as a `.lift.sys` projection (folded) but the lemma would unfold it (`rw` needs a
syntactic match). This affected ~10 sites here.

**Axioms.** All of `liftTok`, `ScottSys.lift`, order facts, `liftMapTok*`, `lift_oplus_lift_iso_sum`,
`lift_otimes_lift_iso_lift_prod` audit to `{propext, Quot.sound}`; `eq_liftBot_or_exists_liftUp` additionally
uses `Classical.choice` (the lone, called-out excluded-middle split).

---

## Checkpoint — Exercise 6.27 COMPLETE (`Exercise627.lean`, ns `Exercise627`)

**Which subsystem relations `⊴` (Lemma 6.15 *embeds-as-subdomain*) hold.** Verdict: **the first five
hold for all `𝒟,ℰ`; the sixth `𝒟 ⊴ 𝒟⊗ℰ` is false in general.** Wired into `Domain.lean`; full
`Domain` green, zero `sorry`. Concrete `{0,1}*` constructors of Ex 6.19/6.21 + function spaces
(`FunctionSpace.lean`, Ex 5.10).

- **(1) `(𝒟⊗ℰ)◁(𝒟×ℰ)`** `otimesTok_subsystem_prodTok` ⟹ `otimes_trianglelefteq_prod` (`Subsystem.trianglelefteq`): smash is literally a subsystem of the product (same master, sub-family of proper rectangles, boundary-stable intersections).
- **(2) `𝒟 ⊴ 𝒟×ℰ`** `fst_trianglelefteq_prod` via projection pair `fstInj X↦(X,Δ₁)` / `fstProj`, `trianglelefteq_of_projectionPair`.
- **(3) `(𝒟⊕ℰ)◁(𝒟+ℰ)`** `oplusTok_subsystem_sumTok` ⟹ `oplus_trianglelefteq_sum`: coalesced sum drops `0Δ₀`,`1Δ₁`; cross-tag intersections empty.
- **(4) `𝒟 ⊴ 𝒟⊕ℰ`** `inl_trianglelefteq_oplus` via `inlInj`/`inlProj` with `leftN X` (`=0X` proper / `sumTokMaster` at `X=Δ₀`). **Only classical part:** `oplus_mem_leftN` decides the undecidable `X=Δ₀` ⟹ `Classical.choice` (genuinely unavoidable over arbitrary systems; flagged).
- **(5) `(𝒟→⊥ℰ)⊴(𝒟→ℰ)`** `strictFun_trianglelefteq_funSpace` — **general `V₀ V₁`, choice-free**. Inclusion `inclMap` + strictification retraction `strctMap`, built by `ofMono` from elementwise `incl=toFilter∘val∘toStrictMap`, `strct=toStrictFilter∘strictify∘toApproxMap`. New `strictifyMap` (force `Δ₀↦Δ₁`); `strictifyMap_le`, `strictifyMap_of_isStrict`. Crux union formulas `toElementMap_inclMap`/`toElementMap_strctMap` (via `mem_stepFun_iff`/`mem_sstepFun_iff`); then `strct_incl`/`incl_strct_le` collapse via the four equiv-inverse lemmas (`toApproxMap_toFilter`, `toStrictMap_toStrictFilter`, …). Comp laws use a **choice-free** local `ext_of_principal` (extracts `mem` from `rel_dom`, avoiding `ext_of_toElementMap`'s `by_cases` — which silently pulls in `Classical.choice`) and `le_iff_toElementMap_le`.
- **(6) `¬(𝒟 ⊴ 𝒟⊗ℰ)`** `not_trianglelefteq_otimes`: counterexample `ℰ=𝟙` (`unitPt`). `otimes_unitPt_collapse` ⟹ `twoPt⊗𝟙` has only its master ⟹ `subsingleton_element_of_only_master` (one-point lattice), but `twoPt` has two elements — contradicts iso injectivity.

**Axioms.** Parts 1–3, 5, 6 audit to `{propext, Quot.sound}`; part 4 (`inl_trianglelefteq_oplus`)
additionally uses `Classical.choice` (the single documented `X=Δ₀?` split). **Gotcha recorded:** the
standard extensionality `ext_of_toElementMap`/`eq_of_toElementMap_principal` do a `by_cases V₀.mem X`,
which brings in `Classical.choice`; when you need a *choice-free* map equality from agreement on
principals, use the `rel_dom`-based `ext_of_principal` pattern instead.

**Next concrete target:** Exercise 6.29 (infinitary `∑_n D_n`, `∏_n D_n`; `⊕`,`⊗`?).

---

## Checkpoint — Exercise 6.28 COMPLETE (`Exercise628.lean`, ns `Domain.Neighborhood`) — 2026-06-22

**Statement (Plotkin).** If `𝒟,ℰ` are *finite* systems and `𝒟 ⊴ ℰ ⊴ 𝒟`, then `𝒟 ≅ ℰ`. Need the
same for infinite systems? Wired into `Domain.lean`; full `Domain` green, zero `sorry`.

**The one idea.** `⊴` is *stronger* than a plain order embedding (it is a retract), but the proof
only needs the embedding. `Trianglelefteq.elementEmbedding : (D ⊴ E) → Nonempty (|D| ↪o |E|)`:
unfold `⊴` to `e : |D| ≅o |D'|` with `D' ◁ E`; Prop 6.12 turns `D' ◁ E` into the projection pair
`i = hsub.inj`, `j = hsub.proj` with `j ∘ i = I` (`proj_comp_inj`); then `projElementEmbedding i j hji`
is an order embedding `|D'| ↪o |E|` — built by `OrderEmbedding.ofMapLEIff i.toElementMap`, with `≤`
both ways: forward is `toElementMap_mono i`, backward applies the *monotone left inverse* `j`
(`toElementMap_mono j` to `i(a) ⊑ i(b)`, then rewrite by the round-trip
`j(i(x)) = (j∘i)(x) = I(x) = x` from `toElementMap_comp`/`hji`/`toElementMap_idMap`). Compose with
`e.toOrderEmbedding` (`RelEmbedding.trans`).

**Finite Schröder–Bernstein.** `orderIso_of_embeddings {P Q} [Finite P] [Finite Q] (f : P ↪o Q)
(g : Q ↪o P) : Nonempty (P ≃o Q)`: order embeddings are injective, so
`Fintype.card_le_of_injective` both ways gives equal card, `Fintype.bijective_iff_injective_and_card`
makes `f` bijective, and the `OrderIso` is `{ toEquiv := Equiv.ofBijective f hbij,
map_rel_iff' := f.map_rel_iff' }`.

**GOTCHA (recorded).** `StrictMono.orderIsoOfSurjective` needs `[LinearOrder]`; element domains are
only `PartialOrder`. A surjective *strictly monotone* map is **not** an order iso on partial orders
— but a surjective *order embedding* (which reflects `≤`) is. So build the iso from the bijective
embedding's `map_rel_iff'` directly, never via `orderIsoOfSurjective`.

**Finite system.** `NeighborhoodSystem.IsFinite D := Finite {X // D.mem X}` (finitely many
neighbourhoods). `finite_element_of_isFinite : D.IsFinite → Finite |D|`: a filter is pinned by which
neighbourhoods it contains, so `x ↦ {p | x.mem p.1}` injects `|D| ↪ Set {X // D.mem X}` (off-`D`
sets are in neither filter by `x.sub`); finite powerset of a finite type. Faithful theorem
`isomorphic_of_finite_system` just `haveI`s the two `Finite |·|` and calls the core.

**Need the same for infinite systems? No.** Plotkin's argument is a finite cardinality count with no
infinite analogue; the retraction preorder on infinite dcpos fails Cantor–Schröder–Bernstein
(Eilenberg-swindle obstruction). The infinite counterexample is recorded as prose only — out of this
file's scope (would require building two non-isomorphic infinite systems that are mutual retracts).

**Axioms.** `projElementEmbedding`, `Trianglelefteq.elementEmbedding` are choice-free
`{propext, Quot.sound}`. `orderIso_of_embeddings`, `finite_element_of_isFinite`, and both main
theorems add `Classical.choice` (extracting `Fintype` from `Finite` / a section of the surjection) —
genuinely unavoidable and confined to the finite count.

---

## Checkpoint — 2026-06-22 — Exercise 6.29 COMPLETE (infinitary `∑`, `∏`; `⊕` yes, `⊗` no)

`Exercise629.lean` (ns `Domain.Neighborhood.Exercise629`), wired into `Domain.lean`, full `Domain`
green, zero `sorry`. Index family `D : ∀ i, NeighborhoodSystem (α i)` over `α i` (`ℕ` intended).

**The four operations.**
- **`iprod` `∏_i D_i`** — cylinders `iprodNbhd X = {p | p.2 ∈ X p.1}`, `X i ∈ 𝒟ᵢ`, master off a finite
  support. Headline **infinitary Prop 3.2**: `iprodEquiv : |∏_i D_i| ≃o ∀ i, |D_i|` (pointwise order).
- **`isum` `∑_i D_i`** — separated sum over `Option (Σ i, α i)`: basepoint master `sumMasterI` or one
  tagged copy `injI i X`. `isum_trichotomy`, `isum_summand_unique`.
- **`ioplus` `⊕_i D_i`** — coalesced sum (as `∑`, improper copies deleted). Generalizes fine.
- **`iotimes` `⊗_i D_i`** — smash. Proper = every coordinate proper ⟹ over infinite `ι` clashes with
  finite support ⟹ `iotimes_only_master`/`iotimes_subsingleton`: a one-point domain. **`⊗` does not
  generalize.** Answer to Scott's question: `+`,`×`,`⊕` generalize; `⊗` degenerates.

**Choice discipline (the hard part — went from pervasive `Classical.choice` to clean).**
- Finite support is the **positive `List` form** `FinSupp D X := ∃ l, ∀ i, i ∉ l → X i = master`. The
  negative form (`X i ≠ master → i ∈ l`) forces double-negation elimination on undecidable set
  equality (`X i = master`) in `FinSupp.inter`/reconstruction ⟹ choice. The positive form makes both
  constructive (outside `l ++ l'`, `master ∩ master = master`; the support equality `restrictTo l X = X`
  is `(hl j h).symm`).
- `Function.update_eq_self` is **classical** — prove `updTuple D i master = (fun j => master)` by
  `funext` + `by_cases j = i` (`updTuple_apply_self`/`_ne`, both `propext`-only).
- In `injI`-intersection `inter_mem` proofs (`isum`/`ioplus`), do **not** `by_cases i = j` (classical,
  no `DecidableEq`): recover `i = j` constructively from the consistency witness `Z` via
  `index_of_some_mem_injI`. Same trick makes `isum_summand_unique` choice-free.
- Mathlib pitfalls pulling choice: `Set.Finite`, `Function.update_eq_self`, `List.mem_toFinset`,
  `Finite.of_fintype`, `not_forall`/`Infinite.exists_notMem_finset`.

**Axiom audit.** Data `iprod`, `isum`, `ioplus`, `iotimes`, `iprodEquiv`, plus `isum_summand_unique`,
`z_mem_of_slices`, `FinSupp.inter` — all `⊆ {propext, Quot.sound}`. Only `isum_trichotomy` (excluded
middle: does `z` reach a summand?) and `iotimes_subsingleton`/`iotimes_only_master` (cardinality via
classical `Set.Finite`) add `Classical.choice` — both Prop-level, genuinely classical, flagged in
their docstrings and the file header.

**Next concrete target:** Exercise 6.29 is **COMPLETE**; this finishes Lecture VI's formalization. The
next frontier is **Lecture VII** (Defn 7.1 *computable presentation* onward), transcribed/inventoried
but formalization-deferred.

---

## Checkpoint 2026-06-22 — Lecture VII opens: **Definition 7.1 COMPLETE** (`Definition71.lean`)

**Modeling decision (user-chosen).** Lecture VII's "recursive / recursively enumerable" is modeled
with **genuine mathlib recursion theory**: `ComputablePred` (a predicate with a `Decidable` instance
whose `decide` is `Computable`) and `REPred` (domain of a `Partrec` function), over the integer
indices (`ℕ`, `ℕ×ℕ`, `ℕ×ℕ×ℕ` are all `Primcodable`). Imports: `Mathlib.Computability.Partrec` +
`Mathlib.Computability.RE`.

**CHOICE NOTE (applies to *all* of Lecture VII).** mathlib's recursion theory is **classical at its
foundation** — `#print axioms Computable.const` already lists `Classical.choice`. Therefore every
Lecture-VII computability theorem audits as `{propext, Classical.choice, Quot.sound}`. This is
**unavoidable and expected** under the chosen modeling, *not* a discipline slip: the construction
*data* (the enumeration `X`, the index functions) is still explicit and constructive; only the
*computability witnesses* (the `ComputablePred`/`REPred` proofs) are classical. Flag it, don't fight
it.

**What's in `Definition71.lean`:**
- `ComputablePresentation V` (structure): `X : ℕ → Set α`, `mem_X : ∀ n, V.mem (X n)`,
  `surj : V.mem Y → ∃ n, X n = Y`, and Scott's two decidable relations
  `interEq_computable : ComputablePred (fun (t:ℕ×ℕ×ℕ) => X t.1 ∩ X t.2.1 = X t.2.2)` (7.1(i)) and
  `cons_computable : ComputablePred (fun (t:ℕ×ℕ) => ∃ k, X k ⊆ X t.1 ∩ X t.2)` (7.1(ii)).
- `ComputablePresentation.incl_computable` — Scott's biconditional `Xₙ⊆Xₘ ↔ Xₙ∩Xₘ=Xₙ`
  (`Set.inter_eq_left`); proved by reindexing `(n,m)↦(n,m,n)` into (i) via `ComputablePred.computable_iff`
  + `Computable.pair/fst/snd`/`Computable.comp`.
- `ComputablePresentation.eq_computable` — `Xₙ=Xₘ ↔ Xₙ⊆Xₘ ∧ Xₘ⊆Xₙ` (`Set.Subset.antisymm_iff`);
  decision Bool `cond (f (n,m)) (f (m,n)) false` from `incl_computable`'s `f` (used `show … = ((cond …
  : Bool) : Prop)` to force the projections to reduce, then `cases`+`simp`).
- `NeighborhoodSystem.IsEffectivelyGiven V := Nonempty (ComputablePresentation V)`.
- `unitPresentation : ComputablePresentation unitSys` + `unitSys_isEffectivelyGiven` — the constant
  enumeration `Xₙ=Δ=univ`; both relations are always-true (`ComputablePred.computable_iff.2 ⟨fun _ =>
  true, Computable.const true, by funext; simp⟩`).

**Useful mathlib API found.** `ComputablePred` & `REPred` live in `Mathlib.Computability.RE`.
`ComputablePred.computable_iff : ComputablePred p ↔ ∃ f:α→Bool, Computable f ∧ p = fun a => (f a:Prop)`
is the workhorse for building derived deciders. `Computable.find` (in RE) turns a `ComputablePred`
+ totality into a `Computable` `Nat.find` — will be handy for the intersection-index function and
later constructions. `Computable.fst/snd/pair/comp/cond/const` for index plumbing. The Bool→Prop
coercion is `(b : Prop) := (b = true)`.

**Next:** Definition 7.2 — a *computable map* `f : 𝒟 → E` is one whose neighbourhood relation
`Xₙ f Yₘ` is `REPred` in `(n,m)` (r.e., not merely recursive — the `𝒟 = {Δ}` degeneration gives the
*computable element* notion: `{m | Yₘ ∈ y}` is r.e.). Will need the approximable-map infrastructure
(`ApproximableMap`) to phrase `Xₙ f Yₘ`.
