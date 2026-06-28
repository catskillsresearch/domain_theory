import Domain.Neighborhood.Exercise722DFA
import Domain.Neighborhood.Exercise722Cat

/-!
# Exercise 7.22 — every fragment expression has a `Fintype` automaton (`denote e = accepts`)

Assembles the leaf automata (`Exercise722DFA.lean`) and the concatenation automaton
(`Exercise722Cat.lean`) into a single uniform recogniser

  `toNFA : (e : SExpr) → NFA Bool (autState e)`     with     `toNFA_accepts : (toNFA e).accepts = denote e`

where the state type `autState e` is a `Fintype` (built from `Unit`, `Option (Fin _)`, `×`, `⊕`).
This is the constructive, **choice-free** realisation of Scott's "the sets in `S` are regular events":
every fragment language is the accepted language of an explicit finite automaton. It is the platform
for the emptiness/equivalence decision procedure (and hence Definition 7.1 effective givenness).

The missing combinator beyond the leaves+`cat` is intersection, handled here by the standard product
construction `NFAinter` (mathlib has `DFA.inter` but no `NFA` intersection).
-/

namespace Domain.Neighborhood

namespace Exercise722

open scoped Computability
open Sum Set

variable {σ₁ σ₂ : Type}

/-! ## NFA intersection (product) -/

/-- Product NFA recognising the intersection: states `σ₁ × σ₂`, stepping/starting/accepting
componentwise. -/
def NFAinter (M₁ : NFA Bool σ₁) (M₂ : NFA Bool σ₂) : NFA Bool (σ₁ × σ₂) where
  step s a := {t | t.1 ∈ M₁.step s.1 a ∧ t.2 ∈ M₂.step s.2 a}
  start := {s | s.1 ∈ M₁.start ∧ s.2 ∈ M₂.start}
  accept := {s | s.1 ∈ M₁.accept ∧ s.2 ∈ M₂.accept}

variable (M₁ : NFA Bool σ₁) (M₂ : NFA Bool σ₂)

theorem NFAinter_mem_eval_iff (x : List Bool) (p : σ₁ × σ₂) :
    p ∈ (NFAinter M₁ M₂).eval x ↔ p.1 ∈ M₁.eval x ∧ p.2 ∈ M₂.eval x := by
  induction x using List.reverseRecOn generalizing p with
  | nil => exact Iff.rfl
  | append_singleton x a ih =>
    rw [NFA.eval_append_singleton, NFA.mem_stepSet]
    constructor
    · rintro ⟨q, hq, hstep⟩
      rw [ih] at hq
      rw [NFA.eval_append_singleton, NFA.mem_stepSet, NFA.eval_append_singleton, NFA.mem_stepSet]
      exact ⟨⟨q.1, hq.1, hstep.1⟩, ⟨q.2, hq.2, hstep.2⟩⟩
    · rintro ⟨h1, h2⟩
      rw [NFA.eval_append_singleton, NFA.mem_stepSet] at h1 h2
      obtain ⟨q1, hq1, hs1⟩ := h1
      obtain ⟨q2, hq2, hs2⟩ := h2
      exact ⟨(q1, q2), (ih (q1, q2)).mpr ⟨hq1, hq2⟩, hs1, hs2⟩

theorem NFAinter_mem_accepts_iff (x : List Bool) :
    x ∈ (NFAinter M₁ M₂).accepts ↔ x ∈ M₁.accepts ∧ x ∈ M₂.accepts := by
  constructor
  · rintro ⟨p, hp, hpe⟩
    rw [NFAinter_mem_eval_iff] at hpe
    exact ⟨⟨p.1, hp.1, hpe.1⟩, ⟨p.2, hp.2, hpe.2⟩⟩
  · rintro ⟨⟨s, hs, hse⟩, ⟨t, ht, hte⟩⟩
    exact ⟨(s, t), ⟨hs, ht⟩, (NFAinter_mem_eval_iff M₁ M₂ x (s, t)).mpr ⟨hse, hte⟩⟩

/-! ## Choice-free DFA → NFA recognition

mathlib's `DFA.toNFA_correct` depends on `Classical.choice`; we reprove it choice-free (the leaf
automata are DFAs, so the uniform `toNFA` must convert them without pulling choice). -/

/-- The NFA from a DFA tracks the single deterministic state as a singleton. -/
theorem dfaToNFA_eval {σ : Type} (M : DFA Bool σ) (x : List Bool) :
    M.toNFA.eval x = {M.eval x} := by
  induction x using List.reverseRecOn with
  | nil => rfl
  | append_singleton x a ih =>
    rw [NFA.eval_append_singleton, ih]
    ext s
    rw [NFA.mem_stepSet]
    constructor
    · rintro ⟨t, ht, hs⟩
      rw [Set.mem_singleton_iff] at ht
      subst ht
      rw [Set.mem_singleton_iff, DFA.eval_append_singleton]
      exact hs
    · intro hs
      rw [Set.mem_singleton_iff, DFA.eval_append_singleton] at hs
      exact ⟨M.eval x, Set.mem_singleton _, hs⟩

