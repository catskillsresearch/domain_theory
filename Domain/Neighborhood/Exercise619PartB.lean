import Domain.Neighborhood.Exercise619
import Domain.Neighborhood.Definition613
import Domain.Neighborhood.Exercise213
import Domain.Neighborhood.FunctionSpace

/-!
# Exercise 6.19 (Scott 1981, PRG-19, §6) — Part B: the functor algebra

> … Now generate all constructs `T(X)` formed by the constants (that is, `T(X) = 𝒟` for a fixed `𝒟`),
> by the identity (`T(X) = X`), and by sums and products (`T₀(X) + T₁(X)`, etc.). Show that these are
> all functors, continuous on maps, and monotone and continuous on domains.

This module formalizes **Part B**: the closed family of constructs `T(X)` over Scott's *uniform*
category of Exercise 6.19 — neighbourhood systems on `Δ ⊆ {0,1}*` with `∅ ∉ 𝒟` (the standing
hypothesis that makes the token-level sum `sumTok`/product `prodTok` of Part A genuine
*endo*-operations) and **strict** approximable maps.

## Contents

* `ScottSys` — an object of Scott's category: an `∅`-free neighbourhood system over `Str = {0,1}*`.
* The object actions `ScottSys.sum`/`ScottSys.prod` (Part A's `sumTok`/`prodTok`, repackaged so they
  stay inside the category) and the constant/identity objects.
* The **functorial action on maps**: `sumMapTok f₀ f₁ : (𝒟₀+𝒟₁) → (ℰ₀+ℰ₁)` and
  `prodMapTok f₀ f₁ : (𝒟₀×𝒟₁) → (ℰ₀×ℰ₁)`, each an approximable map, with strictness preservation
  (`sumMapTok` is *always* strict; `prodMapTok` is strict when both factors are).
* The **bifunctor laws**: both actions preserve identities and composition
  (`sumMapTok_id`/`sumMapTok_comp`, `prodMapTok_id`/`prodMapTok_comp`).
* The functor-expression algebra `FExpr` (constants, identity, sum, product), its object action
  `FExpr.obj`, its action on maps `FExpr.map`.

Scott asks to show these constructs are **all functors, continuous on maps, and monotone and
continuous on domains**; each is established here:

