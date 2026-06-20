import Domain.Neighborhood.Approximable
import Domain.Neighborhood.ExampleB

/-!
# Exercise 2.16 (Scott 1981, PRG-19, §2) — the prefixing map `x ↦ σx` is approximable

In Lecture I (Example 1.B) Scott defined, for each finite string `σ ∈ Σ*`, the elementwise operation
`x ↦ σx` on `|B|` (`ExampleB.sigmaElt`). Exercise 2.16 asks whether this mapping is *approximable*.
It is: the witnessing neighbourhood relation is

`X f Y ↔ X, Y ∈ B ∧ σX ⊆ Y`,

i.e. "the prefixed input cone `σX` is at least as sharp as `Y`." We package it as
`sigmaMap σ : ApproximableMap B B` and show its elementwise action is exactly `sigmaElt σ`
(`toElementMap_sigmaMap`).

(The second half of 2.16 — that the parity map `f : B → T` of Example 2.3 is the *unique* approximable
map satisfying `f(1x)=true`, `f(01x)=false`, `f(00x)=f(x)` — is an equational-uniqueness statement
left to a later pass.) Constructive (`#print axioms ⊆ {propext, Quot.sound}`). -/

namespace Domain.Neighborhood.Exercise216

open Domain.Neighborhood NeighborhoodSystem ExampleB

/-- Prepending a prefix is monotone: `X' ⊆ X → σX' ⊆ σX`. -/
theorem prepend_mono (σ : Str) {X X' : Set Str} (h : X' ⊆ X) : prepend σ X' ⊆ prepend σ X := by
  rintro w ⟨τ, hτ, rfl⟩
  exact ⟨τ, h hτ, rfl⟩

/-- **Exercise 2.16 — `x ↦ σx` is approximable.** The neighbourhood relation `X f Y ↔ σX ⊆ Y`
(confined to `B × B`). Definition 2.1: (i) `σΔ ⊆ Δ`; (ii) the prefixed cone `σX` is a common lower
bound of `Y, Y'`, witnessing `Y ∩ Y' ∈ B`; (iii) `prepend_mono` shrinks `σX'` as `X' ⊆ X`. -/
def sigmaMap (σ : Str) : ApproximableMap B B where
  rel X Y := B.mem X ∧ B.mem Y ∧ prepend σ X ⊆ Y
  rel_dom h := h.1
  rel_cod h := h.2.1
  master_rel := ⟨B.master_mem, B.master_mem, Set.subset_univ _⟩
  inter_right := by
    rintro X Y Y' ⟨hX, hY, hsub⟩ ⟨_, hY', hsub'⟩
    have hpre : B.mem (prepend σ X) := memB_prepend σ hX
    have hsubInter : prepend σ X ⊆ Y ∩ Y' := Set.subset_inter hsub hsub'
    exact ⟨hX, B.inter_mem hY hY' hpre hsubInter, hsubInter⟩
  mono := by
    rintro X X' Y Y' ⟨_, _, hsub⟩ hX'X hYY' hX' hY'
    exact ⟨hX', hY', ((prepend_mono σ hX'X).trans hsub).trans hYY'⟩

/-- **Exercise 2.16.** The elementwise action of `sigmaMap σ` is Scott's `σx`: `(sigmaMap σ)(x) =
σx` for every `x ∈ |B|`. -/
theorem toElementMap_sigmaMap (σ : Str) (x : B.Element) :
    (sigmaMap σ).toElementMap x = sigmaElt σ x := by
  apply Element.ext
  intro Y
  constructor
  · rintro ⟨X, hxX, _, hY, hsub⟩
    exact ⟨hY, X, hxX, hsub⟩
  · rintro ⟨hY, X, hxX, hsub⟩
    exact ⟨X, hxX, x.sub hxX, hY, hsub⟩

end Domain.Neighborhood.Exercise216
