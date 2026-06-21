import Domain.Neighborhood.Definition63
import Domain.Neighborhood.Theorem69
import Domain.Neighborhood.Example62C

/-!
# Exercise 6.17 (Scott 1981, PRG-19, §6) — the algebras for which `C` is initial

> **EXERCISE 6.17.** What are the algebras for which `C` is initial? If `A` of 6.2 is a generalization
> of `B`, what is the corresponding generalization of `C`? Prove that it exists and explain what are
> the algebras involved.

`C` (Example 4.4: finite-or-infinite binary sequences) satisfies the domain equation
`C ≅ {{Λ}} + C + C` (Example 6.2, `Example62C.lean`). So `C` is a solution of the domain equation for
the functor

`T(X) = 𝟙 + X + X`   (one terminator + two successor copies).

This module proves that **`C` is the *initial* `T`-algebra**: for every `T`-algebra `(E, k)` there is a
*unique* homomorphism `C → E`. Concretely a `T`-algebra is a strict map `k : 𝟙 + E + E → E`, which by
the universal property of the separated sum is the same data as

* a distinguished element `e ∈ |E|` (the image of the terminator `𝟙`), and
* two strict endomaps `f₀, f₁ : E → E` (the two successor branches);

so **the algebras for which `C` is initial are the domains carrying a point and two strict unary
operations**, and the unique homomorphism `C → E` interprets a finite-or-infinite binary sequence
`b₀b₁b₂…` as `f_{b₀}(f_{b₁}(… e …))`.

## Why a bespoke category of `∅`-free domains

Scott's separated sum `𝒟₀ + 𝒟₁` (Exercise 3.18) is a neighbourhood system **only** under the standing
assumption `∅ ∉ 𝒟` (an empty neighbourhood of one summand would become a spurious consistency witness
for the other tag, breaking `inter_mem`). Consequently the functor `T(X) = 𝟙 + X + X` does **not**
extend to a total endofunctor of the all-systems category `DomainObj`, and the existence Theorem 6.14
(stated over `DomainObj`) cannot be instantiated directly.

Following Scott — who restricts to the category of `∅`-free systems and *strict* maps in Exercise 6.19
— we instantiate the abstract categorical vocabulary (Definitions 6.3–6.5) on the bespoke object type
`StrictDomainObj` of neighbourhood systems with **no empty neighbourhood**, with **strict approximable
maps** as morphisms. The functor `T` then reuses the existing `sum3` (Example 6.2, the genuine
three-way separated sum) and a three-way sum map, and initiality of `C` is proved **directly** (we
construct the homomorphism and prove its uniqueness by the finite-approximant argument), rather than
routing through the colimit construction of Theorem 6.14.

Everything is choice-free where it is data; the homomorphism/uniqueness layer reuses the project's
established machinery.
-/

namespace Domain.Neighborhood

open NeighborhoodSystem ApproximableMap Domain.Neighborhood.Exercise510

universe w

/-! ## The category of `∅`-free domains and strict maps -/

/-- An object of Scott's category (Exercise 6.19): a token type, a neighbourhood system on it, and the
standing assumption `∅ ∉ 𝒟` (every neighbourhood is non-empty). -/
structure StrictDomainObj : Type (w + 1) where
  /-- The token type. -/
  carrier : Type w
  /-- The neighbourhood system. -/
  sys : NeighborhoodSystem carrier
  /-- Scott's standing assumption `∅ ∉ 𝒟`. -/
  nonempty : ∀ X, sys.mem X → X.Nonempty

/-- **The category of `∅`-free domains and strict maps.** Morphisms are strict approximable maps
(`StrictMap`, Exercise 5.10); identities and associative composition come from Theorem 2.5, and
strictness is preserved by `isStrict_idMap` / `isStrict_comp`. -/
instance : Category StrictDomainObj where
  Hom D E := StrictMap D.sys E.sys
  id D := ⟨ApproximableMap.idMap D.sys, isStrict_idMap⟩
  comp g f := ⟨g.1.comp f.1, isStrict_comp g.2 f.2⟩
  id_comp f := Subtype.ext (ApproximableMap.idMap_comp f.1)
  comp_id f := Subtype.ext (ApproximableMap.comp_idMap f.1)
  assoc h g f := Subtype.ext (ApproximableMap.comp_assoc h.1 g.1 f.1)

@[simp] theorem StrictDomainObj.id_val (D : StrictDomainObj) :
    (Category.id D : StrictMap D.sys D.sys).1 = ApproximableMap.idMap D.sys := rfl

@[simp] theorem StrictDomainObj.comp_val {D E F : StrictDomainObj}
    (g : Category.Hom E F) (f : Category.Hom D E) :
    ((g ⊚ f : StrictMap D.sys F.sys)).1 = g.1.comp f.1 := rfl

/-! ## The functor `T(X) = 𝟙 + X + X` on objects -/

