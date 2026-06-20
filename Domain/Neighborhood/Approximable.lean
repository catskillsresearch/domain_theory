import Domain.Neighborhood.Basic

/-!
# Lecture II (§2) — approximable mappings: Definition 2.1 and Proposition 2.2

Following Dana Scott, *Lectures on a Mathematical Theory of Computation*, PRG-19 (1981), Lecture II,
*Approximable mappings*. A mapping of domains that "preserves the spirit of approximation" is given
not by a function on ideal elements but by a **relation between neighbourhoods**: `X f Y` reads "if
the input is approximated at least as well as by `X`, then the output is approximated at least as
well as by `Y`."

This file formalizes the §2 core that does not depend on concrete examples:

* **Definition 2.1** — `ApproximableMap V₀ V₁`: a relation `f ⊆ 𝒟₀ × 𝒟₁` with
  (i) `Δ₀ f Δ₁` (`master_rel`),
  (ii) `X f Y → X f Y' → X f (Y ∩ Y')` (`inter_right`, the consistency/intersectivity condition),
  (iii) `X f Y → X' ⊆ X → Y ⊆ Y' → X' f Y'` (`mono`, monotonicity: sharper input, blunter output).
  We carry `rel_dom`/`rel_cod` recording `f ⊆ 𝒟₀ × 𝒟₁`.
* **Proposition 2.2** — every approximable mapping determines an elementwise function
  `toElementMap f : |𝒟₀| → |𝒟₁|`, `f(x) = {Y ∣ ∃ X ∈ x, X f Y}`, which is a filter (i)–(iii) are
  *all* used); the relation is recovered by `rel_iff_mem_principal` (`X f Y ↔ Y ∈ f(↑X)`); the map
  is monotone (`toElementMap_mono`); and two approximable maps are equal iff they induce the same
  elementwise map (`ext_of_toElementMap`).

The constructions (`toElementMap`) and the structural lemmas are **choice-free**
(`#print axioms ⊆ {propext, Quot.sound}`); only `ext_of_toElementMap` is classical, since it decides
neighbourhood membership by `by_cases` (`Classical.em`). -/

namespace Domain.Neighborhood

open NeighborhoodSystem

variable {α β γ : Type*}

