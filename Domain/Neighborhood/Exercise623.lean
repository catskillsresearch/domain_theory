import Domain.Neighborhood.Exercise621

/-!
# Exercise 6.23 (Scott 1981, PRG-19, §6) — the syntactic domain of expressions

> **EXERCISE 6.23.** Construe the initial solution to
> `Exp ≅ N ⊕ ((Exp × Exp) + (Exp × Exp))`
> as a "syntactical domain" of expressions generated from infinitely many "variables" by means of two
> binary "operation symbols". Given an algebra `D` with two operations `u : D×D → D` and
> `v : D×D → D`, show how any strict map `s : N → D` determines a unique map `val(s) : Exp → D` that
> can be regarded as the "evaluation of an expression".

The right-hand functor is `T(X) = N ⊕ ((X×X) + (X×X))`, i.e. in the algebra `GExpr` of Exercise 6.21,
`Texp N = .oplus (.const N) (.sum (.prod .var .var) (.prod .var .var))`. Reading the structure map
`k : T(Exp) → Exp` of an algebra through the universal properties of `⊕`, `+`, `×`:

* the `⊕ N` summand gives a strict **variable map** `s : N → Exp` (the "infinitely many variables"
  are the tokens / points of `N`);
* the two `(Exp × Exp)` summands, combined by `+`, give two binary **operation symbols**
  `u, v : Exp × Exp → Exp`.

So an algebra of this functor is exactly *a domain `D` with a strict `s : N → D` and two binary
operations `u, v : D×D → D`*, and the unique homomorphism `val(s) : Exp → D` is Scott's "evaluation
of an expression": it sends a variable to its value under `s`, and an `u`/`v`-node to the `u`/`v` of
the values of its two subexpressions.

## This module (Phase 1 — the domain `Exp` itself)

Following Scott's standing restriction in Exercises 6.19–6.23 to `∅`-free systems over `{0,1}*` and
*strict* maps (`ScottSys`), and following the structure of **Theorem 6.14** (the initial solution is
the iterated colimit `𝒟 = ⋃ₙ Tⁿ({Γ})`), we build the concrete solution domain **for any rooted
`GExpr` functor** `T`:

* `gFix T = ⋃ₙ gFunⁿ({Λ})` — the token set (Exercise 6.20/6.21 fixed point `Γ = tok(T({Γ}))`);
* `gTower T n = Tⁿ({Γ})` — the iterated-functor tower of `∅`-free systems over `Str`;
* `gColim T = ⋃ₙ Tⁿ({Γ})` — the colimit system, with `gColim_obj_eq : T(gColim) = gColim` (the
  structure map is the **identity**, since the two systems are literally equal — no carrier transport
  is needed because `ScottSys` keeps the token type fixed at `Str`).

Instantiating at `Texp N` gives `Exp N := gColim (Texp N)` together with the domain-equation
**isomorphism** `Exp ≅ N ⊕ ((Exp×Exp)+(Exp×Exp))` (`Exp_structure_eq`). The algebra decomposition
(`s`, `u`, `v`) and the unique evaluation homomorphism `val(s)` (initiality) are developed in later
phases.

Everything is **choice-free** (`#print axioms ⊆ {propext, Quot.sound}`); the colimit is genuine data
built without `Classical.choice` (the generator `Γ` is the *explicit* Kleene union, not an
existential witness).
-/

namespace Domain.Neighborhood

open NeighborhoodSystem ApproximableMap Domain.Neighborhood.Exercise619
open Domain.Neighborhood.Example62 Domain.Neighborhood.ExampleB

namespace Exercise619

/-! ## The generator `Γ = ⋃ₙ gFunⁿ({Λ})` (the Exercise 6.20/6.21 fixed point, as data) -/

/-- **The fixed-point token set `Γ = tok(T({Γ}))`**, as the explicit Kleene union `⋃ₙ gIter T n`
(no `Classical.choice`). -/
def gFix (T : GExpr) : Set Str := ⋃ n, gIter T n

