# Handoff — Part II, Scott 1981 (PRG-19): neighborhood systems, §1 foundations

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19, "the blue pamphlet") in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

**Part I (Scott 1972, *Continuous Lattices*) is complete: 38 Pass · 0 Stuck · 0 Not Yet.** Theorem
4.4 (`D∞ ≅ [D∞ → D∞]`) landed last session. This session opens **Part II**, which is currently a
*stub* — there is no Lean module yet.

**Your task this session:** bootstrap `Domain/Neighborhood/` and formalize the **§1 foundations** of
PRG-19 — the definition of a neighborhood system, its domain of (ideal) elements, the inclusion
order, principal filters (finite elements), the bottom element, and the closure Theorem 1.11. This
is the Part II analogue of what `Domain/InfoSys.lean` already does for the 1982 presentation
(structure + `Element` + `PartialOrder`), and it is the prerequisite for everything downstream
(approximable maps §2, constructions §3, the Part IV bridge `continuousLattice_to_neighborhoodSystem`).

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** the §1 core is **constructive** — Scott deliberately uses *partial* filters so
  that the basic theory does **not** need maximal-filter existence (Zorn/choice). Aim for every new
  theorem to depend only on `[propext, Quot.sound]` (verify with `#print axioms <thm>`); if a result
  genuinely needs `Classical.choice`, isolate it and say so in its docstring. (Contrast Part I, which
  is unapologetically classical. Total/maximal elements — Def 1.8 — are the classical frontier; you
  are **not** asked to develop them this session.)
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** create exactly one new file `Domain/Neighborhood/Basic.lean` and add one import
  line to `Domain.lean`. Match the existing naming/style (see `Domain/InfoSys.lean` as the closest
  template).
- **Read the source first:** `sources/PRG19.md` — Definitions 1.1, 1.6, 1.7, 1.8, 1.9, Theorems 1.10,
  1.11 (transcription roughly lines 373–810; pages 8–17 of the pamphlet). The OCR is a *draft* with
  artifacts — sanity-check each statement against the surrounding prose before formalizing.
- **Update docs on completion:** `arxiv.md` (§4 Part II "stub" → live: status table, a new report-card
  row block, and proof notes), and refresh this `HANDOFF.md` with a next-session prompt for §2.

---

## Current status

Part II report card: **0 Pass** (no module). After this session, target a small **Part II §1 report
card** with the deliverables below all **Pass**, and the §4 "Part II (stub)" section of `arxiv.md`
upgraded from stub to a live (if still partial) section. `lake build` is green today.

---

## The mathematics (PRG-19 §1, with OCR cleaned up)

Fix a *master set* (token set) `A`. Write `Δ` for `A` itself (the least informative neighborhood:
"ask me no questions"). Neighborhoods are subsets of `A`; **smaller neighborhood = more information**
(the order is *reversed* relative to information). A *consistent* finite family of neighborhoods is
one with a common lower bound (a `Z ∈ V` contained in all of them).

- **Definition 1.1 (neighborhood system).** A nonempty family `V` of subsets of `A`, closed under
  intersections of finite consistent sequences. Equivalent two-condition form:
  - (i) `Δ ∈ V` (i.e. `A ∈ V`);
  - (ii) whenever `X, Y, Z ∈ V` and `Z ⊆ X ∩ Y`, then `X ∩ Y ∈ V`.
- **Definition 1.6 (ideal elements `|V|`).** A subfamily `x ⊆ V` that is a *filter*:
  - (i) `Δ ∈ x`;
  - (ii) `X, Y ∈ x ⟹ X ∩ Y ∈ x`;
  - (iii) `X ∈ x` and `X ⊆ Y ∈ V ⟹ Y ∈ x` (upward closure within `V`).
  The **domain** is `|V|`, ordered by inclusion (Def 1.8: `x` approximates `y` iff `x ⊆ y`).
- **Definition 1.7 (principal filters / finite elements).** For `X ∈ V`,
  `↑X := { Y ∈ V | X ⊆ Y }`. The map `X ↦ ↑X` is one-one and **inclusion-reversing**
  (`X ⊆ Y ↔ ↑Y ⊆ ↑X`); these are the *finite* elements, and every `x ∈ |V|` is the union of the
  principal filters of its members: `x = ⋃ { ↑X | X ∈ x }`.
- **Bottom (Def 1.8).** `⊥ = {Δ} = ↑Δ` is the least element of `|V|`.
- **Theorem 1.10.** `[X] := { x ∈ |V| | X ∈ x }` gives a neighborhood system over `|V|` isomorphic to
  `|V|` (tokens can be replaced by elements). *(Lower priority — see Step 5.)*