/-- **Definition 2.1 (Scott 1981, PRG-19).** An *approximable mapping* `f : 𝒟₀ → 𝒟₁` is a relation
`rel` between neighbourhoods (`rel X Y`, Scott's `X f Y`) confined to `𝒟₀ × 𝒟₁` and satisfying
Scott's three conditions:

* (i)   `Δ₀ f Δ₁`                                   — `master_rel`;
* (ii)  `X f Y` and `X f Y'` imply `X f (Y ∩ Y')`   — `inter_right`;
* (iii) `X f Y`, `X' ⊆ X`, `Y ⊆ Y'` imply `X' f Y'` — `mono` (the targets `X'`, `Y'` must be
  neighbourhoods, as Scott's relation lives on `𝒟₀ × 𝒟₁`). -/
structure ApproximableMap (V₀ : NeighborhoodSystem α) (V₁ : NeighborhoodSystem β) where
  /-- The underlying neighbourhood relation `X f Y`. -/
  rel : Set α → Set β → Prop
  /-- `f ⊆ 𝒟₀ × 𝒟₁` (domain side): related inputs are neighbourhoods. -/
  rel_dom : ∀ {X Y}, rel X Y → V₀.mem X
  /-- `f ⊆ 𝒟₀ × 𝒟₁` (codomain side): related outputs are neighbourhoods. -/
  rel_cod : ∀ {X Y}, rel X Y → V₁.mem Y
  /-- (i) `Δ₀ f Δ₁`. -/
  master_rel : rel V₀.master V₁.master
  /-- (ii) intersectivity on the output: `X f Y → X f Y' → X f (Y ∩ Y')`. -/
  inter_right : ∀ {X Y Y'}, rel X Y → rel X Y' → rel X (Y ∩ Y')
  /-- (iii) monotonicity: a sharper input `X' ⊆ X` with a blunter output `Y ⊆ Y'` is still related,
  provided `X'`, `Y'` are neighbourhoods. -/
  mono : ∀ {X X' Y Y'}, rel X Y → X' ⊆ X → Y ⊆ Y' → V₀.mem X' → V₁.mem Y' → rel X' Y'

namespace ApproximableMap

variable {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β} {V₂ : NeighborhoodSystem γ}

/-- **Extensionality for the relation.** Two approximable maps with the same neighbourhood relation
are equal (the remaining fields are propositions). -/
theorem ext {f g : ApproximableMap V₀ V₁} (h : ∀ X Y, f.rel X Y ↔ g.rel X Y) : f = g := by
  obtain ⟨rf, _, _, _, _, _⟩ := f
  obtain ⟨rg, _, _, _, _, _⟩ := g
  have : rf = rg := by funext X Y; exact propext (h X Y)
  subst this; rfl

/-- **Proposition 2.2(i) (Scott 1981, PRG-19).** The elementwise function determined by an
approximable mapping: `f(x) = {Y ∈ 𝒟₁ ∣ ∃ X ∈ x, X f Y}`. The four filter laws use *all* of
Definition 2.1: `master_mem` uses (i); `inter_mem` uses (ii) together with (iii) (to pull both
outputs back along the common input `X ∩ X'`); `up_mem` uses (iii). -/
def toElementMap (f : ApproximableMap V₀ V₁) (x : V₀.Element) : V₁.Element where
  mem Y := ∃ X, x.mem X ∧ f.rel X Y
  sub := fun ⟨_, _, hXY⟩ => f.rel_cod hXY
  master_mem := ⟨V₀.master, x.master_mem, f.master_rel⟩
  inter_mem := by
    rintro Y Y' ⟨X, hX, hXY⟩ ⟨X', hX', hX'Y'⟩
    have hXX'mem : x.mem (X ∩ X') := x.inter_mem hX hX'
    have hXX' : V₀.mem (X ∩ X') := x.sub hXX'mem
    refine ⟨X ∩ X', hXX'mem, ?_⟩
    have h1 : f.rel (X ∩ X') Y :=
      f.mono hXY Set.inter_subset_left subset_rfl hXX' (f.rel_cod hXY)
    have h2 : f.rel (X ∩ X') Y' :=
      f.mono hX'Y' Set.inter_subset_right subset_rfl hXX' (f.rel_cod hX'Y')
    exact f.inter_right h1 h2
  up_mem := by
    rintro Y Y' ⟨X, hX, hXY⟩ hY' hYY'
    exact ⟨X, hX, f.mono hXY subset_rfl hYY' (x.sub hX) hY'⟩

@[simp] theorem mem_toElementMap (f : ApproximableMap V₀ V₁) (x : V₀.Element) {Y : Set β} :
    (f.toElementMap x).mem Y ↔ ∃ X, x.mem X ∧ f.rel X Y := Iff.rfl

/-- **Proposition 2.2(ii) (Scott 1981, PRG-19).** The relation is recovered from the elementwise
map: for `X ∈ 𝒟₀`, `X f Y ↔ Y ∈ f(↑X)`. (`→` since `X ∈ ↑X`; `←` since any `Z ∈ ↑X` has `X ⊆ Z`,
so `Z f Y` monotonically yields `X f Y`.) -/
theorem rel_iff_mem_principal (f : ApproximableMap V₀ V₁) {X : Set α} (hX : V₀.mem X) {Y : Set β} :
    f.rel X Y ↔ (f.toElementMap (V₀.principal hX)).mem Y := by
  constructor
  · intro hXY
    exact ⟨X, ⟨hX, subset_rfl⟩, hXY⟩
  · rintro ⟨Z, ⟨_, hXZ⟩, hZY⟩
    exact f.mono hZY hXZ subset_rfl hX (f.rel_cod hZY)

/-- **Proposition 2.2(iii) (Scott 1981, PRG-19).** Approximable maps are monotone on elements:
`x ⊑ y ⟹ f(x) ⊑ f(y)`. -/
theorem toElementMap_mono (f : ApproximableMap V₀ V₁) {x y : V₀.Element} (hxy : x ≤ y) :
    f.toElementMap x ≤ f.toElementMap y := by
  rintro Y ⟨X, hX, hXY⟩
  exact ⟨X, hxy X hX, hXY⟩

/-- **Proposition 2.2(iv) (Scott 1981, PRG-19).** Two approximable maps are *identical as relations*
iff they induce the same elementwise function: `(∀ x, f(x) = g(x)) ⟹ f = g`. For neighbourhoods `X`
the relation is read off `f(↑X)` (`rel_iff_mem_principal`); off `𝒟₀` both relations are empty. -/
theorem ext_of_toElementMap {f g : ApproximableMap V₀ V₁}
    (h : ∀ x, f.toElementMap x = g.toElementMap x) : f = g := by
  apply ApproximableMap.ext
  intro X Y
  by_cases hX : V₀.mem X
  · rw [f.rel_iff_mem_principal hX, g.rel_iff_mem_principal hX, h]
  · constructor
    · intro hr; exact absurd (f.rel_dom hr) hX
    · intro hr; exact absurd (g.rel_dom hr) hX

end ApproximableMap

end Domain.Neighborhood