theorem gFix_nil_mem (T : GExpr) : ([] : Str) ∈ gFix T :=
  Set.mem_iUnion.mpr ⟨0, rfl⟩

theorem gFix_nonempty (T : GExpr) : (gFix T).Nonempty := ⟨[], gFix_nil_mem T⟩

/-- `Γ = tok(T({Γ}))` at the token level: `gFun T Γ = Γ`. -/
theorem gFix_fixed (T : GExpr) (hT : T.RootedConst) : gFun T (gFix T) = gFix T :=
  gFun_iter_fixed T hT

/-! ## The iterated-functor tower `Tⁿ({Γ})` -/

/-- **The one-point generator `{Γ}`** as an object of the category. -/
def gGen (T : GExpr) : ScottSys := singletonSys (gFix T) (gFix_nonempty T)

@[simp] theorem gGen_master (T : GExpr) : (gGen T).sys.master = gFix T := rfl

/-- **`{Γ} ◁ T({Γ})`** — Scott's hypothesis for Theorem 6.14, the base of the tower. (This is the
content of `gExists_singleton_subsystem`, here at the *explicit* generator `Γ = gFix T`.) -/
theorem gBase (T : GExpr) (hT : T.RootedConst) : (gGen T).sys ◁ (T.obj (gGen T)).sys := by
  have hmaster : (T.obj (gGen T)).sys.master = gFix T :=
    (gFun_eq_master T (gFix_nonempty T)).symm.trans (gFix_fixed T hT)
  refine ⟨hmaster.symm, ?_, ?_⟩
  · intro X hX
    have heq : X = (T.obj (gGen T)).sys.master := (hX : X = gFix T).trans hmaster.symm
    rw [heq]; exact (T.obj (gGen T)).sys.master_mem
  · intro X Y hX hY _
    show X ∩ Y = gFix T
    rw [show X = gFix T from hX, show Y = gFix T from hY, Set.inter_self]

/-- **The tower `Tⁿ({Γ})`** of `∅`-free systems over `Str`: `T⁰({Γ}) = {Γ}`, `Tⁿ⁺¹({Γ}) =
T(Tⁿ({Γ}))`. -/
def gTower (T : GExpr) : ℕ → ScottSys
  | 0 => gGen T
  | n + 1 => T.obj (gTower T n)

@[simp] theorem gTower_zero (T : GExpr) : gTower T 0 = gGen T := rfl

@[simp] theorem gTower_succ (T : GExpr) (n : ℕ) : gTower T (n + 1) = T.obj (gTower T n) := rfl

/-- **The basic chain step `Tⁿ({Γ}) ◁ Tⁿ⁺¹({Γ})`.** Base: `gBase`. Step: `T` is monotone on domains
(`obj_subsystem`). -/
theorem gChain (T : GExpr) (hT : T.RootedConst) :
    ∀ n, (gTower T n).sys ◁ (gTower T (n + 1)).sys
  | 0 => gBase T hT
  | n + 1 => T.obj_subsystem (gChain T hT n)

/-- Every level of the tower has the same master `Δ = Γ`. -/
theorem gTower_master (T : GExpr) (hT : T.RootedConst) :
    ∀ n, (gTower T n).sys.master = gFix T
  | 0 => rfl
  | n + 1 => ((gChain T hT n).master_eq).symm.trans (gTower_master T hT n)

/-- The tower is a `◁`-chain: `Tⁿ({Γ}) ◁ Tᵐ({Γ})` whenever `n ≤ m`. -/
theorem gTower_le (T : GExpr) (hT : T.RootedConst) {n m : ℕ} (h : n ≤ m) :
    (gTower T n).sys ◁ (gTower T m).sys := by
  induction h with
  | refl => exact Subsystem.refl _
  | step _ ih => exact ih.trans (gChain T hT _)

/-! ## The colimit `𝒟 = ⋃ₙ Tⁿ({Γ})` -/

