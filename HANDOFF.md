# Handoff — Scott 1981 (PRG-19): Lectures I–IV COMPLETE (IV spine Thm 4.1/4.2, Ex 4.3/4.4, Def 4.5 + Thm 4.6, **all Exercises 4.7–4.25**); **Lecture V COMPLETE** (Table 5.5, Thm 5.1/5.2/5.6, Prop 5.3/5.4, **Exercises 5.7–5.16 — including 5.16's full Thue–Morse `t`: unfolding, digit-sum-mod-2 (Lambek), and overlap-freeness**); **Lecture VI: Example 6.1 (`D^§ ≅ D + (D^§×D^§)`), Example 6.2 (`B ≅ B+B`, `C ≅ {{Λ}}+C+C`, the generalization `A ≅ Aⁿ + Aⁿ`, and eventually-periodic trees ↔ regular events via Myhill–Nerode) + categorical spine (Defs 6.3–6.5, Props 6.6–6.7) Definition 6.8 (functors *continuous on maps*, over the strict function space), and **Theorem 6.9 (homomorphisms out of a fixed point `D ≅ T(D)`)**, and **Theorem 6.14 (initial `T`-algebra: existence + uniqueness/initiality among strict algebras)**, **Lemma 6.15 (projection pair ⟹ `D ⊴ E`)** and **Theorem 6.16 (an initial `T`-algebra embeds in every solution: `D ⊴ E` for all `E ≅ T(E)`)** COMPLETE**; rest of VI + VII–VIII transcribed & inventoried

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

**Next concrete target:** **Theorem 6.16 is now COMPLETE** (`Theorem616.lean`,
`trianglelefteq_of_isInitial`: an initial `T`-algebra `D` satisfies `D ⊴ E` for every `E ≅ T(E)` when
`T` is continuous on maps; see the checkpoint at the end of this file). The natural next items are the
remaining Lecture VI entries from `arxiv.md` — **Exercise 6.17** (algebras for which `C` is initial),
**Exercise 6.18** (`D^∞` as an initial algebra / domain-equation solution), **Exercise 6.19** (sum &
product on the category of strict maps), or move into Lecture VII–VIII. **Lemma 6.15 is COMPLETE**
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
  Example 6.1 (the tree algebra `D^§` + the domain equation `D^§ ≅ D + (D^§×D^§)`), Example 6.2
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

### Lecture VI — Example 6.1, the tree algebra `D^§` and its domain equation (most recent work)

**`Example61.lean` — DONE, fully choice-free `[propext, Quot.sound]`** (even the equation iso and the
order-injection lemmas; no `ext_of_toElementMap` needed). Scott's `D^§` over a fixed domain `D`:
- **Tokens** `Γ = {1,2}* 0 Δ` modelled as `List Bool × α` (`true=1`, `false=2`), master
  `Gamma D = {t ∣ t.2 ∈ Δ}`. Three set embeddings `embZero X = 0X`, `embL P = 1P`, `embR Q = 2Q`,
  `embPair P Q = 1P ∪ 2Q` (set-builder, *not* `Set.image` — membership lemmas are `Iff.rfl`), with a
  tight intersection/subset/injectivity/disjointness API (`embPair_inter`, `embPair_subset`,
  `embZero_inter_embPair`, `embPair_injective`, …).
