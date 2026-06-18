import Mathlib.Data.Finset.Basic
import Mathlib.Data.Set.Basic

/-!
# Scott Information Systems

Following Dana Scott, *"Domains for Denotational Semantics"* (ICALP 1982) and the
compact presentation in Glynn Winskel, *The Formal Semantics of Programming
Languages*, Chapter 8.

A **Scott information system** is a triple `(A, Con, Ent)` where

* `A` is a type of *tokens* (atomic units of information / propositions);
* `Con` is a collection of *consistent* finite sets of tokens; and
* `Ent` (entailment) relates a finite set of tokens to a token it forces.

The **domain** determined by an information system is the poset of its *elements*
(a.k.a. *ideals*): sets of tokens that are consistent on every finite subset and
closed under entailment, ordered by inclusion. This file sets up the structure, the
notion of element, and the partial order; later files build the function, product,
and sum spaces.
-/

/-- A Scott information system on a type of tokens `α`. -/
structure InfoSys (α : Type*) where
  /-- The consistent finite sets of tokens. -/
  Con : Set (Finset α)
  /-- Entailment: `Ent X a` means the consistent set `X` forces the token `a`. -/
  Ent : Finset α → α → Prop
  /-- Consistency is downward closed under `⊆`. -/
  con_subset : ∀ {X Y : Finset α}, X ∈ Con → Y ⊆ X → Y ∈ Con
  /-- Every singleton is consistent. -/
  con_sing : ∀ a : α, {a} ∈ Con
  /-- A set entailing `a` stays consistent when `a` is added. -/
  ent_con : ∀ {X : Finset α} {a : α}, Ent X a → X ∪ {a} ∈ Con
  /-- Entailment is reflexive on members of a consistent set. -/
  ent_refl : ∀ {X : Finset α} {a : α}, X ∈ Con → a ∈ X → Ent X a
  /-- Entailment is transitive (cut). -/
  ent_trans : ∀ {X Y : Finset α} {c : α},
    X ∈ Con → (∀ y ∈ Y, Ent X y) → Ent Y c → Ent X c

namespace InfoSys

variable {α : Type*} (sys : InfoSys α)

/-- An *element* (ideal) of the domain: a set of tokens that is consistent on every
finite subset and closed under entailment. -/
structure Element where
  /-- The underlying set of tokens. -/
  carrier : Set α
  /-- Every finite subset of the element is consistent. -/
  consistent : ∀ Y : Finset α, (Y : Set α) ⊆ carrier → Y ∈ sys.Con
  /-- The element is closed under entailment. -/
  closed : ∀ (Y : Finset α) (a : α), (Y : Set α) ⊆ carrier → sys.Ent Y a → a ∈ carrier

/-- Elements are ordered by inclusion of their carriers; this is the Scott ordering. -/
instance : PartialOrder sys.Element where
  le x y := x.carrier ⊆ y.carrier
  le_refl _ := Set.Subset.refl _
  le_trans _ _ _ h1 h2 := Set.Subset.trans h1 h2
  le_antisymm x y h1 h2 := by
    -- Elements are determined by their carriers (the remaining fields are `Prop`s,
    -- closed by proof irrelevance), so equality reduces to carrier antisymmetry.
    cases x
    cases y
    congr
    exact Set.Subset.antisymm h1 h2

end InfoSys
