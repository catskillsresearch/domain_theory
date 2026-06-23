import Domain.Neighborhood.Example61
import Domain.Neighborhood.Definition72

/-!
# Proposition 7.7 (Scott 1981, PRG-19, §7) — `D^§` is effectively given

Following Dana Scott, *Lectures on a Mathematical Theory of Computation*, PRG-19, Lecture VII.

> **Proposition 7.7.** For any effectively given domain `D`, the domain `D^§` is also effectively
> given, and all the combinators of Example 6.1 prove to be computable.

Scott transposes everything back to `ℕ` and gives the enumeration of `D^§` (Example 6.1's tree
algebra, `Example61.Dsharp`) by a course-of-values recursion. In our model `D^§` lives over
`List Bool × α` (Example 6.1), so the enumeration is `V : ℕ → Set (List Bool × α)`:

* `V 0 = Γ`                  (the master neighbourhood of `D^§`);
* `V (2n+1) = 0·Xₙ`          (`embZero` of the `n`-th `D`-neighbourhood `Xₙ = P.X n`);
* `V (2n+2) = 1·V_{p n} ∪ 2·V_{q n}` (`embPair` of two earlier neighbourhoods).

Here `p n = n.unpair.1` and `q n = n.unpair.2` are Scott's `p, q` (inverse pairing): both are `≤ n`,
hence the subscripts `p n, q n` of `V_{2n+2}` are `< 2n+2`, so the recursion is well-founded and
membership stays recursive — exactly Scott's observation.

This file builds the construction in milestones:

* **Foundational layer (this commit):** `Vsharp` and its core math — `mem_X` (each `V k ∈ 𝒟^§`),
  `surj` (every `𝒟^§`-neighbourhood is some `V k`), nonemptiness. All choice-free.
-/

namespace Domain.Neighborhood

open NeighborhoodSystem Domain.Recursive Example61

variable {α : Type*}

namespace Proposition77

/-! ### A left bound for `Nat.unpair` (local, to keep `Recursive.lean`'s cache warm). -/

/-- `a ≤ Nat.pair a b` (choice-free). -/
private theorem le_pair_left (a b : ℕ) : a ≤ Nat.pair a b := by
  unfold Nat.pair; split <;> omega

/-- `n.unpair.1 ≤ n` (choice-free); the decreasing measure for `Vsharp`'s left child. -/
theorem unpair_fst_le (n : ℕ) : n.unpair.1 ≤ n := by
  have h := le_pair_left n.unpair.1 n.unpair.2
  rwa [pair_unpair] at h

/-! ### The enumeration `V : ℕ → 𝒫(List Bool × α)`. -/

/-- **Proposition 7.7 (Scott 1981, PRG-19).** Scott's enumeration of `D^§`:
`V₀ = Γ`, `V_{2n+1} = 0·Xₙ`, `V_{2n+2} = 1·V_{p n} ∪ 2·V_{q n}` (`p = unpair.1`, `q = unpair.2`). -/
def Vsharp (D : NeighborhoodSystem α) (P : ComputablePresentation D) :
    ℕ → Set (List Bool × α)
  | 0 => Gamma D
  | (k + 1) =>
      if (k + 1) % 2 = 1 then
        embZero (P.X (k / 2))
      else
        embPair (Vsharp D P ((k - 1) / 2).unpair.1) (Vsharp D P ((k - 1) / 2).unpair.2)
  termination_by k => k
  decreasing_by
    · have := unpair_fst_le ((k - 1) / 2); omega
    · have := unpair_snd_le ((k - 1) / 2); omega

variable {D : NeighborhoodSystem α} (P : ComputablePresentation D)

theorem Vsharp_zero : Vsharp D P 0 = Gamma D := by rw [Vsharp]

/-- One-step unfolding of `Vsharp` at a successor index. -/
theorem Vsharp_succ (k : ℕ) :
    Vsharp D P (k + 1) =
      if (k + 1) % 2 = 1 then embZero (P.X (k / 2))
      else embPair (Vsharp D P ((k - 1) / 2).unpair.1) (Vsharp D P ((k - 1) / 2).unpair.2) := by
  rw [Vsharp]

theorem Vsharp_odd (n : ℕ) : Vsharp D P (2 * n + 1) = embZero (P.X n) := by
  rw [Vsharp_succ, if_pos (by omega), show 2 * n / 2 = n from by omega]

theorem Vsharp_even (n : ℕ) :
    Vsharp D P (2 * n + 2) = embPair (Vsharp D P n.unpair.1) (Vsharp D P n.unpair.2) := by
  rw [show 2 * n + 2 = (2 * n + 1) + 1 from rfl, Vsharp_succ, if_neg (by omega),
    show (2 * n + 1 - 1) / 2 = n from by omega]

/-! ### `mem_X`, `surj`, nonemptiness. -/

