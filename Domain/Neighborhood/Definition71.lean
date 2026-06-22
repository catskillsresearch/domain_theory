import Domain.Neighborhood.Basic
import Domain.Neighborhood.Exercise315
import Mathlib.Computability.Partrec
import Mathlib.Computability.RE

/-!
# Definition 7.1 (Scott 1981, PRG-19, §7) — computable presentations / effectively given domains

Following Dana Scott, *Lectures on a Mathematical Theory of Computation*, PRG-19, Lecture VII,
*Computability in effectively given domains*.

Scott's idea: the *finite elements* of `|𝒟|` are the ones initially known, and to know a finite
element is to know how it is **related** to the other finite elements. As finite elements are in
one-one correspondence with neighbourhoods (Definition 1.7), the data reduces to *recursive
calculations with neighbourhoods*. This forces at most a countable infinity of neighbourhoods.

> **Definition 7.1.** A neighbourhood system `𝒟` has a *computable presentation* provided we can
> write `𝒟 = {Xₙ ∣ n ∈ ℕ}`, where the two relations
>
> * (i)  `Xₙ ∩ Xₘ = X_k`, and
> * (ii) `∃ k. X_k ⊆ Xₙ and X_k ⊆ Xₘ`
>
> are recursively decidable (in `n, m, k` and in `n, m` respectively).

We model "recursively decidable" by mathlib's genuine recursion theory: `ComputablePred` over the
integer indices (`ℕ`, `ℕ × ℕ`, `ℕ × ℕ × ℕ` are all `Primcodable`). Relation (i) is the ternary
`interEq` predicate; relation (ii) is the binary `cons`(istency) predicate. The enumeration `X` is
the only *data* the structure carries, and it is a plain `ℕ → Set α`, so building a presentation
stays choice-free.

