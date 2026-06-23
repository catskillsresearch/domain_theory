import Domain.Neighborhood.FunctionSpace
import Domain.Neighborhood.Definition72

/-!
# Theorem 7.5 (Scott 1981, PRG-19, §7) — `(𝒟₀ → 𝒟₁)` is effectively given

Following Dana Scott, *Lectures on a Mathematical Theory of Computation*, PRG-19, Lecture VII.

> **Theorem 7.5.** If `𝒟₀` and `𝒟₁` are effectively given, then so is `(𝒟₀ → 𝒟₁)`. The combinators
> `eval` and `curry` are computable, provided all the domains involved are effectively given. The
> computable elements `f ∈ |𝒟₀ → 𝒟₁|` are exactly the computable maps `f : 𝒟₀ → 𝒟₁`.

This file builds the theorem in green, audited, **choice-free** milestones (see `HANDOFF.md`).

## Milestone 1 — Proposition 3.9(i), the consistency condition (forward, choice-free)

The keystone is Scott's 3.9(i): a function-space neighbourhood `⋂[Xᵢ,Yᵢ]` is non-empty iff for every
subset `I` of indices with `{Xᵢ ∣ i∈I}` consistent in `𝒟₀`, the outputs `{Yᵢ ∣ i∈I}` are consistent
in `𝒟₁`. We model a subset by a **sublist** `sub ⊑ L` (this is what the eventual primitive-recursive
decider enumerates, one entry/bit at a time), and the intersection of a finite list of neighbourhoods
by `interList`. The forward direction — non-empty ⟹ the subset condition — is choice-free: given a
witness map `f ∈ stepFun L` and a common lower neighbourhood `Z` of the selected inputs, `f` relates
`Z` to the intersection of the selected outputs (a finite `inter_right` fold over the *explicit*
selection, so **no undecidable `X ⊆ Xᵢ` case-split is needed**), whence that intersection is a
neighbourhood by `f.rel_cod`.

(The reverse direction is genuinely decidable only relative to the presentations — it needs
`𝒟₀`-inclusion to be decidable to single out `{i ∣ X ⊆ Xᵢ}` — and is developed with the decider.)
-/

namespace Domain.Neighborhood

open NeighborhoodSystem Domain.Recursive ApproximableMap

variable {α β γ : Type*} {V₀ : NeighborhoodSystem α} {V₁ : NeighborhoodSystem β}

/-! ### `interList` — the intersection of a finite list of neighbourhoods (with a base). -/

/-- The intersection of the sets in `M`, taken inside the base set `base` (so the empty list gives
`base`, matching the convention 1.1a where the empty intersection is `Δ`). -/
def interList (base : Set β) : List (Set β) → Set β
  | [] => base
  | Y :: M => Y ∩ interList base M

@[simp] theorem interList_nil (base : Set β) : interList base [] = base := rfl

theorem interList_cons (base : Set β) (Y : Set β) (M : List (Set β)) :
    interList base (Y :: M) = Y ∩ interList base M := rfl

theorem mem_interList {base : Set β} {M : List (Set β)} {z : β} :
    z ∈ interList base M ↔ z ∈ base ∧ ∀ Y ∈ M, z ∈ Y := by
  induction M with
  | nil => simp
  | cons Y M ih =>
    rw [interList_cons]
    simp only [Set.mem_inter_iff, ih, List.mem_cons]
    constructor
    · rintro ⟨hY, hbase, hM⟩
      exact ⟨hbase, fun W hW => hW.elim (fun h => h ▸ hY) (hM W)⟩
    · rintro ⟨hbase, hall⟩
      exact ⟨hall Y (Or.inl rfl), hbase, fun W hW => hall W (Or.inr hW)⟩

theorem interList_subset_base {base : Set β} {M : List (Set β)} : interList base M ⊆ base :=
  fun _ hz => (mem_interList.mp hz).1

/-! ### Milestone 1 — the forward direction of 3.9(i), choice-free. -/

