# Handoff — Part II, Scott 1981 (PRG-19): Definition 1.9 (isomorphism `𝒟₀ ≅ 𝒟₁`) → Theorem 1.10

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (Technical Monograph PRG-19, "the blue pamphlet") in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`.

The monograph (`arxiv.md`) is titled **"Scott's 3 Successively Less Topological, Simpler, and More
Constructive Presentations of Domain Theory and Their Equivalence"**: Part I = 1972 continuous
lattices, **Part II = 1981 neighborhood systems (this work)**, Part III = 1982 information systems,
Part IV = the equivalence finale.

**Part I (Scott 1972, *Continuous Lattices*) is complete: 38 Pass · 0 Stuck · 0 Not Yet.**

**Part II is live.** The §1 Goal List in `arxiv.md §4.2` tracks a *biblical*, line-by-line parse of
PRG-19: Definitions, Theorems, **Factoids** (unnamed prose assertions), **Examples**, and
**Exercises** are all first-class deliverables. **Proof notes** in `arxiv.md §4.5` are part of the
monograph deliverable — update them as each result lands.

**Just landed (this session): Example 1.B — binary sequences (`ExampleB.lean`, all 5 subgoals).**
- **Example 1.B / Exercise 1.B-sys**: `Str := List Bool`, `cone σ := {w ∣ σ <+: w}` (= `σΣ*`),
  `memB X := ∃ σ, X = cone σ`; `B : NeighborhoodSystem Str` built via `ofNestedOrDisjoint` from
  `cone_trichotomy` (any two cones nested-or-disjoint; **decidable** prefix ⇒ choice-free `dite`).
- **Factoid 1.B-mono**: `sigmaBot σ := ↑(cone σ)` (= `σ⊥`); `sigmaBot_le_iff : σ₀⊥ ⊑ σ₁⊥ ↔ σ₀ <+: σ₁`
  (two variance reversals cancel → prefix order directly).
- **Exercise 1.B-elt**: `sigmaElt σ x` (Scott's `σx`), filter via witness `σ(X₁∩X₂)` = a cone
  (`prepend_cone : σ(τΣ*) = (στ)Σ*`); `sigmaElt_bot : sigmaElt σ ⊥ = σ⊥`.
- **Factoid 1.B-lim**: `mem_iff_exists_sigmaBot : x.mem Z ↔ ∃ σ, x.mem (cone σ) ∧ (σ⊥).mem Z`
  (Scott's `x = ⋃ₙ σₙ⊥`, union-of-`σ⊥` form; ascending-chain enumeration left to prose/choice).
- **All constructive** (`#print axioms ⊆ {propext, Quot.sound}`, audited then scratch deleted).

**→ 25 Pass.** `lake build Domain` is green.

**Your task this session:** formalize **Definition 1.9** (isomorphism of domains) and then **Theorem
1.10** (the element-token system `{[X]}` with `𝒟 ≅ {[X]}`). Def 1.9 is short and is the prerequisite
for the isomorphism statements in Theorem 1.10, Exercise 1.20, Exercise 1.21, and the whole Part IV
equivalence finale.

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** Def 1.9 and Theorem 1.10 should be **constructive** (`[propext, Quot.sound]`).
  `[X]` already exists as `basicOpen` in `Exercise122.lean` and is choice-free. Audit with
  `#print axioms` in a scratch file, then delete it.
- **Do not commit or push** unless explicitly asked.
- **Minimize scope:** Def 1.9 (an iso *predicate*/structure on two systems) belongs in
  `Domain/Neighborhood/Basic.lean`. Theorem 1.10 (the `{[X]}` construction) likely deserves its own
  `Domain/Neighborhood/Theorem110.lean` (add to `Domain.lean`).
- **Read the source first:** `sources/PRG19_vision.md` lines 321–322 (Def 1.9) and 329–359
  (Theorem 1.10). The `arxiv.md §4.2` rows for **Def 1.9** and **Theorem 1.10** carry the precise
  sub-claims.
