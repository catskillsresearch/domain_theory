import Domain.Neighborhood.Definition613
import Domain.Neighborhood.Theorem69
import Domain.Neighborhood.ApproximableExercises

/-!
# Lecture VI — Theorem 6.14 (Scott 1981, PRG-19): existence of initial `T`-algebras

> **THEOREM 6.14.** If the functor `T` is continuous on maps and monotone and continuous on domains,
> and if there is a set `Γ` such that `{Γ} ◁ T({Γ})`, then there exists an initial `T`-algebra.

Scott's proof iterates the functor from the generating system `{Γ}`. The assumption
`{Γ} ◁ T({Γ})` means `T({Γ})` is a system over the same token set `Γ`; iterating, every
`Tⁿ({Γ})` is over `Γ` and `Tⁿ({Γ}) ◁ Tⁿ⁺¹({Γ})`. The colimit

`𝒟 = ⋃ₙ Tⁿ({Γ})`

is then a system over `Γ` with `Tⁿ({Γ}) ◁ 𝒟`, whence `𝒟 ◁ T(𝒟)`, and *continuity on domains*
gives `T(𝒟) = 𝒟` — the isomorphism `𝒟 ≅ T(𝒟)` is the **identity**. So `𝒟` is a `T`-algebra, and:

* **existence** of homomorphisms out of `𝒟` is Theorem 6.9 (`nonempty_algHom_of_continuousOnMaps`);
* **uniqueness** is the `ρₙ = iₙ ∘ jₙ` projection-chain argument: `T(ρₙ) = ρₙ₊₁` (monotone on
  domains), `⋃ₙ ρₙ = I_𝒟`, and any homomorphism `h` is `⋃ₙ h∘ρₙ`, the least fixed point of
  `λh. k ∘ T(h)`.

## The carrier-type subtlety

The abstract `T : Endofunctor DomainObj` need not preserve token types, so `Tⁿ({Γ})` a priori live
over different carriers. The hypothesis `{Γ} ◁ T({Γ})` already pins `T({Γ})` to `Γ`'s carrier, and
*monotone on domains* (Definition 6.13, `MonotoneAt.carrier_eq`) propagates the identification up the
tower. We carry the carrier equalities explicitly and transport along them; the transport of the
subdomain relation is the choice-free `subsystem_cast`.
-/

namespace Domain.Neighborhood

open NeighborhoodSystem ApproximableMap Domain.Neighborhood.Exercise510

universe w

namespace Theorem614

/-! ### Carrier-transport helpers -/

variable {α : Type w}

/-- Transport a subsystem relation `D ◁ E` along a carrier-type equality `β = α`. Choice-free. -/
theorem subsystem_cast {β : Type w} (e : β = α) {D E : NeighborhoodSystem β} (h : D ◁ E) :
    (e ▸ D : NeighborhoodSystem α) ◁ (e ▸ E : NeighborhoodSystem α) := by
  cases e; exact h