/-- Choice-free version of `DFA.toNFA_correct`. -/
theorem dfaToNFA_accepts {σ : Type} (M : DFA Bool σ) : M.toNFA.accepts = M.accepts := by
  ext x
  constructor
  · rintro ⟨S, hS, hSe⟩
    rw [dfaToNFA_eval, Set.mem_singleton_iff] at hSe
    rw [DFA.mem_accepts, ← hSe]
    exact hS
  · intro hx
    rw [DFA.mem_accepts] at hx
    exact ⟨M.eval x, hx, by rw [dfaToNFA_eval]; exact Set.mem_singleton _⟩

/-! ## The uniform recogniser `toNFA` -/

/-- State type of the automaton for an `SExpr` (a `Fintype`, see `instFintypeAutState`). -/
def autState : SExpr → Type
  | .sigma => Unit
  | .single σ => Option (Fin (σ.length + 1))
  | .cap a b => autState a × autState b
  | .cat a b => autState a ⊕ autState b

instance instFintypeAutState : (e : SExpr) → Fintype (autState e)
  | .sigma => inferInstanceAs (Fintype Unit)
  | .single σ => inferInstanceAs (Fintype (Option (Fin (σ.length + 1))))
  | .cap a b => by
      letI := instFintypeAutState a; letI := instFintypeAutState b
      exact inferInstanceAs (Fintype (autState a × autState b))
  | .cat a b => by
      letI := instFintypeAutState a; letI := instFintypeAutState b
      exact inferInstanceAs (Fintype (autState a ⊕ autState b))

/-- The uniform automaton for a fragment expression: leaves from `Exercise722DFA.lean`, `cap` by the
product construction, `cat` by the concatenation automaton (`Exercise722Cat.lean`). -/
def toNFA : (e : SExpr) → NFA Bool (autState e)
  | .sigma => sigmaDFA.toNFA
  | .single σ => (singleDFA σ).toNFA
  | .cap a b => NFAinter (toNFA a) (toNFA b)
  | .cat a b => (catEps (toNFA a) (toNFA b)).toNFA

/-- **The automaton recognises exactly the language it should.** -/
theorem toNFA_accepts : (e : SExpr) → (toNFA e).accepts = denote e
  | .sigma => by
      change sigmaDFA.toNFA.accepts = denote .sigma
      rw [dfaToNFA_accepts sigmaDFA, sigmaDFA_accepts, denote_sigma]
  | .single σ => by
      change (singleDFA σ).toNFA.accepts = denote (.single σ)
      rw [dfaToNFA_accepts (singleDFA σ)]
      exact singleDFA_accepts_denote σ
  | .cap a b => by
      ext x
      change x ∈ (NFAinter (toNFA a) (toNFA b)).accepts ↔ _
      rw [NFAinter_mem_accepts_iff, toNFA_accepts a, toNFA_accepts b, denote_cap]
      exact (Set.mem_inter_iff x (denote a) (denote b)).symm
  | .cat a b => by
      change (catEps (toNFA a) (toNFA b)).toNFA.accepts = denote (.cat a b)
      rw [εNFA.toNFA_correct, catEps_accepts, toNFA_accepts a, toNFA_accepts b, denote_cat]

/-! ## Emptiness reduces to reachability of an accept state

Since the state space is a `Fintype`, this reduces Definition 7.1's relation (ii) — consistency,
which by positivity of `Ssys` (`Exercise722.lean`) is exactly `∩`-non-emptiness — to a **finite**
reachability question. The two clean routes to a primitive-recursive decider from here are flagged in
the module docstring of `Exercise722DFA.lean`. -/

variable {σ : Type}

/-- A nonempty accepted language ⟺ some accept state is reachable by reading some word. -/
theorem nfa_accepts_nonempty_iff (M : NFA Bool σ) :
    M.accepts.Nonempty ↔ ∃ s ∈ M.accept, ∃ x, s ∈ M.eval x := by
  constructor
  · rintro ⟨x, S, hS, hSe⟩; exact ⟨S, hS, x, hSe⟩
  · rintro ⟨S, hS, x, hSe⟩; exact ⟨x, S, hS, hSe⟩

/-- **Definition 7.1 relation (ii) as a reachability problem.** `denote e` is empty iff no accept
state of its `Fintype` automaton is reachable. The right-hand side ranges over the finite state set
`autState e`; the only non-finite-looking quantifier (`∀ x`) is what a reachability search eliminates. -/
theorem denote_eq_empty_iff (e : SExpr) :
    denote e = ∅ ↔ ∀ s ∈ (toNFA e).accept, ∀ x, s ∉ (toNFA e).eval x := by
  rw [Set.eq_empty_iff_forall_notMem]
  constructor
  · intro h s hs x hse
    exact h x (by rw [← toNFA_accepts e]; exact ⟨s, hs, hse⟩)
  · intro h x hx
    rw [← toNFA_accepts e] at hx
    obtain ⟨s, hs, hse⟩ := hx
    exact h s hs x hse

end Exercise722

end Domain.Neighborhood
