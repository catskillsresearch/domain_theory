import Domain.ContinuousLattice.MilnerCorrection
import Domain.ContinuousLattice.ScottMaps
import Domain.ContinuousLattice.Injective
import Mathlib.Order.Preorder.Finite

/-!
# Continuous lattice constructions (Scott 1972, §2.8–2.12)

The Milner correction (March 1972, pp. 135–136) is in `MilnerCorrection.lean`. Full proofs of
2.8–2.12 under `CoarserThanScottTopology` are the remaining 1972 items; the Sierpiński
injectivity base case (1.2) is already complete.

This file additionally proves Scott's first two example/closure results, the order-theoretic
content of Propositions 2.8 (finite lattices are continuous) and 2.9 (products of continuous
lattices are continuous). The accompanying topological claims of 2.9–2.10 ("the induced
topology agrees with the product / subspace topology") are the parts that require the Milner
correction and remain open.
-/

namespace Domain.ContinuousLattice

variable {D : Type*} [CompleteLattice D]

/-- A non-empty **finite** directed set attains its supremum: `⊔S ∈ S`. A maximal element of
`S` (which exists by finiteness) is, by directedness, the greatest element, hence the
supremum. This is the order-theoretic heart of "finite ⟹ continuous" (Scott 1972, 2.8). -/
theorem directedOn_finite_sSup_mem {S : Set D} (hSfin : S.Finite) (hSne : S.Nonempty)
    (hSdir : DirectedOn (· ≤ ·) S) : sSup S ∈ S := by
  obtain ⟨m, hm⟩ := hSfin.exists_maximal hSne
  have hub : m ∈ upperBounds S := by
    intro s hs
    obtain ⟨c, hcS, hmc, hsc⟩ := hSdir m hm.1 s hs
    exact hsc.trans (hm.2 hcS hmc)
  have hlub : IsLUB S m := ⟨hub, fun b hb => hb hm.1⟩
  rw [hlub.sSup_eq]
  exact hm.1

/-- **Scott 1972, Proposition 2.8.** A finite lattice is a continuous lattice. In a finite
lattice every principal up-set `Set.Ici y` is Scott-open (a non-empty directed set is finite,
so it attains its supremum), hence `y ≪ y`; therefore `y` is the supremum of `{x | x ≪ y}`. -/
theorem proposition_2_8 [Finite D] : IsContinuousLattice D := by
  intro y
  have hopen : ScottOpen (Set.Ici y) := by
    refine ⟨isUpperSet_Ici y, fun S hSne hSdir hmem => ?_⟩
    exact ⟨sSup S, directedOn_finite_sSup_mem (Set.toFinite S) hSne hSdir, hmem⟩
  have hyy : y ≪ y := wayBelow_self_iff_scottOpen_Ici.mpr hopen
  exact ⟨fun x hx => hx.le, fun b hb => hb hyy⟩

/-- **Scott 1972, Proposition 2.9 (order-theoretic content).** The Cartesian product of any
family of continuous lattices is a continuous lattice.

The key step is that if `a ≪ yᵢ` in the factor `Dᵢ`, then the cylinder element `[a]ⁱ`
(equal to `a` in coordinate `i` and `⊥` elsewhere) is way below `y` in the product: the
preimage `{z | zᵢ ∈ U}` of a Scott-open witness `U ⊆ Dᵢ` is Scott-open in the product
(suprema are computed coordinatewise). Any upper bound `b` of `{x | x ≪ y}` therefore
dominates every `[a]ⁱ`, so `a = ([a]ⁱ)ᵢ ≤ bᵢ`; ranging over `a ≪ yᵢ` and using continuity of
`Dᵢ` gives `yᵢ ≤ bᵢ` for all `i`, i.e. `y ≤ b`. -/
theorem proposition_2_9 {ι : Type*} (E : ι → Type*) [∀ i, CompleteLattice (E i)]
    (hE : ∀ i, IsContinuousLattice (E i)) : IsContinuousLattice (∀ i, E i) := by
  classical
  intro y
  refine ⟨fun x hx => hx.le, fun b hb => ?_⟩
  rw [Pi.le_def]
  intro i
  rw [← (hE i).sSup_wayBelow (y i)]
  apply sSup_le
  intro a ha
  set e : (∀ j, E j) := Function.update (⊥ : ∀ j, E j) i a with he
  have hei : e i = a := by rw [he]; exact Function.update_self i a _
  have hcyl : e ≪ y := by
    obtain ⟨U, hU, hyiU, hUsub⟩ := ha
    refine ⟨{z : ∀ j, E j | z i ∈ U}, ?_, hyiU, ?_⟩
    · refine ⟨fun z w hzw hz => hU.1 (hzw i) hz, fun S hSne hSdir hmem => ?_⟩
      rw [Set.mem_setOf_eq, sSup_apply_eq_sSup_image] at hmem
      have hdir' : DirectedOn (· ≤ ·) (Function.eval i '' S) := by
        rintro _ ⟨f, hf, rfl⟩ _ ⟨g, hg, rfl⟩
        obtain ⟨h, hhS, hfh, hgh⟩ := hSdir f hf g hg
        exact ⟨Function.eval i h, ⟨h, hhS, rfl⟩, hfh i, hgh i⟩
      obtain ⟨t, htimg, htU⟩ := hU.2 (hSne.image _) hdir' hmem
      obtain ⟨f, hfS, rfl⟩ := htimg
      exact ⟨f, hfS, htU⟩
    · intro z hz
      rw [Set.mem_Ici, Pi.le_def]
      intro j
      rcases eq_or_ne j i with rfl | hji
      · rw [hei]; exact Set.mem_Ici.1 (hUsub hz)
      · rw [he, Function.update_of_ne hji]; exact bot_le
  have hle : e i ≤ b i := (hb hcyl) i
  rw [hei] at hle
  exact hle

/-- **Scott 1972, Theorem 2.12 (backward, Sierpiński base case).** Once
`IsContinuousLattice Prop` is available, injectivity of `Prop` follows from Proposition 1.2. -/
theorem theorem_2_12_sierpinski_backward (_h : IsContinuousLattice Prop) : IsInjectiveSpace Prop :=
  proposition_1_2

/-- **Scott 1972, Theorem 2.12 (injectivity half, unconditional).** `Prop` is injective
(Sierpiński); the continuous-lattice half awaits `IsContinuousLattice Prop`. -/
theorem theorem_2_12_injective_half : IsInjectiveSpace Prop :=
  proposition_1_2

end Domain.ContinuousLattice
