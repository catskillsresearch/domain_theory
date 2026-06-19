# Handoff — Scott 1972 "Continuous Lattices" formalization

**Project:** Lean 4 formalization of Scott 1972 *Continuous Lattices* (LNM 274) in
`/home/catskills/Desktop/domain_theory`, mathlib `v4.30.0`.
Source OCR: `sources/ScottContinLatt1972_vision.md`. Narrative + tracker: `arxiv.md`.

## Status

- Report card: **35 Pass · 0 Stuck · 3 Not Yet** (zero `sorry`s). Thm 4.4 split into subgoals (a)–(d); **(a) Pass**.
- HEAD `e344fc0`, working tree clean, `lake build` green.
- Every proven result has axiom footprint `[propext, Classical.choice, Quot.sound]`.
- Done through **§3 complete** and **§4.1–4.3 + Lemma 4.5**; **Thm 4.4 infrastructure built + (a) done**
  (`embInfInf`/`projInfInf` defined as Scott maps; continuity free as sups of Scott maps).
- **4.4 session prompt:** `HANDOFF-Theorem-4.4.md` (paste into a fresh chat).

## Remaining (Scott §4) — Thm 4.4 subgoals

Capstone `D∞ ≅ [D∞ → D∞]`. Scaffolding is in `FunctionSpaceTower.lean`; abstract API in
`InverseLimits.lean`. Work one subgoal per session.

| Subgoal | Task | Lean target(s) |
| ------- | ---- | -------------- |
| **(a)** ✅ | Define `i∞`/`j∞` as `ScottMap`s; prove continuity | **DONE**: `embInfInf` / `projInfInf` (+ `iInfTerm`/`jInfTerm`, `*_apply`, `*_preservesDirectedSup`) in `FunctionSpaceTower.lean` |
| **(b)** | `j∞ ∘ i∞ = id` on `D∞` | `projInfInf_comp_embInfInf` (double-sup collapse + `inverseLimit_eq_iSup`) |
| **(c)** | `i∞ ∘ j∞ = id` on `[D∞→D∞]` | `embInfInf_comp_projInfInf` (`lemma_4_5` + `idInf_eq_iSup`) |
| **(d)** | Package the theorem | `theorem_4_4` (`OrderIso` or mutually-inverse `ScottMap`s) |

Reusable: `embInf`/`projInf`, `embInf_succ`, `inverseLimit_eq_iSup`, **`idInf_eq_iSup`**,
**`lemma_4_5`**, `coconeInf_preservesDirectedSup`; tower in `FunctionSpaceTower.lean`.

## Key reusable infrastructure

- `Domain/ContinuousLattice/FunctionSpaces.lean`: `ScottMap`, `ScottMap.{idMap,comp,const,sup,sSup}`,
  `IsContinuousLatticeProjection` / `IsContinuousLatticeRetraction`, `proposition_2_10_a`
  (retract of a CL is a CL — purely order-theoretic), Props 3.2–3.5, 3.10 (fwd+converse),
  3.12 (`Projections`/`J_D`), 3.13 (`con`/`min`), 3.14 (`fix`).
- `Constructions.lean`: `proposition_2_9_a` (∏ of CLs is a CL), `scottExtend` + `scottExtend_maximal`
  / `scottExtend_maximal_le` (Prop 3.8).
- `Theorem212.lean`: `lemma_3_9`, `theorem_2_12` (injective ⟺ continuous lattice).
- `InverseLimits.lean`: `InverseLimit D P`, `Compatible`, `projection_galoisConnection` (`iₙ ⊣ jₙ`),
  `retr_sInf`, `invLimRetr` (left adjoint of inclusion), `invLimRetr_galoisConnection`,
  `coe_sSup_of_directed`, `inverseLimitRetraction`, `proposition_4_1`; **(4.2)** `embLE`/`projLE`
  towers (+ `_self`/`_succ`/`_succ_left`/`projLE_retr`/`projLE_compatible`/`embLE_le`), `iComp`
  (+ `iComp_self`/`iComp_compatible`/`iComp_incl_le`/`iComp_preservesDirectedSup`), `embInf`/`projInf`
  ScottMaps, `proposition_4_2`, `embInf_succ` (recursion), `inverseLimit_eq_iSup` (monotone lub);
  **(4.3)** `coconeInf` (`f∞(x)=⊔ₙfₙ(xₙ)`) + `coconeInf_climb`/`coconeInf_descend`/
  `coconeInf_comp_embInf` (factorization `fₙ=f∞∘i_{n∞}`)/`coconeInf_preservesDirectedSup`,
  `corollary_4_3` (∃! continuous mediating map — the direct-limit universal property);
  **(remark after 4.2)** `idInf_eq_iSup` (`id_{D∞}=⨆ₙ i_{n∞}∘j_{∞n}`); **(4.5)** `lemma_4_5`
  (recognize projections from limits — the key tool for the `i∞∘j∞=id` half of 4.4).