/-- **The colimit system `𝒟 = ⋃ₙ Tⁿ({Γ})`** as an `∅`-free system over `Str`. A set is a
neighbourhood exactly when it is a neighbourhood of some level; closure under consistent intersection
uses that the tower is a chain (any finite collection sits inside one level). -/
def gColim (T : GExpr) (hT : T.RootedConst) : ScottSys where
  sys :=
    { mem := fun X => ∃ n, (gTower T n).sys.mem X
      master := gFix T
      master_mem := ⟨0, (gTower T 0).sys.master_mem⟩
      inter_mem := by
        rintro X Y Z ⟨n, hX⟩ ⟨m, hY⟩ ⟨p, hZ⟩ hsub
        set N := max n (max m p) with hN
        have hXN : (gTower T N).sys.mem X := (gTower_le T hT (le_max_left n _)).sub hX
        have hYN : (gTower T N).sys.mem Y :=
          (gTower_le T hT ((le_max_left m p).trans (le_max_right n _))).sub hY
        have hZN : (gTower T N).sys.mem Z :=
          (gTower_le T hT ((le_max_right m p).trans (le_max_right n _))).sub hZ
        exact ⟨N, (gTower T N).sys.inter_mem hXN hYN hZN hsub⟩
      sub_master := by
        rintro X ⟨n, hX⟩
        rw [← gTower_master T hT n]
        exact (gTower T n).sys.sub_master hX }
  ne := by rintro X ⟨n, hX⟩; exact (gTower T n).ne X hX

@[simp] theorem mem_gColim (T : GExpr) (hT : T.RootedConst) {X : Set Str} :
    (gColim T hT).sys.mem X ↔ ∃ n, (gTower T n).sys.mem X := Iff.rfl

@[simp] theorem gColim_master (T : GExpr) (hT : T.RootedConst) :
    (gColim T hT).sys.master = gFix T := rfl

/-- Each level of the tower is a subdomain of the colimit: `Tⁿ({Γ}) ◁ 𝒟`. -/
theorem gTower_sub_colim (T : GExpr) (hT : T.RootedConst) (n : ℕ) :
    (gTower T n).sys ◁ (gColim T hT).sys where
  master_eq := by rw [gColim_master, gTower_master T hT]
  sub hX := ⟨n, hX⟩
  inter_closed := by
    rintro X Y hX hY ⟨m, hXY⟩
    have hN : (gTower T (max n m)).sys.mem (X ∩ Y) :=
      (gTower_le T hT (le_max_right n m)).sub hXY
    exact (gTower_le T hT (le_max_left n m)).inter_closed hX hY hN

/-! ## The structure isomorphism `T(𝒟) = 𝒟` -/

/-- Two objects of the category with the same underlying system are equal (the `∅`-freeness field is
a `Prop`). -/
theorem ScottSys.ext {A B : ScottSys} (h : A.sys = B.sys) : A = B := by
  cases A; cases B; cases h; rfl

