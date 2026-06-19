# Handoff — Part II, Scott 1981 (PRG-19): Lecture I tail (Exercises 1.16–1.27) → Lecture II

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

**Just landed (this session): Def 1.9, Theorems 1.10 & 1.11, Exercises 1.12–1.15.**
- **Def 1.9** (`Basic.lean`): `DomainIso V₀ V₁ := V₀.Element ≃o V₁.Element` (heterogeneous tokens);
  `Isomorphic` / `≅ᴰ := Nonempty DomainIso` with `refl`/`symm`/`trans`. `≃o` *reflects* `⊑`
  (`map_rel_iff`) = Scott's two-way inclusion-preservation. Choice-free.
- **Theorem 1.10** (`Theorem110.lean`): `bracket X = [X] = {x ∣ X∈x}`; facts `bracket_master` (1),
  `bracket_inter_nonempty_iff` (2), `bracket_inter` (3), `principal_mem_bracket` (4); one-one
  `bracket_injective`, preserving `bracket_subset_iff`. `tokenSystem : NeighborhoodSystem |𝒟|`,
  `tokenIso : |𝒟| ≃o |{[X]}|` (hand-built from `toToken`/`ofToken`), `isomorphic_tokenSystem :
  𝒟 ≅ᴰ tokenSystem`. **Choice-free** — the first "system of systems", a dry run for Part IV.
- **Theorem 1.11** (`Theorem111.lean`): `iInter x` (`mem X := ∀n, X∈xₙ`, no proviso, GLB) and
  `iUnion x hmono` (`mem X := ∃n, X∈xₙ`, `Monotone x`, LUB). `iInter_le`/`le_iInter`,
  `le_iUnion`/`iUnion_le`. Choice-free.
- **Exercise 1.12** (`Exercise112.lean`): `tail n = {m∣n≤m}` on `ℕ`; `neighborhoodSystem` (chain);
  finite `fin n=↑(tail n)` (`fin_strictMono`); unique limit/total `top` (`isTotal_iff_top`);
  `element_eq` (classical).
- **Exercise 1.13** (`Exercise113.lean`): `B`'s assertions = `ExampleB.lean`; here `branch p = ⋃ₙ
  (p↾n)⊥` (via Thm 1.11), `branch_isTotal` (infinite paths = total/maximal "limit nodes").
- **Exercise 1.14** (`Exercise114.lean`): `mem X := X=ℕ ∨ (X.Finite ∧ X.Nonempty)`; manual
  `inter_mem`; total elements = singletons `singleton_isTotal`.
- **Exercise 1.15** (`Exercise115.lean`): `flat` (`{ℕ}∪{{n}}`, fully classified, no 3-chain) vs
  `stem` (`{ℕ,{0,1}}∪{{n}}`, `stem_three_chain`); `not_isomorphic` (3-chain transports under `≃o`).
- **Axiom audit:** foundational constructions (Def 1.9, Thm 1.10/1.11, all systems) are
  `[propext, Quot.sound]`. The infinite-system **classification / maximality / non-isomorphism**
  results (Ex 1.12 `element_eq`, Ex 1.14 `singleton_isTotal`, Ex 1.15 `not_isomorphic`,
  `flat_no_infinite_chain`) use `Classical.choice` — inherent (decide boundedness/membership;
  proof-by-contradiction maximality). Scratch audit file deleted.

**→ 32 Pass.** `lake build Domain` is green.

**Your task this session:** continue the Lecture I exercise backlog. Highest-value next items, both
of which now have their prerequisites in place:
- **Exercise 1.20** (lines 467–479): `Δ'=𝒟`, `𝒟'={↑X ∣ X∈𝒟}` with `↑X={Y∈𝒟∣Y⊆X}`; `𝒟'` is
  *positive*; `|𝒟|≅|𝒟'|` (uses **Def 1.9**, landed); tokens ↔ finite elements one-one. This is the
  dual of Theorem 1.10 and another Part IV dry run.
- **Exercise 1.21** (lines 481–485): the `{[X]}` system (Theorem 1.10, landed) is *positive* and
  *complete*; consistency `{Xᵢ}` ⟺ `⋂[Xᵢ]≠∅`.
Or pick off the easier independent exercises: **1.16** (cofinite subsets, `|𝒟|≅𝒫(ℕ)`), **1.17**
(rational intervals on `ℝ`), **1.18** (consistent `C⊆𝒟`, least filter ⊇C, `⋂` of filters), **1.19**
(positive systems), **1.25** (ordinal final segments).