The intuitive content (Scott's prose): (i) lets us *locate* the intersection of two neighbourhoods
in the standard list, and (ii) is the *consistency condition* — the necessary and sufficient
condition for the intersection to exist in `𝒟`. Scott immediately remarks the biconditional
`Xₙ ⊆ Xₘ ↔ Xₙ ∩ Xₘ = Xₙ`, which makes the **inclusion** relation decidable from (i); we record this
as `ComputablePresentation.incl_computable`, and equality of neighbourhoods as `eq_computable`.

A neighbourhood system is *effectively given* when it admits such a presentation
(`NeighborhoodSystem.IsEffectivelyGiven`). The one-point system `𝟙` is the sanity inhabitant
(`unitSys_isEffectivelyGiven`).
-/

namespace Domain.Neighborhood

open NeighborhoodSystem

variable {α : Type*}

/-- **Definition 7.1 (Scott 1981, PRG-19).** A *computable presentation* of a neighbourhood system
`V` over a token type `α`: an enumeration `X : ℕ → Set α` whose range is exactly `𝒟` (`mem_X` and
`surj`), such that Scott's two relations on the integer indices are recursively decidable:

* `interEq_computable` is (i): the ternary relation `Xₙ ∩ Xₘ = X_k`;
* `cons_computable` is (ii): the binary consistency relation `∃ k. X_k ⊆ Xₙ ∩ Xₘ`
  (Scott's `X_k ⊆ Xₙ and X_k ⊆ Xₘ`).

Only the enumeration `X` is data; the remaining fields are `Prop`s, so a presentation is built
choice-free. -/
structure ComputablePresentation (V : NeighborhoodSystem α) where
  /-- The enumeration `𝒟 = {Xₙ ∣ n ∈ ℕ}`. -/
  X : ℕ → Set α
  /-- Every `Xₙ` is a neighbourhood. -/
  mem_X : ∀ n, V.mem (X n)
  /-- The enumeration is onto `𝒟`: every neighbourhood appears as some `Xₙ`. -/
  surj : ∀ {Y : Set α}, V.mem Y → ∃ n, X n = Y
  /-- **7.1(i)** — `Xₙ ∩ Xₘ = X_k` is recursively decidable in `n, m, k`. -/
  interEq_computable : ComputablePred (fun t : ℕ × ℕ × ℕ => X t.1 ∩ X t.2.1 = X t.2.2)
  /-- **7.1(ii)** — consistency `∃ k. X_k ⊆ Xₙ ∩ Xₘ` is recursively decidable in `n, m`. -/
  cons_computable : ComputablePred (fun t : ℕ × ℕ => ∃ k, X k ⊆ X t.1 ∩ X t.2)

namespace ComputablePresentation

variable {V : NeighborhoodSystem α} (P : ComputablePresentation V)

/-- **Scott's biconditional after 7.1.** "The inclusion relation between neighbourhoods is itself
decidable in terms of the indices", because `Xₙ ⊆ Xₘ ↔ Xₙ ∩ Xₘ = Xₙ`. We obtain a decision Boolean
for inclusion by reindexing `(n, m) ↦ (n, m, n)` into relation (i). -/
theorem incl_computable : ComputablePred (fun t : ℕ × ℕ => P.X t.1 ⊆ P.X t.2) := by
  obtain ⟨f, hf, hfeq⟩ := ComputablePred.computable_iff.1 P.interEq_computable
  refine ComputablePred.computable_iff.2 ⟨fun t => f (t.1, t.2, t.1), ?_, ?_⟩
  · exact hf.comp (Computable.pair Computable.fst (Computable.pair Computable.snd Computable.fst))
  · funext t
    have h := congrFun hfeq (t.1, t.2, t.1)
    exact (propext (@Set.inter_eq_left _ (P.X t.1) (P.X t.2))).symm.trans h

/-- **Equality of neighbourhoods is decidable** from the indices: `Xₙ = Xₘ ↔ Xₙ ⊆ Xₘ ∧ Xₘ ⊆ Xₙ`,
so equality is the conjunction of two instances of `incl_computable`. -/
theorem eq_computable : ComputablePred (fun t : ℕ × ℕ => P.X t.1 = P.X t.2) := by
  obtain ⟨f, hf, hfeq⟩ := ComputablePred.computable_iff.1 P.incl_computable
  refine ComputablePred.computable_iff.2
    ⟨fun t => cond (f (t.1, t.2)) (f (t.2, t.1)) false, ?_, ?_⟩
  · exact (hf.comp (Computable.pair Computable.fst Computable.snd)).cond
      (hf.comp (Computable.pair Computable.snd Computable.fst)) (Computable.const false)
  · funext t
    obtain ⟨n, m⟩ := t
    show (P.X n = P.X m) = ((cond (f (n, m)) (f (m, n)) false : Bool) : Prop)
    have h1 : (P.X n ⊆ P.X m) = (f (n, m) = true) := congrFun hfeq (n, m)
    have h2 : (P.X m ⊆ P.X n) = (f (m, n) = true) := congrFun hfeq (m, n)
    apply propext
    rw [Set.Subset.antisymm_iff, h1, h2]
    cases f (n, m) <;> cases f (m, n) <;> simp

end ComputablePresentation

/-- **Definition 7.1 (Scott 1981, PRG-19) — effectively given.** A neighbourhood system is
*effectively given* when it admits a computable presentation. -/
def NeighborhoodSystem.IsEffectivelyGiven (V : NeighborhoodSystem α) : Prop :=
  Nonempty (ComputablePresentation V)

/-! ### Sanity inhabitant: the one-point domain `𝟙` is effectively given. -/

/-- The trivial presentation of the one-point system `𝟙 = unitSys`: the constant enumeration
`Xₙ = Δ = univ`. Both of Scott's relations are *always true* here (any two neighbourhoods are equal
and consistent), hence trivially recursive. -/
def unitPresentation : ComputablePresentation unitSys where
  X _ := Set.univ
  mem_X _ := rfl
  surj := by rintro Y rfl; exact ⟨0, rfl⟩
  interEq_computable :=
    ComputablePred.computable_iff.2 ⟨fun _ => true, Computable.const true, by funext t; simp⟩
  cons_computable :=
    ComputablePred.computable_iff.2 ⟨fun _ => true, Computable.const true, by funext t; simp⟩

/-- **The one-point domain `𝟙` is effectively given.** -/
theorem unitSys_isEffectivelyGiven : unitSys.IsEffectivelyGiven :=
  ⟨unitPresentation⟩

end Domain.Neighborhood
