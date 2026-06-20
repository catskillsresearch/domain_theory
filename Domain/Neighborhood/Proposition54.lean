import Domain.Neighborhood.Theorem41

/-!
# Lecture V (§5) — Proposition 5.4 (Scott 1981, PRG-19)

Let `x`, `y`, and `τ(x, y)` have the same type `𝒟`, and let `g` range over `(𝒟 → 𝒟)`. Then the
equation

`λx. !y. τ(x, y) = !g. λx. τ(x, g(x))`

is true.

In this framework `τ : 𝒟 × 𝒟 → 𝒟` is an approximable map. We model the two sides directly:

* the **left** side `λx. !y. τ(x, y)` is `pfix τ := fix ∘ curry(τ)`, the approximable map sending
  `x` to the least fixed point of the section `y ↦ τ(x, y)` (this is `!y.τ(x,y)`, manifestly
  approximable by Theorem 4.2 — exactly Scott's appeal to 5.1 that "`f` is a function");
* the **right** side `!g. λx. τ(x, g(x))` is the least fixed point `(recOp τ).fixElement` of the
  approximable *operator* `recOp τ := curry(τ ∘ ⟨p₁, eval⟩)` on the function space, which sends a
  map `g` to `λx. τ(x, g(x))`.

The proof is Scott's: `pfix τ` is a fixed point of `recOp τ` (so `!g.… ⊑ pfix τ`), and conversely
the value `(recOp τ).fixElement (x)` is a fixed point of the section `y ↦ τ(x, y)` (so
`pfix τ (x) ⊑ (recOp τ).fixElement (x)` for every `x`). Everything is at the level of `|𝒟|` and the
function space, so the *data* (`pfix`, `recOp`) is **choice-free**
(`#print axioms ⊆ {propext, Quot.sound}`); the final map equality goes through the permitted
`ext_of_toElementMap`.
-/

namespace Domain.Neighborhood

open NeighborhoodSystem ApproximableMap

variable {α : Type*} {V : NeighborhoodSystem α}

namespace ApproximableMap

/-- The section `y ↦ τ(x, y)` of `τ : 𝒟 × 𝒟 → 𝒟` at a fixed `x`, as an approximable endomap of
`𝒟` (the curried `τ` applied to `x`). -/
def section₂ (τ : ApproximableMap (prod V V) V) (x : V.Element) : ApproximableMap V V :=
  toApproxMap ((curry τ).toElementMap x)

theorem section₂_apply (τ : ApproximableMap (prod V V) V) (x y : V.Element) :
    (section₂ τ x).toElementMap y = τ.toElementMap (pair x y) := by
  rw [section₂, toElementMap_curry_apply]

/-- The **left-hand side** `λx. !y. τ(x, y)` of Proposition 5.4: `fix ∘ curry(τ)`. -/
def pfix (τ : ApproximableMap (prod V V) V) : ApproximableMap V V :=
  (fixMap V).comp (curry τ)

/-- `pfix τ (x) = !y. τ(x, y)`, the least fixed point of the section at `x`. -/
theorem pfix_apply (τ : ApproximableMap (prod V V) V) (x : V.Element) :
    (pfix τ).toElementMap x = (section₂ τ x).fixElement := by
  rw [pfix, toElementMap_comp, fixMap_toElementMap, section₂]

/-- The **operator** `λg. λx. τ(x, g(x))` of Proposition 5.4, as an approximable endomap of the
function space `(𝒟 → 𝒟)`: `recOp τ := curry(τ ∘ ⟨p₁, eval⟩)`. -/
def recOp (τ : ApproximableMap (prod V V) V) : ApproximableMap (funSpace V V) (funSpace V V) :=
  curry (τ.comp (paired (proj₁ (funSpace V V) V) (evalMap V V)))

/-- `recOp τ (g) (x) = τ(x, g(x))`. -/
theorem recOp_apply (τ : ApproximableMap (prod V V) V) (φ : (funSpace V V).Element) (x : V.Element) :
    (toApproxMap ((recOp τ).toElementMap φ)).toElementMap x
      = τ.toElementMap (pair x ((toApproxMap φ).toElementMap x)) := by
  rw [recOp, toElementMap_curry_apply, toElementMap_comp, toElementMap_paired,
    toElementMap_proj₁, snd_pair, evalMap_apply]

/-- `pfix τ` is a fixed point of `recOp τ` (pointwise: `τ(x, pfix τ x) = pfix τ x`). -/
theorem pfix_isFixed (τ : ApproximableMap (prod V V) V) (x : V.Element) :
    τ.toElementMap (pair x ((pfix τ).toElementMap x)) = (pfix τ).toElementMap x := by
  rw [pfix_apply, ← section₂_apply, toElementMap_fixElement]

/-- **Proposition 5.4 (Scott 1981, PRG-19).** `λx. !y. τ(x, y) = !g. λx. τ(x, g(x))`. -/
theorem pfix_eq_fixElement_recOp (τ : ApproximableMap (prod V V) V) :
    pfix τ = toApproxMap (recOp τ).fixElement := by
  set g₀ := (recOp τ).fixElement with hg₀
  set G := toApproxMap g₀ with hG
  -- `G(x) = τ(x, G(x))`: `g₀` is a fixed point of `recOp τ`.
  have hG_fixed : ∀ x, G.toElementMap x = τ.toElementMap (pair x (G.toElementMap x)) := by
    intro x
    have hfix : (recOp τ).toElementMap g₀ = g₀ := toElementMap_fixElement (recOp τ)
    have := recOp_apply τ g₀ x
    rw [hfix] at this
    rw [hG]; exact this
  apply le_antisymm
  · -- `pfix τ ⊑ G`: `pfix τ (x)` is the least fixed point of the section, `G(x)` is some fixed point.
    rw [le_iff_toElementMap_le]
    intro x
    rw [pfix_apply]
    apply fixElement_le_of_toElementMap_le
    rw [section₂_apply]
    exact le_of_eq (hG_fixed x).symm
  · -- `G ⊑ pfix τ`: `toFilter (pfix τ)` is a fixed point of `recOp τ`, so `g₀ ⊑ toFilter (pfix τ)`.
    have hpre : (recOp τ).toElementMap (toFilter (pfix τ)) ≤ toFilter (pfix τ) := by
      apply le_of_eq
      have hmap : toApproxMap ((recOp τ).toElementMap (toFilter (pfix τ))) = pfix τ := by
        apply ext_of_toElementMap
        intro x
        rw [recOp_apply]
        have hround : toApproxMap (toFilter (pfix τ)) = pfix τ := by
          have he := (funSpaceEquiv V V).apply_symm_apply (pfix τ)
          rwa [funSpaceEquiv_apply, funSpaceEquiv_symm_apply] at he
        rw [hround, pfix_isFixed]
      -- transport `hmap` through the iso `toApproxMap`/`toFilter`.
      have h1 : toFilter (toApproxMap ((recOp τ).toElementMap (toFilter (pfix τ)))) =
          toFilter (pfix τ) := by rw [hmap]
      have hround2 : toFilter (toApproxMap ((recOp τ).toElementMap (toFilter (pfix τ)))) =
          (recOp τ).toElementMap (toFilter (pfix τ)) := by
        have he := (funSpaceEquiv V V).symm_apply_apply ((recOp τ).toElementMap (toFilter (pfix τ)))
        rwa [funSpaceEquiv_apply, funSpaceEquiv_symm_apply] at he
      rw [hround2] at h1
      exact h1
    have hle : g₀ ≤ toFilter (pfix τ) := fixElement_le_of_toElementMap_le (recOp τ) hpre
    have := (funSpaceEquiv V V).monotone hle
    rw [funSpaceEquiv_apply, funSpaceEquiv_apply] at this
    have hround : toApproxMap (toFilter (pfix τ)) = pfix τ := by
      have he := (funSpaceEquiv V V).apply_symm_apply (pfix τ)
      rwa [funSpaceEquiv_apply, funSpaceEquiv_symm_apply] at he
    rw [hG, ← hround]
    exact this

end ApproximableMap

end Domain.Neighborhood