---

## Hard constraints

- **Zero `sorry`s.** Everything must compile under `lake build`.
- **Axiom footprint:** keep *constructions* and *structural* results choice-free
  (`[propext, Quot.sound]`); audit with `#print axioms` in a scratch file, then delete it. Classical
  steps are acceptable **only** where genuinely needed (deciding an infinite predicate, Zorn-style
  maximal extensions, proof-by-contradiction maximality) — note them in the docstring + `arxiv.md`.
- **Do not commit or push** unless explicitly asked.
- **Read the source first:** `sources/PRG19_vision.md` (Exercise 1.20 at 467–479, 1.21 at 481–485,
  etc.). The `arxiv.md §4.2` rows carry the precise sub-claims.
- **Update docs on completion:** mark the row(s) **Pass** in `arxiv.md §4.2`, refresh §4.3 graph +
  §4.4 tally (currently 32), add §4.5 notes. Rewrite this `HANDOFF.md`.

---

## Current status (Part II)

| Block | Status |
| ----- | ------ |
| Vision / OCR | **Lectures I–III fully transcribed** (`sources/PRG19_vision.md`); Lecture IV partial |
| Goal List | **§4.2 (Lecture I, 40 rows, 32 Pass)**; §4.2.II (Lecture II, 22 rows) + §4.2.III (Lecture III, 28 rows) inventoried, all Not Yet |
| Lean modules | `Basic.lean`, `Example12–15.lean`, `ExampleB.lean`, `Theorem110.lean`, `Theorem111.lean`, `Exercise112–115.lean`, `Exercise122.lean` |
| Report card | **32 Pass** · rest queued (see `arxiv.md §4.2`) |

**Pass so far (Lecture I):** Def 1.1, Factoids 1.1a/1.1b, Theorem 1.1c, Def 1.6, Def 1.7, Factoids
1.7a/1.7b, Def 1.8 (order, ⊥/total), Factoids 1.8a/1.8b, **Def 1.9**, Examples 1.2–1.5, Factoids
1.4a/1.5a/1.5b, **Example 1.B + Exercises 1.B-sys/1.B-elt + Factoids 1.B-mono/1.B-lim**,
**Theorem 1.10**, **Theorem 1.11**, **Exercises 1.12, 1.13, 1.14, 1.15**, **Exercise 1.22**.

**Backlog (Lecture I):** Exercises 1.16, 1.17, 1.18, 1.19, **1.20** (needs Def 1.9 ✓), **1.21**
(needs Theorem 1.10 ✓), 1.23, 1.24 (classical, Zorn), 1.25, 1.26, 1.27. Then **Lectures II/III**
(approximable mappings; products/sums/function spaces) — planned roots `Approximable.lean`,
`Constructions.lean`.

---

## Key reference files

| File | Role |
| ---- | ------ |
| `sources/PRG19_vision.md` | **primary source** (Lecture I exercises from line 441) |
| `Domain/Neighborhood/Basic.lean` | core: `NeighborhoodSystem`, `Element`/`Element.ext`, `PartialOrder`, `NestedOrDisjoint`/`ofNestedOrDisjoint`, `limitFamily`, `principal`/`principal_le_iff`/`principal_injective`/`eq_iUnion_principal`, `bot`/`mem_bot`/`bot_le`/`OrderBot`/`IsTotal`/`eq_principal_of_isMin`, **`DomainIso`/`Isomorphic`/`≅ᴰ` (Def 1.9)** |
| `Domain/Neighborhood/Theorem110.lean` | element-token system: `bracket`/`tokenSystem`/`toToken`/`ofToken`/`tokenIso`/`isomorphic_tokenSystem` (reuse for Ex 1.20/1.21) |
| `Domain/Neighborhood/Theorem111.lean` | `iInter`/`iUnion` closure (reuse: `iUnion` already used by Ex 1.13's `branch`) |
| `Domain/Neighborhood/Exercise112–115.lean` | infinite-system examples (tails, `B` limit nodes, finite subsets, flat/stem non-iso) |
| `Domain/Neighborhood/Exercise122.lean` | topology on `|𝒟|`; `basicOpen` (= the topological `[X]`) |
| `Domain.lean` | module index — add new files here |
| `arxiv.md` | Goal Lists (§4.2 / §4.2.II / §4.2.III), dependency graph (§4.3), status (§4.4), proof notes (§4.5) |

The Part I → Part II gate is **open** — all prerequisites green.
