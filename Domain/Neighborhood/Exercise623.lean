import Domain.Neighborhood.Exercise621
import Domain.Neighborhood.Theorem69

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
open Domain.Neighborhood.Example62 Domain.Neighborhood.ExampleB Domain.Neighborhood.Exercise510

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

/-! ## Phase 2 — the strict-map category, the endofunctor `T`, and the algebra `Exp`

Following Scott (and Exercise 6.17's `StrictDomainObj`), but over the *fixed* token type `Str`: the
objects are `ScottSys` (∅-free systems over `Str`), the morphisms are **strict** approximable maps.
Because every object lives over `Str`, all carrier equalities are `rfl` and there is no `HEq`
transport (the obstruction that made the abstract Theorem 6.14 unusable). The functor `Texp N` then
becomes a genuine `Endofunctor` of this category, and the colimit `Exp` of Phase 1 — together with the
structure equality `T(Exp) = Exp` — is a `T`-algebra. -/

/-- **The category of `∅`-free domains over `Str` and strict maps.** Morphisms are strict approximable
maps (`StrictMap`); identities and associative composition are Theorem 2.5, with strictness preserved
by `isStrict_idMap`/`isStrict_comp`. The fixed carrier `Str` is what removes all the carrier-transport
`HEq` that burdens the abstract `Endofunctor DomainObj`. -/
instance : Category ScottSys where
  Hom A B := StrictMap A.sys B.sys
  id A := ⟨idMap A.sys, isStrict_idMap⟩
  comp g f := ⟨g.1.comp f.1, isStrict_comp g.2 f.2⟩
  id_comp f := Subtype.ext (idMap_comp f.1)
  comp_id f := Subtype.ext (comp_idMap f.1)
  assoc h g f := Subtype.ext (comp_assoc h.1 g.1 f.1)

@[simp] theorem ScottSys.id_val (A : ScottSys) :
    (Category.id A : StrictMap A.sys A.sys).1 = idMap A.sys := rfl

@[simp] theorem ScottSys.comp_val {A B C : ScottSys} (g : Category.Hom B C) (f : Category.Hom A B) :
    ((g ⊚ f : StrictMap A.sys C.sys)).1 = g.1.comp f.1 := rfl

/-- The morphism action of `gFunctor T`: a strict `f` is sent to the strict map `T(f)`. (Typed via
`StrictMap`, which is defeq to the category's `Hom`; this avoids the class-projection that blocks the
anonymous `.1` on `Category.Hom`.) -/
def gFunctorMap (T : GExpr) {X Y : ScottSys} (f : StrictMap X.sys Y.sys) :
    StrictMap (T.obj X).sys (T.obj Y).sys :=
  ⟨T.map f.1, T.map_isStrict f.1 f.2⟩

/-- **Every `GExpr` is an `Endofunctor` of the strict-map category.** On objects it is `GExpr.obj`;
on a strict map `f` it is the strict map `T(f)` (`GExpr.map_isStrict`). Functoriality is
`GExpr.map_id` and `GExpr.map_comp` (the latter needs `g` strict — automatic here, since every
morphism of this category is strict). -/
def gFunctor (T : GExpr) : Endofunctor ScottSys where
  obj := T.obj
  map := gFunctorMap T
  map_id X := Subtype.ext (T.map_id X)
  map_comp {_ _ _} g f :=
    Subtype.ext (T.map_comp (f : StrictMap _ _).1 (g : StrictMap _ _).2)

@[simp] theorem gFunctor_obj (T : GExpr) (X : ScottSys) : (gFunctor T).obj X = T.obj X := rfl

@[simp] theorem gFunctorMap_val (T : GExpr) {X Y : ScottSys} (f : StrictMap X.sys Y.sys) :
    (gFunctorMap T f).1 = T.map f.1 := rfl

/-- **The endofunctor `T(X) = N ⊕ ((X×X) + (X×X))`** of Exercise 6.23. -/
def TexpF (N : ScottSys) : Endofunctor ScottSys := gFunctor (Texp N)

/-- The identity isomorphism in any category induced by an object equality. -/
def isoOfObjEq {Obj : Type*} [Category Obj] {X Y : Obj} (h : X = Y) : Iso X Y := by
  cases h
  exact ⟨Category.id X, Category.id X, Category.id_comp _, Category.id_comp _⟩

/-- **The structure isomorphism `T(Exp) ≅ Exp`.** Since Phase 1 proved `T(Exp) = Exp` as objects
(`Exp_structure_eq`), this is the identity isomorphism. -/
def ExpIso (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) :
    Iso ((TexpF N).obj (Exp N hN)) (Exp N hN) :=
  isoOfObjEq (Exp_structure_eq N hN)

/-- **`Exp` as a `T`-algebra** with structure map the isomorphism `T(Exp) ≅ Exp` (the identity, since
`T(Exp) = Exp`). This realises Scott's "construe the initial solution as a syntactic domain of
expressions": `Exp` is an algebra of `T(X) = N ⊕ ((X×X)+(X×X))`. -/
def ExpAlg (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) : TAlgebra (TexpF N) where
  carrier := Exp N hN
  str := (ExpIso N hN).hom

/-! ## Phase 3 — the evaluation homomorphism `val(s)` (existence)

Given any algebra `B = (D, k)` of `T(X) = N ⊕ ((X×X)+(X×X))` — i.e. a domain `D` carrying (through the
universal properties of `⊕`,`+`,`×`) a strict variable map `s : N → D` and two binary operations
`u, v : D×D → D` — we build a `T`-algebra homomorphism `val : Exp → D`. This is Scott's *"evaluation
of an expression"*.

Since Phase 1's structure map `i : T(Exp) → Exp` is the **identity** (`Exp_structure_eq`), the
homomorphism equation `val ∘ i = k ∘ T(val)` is the fixed-point equation `val = k ∘ T(val) ∘ j`
(`j = i⁻¹`). We solve it directly by the Kleene iteration `valₙ` (`val₀ = ⊥`,
`valₙ₊₁ = k ∘ T(valₙ) ∘ j`) and take `val = ⋃ₙ valₙ`. The fixed-point property uses *continuity on
maps* (`GExpr.map_continuous`: `T(⋃ valₙ) = ⋃ T(valₙ)`); no projection machinery is needed for
existence. (Uniqueness — initiality — is the remaining Phase 4.) -/

/-- The structure map of an algebra `B`, as a raw approximable map (its strictness is `algStr_strict`).
The ascription to `StrictMap` forces the categorical `Hom` to its underlying subtype. -/
def algStr (B : TAlgebra (TexpF N)) :
    ApproximableMap ((Texp N).obj B.carrier).sys B.carrier.sys :=
  (B.str : StrictMap ((Texp N).obj B.carrier).sys B.carrier.sys).1

theorem algStr_strict (B : TAlgebra (TexpF N)) : IsStrict (algStr B) :=
  (B.str : StrictMap ((Texp N).obj B.carrier).sys B.carrier.sys).2

/-- The inverse `j = i⁻¹ : Exp → T(Exp)` of the structure isomorphism, as a raw map. -/
def expInv (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) :
    ApproximableMap (Exp N hN).sys ((Texp N).obj (Exp N hN)).sys :=
  ((ExpIso N hN).inv : StrictMap (Exp N hN).sys ((Texp N).obj (Exp N hN)).sys).1

theorem expInv_strict (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) : IsStrict (expInv N hN) :=
  ((ExpIso N hN).inv : StrictMap (Exp N hN).sys ((Texp N).obj (Exp N hN)).sys).2

/-- The structure map `i : T(Exp) → Exp` as a raw map (the identity, since `T(Exp) = Exp`). -/
def expHom (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) :
    ApproximableMap ((Texp N).obj (Exp N hN)).sys (Exp N hN).sys :=
  ((ExpIso N hN).hom : StrictMap ((Texp N).obj (Exp N hN)).sys (Exp N hN).sys).1

/-- `j ∘ i = I_{T(Exp)}` at the raw level (from the iso's `hom_inv_id`). -/
theorem expInv_comp_expHom (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) :
    (expInv N hN).comp (expHom N hN) = idMap ((Texp N).obj (Exp N hN)).sys := by
  have h := congrArg (Subtype.val) (ExpIso N hN).hom_inv_id
  simpa [expInv, expHom] using h

/-- `i ∘ j = I_Exp` at the raw level (from the iso's `inv_hom_id`). -/
theorem expHom_comp_expInv (N : ScottSys) (hN : ([] : Str) ∈ N.sys.master) :
    (expHom N hN).comp (expInv N hN) = idMap (Exp N hN).sys := by
  have h := congrArg (Subtype.val) (ExpIso N hN).inv_hom_id
  simpa [expInv, expHom] using h

section Existence

variable {N : ScottSys} (hN : ([] : Str) ∈ N.sys.master) (B : TAlgebra (TexpF N))

/-- **The Kleene iterates `valₙ : Exp → D`** of the operator `λh. k ∘ T(h) ∘ j`. `val₀ = ⊥`,
`valₙ₊₁ = k ∘ T(valₙ) ∘ j`. -/
def descRel : ℕ → ApproximableMap (Exp N hN).sys B.carrier.sys
  | 0 => constMap (Exp N hN).sys B.carrier.sys.bot
  | n + 1 => (algStr B).comp (((Texp N).map (descRel n)).comp (expInv N hN))

@[simp] theorem descRel_succ (n : ℕ) :
    descRel hN B (n + 1) = (algStr B).comp (((Texp N).map (descRel hN B n)).comp (expInv N hN)) :=
  rfl

/-- Every iterate is strict. -/
theorem descRel_isStrict : ∀ n, IsStrict (descRel hN B n)
  | 0 => isStrict_constBot
  | n + 1 => by
      rw [descRel_succ]
      exact isStrict_comp (algStr_strict B)
        (isStrict_comp ((Texp N).map_isStrict _ (descRel_isStrict n)) (expInv_strict N hN))

/-- The constant `⊥` map is below every approximable map (it relates each domain neighbourhood only
to the codomain master, which every map produces by monotonicity from `master_rel`). -/
theorem constBot_le {α β : Type*} {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β}
    (g : ApproximableMap V₀ V₁) : constMap V₀ V₁.bot ≤ g := by
  intro X Y hr
  obtain ⟨hX, hY⟩ := hr
  rw [NeighborhoodSystem.mem_bot] at hY
  subst hY
  exact g.mono g.master_rel (V₀.sub_master hX) subset_rfl hX V₁.master_mem

/-- The iterates increase: `valₙ ≤ valₙ₊₁`. -/
theorem descRel_le_succ : ∀ n, descRel hN B n ≤ descRel hN B (n + 1)
  | 0 => constBot_le _
  | n + 1 => by
      rw [descRel_succ, descRel_succ]
      exact comp_mono_gen le_rfl
        (comp_mono_gen ((Texp N).map_mono (descRel_le_succ n)) le_rfl)

/-- The iterates form a `≤`-chain. -/
theorem descRel_mono {i j : ℕ} (h : i ≤ j) : descRel hN B i ≤ descRel hN B j := by
  induction h with
  | refl => exact le_rfl
  | step _ ih => exact ih.trans (descRel_le_succ hN B _)

/-- Directedness witness for the union (any two iterates are dominated by the later one). -/
theorem descDir (i j : ℕ) : ∃ k, (∀ X Y, (descRel hN B i).rel X Y → (descRel hN B k).rel X Y) ∧
    (∀ X Y, (descRel hN B j).rel X Y → (descRel hN B k).rel X Y) :=
  ⟨max i j, descRel_mono hN B (le_max_left i j), descRel_mono hN B (le_max_right i j)⟩

/-- **The evaluation map `val = ⋃ₙ valₙ`** as an approximable map. -/
def descMap : ApproximableMap (Exp N hN).sys B.carrier.sys :=
  iSupMap (descRel hN B) (descDir hN B)

theorem descMap_rel {A E : Set Str} :
    (descMap hN B).rel A E ↔ ∃ n, (descRel hN B n).rel A E := Iff.rfl

/-- `val` is strict (a union of strict maps). -/
theorem descMap_isStrict : IsStrict (descMap hN B) := by
  rintro Y ⟨n, hn⟩
  exact descRel_isStrict hN B n hn

/-- Directedness of the iterates in `≤`-form (for `map_continuous`). -/
theorem descDirLe (i j : ℕ) :
    ∃ k, descRel hN B i ≤ descRel hN B k ∧ descRel hN B j ≤ descRel hN B k :=
  ⟨max i j, descRel_mono hN B (le_max_left i j), descRel_mono hN B (le_max_right i j)⟩

/-- `val` is the relational union of the iterates (the hypothesis for `map_continuous`). -/
theorem descMap_is_sup (A E : Set Str) :
    (descMap hN B).rel A E ↔ ∃ n, (descRel hN B n).rel A E := Iff.rfl

/-- **The fixed-point equation `val = k ∘ T(val) ∘ j`.** Forward: an iterate `valₙ` is, after the
recursion, `k ∘ T(valₙ₋₁) ∘ j`, and `T(valₙ₋₁) ⊆ T(val)` by continuity on maps. Backward: a witness
factoring through `T(valₙ)` lands in `valₙ₊₁`. -/
theorem descMap_fix :
    descMap hN B = (algStr B).comp (((Texp N).map (descMap hN B)).comp (expInv N hN)) := by
  have hmc : ∀ Y C, ((Texp N).map (descMap hN B)).rel Y C
      ↔ ∃ n, ((Texp N).map (descRel hN B n)).rel Y C :=
    fun Y C => (Texp N).map_continuous (descRel hN B) (descMap hN B) (descDirLe hN B)
      (descMap_is_sup hN B) Y C
  apply ApproximableMap.ext
  intro A E
  rw [comp_rel]
  constructor
  · rintro ⟨n, hn⟩
    have hn1 : (descRel hN B (n + 1)).rel A E := descRel_le_succ hN B n A E hn
    rw [descRel_succ, comp_rel] at hn1
    obtain ⟨C, hAC, hCE⟩ := hn1
    rw [comp_rel] at hAC
    obtain ⟨Y, hAY, hYC⟩ := hAC
    exact ⟨C, ⟨Y, hAY, (hmc Y C).mpr ⟨n, hYC⟩⟩, hCE⟩
  · rintro ⟨C, hAC, hCE⟩
    rw [comp_rel] at hAC
    obtain ⟨Y, hAY, hYC⟩ := hAC
    obtain ⟨n, hn⟩ := (hmc Y C).mp hYC
    refine ⟨n + 1, ?_⟩
    rw [descRel_succ, comp_rel]
    exact ⟨C, by rw [comp_rel]; exact ⟨Y, hAY, hn⟩, hCE⟩

/-- **The homomorphism square `val ∘ i = k ∘ T(val)`** at the raw level (conjugating the fixed-point
equation by `i`, using `j ∘ i = I`). -/
theorem descComm :
    (descMap hN B).comp (expHom N hN) = (algStr B).comp ((Texp N).map (descMap hN B)) := by
  calc (descMap hN B).comp (expHom N hN)
      = ((algStr B).comp (((Texp N).map (descMap hN B)).comp (expInv N hN))).comp (expHom N hN) := by
        rw [← descMap_fix]
    _ = (algStr B).comp ((((Texp N).map (descMap hN B)).comp (expInv N hN)).comp (expHom N hN)) := by
        rw [comp_assoc]
    _ = (algStr B).comp (((Texp N).map (descMap hN B)).comp ((expInv N hN).comp (expHom N hN))) := by
        rw [comp_assoc]
    _ = (algStr B).comp (((Texp N).map (descMap hN B)).comp (idMap _)) := by
        rw [expInv_comp_expHom]
    _ = (algStr B).comp ((Texp N).map (descMap hN B)) := by rw [comp_idMap]

/-- **The evaluation homomorphism `val(s) : Exp → D`** as a `T`-algebra homomorphism — Scott's
existence of the evaluation map. -/
def descAlgHom : AlgHom (ExpAlg N hN) B where
  hom := ⟨descMap hN B, descMap_isStrict hN B⟩
  comm := by
    apply Subtype.ext
    show (descMap hN B).comp (expHom N hN) = (algStr B).comp ((Texp N).map (descMap hN B))
    exact descComm hN B

/-- **Every homomorphism `g : Exp → D` is a fixed point** of the operator `λh. k ∘ T(h) ∘ j`. This is
the homomorphism square `g ∘ i = k ∘ T(g)` (`g.comm`) rearranged by `i ∘ j = I`. -/
theorem algHom_fix (g : AlgHom (ExpAlg N hN) B) :
    g.hom.1 = (algStr B).comp (((Texp N).map g.hom.1).comp (expInv N hN)) := by
  have hcomm : (g.hom.1).comp (expHom N hN) = (algStr B).comp ((Texp N).map g.hom.1) :=
    congrArg Subtype.val g.comm
  calc g.hom.1
      = (g.hom.1).comp (idMap (Exp N hN).sys) := (comp_idMap _).symm
    _ = (g.hom.1).comp ((expHom N hN).comp (expInv N hN)) := by rw [expHom_comp_expInv]
    _ = ((g.hom.1).comp (expHom N hN)).comp (expInv N hN) := (comp_assoc _ _ _).symm
    _ = ((algStr B).comp ((Texp N).map g.hom.1)).comp (expInv N hN) :=
          congrArg (fun m => m.comp (expInv N hN)) hcomm
    _ = (algStr B).comp (((Texp N).map g.hom.1).comp (expInv N hN)) := comp_assoc _ _ _

/-- **`descAlgHom` is the least homomorphism**: `val ≤ g` for every homomorphism `g : Exp → D`. The
Kleene iterates `valₙ` lie below any fixed point `g` (induction: `val₀ = ⊥ ≤ g`, and the operator is
monotone with `g` its own fixed point), so their union `val` does too. This is the easy half of
initiality; the matching `g ≤ val` (so `g = val`) is the projection-chain argument of Phase 4. -/
theorem descRel_le_algHom (g : AlgHom (ExpAlg N hN) B) : ∀ n, descRel hN B n ≤ g.hom.1
  | 0 => constBot_le _
  | n + 1 => by
      rw [descRel_succ, algHom_fix hN B g]
      exact comp_mono_gen le_rfl
        (comp_mono_gen ((Texp N).map_mono (descRel_le_algHom g n)) le_rfl)

theorem descMap_le_algHom (g : AlgHom (ExpAlg N hN) B) : descMap hN B ≤ g.hom.1 := by
  intro X Y hr
  obtain ⟨n, hn⟩ := hr
  exact descRel_le_algHom hN B g n X Y hn

end Existence

end Exercise619

end Domain.Neighborhood
