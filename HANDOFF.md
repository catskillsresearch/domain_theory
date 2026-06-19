# Handoff — Scott 1972 Theorem 4.4(c): `i∞ ∘ j∞ = id` on `[D∞ → D∞]`

You are a Lean 4 proof engineer formalizing Dana Scott's 1972 *Continuous Lattices* (LNM 274) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Your sole task this session:** prove **subgoal (c)** of Theorem 4.4 — the *converse* identity
`i∞ ∘ j∞ = id` on `[D∞ → D∞]`. Subgoals (a) and (b) are already **Pass**; (d) packages the two
halves and is left for next session.

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** every new theorem must depend only on `[propext, Classical.choice, Quot.sound]`
  (verify with `#print axioms <thm>`).
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** only touch `Domain/ContinuousLattice/FunctionSpaceTower.lean` (and, if a genuinely
  reusable abstract fact is missing, `InverseLimits.lean`). Match existing naming/style.
- **Update docs on completion:** `arxiv.md` (score line, §4 results table row, blueprint node, proof note).
- Read the source first: `sources/ScottContinLatt1972_vision.md` (Lemma 4.5 ~1304–1320; the converse
  calculation ~1322–1335).

---

## Current status

Report card is currently **36 Pass · 0 Stuck · 2 Not Yet**. Landing (c) → **37 Pass · 0 Stuck · 1 Not
Yet** (only (d) remains). `lake build` is green; no sorries.

| Subgoal | Statement | Lean target | Status |
| ------- | --------- | ----------- | ------ |
| (a) | `i∞`/`j∞` as `ScottMap`s + continuity | `embInfInf` / `projInfInf` | **Pass** |
| (b) | `j∞ ∘ i∞ = id` on `D∞` | `projInfInf_comp_embInfInf` | **Pass** |
| **(c)** | **`i∞ ∘ j∞ = id` on `[D∞ → D∞]`** | **`embInfInf_comp_projInfInf`** | **← THIS SESSION** |
| (d) | package `theorem_4_4` | `theorem_4_4` (mutually-inverse `ScottMap`s / `OrderIso`) | Not Yet |

---

## The objects (all in `FunctionSpaceTower.lean`, section `Thm44b`, `variable (D₀ j₀)`)

- `DInf D₀ j₀ := InverseLimit (towerType D₀) (towerProj D₀ j₀)` — `D∞` (a continuous lattice by `proposition_4_1`).
- `DInfFn D₀ j₀ := ScottMap (DInf D₀ j₀) (DInf D₀ j₀)` — `[D∞ → D∞]`.
- `embInfInf : ScottMap DInf DInfFn` = `i∞`; `projInfInf : ScottMap DInfFn DInf` = `j∞`.
- **`conjMap post pre f = post ∘ f ∘ pre`** (a `ScottMap`). Two abbreviations to internalize:
  - `iInfTerm_apply n x z : (iInfTerm n x) z = embInf n ((x.1 (n+1)) (projInf n z))`
  - `jInfTerm_apply n f : jInfTerm n f = embInf (towerType D₀) (towerProj D₀ j₀) (n+1) (conjMap (projInf .. n) (embInf .. n) f)`
- `projInfInf_apply f : projInfInf f = ⨆ n, jInfTerm n f`; `embInfInf_apply x : embInfInf x = ⨆ n, iInfTerm n x`.

Throughout, write `embInf (towerType D₀) (towerProj D₀ j₀) n` and `projInf (towerType D₀) (towerProj D₀ j₀) n`
(these take `D` and `P` explicitly); `(towerProj D₀ j₀ n).incl/.retr` are `iₙ`/`jₙ`.

---

## Goal

```lean
theorem embInfInf_comp_projInfInf :
    (embInfInf D₀ j₀).comp (projInfInf D₀ j₀) = ScottMap.idMap := by
  apply ScottMap.ext
  intro f
  -- goal: embInfInf (projInfInf f) = f
  ...
```

