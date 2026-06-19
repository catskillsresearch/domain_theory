import Domain.ContinuousLattice.Constructions
import Domain.ContinuousLattice.FunctionSpaces
import Mathlib.Order.GaloisConnection.Basic

/-!
# Inverse limits of continuous lattices (Scott 1972, §4)

We formalize Scott's **Proposition 4.1**: the inverse limit `D_∞` of an ω-system of continuous
lattices `⟨Dₙ, jₙ⟩` with each `jₙ : D_{n+1} → Dₙ` a projection is again a continuous lattice.

Scott proves this through injectivity (`D_∞` is an injective `T₀`-space, hence — Theorem 2.12 — a
continuous lattice), using the maximal-extension Proposition 3.8 and the compatibility Lemma 3.9.
The *retraction* of `∏ Dₙ` onto `D_∞` that Scott's argument constructs (extend the identity of
`D_∞` along its inclusion) is realized here **order-theoretically and without topology**:

* each projection `jₙ = (P n).retr` is the upper adjoint of its embedding `iₙ = (P n).incl`
  (`projection_galoisConnection`), hence preserves arbitrary infima;
* therefore the compatibility predicate is closed under pointwise `sInf`, making `D_∞` a complete
  lattice (`completeLatticeOfInf`);
* the inclusion `D_∞ ↪ ∏ Dₙ` preserves infima, so it has a **left adjoint** `r : ∏ Dₙ → D_∞`
  (`invLimRetr`); a left adjoint preserves all suprema, in particular directed ones, so `r` is
  Scott-continuous, and `r ∘ incl = id`.

Thus `D_∞` is a (Scott-continuous) retract of the continuous lattice `∏ Dₙ` (Prop 2.9a), so by
Prop 2.10a it is a continuous lattice. This is exactly the retraction Scott builds via injectivity,
obtained here as the adjoint of the inclusion.
-/

namespace Domain.ContinuousLattice

open Set

universe u

section InverseLimit

variable (D : ℕ → Type u) [∀ n, CompleteLattice (D n)]
variable (P : ∀ n, IsContinuousLatticeProjection (D n) (D (n + 1)))

/-- The embedding–projection pair of a projection is a Galois connection `iₙ ⊣ jₙ`: from
`jₙ ∘ iₙ = id` and `iₙ ∘ jₙ ⊑ id` we get `iₙ x ⊑ y ↔ x ⊑ jₙ y`. In particular `jₙ` (the upper
adjoint) preserves arbitrary infima. -/
theorem projection_galoisConnection (n : ℕ) :
    GaloisConnection ((P n).incl : D n → D (n + 1)) ((P n).retr : D (n + 1) → D n) := by
  intro x y
  constructor
  · intro h
    have h' := (P n).retr.monotone h
    rwa [(P n).retr_incl] at h'
  · intro h
    exact le_trans ((P n).incl.monotone h) ((P n).incl_retr_le y)

/-- Compatibility of a sequence: `jₙ(x_{n+1}) = xₙ` for all `n`. -/
def Compatible (x : ∀ n, D n) : Prop := ∀ n, (P n).retr (x (n + 1)) = x n

