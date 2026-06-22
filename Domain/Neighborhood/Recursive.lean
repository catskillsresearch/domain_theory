import Mathlib.Data.Nat.Sqrt
import Mathlib.Data.Nat.Pairing
import Mathlib.Computability.Partrec

/-!
# A choice-free recursion theory for Lecture VII (Scott 1981, PRG-19)

**Why this file exists — we roll our own and reject mathlib's recursion theory here.**
Lecture VII ("Computability in effectively given domains") needs the notions *recursively
decidable* and *recursively enumerable*. mathlib *has* these (`Computable`, `ComputablePred`,
`REPred`, `Primrec`, `Partrec`), but in mathlib `v4.30.0` essentially every *correctness lemma* of
that development is proved with tactics (`grind`, `lia`) or wrapper lemmas that **open
`Classical`** — e.g. `Computable.const`, `Primrec.const`, `Nat.unpair_pair`, `Nat.sqrt_le`, and
`Nat.Primrec.add`/`mul` all audit with `Classical.choice` in their axiom set. This project's
discipline is to keep *data* (and as much as possible) **choice-free** (`⊆ {propext, Quot.sound}`),
so we deliberately decline mathlib's classical recursion theory and instead build the slice we need
on the genuinely choice-free foundations: the raw inductives `Nat.Primrec` / `Nat.Partrec` (whose
*constructors* are choice-free) and `Nat.sqrt` / `Nat.pair` / `Nat.unpair` (whose *definitions* are
choice-free). The only tactic we lean on for arithmetic is `omega`, which is choice-free here
(unlike `grind`/`lia`).

The pattern: a relation on integer indices is *recursive* (decidable) when it has a
**primitive-recursive characteristic function** (`Nat.Primrec`, lifted to `Nat.Partrec` for the
recursive/`REPred` analogues). Tuples are encoded with `Nat.pair` (choice-free), and we reprove the
pairing round-trips (`unpair_pair'`, `pair_unpair'`) choice-free here.

Everything in this file is `⊆ {propext, Quot.sound}`.
-/

namespace Domain.Recursive

/-! ## Choice-free `Nat.sqrt` correctness

mathlib's `Nat.sqrt.iter_sq_le` / `Nat.sqrt.lt_iter_succ_sq` are the heart of `Nat.sqrt`'s
correctness, but they use `grind` / `lia` (classical). We reprove them with `omega`. -/

/-- **AM–GM for naturals (choice-free).** `4 a b ≤ (a+b)²`. Faithful port of mathlib's `private`
`Nat.AM_GM` (no classical tactics). -/
theorem amGM : ∀ {a b : ℕ}, 4 * a * b ≤ (a + b) * (a + b)
  | 0, _ => by rw [Nat.mul_zero, Nat.zero_mul]; exact Nat.zero_le _
  | _, 0 => by rw [Nat.mul_zero]; exact Nat.zero_le _
  | a + 1, b + 1 => by
    simpa only [Nat.mul_add, Nat.add_mul, show (4 : ℕ) = 1 + 1 + 1 + 1 from rfl, Nat.one_mul,
      Nat.mul_one, Nat.add_assoc, Nat.add_left_comm, Nat.add_le_add_iff_left]
      using Nat.add_le_add_right (@amGM a b) 4

/-- **Choice-free `sqrt.iter` lower bound.** `iter n guess ² ≤ n`. Faithful port of
`Nat.sqrt.iter_sq_le`, with `grind` replaced by `omega`. -/
theorem iter_sq_le (n guess : ℕ) : Nat.sqrt.iter n guess * Nat.sqrt.iter n guess ≤ n := by
  unfold Nat.sqrt.iter
  if h : (guess + n / guess) / 2 < guess then
    rw [dif_pos h]
    exact iter_sq_le n ((guess + n / guess) / 2)
  else
    rw [dif_neg h]
    apply Nat.mul_le_of_le_div
    omega
  termination_by guess
  decreasing_by exact h