- **Update docs on completion:** mark Def 1.9 (and Theorem 1.10 if reached) **Pass** in
  `arxiv.md §4.2`, refresh §4.3 graph + §4.4 tally, add §4.5 notes. Rewrite this `HANDOFF.md`.

---

## The mathematics

### Definition 1.9 (vision OCR, lines 321–322)

> **DEFINITION 1.9.** Two neighbourhood systems `𝒟₀` and `𝒟₁` determine *isomorphic domains* iff
> there is a one-one correspondence between `|𝒟₀|` and `|𝒟₁|` which preserves inclusion between the
> elements of the domains. In symbols `𝒟₀ ≅ 𝒟₁`.

Formalization: an order-isomorphism of the two `Element` posets. Cleanest is to **reuse mathlib's
`OrderIso`**: define `DomainIso (V₀ : NeighborhoodSystem α) (V₁ : NeighborhoodSystem β) := V₀.Element
≃o V₁.Element`, or a `def Iso` predicate `Nonempty (V₀.Element ≃o V₁.Element)`. `≃o` packs the
bijection + `a ≤ b ↔ f a ≤ f b` (order-preserving *both ways*), exactly Scott's "one-one + preserves
inclusion". `PartialOrder Element` is already in `Basic.lean`. Note `|𝒟₀|` and `|𝒟₁|` may live over
*different token types* `α, β`, so keep the two systems independent (don't force `α = β`).

### Theorem 1.10 (vision OCR, lines 329–359)

The **element-token system**: tokens are the *elements* of `|𝒟|`, and for each neighbourhood `X ∈ 𝒟`
the token-set `[X] = {x ∈ |𝒟| ∣ X ∈ x}` (the elements that contain `X`). Then `{[X] ∣ X ∈ 𝒟}` is a
neighbourhood system over `|𝒟|`, and `𝒟 ≅ {[X]}`. Sub-claims (see the §4.2 row):

- `[Δ] = |𝒟|` (every element contains `Δ`) — the master token-set.
- `[X] ∩ [Y] = [X ∩ Y]` (when `X ∩ Y ∈ 𝒟`) — closure / the system's intersection law.
- `↑X ∈ [X]` (the principal filter of `X` contains `X`).
- The map `X ↦ [X]` is one-one and inclusion-preserving, giving `𝒟 ≅ {[X]}`.

`[X]` is **already defined** as `basicOpen X` in `Exercise122.lean`:
`basicOpen X = {x : V.Element ∣ x.mem X}`. Reuse it (move/rename to `Basic.lean` if convenient, or
import `Exercise122`). The system `{[X]}` is a `NeighborhoodSystem V.Element`; build it and the
`OrderIso` to `V.Element`. **This is the first "system of systems" and a dry run for Part IV.**

### Report-card target (this session)

| Scott | Lean target | Notes |
| ----- | ----------- | ----- |
| **Def 1.9** | `DomainIso V₀ V₁ := V₀.Element ≃o V₁.Element` (or `Nonempty (… ≃o …)`) | reuse mathlib `OrderIso`; constructive |
| **Theorem 1.10** | `[X]=basicOpen`; `tokenSystem : NeighborhoodSystem V.Element`; `iso : V.Element ≃o tokenSystem.Element` + `memBracket_master`/`inter`/`mono` | own file `Theorem110.lean` |

(Marking Def 1.9 Pass takes Lecture I 25 → 26; +Theorem 1.10 → 27.)

---

## Pitfalls

1. **Two token types.** Def 1.9 relates systems over possibly *different* `α, β`. Use
   `{α β : Type*} (V₀ : NeighborhoodSystem α) (V₁ : NeighborhoodSystem β)`. `≃o` is heterogeneous in
   the carriers — fine.
2. **`OrderIso` gives both directions for free.** `f : A ≃o B` has `map_rel_iff : f a ≤ f b ↔ a ≤ b`,
   which is Scott's "preserves inclusion" *and* injectivity (an `≃o` is automatically `≤`-reflecting).
   Don't hand-roll a bespoke structure unless `OrderIso` is awkward.
3. **`[X]` variance.** In Theorem 1.10 the correspondence `X ↦ [X]` should come out **inclusion-
   preserving** (`X ⊆ Y → [X] ⊆ [Y]`? check direction against Scott — `[X] = {x ∣ X∈x}`, larger `X`
   is *harder* to contain, so `X ⊆ Y ⟹ [Y] ⊆ [X]`; mind the reversal, as with `principal`).
   The element-level iso `|𝒟| ≅ |{[X]}|` is the order-preserving one; the token map `X ↦ [X]` is the
   reversing one (same pattern as `principal_le_iff`).
4. **Reuse, don't rebuild `[X]`.** `basicOpen` and its lemmas (`isOpen_iff_upper_basic`, etc.) are in
   `Exercise122.lean`. Importing it is fine; the dependency is acyclic.
5. **Stay constructive.** No `Classical` needed: `[X]` membership is just `x.mem X`; the system laws
   mirror `principal`'s constructive proofs.

---

## Workflow

1. Reread `sources/PRG19_vision.md` lines 321–322 (Def 1.9) and 329–359 (Theorem 1.10).
2. Add `DomainIso` (Def 1.9) to `Basic.lean` (constructive, via `OrderIso`).
3. Create `Domain/Neighborhood/Theorem110.lean`; build `tokenSystem` (`{[X]}`) and the `OrderIso`
   `V.Element ≃o tokenSystem.Element`; prove `[Δ]=|𝒟|`, `[X]∩[Y]=[X∩Y]`, `↑X∈[X]`. Add to `Domain.lean`.
4. `lake build Domain` (green); `#print axioms` audit via scratch file → core `[propext, Quot.sound]`;
   delete scratch.
5. Update `arxiv.md` (§4.2 Pass rows, §4.3 graph nodes `D19`/`T110`, §4.4 tally, §4.5 notes) and
   rewrite this `HANDOFF.md` for the next item (**Theorem 1.11** closure under countable `⋂`/ascending
   `⋃`, lines 367–377; or the **Exercises 1.12–1.27** backlog).

---

## Current status (Part II)

| Block | Status |
| ----- | ------ |
| Vision / OCR | **Lectures I–III fully transcribed** (`sources/PRG19_vision.md`, ≈2340 lines); Lecture IV partial |
| Goal List | **§4.2 (Lecture I, 40 rows, 25 Pass)**; **§4.2.II (Lecture II, 22 rows)** + **§4.2.III (Lecture III, 28 rows)** inventoried, all Not Yet |
| Lean modules | `Basic.lean`, `Example12.lean`, `Example13.lean`, `Example14.lean`, `Example15.lean`, `ExampleB.lean`, `Exercise122.lean` |
| Report card | **25 Pass** · rest queued (see `arxiv.md §4.2`) |

**Already Pass (Lecture I):**

| Scott | Lean |
| ----- | ---- |
| Def 1.1 | `NeighborhoodSystem` (`mem`, `master`, `master_mem`, `inter_mem`, `sub_master`) |
| Factoids 1.1a, 1.1b | `interUpTo`, `interUpTo_zero`, `interUpTo_succ` |
| Theorem 1.1c | `interUpTo_mem`, `consistent_iff_interUpTo_mem`, `Consistent`, `interUpTo_subset` |
| **Factoid 1.4a** | `NestedOrDisjoint`, `NeighborhoodSystem.ofNestedOrDisjoint` (choice-free) |
| Def 1.6 | `Element`, `Element.ext` |
| **Factoid 1.5b** | `limitFamily`, `SeqEquiv`, `limitFamily_eq_iff` (choice-free) |
| **Def 1.7** | `principal` (`↑X`), `mem_principal` (choice-free) |
| **Factoid 1.7a** | `principal_le_iff` (`↑X⊑↑Y ⟺ Y⊆X`), `principal_injective` (choice-free) |
| **Factoid 1.7b** | `eq_iUnion_principal` (`x = ⋃{↑X∣X∈x}`, choice-free) |
| Def 1.8 (order) | `instance : PartialOrder Element` (choice-free) |
| Def 1.8 (⊥, total) | `bot`, `mem_bot` (`⊥={Δ}`), `IsTotal` predicate (choice-free) |
| Factoid 1.8a | `bot_le` + `instance : OrderBot Element` (choice-free) |
| Factoid 1.8b | `eq_principal_of_isMin` (choice-free core) |
| Example 1.2 | `Example12.*` (fork) |
| Example 1.3 | `Example13.*` (chain) |
| Example 1.4 | `Example14.*` (binary tree, 7 filters) |
| **Example 1.5 / Factoid 1.5a** | `Example15.*` (all non-empty subsets of `Fin 4`) |
| **Example 1.B / Exercises 1.B-sys, 1.B-elt / Factoids 1.B-mono, 1.B-lim** | `ExampleB.*` (binary sequences `List Bool`; `cone`, `B`, `sigmaBot`, `sigmaElt`, `mem_iff_exists_sigmaBot`) — fully constructive |
| **Exercise 1.22** | `Exercise122.*` (topology on `|𝒟|`; `⊑` = specialization; `[X] = basicOpen`) |

---

## What comes after (context, not this session)

| Next item | Notes |
| --------- | ----- |
| **Theorem 1.11** | closure of `\|𝒟\|` under countable `⋂` and ascending `⋃` (`x₀⊆x₁⊆⋯`) (lines 367–377) |
| **Exercise 1.13** | verify all assertions about `B` (this session's `ExampleB`); the "picture with limit nodes" |
| **Exercise 1.20** | `𝒟'={↑X}`, `𝒟' ` positive, `\|𝒟\|≅\|𝒟'\|` — uses Def 1.9 (this session) |
| **Exercise 1.21** | the `{[X]}` system is *positive* and *complete* — uses Theorem 1.10 (this session) |
| **Exercise 1.24** | existence of total (maximal) extensions — **classical** (Zorn/choice); `IsTotal` predicate already in `Basic.lean` |
| **Lectures II / III** | §4.2.II (approximable mappings, Def 2.1 → Ex 2.22) and §4.2.III (constructions, Def 3.1 → Ex 3.28) — planned roots `Approximable.lean`, `Constructions.lean` |

---

## Key reference files

| File | Role |
| ---- | ------ |
| `sources/PRG19_vision.md` | **primary source** (Def 1.9 at lines 321–322, Theorem 1.10 at 329–359) |
| `Domain/Neighborhood/Basic.lean` | core: `NeighborhoodSystem` (+`sub_master`), `Element`/`Element.ext`, `PartialOrder`, `NestedOrDisjoint`/`ofNestedOrDisjoint`, `limitFamily`/`SeqEquiv`/`limitFamily_eq_iff`, `principal`/`principal_le_iff`/`principal_injective`/`eq_iUnion_principal`, `bot`/`mem_bot`/`bot_le`/`OrderBot`/`IsTotal`/`eq_principal_of_isMin` — **add `DomainIso` (Def 1.9) here** |
| `Domain/Neighborhood/ExampleB.lean` | binary sequences (this session): `cone`/`memB`/`cone_trichotomy`/`B`, `prepend`/`prepend_cone`, `sigmaBot`/`sigmaBot_le_iff`, `sigmaElt`/`sigmaElt_bot`, `mem_iff_exists_sigmaBot` |
| `Domain/Neighborhood/Example12–15.lean` | the four finite worked examples |
| `Domain/Neighborhood/Exercise122.lean` | topology on `|𝒟|` (Exercise 1.22); **`basicOpen` = `[X]`** (reuse for Theorem 1.10) |
| `Domain.lean` | module index — **add `Theorem110` here** |
| `arxiv.md` | Goal Lists (§4.2 / §4.2.II / §4.2.III), dependency graph (§4.3), status (§4.4), proof notes (§4.5) |

The Part I → Part II gate is **open** — all prerequisites green.
