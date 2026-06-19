# Handoff — Scott 1972 §4 Theorem 4.4 (fresh session)

You are a Lean 4 proof engineer formalizing Dana Scott's 1972 paper *Continuous Lattices* (LNM 274) in the repository:

`/home/catskills/Desktop/domain_theory`

**Your sole task this session:** finish **Theorem 4.4** — prove `D∞ ≅ [D∞ → D∞]` (the domain equation). Everything else in §4 is already done; only the final isomorphism remains, split into four subgoals **(a)–(d)** below.

---

## Hard constraints

- **Zero `sorry`s.** Every theorem must compile and pass `lake build`.
- **Axiom footprint:** every new theorem must depend only on `[propext, Classical.choice, Quot.sound]` (verify with `#print axioms`).
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** only touch files needed for 4.4; match existing naming/style.
- **Update docs on completion:** `HANDOFF.md` and `arxiv.md` (score, results table, blueprint, §3.7 proof note).
- Read the exact statement first: `sources/ScottContinLatt1972_vision.md` (~lines 1276–1335).

---

## Current status (36 Pass · 0 Stuck · 2 Not Yet)

- §3 complete; §4.1–4.3 + **Lemma 4.5** done; **Thm 4.4(a) and (b) done** (`embInfInf`/`projInfInf`, `projInfInf_comp_embInfInf`).
- **Thm 4.4 scaffolding built** in `Domain/ContinuousLattice/FunctionSpaceTower.lean`.
- `lake build` green; no sorries in the codebase.
- mathlib `v4.30.0`; module root `Domain.lean` already imports `FunctionSpaceTower`.

### Report-card subgoals for Thm 4.4

| Subgoal | Lean target(s) | Status |
| ------- | -------------- | ------ |
| **(a)** | Define `i∞` / `j∞` as `ScottMap`s; prove Scott continuity | **Pass** (`embInfInf`/`projInfInf`, `iInfTerm`/`jInfTerm`, `*_apply`) |
| **(b)** | Prove `j∞ ∘ i∞ = id` on `D∞` | **Pass** (`projInfInf_comp_embInfInf`) |
| **(c)** | Prove `i∞ ∘ j∞ = id` on `[D∞ → D∞]` | **Not Yet** |
| **(d)** | Package `theorem_4_4` (`OrderIso` or mutually-inverse `ScottMap`s) | **Not Yet** |

Work one subgoal per session if possible. Mark each **Pass** in `arxiv.md` as it lands.

---

## Mathematical goal (Scott 4.4)

Start from a continuous lattice `D₀` and a chosen base projection
`j₀ : [D₀ → D₀] → D₀` (e.g. `Proposition313.projection` from Prop 3.13).

Build the ω-system recursively:

- `D_{n+1} = [Dₙ → Dₙ]`
- `j_{n+1} = [jₙ → jₙ]` (function-space functor, Prop 3.7)

Let `D∞` be the inverse limit. **Theorem 4.4:** `D∞` is homeomorphic to `[D∞ → D∞]`.

Scott's maps (monotone lubs of conjugations):

```
i∞(x) = ⨆ₙ (i_{n∞} ∘ x_{n+1} ∘ j_{∞n})
j∞(f) = ⨆ₙ i_{(n+1)∞}(j_{∞n} ∘ f ∘ i_{n∞})
```

Prove `j∞ ∘ i∞ = id` and `i∞ ∘ j∞ = id`, bundle as mutually inverse `ScottMap`s (and/or `OrderIso` if convenient).

**Note:** In this formalization, "homeomorphic" is realized at the Scott/order level via mutually inverse Scott-continuous maps between complete lattices — consistent with how the rest of §4 is done. Do not open the subspace-Scott-topology trap.

---

## Existing infrastructure (use these; do not reinvent)

### Abstract inverse-limit API — `Domain/ContinuousLattice/InverseLimits.lean`

Section `InverseLimit` is parameterized by:

- `D : ℕ → Type u` with `[CompleteLattice (D n)]`
- `P : ∀ n, IsContinuousLatticeProjection (D n) (D (n + 1))`

Key names:

