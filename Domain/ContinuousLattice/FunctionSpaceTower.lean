import Domain.ContinuousLattice.InverseLimits

/-!
# The function-space tower and Scott's `D_∞ ≅ [D_∞ → D_∞]` (Scott 1972, §4, Theorem 4.4)

Starting from a continuous lattice `D₀` together with a chosen projection `j₀ : [D₀ → D₀] → D₀`
(Proposition 3.13 provides one), we build the recursively-defined ω-system

  `D_{n+1} = [D_n → D_n]`,   `j_{n+1} = [j_n → j_n]`   (the function-space functor, Proposition 3.7),

and form its inverse limit `D_∞`. Theorem 4.4 is that `D_∞` is *homeomorphic to its own function
space* `[D_∞ → D_∞]`.
-/

namespace Domain.ContinuousLattice

universe u

/-- A complete lattice bundled with its instance, used to define the function-space tower by
recursion on `ℕ` (the type at level `n+1` depends on the lattice structure at level `n`). -/
structure CLat : Type (u + 1) where
  carrier : Type u
  [str : CompleteLattice carrier]

attribute [instance] CLat.str

/-- The tower `D₀, [D₀→D₀], [[D₀→D₀]→[D₀→D₀]], …` as bundled complete lattices. -/
noncomputable def towerCLat (D₀ : CLat.{u}) : ℕ → CLat.{u}
  | 0 => D₀
  | (n + 1) => ⟨ScottMap (towerCLat D₀ n).carrier (towerCLat D₀ n).carrier⟩

/-- The carrier `Dₙ` of the function-space tower. -/
def towerType (D₀ : CLat.{u}) (n : ℕ) : Type u := (towerCLat D₀ n).carrier

noncomputable instance towerCompleteLattice (D₀ : CLat.{u}) (n : ℕ) :
    CompleteLattice (towerType D₀ n) := (towerCLat D₀ n).str

@[simp] theorem towerType_zero (D₀ : CLat.{u}) : towerType D₀ 0 = D₀.carrier := rfl

/-- `D_{n+1}` is *definitionally* the function space `[Dₙ → Dₙ]`. -/
theorem towerType_succ (D₀ : CLat.{u}) (n : ℕ) :
    towerType D₀ (n + 1) = ScottMap (towerType D₀ n) (towerType D₀ n) := rfl

/-- View an element of `D_{n+1}` as the Scott map `[Dₙ → Dₙ]` it definitionally is. -/
def towerToMap {D₀ : CLat.{u}} {n : ℕ} (f : towerType D₀ (n + 1)) :
    ScottMap (towerType D₀ n) (towerType D₀ n) := f

/-- Apply an element of `D_{n+1}` as a function `Dₙ → Dₙ` (definitional via `towerType_succ`). -/
instance towerCoeFun {D₀ : CLat.{u}} {n : ℕ} :
    CoeFun (towerType D₀ (n + 1)) (fun _ => towerType D₀ n → towerType D₀ n) where
  coe f := towerToMap f

@[simp] theorem towerToMap_coe {D₀ : CLat.{u}} {n : ℕ} (f : towerType D₀ (n + 1))
    (x : towerType D₀ n) : towerToMap f x = f x := rfl

/-! ### The function-space functor on projections (Proposition 3.7, continuous form)

`proposition_3_7_projection` builds the embedding/projection pair on function spaces as *plain
functions*; here we upgrade them to genuine Scott maps, so that `[Dₙ → Dₙ]` is a continuous-lattice
projection of `[D_{n+1} → D_{n+1}]`. The map `f ↦ post ∘ f ∘ pre` (conjugation) is Scott-continuous
because directed suprema of function spaces are computed pointwise. -/

section Conj

open Set

variable {Y Z W : Type u} [CompleteLattice Y] [CompleteLattice Z] [CompleteLattice W]

/-- Conjugation `f ↦ post ∘ f ∘ pre` as a bare function `[Y → Y] → [W → Z]`. -/
def conjMapFun (post : ScottMap Y Z) (pre : ScottMap W Y) (f : ScottMap Y Y) : ScottMap W Z :=
  post.comp (f.comp pre)

theorem conjMapFun_apply (post : ScottMap Y Z) (pre : ScottMap W Y) (f : ScottMap Y Y) (x : W) :
    conjMapFun post pre f x = post (f (pre x)) := rfl

theorem conjMap_preservesDirectedSup (post : ScottMap Y Z) (pre : ScottMap W Y) :
    PreservesDirectedSup (conjMapFun post pre) := by
  intro F hF hFdir
  apply ScottMap.ext
  intro x
  have hdir : DirectedOn (· ≤ ·) ((fun f : ScottMap Y Y => f (pre x)) '' F) := by
    rintro _ ⟨a, ha, rfl⟩ _ ⟨b, hb, rfl⟩
    obtain ⟨c, hc, hac, hbc⟩ := hFdir a ha b hb
    exact ⟨c (pre x), ⟨c, hc, rfl⟩, hac (pre x), hbc (pre x)⟩
  show post ((sSup F : ScottMap Y Y) (pre x)) = (sSup (conjMapFun post pre '' F) : ScottMap W Z) x
  rw [ScottMap.sSup_apply F (pre x), post.preservesDirectedSup_coe _ (hF.image _) hdir,
    ScottMap.sSup_apply, Set.image_image, Set.image_image]
  rfl