/-- A witness map `f ∈ stepFun L` relates a common lower neighbourhood `Z` of the *selected* inputs
to the intersection of the *selected* outputs. The selection `sub` is processed entry-by-entry with
`inter_right`, so the proof is choice-free (no inclusion case-split). -/
theorem rel_interList_of_selection {f : ApproximableMap V₀ V₁}
    {Z : Set α} (hZ : V₀.mem Z) {sub : List (Set α × Set β)}
    (hmem : ∀ p ∈ sub, f.rel p.1 p.2) (hZle : ∀ p ∈ sub, Z ⊆ p.1) :
    f.rel Z (interList V₁.master (sub.map Prod.snd)) := by
  induction sub with
  | nil =>
    simp only [List.map_nil, interList_nil]
    exact f.mono f.master_rel (V₀.sub_master hZ) subset_rfl hZ V₁.master_mem
  | cons p sub ih =>
    have hp : f.rel p.1 p.2 := hmem p (List.mem_cons.mpr (Or.inl rfl))
    have hZp : f.rel Z p.2 :=
      f.mono hp (hZle p (List.mem_cons.mpr (Or.inl rfl))) subset_rfl hZ (f.rel_cod hp)
    have htail : f.rel Z (interList V₁.master (sub.map Prod.snd)) :=
      ih (fun q hq => hmem q (List.mem_cons.mpr (Or.inr hq)))
        (fun q hq => hZle q (List.mem_cons.mpr (Or.inr hq)))
    rw [List.map_cons, interList_cons]
    exact f.inter_right hZp htail

/-- **Proposition 3.9(i) (Scott 1981, PRG-19), forward direction — choice-free.** If the
function-space neighbourhood `stepFun L` is non-empty, then for every selection `sub ⊑ L` whose
inputs admit a common lower neighbourhood `Z ∈ 𝒟₀`, the intersection of the selected outputs is a
neighbourhood of `𝒟₁`. -/
theorem interList_mem_of_stepFun_nonempty {L : List (Set α × Set β)}
    (h : (stepFun L : Set (ApproximableMap V₀ V₁)).Nonempty) {sub : List (Set α × Set β)}
    (hsub : sub.Sublist L) {Z : Set α} (hZ : V₀.mem Z) (hZle : ∀ p ∈ sub, Z ⊆ p.1) :
    V₁.mem (interList V₁.master (sub.map Prod.snd)) := by
  obtain ⟨f, hf⟩ := h
  have hmem : ∀ p ∈ sub, f.rel p.1 p.2 := fun p hp => hf p (hsub.subset hp)
  exact f.rel_cod (rel_interList_of_selection hZ hmem hZle)

/-! ### Milestone 2 — the consistency characterization over coded entry-lists.

A function-space neighbourhood is presented by a list `el : List ℕ` of *entry codes*: each `e ∈ el`
codes a step pair `[X_{e.1}, Y_{e.2}]` via `Nat.pair`. `funListOf` turns `el` into the list of step
pairs, and `stepFun (funListOf el)` is the neighbourhood `⋂[X_{eᵢ.1}, Y_{eᵢ.2}]`.

The characterization `stepFun_funListOf_nonempty_iff` is Scott's 3.9(i): the neighbourhood is
non-empty iff for every *sub-selection* `sub ⊑ el` whose inputs have a common lower neighbourhood
`Z ∈ 𝒟₀`, the intersection of the selected outputs is a neighbourhood of `𝒟₁`. The reverse direction
builds the least map `leastMap`; its consistency hypothesis is discharged input-by-input by
**filtering `el` with the (choice-free) decidable `𝒟₀`-inclusion test** supplied by the presentation
`P₀`, so it stays `⊆ {propext, Quot.sound}`. -/

variable (P₀ : ComputablePresentation V₀) (P₁ : ComputablePresentation V₁)

/-- The step pair coded by an entry `e`: `(X_{e.unpair.1}, Y_{e.unpair.2})`. -/
def funPair (e : ℕ) : Set α × Set β := (P₀.X e.unpair.1, P₁.X e.unpair.2)

