import Domain.Neighborhood.Basic
import Mathlib.Data.Set.Insert

/-!
# Exercise 7.22 (Scott 1981, PRG-19, §7) — a domain over `{0,1}*` by least fixed point

> **EXERCISE 7.22.** (For algebraists.) Let `Σ = {0,1}*` be the free semigroup. A new domain is
> constructed by defining a family of sets by the least fixed point theorem as follows:
>
> `S = {Σ} ∪ {{σ} ∣ σ ∈ Σ} ∪ {XY ∣ X, Y ∈ S} ∪ {X ∩ Y ∣ X, Y ∈ S and X ∩ Y ≠ ∅}.`
>
> Here `XY = {στ ∣ σ ∈ X and τ ∈ Y}`.
>
> Prove that `S` is an effectively given, positive neighbourhood system. (Hint: the sets in `S` are
> each "regular events" in the terminology of automata theory, and we have a decision method for the
> set algebra of regular events.)
>
> Define multiplication on `|S|` by `xy = {Z ∈ S ∣ ∃ X ∈ x ∃ Y ∈ y. XY ⊆ Z}`, and show `|S|` becomes
> a semigroup with `Σ` embedded into `|S|` by the homomorphism `σ ↦ {X ∈ S ∣ σ ∈ X}`.
>
> Investigate some *infinite words* in `S`, say those defined by least fixed points such as
> `σ⃗ = σ σ⃗` and `σ⃗ = σ⃗ σ`. Are the equations `σ⃗ σ⃗ = σ⃗`, `σ⃗ σ⃗ σ⃗ = σ⃗`,
> `σ⃗ 1⃗ σ⃗ 1⃗ = σ⃗ 1⃗`, and `01⃗ 01⃗ 01⃗ 01⃗ = 01⃗ 01⃗` true?

This file formalises the **algebraic core** of the exercise, fully and choice-free:

* the least-fixed-point family `S` as an inductive predicate `InS` over tokens `Σ = {0,1}* = List Bool`;
* `S` is a **positive neighbourhood system** `Ssys` (Definition 1.1 / Exercise 1.19), built choice-free
  via `NeighborhoodSystem.ofPositive`;
* the **multiplication** `xy` on the domain `|S|` and the proof that it is **associative**, so `|S|`
  is a semigroup (`mulElem`, `mulElem_assoc`);
* the **embedding** `σ ↦ {X ∈ S ∣ σ ∈ X}` of the free monoid into `|S|`, proved a semigroup
  **homomorphism** (`emb_mul`) and **injective** (`emb_injective`).

## On "effectively given" and the infinite-word equations (discussion)

Two parts of Scott's exercise are *not* mechanised here, and are discussed in prose rather than left
as `sorry` (the file is `sorry`-free):