/-- Conjugation `f ↦ post ∘ f ∘ pre` as a Scott map `[Y → Y] → [W → Z]`. -/
noncomputable def conjMap (post : ScottMap Y Z) (pre : ScottMap W Y) :
    ScottMap (ScottMap Y Y) (ScottMap W Z) :=
  ⟨conjMapFun post pre, continuous_of_preservesDirectedSup (conjMap_preservesDirectedSup post pre)⟩

@[simp] theorem conjMap_apply (post : ScottMap Y Z) (pre : ScottMap W Y) (f : ScottMap Y Y) (x : W) :
    conjMap post pre f x = post (f (pre x)) := rfl

end Conj

/-- **Scott 1972, Proposition 3.7 (continuous projection on the diagonal).** If `D` is a
continuous-lattice projection of `D'`, then `[D → D]` is a projection of `[D' → D']` via
`i_{[·]}(f) = i ∘ f ∘ j` and `j_{[·]}(g) = j ∘ g ∘ i`. -/
noncomputable def IsContinuousLatticeProjection.functionSpace
    {A B : Type u} [CompleteLattice A] [CompleteLattice B]
    (P : IsContinuousLatticeProjection A B) :
    IsContinuousLatticeProjection (ScottMap A A) (ScottMap B B) where
  incl := conjMap P.incl P.retr
  retr := conjMap P.retr P.incl
  retr_incl f := by
    apply ScottMap.ext; intro x
    simp only [conjMap_apply, P.retr_incl]
  incl_retr_le g := by
    rw [ScottMap.le_def]; intro x
    simp only [conjMap_apply]
    exact le_trans (P.incl_retr_le _) (g.monotone (P.incl_retr_le x))

/-- The projection tower `j_{n+1} = [j_n → j_n]`, anchored at a chosen base projection
`j₀ : [D₀ → D₀] → D₀`. -/
noncomputable def towerProj (D₀ : CLat.{u})
    (j₀ : IsContinuousLatticeProjection D₀.carrier (ScottMap D₀.carrier D₀.carrier)) :
    ∀ n, IsContinuousLatticeProjection (towerType D₀ n) (towerType D₀ (n + 1))
  | 0 => j₀
  | (n + 1) => (towerProj D₀ j₀ n).functionSpace

theorem towerProj_succ (D₀ : CLat.{u})
    (j₀ : IsContinuousLatticeProjection D₀.carrier (ScottMap D₀.carrier D₀.carrier)) (n : ℕ) :
    towerProj D₀ j₀ (n + 1) = (towerProj D₀ j₀ n).functionSpace := rfl

section Tower

variable (D₀ : CLat.{u})
  (j₀ : IsContinuousLatticeProjection D₀.carrier (ScottMap D₀.carrier D₀.carrier))

/-- **Scott 1972, §4 (recursion for the embeddings).** `i_{n+1}(x) = iₙ ∘ x ∘ jₙ`. -/
theorem towerProj_succ_incl_apply (n : ℕ) (x : towerType D₀ (n + 1)) (y : towerType D₀ (n + 1)) :
    ((towerProj D₀ j₀ (n + 1)).incl x) y
      = (towerProj D₀ j₀ n).incl (x ((towerProj D₀ j₀ n).retr y)) := rfl

/-- **Scott 1972, §4 (recursion for the projections).** `j_{n+1}(x') = jₙ ∘ x' ∘ iₙ`. -/
theorem towerProj_succ_retr_apply (n : ℕ) (x' : towerType D₀ (n + 2)) (y : towerType D₀ n) :
    ((towerProj D₀ j₀ (n + 1)).retr x') y
      = (towerProj D₀ j₀ n).retr (x' ((towerProj D₀ j₀ n).incl y)) := rfl

/-- **Scott 1972, §4 (application is preserved).** `iₙ(f(x)) = i_{n+1}(f)(iₙ(x))` for `f ∈ D_{n+1}`,
`x ∈ Dₙ`. The embeddings turn functional application into application one level up. -/
theorem towerProj_incl_apply (n : ℕ) (f : towerType D₀ (n + 1)) (x : towerType D₀ n) :
    (towerProj D₀ j₀ n).incl (f x)
      = ((towerProj D₀ j₀ (n + 1)).incl f) ((towerProj D₀ j₀ n).incl x) := by
  rw [towerProj_succ_incl_apply, (towerProj D₀ j₀ n).retr_incl]

end Tower

end Domain.ContinuousLattice