/-- Choice-free left-cancellation for `<` under `*` (mathlib's `Nat.lt_of_mul_lt_mul_left` is
classical). From `a*b < a*c` deduce `b < c`, by the contrapositive `c ≤ b → a*c ≤ a*b`. -/
theorem lt_of_mul_lt_mul_left' {a b c : ℕ} (h : a * b < a * c) : b < c := by
  rcases Nat.lt_or_ge b c with hbc | hbc
  · exact hbc
  · exact absurd h (Nat.not_lt.mpr (Nat.mul_le_mul_left a hbc))

/-- **Choice-free `sqrt.iter` upper bound.** If `n < (guess+1)²` then `n < (iter n guess + 1)²`.
Faithful port of `Nat.sqrt.lt_iter_succ_sq`, with `lia` replaced by `omega`. -/
theorem lt_iter_succ_sq (n guess : ℕ) (hn : n < (guess + 1) * (guess + 1)) :
    n < (Nat.sqrt.iter n guess + 1) * (Nat.sqrt.iter n guess + 1) := by
  unfold Nat.sqrt.iter
  if h : (guess + n / guess) / 2 < guess then
    rw [dif_pos h]
    suffices hsuff : n < ((guess + n / guess) / 2 + 1) * ((guess + n / guess) / 2 + 1) from
      lt_iter_succ_sq n ((guess + n / guess) / 2) hsuff
    refine lt_of_mul_lt_mul_left' (a := 4 * (guess * guess)) ?_
    apply Nat.lt_of_le_of_lt amGM
    rw [show (4 : ℕ) = 2 * 2 from rfl]
    rw [Nat.mul_mul_mul_comm 2, Nat.mul_mul_mul_comm (2 * guess)]
    refine Nat.mul_self_lt_mul_self (?_ : _ < _ * ((_ / 2) + 1))
    rw [← Nat.add_div_right _ (by decide), Nat.mul_comm 2, Nat.mul_assoc,
      show guess + n / guess + 2 = (guess + n / guess + 1) + 1 from rfl]
    have aux : (guess + n / guess + 1) ≤ 2 * ((guess + n / guess + 1 + 1) / 2) := by omega
    refine lt_of_lt_of_le ?_ (Nat.mul_le_mul_left _ aux)
    rw [Nat.add_assoc, Nat.mul_add]
    exact Nat.add_lt_add_left
      (Nat.lt_mul_div_succ _ (lt_of_le_of_lt (Nat.zero_le _) h)) _
  else
    rw [dif_neg h]
    exact hn
  termination_by guess
  decreasing_by exact h