* **functors** — `FExpr.map_id` (`T(I)=I`) and `FExpr.map_comp` (`T(g∘f)=T(g)∘T(f)`), by induction;
  plus `FExpr.map_isStrict` (so `T` restricts to Scott's strict-map category).
* **continuous on maps** — `FExpr.map_mono` (a sharper map gives a sharper image) and
  `FExpr.map_continuous` (`λf. T(f)` preserves directed unions of maps); together these are exactly
  approximability of `λf. T(f)` (Exercise 2.13).
* **monotone on domains** — `FExpr.obj_subsystem` (`D ◁ E ⟹ T(D) ◁ T(E)`).
* **continuous on domains** — `FExpr.obj_continuous` (`λD. T(D)` preserves directed unions of
  subsystems, the form Scott uses in Theorem 6.14).

Because every construct stays over the single token type `{0,1}*`, the subdomain relation `◁` is
between systems on a common carrier, so the domain conditions need no carrier transport (unlike the
universe-polymorphic `Endofunctor DomainObj` form of Definitions 6.8/6.13).

Everything is **choice-free** (`#print axioms ⊆ {propext, Quot.sound}`).
-/

namespace Domain.Neighborhood

open NeighborhoodSystem ApproximableMap Domain.Neighborhood.Exercise619
open Domain.Neighborhood.Example62 Domain.Neighborhood.ExampleB
open Domain.Neighborhood.Exercise510

namespace Exercise619

/-! ## Objects of Scott's category: `∅`-free systems over `{0,1}*` -/

/-- **An object of the Exercise 6.19 category.** An `∅`-free neighbourhood system over
`Str = {0,1}*` (`ne`: every neighbourhood is non-empty, Scott's `∅ ∉ 𝒟`). -/
structure ScottSys where
  /-- The underlying neighbourhood system on `{0,1}*`. -/
  sys : NeighborhoodSystem Str
  /-- `∅ ∉ 𝒟`: every neighbourhood is non-empty. -/
  ne : ∀ X, sys.mem X → X.Nonempty

/-- The **sum object** `𝒟₀ + 𝒟₁` of Part A, repackaged as an object of the category. -/
def ScottSys.sum (A₀ A₁ : ScottSys) : ScottSys :=
  ⟨sumTok A₀.sys A₁.sys A₀.ne A₁.ne, sumTok_nonempty⟩

/-- The **product object** `𝒟₀ × 𝒟₁` of Part A, repackaged as an object of the category. -/
def ScottSys.prod (A₀ A₁ : ScottSys) : ScottSys :=
  ⟨prodTok A₀.sys A₁.sys, prodTok_nonempty⟩

variable {A₀ A₁ B₀ B₁ C₀ C₁ : ScottSys}

/-- A non-empty `b`-tagged copy can never sit inside a `b'`-tagged copy for `b ≠ b'`. -/
theorem embBit_not_subset_cross {b b' : Bool} (h : b ≠ b') {X Y : Set Str} (hX : X.Nonempty)
    (hsub : embBit b X ⊆ embBit b' Y) : False := by
  obtain ⟨t, ht⟩ := hX
  obtain ⟨w', he, -⟩ := hsub ⟨t, rfl, ht⟩
  simp only [List.cons.injEq] at he
  exact h he.1

/-! ## The functorial action of sum on maps -/

/-- **`f₀ + f₁`, the action of the sum functor on (approximable) maps.** It carries the master to the
master (so it is strict), a left copy `0X` to `0X'` whenever `X f₀ X'`, and a right copy `1Y` to
`1Y'` whenever `Y f₁ Y'`. -/
def sumMapTok (f₀ : ApproximableMap A₀.sys B₀.sys) (f₁ : ApproximableMap A₁.sys B₁.sys) :
    ApproximableMap (A₀.sum A₁).sys (B₀.sum B₁).sys where
  rel W W' :=
    ((sumTok A₀.sys A₁.sys A₀.ne A₁.ne).mem W ∧ W' = sumTokMaster B₀.sys B₁.sys) ∨
    (∃ X X', f₀.rel X X' ∧ W = embBit false X ∧ W' = embBit false X') ∨
    (∃ Y Y', f₁.rel Y Y' ∧ W = embBit true Y ∧ W' = embBit true Y')
  rel_dom := by
    rintro W W' (⟨hW, -⟩ | ⟨X, X', hrel, rfl, -⟩ | ⟨Y, Y', hrel, rfl, -⟩)
    · exact hW
    · exact Or.inr (Or.inl ⟨X, f₀.rel_dom hrel, rfl⟩)
    · exact Or.inr (Or.inr ⟨Y, f₁.rel_dom hrel, rfl⟩)
  rel_cod := by
    rintro W W' (⟨-, rfl⟩ | ⟨X, X', hrel, -, rfl⟩ | ⟨Y, Y', hrel, -, rfl⟩)
    · exact Or.inl rfl
    · exact Or.inr (Or.inl ⟨X', f₀.rel_cod hrel, rfl⟩)
    · exact Or.inr (Or.inr ⟨Y', f₁.rel_cod hrel, rfl⟩)
  master_rel := Or.inl ⟨(A₀.sum A₁).sys.master_mem, rfl⟩
  inter_right := by
    rintro W W'₁ W'₂ h1 h2
    rcases h1 with ⟨hW, rfl⟩ | ⟨X, X', hrel, rfl, rfl⟩ | ⟨Y, Y', hrel, rfl, rfl⟩
    · rcases h2 with ⟨-, rfl⟩ | ⟨X, X', hrel, hWeq, rfl⟩ | ⟨Y, Y', hrel, hWeq, rfl⟩
      · exact Or.inl ⟨hW, by rw [Set.inter_self]⟩
      · exact Or.inr (Or.inl ⟨X, X', hrel, hWeq, by rw [sumTokMaster_inter_embF (f₀.rel_cod hrel)]⟩)
      · exact Or.inr (Or.inr ⟨Y, Y', hrel, hWeq, by rw [sumTokMaster_inter_embT (f₁.rel_cod hrel)]⟩)
    · rcases h2 with ⟨-, rfl⟩ | ⟨X₂, X'₂, hrel₂, hWeq, rfl⟩ | ⟨Y₂, Y'₂, hrel₂, hWeq, rfl⟩
      · refine Or.inr (Or.inl ⟨X, X', hrel, rfl, ?_⟩)
        rw [Set.inter_comm, sumTokMaster_inter_embF (f₀.rel_cod hrel)]
      · obtain rfl := embBit_injective hWeq
        exact Or.inr (Or.inl ⟨X, X' ∩ X'₂, f₀.inter_right hrel hrel₂, rfl, embBit_inter false X' X'₂⟩)
      · exact absurd hWeq (embBit_ne (by decide) (A₀.ne X (f₀.rel_dom hrel)))
    · rcases h2 with ⟨-, rfl⟩ | ⟨X₂, X'₂, hrel₂, hWeq, rfl⟩ | ⟨Y₂, Y'₂, hrel₂, hWeq, rfl⟩
      · refine Or.inr (Or.inr ⟨Y, Y', hrel, rfl, ?_⟩)
        rw [Set.inter_comm, sumTokMaster_inter_embT (f₁.rel_cod hrel)]
      · exact absurd hWeq (embBit_ne (by decide) (A₁.ne Y (f₁.rel_dom hrel)))
      · obtain rfl := embBit_injective hWeq
        exact Or.inr (Or.inr ⟨Y, Y' ∩ Y'₂, f₁.inter_right hrel hrel₂, rfl, embBit_inter true Y' Y'₂⟩)
  mono := by
    rintro W W'' Z Z' h hWW hZZ' hW'' hZ'
    rcases h with ⟨-, rfl⟩ | ⟨X, X', hrel, rfl, rfl⟩ | ⟨Y, Y', hrel, rfl, rfl⟩
    · -- output was the master; a blunter neighbourhood must again be the master.
      exact Or.inl ⟨hW'', Set.Subset.antisymm ((B₀.sum B₁).sys.sub_master hZ') hZZ'⟩
    · -- input `0X`, output `0X'`. The sharper input `W''` and blunter output `Z'`.
      rcases hZ' with rfl | ⟨X₃, hX₃, rfl⟩ | ⟨Y₃, hY₃, rfl⟩
      · exact Or.inl ⟨hW'', rfl⟩
      · rcases hW'' with rfl | ⟨X₂, hX₂, rfl⟩ | ⟨Y₂, hY₂, rfl⟩
        · exact absurd (hWW nil_mem_sumTokMaster) nil_not_mem_embBit
        · exact Or.inr (Or.inl ⟨X₂, X₃,
            f₀.mono hrel (embBit_subset.mp hWW) (embBit_subset.mp hZZ') hX₂ hX₃, rfl, rfl⟩)
        · exact absurd hWW (fun hsub => embBit_not_subset_cross (by decide) (A₁.ne Y₂ hY₂) hsub)
      · exact absurd hZZ' (fun hsub =>
          embBit_not_subset_cross (by decide) (B₀.ne X' (f₀.rel_cod hrel)) hsub)
    · -- input `1Y`, output `1Y'`.
      rcases hZ' with rfl | ⟨X₃, hX₃, rfl⟩ | ⟨Y₃, hY₃, rfl⟩
      · exact Or.inl ⟨hW'', rfl⟩
      · exact absurd hZZ' (fun hsub =>
          embBit_not_subset_cross (by decide) (B₁.ne Y' (f₁.rel_cod hrel)) hsub)
      · rcases hW'' with rfl | ⟨X₂, hX₂, rfl⟩ | ⟨Y₂, hY₂, rfl⟩
        · exact absurd (hWW nil_mem_sumTokMaster) nil_not_mem_embBit
        · exact absurd hWW (fun hsub => embBit_not_subset_cross (by decide) (A₀.ne X₂ hX₂) hsub)
        · exact Or.inr (Or.inr ⟨Y₂, Y₃,
            f₁.mono hrel (embBit_subset.mp hWW) (embBit_subset.mp hZZ') hY₂ hY₃, rfl, rfl⟩)

/-- **`sumMapTok` is strict** for *any* component maps: the master input `Λ` (the only neighbourhood
containing the empty string) relates only to the output master. -/
theorem sumMapTok_isStrict (f₀ : ApproximableMap A₀.sys B₀.sys)
    (f₁ : ApproximableMap A₁.sys B₁.sys) : IsStrict (sumMapTok f₀ f₁) := by
  rintro Y (⟨-, rfl⟩ | ⟨X, X', -, heq, -⟩ | ⟨Y0, Y', -, heq, -⟩)
  · rfl
  · have heq' : sumTokMaster A₀.sys A₁.sys = embBit false X := heq
    exact absurd (heq' ▸ nil_mem_sumTokMaster) nil_not_mem_embBit
  · have heq' : sumTokMaster A₀.sys A₁.sys = embBit true Y0 := heq
    exact absurd (heq' ▸ nil_mem_sumTokMaster) nil_not_mem_embBit

/-! ## The functorial action of product on maps -/

/-- **`f₀ × f₁`, the action of the product functor on (approximable) maps.** A product
neighbourhood `{Λ} ∪ 0X ∪ 1Y` is sent to `{Λ} ∪ 0X' ∪ 1Y'` whenever `X f₀ X'` and `Y f₁ Y'`. -/
def prodMapTok (f₀ : ApproximableMap A₀.sys B₀.sys) (f₁ : ApproximableMap A₁.sys B₁.sys) :
    ApproximableMap (A₀.prod A₁).sys (B₀.prod B₁).sys where
  rel W W' := ∃ X Y X' Y', f₀.rel X X' ∧ f₁.rel Y Y' ∧
    W = prodTokNbhd X Y ∧ W' = prodTokNbhd X' Y'
  rel_dom := by
    rintro W W' ⟨X, Y, X', Y', h0, h1, rfl, -⟩
    exact prodTok_mem_prodTokNbhd (f₀.rel_dom h0) (f₁.rel_dom h1)
  rel_cod := by
    rintro W W' ⟨X, Y, X', Y', h0, h1, -, rfl⟩
    exact prodTok_mem_prodTokNbhd (f₀.rel_cod h0) (f₁.rel_cod h1)
  master_rel :=
    ⟨A₀.sys.master, A₁.sys.master, B₀.sys.master, B₁.sys.master,
      f₀.master_rel, f₁.master_rel, rfl, rfl⟩
  inter_right := by
    rintro W W'₁ W'₂ ⟨X, Y, X', Y', h0, h1, rfl, rfl⟩ ⟨X₂, Y₂, X'₂, Y'₂, h0₂, h1₂, hWeq, rfl⟩
    obtain ⟨rfl, rfl⟩ := prodTokNbhd_injective hWeq
    exact ⟨X, Y, X' ∩ X'₂, Y' ∩ Y'₂, f₀.inter_right h0 h0₂, f₁.inter_right h1 h1₂, rfl,
      prodTokNbhd_inter X' X'₂ Y' Y'₂⟩
  mono := by
    rintro W W'' Z Z' ⟨X, Y, X', Y', h0, h1, rfl, rfl⟩ hWW hZZ' hW'' hZ'
    obtain ⟨X₂, Y₂, hX₂, hY₂, rfl⟩ := hW''
    obtain ⟨X'₃, Y'₃, hX'₃, hY'₃, rfl⟩ := hZ'
    obtain ⟨hsX, hsY⟩ := prodTokNbhd_subset_iff.mp hWW
    obtain ⟨hsX', hsY'⟩ := prodTokNbhd_subset_iff.mp hZZ'
    exact ⟨X₂, Y₂, X'₃, Y'₃, f₀.mono h0 hsX hsX' hX₂ hX'₃, f₁.mono h1 hsY hsY' hY₂ hY'₃, rfl, rfl⟩

/-- **`prodMapTok` is strict** exactly when both components are strict. -/
theorem prodMapTok_isStrict {f₀ : ApproximableMap A₀.sys B₀.sys}
    {f₁ : ApproximableMap A₁.sys B₁.sys} (hf₀ : IsStrict f₀) (hf₁ : IsStrict f₁) :
    IsStrict (prodMapTok f₀ f₁) := by
  rintro Y ⟨X, Y0, X', Y', h0, h1, hWeq, rfl⟩
  obtain ⟨rfl, rfl⟩ := prodTokNbhd_injective hWeq
  rw [hf₀ h0, hf₁ h1]
  rfl

/-! ## The bifunctor laws: identities and composition are preserved -/

/-- **`(I_{𝒟₀} + I_{𝒟₁}) = I_{𝒟₀+𝒟₁}`.** -/
theorem sumMapTok_id :
    sumMapTok (idMap A₀.sys) (idMap A₁.sys) = idMap (A₀.sum A₁).sys := by
  apply ApproximableMap.ext
  intro W W'
  constructor
  · rintro (⟨hW, rfl⟩ | ⟨X, X', ⟨hX, hX', hsub⟩, rfl, rfl⟩ | ⟨Y, Y', ⟨hY, hY', hsub⟩, rfl, rfl⟩)
    · exact ⟨hW, (A₀.sum A₁).sys.master_mem, (A₀.sum A₁).sys.sub_master hW⟩
    · exact ⟨Or.inr (Or.inl ⟨X, hX, rfl⟩), Or.inr (Or.inl ⟨X', hX', rfl⟩), embBit_subset.mpr hsub⟩
    · exact ⟨Or.inr (Or.inr ⟨Y, hY, rfl⟩), Or.inr (Or.inr ⟨Y', hY', rfl⟩), embBit_subset.mpr hsub⟩
  · rintro ⟨hW, hW', hsub⟩
    rcases hW' with rfl | ⟨X', hX', rfl⟩ | ⟨Y', hY', rfl⟩
    · exact Or.inl ⟨hW, rfl⟩
    · rcases hW with rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩
      · exact absurd (hsub nil_mem_sumTokMaster) nil_not_mem_embBit
      · exact Or.inr (Or.inl ⟨X, X', ⟨hX, hX', embBit_subset.mp hsub⟩, rfl, rfl⟩)
      · exact absurd hsub (fun h => embBit_not_subset_cross (by decide) (A₁.ne Y hY) h)
    · rcases hW with rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩
      · exact absurd (hsub nil_mem_sumTokMaster) nil_not_mem_embBit
      · exact absurd hsub (fun h => embBit_not_subset_cross (by decide) (A₀.ne X hX) h)
      · exact Or.inr (Or.inr ⟨Y, Y', ⟨hY, hY', embBit_subset.mp hsub⟩, rfl, rfl⟩)

/-- **`(g₀ ∘ f₀) + (g₁ ∘ f₁) = (g₀ + g₁) ∘ (f₀ + f₁)`.** -/
theorem sumMapTok_comp (f₀ : ApproximableMap A₀.sys B₀.sys) (f₁ : ApproximableMap A₁.sys B₁.sys)
    (g₀ : ApproximableMap B₀.sys C₀.sys) (g₁ : ApproximableMap B₁.sys C₁.sys) :
    sumMapTok (g₀.comp f₀) (g₁.comp f₁) = (sumMapTok g₀ g₁).comp (sumMapTok f₀ f₁) := by
  apply ApproximableMap.ext
  intro W W''
  constructor
  · rintro (⟨hW, rfl⟩ | ⟨X, X'', ⟨X', hf, hg⟩, rfl, rfl⟩ | ⟨Y, Y'', ⟨Y', hf, hg⟩, rfl, rfl⟩)
    · exact ⟨sumTokMaster B₀.sys B₁.sys, Or.inl ⟨hW, rfl⟩,
        Or.inl ⟨(B₀.sum B₁).sys.master_mem, rfl⟩⟩
    · exact ⟨embBit false X', Or.inr (Or.inl ⟨X, X', hf, rfl, rfl⟩),
        Or.inr (Or.inl ⟨X', X'', hg, rfl, rfl⟩)⟩
    · exact ⟨embBit true Y', Or.inr (Or.inr ⟨Y, Y', hf, rfl, rfl⟩),
        Or.inr (Or.inr ⟨Y', Y'', hg, rfl, rfl⟩)⟩
  · rintro ⟨W', hWW', hW'W''⟩
    rcases hWW' with ⟨hW, rfl⟩ | ⟨X, X', hf, rfl, rfl⟩ | ⟨Y, Y', hf, rfl, rfl⟩
    · rcases hW'W'' with ⟨-, rfl⟩ | ⟨X, X', -, heq, -⟩ | ⟨Y, Y', -, heq, -⟩
      · exact Or.inl ⟨hW, rfl⟩
      · exact absurd (heq ▸ nil_mem_sumTokMaster) nil_not_mem_embBit
      · exact absurd (heq ▸ nil_mem_sumTokMaster) nil_not_mem_embBit
    · rcases hW'W'' with ⟨-, rfl⟩ | ⟨X₂, X'', hg, heq, rfl⟩ | ⟨Y₂, Y'', hg, heq, -⟩
      · exact Or.inl ⟨Or.inr (Or.inl ⟨X, f₀.rel_dom hf, rfl⟩), rfl⟩
      · obtain rfl := embBit_injective heq
        exact Or.inr (Or.inl ⟨X, X'', ⟨X', hf, hg⟩, rfl, rfl⟩)
      · exact absurd heq (embBit_ne (by decide) (B₀.ne X' (f₀.rel_cod hf)))
    · rcases hW'W'' with ⟨-, rfl⟩ | ⟨X₂, X'', hg, heq, -⟩ | ⟨Y₂, Y'', hg, heq, rfl⟩
      · exact Or.inl ⟨Or.inr (Or.inr ⟨Y, f₁.rel_dom hf, rfl⟩), rfl⟩
      · exact absurd heq (embBit_ne (by decide) (B₁.ne Y' (f₁.rel_cod hf)))
      · obtain rfl := embBit_injective heq
        exact Or.inr (Or.inr ⟨Y, Y'', ⟨Y', hf, hg⟩, rfl, rfl⟩)

/-- **`(I_{𝒟₀} × I_{𝒟₁}) = I_{𝒟₀×𝒟₁}`.** -/
theorem prodMapTok_id :
    prodMapTok (idMap A₀.sys) (idMap A₁.sys) = idMap (A₀.prod A₁).sys := by
  apply ApproximableMap.ext
  intro W W'
  constructor
  · rintro ⟨X, Y, X', Y', ⟨hX, hX', hsX⟩, ⟨hY, hY', hsY⟩, rfl, rfl⟩
    exact ⟨prodTok_mem_prodTokNbhd hX hY, prodTok_mem_prodTokNbhd hX' hY',
      prodTokNbhd_subset_iff.mpr ⟨hsX, hsY⟩⟩
  · rintro ⟨⟨X, Y, hX, hY, rfl⟩, ⟨X', Y', hX', hY', rfl⟩, hsub⟩
    obtain ⟨hsX, hsY⟩ := prodTokNbhd_subset_iff.mp hsub
    exact ⟨X, Y, X', Y', ⟨hX, hX', hsX⟩, ⟨hY, hY', hsY⟩, rfl, rfl⟩

/-- **`(g₀ ∘ f₀) × (g₁ ∘ f₁) = (g₀ × g₁) ∘ (f₀ × f₁)`.** -/
theorem prodMapTok_comp (f₀ : ApproximableMap A₀.sys B₀.sys) (f₁ : ApproximableMap A₁.sys B₁.sys)
    (g₀ : ApproximableMap B₀.sys C₀.sys) (g₁ : ApproximableMap B₁.sys C₁.sys) :
    prodMapTok (g₀.comp f₀) (g₁.comp f₁) = (prodMapTok g₀ g₁).comp (prodMapTok f₀ f₁) := by
  apply ApproximableMap.ext
  intro W W''
  constructor
  · rintro ⟨X, Y, X'', Y'', ⟨X', hf0, hg0⟩, ⟨Y', hf1, hg1⟩, rfl, rfl⟩
    exact ⟨prodTokNbhd X' Y', ⟨X, Y, X', Y', hf0, hf1, rfl, rfl⟩,
      ⟨X', Y', X'', Y'', hg0, hg1, rfl, rfl⟩⟩
  · rintro ⟨W', ⟨X, Y, X', Y', hf0, hf1, rfl, rfl⟩, ⟨X₂, Y₂, X'', Y'', hg0, hg1, hWeq, rfl⟩⟩
    obtain ⟨rfl, rfl⟩ := prodTokNbhd_injective hWeq
    exact ⟨X, Y, X'', Y'', ⟨X', hf0, hg0⟩, ⟨Y', hf1, hg1⟩, rfl, rfl⟩

/-! ## The functor-expression algebra `T(X)` and the functor laws

*"Generate all constructs `T(X)` formed by the constants (`T(X) = 𝒟`), by the identity (`T(X) = X`),
and by sums and products."* -/

/-- **The functor-expression algebra.** A `T(X)` built from constants, the identity, and binary sums
and products — Scott's closed family of constructs. -/
inductive FExpr where
  /-- The constant functor `T(X) = 𝒟` at a fixed object `𝒟`. -/
  | const : ScottSys → FExpr
  /-- The identity functor `T(X) = X`. -/
  | var : FExpr
  /-- The sum `T₀(X) + T₁(X)`. -/
  | sum : FExpr → FExpr → FExpr
  /-- The product `T₀(X) × T₁(X)`. -/
  | prod : FExpr → FExpr → FExpr

/-- **The action of `T` on objects.** -/
def FExpr.obj : FExpr → ScottSys → ScottSys
  | .const D, _ => D
  | .var, X => X
  | .sum T₀ T₁, X => (T₀.obj X).sum (T₁.obj X)
  | .prod T₀ T₁, X => (T₀.obj X).prod (T₁.obj X)

/-- **The action of `T` on (approximable) maps.** Constants act by the identity, the identity functor
acts by `f` itself, and sums/products act by the bifunctorial combinators `sumMapTok`/`prodMapTok`. -/
def FExpr.map : (T : FExpr) → {X Y : ScottSys} → ApproximableMap X.sys Y.sys →
    ApproximableMap (T.obj X).sys (T.obj Y).sys
  | .const D, _, _, _ => idMap D.sys
  | .var, _, _, f => f
  | .sum T₀ T₁, _, _, f => sumMapTok (T₀.map f) (T₁.map f)
  | .prod T₀ T₁, _, _, f => prodMapTok (T₀.map f) (T₁.map f)

/-- **Every `T` preserves strictness** (so it restricts to Scott's category of strict maps): `T(f)`
is strict whenever `f` is (and constants/sums are strict unconditionally). -/
theorem FExpr.map_isStrict : (T : FExpr) → {X Y : ScottSys} → (f : ApproximableMap X.sys Y.sys) →
    IsStrict f → IsStrict (T.map f)
  | .const _, _, _, _, _ => isStrict_idMap
  | .var, _, _, _, hf => hf
  | .sum T₀ T₁, _, _, f, _ => sumMapTok_isStrict (T₀.map f) (T₁.map f)
  | .prod T₀ T₁, _, _, f, hf =>
      prodMapTok_isStrict (T₀.map_isStrict f hf) (T₁.map_isStrict f hf)

/-- **Functor law 1 — `T(I_X) = I_{T(X)}`.** Every construct `T` preserves identities. -/
theorem FExpr.map_id : (T : FExpr) → (X : ScottSys) → T.map (idMap X.sys) = idMap (T.obj X).sys
  | .const D, _ => rfl
  | .var, _ => rfl
  | .sum T₀ T₁, X => by
      show sumMapTok (T₀.map (idMap X.sys)) (T₁.map (idMap X.sys))
          = idMap ((T₀.obj X).sum (T₁.obj X)).sys
      rw [T₀.map_id X, T₁.map_id X, sumMapTok_id]
  | .prod T₀ T₁, X => by
      show prodMapTok (T₀.map (idMap X.sys)) (T₁.map (idMap X.sys))
          = idMap ((T₀.obj X).prod (T₁.obj X)).sys
      rw [T₀.map_id X, T₁.map_id X, prodMapTok_id]

/-- **Functor law 2 — `T(g ∘ f) = T(g) ∘ T(f)`.** Every construct `T` preserves composition; together
with `map_id` this shows *these are all functors*. -/
theorem FExpr.map_comp : (T : FExpr) → {X Y Z : ScottSys} → (f : ApproximableMap X.sys Y.sys) →
    (g : ApproximableMap Y.sys Z.sys) → T.map (g.comp f) = (T.map g).comp (T.map f)
  | .const D, _, _, _, _, _ => (idMap_comp (idMap D.sys)).symm
  | .var, _, _, _, _, _ => rfl
  | .sum T₀ T₁, _, _, _, f, g => by
      show sumMapTok (T₀.map (g.comp f)) (T₁.map (g.comp f))
          = (sumMapTok (T₀.map g) (T₁.map g)).comp (sumMapTok (T₀.map f) (T₁.map f))
      rw [T₀.map_comp f g, T₁.map_comp f g, sumMapTok_comp]
  | .prod T₀ T₁, _, _, _, f, g => by
      show prodMapTok (T₀.map (g.comp f)) (T₁.map (g.comp f))
          = (prodMapTok (T₀.map g) (T₁.map g)).comp (prodMapTok (T₀.map f) (T₁.map f))
      rw [T₀.map_comp f g, T₁.map_comp f g, prodMapTok_comp]

/-! ## Continuous on maps — the monotone half

Scott's *continuous on maps* (Definition 6.8) requires `λf. T(f)` to be approximable on the strict
function space; here we record its **monotonicity** (the order half of approximability — a sharper map
yields a sharper image), proved compositionally from the bifunctor combinators. -/

/-- `sumMapTok` is monotone in both arguments. -/
theorem sumMapTok_mono {f₀ f₀' : ApproximableMap A₀.sys B₀.sys}
    {f₁ f₁' : ApproximableMap A₁.sys B₁.sys} (h0 : f₀ ≤ f₀') (h1 : f₁ ≤ f₁') :
    sumMapTok f₀ f₁ ≤ sumMapTok f₀' f₁' := by
  rw [ApproximableMap.le_iff]
  rintro W W' (⟨hW, rfl⟩ | ⟨X, X', hrel, rfl, rfl⟩ | ⟨Y, Y', hrel, rfl, rfl⟩)
  · exact Or.inl ⟨hW, rfl⟩
  · exact Or.inr (Or.inl ⟨X, X', h0 X X' hrel, rfl, rfl⟩)
  · exact Or.inr (Or.inr ⟨Y, Y', h1 Y Y' hrel, rfl, rfl⟩)

/-- `prodMapTok` is monotone in both arguments. -/
theorem prodMapTok_mono {f₀ f₀' : ApproximableMap A₀.sys B₀.sys}
    {f₁ f₁' : ApproximableMap A₁.sys B₁.sys} (h0 : f₀ ≤ f₀') (h1 : f₁ ≤ f₁') :
    prodMapTok f₀ f₁ ≤ prodMapTok f₀' f₁' := by
  rw [ApproximableMap.le_iff]
  rintro W W' ⟨X, Y, X', Y', hr0, hr1, rfl, rfl⟩
  exact ⟨X, Y, X', Y', h0 X X' hr0, h1 Y Y' hr1, rfl, rfl⟩

/-- **`λf. T(f)` is monotone.** A sharper map `f ≤ f'` is sent to a sharper image `T(f) ≤ T(f')` —
the monotonicity half of *continuous on maps*. -/
theorem FExpr.map_mono : (T : FExpr) → {X Y : ScottSys} → {f f' : ApproximableMap X.sys Y.sys} →
    f ≤ f' → T.map f ≤ T.map f'
  | .const _, _, _, _, _, _ => le_rfl
  | .var, _, _, _, _, h => h
  | .sum T₀ T₁, _, _, _, _, h => sumMapTok_mono (T₀.map_mono h) (T₁.map_mono h)
  | .prod T₀ T₁, _, _, _, _, h => prodMapTok_mono (T₀.map_mono h) (T₁.map_mono h)

/-! ## Monotone on domains

Scott's *monotone on domains* (Definition 6.13): a subdomain relation `D ◁ E` is carried to
`T(D) ◁ T(E)`. Because every construct here stays over the single token type `{0,1}*`, the relation is
between systems on a common carrier (no transport needed), and the bifunctor combinators carry `◁`
componentwise. -/

/-- The sum carries the subsystem relation componentwise: `𝒟₀ ◁ ℰ₀` and `𝒟₁ ◁ ℰ₁` give
`𝒟₀+𝒟₁ ◁ ℰ₀+ℰ₁`. -/
theorem sumTok_subsystem (h0 : A₀.sys ◁ B₀.sys) (h1 : A₁.sys ◁ B₁.sys) :
    (A₀.sum A₁).sys ◁ (B₀.sum B₁).sys := by
  have heqm : sumTokMaster A₀.sys A₁.sys = sumTokMaster B₀.sys B₁.sys := by
    unfold sumTokMaster; rw [h0.master_eq, h1.master_eq]
  refine ⟨heqm, ?_, ?_⟩
  · rintro W (rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩)
    · exact Or.inl heqm
    · exact Or.inr (Or.inl ⟨X, h0.sub hX, rfl⟩)
    · exact Or.inr (Or.inr ⟨Y, h1.sub hY, rfl⟩)
  · rintro W W' (rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩) (rfl | ⟨X', hX', rfl⟩ | ⟨Y', hY', rfl⟩) hInt
    · rw [Set.inter_self]; exact Or.inl rfl
    · rw [sumTokMaster_inter_embF hX']; exact Or.inr (Or.inl ⟨X', hX', rfl⟩)
    · rw [sumTokMaster_inter_embT hY']; exact Or.inr (Or.inr ⟨Y', hY', rfl⟩)
    · rw [Set.inter_comm, sumTokMaster_inter_embF hX]; exact Or.inr (Or.inl ⟨X, hX, rfl⟩)
    · rw [embBit_inter] at hInt ⊢
      exact Or.inr (Or.inl ⟨X ∩ X',
        h0.inter_closed hX hX' (sumTok_mem_embF_inv (h₀ := B₀.ne) (h₁ := B₁.ne) hInt), rfl⟩)
    · rw [embBit_inter_ne (show (false : Bool) ≠ true by decide)] at hInt
      exact absurd ((B₀.sum B₁).ne _ hInt) Set.not_nonempty_empty
    · rw [Set.inter_comm, sumTokMaster_inter_embT hY]; exact Or.inr (Or.inr ⟨Y, hY, rfl⟩)
    · rw [embBit_inter_ne (show (true : Bool) ≠ false by decide)] at hInt
      exact absurd ((B₀.sum B₁).ne _ hInt) Set.not_nonempty_empty
    · rw [embBit_inter] at hInt ⊢
      exact Or.inr (Or.inr ⟨Y ∩ Y',
        h1.inter_closed hY hY' (sumTok_mem_embT_inv (h₀ := B₀.ne) (h₁ := B₁.ne) hInt), rfl⟩)

/-- The product carries the subsystem relation componentwise. -/
theorem prodTok_subsystem (h0 : A₀.sys ◁ B₀.sys) (h1 : A₁.sys ◁ B₁.sys) :
    (A₀.prod A₁).sys ◁ (B₀.prod B₁).sys := by
  have heqm : prodTokNbhd A₀.sys.master A₁.sys.master
      = prodTokNbhd B₀.sys.master B₁.sys.master := by rw [h0.master_eq, h1.master_eq]
  refine ⟨heqm, ?_, ?_⟩
  · rintro W ⟨X, Y, hX, hY, rfl⟩
    exact ⟨X, Y, h0.sub hX, h1.sub hY, rfl⟩
  · rintro W W' ⟨X, Y, hX, hY, rfl⟩ ⟨X', Y', hX', hY', rfl⟩ hInt
    rw [prodTokNbhd_inter] at hInt ⊢
    obtain ⟨X'', Y'', hX'', hY'', heq⟩ := hInt
    obtain ⟨rfl, rfl⟩ := prodTokNbhd_injective heq
    exact ⟨X ∩ X', Y ∩ Y', h0.inter_closed hX hX' hX'', h1.inter_closed hY hY' hY'', rfl⟩

/-- **`λX. T(X)` is monotone on domains.** Whenever `X ◁ Y` we have `T(X) ◁ T(Y)`. -/
theorem FExpr.obj_subsystem : (T : FExpr) → {X Y : ScottSys} → X.sys ◁ Y.sys →
    (T.obj X).sys ◁ (T.obj Y).sys
  | .const D, _, _, _ => Subsystem.refl D.sys
  | .var, _, _, h => h
  | .sum T₀ T₁, _, _, h => sumTok_subsystem (T₀.obj_subsystem h) (T₁.obj_subsystem h)
  | .prod T₀ T₁, _, _, h => prodTok_subsystem (T₀.obj_subsystem h) (T₁.obj_subsystem h)

/-! ## Continuous on domains

Scott's *continuous on domains* (Definition 6.13): `λD. T(D)` preserves directed unions of
subsystems. Concretely, if `U` is the union of a non-empty `◁`-directed family `ℱ` of subsystems of
`U`, then every neighbourhood of `T(U)` already appears in some `T(D)` with `D ∈ ℱ` (and conversely).
The forward direction is by induction; the products use directedness to merge the two component
witnesses into a single `D`. -/

/-- Forward direction of continuity on domains: a neighbourhood of `T(U)` is a neighbourhood of some
`T(D)` with `D ∈ ℱ`. -/
theorem FExpr.obj_continuous_mp : (T : FExpr) → {ℱ : Set ScottSys} → {U : ScottSys} →
    DirectedOn (fun a b => a.sys ◁ b.sys) ℱ → ℱ.Nonempty →
    (∀ D ∈ ℱ, D.sys ◁ U.sys) → (∀ X, U.sys.mem X ↔ ∃ D ∈ ℱ, D.sys.mem X) →
    {W : Set Str} → (T.obj U).sys.mem W → ∃ D ∈ ℱ, (T.obj D).sys.mem W
  | .const _, _, _, _, hne, _, _, _, hmem => by
      obtain ⟨D, hD⟩ := hne; exact ⟨D, hD, hmem⟩
  | .var, _, _, _, _, _, hU, W, hmem => (hU W).mp hmem
  | .sum T₀ T₁, _, _, hdir, hne, hsub, hU, _, hmem => by
      rcases hmem with rfl | ⟨X, hX, rfl⟩ | ⟨Y, hY, rfl⟩
      · obtain ⟨D, hD⟩ := hne
        exact ⟨D, hD, Or.inl ((FExpr.sum T₀ T₁).obj_subsystem (hsub D hD)).master_eq.symm⟩
      · obtain ⟨D, hD, hXD⟩ := T₀.obj_continuous_mp hdir hne hsub hU hX
        exact ⟨D, hD, Or.inr (Or.inl ⟨X, hXD, rfl⟩)⟩
      · obtain ⟨D, hD, hYD⟩ := T₁.obj_continuous_mp hdir hne hsub hU hY
        exact ⟨D, hD, Or.inr (Or.inr ⟨Y, hYD, rfl⟩)⟩
  | .prod T₀ T₁, _, _, hdir, hne, hsub, hU, _, hmem => by
      obtain ⟨X, Y, hX, hY, rfl⟩ := hmem
      obtain ⟨D₁, hD₁, hXD⟩ := T₀.obj_continuous_mp hdir hne hsub hU hX
      obtain ⟨D₂, hD₂, hYD⟩ := T₁.obj_continuous_mp hdir hne hsub hU hY
      obtain ⟨D₃, hD₃, hr1, hr2⟩ := hdir D₁ hD₁ D₂ hD₂
      exact ⟨D₃, hD₃, X, Y, (T₀.obj_subsystem hr1).sub hXD, (T₁.obj_subsystem hr2).sub hYD, rfl⟩

/-- **`λD. T(D)` is continuous on domains.** For a non-empty `◁`-directed family `ℱ` of subsystems of
`U` whose union is `U`, the neighbourhood family of `T(U)` is the union of those of the `T(D)`. -/
theorem FExpr.obj_continuous (T : FExpr) {ℱ : Set ScottSys} {U : ScottSys}
    (hdir : DirectedOn (fun a b => a.sys ◁ b.sys) ℱ) (hne : ℱ.Nonempty)
    (hsub : ∀ D ∈ ℱ, D.sys ◁ U.sys) (hU : ∀ X, U.sys.mem X ↔ ∃ D ∈ ℱ, D.sys.mem X)
    (W : Set Str) : (T.obj U).sys.mem W ↔ ∃ D ∈ ℱ, (T.obj D).sys.mem W := by
  refine ⟨T.obj_continuous_mp hdir hne hsub hU, ?_⟩
  rintro ⟨D, hD, hmem⟩
  exact (T.obj_subsystem (hsub D hD)).sub hmem

/-! ## Continuous on maps — full directed-sup preservation

Scott's *continuous on maps* (Definition 6.8): `λf. T(f)` is approximable, equivalently (Exercise
2.13) it is continuous — monotone (`map_mono`) and preserving directed unions of maps. If `f` is the
pointwise union of a non-empty directed family `gᵢ`, then `T(f)` is the pointwise union of the
`T(gᵢ)`. The products use directedness to merge the two component witnesses. -/

/-- Forward direction of continuity on maps: a related pair of `T(f)` is already related by some
`T(gᵢ)`. -/
theorem FExpr.map_continuous_mp : (T : FExpr) → {I : Type} → {X Y : ScottSys} →
    {g : I → ApproximableMap X.sys Y.sys} → {f : ApproximableMap X.sys Y.sys} →
    [Nonempty I] → (∀ i j, ∃ k, g i ≤ g k ∧ g j ≤ g k) →
    (∀ A B, f.rel A B ↔ ∃ i, (g i).rel A B) →
    {A B : Set Str} → (T.map f).rel A B → ∃ i, (T.map (g i)).rel A B
  | .const _, _, _, _, _, _, _, _, _, _, _, hrel => by
      obtain ⟨i⟩ := ‹Nonempty _›; exact ⟨i, hrel⟩
  | .var, _, _, _, _, _, _, _, hf, A, B, hrel => (hf A B).mp hrel
  | .sum T₀ T₁, _, _, _, _, _, _, hdir, hf, _, _, hrel => by
      rcases hrel with ⟨hA, rfl⟩ | ⟨P, P', hr, rfl, rfl⟩ | ⟨Q, Q', hr, rfl, rfl⟩
      · obtain ⟨i⟩ := ‹Nonempty _›; exact ⟨i, Or.inl ⟨hA, rfl⟩⟩
      · obtain ⟨i, hi⟩ := T₀.map_continuous_mp hdir hf hr
        exact ⟨i, Or.inr (Or.inl ⟨P, P', hi, rfl, rfl⟩)⟩
      · obtain ⟨i, hi⟩ := T₁.map_continuous_mp hdir hf hr
        exact ⟨i, Or.inr (Or.inr ⟨Q, Q', hi, rfl, rfl⟩)⟩
  | .prod T₀ T₁, _, _, _, _, _, _, hdir, hf, _, _, hrel => by
      obtain ⟨P, Q, P', Q', hr0, hr1, rfl, rfl⟩ := hrel
      obtain ⟨i, hi⟩ := T₀.map_continuous_mp hdir hf hr0
      obtain ⟨j, hj⟩ := T₁.map_continuous_mp hdir hf hr1
      obtain ⟨k, hik, hjk⟩ := hdir i j
      exact ⟨k, P, Q, P', Q', (T₀.map_mono hik) P P' hi, (T₁.map_mono hjk) Q Q' hj, rfl, rfl⟩

/-- **`λf. T(f)` is continuous on maps.** For a non-empty directed family `gᵢ` with pointwise union
`f`, the relation of `T(f)` is the union of those of the `T(gᵢ)` — `T(f)` is approximable. -/
theorem FExpr.map_continuous (T : FExpr) {I : Type} [Nonempty I] {X Y : ScottSys}
    (g : I → ApproximableMap X.sys Y.sys) (f : ApproximableMap X.sys Y.sys)
    (hdir : ∀ i j, ∃ k, g i ≤ g k ∧ g j ≤ g k)
    (hf : ∀ A B, f.rel A B ↔ ∃ i, (g i).rel A B) (A B : Set Str) :
    (T.map f).rel A B ↔ ∃ i, (T.map (g i)).rel A B := by
  refine ⟨T.map_continuous_mp hdir hf, ?_⟩
  rintro ⟨i, hi⟩
  have hgif : g i ≤ f := by
    rw [ApproximableMap.le_iff]; intro A' B' h; exact (hf A' B').mpr ⟨i, h⟩
  exact (T.map_mono hgif) A B hi

end Exercise619

end Domain.Neighborhood