/-- **Scott 1972, §4.** The inverse limit `D_∞` as the subspace of compatible sequences. -/
abbrev InverseLimit : Type u := {x : ∀ n, D n // Compatible D P x}

/-- `jₙ` preserves arbitrary infima (it is the upper adjoint of `iₙ`). -/
theorem retr_sInf (n : ℕ) (A : Set (D (n + 1))) :
    (P n).retr (sInf A) = sInf ((P n).retr '' A) := by
  rw [(projection_galoisConnection D P n).u_sInf, sInf_image]

/-- The pointwise infimum of compatible sequences is compatible. -/
theorem compatible_sInf (S : Set (InverseLimit D P)) :
    Compatible D P (sInf (Subtype.val '' S)) := by
  intro n
  rw [sInf_apply_eq_sInf_image, sInf_apply_eq_sInf_image, retr_sInf]
  congr 1
  rw [Set.image_image]
  exact Set.image_congr (by rintro _ ⟨x, _, rfl⟩; exact x.2 n)

noncomputable instance : InfSet (InverseLimit D P) :=
  ⟨fun S => ⟨sInf (Subtype.val '' S), compatible_sInf D P S⟩⟩

theorem coe_sInf (S : Set (InverseLimit D P)) :
    ((sInf S : InverseLimit D P) : ∀ n, D n) = sInf (Subtype.val '' S) := rfl

theorem isGLB_sInf' (S : Set (InverseLimit D P)) : IsGLB S (sInf S) := by
  constructor
  · intro x hx
    refine Subtype.coe_le_coe.mp ?_
    rw [coe_sInf]
    exact sInf_le (Set.mem_image_of_mem _ hx)
  · intro b hb
    refine Subtype.coe_le_coe.mp ?_
    rw [coe_sInf]
    refine le_sInf ?_
    rintro _ ⟨x, hx, rfl⟩
    exact Subtype.coe_le_coe.mpr (hb hx)

noncomputable instance instCompleteLattice : CompleteLattice (InverseLimit D P) :=
  completeLatticeOfInf (InverseLimit D P) (isGLB_sInf' D P)

/-- For a directed, nonempty family, the inverse-limit supremum is computed pointwise (each `jₙ`
is Scott-continuous, so the pointwise sup of compatible sequences is compatible and is the least
upper bound in `D_∞`). -/
theorem coe_sSup_of_directed (S : Set (InverseLimit D P)) (hSne : S.Nonempty)
    (hSdir : DirectedOn (· ≤ ·) S) :
    ((sSup S : InverseLimit D P) : ∀ n, D n) = sSup (Subtype.val '' S) := by
  have hcompat : Compatible D P (sSup (Subtype.val '' S)) := by
    intro n
    rw [sSup_apply_eq_sSup_image, sSup_apply_eq_sSup_image]
    set A : Set (D (n + 1)) := (fun f : ∀ m, D m => f (n + 1)) '' (Subtype.val '' S) with hA
    have hAne : A.Nonempty := (hSne.image _).image _
    have hAdir : DirectedOn (· ≤ ·) A := by
      rintro _ ⟨_, ⟨x, hxS, rfl⟩, rfl⟩ _ ⟨_, ⟨y, hyS, rfl⟩, rfl⟩
      obtain ⟨z, hzS, hxz, hyz⟩ := hSdir x hxS y hyS
      exact ⟨z.1 (n + 1), ⟨z.1, ⟨z, hzS, rfl⟩, rfl⟩, hxz (n + 1), hyz (n + 1)⟩
    rw [(P n).retr.preservesDirectedSup_coe A hAne hAdir]
    congr 1
    rw [hA, Set.image_image]
    exact Set.image_congr (by rintro _ ⟨x, _, rfl⟩; exact x.2 n)
  set p : InverseLimit D P := ⟨sSup (Subtype.val '' S), hcompat⟩ with hp
  have hlub : IsLUB S p := by
    constructor
    · intro x hx
      refine Subtype.coe_le_coe.mp ?_
      exact le_sSup (Set.mem_image_of_mem _ hx)
    · intro b hb
      refine Subtype.coe_le_coe.mp ?_
      refine sSup_le ?_
      rintro _ ⟨x, hx, rfl⟩
      exact Subtype.coe_le_coe.mpr (hb hx)
  rw [(isLUB_sSup S).unique hlub]

/-- The inclusion `D_∞ ↪ ∏ Dₙ` preserves directed suprema. -/
theorem incl_preservesDirectedSup :
    PreservesDirectedSup (Subtype.val : InverseLimit D P → ∀ n, D n) := by
  intro S hSne hSdir
  exact coe_sSup_of_directed D P S hSne hSdir

/-- Scott's retraction `r : ∏ Dₙ → D_∞`, realized as the **left adjoint** of the inclusion:
`r y = ⊓ { x ∈ D_∞ : y ⊑ x }`, the least compatible sequence above `y`. -/
noncomputable def invLimRetr (y : ∀ n, D n) : InverseLimit D P :=
  sInf {x : InverseLimit D P | y ≤ x.1}

theorem le_coe_invLimRetr (y : ∀ n, D n) : y ≤ (invLimRetr D P y).1 := by
  rw [invLimRetr, coe_sInf]
  refine le_sInf ?_
  rintro _ ⟨x, hx, rfl⟩
  exact hx

/-- `r ⊣ incl`: the retraction is left adjoint to the inclusion. -/
theorem invLimRetr_galoisConnection :
    GaloisConnection (invLimRetr D P) (Subtype.val : InverseLimit D P → ∀ n, D n) := by
  intro y x
  constructor
  · intro h
    exact le_trans (le_coe_invLimRetr D P y) (Subtype.coe_le_coe.mpr h)
  · intro h
    exact sInf_le (show x ∈ {x' : InverseLimit D P | y ≤ x'.1} from h)

/-- The retraction preserves directed suprema (a left adjoint preserves all suprema). -/
theorem invLimRetr_preservesDirectedSup :
    PreservesDirectedSup (invLimRetr D P) := by
  intro S _ _
  rw [(invLimRetr_galoisConnection D P).l_sSup, sSup_image]

/-- `r ∘ incl = id`: the retraction fixes `D_∞`. -/
theorem invLimRetr_incl (x : InverseLimit D P) : invLimRetr D P x.1 = x := by
  refine le_antisymm ?_ ?_
  · exact sInf_le (show x ∈ {x' : InverseLimit D P | (x.1 : ∀ n, D n) ≤ x'.1} from le_refl x.1)
  · refine le_sInf ?_
    intro x' hx'
    exact Subtype.coe_le_coe.mp hx'

/-- `D_∞` is a Scott-continuous retract of the product `∏ Dₙ`. -/
noncomputable def inverseLimitRetraction :
    IsContinuousLatticeRetraction (InverseLimit D P) (∀ n, D n) where
  incl := ⟨Subtype.val, continuous_of_preservesDirectedSup (incl_preservesDirectedSup D P)⟩
  retr := ⟨invLimRetr D P, continuous_of_preservesDirectedSup (invLimRetr_preservesDirectedSup D P)⟩
  retr_incl := invLimRetr_incl D P

/-- **Scott 1972, Proposition 4.1.** The inverse limit `D_∞` of an ω-system of continuous lattices
with projection bonding maps is itself a continuous lattice. The product `∏ Dₙ` is a continuous
lattice (Prop 2.9a) and `D_∞` is a retract of it (`inverseLimitRetraction`), so Prop 2.10a applies. -/
theorem proposition_4_1 (hD : ∀ n, IsContinuousLattice (D n)) :
    IsContinuousLattice (InverseLimit D P) :=
  proposition_2_10_a (inverseLimitRetraction D P) (proposition_2_9_a D hD)

end InverseLimit

end Domain.ContinuousLattice