open Example62C in
/-- Every neighbourhood of the three-way separated sum `sum3` is non-empty (so `sum3` is again an
object of the `∅`-free category). -/
theorem sum3_nonempty {α β γ : Type*} {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β}
    {V₂ : NeighborhoodSystem γ} {h₀ : ∀ X, V₀.mem X → X.Nonempty}
    {h₁ : ∀ Y, V₁.mem Y → Y.Nonempty} {h₂ : ∀ Z, V₂.mem Z → Z.Nonempty} :
    ∀ W, (sum3 V₀ V₁ V₂ h₀ h₁ h₂).mem W → W.Nonempty := by
  rintro W (rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩ | ⟨Z, hZ, rfl⟩)
  · exact ⟨none, none_mem_master3⟩
  · exact j0_nonempty (h₀ X hX)
  · exact j1_nonempty (h₁ Y hY)
  · exact j2_nonempty (h₂ Z hZ)

/-- **The functor `T(X) = 𝟙 + X + X` on objects.** Over `D`, the system is the genuine three-way
separated sum `𝟙 + D + D` (Example 6.2's `sum3`, with `𝟙 = unitSys`), again `∅`-free by
`sum3_nonempty`. -/
def tcObj (D : StrictDomainObj.{w}) : StrictDomainObj.{w} where
  carrier := Option (Unit ⊕ D.carrier ⊕ D.carrier)
  sys := sum3 unitSys D.sys D.sys Example62C.unitSys_nonempty D.nonempty D.nonempty
  nonempty := sum3_nonempty

@[simp] theorem tcObj_sys (D : StrictDomainObj.{w}) :
    (tcObj D).sys = sum3 unitSys D.sys D.sys Example62C.unitSys_nonempty D.nonempty D.nonempty := rfl

/-! ### Membership-shape lemmas for `sum3` (no nesting through the wrong tag) -/

section ShapeLemmas

open Example62C

variable {α β γ : Type*} {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β}
  {V₂ : NeighborhoodSystem γ} {h₀ : ∀ X, V₀.mem X → X.Nonempty}
  {h₁ : ∀ Y, V₁.mem Y → Y.Nonempty} {h₂ : ∀ Z, V₂.mem Z → Z.Nonempty}

/-- A `sum3`-neighbourhood contained in a `0`-copy `0X` is itself a `0`-copy. -/
theorem mem_subset_j0_inv {W : Set (Option (α ⊕ β ⊕ γ))} {X : Set α}
    (hW : (sum3 V₀ V₁ V₂ h₀ h₁ h₂).mem W) (hsub : W ⊆ j0 X) :
    ∃ X₂, V₀.mem X₂ ∧ W = j0 X₂ := by
  rcases hW with rfl | ⟨X₂, hX₂, rfl⟩ | ⟨Y₂, hY₂, rfl⟩ | ⟨Z₂, hZ₂, rfl⟩
  · exact absurd (hsub none_mem_master3) none_not_mem_j0
  · exact ⟨X₂, hX₂, rfl⟩
  · obtain ⟨b, hb⟩ := h₁ Y₂ hY₂; exact absurd (hsub (t1_mem_j1.mpr hb)) t1_not_mem_j0
  · obtain ⟨c, hc⟩ := h₂ Z₂ hZ₂; exact absurd (hsub (t2_mem_j2.mpr hc)) t2_not_mem_j0

/-- A `sum3`-neighbourhood contained in a `1`-copy `1Y` is itself a `1`-copy. -/
theorem mem_subset_j1_inv {W : Set (Option (α ⊕ β ⊕ γ))} {Y : Set β}
    (hW : (sum3 V₀ V₁ V₂ h₀ h₁ h₂).mem W) (hsub : W ⊆ j1 Y) :
    ∃ Y₂, V₁.mem Y₂ ∧ W = j1 Y₂ := by
  rcases hW with rfl | ⟨X₂, hX₂, rfl⟩ | ⟨Y₂, hY₂, rfl⟩ | ⟨Z₂, hZ₂, rfl⟩
  · exact absurd (hsub none_mem_master3) none_not_mem_j1
  · obtain ⟨a, ha⟩ := h₀ X₂ hX₂; exact absurd (hsub (t0_mem_j0.mpr ha)) t0_not_mem_j1
  · exact ⟨Y₂, hY₂, rfl⟩
  · obtain ⟨c, hc⟩ := h₂ Z₂ hZ₂; exact absurd (hsub (t2_mem_j2.mpr hc)) t2_not_mem_j1

/-- A `sum3`-neighbourhood contained in a `2`-copy `2Z` is itself a `2`-copy. -/
theorem mem_subset_j2_inv {W : Set (Option (α ⊕ β ⊕ γ))} {Z : Set γ}
    (hW : (sum3 V₀ V₁ V₂ h₀ h₁ h₂).mem W) (hsub : W ⊆ j2 Z) :
    ∃ Z₂, V₂.mem Z₂ ∧ W = j2 Z₂ := by
  rcases hW with rfl | ⟨X₂, hX₂, rfl⟩ | ⟨Y₂, hY₂, rfl⟩ | ⟨Z₂, hZ₂, rfl⟩
  · exact absurd (hsub none_mem_master3) none_not_mem_j2
  · obtain ⟨a, ha⟩ := h₀ X₂ hX₂; exact absurd (hsub (t0_mem_j0.mpr ha)) t0_not_mem_j2
  · obtain ⟨b, hb⟩ := h₁ Y₂ hY₂; exact absurd (hsub (t1_mem_j1.mpr hb)) t1_not_mem_j2
  · exact ⟨Z₂, hZ₂, rfl⟩

end ShapeLemmas

/-! ### The three-way sum map `f₀ + f₁ + f₂` -/

section SumMap3

open Example62C

variable {α β γ α' β' γ' : Type*}
  {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β} {V₂ : NeighborhoodSystem γ}
  {V₀' : NeighborhoodSystem α'} {V₁' : NeighborhoodSystem β'} {V₂' : NeighborhoodSystem γ'}
  {h₀ : ∀ X, V₀.mem X → X.Nonempty} {h₁ : ∀ Y, V₁.mem Y → Y.Nonempty}
  {h₂ : ∀ Z, V₂.mem Z → Z.Nonempty}
  {h₀' : ∀ X, V₀'.mem X → X.Nonempty} {h₁' : ∀ Y, V₁'.mem Y → Y.Nonempty}
  {h₂' : ∀ Z, V₂'.mem Z → Z.Nonempty}

/-- **The three-way sum map `f₀ + f₁ + f₂ : 𝒟₀+𝒟₁+𝒟₂ → 𝒟₀'+𝒟₁'+𝒟₂'`.** Routes each tagged copy `iX`
through `fᵢ` (to `iYᵢ'`), and sends everything to the codomain master. (The three-way analogue of
Exercise 3.19's `sumMap`.) -/
def sumMap3 (f₀ : ApproximableMap V₀ V₀') (f₁ : ApproximableMap V₁ V₁')
    (f₂ : ApproximableMap V₂ V₂') :
    ApproximableMap (sum3 V₀ V₁ V₂ h₀ h₁ h₂) (sum3 V₀' V₁' V₂' h₀' h₁' h₂') where
  rel W W' := (sum3 V₀ V₁ V₂ h₀ h₁ h₂).mem W ∧ (sum3 V₀' V₁' V₂' h₀' h₁' h₂').mem W' ∧
    (W' = master3 V₀' V₁' V₂' ∨
      (∃ X Y', W = j0 X ∧ W' = j0 Y' ∧ f₀.rel X Y') ∨
      (∃ X Y', W = j1 X ∧ W' = j1 Y' ∧ f₁.rel X Y') ∨
      (∃ X Y', W = j2 X ∧ W' = j2 Y' ∧ f₂.rel X Y'))
  rel_dom h := h.1
  rel_cod h := h.2.1
  master_rel := ⟨(sum3 V₀ V₁ V₂ h₀ h₁ h₂).master_mem, (sum3 V₀' V₁' V₂' h₀' h₁' h₂').master_mem,
    Or.inl rfl⟩
  inter_right := by
    rintro W W'₁ W'₂ ⟨hW, hW'₁, hd₁⟩ ⟨_, hW'₂, hd₂⟩
    have hmem : ∀ W'' : Set (Option (α' ⊕ β' ⊕ γ')),
        (W'' = master3 V₀' V₁' V₂' ∨
          (∃ X Y', W = j0 X ∧ W'' = j0 Y' ∧ f₀.rel X Y') ∨
          (∃ X Y', W = j1 X ∧ W'' = j1 Y' ∧ f₁.rel X Y') ∨
          (∃ X Y', W = j2 X ∧ W'' = j2 Y' ∧ f₂.rel X Y')) →
          (sum3 V₀' V₁' V₂' h₀' h₁' h₂').mem W'' := by
      rintro W'' (rfl | ⟨_, Y', _, rfl, hf⟩ | ⟨_, Y', _, rfl, hf⟩ | ⟨_, Y', _, rfl, hf⟩)
      · exact (sum3 V₀' V₁' V₂' h₀' h₁' h₂').master_mem
      · exact Or.inr (Or.inl ⟨Y', f₀.rel_cod hf, rfl⟩)
      · exact Or.inr (Or.inr (Or.inl ⟨Y', f₁.rel_cod hf, rfl⟩))
      · exact Or.inr (Or.inr (Or.inr ⟨Y', f₂.rel_cod hf, rfl⟩))
    have key : (W'₁ ∩ W'₂ = master3 V₀' V₁' V₂' ∨
        (∃ X Y', W = j0 X ∧ W'₁ ∩ W'₂ = j0 Y' ∧ f₀.rel X Y') ∨
        (∃ X Y', W = j1 X ∧ W'₁ ∩ W'₂ = j1 Y' ∧ f₁.rel X Y') ∨
        (∃ X Y', W = j2 X ∧ W'₁ ∩ W'₂ = j2 Y' ∧ f₂.rel X Y')) := by
      rcases hd₁ with rfl | ⟨X, Y'₁, hWX₁, rfl, hf₁⟩ | ⟨Y, Y'₁, hWY₁, rfl, hf₁⟩
        | ⟨Z, Y'₁, hWZ₁, rfl, hf₁⟩
      · rw [Set.inter_eq_right.mpr (show W'₂ ⊆ master3 V₀' V₁' V₂' from
          (sum3 V₀' V₁' V₂' h₀' h₁' h₂').sub_master hW'₂)]; exact hd₂
      · rcases hd₂ with rfl | ⟨X', Y'₂, hWX₂, rfl, hf₂⟩ | ⟨Y', Y'₂, hWY₂, rfl, hf₂⟩
          | ⟨Z', Y'₂, hWZ₂, rfl, hf₂⟩
        · rw [Set.inter_eq_left.mpr (j0_subset_master3 (f₀.rel_cod hf₁))]
          exact Or.inr (Or.inl ⟨X, Y'₁, hWX₁, rfl, hf₁⟩)
        · obtain rfl : X = X' := j0_injective (hWX₁.symm.trans hWX₂)
          rw [j0_inter_j0]
          exact Or.inr (Or.inl ⟨X, Y'₁ ∩ Y'₂, hWX₁, rfl, f₀.inter_right hf₁ hf₂⟩)
        · obtain ⟨a, ha⟩ := h₀ X (f₀.rel_dom hf₁)
          exact absurd ((hWX₁.symm.trans hWY₂) ▸ t0_mem_j0.mpr ha) t0_not_mem_j1
        · obtain ⟨a, ha⟩ := h₀ X (f₀.rel_dom hf₁)
          exact absurd ((hWX₁.symm.trans hWZ₂) ▸ t0_mem_j0.mpr ha) t0_not_mem_j2
      · rcases hd₂ with rfl | ⟨X', Y'₂, hWX₂, rfl, hf₂⟩ | ⟨Y', Y'₂, hWY₂, rfl, hf₂⟩
          | ⟨Z', Y'₂, hWZ₂, rfl, hf₂⟩
        · rw [Set.inter_eq_left.mpr (j1_subset_master3 (f₁.rel_cod hf₁))]
          exact Or.inr (Or.inr (Or.inl ⟨Y, Y'₁, hWY₁, rfl, hf₁⟩))
        · obtain ⟨b, hb⟩ := h₁ Y (f₁.rel_dom hf₁)
          exact absurd ((hWY₁.symm.trans hWX₂) ▸ t1_mem_j1.mpr hb) t1_not_mem_j0
        · obtain rfl : Y = Y' := j1_injective (hWY₁.symm.trans hWY₂)
          rw [j1_inter_j1]
          exact Or.inr (Or.inr (Or.inl ⟨Y, Y'₁ ∩ Y'₂, hWY₁, rfl, f₁.inter_right hf₁ hf₂⟩))
        · obtain ⟨b, hb⟩ := h₁ Y (f₁.rel_dom hf₁)
          exact absurd ((hWY₁.symm.trans hWZ₂) ▸ t1_mem_j1.mpr hb) t1_not_mem_j2
      · rcases hd₂ with rfl | ⟨X', Y'₂, hWX₂, rfl, hf₂⟩ | ⟨Y', Y'₂, hWY₂, rfl, hf₂⟩
          | ⟨Z', Y'₂, hWZ₂, rfl, hf₂⟩
        · rw [Set.inter_eq_left.mpr (j2_subset_master3 (f₂.rel_cod hf₁))]
          exact Or.inr (Or.inr (Or.inr ⟨Z, Y'₁, hWZ₁, rfl, hf₁⟩))
        · obtain ⟨c, hc⟩ := h₂ Z (f₂.rel_dom hf₁)
          exact absurd ((hWZ₁.symm.trans hWX₂) ▸ t2_mem_j2.mpr hc) t2_not_mem_j0
        · obtain ⟨c, hc⟩ := h₂ Z (f₂.rel_dom hf₁)
          exact absurd ((hWZ₁.symm.trans hWY₂) ▸ t2_mem_j2.mpr hc) t2_not_mem_j1
        · obtain rfl : Z = Z' := j2_injective (hWZ₁.symm.trans hWZ₂)
          rw [j2_inter_j2]
          exact Or.inr (Or.inr (Or.inr ⟨Z, Y'₁ ∩ Y'₂, hWZ₁, rfl, f₂.inter_right hf₁ hf₂⟩))
    exact ⟨hW, hmem _ key, key⟩
  mono := by
    rintro W W₂ W' W'₂ ⟨hW, hW', hd⟩ hW₂W hW'W'₂ hW₂mem hW'₂mem
    refine ⟨hW₂mem, hW'₂mem, ?_⟩
    rcases hd with rfl | ⟨X, Y', rfl, rfl, hf⟩ | ⟨Y, Y', rfl, rfl, hf⟩ | ⟨Z, Y', rfl, rfl, hf⟩
    · exact Or.inl (eq_master3_of_subset hW'W'₂ ((sum3 V₀' V₁' V₂' h₀' h₁' h₂').sub_master hW'₂mem))
    · obtain ⟨X₂, hX₂, rfl⟩ := mem_subset_j0_inv hW₂mem hW₂W
      have hX₂X : X₂ ⊆ X := j0_subset_j0.mp hW₂W
      rcases hW'₂mem with rfl | ⟨Y'₂, hY'₂, rfl⟩ | ⟨Y'₂, hY'₂, rfl⟩ | ⟨Y'₂, hY'₂, rfl⟩
      · exact Or.inl rfl
      · exact Or.inr (Or.inl ⟨X₂, Y'₂, rfl, rfl,
          f₀.mono hf hX₂X (j0_subset_j0.mp hW'W'₂) hX₂ hY'₂⟩)
      · obtain ⟨a, ha⟩ := h₀' Y' (f₀.rel_cod hf)
        exact absurd (hW'W'₂ (t0_mem_j0.mpr ha)) t0_not_mem_j1
      · obtain ⟨a, ha⟩ := h₀' Y' (f₀.rel_cod hf)
        exact absurd (hW'W'₂ (t0_mem_j0.mpr ha)) t0_not_mem_j2
    · obtain ⟨Y₂, hY₂, rfl⟩ := mem_subset_j1_inv hW₂mem hW₂W
      have hY₂Y : Y₂ ⊆ Y := j1_subset_j1.mp hW₂W
      rcases hW'₂mem with rfl | ⟨Y'₂, hY'₂, rfl⟩ | ⟨Y'₂, hY'₂, rfl⟩ | ⟨Y'₂, hY'₂, rfl⟩
      · exact Or.inl rfl
      · obtain ⟨b, hb⟩ := h₁' Y' (f₁.rel_cod hf)
        exact absurd (hW'W'₂ (t1_mem_j1.mpr hb)) t1_not_mem_j0
      · exact Or.inr (Or.inr (Or.inl ⟨Y₂, Y'₂, rfl, rfl,
          f₁.mono hf hY₂Y (j1_subset_j1.mp hW'W'₂) hY₂ hY'₂⟩))
      · obtain ⟨b, hb⟩ := h₁' Y' (f₁.rel_cod hf)
        exact absurd (hW'W'₂ (t1_mem_j1.mpr hb)) t1_not_mem_j2
    · obtain ⟨Z₂, hZ₂, rfl⟩ := mem_subset_j2_inv hW₂mem hW₂W
      have hZ₂Z : Z₂ ⊆ Z := j2_subset_j2.mp hW₂W
      rcases hW'₂mem with rfl | ⟨Y'₂, hY'₂, rfl⟩ | ⟨Y'₂, hY'₂, rfl⟩ | ⟨Y'₂, hY'₂, rfl⟩
      · exact Or.inl rfl
      · obtain ⟨c, hc⟩ := h₂' Y' (f₂.rel_cod hf)
        exact absurd (hW'W'₂ (t2_mem_j2.mpr hc)) t2_not_mem_j0
      · obtain ⟨c, hc⟩ := h₂' Y' (f₂.rel_cod hf)
        exact absurd (hW'W'₂ (t2_mem_j2.mpr hc)) t2_not_mem_j1
      · exact Or.inr (Or.inr (Or.inr ⟨Z₂, Y'₂, rfl, rfl,
          f₂.mono hf hZ₂Z (j2_subset_j2.mp hW'W'₂) hZ₂ hY'₂⟩))

/-- The three-way sum map is always strict: `(f₀+f₁+f₂)(⊥) = ⊥`. (The master only relates to the
master, since `master3` is not any tagged copy.) -/
theorem isStrict_sumMap3 (f₀ : ApproximableMap V₀ V₀') (f₁ : ApproximableMap V₁ V₁')
    (f₂ : ApproximableMap V₂ V₂') :
    IsStrict (sumMap3 (h₀ := h₀) (h₁ := h₁) (h₂ := h₂) (h₀' := h₀') (h₁' := h₁') (h₂' := h₂')
      f₀ f₁ f₂) := by
  rintro Y ⟨-, -, hd⟩
  have h0 : (none : Option (α ⊕ β ⊕ γ)) ∈ (sum3 V₀ V₁ V₂ h₀ h₁ h₂).master := none_mem_master3
  rcases hd with rfl | ⟨X, Y', hWX, -, -⟩ | ⟨X, Y', hWX, -, -⟩ | ⟨X, Y', hWX, -, -⟩
  · rfl
  · exact absurd (hWX ▸ h0) none_not_mem_j0
  · exact absurd (hWX ▸ h0) none_not_mem_j1
  · exact absurd (hWX ▸ h0) none_not_mem_j2

/-- **Functoriality (identities): `I + I + I = I`.** -/
theorem sumMap3_id :
    sumMap3 (h₀ := h₀) (h₁ := h₁) (h₂ := h₂) (h₀' := h₀) (h₁' := h₁) (h₂' := h₂)
      (idMap V₀) (idMap V₁) (idMap V₂) = idMap (sum3 V₀ V₁ V₂ h₀ h₁ h₂) := by
  apply ApproximableMap.ext
  intro W W'
  constructor
  · rintro ⟨hW, hW', hd⟩
    refine ⟨hW, hW', ?_⟩
    rcases hd with rfl | ⟨X, Y', rfl, rfl, _, _, hXY⟩ | ⟨Y, Y', rfl, rfl, _, _, hXY⟩
      | ⟨Z, Y', rfl, rfl, _, _, hXY⟩
    · exact (sum3 V₀ V₁ V₂ h₀ h₁ h₂).sub_master hW
    · exact j0_subset_j0.mpr hXY
    · exact j1_subset_j1.mpr hXY
    · exact j2_subset_j2.mpr hXY
  · rintro ⟨hW, hW', hsub⟩
    refine ⟨hW, hW', ?_⟩
    rcases hW with rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩ | ⟨Z, hZ, rfl⟩
    · left; exact eq_master3_of_subset hsub ((sum3 V₀ V₁ V₂ h₀ h₁ h₂).sub_master hW')
    · rcases hW' with rfl | ⟨X', hX', rfl⟩ | ⟨Y', hY', rfl⟩ | ⟨Z', hZ', rfl⟩
      · exact Or.inl rfl
      · exact Or.inr (Or.inl ⟨X, X', rfl, rfl, hX, hX', j0_subset_j0.mp hsub⟩)
      · obtain ⟨a, ha⟩ := h₀ X hX; exact absurd (hsub (t0_mem_j0.mpr ha)) t0_not_mem_j1
      · obtain ⟨a, ha⟩ := h₀ X hX; exact absurd (hsub (t0_mem_j0.mpr ha)) t0_not_mem_j2
    · rcases hW' with rfl | ⟨X', hX', rfl⟩ | ⟨Y', hY', rfl⟩ | ⟨Z', hZ', rfl⟩
      · exact Or.inl rfl
      · obtain ⟨b, hb⟩ := h₁ Y hY; exact absurd (hsub (t1_mem_j1.mpr hb)) t1_not_mem_j0
      · exact Or.inr (Or.inr (Or.inl ⟨Y, Y', rfl, rfl, hY, hY', j1_subset_j1.mp hsub⟩))
      · obtain ⟨b, hb⟩ := h₁ Y hY; exact absurd (hsub (t1_mem_j1.mpr hb)) t1_not_mem_j2
    · rcases hW' with rfl | ⟨X', hX', rfl⟩ | ⟨Y', hY', rfl⟩ | ⟨Z', hZ', rfl⟩
      · exact Or.inl rfl
      · obtain ⟨c, hc⟩ := h₂ Z hZ; exact absurd (hsub (t2_mem_j2.mpr hc)) t2_not_mem_j0
      · obtain ⟨c, hc⟩ := h₂ Z hZ; exact absurd (hsub (t2_mem_j2.mpr hc)) t2_not_mem_j1
      · exact Or.inr (Or.inr (Or.inr ⟨Z, Z', rfl, rfl, hZ, hZ', j2_subset_j2.mp hsub⟩))

/-- **Functoriality (composition): `(g₀∘f₀) + (g₁∘f₁) + (g₂∘f₂) = (g₀+g₁+g₂) ∘ (f₀+f₁+f₂)`.** -/
theorem sumMap3_comp {α'' β'' γ'' : Type*} {V₀'' : NeighborhoodSystem α''}
    {V₁'' : NeighborhoodSystem β''} {V₂'' : NeighborhoodSystem γ''}
    {h₀'' : ∀ X, V₀''.mem X → X.Nonempty} {h₁'' : ∀ Y, V₁''.mem Y → Y.Nonempty}
    {h₂'' : ∀ Z, V₂''.mem Z → Z.Nonempty}
    (g₀ : ApproximableMap V₀' V₀'') (g₁ : ApproximableMap V₁' V₁'') (g₂ : ApproximableMap V₂' V₂'')
    (f₀ : ApproximableMap V₀ V₀') (f₁ : ApproximableMap V₁ V₁') (f₂ : ApproximableMap V₂ V₂') :
    sumMap3 (h₀ := h₀) (h₁ := h₁) (h₂ := h₂) (h₀' := h₀'') (h₁' := h₁'') (h₂' := h₂'')
        (g₀.comp f₀) (g₁.comp f₁) (g₂.comp f₂)
      = (sumMap3 (h₀ := h₀') (h₁ := h₁') (h₂ := h₂') (h₀' := h₀'') (h₁' := h₁'') (h₂' := h₂'')
          g₀ g₁ g₂).comp
        (sumMap3 (h₀ := h₀) (h₁ := h₁) (h₂ := h₂) (h₀' := h₀') (h₁' := h₁') (h₂' := h₂')
          f₀ f₁ f₂) := by
  apply ApproximableMap.ext
  intro W W''
  constructor
  · rintro ⟨hW, hW'', hd⟩
    rcases hd with rfl | ⟨X, Z'', rfl, rfl, Y', hf, hg⟩ | ⟨Y, Z'', rfl, rfl, Y', hf, hg⟩
      | ⟨Z, Z'', rfl, rfl, Y', hf, hg⟩
    · exact ⟨master3 V₀' V₁' V₂', ⟨hW, (sum3 V₀' V₁' V₂' h₀' h₁' h₂').master_mem, Or.inl rfl⟩,
        (sum3 V₀' V₁' V₂' h₀' h₁' h₂').master_mem, hW'', Or.inl rfl⟩
    · exact ⟨j0 Y', ⟨hW, Or.inr (Or.inl ⟨Y', f₀.rel_cod hf, rfl⟩),
        Or.inr (Or.inl ⟨X, Y', rfl, rfl, hf⟩)⟩,
        Or.inr (Or.inl ⟨Y', f₀.rel_cod hf, rfl⟩), hW'', Or.inr (Or.inl ⟨Y', Z'', rfl, rfl, hg⟩)⟩
    · exact ⟨j1 Y', ⟨hW, Or.inr (Or.inr (Or.inl ⟨Y', f₁.rel_cod hf, rfl⟩)),
        Or.inr (Or.inr (Or.inl ⟨Y, Y', rfl, rfl, hf⟩))⟩,
        Or.inr (Or.inr (Or.inl ⟨Y', f₁.rel_cod hf, rfl⟩)), hW'',
        Or.inr (Or.inr (Or.inl ⟨Y', Z'', rfl, rfl, hg⟩))⟩
    · exact ⟨j2 Y', ⟨hW, Or.inr (Or.inr (Or.inr ⟨Y', f₂.rel_cod hf, rfl⟩)),
        Or.inr (Or.inr (Or.inr ⟨Z, Y', rfl, rfl, hf⟩))⟩,
        Or.inr (Or.inr (Or.inr ⟨Y', f₂.rel_cod hf, rfl⟩)), hW'',
        Or.inr (Or.inr (Or.inr ⟨Y', Z'', rfl, rfl, hg⟩))⟩
  · rintro ⟨W', ⟨hW, hW', hdf⟩, _, hW'', hdg⟩
    refine ⟨hW, hW'', ?_⟩
    rcases hdg with rfl | ⟨X', Z'', hW'X', rfl, hg⟩ | ⟨Y', Z'', hW'Y', rfl, hg⟩
      | ⟨Z', Z'', hW'Z', rfl, hg⟩
    · exact Or.inl rfl
    · rcases hdf with rfl | ⟨X, Y'₀, rfl, hW'eq, hf⟩ | ⟨Y, Y'₀, rfl, hW'eq, hf⟩
        | ⟨Z, Y'₀, rfl, hW'eq, hf⟩
      · exact absurd ((hW'X'.symm) ▸ none_mem_master3) none_not_mem_j0
      · obtain rfl : Y'₀ = X' := j0_injective (hW'eq.symm.trans hW'X')
        exact Or.inr (Or.inl ⟨X, Z'', rfl, rfl, ⟨Y'₀, hf, hg⟩⟩)
      · obtain ⟨b, hb⟩ := h₁' Y'₀ (f₁.rel_cod hf)
        exact absurd ((hW'eq.symm.trans hW'X') ▸ t1_mem_j1.mpr hb) t1_not_mem_j0
      · obtain ⟨c, hc⟩ := h₂' Y'₀ (f₂.rel_cod hf)
        exact absurd ((hW'eq.symm.trans hW'X') ▸ t2_mem_j2.mpr hc) t2_not_mem_j0
    · rcases hdf with rfl | ⟨X, Y'₀, rfl, hW'eq, hf⟩ | ⟨Y, Y'₀, rfl, hW'eq, hf⟩
        | ⟨Z, Y'₀, rfl, hW'eq, hf⟩
      · exact absurd ((hW'Y'.symm) ▸ none_mem_master3) none_not_mem_j1
      · obtain ⟨a, ha⟩ := h₀' Y'₀ (f₀.rel_cod hf)
        exact absurd ((hW'eq.symm.trans hW'Y') ▸ t0_mem_j0.mpr ha) t0_not_mem_j1
      · obtain rfl : Y'₀ = Y' := j1_injective (hW'eq.symm.trans hW'Y')
        exact Or.inr (Or.inr (Or.inl ⟨Y, Z'', rfl, rfl, ⟨Y'₀, hf, hg⟩⟩))
      · obtain ⟨c, hc⟩ := h₂' Y'₀ (f₂.rel_cod hf)
        exact absurd ((hW'eq.symm.trans hW'Y') ▸ t2_mem_j2.mpr hc) t2_not_mem_j1
    · rcases hdf with rfl | ⟨X, Y'₀, rfl, hW'eq, hf⟩ | ⟨Y, Y'₀, rfl, hW'eq, hf⟩
        | ⟨Z, Y'₀, rfl, hW'eq, hf⟩
      · exact absurd ((hW'Z'.symm) ▸ none_mem_master3) none_not_mem_j2
      · obtain ⟨a, ha⟩ := h₀' Y'₀ (f₀.rel_cod hf)
        exact absurd ((hW'eq.symm.trans hW'Z') ▸ t0_mem_j0.mpr ha) t0_not_mem_j2
      · obtain ⟨b, hb⟩ := h₁' Y'₀ (f₁.rel_cod hf)
        exact absurd ((hW'eq.symm.trans hW'Z') ▸ t1_mem_j1.mpr hb) t1_not_mem_j2
      · obtain rfl : Y'₀ = Z' := j2_injective (hW'eq.symm.trans hW'Z')
        exact Or.inr (Or.inr (Or.inr ⟨Z, Z'', rfl, rfl, ⟨Y'₀, hf, hg⟩⟩))

end SumMap3

/-! ## The functor `T(X) = 𝟙 + X + X` -/

open Example62C in
/-- The morphism action of `T`: `T(f) = I_𝟙 + f + f` (identity on the terminator, `f` on each
successor copy). Always strict (`isStrict_sumMap3`). -/
def tcMapHom {D E : StrictDomainObj.{w}} (f : Category.Hom D E) :
    Category.Hom (tcObj D) (tcObj E) :=
  ⟨sumMap3 (h₀ := Example62C.unitSys_nonempty) (h₁ := D.nonempty) (h₂ := D.nonempty)
      (h₀' := Example62C.unitSys_nonempty) (h₁' := E.nonempty) (h₂' := E.nonempty)
      (idMap unitSys) f.1 f.1, isStrict_sumMap3 _ _ _⟩

open Example62C in
/-- **Exercise 6.17 — the functor `T(X) = 𝟙 + X + X`** on the category of `∅`-free domains and strict
maps. On objects, `T(D) = 𝟙 + D + D` (Example 6.2's three-way sum); on maps, `T(f) = I_𝟙 + f + f`. -/
def Tc : Endofunctor StrictDomainObj.{w} where
  obj := tcObj
  map := tcMapHom
  map_id D := Subtype.ext (by
    show sumMap3 (idMap unitSys) (idMap D.sys) (idMap D.sys) = idMap (tcObj D).sys
    exact sumMap3_id)
  map_comp {D E F} g f := Subtype.ext (by
    show sumMap3 (idMap unitSys) (g.1.comp f.1) (g.1.comp f.1)
      = (sumMap3 (idMap unitSys) g.1 g.1).comp (sumMap3 (idMap unitSys) f.1 f.1)
    have h := sumMap3_comp (h₀ := Example62C.unitSys_nonempty) (h₁ := D.nonempty) (h₂ := D.nonempty)
      (h₀' := Example62C.unitSys_nonempty) (h₁' := E.nonempty) (h₂' := E.nonempty)
      (h₀'' := Example62C.unitSys_nonempty) (h₁'' := F.nonempty) (h₂'' := F.nonempty)
      (idMap unitSys) g.1 g.1 (idMap unitSys) f.1 f.1
    rw [idMap_comp] at h
    exact h)

@[simp] theorem Tc_obj (D : StrictDomainObj.{w}) : Tc.obj D = tcObj D := rfl

@[simp] theorem Tc_map_val {D E : StrictDomainObj.{w}} (f : Category.Hom D E) :
    (Tc.map f).1 = sumMap3 (h₀ := Example62C.unitSys_nonempty) (h₁ := D.nonempty) (h₂ := D.nonempty)
      (h₀' := Example62C.unitSys_nonempty) (h₁' := E.nonempty) (h₂' := E.nonempty)
      (idMap unitSys) f.1 f.1 := rfl

/-! ## `C` as a `T`-algebra -/

/-- The map of an order-isomorphism is strict (an iso of domains preserves `⊥`). -/
theorem isStrict_ofIso {α β : Type*} {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β}
    (e : V₀.Element ≃o V₁.Element) : IsStrict (ofIso e) := by
  rw [isStrict_iff_apply_bot, toElementMap_ofIso]
  exact e.map_bot

open Example44 Example62C ExampleB in
/-- `C` (Example 4.4: finite-or-infinite binary sequences) as an object of the `∅`-free category. -/
def Cobj : StrictDomainObj.{0} := ⟨Str, C, C_nonempty⟩

open Example44 Example62C in
/-- **The `T`-algebra structure on `C`.** `(tcObj Cobj).sys = 𝟙 + C + C` (definitionally Example 6.2's
`CC`), and the structure map `i : 𝟙 + C + C → C` is the inverse of the domain-equation isomorphism
`ccEquiv` (Example 6.2), realised as an approximable map by `ofIso`; it is strict by `isStrict_ofIso`.
Concretely `i` sends the terminator to `Λ̂` and each `b`-copy of `x` to `b·x`. -/
def cStr : Category.Hom (Tc.obj Cobj) Cobj :=
  ⟨ofIso (by exact ccEquiv.symm), isStrict_ofIso _⟩

open Example44 Example62C in
/-- **`C` is a `T`-algebra**, `(C, i)` with `T(X) = 𝟙 + X + X`. -/
def Calg : TAlgebra Tc := ⟨Cobj, cStr⟩

end Domain.Neighborhood
