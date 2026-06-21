# Handoff — Scott 1981 (PRG-19): Lectures I–IV COMPLETE (IV spine Thm 4.1/4.2, Ex 4.3/4.4, Def 4.5 + Thm 4.6, **all Exercises 4.7–4.25**); **Lecture V core formalized** (Table 5.5, Thm 5.1/5.2/5.6, Prop 5.3/5.4, Ex 5.7/5.8/5.9/5.11/5.12); VI–VIII transcribed & inventoried

You are a Lean 4 proof engineer formalizing Dana Scott's 1981 *Lectures on a Mathematical Theory of
Computation* (PRG-19) in:

`/home/catskills/Desktop/domain_theory` — mathlib `v4.30.0`, Lean toolchain per `lean-toolchain`.

## Where things stand

- **`lake build Domain` is green, zero `sorry`s** (≈3056 jobs). **Theorem 5.6 is now complete
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
  *and* **every §4 exercise (4.7–4.25)** are **Pass**. **Lecture V core is now Pass** (see next
  section); VI–VIII are still `—`. Pages 108–111 were re-OCR'd to fix a page-order scramble
  (Thm 6.14 tail, Lemma 6.15, Thm 6.16, Exercises 6.17–6.20 now in correct order).

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

**Remaining Lecture V items (still `—`, larger standalone efforts):** Exercise 5.13 (one-one
`num:N×N→N`), Exercise 5.14 (`fun`/`graph`), Exercise 5.15 (free-semigroup domain), Exercise 5.16
(`neg`/`merge` on `C` — needs `tail`/tests/`cond` on `C` plus a continuity/approximation argument for
`neg(neg x)=x`).

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
| V   | §4.2.V    | 16 | Typed λ-calculus, λ-definability of partial recursive | 2383–3207 |
| VI  | §4.2.VI   | 29 | Domain equations, functors, initial `T`-algebras | 3208–4188 |
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