- **Theorem 1.11 (closure).** If `Xₙ ∈ |V|` for all `n`, then
  - (i) `⋂ₙ Xₙ ∈ |V|`; and
  - (ii) `⋃ₙ Xₙ ∈ |V|` **provided** the sequence is ascending (`Xₙ ⊆ Xₙ₊₁`).
  The proof just checks Def 1.6 (i)–(iii); only the union's clause (ii) uses the directedness proviso
  (`max n m` argument).

---

## Goal (recommended Lean shape)

In `Domain/Neighborhood/Basic.lean`, namespace `Domain.Neighborhood`:

```lean
/-- Scott 1981 (PRG-19), Definition 1.1. A neighborhood system over a token set `α`. -/
structure NeighborhoodSystem (α : Type*) where
  mem      : Set α → Prop                 -- `X ∈ V`
  master   : Set α                        -- `Δ` (intended: `Set.univ`, but keep abstract)
  master_mem : mem master
  inter_mem : ∀ {X Y Z}, mem X → mem Y → mem Z → Z ⊆ X ∩ Y → mem (X ∩ Y)
  -- (optionally bundle `master = univ`; see "Design choices")

namespace NeighborhoodSystem
variable {α : Type*} (V : NeighborhoodSystem α)

/-- Definition 1.6: the (ideal) elements of `V` — filters of neighborhoods. -/
structure Element where
  mem        : Set α → Prop
  sub        : ∀ {X}, mem X → V.mem X      -- `x ⊆ V`
  master_mem : mem V.master                -- (i)
  inter_mem  : ∀ {X Y}, mem X → mem Y → mem (X ∩ Y)         -- (ii)
  up_mem     : ∀ {X Y}, mem X → V.mem Y → X ⊆ Y → mem Y     -- (iii)

instance : PartialOrder V.Element := ...   -- inclusion of `mem` (see InfoSys.lean for the antisymm trick)

def principal (X : Set α) (hX : V.mem X) : V.Element := ...   -- Def 1.7  ↑X
def bot : V.Element := ...                                    -- ⊥ = ↑master
```

Then prove the `Pass` deliverables (see report-card target). Mirror `Domain/InfoSys.lean`'s
`Element` + `PartialOrder` pattern closely — including its **choice-free `le_antisymm`** (it avoids
`congr`, which pulls in `Classical.choice`; reuse that trick so the footprint stays `{propext,
Quot.sound}`).

---

## Report-card target for this session (all `Pass`, sorry-free)

| # | Scott (PRG-19) | Lean target | Notes |
| - | -------------- | ----------- | ----- |
| 1 | Def 1.1 | `NeighborhoodSystem` | structure + the two closure conditions |
| 2 | Def 1.6 | `NeighborhoodSystem.Element` | filter structure |
| 3 | Def 1.8 | `instance : PartialOrder Element` | inclusion order; choice-free `le_antisymm` |
| 4 | Def 1.7 | `principal`, `principal_mem_iff`, `principal_le_principal_iff` (`X ⊆ Y ↔ ↑Y ≤ ↑X`), `principal_injective` | finite elements; inclusion-reversing |
| 5 | Def 1.8 | `bot`, `OrderBot Element` (or `bot_le`) | `⊥ = ↑master = {Δ}` |
| 6 | Thm 1.11(i) | `iInter_mem` (countable / arbitrary `⋂`) | filter closed under intersections of elements |
| 7 | Thm 1.11(ii) | `iUnion_mem_of_monotone` | ascending `⋃` is an element (needs the proviso) |
| 8 | Def 1.6 remark | `eq_iUnion_principal` (`x = ⋃ {↑X | X ∈ x}`) | every element is the lub of its finite approximations |

**Stretch (only if 1–8 are solid):** Theorem 1.10 (`[X]`, the element-token system) and a
`NeighborhoodSystem`-isomorphism scaffold for Definition 1.9 (`V₀ ≅ V₁`). If short on budget, leave
1.10/1.9 as the documented next session and stop at 8.

---

## Design choices (pick reasonable defaults; note them in `arxiv.md`)

1. **`Set α → Prop` vs `Set (Set α)`.** A bundled predicate (`mem : Set α → Prop`) tends to elaborate
   more smoothly than `Set (Set α)` membership and matches `InfoSys.Con`'s spirit. Either is fine;
   prefer the predicate.