- `InverseLimit D P` — `D∞` as compatible sequences
- `embInf n` / `projInf n` — Scott maps `i_{n∞}` / `j_{∞n}`
- `proposition_4_2` — each `⟨embInf n, projInf n⟩` is a projection; **`retr_incl`** gives `projInf n ∘ embInf n = id` on `D n`
- `embInf_succ` — recursion `i_{(n+1)∞} ∘ iₙ = i_{n∞}`
- `inverseLimit_eq_iSup` — `x = ⨆ₙ i_{n∞}(xₙ)` for `x ∈ D∞`
- `idInf_eq_iSup` — **`id_{D∞} = ⨆ₙ (embInf n).comp (projInf n)`** ("remark after 4.2")
- `lemma_4_5` — if `u : ∀ n, D (n+1)` satisfies `j_{n+1}(u_{n+2}) = u_{n+1}`, then `(⨆ₖ i_{(k+1)∞}(uₖ))_{n+1} = uₙ`
- `coconeInf` + `coconeInf_preservesDirectedSup` — template for proving a sup-of-maps `f∞` is Scott-continuous (Cor 4.3)

### Function-space tower — `Domain/ContinuousLattice/FunctionSpaceTower.lean`

Concrete instantiation for 4.4:

- `CLat` — bundled `carrier` + `CompleteLattice` (needed because `D_{n+1}` depends on lattice structure at `n`)
- `towerCLat D₀ n`, `towerType D₀ n` — the tower `D₀, [D₀→D₀], …`
- `towerType_succ` — **`D_{n+1} = ScottMap (Dₙ) (Dₙ)` by `rfl`**
- `towerCoeFun` — apply `f : D_{n+1}` as a function `Dₙ → Dₙ`
- `conjMap post pre` — Scott-continuous `f ↦ post ∘ f ∘ pre`
- `IsContinuousLatticeProjection.functionSpace` — continuous Prop 3.7 on diagonal `[D→D]`
- `towerProj D₀ j₀ n` — projection tower `j_{n+1} = [jₙ → jₙ]`
- `towerProj_succ_incl_apply` — `i_{n+1}(x) = iₙ ∘ x ∘ jₙ`
- `towerProj_succ_retr_apply` — `j_{n+1}(x') = jₙ ∘ x' ∘ iₙ`
- `towerProj_incl_apply` — `iₙ(f(x)) = i_{n+1}(f)(iₙ(x))`

### Wiring the concrete `D∞`

Instantiate the abstract API with:

```lean
def D := towerType D₀
def P := towerProj D₀ j₀
def DInf := InverseLimit (towerType D₀) (towerProj D₀ j₀)
def DInfFn := ScottMap DInf DInf
```

`proposition_4_1` already shows `DInf` is a continuous lattice (retract route).

Base projection example:

```lean
noncomputable def baseProj : IsContinuousLatticeProjection D₀.carrier (ScottMap D₀.carrier D₀.carrier) :=
  Proposition313.projection
```

---

## Proof plan — four subgoals

### (a) Define `i∞` and `j∞` as Scott maps

Suggested names: `embInfInf` / `projInfInf` or `iInf` / `jInf` (match local style).

**`i∞`:** For `x : DInf`, define as a `ScottMap DInf DInfFn` by:

```lean
⨆ n, (embInf n).comp (conjMap (projInf n) (embInf n) (x.1 (n+1)))
```

i.e. Scott's `i_{n∞} ∘ x_{n+1} ∘ j_{∞n}`. Use `conjMap` from the tower file.

**`j∞`:** For `f : ScottMap DInf DInf`,

```lean
⨆ n, embInf (n+1) (conjMap (projInf n) (embInf n) f)
```

i.e. `i_{(n+1)∞}(j_{∞n} ∘ f ∘ i_{n∞})`.

**Continuity:** Model on `coconeInf_preservesDirectedSup` and `conjMap_preservesDirectedSup`. You will need:

- directed sups in `DInf` are pointwise (`coe_sSup_of_directed`)
- directed sups in `ScottMap` are pointwise (`ScottMap.sSup_apply`)
- `iSup_comm` for double sups over `ℕ × S`