/-- Transport composition for neighbourhood systems: `e' ▸ (e ▸ x) = (e.trans e') ▸ x`. -/
theorem rec_trans {β γ : Type w} (e : β = γ) (e' : γ = α) (x : NeighborhoodSystem β) :
    (e' ▸ (e ▸ x : NeighborhoodSystem γ) : NeighborhoodSystem α) = (e.trans e') ▸ x := by
  cases e; cases e'; rfl

/-- Membership in a transported system: `(e ▸ V).mem X ↔ V.mem (e.symm ▸ X)`. -/
theorem mem_cast {β : Type w} (e : β = α) (V : NeighborhoodSystem β) (X : Set α) :
    (e ▸ V : NeighborhoodSystem α).mem X ↔ V.mem (e.symm ▸ X : Set β) := by
  cases e; rfl

/-- Transport composition for sets: `e' ▸ (e ▸ X) = (e.trans e') ▸ X`. -/
theorem set_rec_trans {β γ : Type w} (e : β = γ) (e' : γ = α) (X : Set β) :
    (e' ▸ (e ▸ X : Set γ) : Set α) = (e.trans e') ▸ X := by
  cases e; cases e'; rfl

/-! ### The setup bundle (hypotheses of Theorem 6.14) -/

/-- The hypotheses of Theorem 6.14, bundled: a functor `T` that is continuous on maps, monotone and
continuous on domains, together with a generating system `Γ` over a token type `Tok` such that
`{Γ} ◁ T({Γ})` (the carrier of `T({Γ})` is identified with `Tok` by `ceq`, and `hsub` is Scott's
`{Γ} ◁ T({Γ})`). -/
structure Setup where
  /-- The functor. -/
  T : Endofunctor DomainObj.{w}
  /-- `T` is continuous on maps (Definition 6.8). -/
  hmaps : ContinuousOnMaps T
  /-- `T` is monotone on domains (Definition 6.13). -/
  hmono : MonotoneOnDomains T
  /-- `T` is continuous on domains (Definition 6.13). -/
  hcont : ContinuousOnDomains T
  /-- The token type of the generating system. -/
  {Tok : Type w}
  /-- The generating system `{Γ}`. -/
  Γ : NeighborhoodSystem Tok
  /-- `T({Γ})` is a system over the same token type. -/
  ceq : (T.obj ⟨Tok, Γ⟩).carrier = Tok
  /-- Scott's hypothesis `{Γ} ◁ T({Γ})`. -/
  hsub : Γ ◁ (ceq ▸ (T.obj ⟨Tok, Γ⟩).sys : NeighborhoodSystem Tok)

/-! ### The iterated functor tower `Tⁿ({Γ})` -/

/-- The iterated tower, as data: at level `n`, the system `Tⁿ({Γ})` over `Tok`, the carrier
identification `(T.obj Tⁿ({Γ})).carrier = Tok`, and the subdomain relation `Tⁿ({Γ}) ◁ Tⁿ⁺¹({Γ})`
(where `Tⁿ⁺¹({Γ})` is the carrier-transport of `T(Tⁿ({Γ}))`). The successor step uses
*monotone on domains* (`MonotoneAt`) to obtain the next carrier identification and subdomain
relation. Choice-free. -/
def iter (s : Setup.{w}) : (n : ℕ) →
    Σ' (S : NeighborhoodSystem s.Tok), Σ' (ceq : (s.T.obj ⟨s.Tok, S⟩).carrier = s.Tok),
      S ◁ (ceq ▸ (s.T.obj ⟨s.Tok, S⟩).sys : NeighborhoodSystem s.Tok)
  | 0 => ⟨s.Γ, s.ceq, s.hsub⟩
  | (n + 1) =>
      let p := iter s n
      ⟨p.2.1 ▸ (s.T.obj ⟨s.Tok, p.1⟩).sys,
        (s.hmono p.2.2).carrier_eq.trans p.2.1,
        by
          have hsub := subsystem_cast p.2.1 (s.hmono p.2.2).sub
          rwa [rec_trans] at hsub⟩

/-- `Tⁿ({Γ})`, the `n`-th system in the tower (over `Tok`). -/
def Dsys (s : Setup.{w}) (n : ℕ) : NeighborhoodSystem s.Tok := (iter s n).1

/-- The carrier identification `(T.obj Tⁿ({Γ})).carrier = Tok`. -/
def Dceq (s : Setup.{w}) (n : ℕ) : (s.T.obj ⟨s.Tok, Dsys s n⟩).carrier = s.Tok := (iter s n).2.1

/-- `Tⁿ⁺¹({Γ})` is the carrier-transport of `T(Tⁿ({Γ}))`. -/
theorem Dsys_succ (s : Setup.{w}) (n : ℕ) :
    Dsys s (n + 1) = (Dceq s n ▸ (s.T.obj ⟨s.Tok, Dsys s n⟩).sys : NeighborhoodSystem s.Tok) :=
  rfl

/-- The basic subdomain step `Tⁿ({Γ}) ◁ Tⁿ⁺¹({Γ})`. -/
def Dchain (s : Setup.{w}) (n : ℕ) : Dsys s n ◁ Dsys s (n + 1) := (iter s n).2.2

/-- Every system in the tower has the same master `Δ = Γ`. -/
theorem Dsys_master (s : Setup.{w}) (n : ℕ) : (Dsys s n).master = s.Γ.master := by
  induction n with
  | zero => rfl
  | succ k ih => rw [← (Dchain s k).master_eq]; exact ih

/-- The tower is a `◁`-chain: `Tⁿ({Γ}) ◁ Tᵐ({Γ})` whenever `n ≤ m`. -/
theorem chain_le (s : Setup.{w}) {n m : ℕ} (h : n ≤ m) : Dsys s n ◁ Dsys s m := by
  induction h with
  | refl => exact Subsystem.refl _
  | step _ ih => exact ih.trans (Dchain s _)

/-! ### The colimit `𝒟 = ⋃ₙ Tⁿ({Γ})` -/

/-- **The colimit `𝒟 = ⋃ₙ Tⁿ({Γ})`** as a neighbourhood system over `Tok`: a set is a neighbourhood
of `𝒟` exactly when it is a neighbourhood of some `Tⁿ({Γ})`. Closure under consistent intersection
uses that the tower is a chain (`chain_le`): any finite collection of neighbourhoods sits inside one
level `Tᴺ({Γ})`, whose own `inter_mem` finishes the job. -/
def colim (s : Setup.{w}) : NeighborhoodSystem s.Tok where
  mem X := ∃ n, (Dsys s n).mem X
  master := s.Γ.master
  master_mem := ⟨0, s.Γ.master_mem⟩
  inter_mem := by
    rintro X Y Z ⟨n, hX⟩ ⟨m, hY⟩ ⟨p, hZ⟩ hsub
    set N := max n (max m p) with hN
    have hXN : (Dsys s N).mem X := (chain_le s (le_max_left n _)).sub hX
    have hYN : (Dsys s N).mem Y :=
      (chain_le s ((le_max_left m p).trans (le_max_right n _))).sub hY
    have hZN : (Dsys s N).mem Z :=
      (chain_le s ((le_max_right m p).trans (le_max_right n _))).sub hZ
    exact ⟨N, (Dsys s N).inter_mem hXN hYN hZN hsub⟩
  sub_master := by
    rintro X ⟨n, hX⟩
    rw [← Dsys_master s n]
    exact (Dsys s n).sub_master hX

@[simp] theorem mem_colim (s : Setup.{w}) {X : Set s.Tok} :
    (colim s).mem X ↔ ∃ n, (Dsys s n).mem X := Iff.rfl

@[simp] theorem colim_master (s : Setup.{w}) : (colim s).master = s.Γ.master := rfl

/-- Each level of the tower is a subdomain of the colimit: `Tⁿ({Γ}) ◁ 𝒟`. -/
theorem Dsys_sub_colim (s : Setup.{w}) (n : ℕ) : Dsys s n ◁ colim s where
  master_eq := by rw [colim_master, Dsys_master]
  sub hX := ⟨n, hX⟩
  inter_closed := by
    rintro X Y hX hY ⟨m, hXY⟩
    have hN : (Dsys s (max n m)).mem (X ∩ Y) := by
      have hle : (Dsys s m) ◁ (Dsys s (max n m)) := chain_le s (le_max_right n m)
      exact hle.sub hXY
    -- pull `X ∩ Y` back into `Tⁿ({Γ})` using consistency-in-the-bigger-level
    exact (chain_le s (le_max_left n m)).inter_closed hX hY hN

/-! ### `T(𝒟)` and the relation `𝒟 ◁ T(𝒟)` -/

/-- The carrier identification `(T.obj 𝒟).carrier = Tok`, from `MonotoneAt` of `T⁰({Γ}) ◁ 𝒟`. -/
def colimCeq (s : Setup.{w}) : (s.T.obj ⟨s.Tok, colim s⟩).carrier = s.Tok :=
  (s.hmono (Dsys_sub_colim s 0)).carrier_eq.trans (Dceq s 0)

/-- `T(𝒟)`, the image of the colimit, as a system over `Tok` (via `colimCeq`). -/
def Tcolim (s : Setup.{w}) : NeighborhoodSystem s.Tok :=
  colimCeq s ▸ (s.T.obj ⟨s.Tok, colim s⟩).sys

/-- `Tⁿ⁺¹({Γ}) ◁ T(𝒟)`: applying *monotone on domains* to `Tⁿ({Γ}) ◁ 𝒟` and transporting. -/
theorem Dsys_sub_Tcolim (s : Setup.{w}) (n : ℕ) : Dsys s (n + 1) ◁ Tcolim s := by
  have h := subsystem_cast (Dceq s n) (s.hmono (Dsys_sub_colim s n)).sub
  rw [rec_trans] at h
  exact h

/-- `T(𝒟)` and `𝒟` share the master `Δ = Γ`. -/
theorem Tcolim_master (s : Setup.{w}) : (Tcolim s).master = s.Γ.master := by
  rw [← (Dsys_sub_Tcolim s 0).master_eq, Dsys_master]

/-- The easy half of `T(𝒟) = 𝒟`: every neighbourhood of `𝒟` is a neighbourhood of `T(𝒟)`
(`𝒟 ⊆ T(𝒟)`), since `Tⁿ({Γ}) ◁ Tⁿ⁺¹({Γ}) ◁ T(𝒟)`. -/
theorem colim_sub_Tcolim (s : Setup.{w}) {X : Set s.Tok} (hX : (colim s).mem X) :
    (Tcolim s).mem X := by
  obtain ⟨n, hn⟩ := hX
  exact (Dsys_sub_Tcolim s n).sub ((Dchain s n).sub hn)

/-- **The continuity step (the hard half of `T(𝒟) = 𝒟`).** Every neighbourhood of `T(𝒟)` is a
neighbourhood of `𝒟`. This is exactly Scott's `T(𝒟) = T(⋃ₙ Tⁿ({Γ})) = ⋃ₙ Tⁿ⁺¹({Γ}) = 𝒟`,
obtained from *continuity on domains* applied to the directed family `{Tⁿ({Γ})}`. -/
theorem Tcolim_sub_colim (s : Setup.{w}) {X : Set s.Tok} (hX : (Tcolim s).mem X) :
    (colim s).mem X := by
  obtain ⟨hmono', hC⟩ := s.hcont
  set ℱ : Set (NeighborhoodSystem s.Tok) := Set.range (Dsys s) with hℱdef
  have hℱ : ∀ ⦃D⦄, D ∈ ℱ → D ◁ colim s := by rintro D ⟨n, rfl⟩; exact Dsys_sub_colim s n
  have hne : ℱ.Nonempty := ⟨Dsys s 0, ⟨0, rfl⟩⟩
  have hdir : DirectedOn (· ◁ ·) ℱ := by
    rintro _ ⟨n, rfl⟩ _ ⟨m, rfl⟩
    exact ⟨Dsys s (max n m), ⟨max n m, rfl⟩,
      chain_le s (le_max_left n m), chain_le s (le_max_right n m)⟩
  have hU : ∀ Y, (colim s).mem Y ↔ ∃ D ∈ ℱ, D.mem Y := by
    intro Y; constructor
    · rintro ⟨n, hn⟩; exact ⟨Dsys s n, ⟨n, rfl⟩, hn⟩
    · rintro ⟨D, ⟨n, rfl⟩, hn⟩; exact ⟨n, hn⟩
  have heq := hC ℱ hℱ hne hdir (Subsystem.refl (colim s)) hU
  set Y₀ : Set (s.T.obj ⟨s.Tok, colim s⟩).carrier := (colimCeq s).symm ▸ X with hY₀
  -- `X ∈ T(𝒟)` says `Y₀ ∈ targetFam (refl 𝒟)` = the neighbourhood family of `T(𝒟)`.
  have hmem : Y₀ ∈ targetFam s.T hmono' (Subsystem.refl (colim s)) :=
    (mem_cast (colimCeq s) _ X).mp hX
  rw [heq, Set.mem_iUnion] at hmem
  obtain ⟨D, hmem⟩ := hmem
  rw [Set.mem_iUnion] at hmem
  obtain ⟨hD, hmemD⟩ := hmem
  obtain ⟨n, rfl⟩ := hD
  simp only [targetFam, Set.mem_setOf_eq] at hmemD
  -- conclude `X ∈ Tⁿ⁺¹({Γ}) ⊆ 𝒟`.
  refine ⟨n + 1, ?_⟩
  rw [Dsys_succ s n, mem_cast (Dceq s n)]
  have key : ((Dceq s n).symm ▸ X : Set (s.T.obj ⟨s.Tok, Dsys s n⟩).carrier)
      = (s.hmono (hℱ ⟨n, rfl⟩)).carrier_eq ▸ Y₀ := by
    rw [hY₀, set_rec_trans]
  rw [key]
  exact hmemD

/-- **`T(𝒟) = 𝒟`** (Scott's `𝒟 = T(𝒟)`): the two systems have the same neighbourhoods (mutual
inclusion via `colim_sub_Tcolim`/`Tcolim_sub_colim`) and the same master. -/
theorem Tcolim_eq_colim (s : Setup.{w}) : Tcolim s = colim s :=
  NeighborhoodSystem.ext
    (fun _ => ⟨fun h => Tcolim_sub_colim s h, fun h => colim_sub_Tcolim s h⟩)
    (by rw [Tcolim_master, colim_master])

/-! ### `𝒟` is a `T`-algebra: the iso `𝒟 ≅ T(𝒟)` is the identity -/

/-- A `DomainObj` equality from a carrier equality and a transported-system equality. -/
theorem domainObj_ext {c : Type w} (σ : NeighborhoodSystem c) (e : c = α)
    {V : NeighborhoodSystem α} (h : (e ▸ σ : NeighborhoodSystem α) = V) :
    (⟨c, σ⟩ : DomainObj) = ⟨α, V⟩ := by
  cases e; cases h; rfl

/-- The identity isomorphism induced by an object equality in any category. -/
def isoOfEq {Obj : Type*} [Category Obj] {X Y : Obj} (h : X = Y) : Iso X Y := by
  cases h
  exact ⟨Category.id X, Category.id X, Category.id_comp _, Category.id_comp _⟩

/-- **`T(𝒟) ≅ 𝒟` is the identity**, packaged as a `DomainObj` equality `T(𝒟) = 𝒟`. -/
theorem colimObj_eq (s : Setup.{w}) :
    s.T.obj ⟨s.Tok, colim s⟩ = (⟨s.Tok, colim s⟩ : DomainObj) :=
  domainObj_ext (s.T.obj ⟨s.Tok, colim s⟩).sys (colimCeq s) (Tcolim_eq_colim s)

/-- The isomorphism `T(𝒟) ≅ 𝒟` making `𝒟` a `T`-algebra (the identity, since `T(𝒟) = 𝒟`). -/
def colimIso (s : Setup.{w}) : Iso (s.T.obj ⟨s.Tok, colim s⟩) (⟨s.Tok, colim s⟩ : DomainObj) :=
  isoOfEq (colimObj_eq s)

/-- The colimit `𝒟` as a `T`-algebra, with structure map the iso `T(𝒟) → 𝒟`. -/
def colimAlg (s : Setup.{w}) : TAlgebra s.T :=
  ⟨⟨s.Tok, colim s⟩, (colimIso s).hom⟩

/-! ### Existence of homomorphisms (Theorem 6.9) -/

/-- **Existence (Theorem 6.9 applied to `𝒟 ≅ T(𝒟)`).** For any `T`-algebra `B` with a strict
structure map, there is a homomorphism `𝒟 → B`. -/
theorem nonempty_algHom (s : Setup.{w}) (B : TAlgebra s.T) (hk : IsStrict B.str) :
    Nonempty (AlgHom (colimAlg s) B) :=
  nonempty_algHom_of_continuousOnMaps s.T s.hmaps (colimIso s) B hk

/-! ### The projection chain `ρₙ = iₙ ∘ jₙ` and `⋃ₙ ρₙ = I_𝒟` -/

/-- `ρₙ = iₙ ∘ jₙ : 𝒟 → 𝒟`, the retraction onto `Tⁿ({Γ})` (Proposition 6.12's projection pair for
`Tⁿ({Γ}) ◁ 𝒟`). -/
def rho (s : Setup.{w}) (n : ℕ) : ApproximableMap (colim s) (colim s) :=
  (Dsys_sub_colim s n).inj.comp (Dsys_sub_colim s n).proj

/-- Scott's relational description `X ρₙ Y ↔ ∃ z ∈ Tⁿ({Γ}), X ⊆ z ⊆ Y`. -/
theorem rho_rel (s : Setup.{w}) (n : ℕ) {X Y : Set s.Tok} :
    (rho s n).rel X Y ↔
      (colim s).mem X ∧ (colim s).mem Y ∧ ∃ z, (Dsys s n).mem z ∧ X ⊆ z ∧ z ⊆ Y := by
  unfold rho
  rw [comp_rel]
  constructor
  · rintro ⟨z, ⟨hcX, hDz, hXz⟩, _, hcY, hzY⟩
    exact ⟨hcX, hcY, z, hDz, hXz, hzY⟩
  · rintro ⟨hcX, hcY, z, hDz, hXz, hzY⟩
    exact ⟨z, ⟨hcX, hDz, hXz⟩, hDz, hcY, hzY⟩

/-- `ρₙ ⊆ ρₘ` for `n ≤ m` (the projection chain is increasing). -/
theorem rho_mono (s : Setup.{w}) {n m : ℕ} (h : n ≤ m) {X Y : Set s.Tok}
    (hr : (rho s n).rel X Y) : (rho s m).rel X Y := by
  rw [rho_rel] at hr ⊢
  obtain ⟨hcX, hcY, z, hDz, hXz, hzY⟩ := hr
  exact ⟨hcX, hcY, z, (chain_le s h).sub hDz, hXz, hzY⟩

/-- The pointwise union `⋃ₙ ρₙ` (directed, since the chain is increasing). -/
def iSupRho (s : Setup.{w}) : ApproximableMap (colim s) (colim s) :=
  iSupMap (rho s) (fun i j => ⟨max i j,
    fun _ _ h => rho_mono s (le_max_left i j) h,
    fun _ _ h => rho_mono s (le_max_right i j) h⟩)

/-- **`⋃ₙ ρₙ = I_𝒟`** (Scott's key identity for uniqueness). The forward inclusion uses
`X ⊆ z ⊆ Y ⟹ X ⊆ Y`; the reverse factors the identity step `X ⊆ X ⊆ Y` through the level
witnessing `X ∈ 𝒟`. -/
theorem iSupRho_eq_id (s : Setup.{w}) : iSupRho s = idMap (colim s) := by
  apply ApproximableMap.ext
  intro X Y
  rw [idMap_rel]
  constructor
  · rintro ⟨n, hr⟩
    rw [rho_rel] at hr
    obtain ⟨hcX, hcY, z, _, hXz, hzY⟩ := hr
    exact ⟨hcX, hcY, hXz.trans hzY⟩
  · rintro ⟨hcX, hcY, hXY⟩
    obtain ⟨n, hX⟩ := hcX
    exact ⟨n, (rho_rel s n).mpr ⟨⟨n, hX⟩, hcY, X, hX, subset_rfl, hXY⟩⟩

/-! ### Theorem 6.14 — the existence half (the canonical solution and its homomorphisms) -/

/-- **Theorem 6.14 (Scott 1981, PRG-19) — the canonical fixed point.** Under the hypotheses
(continuous on maps, monotone and continuous on domains, with a generating set `{Γ} ◁ T({Γ})`), the
iterated colimit `𝒟 = ⋃ₙ Tⁿ({Γ})` is a `T`-algebra whose structure map is an isomorphism
`T(𝒟) ≅ 𝒟` (the identity, since `T(𝒟) = 𝒟`), and there is a homomorphism from `𝒟` into every
`T`-algebra with a strict structure map (Theorem 6.9). This is Scott's *existence* of the initial
`T`-algebra. -/
theorem exists_algebra_with_hom (s : Setup.{w}) :
    ∃ A : TAlgebra s.T, Nonempty (Iso (s.T.obj A.carrier) A.carrier) ∧
      ∀ B : TAlgebra s.T, IsStrict B.str → Nonempty (AlgHom A B) :=
  ⟨colimAlg s, ⟨colimIso s⟩, fun B hk => nonempty_algHom s B hk⟩

end Theorem614

end Domain.Neighborhood