2. **`master` abstract vs `Set.univ`.** Scott's `Δ` is literally `A` (the whole set), so `master =
   Set.univ` is faithful and simplifies (iii)/bottom. Keeping `master` as a field (with no `= univ`
   constraint) is also defensible and slightly more general. **Recommendation:** keep a `master`
   field for fidelity to the text's `Δ` notation, but you may add `master_eq_univ` later if a proof
   wants it. Whatever you choose, be consistent.
3. **Order direction.** Elements are ordered by `x ⊆ y` (Def 1.8, "approximates"). Neighborhoods are
   ordered by reverse inclusion (smaller = better). Keep these straight — `principal` is
   inclusion-*reversing* from neighborhoods to elements.
4. **Constructivity.** Do not reach for `Classical` in §1. The `Element` antisymmetry, `principal`,
   and Theorem 1.11 are all constructive. Run `#print axioms` on each deliverable and keep `{propext,
   Quot.sound}`.

---

## Pitfalls (from Part I / InfoSys experience)

1. **`le_antisymm` and `Classical.choice`.** `InfoSys.lean` deliberately avoids `congr`/`Subtype.ext`
   machinery that drags in choice; it proves carrier-equality then reconstructs by proof irrelevance.
   Copy that pattern (`Domain/InfoSys.lean` ~lines 83–98) so the footprint stays choice-free.
2. **Structure eta / field access.** When two `Element`s share a `mem`, the `Prop`-valued fields are
   equal by proof irrelevance — but Lean won't always see it definitionally. Prove a
   `Element.ext`-style lemma (`mem`-equality ⟹ equality) early and reuse it.
3. **OCR noise.** `sources/PRG19.md` is a `pdftotext` draft: `Δ` shows up as `lJ.`/`fJ`/`"`, `⊆` as
   `S`/`s.`/`£`, `∩` as `n`, `↑X` as `+X`/`tX`, `∈` as `E`. Read the prose to disambiguate; do **not**
   transcribe symbols literally.
4. **`⋂`/`⋃` over `ℕ`.** Theorem 1.11(ii)'s proviso is exactly the `k = max n m` directedness move
   (cf. Part I's `iSup₂_monotone_eq_diagonal` and `Monotone.iSup_nat_add`). Intersection (i) needs no
   proviso.
5. **Don't formalize total/maximal elements (Def 1.8 "total").** That is the classical/Zorn frontier
   and is explicitly out of scope this session.

---

## Workflow

1. Reread `sources/PRG19.md` §1 (Def 1.1–1.8, Thm 1.10–1.11), cleaning OCR as you go.
2. Skim `Domain/InfoSys.lean` (the 1982 analogue) for the `structure` + `Element` + `PartialOrder`
   template and the choice-free `le_antisymm`.
3. Create `Domain/Neighborhood/Basic.lean`; add `import Domain.Neighborhood.Basic` to `Domain.lean`
   (after `Domain.InfoSys`, or grouped as you see fit).
4. Implement deliverables 1–8 above, sorry-free.
5. `lake build` (green), then `#print axioms` on each deliverable (temp scratch file pattern: a
   one-line `import … #print axioms …`, build with `lake env lean Scratch.lean`, then delete it).
   Confirm `{propext, Quot.sound}` (flag any `Classical.choice` you couldn't avoid).
6. Update `arxiv.md`: turn §4 "Part II (stub)" into a live section with a §1 report card (rows for
   deliverables 1–8), update the §2.1/§2.3 gate notes ("Part I → Part II" gate is **open**, Part II
   started), and add short proof notes. Rewrite `HANDOFF.md` as the §2 (approximable mappings) prompt.

---

## What comes after this session (for context, not this session's work)

- **§2 — approximable mappings (Def 2.1).** Relations `f ⊆ V₀ × V₁` with (i) `Δ₀ f Δ₁`, (ii) `X f Y ∧
  X f Y' ⟹ X f (Y∩Y')`, (iii) `X f Y ∧ X' ⊆ X ∧ Y ⊆ Y' ⟹ X' f Y'`. Proposition 2.2: `f` induces an
  elementwise map `|V₀| → |V₁|`. Theorem 2.5: domains + approximable maps form a category. Theorem
  2.7: every domain isomorphism comes from an approximable map (Def 1.9).
- **§3 — constructions:** product `V₀ × V₁`, function space `[V₀ → V₁]`, with universal properties.
- **Part IV bridge:** `continuousLattice_to_neighborhoodSystem` (1972 → 1981), using Part I's 2.11/2.12
  (Δ as master set). `neighborhoodSystem_to_infoSys` (1981 → 1982) lines this up with `Domain/InfoSys.lean`.

---

## Key reference files

| File | Role |
| ---- | ---- |
| `sources/PRG19.md` | primary source (OCR draft — verify against prose) |
| `Domain/InfoSys.lean` | **closest template**: 1982 `InfoSys` + `Element` + choice-free `PartialOrder` |
| `Domain/Neighborhood/Basic.lean` | **new this session** — §1 foundations |
| `Domain.lean` | module index — add the new import |
| `arxiv.md` | tracker + report cards + proof notes (update on completion); §4 = Part II |
| `Domain/Constructive.lean` | choice-free helpers, if any `Finset` work creeps in |

The Part I → Part II gate (Pass on Scott 2.8–2.11 and 3.3) is **open** — all prerequisites are green.