@[simp] theorem funPair_fst (e : ℕ) : (funPair P₀ P₁ e).1 = P₀.X e.unpair.1 := rfl
@[simp] theorem funPair_snd (e : ℕ) : (funPair P₀ P₁ e).2 = P₁.X e.unpair.2 := rfl

/-- The list of step pairs coded by an entry-list `el`. -/
def funListOf (el : List ℕ) : List (Set α × Set β) := el.map (funPair P₀ P₁)

theorem funListOf_valid (el : List ℕ) :
    ∀ p ∈ funListOf P₀ P₁ el, V₀.mem p.1 ∧ V₁.mem p.2 := by
  intro p hp
  rw [funListOf, List.mem_map] at hp
  obtain ⟨e, _, rfl⟩ := hp
  exact ⟨P₀.mem_X _, P₁.mem_X _⟩

/-- **Proposition 3.9(i) (Scott 1981, PRG-19), over coded entry-lists — choice-free.** The
function-space neighbourhood `⋂[X_{eᵢ}, Y_{eᵢ}]` coded by `el` is non-empty iff for every
sub-selection `sub ⊑ el` whose inputs `{X_{e} ∣ e ∈ sub}` admit a common lower neighbourhood
`Z ∈ 𝒟₀`, the intersection of the selected outputs `{Y_{e} ∣ e ∈ sub}` is a neighbourhood of `𝒟₁`.

* (⟹) is `interList_mem_of_stepFun_nonempty` (Milestone 1), pushed through `funPair`.
* (⟸) builds `leastMap`; its consistency hypothesis `hcons` is discharged for each input `X'` by
  **filtering `el` with the decidable `𝒟₀`-inclusion `X' ⊆ X_e`** (supplied choice-free by `P₀`), so
  that `interYs Δ₁ (funListOf el) X'` is exactly the intersection of the selected outputs. -/