/-- Every `V k` is a neighbourhood of `D^§`. -/
theorem Vsharp_mem (k : ℕ) : MemS D (Vsharp D P k) := by
  induction k using Nat.strong_induction_on with
  | _ k ih =>
    rcases Nat.eq_zero_or_pos k with rfl | hk
    · rw [Vsharp_zero]; exact MemS.gamma
    · -- `k ≥ 1` is odd `2n+1` or even `2n+2`, decided choice-free by `k % 2`.
      rcases (by
        rcases Nat.lt_or_ge (k % 2) 1 with h | h
        · exact Or.inr ⟨k / 2 - 1, by omega⟩
        · exact Or.inl ⟨k / 2, by omega⟩ :
          (∃ n, k = 2 * n + 1) ∨ (∃ n, k = 2 * n + 2)) with ⟨n, rfl⟩ | ⟨n, rfl⟩
      · rw [Vsharp_odd]; exact MemS.zero (P.mem_X n)
      · rw [Vsharp_even]
        exact MemS.pair (ih _ (by have := unpair_fst_le n; omega))
          (ih _ (by have := unpair_snd_le n; omega))

/-- Every neighbourhood of `D^§` is enumerated as some `V k` (surjectivity of `V`). -/
theorem Vsharp_surj {W : Set (List Bool × α)} (hW : MemS D W) : ∃ k, Vsharp D P k = W := by
  induction hW with
  | gamma => exact ⟨0, Vsharp_zero P⟩
  | @zero X hX => obtain ⟨n, hn⟩ := P.surj hX; exact ⟨2 * n + 1, by rw [Vsharp_odd, hn]⟩
  | @pair Pp Qq _ _ ihP ihQ =>
      obtain ⟨a, ha⟩ := ihP
      obtain ⟨b, hb⟩ := ihQ
      refine ⟨2 * Nat.pair a b + 2, ?_⟩
      have h1 : (Nat.pair a b).unpair.1 = a := by rw [unpair_pair]
      have h2 : (Nat.pair a b).unpair.2 = b := by rw [unpair_pair]
      rw [Vsharp_even, h1, h2, ha, hb]

/-- Under `∅ ∉ 𝒟`, no `V k` is empty. -/
theorem Vsharp_nonempty (hD : ∀ X, D.mem X → X.Nonempty) (k : ℕ) : (Vsharp D P k).Nonempty :=
  memS_nonempty hD (Vsharp_mem P k)

/-! ### Per-parity intersection identities.

These are the choice-free heart of Scott's "the reader has to check that 7.1(i)–(ii) hold for the
`Vₖ`. The idea is that any such check is either (1) trivial, or (2) something already assumed about
`D` and the `Xₙ`, or (3) can be thrown back to some sets `Vₘ` with strictly smaller subscripts."

* `V₀ = Γ` is the identity for `∩` (cases (1));
* odd ∩ odd reduces to `D`'s own intersection `Xₐ ∩ X_b` (case (2));
* odd ∩ even (and even ∩ odd) are `∅` — inconsistent (case (1), and `∅ ∉ 𝒟^§`);
* even ∩ even is `embPair` of the *component* intersections, whose subscripts `unpair.1 / unpair.2`
  are strictly smaller (case (3)). -/

theorem Vsharp_zero_inter (m : ℕ) : Vsharp D P 0 ∩ Vsharp D P m = Vsharp D P m := by
  rw [Vsharp_zero, Set.inter_eq_right]; exact memS_subset_gamma (Vsharp_mem P m)

theorem Vsharp_inter_zero (n : ℕ) : Vsharp D P n ∩ Vsharp D P 0 = Vsharp D P n := by
  rw [Vsharp_zero, Set.inter_eq_left]; exact memS_subset_gamma (Vsharp_mem P n)

theorem Vsharp_odd_inter_odd (a b : ℕ) :
    Vsharp D P (2 * a + 1) ∩ Vsharp D P (2 * b + 1) = embZero (P.X a ∩ P.X b) := by
  rw [Vsharp_odd, Vsharp_odd, embZero_inter]

theorem Vsharp_odd_inter_even (a b : ℕ) :
    Vsharp D P (2 * a + 1) ∩ Vsharp D P (2 * b + 2) = ∅ := by
  rw [Vsharp_odd, Vsharp_even, embZero_inter_embPair]

theorem Vsharp_even_inter_odd (a b : ℕ) :
    Vsharp D P (2 * a + 2) ∩ Vsharp D P (2 * b + 1) = ∅ := by
  rw [Set.inter_comm]; exact Vsharp_odd_inter_even P b a

theorem Vsharp_even_inter_even (a b : ℕ) :
    Vsharp D P (2 * a + 2) ∩ Vsharp D P (2 * b + 2)
      = embPair (Vsharp D P a.unpair.1 ∩ Vsharp D P b.unpair.1)
                (Vsharp D P a.unpair.2 ∩ Vsharp D P b.unpair.2) := by
  rw [Vsharp_even, Vsharp_even, embPair_inter]

end Proposition77

end Domain.Neighborhood
