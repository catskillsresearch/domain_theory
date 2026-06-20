import Domain.Neighborhood.Exercise118
import Domain.Neighborhood.Theorem41

/-!
# Exercise 4.13 (Scott 1981, PRG-19, Lecture IV) — eliminating the circularity

The proof of Theorem 4.1 uses the integers (the chain `fⁿ(⊥)`), whereas the proof of Theorem 4.6
uses 4.1 — *a hint of circularity*. Scott shows it can be eliminated:

**(1)** If a domain `𝒟` has an element `a` where, for `f : 𝒟 → 𝒟`, the relation `f(a) ⊑ a` holds,
then the least fixed point can be defined *without* the integers, purely by a greatest-lower-bound:

  `fix(f) = ⋂ {x ∈ |𝒟| ∣ f(x) ⊑ x}`,

and `fix(f) ⊑ a`. Here `b = ⋂{…}` is a well-defined element by Exercise 1.18 (`sInf`, the
intersection of a non-empty family of filters). The argument uses **only the monotonicity** of
`f : |𝒟| → |𝒟|` — no directed sups, no integers:

* `f(b) ⊑ x` whenever `f(x) ⊑ x` (since `b ⊑ x` so `f(b) ⊑ f(x) ⊑ x`), hence `f(b) ⊑ b`;
* then `f(f(b)) ⊑ f(b)`, so `b ⊑ f(b)` too; thus `b = f(b)`;
* `b` is least among pre-fixed points, in particular the least fixed point.

This is `monoFix` / `monoFix_isFixed` / `monoFix_least` / `monoFix_le_preFix` below. It is entirely
**choice-free** (`#print axioms ⊆ {propext, Quot.sound}`).

**(2)** The argument uses only monotonicity, and `(1)` *always* applies to power-set domains `P A`
(take `a = A`, the top element, where `f(A) ⊑ A` is automatic) — see Exercise 4.14.

**(3)** With `(1)` one re-establishes the recursion principle behind 4.6 directly: for any structured
set `⟨Z, z, ·⟩` there is a *unique* `s : ℕ → Z` with `s(0) = z` and `s(n⁺) = s(n)·`
(`exists_unique_nat_rec`). This is the choice-free primitive recursion theorem; combined with `(1)`
it removes the circularity (one no longer needs 4.1 to build the iteration).

**(4)** Specializing `(3)` to `⟨ℕ, 0, ⁺⟩` recovers the very iteration `n ↦ fⁿ` used in 4.1
(`nat_iterate_unique`), closing the loop without circularity.
-/

namespace Domain.Neighborhood

open NeighborhoodSystem

variable {α : Type*} {V : NeighborhoodSystem α}

namespace NeighborhoodSystem

/-! ### (1) The least fixed point of a monotone map via intersection. -/

/-- The set of *pre-fixed points* `{x ∣ f(x) ⊑ x}` of `f`. -/
def preFix (f : V.Element → V.Element) : Set V.Element := {x | f x ≤ x}

@[simp] theorem mem_preFix {f : V.Element → V.Element} {x : V.Element} :
    x ∈ preFix f ↔ f x ≤ x := Iff.rfl

/-- **Exercise 4.13(1) (Scott 1981, PRG-19).** The least fixed point of a *monotone* `f` defined
purely as the greatest lower bound of the pre-fixed points, `⋂ {x ∣ f(x) ⊑ x}`. Well-defined as an
element by Exercise 1.18 (`sInf`); the non-emptiness witness is any `a` with `f(a) ⊑ a`. -/
def monoFix (f : V.Element → V.Element) {a : V.Element} (ha : f a ≤ a) : V.Element :=
  V.sInf (preFix f) ⟨a, ha⟩

/-- `monoFix f ha ⊑ x` for every pre-fixed point `x` (`f(x) ⊑ x`). -/
theorem monoFix_le_preFix (f : V.Element → V.Element) {a : V.Element} (ha : f a ≤ a)
    {x : V.Element} (hx : f x ≤ x) : monoFix f ha ≤ x :=
  V.sInf_le (preFix f) ⟨a, ha⟩ hx