(`f : DInfFn D₀ j₀`, i.e. a Scott map `D∞ → D∞`.)

---

## Proof plan (Scott ~1322–1335)

Let `u n := conjMap (projInf .. n) (embInf .. n) f : towerType D₀ (n+1)` (the restriction
`j_{∞n} ∘ f ∘ i_{n∞} ∈ D_{n+1}`; it typechecks since `towerType (n+1) ≡ ScottMap (towerType n) (towerType n)`).
Note `projInfInf f = ⨆ n, embInf .. (n+1) (u n)` by `projInfInf_apply` + `jInfTerm_apply` (definitionally `u n`).

### Step 1 — recursion equation for `u` (NEW small lemma)

Prove the Lemma-4.5 hypothesis `j_{n+1}(u_{n+2}) = u_{n+1}`:

```lean
theorem towerProj_retr_conjMap_succ (n : ℕ) (f : DInfFn D₀ j₀) :
    (towerProj D₀ j₀ (n + 1)).retr
        (conjMap (projInf .. (n + 1)) (embInf .. (n + 1)) f)
      = conjMap (projInf .. n) (embInf .. n) f
```

*Proof:* `ScottMap.ext`, `intro y` (`y : towerType n`). `(towerProj (n+1)).retr = (towerProj n).functionSpace.retr
= conjMap (P n).retr (P n).incl`; unfold with `towerProj_succ_retr_apply` (or `dsimp [IsContinuousLatticeProjection.functionSpace]`)
and `conjMap_apply`. The goal becomes
`(P n).retr (projInf (n+1) (f (embInf (n+1) ((P n).incl y)))) = projInf n (f (embInf n y))`.
Close with two facts:
- `embInf_succ .. n y : embInf (n+1) ((P n).incl y) = embInf n y`, and
- `(P n).retr (projInf (n+1) W) = projInf n W` (compatibility `W.2 n`, exactly the rewrite used in the
  already-proven `incl_projInf_le_projInf_succ`).

This is the **equality** counterpart of the inequality `conjMap_incl_le_conjMap_succ` proved for (b);
the proof structure there is your template (same `functionSpace.retr` unfolding, but now an `=`, not `≤`).

### Step 2 — coordinates of `j∞ f` via Lemma 4.5

```lean
have hcoord (n : ℕ) : (projInfInf D₀ j₀ f).1 (n + 1) = conjMap (projInf .. n) (embInf .. n) f
```

`projInfInf f = ⨆ k, embInf .. (k+1) (u k)` (rewrite with `projInfInf_apply`, then `jInfTerm_apply` under
the binder — beware the beta-redex pitfall below; prefer a `calc`/`Eq` term over `rw` for the `⨆`-shape
match). Then apply `lemma_4_5 (towerType D₀) (towerProj D₀ j₀) u (towerProj_retr_conjMap_succ … ) n`.
`lemma_4_5` gives exactly `(⨆ k, embInf (k+1) (u k)).1 (n+1) = u n`.

### Step 3 — unfold `i∞(j∞ f)` to `⨆ₙ rₙ ∘ f ∘ rₙ`

Abbreviate `rₙ z := embInf .. n (projInf .. n z)` (= `((embInf .. n).comp (projInf .. n)) z`, the Prop-4.2
approximation `i_{n∞} ∘ j_{∞n}`). Then `embInfInf (projInfInf f) = ⨆ n, iInfTerm n (projInfInf f)`
(`embInfInf_apply`); evaluate at `z` (`ScottMap.sSup_apply`):

```
(iInfTerm n (projInfInf f)) z
  = embInf n ((projInfInf f).1 (n+1) (projInf n z))         -- iInfTerm_apply
  = embInf n ((conjMap (projInf n)(embInf n) f) (projInf n z))  -- hcoord
  = embInf n (projInf n (f (embInf n (projInf n z))))       -- conjMap_apply
  = rₙ (f (rₙ z)).
```