/-- `sqrt n` squared is `≤ n` (choice-free; mathlib's `Nat.sqrt_le` is classical). -/
theorem sqrt_le (n : ℕ) : Nat.sqrt n * Nat.sqrt n ≤ n := by
  rcases Nat.lt_or_ge 1 n with h | h
  · rw [Nat.sqrt, if_neg (Nat.not_le.mpr h)]
    exact iter_sq_le _ _
  · rw [Nat.sqrt, if_pos h]
    calc n * n ≤ 1 * n := Nat.mul_le_mul_right n h
      _ = n := Nat.one_mul n

/-- `n < (sqrt n + 1)²` (choice-free; mathlib's `Nat.lt_succ_sqrt` is classical). The initial guess
`2 ^ (log₂ n / 2 + 1)` over-shoots `√n`, which feeds `lt_iter_succ_sq`. -/
theorem lt_succ_sqrt (n : ℕ) : n < (Nat.sqrt n + 1) * (Nat.sqrt n + 1) := by
  rcases Nat.lt_or_ge 1 n with h | h
  · rw [Nat.sqrt, if_neg (Nat.not_le.mpr h)]
    refine lt_iter_succ_sq _ _ ?_
    set g := 1 <<< (n.log2 / 2 + 1) with hg
    have hshift : g = 2 ^ (n.log2 / 2 + 1) := by rw [hg, Nat.shiftLeft_eq, Nat.one_mul]
    have hgg : g * g = 2 ^ (2 * (n.log2 / 2 + 1)) := by
      rw [hshift, ← pow_add]; congr 1; omega
    calc n < 2 ^ (n.log2 + 1) := Nat.lt_log2_self
      _ ≤ 2 ^ (2 * (n.log2 / 2 + 1)) := Nat.pow_le_pow_right (by decide) (by omega)
      _ = g * g := hgg.symm
      _ ≤ (g + 1) * (g + 1) := Nat.mul_le_mul (Nat.le_succ g) (Nat.le_succ g)
  · rw [Nat.sqrt, if_pos h]
    exact Nat.lt_of_lt_of_le (Nat.lt_succ_self n)
      (Nat.le_mul_of_pos_right (n + 1) (Nat.succ_pos n))

/-- **The square-root characterization (choice-free).** If `q² ≤ m < (q+1)²` then `sqrt m = q`. The
uniqueness step is `omega` from the two bounds plus `sqrt_le`/`lt_succ_sqrt`. -/
theorem sqrt_eq_of {m q : ℕ} (h1 : q * q ≤ m) (h2 : m < (q + 1) * (q + 1)) : Nat.sqrt m = q := by
  have hle := sqrt_le m
  have hlt := lt_succ_sqrt m
  have hq_le : q ≤ Nat.sqrt m := by
    rcases Nat.lt_or_ge (Nat.sqrt m) q with hh | hh
    · exfalso
      have ha : Nat.sqrt m + 1 ≤ q := hh
      have hmul : (Nat.sqrt m + 1) * (Nat.sqrt m + 1) ≤ q * q := Nat.mul_le_mul ha ha
      omega
    · exact hh
  have hle_q : Nat.sqrt m ≤ q := by
    rcases Nat.lt_or_ge q (Nat.sqrt m) with hh | hh
    · exfalso
      have ha : q + 1 ≤ Nat.sqrt m := hh
      have hmul : (q + 1) * (q + 1) ≤ Nat.sqrt m * Nat.sqrt m := Nat.mul_le_mul ha ha
      omega
    · exact hh
  omega

/-- `sqrt (q² + a) = q` whenever `a ≤ 2q` (choice-free; mathlib's `Nat.sqrt_add_eq` is classical). -/
theorem sqrt_add_eq (q a : ℕ) (h : a ≤ q + q) : Nat.sqrt (q * q + a) = q := by
  refine sqrt_eq_of (Nat.le_add_right _ _) ?_
  have expand : (q + 1) * (q + 1) = q * q + q + q + 1 := Nat.succ_mul_succ q q
  omega

/-! ## Choice-free pairing round-trip

`Nat.pair`/`Nat.unpair` are themselves choice-free *definitions*; only mathlib's `unpair_pair`
*lemma* (via `sqrt_add_eq`) is classical. We reprove the round-trip on our choice-free `sqrt`. -/

/-- **`unpair ∘ pair = id` (choice-free).** Mirrors `Nat.unpair_pair`. -/
theorem unpair_pair (a b : ℕ) : Nat.unpair (Nat.pair a b) = (a, b) := by
  rw [Nat.pair]
  if h : a < b then
    rw [if_pos h]
    show Nat.unpair (b * b + a) = (a, b)
    have be : Nat.sqrt (b * b + a) = b := sqrt_add_eq b a (by omega)
    simp only [Nat.unpair, be, Nat.add_sub_cancel_left, if_pos h]
  else
    rw [if_neg h]
    show Nat.unpair (a * a + a + b) = (a, b)
    have ae : Nat.sqrt (a * a + a + b) = a := by
      have e : a * a + a + b = a * a + (a + b) := by omega
      rw [e]; exact sqrt_add_eq a (a + b) (by omega)
    have e1 : a * a + a + b - a * a = a + b := by omega
    have e2 : ¬ a + b < a := by omega
    have e3 : a + b - a = b := by omega
    simp only [Nat.unpair, ae, e1, if_neg e2, e3]

/-- First projection of the pairing round-trip. -/
@[simp] theorem unpair_pair_fst (a b : ℕ) : (Nat.pair a b).unpair.1 = a := by rw [unpair_pair]

/-- Second projection of the pairing round-trip. -/
@[simp] theorem unpair_pair_snd (a b : ℕ) : (Nat.pair a b).unpair.2 = b := by rw [unpair_pair]

/-- `n ≤ (sqrt n)² + 2·sqrt n` (choice-free; needed for `pair_unpair`). -/
theorem sqrt_le_add (n : ℕ) : n ≤ Nat.sqrt n * Nat.sqrt n + Nat.sqrt n + Nat.sqrt n := by
  have h := lt_succ_sqrt n
  have e : (Nat.sqrt n + 1) * (Nat.sqrt n + 1)
      = Nat.sqrt n * Nat.sqrt n + Nat.sqrt n + Nat.sqrt n + 1 := Nat.succ_mul_succ _ _
  omega

/-- **`pair ∘ unpair = id` (choice-free).** Mirrors `Nat.pair_unpair`. -/
theorem pair_unpair (n : ℕ) : Nat.pair (Nat.unpair n).1 (Nat.unpair n).2 = n := by
  have sm : Nat.sqrt n * Nat.sqrt n + (n - Nat.sqrt n * Nat.sqrt n) = n :=
    Nat.add_sub_cancel' (sqrt_le _)
  have hadd := sqrt_le_add n
  rw [Nat.unpair]
  if h : n - Nat.sqrt n * Nat.sqrt n < Nat.sqrt n then
    rw [if_pos h]
    show Nat.pair (n - Nat.sqrt n * Nat.sqrt n) (Nat.sqrt n) = n
    rw [Nat.pair, if_pos h]
    omega
  else
    rw [if_neg h]
    have hge : Nat.sqrt n ≤ n - Nat.sqrt n * Nat.sqrt n := Nat.le_of_not_lt h
    have hlt : ¬ Nat.sqrt n < n - Nat.sqrt n * Nat.sqrt n - Nat.sqrt n := by omega
    show Nat.pair (Nat.sqrt n) (n - Nat.sqrt n * Nat.sqrt n - Nat.sqrt n) = n
    rw [Nat.pair, if_neg hlt]
    omega

/-! ## Choice-free primitive-recursive arithmetic

mathlib's `Nat.Primrec.id/add/mul` are proved with `by simp`, which silently applies the *classical*
`@[simp] Nat.unpair_pair`; so they audit with `Classical.choice`. We reprove the few we need using
the choice-free round-trips above. The *constructors* of `Nat.Primrec`
(`zero/succ/left/right/pair/comp/prec`) are choice-free and used directly. -/

/-- `id` is primitive recursive (choice-free). -/
theorem primrec_id : Nat.Primrec id :=
  (Nat.Primrec.left.pair Nat.Primrec.right).of_eq fun n => pair_unpair n

/-- The `prec` recursor for addition computes the sum. -/
private theorem rec_add (a b : ℕ) : Nat.rec a (fun _ IH => IH + 1) b = a + b := by
  induction b with
  | zero => rfl
  | succ k ih => show Nat.rec a (fun _ IH => IH + 1) k + 1 = a + (k + 1); omega

/-- The `prec` recursor for multiplication computes the product. -/
private theorem rec_mul (a b : ℕ) : Nat.rec 0 (fun _ IH => a + IH) b = a * b := by
  induction b with
  | zero => rfl
  | succ k ih =>
    show a + Nat.rec 0 (fun _ IH => a + IH) k = a * (k + 1)
    rw [Nat.mul_succ]; omega

/-- Addition is primitive recursive (choice-free). -/
theorem primrec_add : Nat.Primrec (Nat.unpaired (· + ·)) :=
  (Nat.Primrec.prec primrec_id
      ((Nat.Primrec.succ.comp Nat.Primrec.right).comp Nat.Primrec.right)).of_eq fun p => by
    simp only [unpair_pair_snd, id_eq]
    exact rec_add _ _

/-- Multiplication is primitive recursive (choice-free). -/
theorem primrec_mul : Nat.Primrec (Nat.unpaired (· * ·)) :=
  (Nat.Primrec.prec Nat.Primrec.zero
      (primrec_add.comp (Nat.Primrec.pair Nat.Primrec.left
        (Nat.Primrec.right.comp Nat.Primrec.right)))).of_eq fun p => by
    simp only [unpair_pair_fst, unpair_pair_snd, Nat.unpaired]
    exact rec_mul _ _

/-- `a * b = 1 ↔ a = 1 ∧ b = 1` over `ℕ` (choice-free; avoids the classical generic `mul_eq_one`). -/
theorem nat_mul_eq_one {a b : ℕ} : a * b = 1 ↔ a = 1 ∧ b = 1 := by
  refine ⟨fun h => ⟨Nat.dvd_one.mp ⟨b, h.symm⟩, Nat.dvd_one.mp ⟨a, ?_⟩⟩, fun h => by rw [h.1, h.2]⟩
  rw [Nat.mul_comm] at h; exact h.symm

/-! ## "Recursively decidable" predicates (Scott's notion, Definition 7.1)

A predicate is recursively decidable when it has a primitive-recursive `{0,1}`-valued characteristic
function. Tuples are coded by `Nat.pair`. These are the building blocks Scott's Definition 7.1 needs
(relations on indices), and the closure lemmas (`of_iff`, `comp` = reindex, `and`) let us derive the
inclusion- and equality-deciders. All choice-free. -/

/-- A unary predicate `p : ℕ → Prop` is **recursively decidable**. -/
def RecDecidable (p : ℕ → Prop) : Prop :=
  ∃ f : ℕ → ℕ, Nat.Primrec f ∧ ∀ n, p n ↔ f n = 1

/-- A binary relation is recursively decidable when its `Nat.pair`-coding is. -/
def RecDecidable₂ (r : ℕ → ℕ → Prop) : Prop :=
  RecDecidable fun t => r t.unpair.1 t.unpair.2

/-- A ternary relation is recursively decidable when its `Nat.pair`-coding (`pair n (pair m k)`) is. -/
def RecDecidable₃ (r : ℕ → ℕ → ℕ → Prop) : Prop :=
  RecDecidable fun t => r t.unpair.1 t.unpair.2.unpair.1 t.unpair.2.unpair.2

/-- Recursive decidability transfers across a pointwise logical equivalence. -/
theorem RecDecidable.of_iff {p q : ℕ → Prop} (h : ∀ n, q n ↔ p n) (hp : RecDecidable p) :
    RecDecidable q := by
  obtain ⟨f, hf, hfe⟩ := hp
  exact ⟨f, hf, fun n => (h n).trans (hfe n)⟩

/-- **Reindexing.** If `p` is recursively decidable and `g` is primitive recursive, then
`fun n => p (g n)` is recursively decidable. -/
theorem RecDecidable.comp {p : ℕ → Prop} (hp : RecDecidable p) {g : ℕ → ℕ}
    (hg : Nat.Primrec g) : RecDecidable (fun n => p (g n)) := by
  obtain ⟨f, hf, hfe⟩ := hp
  exact ⟨fun n => f (g n), hf.comp hg, fun n => hfe (g n)⟩

/-- **Conjunction.** Recursive decidability is closed under `∧` (multiply the `{0,1}` deciders). -/
theorem RecDecidable.and {p q : ℕ → Prop} (hp : RecDecidable p) (hq : RecDecidable q) :
    RecDecidable (fun n => p n ∧ q n) := by
  obtain ⟨f, hf, hfe⟩ := hp
  obtain ⟨g, hg, hge⟩ := hq
  refine ⟨fun n => f n * g n, ?_, fun n => ?_⟩
  · exact (primrec_mul.comp (hf.pair hg)).of_eq fun n => by
      simp only [Nat.unpaired, unpair_pair_fst, unpair_pair_snd]
  · rw [nat_mul_eq_one]; exact and_congr (hfe n) (hge n)

/-- An always-true predicate is recursively decidable (constant decider `1`). -/
theorem recDecidable_of_forall {p : ℕ → Prop} (h : ∀ n, p n) : RecDecidable p :=
  ⟨fun _ => 1, Nat.Primrec.const 1, fun n => ⟨fun _ => rfl, fun _ => h n⟩⟩

/-! ## "Recursively enumerable" predicates (Scott's notion, Definition 7.2)

Scott's Definition 7.2 asks for the neighbourhood relation `Xₙ f Yₘ` to be *recursively
enumerable*. We model "recursively enumerable" choice-free as a **projection of a recursively
decidable relation**: `p` is r.e. iff there is a recursively decidable `q` with
`p n ↔ ∃ i, q ⟨i, n⟩` (the search variable `i` is paired with `n` via `Nat.pair`). This is the
standard equivalent of Scott's prose description — "there is a primitive recursive `r` with
`y = {Y_{r(i)} ∣ i ∈ ℕ}`": the projection form additionally represents the empty set (take `q`
identically false), exactly as r.e. sets require. Every recursively decidable predicate is r.e.
(`RecDecidable.re`, dropping the search variable), and r.e.-ness transfers across pointwise
equivalence (`REPred.of_iff`). All choice-free. -/

/-- A unary predicate `p : ℕ → Prop` is **recursively enumerable**: it is the projection of a
recursively decidable relation, `p n ↔ ∃ i, q (Nat.pair i n)`. -/
def REPred (p : ℕ → Prop) : Prop :=
  ∃ q : ℕ → Prop, RecDecidable q ∧ ∀ n, p n ↔ ∃ i, q (Nat.pair i n)

/-- A binary relation is recursively enumerable when its `Nat.pair`-coding is. -/
def REPred₂ (r : ℕ → ℕ → Prop) : Prop :=
  REPred fun t => r t.unpair.1 t.unpair.2

/-- **Every recursively decidable predicate is recursively enumerable.** Use the decider as the
relation `q ⟨i, n⟩ := p n` (a reindex of `p` along `unpair.2`, dropping the search variable `i`); the
witness `i = 0` makes the projection trivial. -/
theorem RecDecidable.re {p : ℕ → Prop} (hp : RecDecidable p) : REPred p := by
  refine ⟨fun t => p t.unpair.2, hp.comp Nat.Primrec.right, fun n => ?_⟩
  simp only [unpair_pair_snd]
  exact ⟨fun h => ⟨0, h⟩, fun ⟨_, h⟩ => h⟩

/-- A recursively decidable binary relation is recursively enumerable. -/
theorem RecDecidable₂.re {r : ℕ → ℕ → Prop} (hr : RecDecidable₂ r) : REPred₂ r :=
  RecDecidable.re hr

/-- Recursive enumerability transfers across a pointwise logical equivalence. -/
theorem REPred.of_iff {p q : ℕ → Prop} (h : ∀ n, q n ↔ p n) (hp : REPred p) : REPred q := by
  obtain ⟨r, hr, hre⟩ := hp
  exact ⟨r, hr, fun n => (h n).trans (hre n)⟩

/-- An always-true predicate is recursively enumerable. -/
theorem rePred_of_forall {p : ℕ → Prop} (h : ∀ n, p n) : REPred p :=
  (recDecidable_of_forall h).re

end Domain.Recursive