- **The system** `Dsharp D hD` (`hD : ∀ X, 𝒟.mem X → X.Nonempty` = Scott's standing `∅∉𝒟`). Its `mem`
  is the inductive `MemS D` (least family with `Γ`, `0X`, `1P∪2Q`). The crux **`memS_inter`** is
  Scott's "induction on the number of steps to put `X`,`Y` into `𝒟^§`": cross cases collapse to `∅`,
  killed by `memS_nonempty` (every member non-empty, the only use of `hD`); the `0A∩0B` case uses
  `𝒟`'s own closure, the `(1P∪2Q)∩(1P'∪2Q')` case recurses. Inversions `memS_embZero_inv`/
  `memS_embPair_inv` recover the constructor from the shape (the `generalize … cases` idiom).
- **The domain equation** `dsharp_domain_equation : Dsharp D hD ≅ᴰ sum D (prod (Dsharp D hD)
  (Dsharp D hD)) hD (prod_dsharp_nonempty D hD)` — i.e. `D^§ ≅ D + (D^§ × D^§)` against the project's
  `+` (Ex 3.18) and `×` (Def 3.1). Built as the explicit order-iso `dsharpEquiv` from the filter maps
  `toS` (forward) / `fromS` (inverse), inverse laws `fromS_toS`/`toS_fromS`, and `map_rel_iff'`. The
  three-way branch (⊥ / `0`-branch / pair-branch) is forced by non-emptiness; sum-side inversions
  `sum_mem_inj₀_inv`/`sum_mem_inj₁_inv` and the helper iffs `toS_mem_inj₀`/`toS_mem_inj₁`/
  `fromS_mem_embZero`/`fromS_mem_embPair` keep the inverse-law proofs short.
- **Injections** `inSharp` (`x^§ = {Γ}∪{0X∣X∈x}`, `inSharp_le_iff`) and `pairSharp`
  (`⟨x,y⟩ = {Γ}∪{1P∪2Q∣P∈x,Q∈y}`, `pairSharp_le_iff`) — Scott's *isomorphic injections*
  `λx.x^§ : D→D^§` and `λx,y.⟨x,y⟩ : D^§×D^§→D^§`; `⊥ = {Γ}` is the system's own `bot`.
- **Pitfalls (re)learned:** (1) section `variable`s used *only in a proof body* (e.g. `hD` in the
  `≠`-shape lemmas whose statement mentions only `D`) are **not** auto-included — add `include hD`.
  (2) `Set.notMem_empty` (not `not_mem_empty`). (3) feeding a member `(p',a)∈P` to `hP : P ⊆ Gamma D`
  when the goal is `(p,a)∈Gamma D` fails elaboration order (it unifies `?x` from the goal) — bind
  `have h := hP …; exact h` so the membership is elaborated first and `exact` closes by defeq.

**What's NOT done in VI (good stopping point):** the
*initial-algebra/homomorphism* `g : D^§ → E` part of Example 6.1 (the `out`/`proj`/`atom` predecessors
and the fixed-point `g` — connects `D^§` to the 6.4 `T`-algebra spine, but needs the `cond`-style
recursion over `D^§`), and everything from Definition 6.8 onward (functors continuous on maps, Theorem
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
- **Exercise 5.11** (`Exercise511.lean`) — `D^∞ = iterSys D` as stacks: `head`/`tail`/`push` from
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
  - **Universal argument domain** `𝒩 := iterSys N` (`N^∞`, Exercise 3.16): a `k`-ary function is one
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

- **3.16** (`Exercise316.lean`) — the infinite iterate `𝒟^∞` over `ℕ × Δ` via fibers + cofinite-`Δ`
  bound: `iterSys` is a system, `iterSeqEquiv : |𝒟^∞| ≃o (ℕ → |𝒟|)`, and `𝒟^∞ ≅ 𝒟 × 𝒟^∞`
  (`iter_isomorphic`); plus `component`, `ofSeq`, `projN`.
- **3.17** (`Exercise317.lean`) — `B` is a **retract** of `T^∞`: section `f : B → T^∞`, retraction
  `g : T^∞ → B`, with `gf_eq_id : g ∘ f = I_B`, `fg_le_id : f ∘ g ⊑ I_{T^∞}`, and `f_injective`.
  Encoding `encSet σ` pins copy `i` to `bitNbhd σ[i]`; key lemma `prefix_of_encSet_subset`.
- **3.24(ii)** (`Exercise324Iter.lean`) — `(𝒟₀→𝒟₁^∞) ≅ (𝒟₀→𝒟₁)^∞` (`funIter_isomorphic`), via
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
| VI  | §4.2.VI   | 29 | Domain equations, functors, initial `T`-algebras (**14/29: Example 6.1 (`D^§≅D+(D^§×D^§)`), Example 6.2 (`B≅B+B`, `C≅{{Λ}}+C+C`, the generalization `A≅Aⁿ+Aⁿ`, eventually-periodic ↔ regular), Defs 6.3–6.5, Props 6.6–6.7, Def 6.8 (continuous on maps), Thm 6.9 (homomorphisms out of a fixed point), Def 6.10 (the subsystem relation `D◁E`), Prop 6.11 (the subsystems of `E` form a domain), Prop 6.12 (`D◁E` ⟹ a projection pair `i,j`), Def 6.13 (monotone / continuous on domains), Thm 6.14 **existence half** (the colimit `𝒟=⋃ₙTⁿ({Γ})`, `T(𝒟)=𝒟`, the algebra, homomorphism existence via 6.9, and the `⋃ₙρₙ=I_𝒟` chain; **uniqueness/initiality still TODO** — the `T(ρₙ)=ρₙ₊₁` HEq lemma) — categorical spine + concrete equations + the homomorphism-existence theorem + the subsystem relation + its domain structure + the projection pair + the domain-level functor continuity conditions + the iterated-functor colimit solution + Lemma 6.15 (projection pair ⟹ `D⊴E`, the converse of 6.12)**) | 3208–4188 |
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
  *non-flat* — the successor has an infinite fixed point `infElt = 1^∞` (`infElt_eq`) absent from the
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
- `iterSys V : NeighborhoodSystem (ℕ × α)` (the `𝒟^∞`), `component n`, `ofSeq`, `projN`,
  `iterSeqEquiv : |iterSys V| ≃o (ℕ → V.Element)`, `iter_isomorphic : iterSys V ≅ᴰ prod V (iterSys V)`.

### Fixed points (`Theorem41.lean`) — Lecture IV §4, Theorems 4.1 & 4.2
- `f.iterMap n` (`fⁿ`, `f⁰=idMap`, `f^{n+1}=f.comp (fⁿ)`); `iterMap_mono_map`, `iter_comm`,
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