theorem stepFun_funListOf_nonempty_iff (el : List ℕ) :
    (stepFun (funListOf P₀ P₁ el) : Set (ApproximableMap V₀ V₁)).Nonempty ↔
      ∀ sub : List ℕ, sub.Sublist el →
        (∃ Z, V₀.mem Z ∧ ∀ e ∈ sub, Z ⊆ P₀.X e.unpair.1) →
          V₁.mem (interList V₁.master (sub.map (fun e => P₁.X e.unpair.2))) := by
  constructor
  · -- forward
    intro h sub hsub hcons
    obtain ⟨Z, hZ, hZle⟩ := hcons
    have hsub' : (sub.map (funPair P₀ P₁)).Sublist (funListOf P₀ P₁ el) := hsub.map _
    have hZle' : ∀ p ∈ sub.map (funPair P₀ P₁), Z ⊆ p.1 := by
      intro p hp
      rw [List.mem_map] at hp
      obtain ⟨e, he, rfl⟩ := hp
      exact hZle e he
    have hres := interList_mem_of_stepFun_nonempty h hsub' hZ hZle'
    have hlist : (sub.map (funPair P₀ P₁)).map Prod.snd = sub.map (fun e => P₁.X e.unpair.2) := by
      rw [List.map_map]; rfl
    rwa [hlist] at hres
  · -- backward
    intro hcond
    have hL := funListOf_valid P₀ P₁ el
    have hcons : ∀ {X' : Set α}, V₀.mem X' →
        V₁.mem (interYs V₁.master (funListOf P₀ P₁ el) X') := by
      intro X' hX'
      obtain ⟨nx, hnx⟩ := P₀.surj hX'
      obtain ⟨finc, _, hfinc⟩ := P₀.incl_computable
      letI : DecidablePred (fun e : ℕ => X' ⊆ P₀.X e.unpair.1) := fun e =>
        decidable_of_iff (finc (Nat.pair nx e.unpair.1) = 1) (by
          have h := hfinc (Nat.pair nx e.unpair.1)
          simp only [unpair_pair_fst, unpair_pair_snd] at h
          rw [hnx] at h
          exact h.symm)
      set sub : List ℕ := el.filter (fun e => decide (X' ⊆ P₀.X e.unpair.1)) with hsubdef
      have hsub : sub.Sublist el := List.filter_sublist
      have hmem_iff : ∀ e, e ∈ sub ↔ e ∈ el ∧ X' ⊆ P₀.X e.unpair.1 := by
        intro e
        rw [hsubdef, List.mem_filter, decide_eq_true_iff]
      have heq : interYs V₁.master (funListOf P₀ P₁ el) X'
          = interList V₁.master (sub.map (fun e => P₁.X e.unpair.2)) := by
        apply Set.ext; intro z
        rw [mem_interYs, mem_interList]
        constructor
        · rintro ⟨hzb, hall⟩
          refine ⟨hzb, ?_⟩
          intro Y hY
          rw [List.mem_map] at hY
          obtain ⟨e, hesub, rfl⟩ := hY
          have he := (hmem_iff e).mp hesub
          have hpair : funPair P₀ P₁ e ∈ funListOf P₀ P₁ el := List.mem_map.mpr ⟨e, he.1, rfl⟩
          exact hall (funPair P₀ P₁ e) hpair he.2
        · rintro ⟨hzb, hall⟩
          refine ⟨hzb, ?_⟩
          intro p hp hXp
          rw [funListOf, List.mem_map] at hp
          obtain ⟨e, hee, rfl⟩ := hp
          have hesub : e ∈ sub := (hmem_iff e).mpr ⟨hee, hXp⟩
          exact hall (P₁.X e.unpair.2) (List.mem_map.mpr ⟨e, hesub, rfl⟩)
      rw [heq]
      refine hcond sub hsub ⟨X', hX', ?_⟩
      intro e he
      exact ((hmem_iff e).mp he).2
    exact ⟨leastMap (funListOf P₀ P₁ el) hL hcons, leastMap_mem_stepFun hL hcons⟩

/-! ### Milestone 3a — deciding consistency of a finite index set via the `inter`-chain.

To decide whether a finite list of neighbourhood indices `js` is *consistent* in `𝒟` (i.e. whether
`⋂{X_j ∣ j ∈ js}` is a neighbourhood) we fold the presentation's primitive-recursive `inter` along
`js`, starting from `masterIdx`, to obtain an index `idxchain js`. The crisp characterization is:

> `js` is consistent **iff** `X_{idxchain js} ⊆ X_j` for every `j ∈ js`.

The point is that `X_{idxchain js}` is *always* a neighbourhood (`mem_X`), so if it sits inside every
`X_j` it witnesses consistency; conversely, when consistent, `inter`'s spec (and the fact that a
subset of a consistent set is consistent) makes the chain compute the genuine intersection. This
replaces any consistency-flag bookkeeping by a single `inter`-fold plus a bounded inclusion check —
all choice-free. -/

section ConsChain

variable {V : NeighborhoodSystem α} (P : ComputablePresentation V)

/-- The running intersection of `A` with the neighbourhoods `X_j` (`j ∈ js`), left-accumulated to
match `List.foldl`. -/
def interFrom (A : Set α) : List ℕ → Set α
  | [] => A
  | j :: js => interFrom (A ∩ P.X j) js

theorem mem_interFrom {A : Set α} {js : List ℕ} {z : α} :
    z ∈ interFrom P A js ↔ z ∈ A ∧ ∀ j ∈ js, z ∈ P.X j := by
  induction js generalizing A with
  | nil => simp [interFrom]
  | cons j js ih =>
    rw [interFrom, ih]
    simp only [Set.mem_inter_iff, List.mem_cons]
    constructor
    · rintro ⟨⟨hA, hj⟩, hrest⟩
      exact ⟨hA, fun j' hj' => hj'.elim (fun h => h ▸ hj) (hrest j')⟩
    · rintro ⟨hA, hall⟩
      exact ⟨⟨hA, hall j (Or.inl rfl)⟩, fun j' hj' => hall j' (Or.inr hj')⟩

theorem interFrom_subset {A : Set α} {js : List ℕ} : interFrom P A js ⊆ A :=
  fun _ hz => (mem_interFrom P |>.mp hz).1

/-- A finite running intersection with a neighbourhood inside it is itself a neighbourhood. -/
theorem interFrom_mem_of_witness {A : Set α} {js : List ℕ} {Z : Set α}
    (hZ : V.mem Z) (hZsub : Z ⊆ interFrom P A js) (hA : V.mem A) :
    V.mem (interFrom P A js) := by
  induction js generalizing A with
  | nil => simpa [interFrom] using hA
  | cons j js ih =>
    rw [interFrom] at hZsub ⊢
    have hAXj : V.mem (A ∩ P.X j) :=
      V.inter_mem hA (P.mem_X j) hZ (hZsub.trans (interFrom_subset P))
    exact ih hZsub hAXj

/-- The fold of `inter` along `js` (starting from `a`, with `X a = A`) computes the running
intersection `interFrom A js` — *provided* that intersection is consistent (so each prefix is too, by
`inter_spec`). -/
theorem interFrom_eq_of_foldl : ∀ (js : List ℕ) (A : Set α) (a : ℕ),
    P.X a = A → V.mem A → V.mem (interFrom P A js) →
    P.X (js.foldl (fun acc j => P.inter acc j) a) = interFrom P A js
  | [], A, a, hXa, _, _ => by simpa [interFrom] using hXa
  | j :: js, A, a, hXa, hA, hmem => by
    have hmem' : V.mem (interFrom P (A ∩ P.X j) js) := by rwa [interFrom] at hmem
    have hAXj : V.mem (A ∩ P.X j) :=
      V.inter_mem hA (P.mem_X j) hmem' (interFrom_subset P)
    have hk : ∃ k, P.X k ⊆ P.X a ∩ P.X j := by
      obtain ⟨k, hk⟩ := P.surj hAXj
      exact ⟨k, by rw [hk, hXa]⟩
    have hXinter : P.X (P.inter a j) = A ∩ P.X j := by rw [P.inter_spec hk, hXa]
    rw [List.foldl_cons, interFrom]
    exact interFrom_eq_of_foldl js (A ∩ P.X j) (P.inter a j) hXinter hAXj hmem'

/-- The `inter`-chain index of `js`: `inter`-fold from `masterIdx`. -/
def idxchain (js : List ℕ) : ℕ := js.foldl (fun acc j => P.inter acc j) P.masterIdx

/-- When `js` is consistent, the `inter`-chain index genuinely indexes `⋂{X_j ∣ j ∈ js}`. -/
theorem idxchain_spec {js : List ℕ} (h : V.mem (interFrom P V.master js)) :
    P.X (idxchain P js) = interFrom P V.master js :=
  interFrom_eq_of_foldl P js V.master P.masterIdx P.masterIdx_spec V.master_mem h

/-- **Consistency via the `inter`-chain (choice-free).** A finite index set `js` is consistent — i.e.
`⋂{X_j ∣ j ∈ js}` is a neighbourhood — exactly when the always-a-neighbourhood `X_{idxchain js}` sits
inside every `X_j` (`j ∈ js`). -/
theorem consChain_iff (js : List ℕ) :
    (∀ j ∈ js, P.X (idxchain P js) ⊆ P.X j) ↔ V.mem (interFrom P V.master js) := by
  constructor
  · intro hle
    have hsub : P.X (idxchain P js) ⊆ interFrom P V.master js := by
      intro z hz
      rw [mem_interFrom]
      exact ⟨V.sub_master (P.mem_X _) hz, fun j hj => hle j hj hz⟩
    exact interFrom_mem_of_witness P (P.mem_X _) hsub V.master_mem
  · intro hmem j hj
    rw [idxchain_spec P hmem]
    exact fun z hz => (mem_interFrom P |>.mp hz).2 j hj

end ConsChain

end Domain.Neighborhood