So the goal reduces to: `⨆ n, rₙ (f (rₙ z)) = f z`.

### Step 4 — confine the lub and apply `idInf_eq_iSup`

This is the one analytic step. Use:
- `idInf_eq_iSup : ScottMap.idMap = ⨆ n, (embInf n).comp (projInf n)`, i.e. `z = ⨆ m, rₘ z` and
  `f z = ⨆ k, rₖ (f z)` (apply the map equation pointwise; `ScottMap.sSup_apply`).
- `f` continuous: `f (⨆ m, rₘ z) = ⨆ m, f (rₘ z)`; each `rₖ` continuous likewise.
- The family `n ↦ rₙ z` is **monotone** (`rₙ z = embInf n (z.1 n)`, and `embInf_le_succ` gives
  `embInf n (z.1 n) ≤ embInf (n+1) (z.1 (n+1))`). Hence `(k,m) ↦ rₖ (f (rₘ z))` is monotone in each index.

Compute `f z = ⨆ k, rₖ (f z) = ⨆ k, rₖ (f (⨆ m, rₘ z)) = ⨆ k, rₖ (⨆ m, f (rₘ z)) = ⨆ k ⨆ m, rₖ (f (rₘ z))`,
then collapse the double sup to the diagonal with the **already-proven**
`iSup₂_monotone_eq_diagonal` → `⨆ n, rₙ (f (rₙ z))`. Done.

(Equivalently, prove `embInfInf (projInfInf f) = (⨆ rₙ).comp (f.comp (⨆ rₙ))` at the `ScottMap` level
and rewrite both `⨆ rₙ = idMap`; but the pointwise route via `iSup₂_monotone_eq_diagonal` reuses existing
machinery and avoids new continuity-of-composition lemmas.)

---

## Reusable lemmas (already proven — do not reinvent)