/-- **`T(𝒟) = 𝒟` at the level of neighbourhood systems.** Membership: continuity on domains
(`obj_continuous`) along the directed tower turns `T(⋃ₙ Tⁿ({Γ}))` into `⋃ₙ Tⁿ⁺¹({Γ})`, which has the
same neighbourhoods as `⋃ₙ Tⁿ({Γ})` (the extra `n=0` level `T⁰({Γ})` is absorbed by the chain step).
Master: both are `Γ` (`gTower_master` through `obj_subsystem` of `Tⁿ({Γ}) ◁ 𝒟`). -/
theorem gColim_obj_sys_eq (T : GExpr) (hT : T.RootedConst) :
    (T.obj (gColim T hT)).sys = (gColim T hT).sys := by
  set ℱ : Set ScottSys := Set.range (gTower T) with hℱ
  have hne : ℱ.Nonempty := ⟨gTower T 0, 0, rfl⟩
  have hsub : ∀ D ∈ ℱ, D.sys ◁ (gColim T hT).sys := by
    rintro D ⟨n, rfl⟩; exact gTower_sub_colim T hT n
  have hdir : DirectedOn (fun a b => a.sys ◁ b.sys) ℱ := by
    rintro _ ⟨n, rfl⟩ _ ⟨m, rfl⟩
    exact ⟨gTower T (max n m), ⟨max n m, rfl⟩,
      gTower_le T hT (le_max_left n m), gTower_le T hT (le_max_right n m)⟩
  have hU : ∀ X, (gColim T hT).sys.mem X ↔ ∃ D ∈ ℱ, D.sys.mem X := by
    intro X; constructor
    · rintro ⟨n, hn⟩; exact ⟨gTower T n, ⟨n, rfl⟩, hn⟩
    · rintro ⟨D, ⟨n, rfl⟩, hn⟩; exact ⟨n, hn⟩
  apply NeighborhoodSystem.ext
  · intro W
    rw [T.obj_continuous hdir hne hsub hU W]
    constructor
    · rintro ⟨D, ⟨n, rfl⟩, hn⟩
      -- `T(Tⁿ({Γ})) = Tⁿ⁺¹({Γ})`, a level of the colimit.
      exact ⟨n + 1, hn⟩
    · rintro ⟨n, hn⟩
      -- a colimit neighbourhood at level `n` is, after one chain step, at `T(Tⁿ({Γ}))`.
      exact ⟨gTower T n, ⟨n, rfl⟩, (gChain T hT n).sub hn⟩
  · -- masters: `(T 𝒟).master = (Tⁿ⁺¹({Γ})).master = Γ = 𝒟.master`, via `obj_subsystem` at `n=0`.
    have h := (T.obj_subsystem (gTower_sub_colim T hT 0)).master_eq
    rw [gColim_master]
    rw [show (T.obj (gTower T 0)) = gTower T 1 from rfl] at h
    rw [← h, gTower_master T hT]

/-- **The structure isomorphism `T(𝒟) ≅ 𝒟` is the identity** (the two objects are literally equal). -/
theorem gColim_obj_eq (T : GExpr) (hT : T.RootedConst) : T.obj (gColim T hT) = gColim T hT :=
  ScottSys.ext (gColim_obj_sys_eq T hT)

/-! ## The functor of Exercise 6.23 and the syntactic domain `Exp` -/

/-- **The functor `T(X) = N ⊕ ((X×X) + (X×X))`** of Exercise 6.23, as a `GExpr` over the variable
domain `N`. The `⊕ N` carries the variables, and the two `(X×X)` summands (combined by `+`) carry the
two binary operation symbols. -/
def Texp (N : ScottSys) : GExpr :=
  .oplus (.const N) (.sum (.prod .var .var) (.prod .var .var))

/-- `Texp N` is rooted iff the variable domain `N` is (`Λ ∈ tok(N)`, automatic for the fixed-point
solutions of 6.19–6.22). -/
theorem Texp_rooted {N : ScottSys} (hN : ([] : Str) ∈ N.sys.master) : (Texp N).RootedConst :=
  ⟨hN, ⟨trivial, trivial⟩, ⟨trivial, trivial⟩⟩

/-- **The syntactic domain of expressions** `Exp = ⋃ₙ Texpⁿ({Γ})`, the initial solution of
`Exp ≅ N ⊕ ((Exp×Exp)+(Exp×Exp))`. -/
def Exp (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) : ScottSys :=
  gColim (Texp N) (Texp_rooted hN)

/-- **The domain equation `Exp ≅ N ⊕ ((Exp×Exp)+(Exp×Exp))`**, realised as an equality of systems
(the structure map is the identity). This is the "construe the initial solution" half of
Exercise 6.23. -/
theorem Exp_structure_eq (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) :
    (Texp N).obj (Exp N hN) = Exp N hN :=
  gColim_obj_eq (Texp N) (Texp_rooted hN)

end Exercise619

end Domain.Neighborhood
