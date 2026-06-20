# Handoff — Scott 1981 (PRG-19): Lectures I–III COMPLETE; IV–VIII transcribed & inventoried

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`, Lean toolchain per `lean-toolchain`.

## Where things stand

- **`lake build Domain` is green, zero `sorry`s** (≈3015 jobs).
- **Lecture I (43), Lecture II (22), Lecture III (29) = 94 numbered results/exercises are Pass.**
  Lecture III is now **complete end-to-end**: the spine (Def 3.1 → Thm 3.13) *and* every §3 exercise
  (3.14–3.28).
- **Lectures IV–VIII are now fully transcribed** in `sources/PRG19_vision.md` (all eight lectures,
  ≈5340 lines) **and fully inventoried** in `arxiv.md` §4.2.IV–VIII as Goal Lists (Lean column `—` =
  not yet formalized). This is the next frontier.

### Lecture III exercises completed (most recent work)

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

## What's next: Lectures IV–VIII (transcribed, NOT yet formalized)

The Goal Lists are in `arxiv.md`:

| Lecture | arxiv § | Rows | Theme | Source lines |
| ------- | ------- | ---- | ----- | ------------ |
| IV  | §4.2.IV   | 25 | Fixed points & recursion (`fix`, `N`, Peano models) | 1647–2382 |
| V   | §4.2.V    | 16 | Typed λ-calculus, λ-definability of partial recursive | 2383–3207 |
| VI  | §4.2.VI   | 27 | Domain equations, functors, initial `T`-algebras | 3208–4188 |
| VII | §4.2.VII  | 24 | Computability in effectively given domains, power domain | 4189–4728 |
| VIII| §4.2.VIII | 26 | Retracts of the universal domain `U` | 4729–5336 |

**Suggested first target: Theorem 4.1 + Theorem 4.2** (least fixed point `fix(f)=⊔ₙ fⁿ(⊥)` and that
`fix : (D→D)→D` is itself approximable). These are the keystones the rest of Lecture IV (and V–VIII)
lean on, and the `Domain/Neighborhood` API already has everything needed (`funSpace`, `eval`,
`comp`, `Element` sups via `sSupMaps`/directed joins).

**OCR anomalies to be aware of (documented in arxiv.md notes):**
- Lecture V: "Table 5.5" is a combinator table, not a numbered theorem.
- Lecture VI: `Example 6.1` (line 3214) is not bold-tagged; `6.15` is absent; `Theorem 6.16` (3995)
  is out of order; Exercises **6.17–6.20 are duplicated** (3933–3955 and again 4043–4065).
- Lecture VIII: `Theorem 8.4` is absent (numbering jumps 8.3 → 8.5).

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
lake build Domain                                 # full build (≈3015 jobs)
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

### Examples reused
- **`Example12.lean`** (`= Example23.T`): truth domain `T` over `Token = Fin 2`, `{master, zero={0},
  one={1}}`; `mem_iff`, `elemZero`/`elemOne`. `Example23`: `trueElt`, `falseElt`, `botElt`.
- **`ExampleB.lean`**: binary system `B` over `Str = List Bool`; `cone σ = {w | σ <+: w}`.
- **`Exercise222.lean`**: abstract representation theorem — `reprSystem`, `reprIso` (`≃o C`).
- **`Exercise213.lean`**: continuous ⟺ approximable, topology bridge for `|D|`.

---

## Pitfalls learned (don't relearn)
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