In `FunctionSpaceTower.lean`:
- `conjMap_apply`, `conjMap_iSup`, `iInfTerm_apply`, `jInfTerm_apply`, `embInfInf_apply`, `projInfInf_apply`
- `towerProj_succ_incl_apply` (`i_{n+1}=iₙ∘·∘jₙ`), `towerProj_succ_retr_apply` (`j_{n+1}=jₙ∘·∘iₙ`), `towerProj_incl_apply`
- `incl_projInf_le_projInf_succ` (`iₙ(yₙ) ⊑ y_{n+1}` — the compatibility-rewrite template for Step 1)
- `conjMap_incl_le_conjMap_succ` (the `≤` sibling of Step 1's equality — copy its `functionSpace.retr/incl` unfolding)
- `iSup₂_monotone_eq_diagonal` (`⨆ₙ⨆ₘ aₙₘ = ⨆ₙ aₙₙ` for separately-monotone `a`) — **used directly in Step 4**
- `iInfTerm_monotone`, `embInf_succ_iSup`

In `InverseLimits.lean`:
- **`lemma_4_5`** `(u : ∀ n, D (n+1)) (hu : ∀ n, (P (n+1)).retr (u (n+1)) = u n) (n) : (⨆ k, embInf (k+1) (u k)).1 (n+1) = u n`
- **`idInf_eq_iSup`** `: ScottMap.idMap = ⨆ n, (embInf n).comp (projInf n)`
- `embInf_succ` `: embInf (n+1) ((P n).incl x) = embInf n x`; `embInf_le_succ` `: embInf n (x.1 n) ≤ embInf (n+1) (x.1 (n+1))`
- `inverseLimit_eq_iSup`, `proposition_4_2` (`.retr_incl` = `projInf n ∘ embInf n = id`), `coe_sSup_of_directed`
- `ScottMap.sSup_apply`, `ScottMap.preservesDirectedSup_coe`, `ScottMap.monotone`, `ScottMap.comp_apply`, `ScottMap.idMap_apply`

---

## Pitfalls (learned the hard way in (b) — read before starting)

1. **`towerType (n+1)` is defeq to `ScottMap (Dₙ) (Dₙ)` but NOT syntactically.** Apply elements via
   `towerCoeFun`/`towerToMap`. When a coercion confuses elaboration, a `show … (… : ScottMap _ _) …`
   or `change` fixes it.
2. **`≤`/`SupSet` instance-path mismatch on `towerType (n+k)`.** Its lattice instance reduces to
   `ScottMap.instCompleteLattice`, but `rw [ScottMap.le_def]` matches *syntactically* and fails (it sees
   `ChainCompletePartialOrder.instOfCompleteLattice.toLE`). Use **`refine ScottMap.le_def.mpr fun y => ?_`**
   (defeq-based) instead of `rw [ScottMap.le_def]`.
3. **Beta-redex after `rw` with a `⨆`/lemma whose RHS is `⨆ m, g (f m)`.** `rw`'s closing `rfl` is
   *reducible*-transparency and won't beta-reduce `(fun m => …) m`. Either append an explicit `rfl`
   (default transparency does beta), or — better — apply the iSup lemma as a **term inside a `calc`**
   (defeq-checked) rather than via `rw` (syntactic `kabstract` match). This bit hard in `hinner`/`conjMap_iSup`.
4. **`set g := … with hg`** makes `g` an opaque fvar; fold/unfold only via `simp only [hg]` / `rw [hg]`
   (plus `dsimp only` to beta-reduce), never rely on defeq.
5. **`conjMap` argument order is `post pre`**: `conjMap post pre f = post ∘ f ∘ pre`. For `j_{∞n}∘f∘i_{n∞}`
   use `conjMap (projInf n) (embInf n)`; for `i_{n∞}∘g∘j_{∞n}` use `conjMap (embInf n) (projInf n)`.
6. `ScottMap.idMap`, never `id` (shadows `Finset.sup id`). Scott topology is a `def`, not an instance.

---

## Workflow

1. Reread `sources/ScottContinLatt1972_vision.md` Lemma 4.5 + converse calc (~1304–1335).
2. Prove `towerProj_retr_conjMap_succ`, then `embInfInf_comp_projInfInf`, sorry-free.
3. `lake build Domain.ContinuousLattice.FunctionSpaceTower` (green).
4. `#print axioms Domain.ContinuousLattice.embInfInf_comp_projInfInf` → `[propext, Classical.choice, Quot.sound]`
   (temp scratch file pattern: a one-line `import … #print axioms …`, build with `lake env lean`, delete).
5. Update `arxiv.md`: score → **37 Pass · 0 Stuck · 1 Not Yet**; §4 table row (c) → **Pass**; blueprint
   node `T44c` → ✓; add a proof note next to the 4.4(a)/(b) notes.

---

## Key reference files

| File | Role |
| ---- | ---- |
| `Domain/ContinuousLattice/FunctionSpaceTower.lean` | tower, `i∞`/`j∞`, (a)+(b) done; add (c) in section `Thm44b` |
| `Domain/ContinuousLattice/InverseLimits.lean` | `D∞`, `embInf`/`projInf`, 4.2/4.3/4.5, `idInf_eq_iSup` |
| `Domain/ContinuousLattice/FunctionSpaces.lean` | `ScottMap`, `conjMap` pattern, Prop 3.7/3.13 |
| `sources/ScottContinLatt1972_vision.md` | primary source |
| `arxiv.md` | tracker + proof notes (update on completion) |
| `Domain.lean` | module imports (already includes `FunctionSpaceTower`) |

After (c) lands, the only remaining work in the whole §4 program is (d): bundle
`projInfInf_comp_embInfInf` and `embInfInf_comp_projInfInf` into `theorem_4_4` (mutually-inverse Scott
maps, or an `OrderIso`).
