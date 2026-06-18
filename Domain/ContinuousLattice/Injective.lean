import Mathlib.Topology.ContinuousMap.T0Sierpinski
import Mathlib.Topology.ContinuousMap.Basic

/-!
# Injective spaces (Scott 1972, §1)

This file begins the formalization of Dana Scott's *Continuous Lattices* (Dalhousie 1971;
LNM 274, 1972), the **1972 / topological** presentation of domain theory, the first of the
three historical versions covered in this project.

Scott's §1 introduces *injective* `T₀`-spaces — those with the extension property for
continuous maps along subspace embeddings — and shows the two-point Sierpiński space is
injective, that injectivity is preserved by products and by retracts, and (the embedding
theorem) that every `T₀`-space embeds in a power of the Sierpiński space.

Because this is the classical/topological version of the theory, we use mathlib's topology
freely (and classical reasoning where convenient); the *constructive* discipline is
reserved for the 1982 information-systems core.

## Main definitions / results

* `IsInjectiveSpace D` — Scott's Definition 1.1.
* `isInjectiveSpace_sierpinski` — Scott's Proposition 1.2 (the Sierpiński space is injective).
* `IsInjectiveSpace.pi` — Scott's Proposition 1.3 (products of injective spaces are injective).
* `IsInjectiveSpace.of_retract` — Scott's Proposition 1.4 (retracts of injective spaces are
  injective).
-/

open Topology

universe u v w

/-- **Scott 1972, Definition 1.1.** A topological space `D` is *injective* when, for every
topological embedding `e : X → Y` (Scott's "`X ⊆ Y` as a subspace") and every continuous
`f : X → D`, there is a continuous `g : Y → D` extending `f` along `e`, i.e. `g ∘ e = f`.

Following Scott we leave the `T₀` hypothesis out of the definition itself; it is not needed
for the extension property. -/
def IsInjectiveSpace (D : Type v) [TopologicalSpace D] : Prop :=
  ∀ {X Y : Type u} [TopologicalSpace X] [TopologicalSpace Y] (e : X → Y),
    IsEmbedding e → ∀ f : C(X, D), ∃ g : C(Y, D), ∀ x, g (e x) = f x

/-- **Scott 1972, Proposition 1.2.** The Sierpiński space — here `Prop` with the Sierpiński
topology — is injective.

The proof is Scott's: continuous maps `X → Prop` correspond to open subsets of `X`; an open
subset of a subspace `X ⊆ Y` is the restriction of an open subset of `Y`; restoring that
open set of `Y` extends the map. -/
theorem isInjectiveSpace_sierpinski : IsInjectiveSpace.{u} Prop := by
  intro X Y _ _ e he f
  -- `f` is continuous into the Sierpiński space, so `{x | f x}` is open in `X`.
  have hfopen : IsOpen {x | f x} := continuous_Prop.1 f.continuous
  -- For an embedding, that open set is the preimage of an open set `V ⊆ Y`.
  rw [he.isInducing.isOpen_iff] at hfopen
  obtain ⟨V, hVopen, hVeq⟩ := hfopen
  -- Extend by the open set `V`: `g y := y ∈ V`.
  refine ⟨⟨fun y => y ∈ V, continuous_Prop.2 hVopen⟩, fun x => ?_⟩
  have : (e x ∈ V) = (x ∈ {x | f x}) := by rw [← hVeq]; rfl
  simpa using this

/-- **Scott 1972, Proposition 1.3.** A Cartesian product of injective spaces, in the product
topology, is injective. -/
theorem IsInjectiveSpace.pi {ι : Type w} (D : ι → Type v) [∀ i, TopologicalSpace (D i)]
    (h : ∀ i, IsInjectiveSpace.{u} (D i)) : IsInjectiveSpace.{u} (∀ i, D i) := by
  intro X Y _ _ e he f
  -- Extend each component separately, then reassemble with `continuous_pi`.
  choose g hg using fun i =>
    h i e he ⟨fun x => f x i, (continuous_apply i).comp f.continuous⟩
  refine ⟨⟨fun y i => g i y, continuous_pi fun i => (g i).continuous⟩, fun x => ?_⟩
  funext i
  exact hg i x

/-- **Scott 1972, Proposition 1.4.** A retract of an injective space is injective. Here
`r : D → D'` is a retraction with section `s : D' → D` (both continuous, `r ∘ s = id`). -/
theorem IsInjectiveSpace.of_retract {D : Type v} {D' : Type v}
    [TopologicalSpace D] [TopologicalSpace D'] (hD : IsInjectiveSpace.{u} D)
    (s : C(D', D)) (r : C(D, D')) (hrs : ∀ d, r (s d) = d) :
    IsInjectiveSpace.{u} D' := by
  intro X Y _ _ e he f
  -- Push `f` into `D` via the section, extend there, then pull back via the retraction.
  obtain ⟨g, hg⟩ := hD e he (s.comp f)
  refine ⟨r.comp g, fun x => ?_⟩
  show r (g (e x)) = f x
  rw [hg x]
  show r (s (f x)) = f x
  exact hrs (f x)

/-- **Scott 1972, Proposition 1.5 (embedding theorem), via mathlib.** Every `T₀`-space embeds
into a power of the Sierpiński space (one factor per open set). This is
`TopologicalSpace.productOfMemOpens_isEmbedding`; we record it here under Scott's heading. -/
theorem t0_isEmbedding_into_sierpinski_power (X : Type u) [TopologicalSpace X] [T0Space X] :
    IsEmbedding (TopologicalSpace.productOfMemOpens X) :=
  TopologicalSpace.productOfMemOpens_isEmbedding X