/-- `monoFix f ha ⊑ a`: the least fixed point lies below the given pre-fixed point `a`. -/
theorem monoFix_le (f : V.Element → V.Element) {a : V.Element} (ha : f a ≤ a) :
    monoFix f ha ≤ a := monoFix_le_preFix f ha ha

/-- The key step: `f(b) ⊑ b` where `b = monoFix f ha`, by monotonicity alone. -/
theorem monoFix_preFix (f : V.Element → V.Element) (hf : Monotone f) {a : V.Element}
    (ha : f a ≤ a) : f (monoFix f ha) ≤ monoFix f ha := by
  apply V.le_sInf (preFix f) ⟨a, ha⟩
  intro x hx
  exact le_trans (hf (monoFix_le_preFix f ha hx)) hx

/-- **Exercise 4.13(1) (Scott 1981, PRG-19).** `monoFix f ha` is a fixed point: `f(b) = b`. (After
`f(b) ⊑ b`, monotonicity gives `f(f(b)) ⊑ f(b)`, so `f(b)` is itself a pre-fixed point, whence
`b ⊑ f(b)`.) -/
theorem monoFix_isFixed (f : V.Element → V.Element) (hf : Monotone f) {a : V.Element}
    (ha : f a ≤ a) : f (monoFix f ha) = monoFix f ha := by
  have hfb : f (monoFix f ha) ≤ monoFix f ha := monoFix_preFix f hf ha
  have hbf : monoFix f ha ≤ f (monoFix f ha) :=
    monoFix_le_preFix f ha (hf hfb)
  exact le_antisymm hfb hbf

/-- **Exercise 4.13(1) (Scott 1981, PRG-19).** `monoFix f ha` is the *least* fixed point: any `y`
with `f(y) = y` satisfies `b ⊑ y`. -/
theorem monoFix_least (f : V.Element → V.Element) {a : V.Element} (ha : f a ≤ a)
    {y : V.Element} (hy : f y = y) : monoFix f ha ≤ y :=
  monoFix_le_preFix f ha (le_of_eq hy)

/-! ### (3) The primitive-recursion theorem (choice-free), behind 4.6. -/

/-- **Exercise 4.13(3) (Scott 1981, PRG-19).** For any structured set `⟨Z, z, ·⟩` (`z : Z`,
`op : Z → Z`) there is a *unique* `s : ℕ → Z` with `s(0) = z` and `s(n⁺) = (s n)·`. This is the
choice-free recursion principle (`Nat.rec`); together with 4.13(1) it eliminates the circularity in
the proofs of 4.1 and 4.6. -/
theorem exists_unique_nat_rec {Z : Type*} (z : Z) (op : Z → Z) :
    ∃! s : ℕ → Z, s 0 = z ∧ ∀ n, s (n + 1) = op (s n) := by
  refine ⟨fun n => Nat.rec z (fun _ x => op x) n, ⟨rfl, fun _ => rfl⟩, ?_⟩
  rintro s ⟨h0, hsucc⟩
  funext n
  induction n with
  | zero => exact h0
  | succ k ih => rw [hsucc k, ih]

/-! ### (4) Specialization to `⟨ℕ, 0, ⁺⟩`. -/

/-- **Exercise 4.13(4) (Scott 1981, PRG-19).** Specializing 4.13(3) to the structured set
`⟨ℕ, 0, ⁺⟩`: the *unique* function `s` with `s(0) = 0` and `s(n⁺) = (s n)⁺` is the identity. This
is the iteration `n ↦ fⁿ` underlying Theorem 4.1, now justified without circularity. -/
theorem nat_iterate_unique {s : ℕ → ℕ} (h0 : s 0 = 0) (hsucc : ∀ n, s (n + 1) = s n + 1) :
    ∀ n, s n = n := by
  intro n
  induction n with
  | zero => exact h0
  | succ k ih => rw [hsucc k, ih]

end NeighborhoodSystem

end Domain.Neighborhood