**Deliverable:** `embInfInf` / `projInfInf` (or similar) as `ScottMap`s + continuity lemmas.

> **(a) DONE.** Implemented in `FunctionSpaceTower.lean`, section `LimitMaps`. Concrete API:
> - `DInf D₀ j₀ := InverseLimit (towerType D₀) (towerProj D₀ j₀)`, `DInfFn D₀ j₀ := ScottMap DInf DInf`.
> - `iInfTerm D₀ j₀ n : ScottMap DInf DInfFn` `= (conjMap (embInf .. n) (projInf .. n)).comp (projInf .. (n+1))`
>   with `iInfTerm_apply : (iInfTerm n x) z = embInf n ((x.1 (n+1)) (projInf n z))` (`rfl`).
> - `jInfTerm D₀ j₀ n : ScottMap DInfFn DInf` `= (embInf .. (n+1)).comp (conjMap (projInf .. n) (embInf .. n))`
>   with `jInfTerm_apply : jInfTerm n f = embInf (n+1) (conjMap (projInf n) (embInf n) f)` (`rfl`).
> - `embInfInf := ⨆ n, iInfTerm n`, `projInfInf := ⨆ n, jInfTerm n` (sups of Scott maps ⇒ Scott maps).
> - `embInfInf_apply : embInfInf x = ⨆ n, iInfTerm n x`; `projInfInf_apply : projInfInf f = ⨆ n, jInfTerm n f`.
> - `embInfInf_preservesDirectedSup` / `projInfInf_preservesDirectedSup` (via `proposition_2_5` + `.continuous`).
>
> Note the `conjMap` argument order: **`conjMap post pre f = post ∘ f ∘ pre`**. For `i∞` use
> `conjMap (embInf n) (projInf n)` (post `= i_{n∞}`, pre `= j_{∞n}`); for `j∞` use
> `conjMap (projInf n) (embInf n)` (post `= j_{∞n}`, pre `= i_{n∞}`).

---

### (b) Prove `j∞ ∘ i∞ = id` on `DInf`

Scott's calculation (~lines 1290–1294):

1. Expand `j∞(i∞(x))` as a double sup `⨆ₙ ⨆ₘ …`
2. Use `towerProj_succ_incl_apply` / `towerProj_succ_retr_apply` (or abstract `embInf`/`projInf` recursion) to rewrite inner terms
3. **Collapse monotone double sup to diagonal** — likely needs a small helper lemma (e.g. if `a_{n,m}` is monotone in both arguments and `a_{n,n} = b_n` with `b` monotone, then `⨆ₙ ⨆ₘ a_{n,m} = ⨆ₙ b_n`). Mathlib: `Monotone.iSup_nat_add`, `iSup_comm`, possibly `iSup_iSup_ge_nat_add`.
4. Use `projInf ∘ embInf = id` (`proposition_4_2.retr_incl` / `iComp_self`) to simplify
5. Finish with `inverseLimit_eq_iSup`

**Deliverable:** e.g. `projInfInf_comp_embInfInf` or `jInf_comp_iInf_eq_id`.

---

### (c) Prove `i∞ ∘ j∞ = id` on `[D∞ → D∞]`

Scott's calculation (~lines 1324–1334):

1. Show `(j∞ f).1 (n+1)` = restriction `j_{∞n} ∘ f ∘ i_{n∞}` at level `n+1`
2. Verify recursion hypothesis for **`lemma_4_5`**: `j_{n+1}(u_{n+2}) = u_{n+1}` where `u_n = j_{∞(n-1)} ∘ f ∘ i_{(n-1)∞}` (shift indices carefully). Use `embInf_succ` + compatibility of `f` with tower maps.
3. Apply `lemma_4_5` to identify `(j∞ f)_{n+1}`
4. Compute `i∞(j∞ f) = ⨆ₙ i_{n∞} ∘ j_{∞n} ∘ f ∘ i_{n∞} ∘ j_{∞n}`
5. Use continuity of `f` to factor the right-hand lub: `… = (⨆ₙ i_{n∞}∘j_{∞n}) ∘ f ∘ (⨆ₙ i_{n∞}∘j_{∞n})`
6. Apply **`idInf_eq_iSup`** → `f`