- `FunctionSpaceTower.lean` (**Thm 4.4 scaffolding**): `CLat` (bundled lattice for recursion),
  `towerCLat`/`towerType` (`Dₙ`: `D₀`, `[D₀→D₀]`, …) with carried `CompleteLattice` instances,
  `towerType_succ` (`D_{n+1}=[Dₙ→Dₙ]` by `rfl`) + `towerCoeFun` (apply a `D_{n+1}` element as a
  function); `conjMap` (`f↦post∘f∘pre`, Scott-continuous), `IsContinuousLatticeProjection.functionSpace`
  (continuous Prop 3.7 on the diagonal: `[D→D]` is a projection of `[D'→D']`), `towerProj`
  (`j_{n+1}=[jₙ→jₙ]` from a base `j₀`), and the recursion/algebra laws `towerProj_succ_incl_apply`
  (`i_{n+1}(x)=iₙ∘x∘jₙ`), `towerProj_succ_retr_apply` (`j_{n+1}=jₙ∘·∘iₙ`), `towerProj_incl_apply`
  (`iₙ(f(x))=i_{n+1}(f)(iₙ(x))`).

## Conventions / lessons that matter

- `IsContinuousLattice` is **purely order-theoretic**; the retract route (2.9a + 2.10a) proves
  continuity with no topology. This is how 4.1 avoids the subspace-Scott-topology soundness trap.
- Projections give an adjunction `iₙ ⊣ jₙ`: upper adjoint `jₙ` preserves infima; lower adjoint
  preserves suprema (`GaloisConnection.{u_sInf,l_sSup}`). This is the workhorse for §4.
- Scott topology is a `def`, **not an instance**. Use `letI : TopologicalSpace _ := scottTopologicalSpace`
  **scoped inside the continuity `have`** only — a top-level `letI` makes the lattice `≤` ambiguous
  (re-resolved via `specializationPreorder`) and silently breaks `le_antisymm`/`calc`.
- Subtypes carrying lattice structure should be `abbrev` (so `Subtype` instances resolve), as with
  `Projections` and `InverseLimit`.
- Name the identity Scott map `idMap`, not `id` (avoid shadowing `_root_.id`, needed by `Finset.sup id`).
- Coordinatewise `sInf`/`sSup` of a `Pi` type: `sInf_apply_eq_sInf_image` / `sSup_apply_eq_sSup_image`.
  Close the resulting set equalities with `Set.image_image` + `Set.image_congr` (not `ext`, whose
  membership unfolds to `Function.eval` with the wrong orientation).
- Unannotated binders + coercion ascription is a trap: `∀ f, (f : D → D) …` *fixes* the binder type
  to `D → D`. Write `∀ f : ScottMap D D, …`.
- Dependently-typed towers over `Dₙ` (§4): use `Nat.leRecOn` to define `Dₙ → D_m` directly (no
  `Nat`-subtraction casts; descend uses motive `C k := D k → Dₘ`) and `induction n, h using
  Nat.le_induction` to reason. `Nat.leRecOn` is `@[elab_as_elim]`: unfold the wrapper def with
  `simp only [embLE]` *before* `rw`/`exact`-ing `Nat.leRecOn_self/_succ/_succ_left`; term-mode
  `:= Nat.leRecOn_self x` fails ("failed to elaborate eliminator"). Definitional proof irrelevance
  makes the towers independent of which `≤` proof is passed, so `rw` chains match freely.

## Per-theorem workflow

1. Read the exact statement in `sources/ScottContinLatt1972_vision.md`.
2. Prove sorry-free; build the affected module (`lake build Domain.ContinuousLattice.<Mod>`).
3. `#print axioms <thm>` — expect `[propext, Classical.choice, Quot.sound]`.
4. Update `arxiv.md`: score line, §3.1 results table row, blueprint (§3.6 for §4), add a proof note
   under §3.7 (statement, proof sketch, engineering lessons, footprint).
5. Add new modules to `Domain.lean`. Commit + push **only when asked**.

**Thm 4.4:** use `HANDOFF-Theorem-4.4.md`; work one subgoal (a)–(d) per session; mark each row Pass
in the results table as it lands.
