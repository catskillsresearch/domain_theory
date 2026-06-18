import Domain.ContinuousLattice.MilnerCorrection
import Domain.ContinuousLattice.ScottMaps
import Domain.ContinuousLattice.Injective

/-!
# Continuous lattice constructions (Scott 1972, §2.8–2.12)

The Milner correction (March 1972, pp. 135–136) is in `MilnerCorrection.lean`. Full proofs of
2.8–2.12 under `CoarserThanScottTopology` are the remaining 1972 items; the Sierpiński
injectivity base case (1.2) is already complete.
-/

namespace Domain.ContinuousLattice

/-- **Scott 1972, Theorem 2.12 (backward, Sierpiński base case).** Once
`IsContinuousLattice Prop` is available, injectivity of `Prop` follows from Proposition 1.2. -/
theorem theorem_2_12_sierpinski_backward (_h : IsContinuousLattice Prop) : IsInjectiveSpace Prop :=
  proposition_1_2

/-- **Scott 1972, Theorem 2.12 (injectivity half, unconditional).** `Prop` is injective
(Sierpiński); the continuous-lattice half awaits `IsContinuousLattice Prop`. -/
theorem theorem_2_12_injective_half : IsInjectiveSpace Prop :=
  proposition_1_2

end Domain.ContinuousLattice