**Deliverable:** e.g. `embInfInf_comp_projInfInf` or `iInf_comp_jInf_eq_id`.

---

### (d) Package `theorem_4_4`

```lean
theorem theorem_4_4 (D₀ : CLat) (j₀ : …) :
    ∃ (i∞ j∞ : …), j∞.comp i∞ = ScottMap.idMap ∧ i∞.comp j∞ = ScottMap.idMap
```

or an `OrderIso` between `DInf` and `ScottMap DInf DInf` if that fits cleanly.

Put final theorem in `FunctionSpaceTower.lean` (or a small `Theorem44.lean` if the file grows too large — add to `Domain.lean` if so).

**Deliverable:** `theorem_4_4`; report card → **38 Pass · 0 Stuck · 0 Not Yet**.

---

## Conventions / pitfalls (learned the hard way)

1. **`ScottMap.idMap`**, not `id` (shadows `Finset.sup id`).
2. **Scott topology is a `def`, not a global instance.** Only `letI := scottTopologicalSpace` inside continuity proofs.
3. **`towerType (n+1)` is defeq to `ScottMap …` but not syntactically** — use `towerCoeFun` / `towerToMap` to apply `D_{n+1}` elements as functions.
4. **`Nat.leRecOn` is `@[elab_as_elim]`** — unfold with `simp only [embLE]` before `rw`/`exact` on computation lemmas.
5. **Directed sups in `InverseLimit` and `ScottMap` are pointwise** — use `coe_sSup_of_directed`, `ScottMap.sSup_apply`, `sSup_apply_eq_sSup_image`, `Set.image_image`.
6. **Binder trap:** write `∀ f : ScottMap D D, …`, not `∀ f, (f : D → D) …`.
7. **`InverseLimit` and `Projections` are `abbrev`** subtypes so instances resolve.
8. **`IsContinuousLattice` is purely order-theoretic** — no topology needed for lattice structure proofs.

---

## Per-subgoal workflow

1. Read Scott's statement in `sources/ScottContinLatt1972_vision.md`.
2. Implement sorry-free in Lean.
3. `lake build Domain.ContinuousLattice.FunctionSpaceTower` (or affected module).
4. `#print axioms` on new lemmas.
5. Update `arxiv.md`: mark subgoal **Pass**; when all four pass, score → **38 Pass · 0 Stuck · 0 Not Yet**.
6. Update `HANDOFF.md`: mark subgoal done; remove from Remaining when (d) lands.

---

## Suggested first actions

1. Read `FunctionSpaceTower.lean` and the end of `InverseLimits.lean` (`idInf_eq_iSup`, `lemma_4_5`, `coconeInf_preservesDirectedSup`).
2. Wire `DInf := InverseLimit (towerType D₀) (towerProj D₀ j₀)` and check `proposition_4_1` applies.
3. **Subgoal (a):** define `i∞`/`j∞` and prove Scott continuity.
4. **Subgoal (b):** `j∞ ∘ i∞ = id`.
5. **Subgoal (c):** `i∞ ∘ j∞ = id`.
6. **Subgoal (d):** package `theorem_4_4`, build, check axioms, update docs.

---

## Reference files

| File | Role |
| ---- | ---- |
| `sources/ScottContinLatt1972_vision.md` | Primary source (~1276–1335) |
| `HANDOFF.md` | Overall project status |
| `HANDOFF-Theorem-4.4.md` | This file — 4.4-specific session prompt |
| `arxiv.md` | Tracker + proof notes |
| `Domain/ContinuousLattice/InverseLimits.lean` | `D∞`, `embInf`/`projInf`, 4.2–4.3, 4.5, `idInf_eq_iSup` |
| `Domain/ContinuousLattice/FunctionSpaceTower.lean` | Tower + where to add 4.4 |
| `Domain/ContinuousLattice/FunctionSpaces.lean` | `ScottMap`, `conjMap` pattern, Prop 3.7/3.13 |
| `Domain.lean` | Module imports |

The hard infrastructure is done; what remains is defining `i∞`/`j∞` and the two inverse calculations, one subgoal at a time.