* **Effective givenness.** Every member of `S` is a *regular event* (Scott's hint): `Σ = {0,1}*` and
  every singleton `{σ}` is regular, and regular languages are closed under concatenation `XY` and
  intersection `X ∩ Y`. An enumeration `X : ℕ → Set Σ` of `S` is obtained by Gödel-numbering the
  finite *syntax* of `S`-terms (the four generators `Σ`, `{σ}`, `·` for `XY`, `∩`). Scott's two
  decidability relations (Definition 7.1) — `Xₙ ∩ Xₘ = X_k` and the consistency `∃k. X_k ⊆ Xₙ ∩ Xₘ`
  (which by **positivity** is just non-emptiness of `Xₙ ∩ Xₘ`) — are decidable because the *set
  algebra of regular events* is decidable (emptiness and equivalence of regular languages are
  decidable, e.g. via minimal DFAs / Myhill–Nerode, cf. `Example62Regular.lean`). Mechanising that
  decision procedure inside this project's bespoke **choice-free** recursion theory
  (`Recursive.lean`) would require building the automata-theoretic decision algorithms primitively;
  that is a separate, large undertaking and is left as the documented gap. The neighbourhood-system
  content (positivity) and the algebra (semigroup + embedding) are complete.

* **Infinite words.** The "infinite words" `σ⃗` are the *total* elements of `|S|` obtained as least
  fixed points of `t ↦ {σ} · t` (a left-infinite power) etc. The questions
  `σ⃗ σ⃗ = σ⃗ ?`, `01⃗ 01⃗ 01⃗ 01⃗ = 01⃗ 01⃗ ?` are explicitly posed by Scott as open *investigations*;
  they concern idempotency/periodicity of these limits under the multiplication and are out of scope
  of the algebraic core formalised here.

Everything below depends only on `propext` / `Quot.sound` (no `Classical.choice`).
-/

namespace Domain.Neighborhood

namespace Exercise722

/-! ## Concatenation of languages over `Σ = {0,1}*`

We work with tokens `Σ = List Bool` (the words over `{0,1}`); a neighbourhood is a `Set (List Bool)`
(a "language"). We use a bespoke `concat` (rather than mathlib's `Language.*`) so that intersection,
`Set.univ`, and singletons remain the native `Set` operations the neighbourhood-system API expects. -/

/-- Scott's `XY = {στ ∣ σ ∈ X and τ ∈ Y}`: the concatenation of two languages. -/
def concat (X Y : Set (List Bool)) : Set (List Bool) := {w | ∃ a ∈ X, ∃ b ∈ Y, a ++ b = w}

@[simp] theorem mem_concat {X Y : Set (List Bool)} {w : List Bool} :
    w ∈ concat X Y ↔ ∃ a ∈ X, ∃ b ∈ Y, a ++ b = w := Iff.rfl

/-- `a ∈ X`, `b ∈ Y ⟹ a ++ b ∈ XY`. -/
theorem append_mem_concat {X Y : Set (List Bool)} {a b : List Bool} (ha : a ∈ X) (hb : b ∈ Y) :
    a ++ b ∈ concat X Y := ⟨a, ha, b, hb, rfl⟩

/-- Concatenation is monotone in both arguments. -/
theorem concat_mono {X X' Y Y' : Set (List Bool)} (hX : X ⊆ X') (hY : Y ⊆ Y') :
    concat X Y ⊆ concat X' Y' := by
  rintro w ⟨a, ha, b, hb, rfl⟩; exact ⟨a, hX ha, b, hY hb, rfl⟩

/-- Concatenation is associative (inherited from `List.append_assoc`). -/
theorem concat_assoc (X Y Z : Set (List Bool)) :
    concat (concat X Y) Z = concat X (concat Y Z) := by
  ext w
  constructor
  · rintro ⟨ab, ⟨a, ha, b, hb, rfl⟩, c, hc, rfl⟩
    exact ⟨a, ha, b ++ c, ⟨b, hb, c, hc, rfl⟩, by rw [List.append_assoc]⟩
  · rintro ⟨a, ha, bc, ⟨b, hb, c, hc, rfl⟩, rfl⟩
    exact ⟨a ++ b, ⟨a, ha, b, hb, rfl⟩, c, hc, by rw [List.append_assoc]⟩

/-- The concatenation of two non-empty languages is non-empty. -/
theorem concat_nonempty {X Y : Set (List Bool)} (hX : X.Nonempty) (hY : Y.Nonempty) :
    (concat X Y).Nonempty := by
  obtain ⟨a, ha⟩ := hX
  obtain ⟨b, hb⟩ := hY
  exact ⟨a ++ b, a, ha, b, hb, rfl⟩

/-- `{a}{b} = {a ++ b}`: concatenation of singletons is the singleton of the concatenation. -/
theorem concat_singleton (a b : List Bool) : concat {a} {b} = {a ++ b} := by
  ext w
  simp only [mem_concat, Set.mem_singleton_iff]
  constructor
  · rintro ⟨a', rfl, b', rfl, rfl⟩; rfl
  · rintro rfl; exact ⟨a, rfl, b, rfl, rfl⟩

/-! ## The least-fixed-point family `S` -/

/-- **Scott's family `S`**, as the least fixed point (an inductive predicate). A language `X` is *in
`S`* iff it is built from the four generators:

* `Σ = {0,1}*` itself (`Set.univ`);
* a singleton `{σ}`;
* a concatenation `XY` of two members;
* a *non-empty* intersection `X ∩ Y` of two members. -/
inductive InS : Set (List Bool) → Prop
  | univ : InS Set.univ
  | singleton (σ : List Bool) : InS {σ}
  | mul {X Y : Set (List Bool)} : InS X → InS Y → InS (concat X Y)
  | inter {X Y : Set (List Bool)} : InS X → InS Y → (X ∩ Y).Nonempty → InS (X ∩ Y)

/-- **Every member of `S` is non-empty.** (`Σ` and singletons are non-empty; concatenation preserves
non-emptiness; intersections are only admitted to `S` when non-empty.) This is what makes `S`
*positive*. -/
theorem InS.nonempty {X : Set (List Bool)} (h : InS X) : X.Nonempty := by
  induction h with
  | univ => exact ⟨[], trivial⟩
  | singleton σ => exact ⟨σ, rfl⟩
  | mul _ _ ihX ihY => exact concat_nonempty ihX ihY
  | inter _ _ hne _ _ => exact hne

/-! ## `S` is a positive neighbourhood system -/

/-- **Exercise 7.22 (neighbourhood-system part).** `S` is a *positive* neighbourhood system over the
token type `Σ = {0,1}*`, with master neighbourhood `Δ = Σ = Set.univ`. Built choice-free via
`NeighborhoodSystem.ofPositive`: positivity `(X ∩ Y) ∈ S ↔ (X ∩ Y).Nonempty` holds because every
member of `S` is non-empty (`InS.nonempty`, the `→` direction) and `InS.inter` is exactly the `←`. -/
def Ssys : NeighborhoodSystem (List Bool) :=
  NeighborhoodSystem.ofPositive InS Set.univ InS.univ (fun {X} _ => Set.subset_univ X)
    (fun _ _ hX hY => ⟨fun h => h.nonempty, fun h => InS.inter hX hY h⟩)

@[simp] theorem Ssys_mem {X : Set (List Bool)} : Ssys.mem X ↔ InS X := Iff.rfl

theorem Ssys_master : Ssys.master = Set.univ := rfl

/-- `S` is indeed positive (Exercise 1.19's `IsPositive`). -/
theorem Ssys_isPositive : Ssys.IsPositive := by
  intro X Y hX hY
  exact ⟨fun h => h.nonempty, fun h => InS.inter hX hY h⟩

/-! ## Multiplication on the domain `|S|`

`xy = {Z ∈ S ∣ ∃ X ∈ x ∃ Y ∈ y. XY ⊆ Z}`. We show this is again a filter (an element of `|S|`). -/

/-- **Scott's multiplication on `|S|`.** `xy = {Z ∈ S ∣ ∃ X ∈ x ∃ Y ∈ y. XY ⊆ Z}`. The filter
conditions:

* `master_mem`: take `X = Y = Σ` (both in any filter), `Σ·Σ ⊆ Σ`;
* `inter_mem`: from witnesses `X₁Y₁ ⊆ Z₁`, `X₂Y₂ ⊆ Z₂`, the pair `X₁ ∩ X₂ ∈ x`, `Y₁ ∩ Y₂ ∈ y` (filter
  closure) gives `(X₁ ∩ X₂)(Y₁ ∩ Y₂) ⊆ Z₁ ∩ Z₂` by monotonicity of `concat`, and `Z₁ ∩ Z₂ ∈ S`
  because this non-empty witness sits inside it (positivity);
* `up_mem`: transitivity of `⊆`. -/
def mulElem (x y : Ssys.Element) : Ssys.Element where
  mem Z := InS Z ∧ ∃ X, x.mem X ∧ ∃ Y, y.mem Y ∧ concat X Y ⊆ Z
  sub h := h.1
  master_mem :=
    ⟨InS.univ, Set.univ, x.master_mem, Set.univ, y.master_mem, Set.subset_univ _⟩
  inter_mem := by
    rintro Z1 Z2 ⟨hZ1, X1, hX1, Y1, hY1, hsub1⟩ ⟨hZ2, X2, hX2, Y2, hY2, hsub2⟩
    have hXi : x.mem (X1 ∩ X2) := x.inter_mem hX1 hX2
    have hYi : y.mem (Y1 ∩ Y2) := y.inter_mem hY1 hY2
    have hcsub : concat (X1 ∩ X2) (Y1 ∩ Y2) ⊆ Z1 ∩ Z2 := by
      intro w hw
      exact ⟨hsub1 (concat_mono Set.inter_subset_left Set.inter_subset_left hw),
             hsub2 (concat_mono Set.inter_subset_right Set.inter_subset_right hw)⟩
    have hne : (Z1 ∩ Z2).Nonempty :=
      (concat_nonempty (x.sub hXi).nonempty (y.sub hYi).nonempty).mono hcsub
    exact ⟨InS.inter hZ1 hZ2 hne, X1 ∩ X2, hXi, Y1 ∩ Y2, hYi, hcsub⟩
  up_mem := by
    rintro Z W ⟨_, X, hX, Y, hY, hsub⟩ hW hZW
    exact ⟨hW, X, hX, Y, hY, hsub.trans hZW⟩

@[simp] theorem mem_mulElem {x y : Ssys.Element} {Z : Set (List Bool)} :
    (mulElem x y).mem Z ↔ InS Z ∧ ∃ X, x.mem X ∧ ∃ Y, y.mem Y ∧ concat X Y ⊆ Z := Iff.rfl

/-- **Exercise 7.22 (semigroup part): multiplication on `|S|` is associative**, so `|S|` is a
semigroup. The forward inclusion rewrites `X(YZ) = (XY)Z` (`concat_assoc`) and uses monotonicity of
`concat` to push the witnesses through; the converse is symmetric. -/
theorem mulElem_assoc (x y z : Ssys.Element) :
    mulElem (mulElem x y) z = mulElem x (mulElem y z) := by
  apply NeighborhoodSystem.Element.ext
  intro W
  constructor
  · rintro ⟨hW, P, ⟨_, X, hX, Y, hY, hXY⟩, Z, hZ, hPZ⟩
    refine ⟨hW, X, hX, concat Y Z, ⟨InS.mul (y.sub hY) (z.sub hZ), Y, hY, Z, hZ,
      Set.Subset.refl _⟩, ?_⟩
    rw [← concat_assoc]
    exact (concat_mono hXY (Set.Subset.refl _)).trans hPZ
  · rintro ⟨hW, X, hX, Q, ⟨_, Y, hY, Z, hZ, hYZ⟩, hXQ⟩
    refine ⟨hW, concat X Y, ⟨InS.mul (x.sub hX) (y.sub hY), X, hX, Y, hY,
      Set.Subset.refl _⟩, Z, hZ, ?_⟩
    rw [concat_assoc]
    exact (concat_mono (Set.Subset.refl _) hYZ).trans hXQ

/-! ## The embedding of `Σ = {0,1}*` into `|S|` -/

/-- **Scott's embedding** `σ ↦ {X ∈ S ∣ σ ∈ X}`. This is a filter (an element of `|S|`): it contains
`Σ`, is closed under intersection (the intersection is non-empty since it still contains `σ`, so it
lies in `S` by positivity), and is upward closed. -/
def emb (σ : List Bool) : Ssys.Element where
  mem X := InS X ∧ σ ∈ X
  sub h := h.1
  master_mem := ⟨InS.univ, Set.mem_univ σ⟩
  inter_mem := by
    rintro X Y ⟨hX, hσX⟩ ⟨hY, hσY⟩
    exact ⟨InS.inter hX hY ⟨σ, hσX, hσY⟩, hσX, hσY⟩
  up_mem := by
    rintro X Y ⟨_, hσ⟩ hY hsub
    exact ⟨hY, hsub hσ⟩

@[simp] theorem mem_emb {σ : List Bool} {X : Set (List Bool)} :
    (emb σ).mem X ↔ InS X ∧ σ ∈ X := Iff.rfl

/-- **Exercise 7.22 (homomorphism part): `emb` is a semigroup homomorphism**,
`emb (σ ++ τ) = emb σ · emb τ`. Forward: from `σ ++ τ ∈ Z`, the witnesses `X = {σ}`, `Y = {τ}` give
`{σ}{τ} = {σ ++ τ} ⊆ Z`. Converse: if `{σ}` ∈ `emb σ`, `{τ}` ∈ `emb τ` with `XY ⊆ Z` then
`σ ++ τ ∈ XY ⊆ Z`. -/
theorem emb_mul (σ τ : List Bool) : emb (σ ++ τ) = mulElem (emb σ) (emb τ) := by
  apply NeighborhoodSystem.Element.ext
  intro Z
  constructor
  · rintro ⟨hZ, hστ⟩
    refine ⟨hZ, {σ}, ⟨InS.singleton σ, rfl⟩, {τ}, ⟨InS.singleton τ, rfl⟩, ?_⟩
    rw [concat_singleton]
    intro w hw
    rw [Set.mem_singleton_iff] at hw
    subst hw; exact hστ
  · rintro ⟨hZ, X, ⟨_, hσX⟩, Y, ⟨_, hτY⟩, hsub⟩
    exact ⟨hZ, hsub (append_mem_concat hσX hτY)⟩

/-- The embedding is **injective**: distinct words give distinct elements of `|S|`. (If
`emb σ = emb τ` then `emb τ` contains `{σ}`, forcing `τ = σ`.) So `Σ` genuinely *embeds* into `|S|`. -/
theorem emb_injective : Function.Injective emb := by
  intro σ τ h
  have hmem : (emb τ).mem {σ} := h ▸ (⟨InS.singleton σ, rfl⟩ : (emb σ).mem {σ})
  exact (Set.mem_singleton_iff.mp hmem.2).symm

end Exercise722

end Domain.Neighborhood
