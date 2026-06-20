# Handoff — Scott 1981 (PRG-19) Lecture III §3: ALL exercises complete

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`, Lean toolchain per `lean-toolchain`.

**Status:** Lecture I (43), Lecture II (22), and the Lecture III §3 *spine* (Def 3.1 → Thm 3.13, 15)
are COMPLETE and green. **ALL §3 exercises (3.14–3.28) are now done.** The previously-remaining five
were completed:

- **3.16** (`Exercise316.lean`) — the infinite iterate `𝒟^∞` over `ℕ × Δ` via fibers + cofinite-`Δ`
  bound: `iterSys` is a system, `iterSeqEquiv : |𝒟^∞| ≃o (ℕ → |𝒟|)`, and `𝒟^∞ ≅ 𝒟 × 𝒟^∞`
  (`iter_isomorphic`); plus `component`, `ofSeq`, `projN`.
- **3.17** (`Exercise317.lean`) — `B` is a **retract** of `T^∞`: section `f : B → T^∞`, retraction
  `g : T^∞ → B`, with `gf_eq_id : g ∘ f = I_B`, `fg_le_id : f ∘ g ⊑ I_{T^∞}`, and `f_injective`
  (one-one). Encoding `encSet σ` pins copy `i` to `bitNbhd σ[i]`; the key lemma
  `prefix_of_encSet_subset` uses non-emptiness of `T`-neighbourhoods.
- **3.24(ii)** (`Exercise324Iter.lean`) — `(𝒟₀→𝒟₁^∞) ≅ (𝒟₀→𝒟₁)^∞` (`funIter_isomorphic`), via
  `mapOfSeq` and a local `piCongrOrderIso`.
- **3.24(iii)(iv)** (`Exercise324Distrib.lean`) — established as canonical **mapping relationships**
  (not isomorphisms, due to the separated-sum bottom): `copair : (D₀+D₁)→D₂` with the section/retract
  packaging `copairProj`, plus the distribution map `distribMap` for (iii).
- **3.25** (`Exercise325.lean`) — the open subsets of `|𝒟|` form a domain: `openIso` matches opens to
  approximable maps `𝒟 → 𝒪` (Sierpiński), then `funSpaceEquiv` (Thm 3.10) gives
  `opensReprIso : {U // IsOpen U} ≃o |𝒟 → 𝒪|`.
- **3.27** (`Exercise327.lean`) — alternate proof that `(D₀→D₁)` is a domain via the Ex 2.22
  representation theorem: the family `C` of graphs of approximable maps is closed under non-empty
  intersections (`meetMap`) and directed unions (`joinMap`), giving `funSpaceReprIso`.

`lake build Domain` is green, zero `sorry`s.

*Note on choice for 3.26:* `cond`/`condSum`/`whichMap` report `Classical.choice` in their axiom
audit, but this is inherited structurally from the truth domain `T = Example12.neighborhoodSystem`
(whose own `inter_mem` proof uses `fin_cases`/`simp`), exactly as the pre-existing
`Example23.parityMap` does — not from any new choice in these constructions.

---

## Working rules (read first)

- **One module per exercise**, named `Domain/Neighborhood/Exercise<NN>.lean` (or `Exercise<NN>Foo.lean`
  for a second piece, e.g. `Exercise319Sum.lean`). Add `import Domain.Neighborhood.Exercise<NN>` to
  `Domain.lean` (keep imports in numeric order).
- **Goal:** `lake build Domain` green, **zero `sorry`**.
- **Choice discipline:** keep every *data construction* (a `NeighborhoodSystem`, an `ApproximableMap`,
  an `OrderIso`/`≃o`, an `Equiv`) choice-free: `#print axioms <name>` must be `⊆ {propext, Quot.sound}`.
  Map/structure *equalities* and *uniqueness* lemmas may pull `Classical.choice` **only** through the
  project's established `ApproximableMap.ext_of_toElementMap` (elementwise extensionality) and the
  `leastMap`/`rel_interYs` `X ⊆ Xᵢ` case split — these are documented classical *proof* steps. Do not
  introduce *new* choice in constructions.
- **Prefer relational extensionality** `ApproximableMap.ext` (compares `.rel`) when you can — it is
  choice-free, unlike `ext_of_toElementMap`.
- After each module: build it alone, then run the axiom audit, then update `arxiv.md` (flip the row to
  **Pass** with the module name; rows are near lines 1267–1281) and the status line of this file.

### Commands

```bash
cd /home/catskills/Desktop/domain_theory
lake build Domain.Neighborhood.Exercise<NN>      # build one module
lake build Domain                                 # full build (≈3007 jobs)
```

Axiom audit (scratch file, delete after):

```bash
cat > scratch_axioms.lean <<'EOF'
import Domain.Neighborhood.Exercise<NN>
open Domain.Neighborhood
#print axioms <name1>
#print axioms <name2>
EOF
lake env lean scratch_axioms.lean ; rm -f scratch_axioms.lean
```

---

## Reusable API cheat-sheet (what the remaining exercises build on)

### Core (`Basic.lean`)
- `structure NeighborhoodSystem (α)` fields: `mem : Set α → Prop`, `master : Set α`, `master_mem`,
  `inter_mem : mem X → mem Y → mem Z → Z ⊆ X∩Y → mem (X∩Y)`, `sub_master : mem X → X ⊆ master`.
- `V.Element` = filters: fields `mem`, `up_mem`, `master_mem`, `inter_mem`; `Element.ext` (by `mem`),
  order `≤` is `∀ Z, y.mem Z → x.mem Z`-style reverse-inclusion-of-filters (`x ≤ y` ⟺ `x.mem ⊆ y.mem`).
- `V.principal (hX : V.mem X) : V.Element`, `V.bot`, `mem_bot`.
- `DomainIso V₀ V₁ := V₀.Element ≃o V₁.Element`; `Isomorphic V₀ V₁` (`V₀ ≅ᴰ V₁`) `:= Nonempty (DomainIso …)`;
  `Isomorphic.refl/symm/trans`. **Pitfall:** the superscript `ᴰ` is fine in the *notation* `≅ᴰ` but
  **cannot** appear in plain identifiers (`prodCommᴰ` fails to parse) — use `D` (`prodCommD`).

### Approximable maps (`Approximable.lean`, `ApproximableExercises.lean`)
- `structure ApproximableMap V₀ V₁` fields: `rel : Set α → Set β → Prop`, `rel_dom`, `rel_cod`,
  `master_rel`, `inter_right`, `mono`. `ApproximableMap.ext` (relational), `ext_of_toElementMap`.
- `toElementMap f : V₀.Element → V₁.Element`; `rel_iff_mem_principal`; `idMap`, `comp` (`(A.comp B).rel x z = ∃ y, B.rel x y ∧ A.rel y z`),
  `toElementMap_comp`, `toElementMap_idMap`, `ofIso`.
- `ofMono`, `interMap`, `iSupMap`, `ApproximableMap₂` (curried two-arg maps), `toElementMap₂`.

### Products (`Product.lean`)
- `prod V₀ V₁ : NeighborhoodSystem (α ⊕ β)`; `prodNbhd X Y = Sum.inl '' X ∪ Sum.inr '' Y` (= Scott's
  `0X ∪ 1Y`); `prodNbhd_inter`, `prodNbhd_subset_iff`, `prodNbhd_injective` (all choice-free).
- `pair x y`, `Element.fst`, `Element.snd`, `fst_pair`/`snd_pair`/`pair_fst_snd`, `pair_le_pair_iff`,
  `prodEquiv : (prod V₀ V₁).Element ≃o V₀.Element × V₁.Element`.
- `proj₀`/`proj₁`, `paired`, `proj₀_comp_paired`/`proj₁_comp_paired`, `paired_proj`,
  `toElementMap_paired`, `toElementMap_proj₀`/`_proj₁`, `constMap`, `toElementMap_constMap`.
- `toMap₂`/`ofMap₂`/`map₂Equiv` (`ApproximableMap (prod V₀ V₁) V₂ ≃ ApproximableMap₂ V₀ V₁ V₂`),
  `substitution_toElementMap`.

### Sum (`Exercise318.lean`) — the model to copy for tagged/indexed constructions
- Tokens `Option (α ⊕ β)`: `Λ = none`, `il a = some (inl a)`, `ir b = some (inr b)`.
- `inj₀ X = il '' X` (`0X`), `inj₁ Y = ir '' Y` (`1Y`); membership simp lemmas `il_mem_inj₀` etc.;
  `inj₀_inter`, `inj₀_inter_inj₁ = ∅`, `inj₀_subset_inj₀ ↔ ⊆`, `inj₀_injective` (all choice-free).
- `sumMaster`, `sum V₀ V₁ (h₀ : ∀X, V₀.mem X → X.Nonempty) (h₁ : …) : NeighborhoodSystem (Option (α⊕β))`.
  **Non-emptiness `h₀ h₁` is what makes `inter_mem` hold** (cross pairs `0X ∩ 1Y = ∅` are inconsistent).
- `inMap₀`/`inMap₁`, `outMap₀`/`outMap₁` (via choice-free `leftPart`/`rightPart` retraction helpers),
  `outMapᵢ_comp_inMapᵢ = idMap`. `Exercise319Sum.lean` adds `sumMap` (`f+g`) and `mem_subset_inj₀`,
  `eq_sumMaster_of_subset`, `not_inj₀_subset_inj₁` (handy structural lemmas).

### Function space (`FunctionSpace.lean`, `Exercise321.lean`, `Exercise328.lean`)
- `step X Y = {f | f.rel X Y}` (`[X,Y]`), `stepFun L`, `stepFun_singleton`, `step_inter_right`,
  `step_subset`, `step_master_eq`, `step_mem`, `mem_stepFun_iff`.
- `funSpace V₀ V₁ : NeighborhoodSystem (ApproximableMap V₀ V₁)`,
  `funSpaceEquiv : (funSpace V₀ V₁).Element ≃o ApproximableMap V₀ V₁`, `toApproxMap`/`toFilter`.
- `interYs`, `mem_interYs`, `interYs_antitone`, `leastMap L hL hcons`, `leastMap_rel`,
  `leastMap_mem_stepFun`, `rel_interYs`, `leastMap_le`, `stepFun_subset_step_iff`.
- `eval`/`evalMap`/`evalMap_apply`, `curry`/`uncurry`/`curryEquiv`, `le_iff_toElementMap_le`,
  pointwise-bdd/sup (`mapsBounded_iff_pointwiseBounded`, `sSupMaps`, `toElementMap_sSupMaps`).
- 3.15 helpers in `Exercise315.lean`: `unitSys` (terminal `𝟙`), `prodCongrOrderIso`,
  `prodUniqueOrderIso`, `uniqueProdOrderIso` (choice-free `≃o` for plain `Prod`; **mathlib has
  `OrderIso.prodComm`/`prodAssoc` but NOT `prodCongr`/`prodUnique` for non-lex products** — hence these).

### Examples reused below
- **`Example12.lean`** (`= Example23.T`): the truth domain `T` over `Token = Fin 2`, neighbourhoods
  `memSet = {master=univ, zero={0}, one={1}}`; `mem_iff`, `not_mem_empty`, `elemZero`/`elemOne`.
  `Example23.lean`: `trueElt = elemZero`, `falseElt = elemOne`, `botElt = T.bot`, `botElt_le`.
- **`ExampleB.lean`**: binary system `B` over `Str = List Bool`; `cone σ = {w | σ <+: w}`, `B`,
  `sigmaBot`, `sigmaElt`, `cone_subset_cone`, prefix trichotomy via `ofNestedOrDisjoint`.
- **`Exercise222.lean`**: abstract representation theorem — `reprSystem`, `toC`/`ofC`, `reprIso` (`≃o C`).
- **`Exercise213.lean`**: continuous ⟺ approximable, `ofContinuous`, topology bridge for `|D|`.

---

## The five remaining exercises (with concrete plans)

### Exercise 3.16 — the infinite power `𝒟^∞` (HARD; the keystone, 3.17 & 3.24(ii) depend on it)
Source lines ~1443–1466. `Δ^∞ = ⋃_{n≥0} 1ⁿ0 Δ` (infinitely many disjoint tagged copies of `Δ`).
`𝒟^∞` is the **least** family with (1) `Δ^∞ ∈ 𝒟^∞`, and (2) `X ∈ 𝒟`, `Y ∈ 𝒟^∞` ⟹ `0X ∪ 1Y ∈ 𝒟^∞`.
Deliverables: `𝒟^∞` is a neighbourhood system over `Δ^∞`; **`𝒟^∞ ≅ 𝒟 × 𝒟^∞`**; elements of `|𝒟^∞|`
↔ arbitrary sequences `⟨xₙ⟩` of `|𝒟|`-elements (via `0X₀ ∪ 10X₁ ∪ ⋯ ∪ 1ⁿ0Xₙ ∪ ⋯`, eventually all `Δ`).

Plan / suggested encoding:
- **Tokens:** `ℕ × α` works cleanly — token `(n, a)` *is* `1ⁿ0 a`. Then `Δ^∞ = Set.univ`-image
  `{(n,a) | a ∈ Δ}`, copy-`n` is `{n} ×ˢ Δ`. A general neighbourhood from rule (2) iterated is a
  *finite* prefix of per-index neighbourhoods then `Δ` forever: `W = ⋃ₙ ({n} ×ˢ Xₙ)` with `Xₙ ∈ 𝒟`
  and `Xₙ = Δ` for all `n ≥ N` (some `N`). Model a neighbourhood by a function `g : ℕ → Set α` with
  `(∀ n, V.mem (g n)) ∧ (∃ N, ∀ n ≥ N, g n = V.master)`; the set is `{(n,a) | a ∈ g n}`.
  Define `mem W := ∃ g, (cofinitely master) ∧ W = {p | p.2 ∈ g p.1}`. **`inter_mem`** is pointwise
  (`(g ∩ g')ₙ = gₙ ∩ g'ₙ`, still cofinitely `Δ`, witness pointwise from the `Z`).
- **`𝒟^∞ ≅ 𝒟 × 𝒟^∞`** (`prod V (D∞)` over `α ⊕ (ℕ×α)`): the iso shifts indices —
  `0X ∪ 1Y ↔ (X, Y)` i.e. `g ↔ (g 0, n ↦ g (n+1))`. Build the element-level `≃o` and conclude `≅ᴰ`.
  This is the analogue of `Exercise315`'s product isos; reuse `prodEquiv`.
- **Elements ↔ sequences:** `|𝒟^∞| ≃o (∀ n, |𝒟|)` with the **product order**. Forward: a filter `x`
  gives `xₙ := out at copy n`; back: a sequence gives the filter generated by the cofinite-`Δ` nbhds.
  Mirror `prodEquiv`'s proof style. Expect this to be the longest part.
- **Pitfalls:** "least family" — don't try to define via an inductive `Prop` if you can give the closed
  form above (closed form is easier to prove `inter_mem`/`sub_master` for, and is choice-free). Keep
  the cofinite-`Δ` witness as explicit data, not `∃` you must `choose` from (avoid `Classical.choice`).

### Exercise 3.17 — `B ⇆ T^∞` (depends on 3.16 giving `T^∞`)
Source ~1468–1486. Need a **one-one** approximable `f : B → T^∞` and `g : T^∞ → B` with `g∘f = I_B`
and `f∘g ⊆ I_{T^∞}` (so `f` is a section, `g` a retraction; `B` is a *retract* of `T^∞`). Then discuss
(prose-level or as `¬ Isomorphic`) whether `B ≅ T^∞` and `B ≅ T × B`.
- Idea: a binary string / infinite binary sequence ↔ a sequence of truth values (`T`'s `true/false/⊥`).
  `f` sends the `B`-cone of `σ` to the `T^∞`-sequence "first `|σ|` coordinates are the bits of `σ`
  (as `true/false`), rest `⊥`". `g` reads coordinates back into a prefix. Use `Example23.trueElt`/
  `falseElt`/`botElt`. Reuse the `comp`/`idMap` and the `≤`-as-`⊆` on maps for `f∘g ⊆ I`.
- Pattern to copy: `Exercise318`'s `outMapᵢ_comp_inMapᵢ = idMap` (relational `ext`), and
  `Exercise218` (`kMap_comp_hMap = I`, plus `not_injective`/`not_surjective` for the "are they iso?"
  questions) in Lecture II.

### Exercise 3.25 — open subsets of `|D|` form a domain (For topologists)
Source line 1578. Recall `|D|` as a topological space (Exercises 1.21, 2.13 — see `Exercise213.lean`
for the continuity/topology bridge, and `Exercise215.lean` for the Sierpiński/opens-as-maps idea).
Using Thm 3.10, show the family of **open subsets of `|D|`** is isomorphic to a domain.
- Likely route: opens of `|D|` ↔ continuous maps `|D| → 𝕊` (Sierpiński) ↔ approximable maps `D → O`
  (the one-token system `O` of `Exercise215.lean`, where `openSet_equiv_map` already gives
  opens ≃ maps for that example) ↔ `|D → O|` via `funSpaceEquiv` (Thm 3.10). So the target domain is
  `funSpace D O`. Assemble `Opens |D| ≃o |funSpace D O|`. Check what `Exercise213`/`215` already expose
  before building topology from scratch.

### Exercise 3.26 — the conditional operator `cond` (self-contained; flagship) — ✅ DONE (`Exercise326.lean`, `Exercise326Sum.lean`)
Source ~1580–1620. For every domain `D`, an approximable `cond : T × D × D → D` with
`cond(true,x,y)=x`, `cond(false,x,y)=y`, `cond(⊥,x,y)=⊥`. **Scott's hint gives the relation directly**
(with `T = {{0},{1},{0,1}}`, using the 3.14 tagged product):
```
0C ∪ 10X ∪ 110Y  cond  Z   iff   (0∈C ∧ X⊆Z) ∨ (1∈C ∧ Y⊆Z) ∨ (0,1∈C ∧ Δ⊆Z).
```
Plan:
- Domain is `prod T (prod D D)` (tokens `T.Token ⊕ (α ⊕ α)`). A neighbourhood is
  `prodNbhd C (prodNbhd X Y)`; recover `C, X, Y` from `W` by preimage/`leftPart`-style projection
  (reuse `Product.lean` projections / `proj₀ ∘ ...`, or write `Cpart/Xpart/Ypart` like `leftPart`).
- `T.Token = Fin 2`; "`0 ∈ C`" is `(0 : Fin 2) ∈ C`, "`1 ∈ C`" is `(1 : Fin 2) ∈ C`. With
  `Example12.mem_iff`, `C ∈ {Δ,{0},{1}}` so the three guard combinations are: `{0}`→only first,
  `{1}`→only second, `Δ`→third (and both firsts), giving the `cond(true/false/⊥)` outputs.
- Prove `inter_right`/`mono` for the relation (case on which guards hold; similar bookkeeping to
  `Exercise319Sum.sumMap`). Then the three elementwise identities via `toElementMap`.
- Then the **two follow-ups**: (a) the sum-valued operator `T × D₀ × D₁ → D₀ + D₁` (route `true→in₀`,
  `false→in₁`); (b) `which : D₀ + D₁ → T` with
  `cond(which x, in₀(out₀ x), in₁(out₁ x)) = x` — `which` reads the tag (`0X→true`, `1Y→false`,
  `Λ→⊥`). Reuse `inMapᵢ`/`outMapᵢ` from `Exercise318`.

### Exercise 3.27 — alternate proof that `(D₀→D₁)` is a domain (For set theorists)
Source ~1622–1628. Reprove "`{f : D₀→D₁}` ≅ a domain" via the **general argument of Exercise 2.22**
(`Exercise222.lean`: `reprSystem`/`reprIso`) instead of the explicit 3.9/3.10 construction; compare the
methods (a short prose `/-! -/` discussion is appropriate, but back the iso with Lean). Second part:
show `eval : (D₁→D₂) × D₁ → D₂` is approximable **without** explicit neighbourhoods, using Thm 3.5
(`map₂Equiv`) and the idea of Exercise 2.12. Mostly a re-derivation that reuses existing pieces.

### Also missing: Exercise 3.24 (ii)(iii)(iv)
`Exercise324.lean` has only **(i)** `(D₀→D₁×D₂) ≅ (D₀→D₁)×(D₀→D₂)`. Still to do:
(ii) `(D₀→D₁^∞) ≅ (D₀→D₁)^∞` (needs 3.16); (iii) `D₀×(D₁+D₂) ≅ (D₀×D₁)+(D₀×D₂)` (needs sum, may be
false/partial — Scott says "if not true, establish mapping relationships"); (iv)
`(D₀+D₁)→D₂ ≅ (D₀→D₂)×(D₁→D₂)`. Suggested order: do (iv) and (iii) after 3.26; (ii) after 3.16.

**Recommended sequence:** ~~3.26 (self-contained, high value)~~ ✅ DONE → 3.16 (keystone) →
3.17 & 3.24(ii) (use 3.16) → 3.24(iv)/(iii) → 3.25 → 3.27.

---

## Pitfalls learned this session (don't relearn them)
- **`ᴰ` in identifiers fails to parse.** Notation `≅ᴰ` is fine; names must use `D`.
- **`simpa`/`simp` can pull `Classical.choice`** into a construction. In choice-free lemmas, replace with
  explicit term-mode (`il_mem_inj₀.mp (h (il_mem_inj₀.mpr ha))`) or `simp only [...]`. `Set.image_mono`
  / `Set.image_subset` were unavailable/choice-y — unfold and use `obtain ⟨a, ha, rfl⟩`.
- **`rw` needs syntactic match:** `(sum …).master` is *defeq* but not syntactically `sumMaster …`; pass
  an explicitly-typed `show W ⊆ sumMaster … from …` to `Set.inter_eq_right.mpr`, or use `Eq.subset`.
- **`X ▸ subset_rfl` often fails** to rewrite the right occurrence; prefer `hEq ▸ hsub` where `hsub` is
  the actual subset hypothesis (e.g. `hWX₀ ▸ hinj : inj₀ X ⊆ inj₀ X₀`).
- **`rw [foo]` leaves a `⊆`-refl goal open** (e.g. after `leftPart_inj₀`); finish with the term
  `(leftPart_inj₀ V Z).subset` or add `exact subset_rfl`.
- **`OrderIso.prodCongr`/`prodUnique`/`uniqueProd` don't exist for plain `Prod`** — use the helpers in
  `Exercise315.lean`. `OrderIso.prodAssoc` is `(A×B)×C ≃o A×(B×C)`; take `.symm` for the other way.
- **Don't `choose` from existentials in a construction** (pulls choice). Carry witnesses as data.

## Files map
- New work goes in `Domain/Neighborhood/Exercise<NN>.lean`, imported from `Domain.lean`.
- Source statements: `sources/PRG19_vision.md` (3.16 ~1443; 3.17 ~1468; 3.24 ~1566; 3.25 ~1578;
  3.26 ~1580; 3.27 ~1622).
- Inventory/status: `arxiv.md` (Lecture III exercise rows ~1267–1281; flip to **Pass**).
- This file: update the status line as you complete modules.
