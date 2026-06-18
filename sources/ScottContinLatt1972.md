---
source_pdf: ScottContinLatt1972.pdf
title: "Continuous Lattices"
author: Dana Scott
year: 1972
citation_key: Sco72
alias: "PRG-7 (Oxford Technical Monograph, 1971; textually identical to LNM 274)"
bibliography: "Scott, D. Continuous lattices. In: Toposes, Algebraic Geometry and Logic (F. W. Lawvere, ed.), LNM 274, Springer, 1972, pp. 97–136."
pages: 40
extraction_method: "pdftotext"
verification_status: draft
verified_by: null
verified_date: null
---

# Continuous Lattices

**Author:** Dana Scott (1972)  
**Source file:** `ScottContinLatt1972.pdf`  
**Also known as:** PRG-7 (Oxford Technical Monograph, 1971; textually identical to LNM 274)

> **Human verification required.** This file is a machine-generated *draft*, cleaned
> for readability (page numbers removed, paragraphs reflowed). Compare against the
> PDF and correct OCR errors, restore mathematical notation, and check off items
> below. When done, set `verification_status: verified` in the YAML front matter.

## Bibliography

Scott, D. Continuous lattices. In: Toposes, Algebraic Geometry and Logic (F. W. Lawvere, ed.), LNM 274, Springer, 1972, pp. 97–136.

## Verification checklist

- [ ] p.1: ABSTRACT
- [ ] p.1: CONTENTS
- [ ] p.1: 0.           Introduction
- [ ] p.1: 1.           Injective       Spaces
- [ ] p.1: 2.           Continuous       Lattices
- [ ] p.1: 3.           Function       Spaces
- [ ] p.1: 4.           Inverse     Limits
- [ ] p.19: 0   But this implies
- [ ] p.25: 0              Suppose finally   that S ~ J 0 is
- [ ] p.28: 4. INVERSE LIMITS. By an inverse       system of spaces we understand
- [ ] p.36: REFERENCES •    An announcement of this work and related    investigations

---

## Transcription


Scott, D. Continuous lattices. In: Toposes, Algebraic Geometry and Logic, edited by F. Lawvere.

Springer-Verlag, LNM, vol. 274, 1972, pp. 97-136.

CONTINUOUS LATTICES

BY Dana Scott

ABSTRACT

Starting from the topological point of view a certain wide class of T0 -spaces is introduced having a very strong extension property for continuous functions with values in these spaces. It is then shown that all such spaces are complete lattices whose lattice structure determines the topology - these are the [?oontinuous] [?Zattioes] - and every such lattice has the extension property. With this foundation the lattices are studied in detail with respect to projections, subspaces, embeddings, and constructions such as products, sums, function spaces, and inverse limits. The main result of the paper is a proof that every topological space can be embedded in a continuous lattice which is homeomorphic (and isomorphic) to its own function space. The function algebra of such spaces provides mathematical models for the Church-Curry A-Calculus.

CONTENTS

0. Introduction

1. Injective Spaces

2. Continuous Lattices

3. Function Spaces

4. Inverse Limits

References

0, Introduction

Through a roundabout chain of mathematical events I have become interested in T0 -spaces, those topological spaces satisfying the weakest separation axiom to the effect that two distinct points cannot share the same system of open neighborhoods. These spaces seem to have been originally suggested by Kolmogoroff and were introduced first in Alexandro££ and Hopf (1935). Subsequent topology textbooks have dutifully recorded the definition but without much enthusiasm: mainly the idea is introduced to provide exercises. In the book ~ech (1966) for example, T0 -spaces are called [?feebly] semi-separated spaces, which surely is a term expressing mild contempt. Some interest has been shown in finite T0 -spaces (finite T1 -spaces are necessarily discrete), but generally topology seems to go better under at least the Hausdorff separation axiom, The reason for this is no doubt the strong motivation we get from geometry, where points are points and where distinct points can be separated.

What I hope to show in this paper is that from a less geometric point of view T0 -spaces can be not only interesting but also natural.

The interest for me lies in the construction of function spaces, and the main result is the production of a large number of T0 -spaces D such that D and [D + DJ are homeomorphic. Here [D + D] is the space of all continuous functions from D into D with the topology of pointwise convergence (the product topology). It will be shown that every space can be embedded in such a space D, and that D can be chosen to have quite strong extension properties for D-valued continuous functions. These properties make D most convenient for applications to logic and recursive function theory, which was the author's original motivation. Some of the facts about these spaces seem to be most easily proved with the aid of some lattice theory, a circumstance that throws new light on the connections between topology and lattices. In fact, the required spaces are at the same time complete lattices whose topology is determined by the lattice structure in a special way, whence my title.

1. INJECTIVE SPACES. All spaces are T0 spaces, and we begin by defining a class of spaces to be called [?injeative].

Definition.

l .l A T0 -space Dis [?injeative] if£ for arbitrary spaces X and Y if X c Y as a subspace, then every continuous function f:X + D can be extended to a continuous function f:Y + D. As a diagram we have:

Some people will object to this terminology because I use the subspace relationshi~ rather than a monomorphism in the category of T0 spaces and continuous maps. However, only the trivial 1-point space is injective in the sense of monomorphisms in that category, and so the notion is uninteresting. If the reader prefers another terminology, I do not mind. As we shall see these spaces have very strong retraction properties.

A slightly less trivial example of an injective space is the 2-point space (I) with "points" J. and T where {T} is open but { J.} is not. (This space is sometimes called the Sierpinski Space.)

1.2 Proposition. The [?spaae] ID is injective.

Proof: As.is obvious, the continuous maps f:X + 0 are in a one-1 one correspondence with the open subsets of X (consider f ({T})).

If X ~ Y as a subspace, then an open subset of Xis the restriction of some open subset of Y. Thus any f:X + (I) can be extended to f:Y + 0. D

1.3 Proposition. The Cartesian produat of any number of [?injeative] spaaes is [?injeative] under the product topology.

Proof: The argument is standard. A map into the product can be projected onto each of the factors. Each of these projections can be extended. Then the separate maps can be put together again to make the required extended map into the product. D We now have a large number of injective spaces, and further examples could be found using the next fact.

l .4 Proposition. A retraat of an injective space is injective.

Proof: Let D be injective. By a retract of D we understand a subspace D'~ D for which there exists a retraction map j:D + 01 such that

D1 = {x e D : j(x) = x}.

Then if f:X + D and X ~ Y, we have f:X + D as a continuous map also.

Taking f:Y + D, we have only to form jof : Y -+ D'

to show that D' is injective. D The relationship between arbitrary T0 -spaces and the injective spaces is given by the embedding theorem.

1.5 Proposition. Every T0 -[?spaae] aan be embedded in an [?injeative] space; in fact, in a Cartesian power of the 2-etement [?spaae] 0.

Proof: The proof is well known (cf. ~ech (1966), Theorem 26B.9, p. 484.) But we give the argument for completeness sake. Let X be the given space, and let~be the class of open subsets of X. Let D Oi,

be the Cartesian power of O. Then Dis injective by 1.3. Define the map e: X + D by: if X E U, .Cx)(U) -{: ifxEfU,

for x e X and U et;',. This map e is continuous in view of the topology given to O and to D. The map e is one-one, because Xis T0 • Finally, if Uc Xis open, then e(U) = {e(x) x E U}

= {e(x) e(x) (U) = T} e(X) n {t ED : t(U)E {T}}, which shows that the image e(U) is open in the subspace e(X) c D.

Therefore e:X +Dis an embedding of X as a subspace in D. D

l .6 Corollary. The [?injeative] spaaes are exaatZy the retraats of the Cartesian powers of O.

Proof: Such a retract is injective by 1.4. If Dis injective, then it is (homeomorphic to) a subspace of a power of O. But since Dis injective the identity function on the subspace to itself can be extended to the whole of the power of O providing the required retraction. D

l .7 Corollary. A [?spaae] is [?injeative] iff it is a retraat of every space of which it is a subspace,

Proof: As in the proof of 1.6, this property is obvious for injective spaces. But in view of 1.5 every such space is a retract of a power of O and hence is injective. D As a result of these very elementary considerations, the injective space could be called absolute retracts, if one remembers to modify the standard definitions by using arbitrary subspaces rather than just alosed subspaces. Note too that it is easy to show that the only continuous maps e:X + Y for which the extension property x--4v

1\.,/f 0

could hold for all continuous f:X +Oare embeddings as subspaces.

Thus it would seem that we have a reasonably good initial grasp of the notion of injective spaces, but further constructions are considerably facilitated by the introduction of the lattice structure.

2. CONTINUOUS LATTICES. Every T0 -space becomes a partially ordered set under the definition: x ~ y if£ whenever x Eu and u is open, then ye u.

Indeed, though this relation is reflexive and transitive, the condition that it be antisymmetric is exactly equivalent to the T0 -axiom.

In the converse direction, every p&rtially ordered set <X, ~> can be so obtained, for we have only to define U ~ X as being open if it satisfies the condition: (i) whenever x EU and x Sy, then y EU.

The axioms for partial order make X a T0 -space, because for any y EX the set {xE X:x~y}

is open. This connection is not very interesting, however.

What is interesting in topological spaces is convergence and the properties of limit points. We shall discuss limits in terms of nets, in particular in terms of monotone nets. A monotone net in a T0 -space X is a function

X I + X

where < I,..; > is a directed set and where i < J iJT1plies :x:.1, C::: 0

-:x:. for all

J i,j EI. In a T 1-space a monotone net is constant (hence, uninteresting) because the ~-relation is the identity. As usual (cf. Kelley (1955),p.66) we say that a net :x: converges to an element y if£ whenever U is open and y Eu, then for some i EI we have :x:. EU for all j ~ i. Note that a

J monotone net :x: converges to each of its terJT1s xi. Suppose that a monotone net :x: converges to an element y which is an upper bound to all the terms of :x:. Then y must be the least upper bound, which we write as: y LJ{xi : i E I} To see this, assume that z is any other upper bound with :x:.1, ~ z for all i E I. If U is open and y Eu, then :r:,1, Eu for some i EI. But then Z E U, and soy~ z follows.

We shall find that most of the facts about the topology of the spaces we are concerned with here can be expressed in terms of least upper bounds (lubs). It is not always the case, however, that lubs are limits. Thus, for a partially ordered set X, we impose a further restriction on its topology beyond condition (i) for saying when a subset U is open: (ii) whenever S c X is directed, LJS exists, and LJS E U, then Sn U * (JJ.

By a directed subset of X we of course mean that it is directed in the sense of the partial ordering~. Note that in this paper directed sets are always non-empty. The sets satisfying (i) and (ii) form the induced topology on a partially ordered set X, which is still a T0 -space because the sets {x E X : :x: ~ y} remain open even in the sense of (ii). Obviously a directed sets f X can be regarded as a net, and now in view of (ii) it follows that S converges to Us -- if this lub exists. l':e can summarize this discussion as follows.

2. l Proposition. In a partially ordered set X with the induced topology, a monotone net :x:: I~ X with a least upper bound converges to an element y EX iff i E I}. 0 Our main interest will lie with those partially ordered sets in which every subset has a lub: namely, complete lattices. If Dis such a space we write .L = LJ(/)and T = LJO for the smallest and largest elements (read: bottom and top). As is well known, greatest lower bounds must exist, for: n S = LJ{:r:

E D : x !;_ y for all y E S} gives the definition.

Given a complete lattice Owe define

x < y iffy E Int {z ED: x ~ z}, where the interior is taken in the sense of the induced topology. The relation x < y behaves somewhat like a strict ordering relation; at least its meaning is clearly that y should be definitely larger than in the partial ordering. Such a relation has many pleasant properties.

The primary purpose of introducing it is to provide a simple definition for the kind of spaces that are most useful to us. We first mention the most elementary features of this relation.

2.2 [?Proeosition]. In a compZete Zattice D we have: ( i) J. < x;

(ii) X < z and y < z impZy x LI y < z;

(iii) X <y C z impZies X < z. J

(iv) X !;_ y < z impZies x < z_; (v) X < y imp lies x !;_ y; (vi) X < X iff {z E D : X ~ z} is open; (vii J if S S. Dis direated, then X < LJs iff X < y for some y E s. D The proofs of these statements can be safely left to the reader.

2!3 Definition. A continuous Zattiae is a complete lattice D in which for every y E D we have: y = lJ{x E D : X < y}.

As an alternate definition we find: 214 [?Proeosition]. A compZete Zattice D is continuous iff for every y E D we have: y = LJ{nu : y E U}, where U ranges over the open subsets of D.

Proof: Suppose D is continuous. If y E D and x < y, then let U Int {z : x ~ z}, an open set. Now y EU by definition,and U s_ {z : X ~ Z}.

Thus, x~nu!;_y.

It easily follows by lattice theory that the equation of 2.3 implies that of 2.4.

In the converse direction we have only to note that if U is open and y E U, then nu < y. The implication from 2. 4 to 2. 3 results at once. o

What is the idea of this definition? A continuous lattice is more special than a complete lattice: not only are lubs to be limits but every element must be a limit from below. This rather rough remark can be made more precise. In any complete lattice D define the principal limit of a net x: I~ D by the formula:

Zim<x. iE I>= LJ{n{x.: j>i}: iE I},

~ J Then specify that x converges toy ED iff Y C- lim <x.~ : i E I> Having a notion of convergence, we can then say that u SD is open iff every net converging to an element of U is eventually in U, This gives nothing more than what we have called the induced topology above, as is easily checked, But now being in possession of a topology, we can redefine convergence in the usual way. Question: when do the two notions of convergence agree? Answer: if and only if Dis a continuous lattice.

For obviously by construction the limit definition of convergence implies the topological. Now if Dis a continuous lattice and x converges toy topologically, consider an open u SD with y Eu. For some i EI we shall have x. e u for all j ~ i, Therefore

J n u cn{x.

- J : J. ~ i} C Zim <x.

- ~ i E I> •

Thus, in continuous lattices, -From the formula of 2.4 it at once follows that Y C lim < x. : i E I ) • we have shown that the two notions ~ of convergence are the same, Finally, suppose that the two notions coincide for a complete lattice D. Define a set I= {(U,z) : y,z Eu}, where z ranges over D and u over open subsets of D. This set is directed by the relation: (U,z) ~ (V,w) if£ U 2 V. Let x : I~ D be given by: x(U,z) = z. Then x is a net converging toy topologically. But Zim <x. : i EI> ~ lJ{nu: y EU}. In this way we see that the assumption about the two styles of convergence implies that Dis a continuous lattice in view of 2.4.

In T0 -spaces continuous functions are always monotonic (i.e.~preserving). For continuous lattices, by virtue of the remarks we have just made about limits, we can define the continuity off: D ~ D' to mean that f(Zim <xi: i EI>)[;_ Zim' <f(xi): i EI> for all nets x: I~ D, This is all very fine, but general limits are messy to work with; we shall find it easier to state results in terms of lubs as in 2.5-2.7 below.

Before going any deeper, however, we should clear up another point about topologies. Suppose that Dis any T0 -space which becomes a complete lattice under its induced partial ordering. Then it is evident from our definitions that every set open in the given topology is also open in the topology induced from the lattice structure, Question: when do the two topologies agree? Answer: a sufficient condition is that the equation: y = u {nu : y E U}

hold for ally ED, where u ranges over the given open sets. Because in that case if Vis open in the lattice sense and y E v, then nu E V for some set U, open in the given sense, where y EU, But Uc V follows, and so vis a union of given open sets and is itself open in the given topology. Of course this equation implies that D is a continuous lattice by virtue of 2.4. Notice that by the same token the sets of the form {y E D:x ~ y} will form a basis for the open sets of a continuous lattice.

2.5 Proposition. If D and D1 are aomplete lattiaes with their induaed topologies, then a function f:D + D1 is continuous iff for all directed subsets s ~ D: f<LJS) = LJ{f(x) : x e s}.

Proof: If f:D + D is continuous, 1 the equation follows from the definition of continuous function and the fact that lubs are limits.

Assume then that the equation holds for all directed sets s. Let u' ~ D1 be open in D1 and let u = {x ED : f(x) Eu'}.

We must show that u is open in D. Note first that if x Cy, then S = {x,y} is directed; hence, f(x Uy) = f(y) = f(x) U f(y), so f(x) ~ f(y). Thus f is monotonic and so U satisfies condition (i).

That U satisfies condition (ii) follows at once from the above equation. o 2.6 Pr0position. With functions from complete lattiaes to aomplete [?lattiae]~ a funation of several variables is continuous in the variables jointly iff it is continuous in the variables separately.

Proof: It will be sufficient to discuss functions of two variables. The product DxD1 of two complete lattices is a complete lattice, and it is easy to check that the induced topology is the product topology. Since projection is continuous, joint continuity implies separate continuity. To check the converse suppose that f:DxD' + D" is a map where the separate continuity holds as follows: f<Us,y) =lJ{f(x,y) : x es}

and f(x,Us') =LJ{f(x,y) : y E s'l wheres c D ands' c D'are directed and x ED and y ED'. Let now 1 S* c DxD be directed in the product. The projection of S* to Sc D and S* to s' c D' produces directed subsets of D and D'.

Note that Us*= ( Us, Us').

Thus by assumption f( u S*) =LJ{f(x,y) : XE s, y Es'}.

But since S* is directed, x Es and yes' implies X !;;'.U and y !; V for (u,v) E S*. Thus by monotonicity off we can show f( US*) = LJ{f(u,v) (u,v) ES*} and that gives the joint continuity. D One of the justifications (by euphony at least) of the term

continuous lattice is the fact that such spaces allow for so many

continuous functions. One indication of this is the result:

2.7 Proposition. In a continuous lattice D the finitaPy lattice opePations LI and nape continuous.

PPoof: It is trivial to show that LI is continuous in every complete lattice; this is not so for n. In view of 2.6 we need only show x n Us = LJ{x n y : y e s} for every directed Sc 0. In fact it is enough to show x n Us !; LJ{x n y : y e s} because the opposite inequality is valid in all complete lattices.

In view of the fact that Dis continuous, it is enough to show that t < x n Us implies t !; LJ{x n y : y E s}.

So assume t < x n Us. Then t ~ x n Ust; x. Also t -< Us because x nLJs!; Us. Thus t < y for some y E s since the set {z E 0 t < z} is open. But then t Cy, and sot C x n y, and the result follows. D It is now time to provide some examples of continuous lattices.

2.8 Proposition. A finite lattice is a continuous lattice. D

2.9 Proposition. The Cartesian product of any number of continuous lattices is a continuous lattice with the induced topology agreeing with the product topology.

2.10 Proposition. A retract of a continuous lattice is a continuous lattice with the subspace topology agreeing with the induced topology.

It would seem that the continuous lattices are starting to sound suspiciously like the injective spaces. Indeed, if we can prove the following, the circle will be complete.

2.11 Proposition. Every continuous Zattice is an injective space under its induced topoZogy.

2.12 Theorem. The injective spaces are exactly the continuous Zattices.

This theorem is an immediate consequence of the preceding results: an injective space is a retract of a power of~- But O is a finite lattice c~ ~ T), and so the given space is a continuous lattice under its induced topology. On the other hand a continuous lattice is injective. It remains then to prove 2.9 - 2.11.

Proof of 2.9 Let D. for i E I be a system of continuous '!-

lattices. The product

D* =

X iEI

D.'!-

is a complete lattice in the usual way and has its induced topology, Suppose y ED* and let i EI. Then y.'!- ED '!-.. Since D.'!- is a

continuous lattice y • = LJ {x E D• : x < y . } , '!- '!- '!-

For x ED.,'!- let [x]i ED* be defined by: if i=j,

if i*j.

Note that since Di is continuous we have: [y • ] i = LJ { [x] i ; X < y •}' '!- '!-

and y =LJ{[yi]i : i EI}.

It follows that y = LJ{n{.s : zi E U} : i E l, yi E U},

where i ranges over I and U over the open subsets of Di' because [x]i !;_ n{z: z. EU}, where U = {u ED.:~ X -<U}.

~

But the sets {z : z. EU} are open in the product sense, and so ~

y = LJ{ n U : y E U}, where U ranges now over the open subsets of the product topology on D*. By the remark following 2.4 we conclude that D* is continuous with the lattice-induced topology being the product topology. D

PPoof of 2 1 10 Let D' be a continuous lattice and let D c D' be a subspace which is a retract. We have for a suitable j:D' + D, D = {x ED' : j(x) = x}, where of course j is continuous.

First a note of waPning: though Dis a subspace it is not a sublattice; that is, the partial ordering on Dis the restriction of that of D', but the lubs of Dare not those of D'. We shall have to distinguish operations by adding a prime (') for those of D'.

Suppose x,y ED. Let z 1 = x U'y ED' and define z = j(z 1 ) E 0.

Now x ~ z and y ~ z and j is monotonic, 1 1 so x ~ z and y ~ z.

Suppose x ~wand y f w with w ED. Then in D' we have x U'y ~ w; so a~~ also. Hence we have shown that z = x Uy in D.

To show that D has a least element~ (which may be larger than the~' ED'), we need a well-known lemma about monotonic functions:

Every monotonic function on a complete lattice into itself has a Zeast fixed point. (Cf. Birkhoff (1970), p. 115.) In our case j is monotonic and ~ = n' {x E D' j(x) f x} is the desired element in D.

Thus Dis at least a semilattice with~ and LI. To show that D is a lattice we need to show that every directed s c D has a lub in D.

Now we know: LJ'sED', and this is a Zimit of a monotone net. So by 2.1, and the continuity of j: j( LJ's) = lJ{j(x) X E S}

= Us in D. In this way we now know that Dis a complete lattice. We must

still show that 0 is continuous.

Suppose y E 0. In 0' we can write: y = LJ'{z E O' : z < y} and this is the limit of a monotone net. Thus j(y) =y = LJ{j(:d : z < y, z E 0'},

where the lub is taken in 0. Note that the sets U = {z E O : z < z}

are open in 0 for each z e 0'. Note too that if z e u, then z ~ z and so j(z) ~ j(z) = z. This means that j(z) C n U

in 0. We can then write in 0: y = LJ{n U : y E U}

where u ranges over the open subsets of 0, and so the lattice is

continuous by 2.4. Inasmuch as the open sets u just used were open in the subspace topology, it follows by the remark after 2.4 that the subspace and the lattice-induced topologies coincide. D

Proof of 2.11: Let 0 be a continuous lattice with its induced topology, and let X c Y be two T0 -spaces in the subspace relation.

Suppose f X -+ 0

is continuous. Define f Y -+ 0

by the formula: f(y) = LJ{n {f(z) : x E X n U} : y E U},

where U ranges over the open subsets of Y. We need to show that f extends f and that it is continuous.

First, the continuity: Suppose that de 0 and d < f (y); that is, f(y) belongs to a typical basic open subset of 0. Since 0 is

continuous, we can also find d<d'<·f(y)

with d 1 E 0. From the definition off it follows that d' ~ n {f(z) x e X n u}.

for some open u ~ Y with ye u. Thus

d' ~ f(y' ) for aZZ y 1 EU by virtue of the definition off. Since d < d 1 , we have also d < f (y' )

for all y 1 e u; in other words, the inverse image of the open subset of D determined by d under f is indeed open in Y, and f is thus

continuous.

Next, the extension property: Note that the relationship f (:x:') i:;;:f (:x:') 1 for all :x: EX comes directly out of the definition off. For the 1 converse, supposed< f(:x: ) where d ED. By assumption f: X 4 Dis

continuous, so d < f (:r/ 1)

for all :x:~EX n U where u is a suitable open subset of Y with :x:'E U.

In particular we have: d ~ n {f ( x' I ) : x'' E X n u} '

and sod~ 1 f(:x: ). Since d < f(:x:1 ) always implies d ~ f(:x:1 ), we see that f(:x:1 ) r; f(:x:1 ) follows by the continuity of D, and the proof is complete. D The lattice approach to injective spaces gives a completely "internal" characterization of them: in the first place the lattices are complete. Next we can define lattice theoretically: :x: < y iff whenever y !; LJ z and z c D is directed, then :x:r; z for some z E z.

Finally we assume that for all y E D: y = u {:x: E D : :x: < y}.

That makes D a continuous lattice with the sets {y ED : :x: < y} as a basis for the topology. Such T0 -spaces are injective and every injective space can be obtained in this way with the lattice structure being uniquely determined by the topology. Furthermore, as we have seen, the injective property can be exhibited, as in the proof of 2.11, by an explicit formula for extending functions.

The retract approach to injective spaces should also be considered. The Cartesian powers v 1 are very simple spaces; indeed, as lattices these are just the Boolean algebras of aZZ subsets of I (that is, isomorphic thereto). The topology has as a basis the

classes of sets containing given finite sets (the weak topology, cf.

Nerode ( 1959)). A continuous function j : PI -+ PI is one of "finite character" so that j(X) =U{j(F) : F c x} where X ~ I and F ranges over finite sets. Such a function j is a retraction iff it is an idempotent: joj = j, which means that the range of j is the set of fixed points of j. As we have seen D ={XE PI : j(X) = X} is a continuous lattice (under~ in this case), and every continuous lattice is isomorphic to one obtained in this way. This provides a representation theorem of sorts for continuous lattices, but it does not seem to be of too much help in proving theorems.

The reader should not forget that any space (any given number of spaces X, Y, •.• ) can be found as a subspace of a continuous lattice D. Since Dis injective any continuous function f; X-+ Y can be extended to a continuous function f: D-+ D. Thus the continuous functions from D into Dare a rich totality including all the structure of continuous functions on all the subspaces. And this remark brings us to the study of function spaces.

3. FUNCTIONSPACES. We recall the standard definition and introduce our notation for function spaces.

3,1 Definition. For T0 -spaces X and Y we let [X-+ Y] be the spacfe of all aontinuous funations f: X -+ Y endowed with the product topology, sometimes called the topology of pointwise convergence.

This topology has as a subbase sets of the form: {f : f(x) E U}

where x EX and U ~ Y is open.

The pointwise aspect of the topology is immediately apparent in the partial ordering.

3,2 Proposition. The induced partial ordering on [X-+ Y] is suah that: f ~ g iff f(x) C g(x) for all x EX,

where f, g E [X ~ YJ. D

The first question, of course, is what kind of a partial ordering this is.

3.3 Theorem. If D and D1 are continuous lattices, then so is [D ~ D'J under the induced partial ordering with the lattice topology agreeing with the product topology.

The argument is "pointwise."

Proof: Thus, the constant function with value i ED' is obviously continuous and is the i of [D ~ D'] by 3.2. Since by 2.7 the lattice operation u on D' is continuous, then if f, g E [D ~ D'J the composition f U g, defined by (f U g)(x) = f(x) U g(x) for all e D, is also continuous x and represents the lub of {f, g} in [D ~ D'J. (The same arguments apply to T and n, so [D ~ D'] is at least a lattice.) To show that [D ~ D'J is complete it is sufficient now to show that lubs of directed subsets exist. So let :I~ [D ~ D'] be directed. Define a function from D into D' by the equation: ( lJ:I )(x) = Lj{f(x) : f E :I},

for all x E D. If we can show that LJjf is continuous, then being in [D ~ D'J it has to be the lub. Consider u ~ D', an open subset.

Taking the inverse image and remembering that :I is directed, we find: {x: cLJ:1 )(x) EU}= U{{x: f(x) EU}: fE:I}.

This is an open set, and so LJ:I is indeed continuous. (Warning: the infinite n:1 are not in general computed pointwise; however, it is easy to extend the above argument to show that arbitrary LJjf are.) To show that [D ~ D'] is continuous, we establish first that for f E [ D ~ D' ] f = LJ{;;[e,e 1 J : e' < f(e)}, 1 where e ranges over D and e 1 over D', and where the function ;[e,e ]

is defined by : e' if e< X, 1 ;[e,e ](x) = i { if not, for all x ED. Call the function on the right f'. Calculate:

f' (x) = LJ{;[e ,e' J<x) : e 1 < f(e)}

= LJ{e' 3e< x[e' < f(e)]}

= LJ{e' e 1 <f(x)} = f(x).

With the equation for f proved, note next that for all g e [D...,. D'J, e 1 < g(e) implies ;[e,e 1 ] ~ g

by an easy pointwise argument. If we let V = {g: e 1 < g(e)},

we see then that Vis open in the product topology and that ;[e ,e 1 ] ~ n V, We may then conclude that f = LJ{ n V : f E V} , which proves both that [D...,. D' J is a continuous lattice and that the two topologies agree by the remark following 2.4. D The above theorem might possibly be generalized to [X...,. DJ where Xis merely a T0 -space, but I was unable to see the argument. In any case we are mostly interested in the continuous lattices. Note as a consequence of our proof:

3.4 Corollary. For continuous Zattices D and D', the evaZuation map: eval [D...,.D'JxD...,.D' is continuous.

Proof: Here eval(f,x) = f(x). With f fixed, this is obviously continuous. With x fixed, we proved the continuity above with our calculation of LJ.:f in view of 2. 5. Hence applying 5. 3 and 2.6, we conclude that eval is jointly continuous. D

This result gives only one example of the masses of continuous functions that are available on continuous lattices. As another fundamental example we have:

3.5 Proposition. For [?oontinuous] lattices D, D', and D", the map of functional abstraction: lambda : [[D x D'J...,. D"J ~ [D ~ [D' ~ D"JJ is continuous.

Proof: Here lambda is defined by: lambda(f)(x)(y) = f(x,y) where f E [[D x D']-+ D"] and x ED and ye D'. What is particularly interesting here is that by virtue of 3.3 we are making use of [D-+ [D'-+ D"]] as a continuous lattice. The principle being stated here can be formulated more broadly in this way:

If an expression &(x,y,z, .•. ) is continuous in all its variables x,y,z, ..• with values in D' as x ranges in D, then the expression >,.x:D.&(x,y,z, . .• ) with values in [D-+ D1 ] is continuous in the remaining variables y ,z,... .

The >,.-notation is a notation for funations, where in the above the variable after the\ is the argument and the expression after the .

is the vaZue (as a function of the argument). Thus we could write: lambda= >,.f:[(D x D']-+ D"J.>..x:D.\y:D'.f(x,y), and, because f(x,y) is continuous inf, x, and y, our conclusion follows. But often it is more readable not to write equations between functions but rather equations between values for definitional purposes.

The proof of the principle is easy. For let the variable y, say range over D" and lets c D" be a directed subset. Then \x:D.&(x, Us, z, •.. ) = \x:D.lJ{&(x,y,z, •.. ) y E S}

= LJo,x:D.&(x,y,z, ... ) y Es}, because the lubs of functions are computed pointwise. D We need not enumerate the many corollaries that follow easily now from this result. We mention, however, that composition f g of 0

functions (on continuous lattices) is continuous in the two function variables, where we write (fog)(x) = f(g(x)).

What will be useful will be to return at this point to a discussion of the injective properties of continuous lattices. If one continuous lattice is a subspace of another it is of course a retract. This relationship between spaces can be given by a pair of

continuous maps

i D -+ D' and j D' -+ D ,

where joi = ido = AX:D.x • The composition i j : D'-+ i(D) is the retraction

0 onto the subspace corresponding to D under i. Now if we have a diagram: i

D --=--+- D' f

". J

I / f- : foj \ ;.

D"

the given continuous f is at once extendable from D to D' by the obvious definition off, This f is not the j used in the proof of 2.11, and it will be well to sort out the connections. On one side note that if f' is any function which extends f, then we have f = f' i.

0 But this implies f = foj = f 10 i 0 j, which shows that f is a "degraded" version of f 1 • There is one situation where this type of degrading is especially nice.

3.6 Definition. A continuous lattice Dis said to be a pPojection of a continuous lattice D' iff there are a pair of

continuous maps i D -+ D' and j DI -+ D

such that not only

but also ioj~ido'·

Thus, in case our retraction is a projection, we have f C f 1 , which means that f is the minimaZ extension off E [D-,. D"] to a function in [D'-,. D"]. We will discuss the nature off in a moment.

But before we do we pause to remark that the correspondence f 'V\r+ f is continuous, and this fact is easily extended.

3.7 Proposition. Suppose the two pairs of maps D -,. D' and J 0

D' -,. D n n n n n

for n = 0,1 make On a retraction (projection) of D~. Then [0 -+ D1 ] 0 is also a retraction (projection) of [0~-+ Di] by means of the pair of maps:

-+ j(f') = jlof'oio ' where f E [0 0 -+ 0 ] and f 1 E [0 0 -+ Di], D 1 Returning now to f we can prove:

3.8 Proposition. If Dis a continuous lattice and e : X-+ Ya subspace embedding, then for each f: X-+ D, the function f: Y-+ D given by the formula f(y) = LJ{n {f(x) e (x) E U} : y E U},

where U ranges over open subsets of Y and x over X, is the maximal extension off to a function in the partiaZZy ordered set [Y-+ D].

Proof: We are saying that f is the maximal solution to the equation f =foe• We already know it is a solution, so let f 1 be any other. We have f' (y) = LJ{n {f' (z) z E U} : y E U}

C LJ{n {f' z e(X) n U} : y E U} (z) E

= LJ£n{f' : e U} y E U} (e(x)) (x) E

= LJ{n {f(:x:) : e(:x:) U} : Y e U} E

= l (y) '

which establishes that f' ~ f. o

By the same argument we could show that f is the maximal solution of f e ~ f. 0An interesting question is whether the correspondence f 'V\r+ f is continuous. I very much doubt it, but at this moment a counterexample escapes me. It is clear that the correspondence is monotonic, for if f ~ g, then the formula of 3.8 shows that f ~ g. This gives us a neat argument for the previous remark: if g e ~ f, then 0

But goe = goe, so by 3.8, g ~ goe, and f is thus maximal.

In the case that the range spaces are being extended, the following lemma relating the extensions will be very useful when we consider inverse limits.

3.9 Lemma. ConsideP the diagPam:

j

where the uppeP row is a subspace embedding and the Zower is a pPojeation. If the given funations f and g aPe extended to f and g as in 3.8, and if f = jog, then f = jog aZeo.

Proof: f and g are maximal solutions off= foe and g = goe.

Therefore since f =jog= jogoe, we see that jog!;; f.

Note also that iofoe = iof = iojog ~ g, and so by the remark following 3.8, we have i 0 f !;; g.

Therefore f = joiof !;; jog, which proves the equality. D Whether this lemma is true for retractions in any form, I do not know. My proof seems to require the stronger projection relationship.

I suspect there may be difficulties. In general projections are better behaved than retractions. By the way the word pPojection seems to be properly used in 3.6, for the projection j:Dxo'~o of the Cartesian product of two continuous lattices onto the first factor is a projection with partial inverse i:D ~ DxD' defined by i(x) = (x,.1.) for x e D.

3.10 Proposition. If the continuous lattice Dis a projection of the continuous lattice D' via the pair of maps i,j; then for all Sc D and all x,y ED we have: (i) i<Us>=lJ{i(x):xES}, (ii) i(x) = i(y) implies x=y, (iii) x < y implies i(x) < i(y).

Conversely, if a map i:D ~ D1 satisfies (i) - (iii), then there exists a continuous j:D'~D making D a projection of D', and in fact j is uniquely determined by: (iv) j(:x:1 } = lJ{xE D i (:x:) C :x:1 } foraZl:x: 1 eD'.

Proof: Equation (i) holds for directed S ~ D because i is

continuous. To have it hold for arbitrary Sit is only necessary to check it for finite sets, because every lub is the directed lub of finite sublubs. (The last word of that sentence is an unfortunate accident.) Further, to check the equation for finite sets it is enough to check it for the empty set and for two element sets. Thus, i(i) = i, because j(i(i)} = i and since i G i(i), j(i} G j(iCi)) = i, so j(i) = i. Whence i(i) = i(j(i)) G i. Next i(x LI y) = i(:x:) LI i(y), because first i(x) LI i(y) G i(x LI y)

by monotonicity. Then note that i(x) G i(x} U i(y)

and so x = j(i(x)) C j(i(x) U i(y)).

Similarly y G j(i<:x:> u i(y)), whence :x:Uy G j(i(x) U i(y)).

But then i(x LI y) G i(j(i(x) LI i(y))) G i(x) LI i(y),

which completes the argument for equation (i).

Condition (ii) is obvious. For (iii) we argue as follows.

Assume x < y. Since D' is continuous we can write: i(y) = LJ{z 1 E D' z 1 < i ( y)} ,

and conclude by the continuity of j that: y = j(i(y)) = lJ{j(z 1) : z 1 < i(y)}.

But x < y, so x < j(z') for some z 1 < i(y). Now x ~ j(z 1 ) follows; therefore i(x) ~ i(j(z 1 )) ~ z • 1 Thus i(x) < i(y).

Turning now to the converse, assume of the map i that its satisfies (i) - (iii). Compute: i(j(x 1 )) = lJ{i(x): i(x) ~ x 1 } ~ x'.

This is correct because i is continuous and the set {x : i (x) ~ x' } is directed in view of condition (i), Thus ioj ~ id 0 ,. Note that by virtue of (i) and (ii) it is the case that i(x) ~ i(y) implies x ~ y.

(The reason is that x ~ y is equivalent to x LI y = y.) This remark allows us to compute: j(i(y)) = lJ{x i(x) ~ i(y)}

= LJ{x X ~ y} : y.

Hence, joi = id 0 . It remains to show that j is continuous.

Supposes'~ D' is directed. Since j is by definition monotonic, it is sufficient to prove that j(LJs') ~ lJ{j(x') x' e s' }.

Now j(LJs') = lJ{x: i(x) ~ Us'}, so suppose i(x) ~ LI S • Let z < x; whence i(z) 1 < i(x). Thus i(z) < x 1 for some x E s, and therefore 1 1 i(z) C x • We obtain then z ~ j(x' ), which means that

z ~ LJ{j (x 1 ) : x 1 E S1 }

holds for all z < x. By the continuity of D we conclude x~ lJ{j(x'): x'E S1 }

holds for all x with i(x) ~ LI S 1 • The desired result follows. D As a corollary of 3.10 we can easily see which subspaaes of a

continuous lattice D' are projections of it. Such a subspace D c D' must first be closed under LI . That is, if S ~ D, then Us ED for

alls, where the lub is taken in the sense of 0'. The identity map on

0 will then satisfy (i) and (ii). But this is not enough, since we would not know that 0 is a continuous lattice, nor whether (iii) hold~ The following additional condition would be sufficient, if assumed for all y E O:

y = LJ{x E D : x < y} ,

where< is taken in the sense of 0'. This implies that y = LJ{n (D n U) : y E U} where U ranges over the open subsets of D' and where the is taken n in the sense of 0. This condition makes the subspace topology the same as the lattice topology on D and besides makes 0 continuous, which is just what we need. (Another way to put it is that whenever z < y, where y E D but z E D' , then z !;; x < y, for some x E D.) It seems a bit troublesome to characterize in a simple way just which maps j:0'~ Dare projections. (Other than saying outright that the map i:D ~ 0' such that for all x ED: i (x) = n {x 1 E O1 : x !;; j (x 1 ) }

is the continuous partial inverse to j.) But we can say very easily which continuous maps j:D'~ D' are projections onto subspaaes; namely, we must have j: joj !;; id.

The subspace in question then is:

D = {x E 0 1 = x}. : j(x) This non-empty subspace is the exact range of j and is closed under LJ . Let y e D. Then if x' < y in D', we find j (x 1 ) !;; x 1 < y.

Thus since y = LJ {x 1 E 0 1 x' < y}' we see that y = j(y) = LJ{j(x 1 ) : x' < y}.

But each j(x) e 0, so y = LJ {x e D : x < y}, as desired.

The foregoing di$cussion suggests looking more closely at the space of all projections of a continuous lattice since they are so easily characterized.

3.11 Definition. Given a continuous lattice D, we let the space of projections be denoted by:

JD= {j E [D ~ DJ : j = joj ~ id}.

3.12 Proposition. For a continuous Zattice D the space JD of projections forms a complete lattice as a LJ -closed subspace of

[D ~ DJ.

Proof: The constant function i E JD obviously, so J 0 contains LJ 0. Suppose j,k E J 0 . We wish to show that j LI k E J 0 . Compute:

(j LI k)((j LI k)(x)) = j(j(x) LI k(x)) LI k(j(x) LI k(x)) But note: j(x) ~ j(j(x)) ~ j(j(x) LI k(x)) ~ j(x),

because j(x) LI k(x) ~ x. Similarly for k(x). Therefore, we find that (j LI k) (j LI k) = j LI k ~ id.

0 Suppose finally that S ~ J 0 is directed. We wish to show that US E J 0 . Clearly US~ id, so compute by continuity of 0 :

LJ So LJ S = LJ{j oj : j E S} = LJ{j : j E S}: LJS, It follows that J 0 is U -closed and hence is a complete lattice. D The significance of the above result becomes clearer if we consider the connection between projections and subspaces. Let us write:

D(j) = {x E D : j(x) = x}.

For j E J 0 , each D(j) is a projection of D onto a subspace, We show first that j ~ k iff D(j) <;: D(k) Because if j ~ k, then j ~ joj ~ koj ~ idoj = j. Therefore if j(x) = x, then k(x) = k(j(x)) = j(x) = x, which means that D(j) c D(k). On the other hand, if D(j) <;:D(k), then since j(D) c D(j), we see that koj = j, and so j ~ k id = k. Hence JD is 0

isomorphic to the partially ordered set of subspaces of D that are projections. We thus conclude that these subspaces form a lattice.

In fact, it is easy to show that D(j LI k) = {x LI y : x E D(j), y E D(k)}.

Similarly, if s is a directed set of J 0 , then D( US) is the U -closure in D of the subset:

U{D(j) j E S}.

These are not very deep facts, but their proofs were very much facilitated by the introduction of JD and the utilization of the lattice structure of [D ~ D]. Along the same line we can define for j,k E JD a function (j ~ k) E [D ~DJ~ [D ~ D] by the equation (j ~ k)(f) = kofoj, It is very easy to show that (j ~ k) E J[D ~ D]' that (j ~ k) is

continuous in j and k, and that [D ~ DJ(j ~ k) is isomorphic to [D(j) ~ D(k)]. There are many other interesting operations on projections corresponding to other constructs besides these. And, just as with (j ~ k), the operations are continuous. This makes it possible to prove existence theorems about subspaces by using results like the fixed-point theorem for continuous functions. It would be even nicer if JD turns out to be a continuous lattice itself, but as far as I can tell this is not likely to be the case.

Before we turn to the iterated function-space construction by inverse limits, there are a couple of other connections between spaces and function spaces that are useful to know.

3.13 Proposition. Every aontinuous Zattiae Dis a projeation of its funation [?spaae] [D ~ DJ.

Proof: Consider the following pair of mappings con :D ~ [D ~ DJ and min : [D ~ D] ~ D where con(x)(y) = x and min(f) = f(~) for all x,y ED and f ED. They are obviously continuous. The map con matches every element of D with the corresponding aonstant function in [D ~ D]. The map min associates to every function in [D ~ DJ its minimum value in the partial ordering. The proof that this pair forms a projection is trivial. D The pair con, min are not the only pair for making D a projection of [D ~ D]. The following pair of maps were suggested by David Park: ~

\x,e[t,x] and \f.f(t),

where x ranges over D, and f over [D ~ D] and where tis a fixed isolated element of D (that is, t < t holds). The pair con and min will result if we sett=~. (Note that the expression ;[t,x] though

continuous in xis not continuous--or even monotonic--in the variable t.) A lattice may very well possess a large number of isolated

elements, whence a large number of projections. And furthermore this is the only way the function j = Af,f(t) can be a projection. For assume the existence of an inverse i : D ~ [D ~ D] satisfying the proper conditions. Then it would be the case that i(:c)(t) = :c and i(f(t))(y) !;; f(y)

for all :c,y ED and all f E [D ~ DJ. We can prove for all u ED, if t !t U, then i (:c)(U) = J.

by substituting ;[v,x] for fin the second equation above, where vis chosen so that v < t but not v < u. But then note that i(:c)(t) = LJ{i(:c)(u) : u < t}.

If not t < t, then u < t implies t !tu, which leads to absurdity.

Hence t must be isolated, and, as we noted earlier, the function i is uniquely determined as being the one we already knew. Aside from these pairs of projections one could obtain others by combinations with automorphisms. I was unable to determine whether there are further pairs of an essentially different nature.

The topic of projections in these spaces is rather interesting since one has in a way more freedom in T0 -spaces (particularly in injective spaces) than in ordinary spaces for defining functions. As another example, consider the Cartesian square DxD, Aside from the two obvious projections onto D, there is also the "diagonal" system given by the pair:

Ax.(x,x) and A(:c,y) ,:,; n y We shall note in the next section how the choice of an initial projection effects the construction of an inverse limit.

The projections are not the only useful functions in [D ~ D] ~ D. As a final example of what can be done in function spaces we mention the fixed-point operator.

3.14 Proposition. For a [?oontinuous] Zattioe D there is a uniqueZy determined aontinuous mapping fix : [D ~DJ, D where for aZZ f E [D ~ DJ and:,; ED f(fix(f)) = fix(f)

and whenever f(x) = x, then fix(f) i; :,;.

Proof: The proof of the existence of minimal fixed points in complete lattices is well known, as was mentioned in the proof of 2.10.

To establish the continuity, it is sufficient to remark that since all functions f E [D ~ DJ are continuous, we have fix(f) = LJtn(.1.) n=o

where fn(x) = f(f( •.. f(x) •.. ))(n times). Thus fix is the point-wise lub of continuous functions on [D ~ D] and is thus itself continuous. D

4. INVERSE LIMITS. By an inverse system of spaces we understand as usual a sequence 00

<X • > n, Jn n=o

of T0 -spaces and continuous maps jn:Xn+l~ Xn. The space X 00 , called the inverse Zimit of the sequence, is constructed in the familiar way as that subspace of the product space consisting of exactly those infinite sequences co :,; = ( X n) n=o '

where for each n we have xn E Xn, and

The space X is given 00 the product topology, and the maps j_-n :X 00 ~ Xn such that

: X n are of course continous and satisfy the recursion equation:

j 00 n = jn°j 00 (n+l).

Besides this we have the expected extension property for any system of continuous maps y ~ X n

where for each n

Because, we can define f.., y -+ x..,

by the equation

for ally E Y; whence

fn = j.,.nofoo holds. So much for a review of inverse limits. In this paper our interest will center on rather special inverse systems and their limits.

4. 1 Proposition. Let< D ,j >"" be an inverse system of n n n=o

continuous Lattices where each j n :Dn +l-+ Dn is a projection. Then the inverse Zimit space D00 is aZso a continuous Zattice.

Proof: We need only show that D.., as a T0 -space is injective.

So suppose f :X-+ D.., is 00 given and X c Y. Define fn:X-+ Dn by fn = j"°nof..,. Let f n :Y-+ Dn be the maximaZ extension of fn according to 3.8. Now we can see the point of Lemma 3.9: by this construction we guarantee that f = j +l' Hence0 the / required / 00 :Y-+ D00 n n n exists. D I do not know at the time of writing whether this theorem on inverse limits of continuous lattices extends to sequences where, say, the jn are only retractions. Fortunately, sufficiently many projections exist to make this construction useful. Note that by reference to the product space construction of D00 , its lattice ordering is given simply by the relation:

X \; y iff x n Cy - n for all n.

4.2 Proposition. Let< Dn,jn>:=o and D.., be as in 4,1, Then the maps J'oon' ·D-+ Dn are proJ'ections.

00

Proof: The projections jn:Dn+l-+ Dn, as we know, have their uniquely determined inverses in:Dn-+ Dn+l' We can define in 00 :Dn-+ D..,

by the equation:

where

if m<n, { :m(Ymn) Ym = if m=n, im(ym-1) if m>n.

The proof that in 00 and j 00 n form a projection is now an easy computation. D

One should note also the recursion equation:

inoo = i(n+l)ooo in.

These maps also make it possible to state this useful equation: 00

X : LJ i n 00

(X n ) , n=o where x E D It is easy to check that this is a monotone lub, and 00 ,

so we can say each x E D is the Zimit of its projections 00 xn. In fact, from what we know about projections, x n is the best possible approximation toxin the space D .

n

4.3 Corollary. Let the spaaes be as in 4.1 and 4.2, Let D' be any aompZete Zattiae and suppose aontinuous funations f : D ~ D' n n are given so that fn = fn+l 0 in. Then we aan define f 00 : D ~ D' by 00

the equation: 00

f 00 (x) = LJ f n (x n ) n=o for X E Doo' and we have fn = fooo i noo. D

The import of this last result is that within the category of complete lattices, the space D is not only the inverse limit of the 00

Dn , but it is also the direat Zimit. (One system of spaces here uses the j n as connecting maps, the other the i n .) This is the algebraic result that lies at the heart of our main result about inverse limits of function spaces.

Turning to function spaces, let D = D0 be a given continuous lattice. As we have seen in 3.13, there are many ways of making D0 a projection of D1 = [D 0~ D0 ]. Choose one such given by a pair i 0 ,j 0 . Define recursively:

and introduce the pairs in+l' jn+l making Dn+l a projection of Dn+2

by the method of 3.7. Specifically we shall have for x E Dn+l and x' E Dn+2 :

jn+l<x') = j n ox' oi n .

Since these spaces are more than continuous lattices being function spaces, it is interesting to note that the maps i n preserve function value as an algebraic operation as follows:

where x E On and f E Dn+l" Thus in passing to the limit space 000 something of functional application must also be preserved. The precise result shows that indeed 000 becomes its own function space.

~.4 Theorem. The inverse Zimit D00 of the reoursiveZy defined 00 sequenoe < Dn ,j n) n=o of funotion spaoes is not only a [?oontinuous] Zattioe, but it is aZso homeomorphio to its own funotion spaoe (000-+ 000].

Proof: We can write down directly the pair of maps i 00 ,j 00 that provide the homeomorphism: 00 ioo(x) = n=o (i n u ox n+l j ) n ' 00

O 00

= u 00

joo(f) i(n+l)oo(joonofoinoo).

n=o Note that these formulae are simply generalizations at the limit for the formulae we used to define i n ,j n in the first place. Thus it is not surprising that they would provide a projection of [0 00 -+ 000 ] upon 000• Indeed we can compute out j 00(i 00 (x)), noting that all the lubs are monotone and that a double monotone limit can always be replaced

by a single one in view of the continuity of the operations involved, obtaining

00

= LJ i (n+l) n=o 00 (xn+l)

= x.

In the converse order the calculation is only a bit more complicated. The idea is that since all the functions fare

continuous and since the elements x are the limits of their approximations, then each f is actually completely determined by its

sequence of restrictions J=nof in E Dn+i· This simple idea can be 0 00

made more precise with the aid of a lemma about D which allows us 00 ,

in certain cases to recognize projections from limits.

4.5 Lemma. Suppose for each n we have u(n+l) E Dn+l and we let:

u = LJ i(n+l) 00 (u(n+l)).

n=o

Then if

for each n, we can conclude that:

Proof: If the sequence u(n+l) satisfies the recursion, then the limit defining u is monotonic. Therefore by continuity of projection it suffices to prove that

for all m ~ n. This is obvious form= n, and it can be readily proved by induction for larger musing the various recursion equations. (Properly speaking the induction is done on the quantity (m - n) using both n and mas variables.) D

Proof of 4.4 concluded: The lemma applies at once to our calculation, for we find: 00

ioo(joo(f)) = LJ (i nooOJ•oonofoi noooj oon) n=o co 00

= LJ (i noooJ oon)ofolJ (i noooj oon) n=o n=o Here we have just applied the continuity off to be able to confine the lub on the right. But now by the remark following 4.2, we note the functional equation: 00

id = LJ (' 1,ncoo J'oon ) ' n=o and the proof that i 00 and j 00 are inverse to one another is complete.

complete. D We can explain the idea of this proof in other terms using a suggestion made to me by F. W. Lawvere. Consider the category of

continuous lattices and projections. In that category our 0 is, as 00

we have remarked, both a direat and an inverse limit. Note too that with regard to projections [D-+ D1 ) is a funator, for we can also define [j-+ j 1 ] when the maps are projections. In this language our particular inverse system is defined by the recursion:

Dn+l = [Dn--,. Dn] a nd jn+l = [jn--,. jn],

where D0 and j 0 are given in advance. Now the function space construction is continuous in its two arguments turning an inverse limit on the right into an inverse limit and a direat limit on the Zeft also into an inverse limit. A repeated limit can be made into a simple limit, so we can write:

00 • <Dn ,J ·> D = \Zi.m n n=o 00 = "'"'"-+ Zim <Dn ,i n> n=o

and 00

[D -+D 00 00 ] = Zim < [D ...,.DJ, [j ...,.j ]> - n n n n n=o

= 000 (up to isomorphism).

A full checking of the details involved would not make the argument appreciably simpler over the more "element-by-element" argument I have presented. In fact, the proofs are actually the same. But thinking of the result in terms of properties of functors does seem to isolate very well the essential idea and to show how simple it is.

One must only add here a note of caution: the proper choice of category must be done with care. Thus it seems to me that the use of projections rather than arbitrary continuous maps is necessary.

Inasmuch as I have not checked all details in this form, I hope what I say is correct.

Since we have shown (0 -+D to be homeomorphic to D we can 00 00 ] 00 ,

begin to regard them as the same. In particular there ought to be some function space structure to transfer to D This can be done by 00 •

defining functional application for any elements x,y E D by the 00

equation:

Similarly we can define \-abstraction on continuous expressions: \x.[ ••• x ••• ] = j 00 (\x:Doc.[. •• x ••• ]),

and in this way Doc becomes a model for the \-calculus of Church and Curry. The model-theoretic and proof-theoretic aspects of this result will be explained in another paper (Scott (1972)).

Suppose we were to start with the least, non-trivial lattice 0 = {T,i} for Do. Now D1 = [~~OJ has exactly three elements and there are just two ways of defining a projection j :D ~D • They are 0 1 0 illustrated in the figure:

,?;;=:r~:::~ i r!------ [i,i] Hence our construction gives two limit spaces D00 and D!. Are they the same? No, they are not. It can be shown, for example that the T of Doc is isolated (that is, T < T), while the same is not true of D!. More interestingly, David Park has proved that the fixed-point operator fix mentioned in 3.14 has algebraic properties in Doc quite different from those in D!. By algebraia here, we of course have reference to the functional algebra embodied in the application operation x(y) defined on these limit spaces. Note, by the way, that in view of our isomorphism result we can regard fix (or any other similar continuous function for that matter) as an element of Doc. This makes the "algebra" of D00 quite a rich field for study.

The reader will have surely remarked that by virtue of 1.5, every T0 -space X whatsoever can be embedded as a subspace in a D 00 •

Besides this all the continuous functions on X (oh, into D00 , say) can be extended to Doc; whence they can be regarded as elements of Doc. Thus we have been able to embed not only the topology of X into D00 but also all of the continuous function theory over X. So far this is only a "logical" construction. For more interesting "mathematical" results we shall have to investigate whether any useful theorems about the usual function spaces [X ~ XJ can be obtained with the aid of D00 • This method can easily be employed for real- or complex-valued continuous functions, though it seems more oriented toward pointwise convergence than anything else. Still, there seems to be a chance it might be useful--especially if one wished to consider continuous operators on function spaces.

The idea of forming the limit space can also be applied to other funators besides [D .... DJ. Thus instead of solving the "equation"

D = [D .... DJ as we have done with the D00 construction, we could also solve:

V = T + [VxVJ + [V+VJ + [V-+VJ for example. Here T = {L,0,l ,T} is the four-element lattice with 0 and 1 as incomparable elements. By [VxVJ and [V-->V]we understand the usual Cartesian product and function space construction. The+ operator, on the other hand works only in the category of lattices with T as an isolated element. It is defined so as to make:

D+D'~ D'

i

D-4;-0 i a push-out diagram, where the maps from Oare meant to match L with Land T with r. The point of requiring T to be isolated is that both D and D' become projections of D+D'. This construction, though not quite a disjoint union, has many properties in common with that operation on spaces. In particular, if we consider the category with projections as maps, the construction JF(D) = T + [DxD] + [D+DJ + [D-->D] is a funator. Furthermore, we can project JF1(T) onto Tin an obvious way, thereby setting things up for an inverse limit construction:

V Z • <n;,n ( T) • > = .

+1:!!!

'11." ,J n n=o

The resulting continuous lattice satisfies the desired equation up to isomorphism.

The space V constructed in the way just indicated is very rich in subspaces. To see this, consider the space JVof proper projections j where j(T) = T. As in 3.12 this is a complete lattice.

Now that [VxV] and [V+V] and [V-->V]are regarded as subspaaes of this "universe" V itself, we can easily define aontinuous operations (jxk) , (j+k) , and (j-->k) on the projections obtaining again elements of JV.

The projections so obtained correspond to the indicated constructions of subspaces, of course. (Indeed, if we had the time and space, we could show that JV becomes a very interesting category). There will be a particular

projection t corresponding to T, and reason for doing all this is to show that the existence of subspaces of V can now be established by solving equations in Jy, For example, by the fixed-point construction we could find a j E JV such that j =t + (txj) + ((jxj)~j),

The range of j would then be a subspace W ~ V such that W solves the equation:

W = T + [TxW] + [[WxW] ~ W].

And these are only a few examples: simultaneous equations are possible, and many other operators are waiting for discovery and application.

REFERENCES • An announcement of this work and related investigations was first given in Scott (1970). Rather complete references and background material can be found in Scott (1971). A discussion of formal theories is to appear in Scott (1972).

The presentation of the material of the paper changed considerably after the January conference. In the first place remarks

by several participants, Ernie Mannes in particular, caused me to rethink several points. Then the opportunity of lecturing at the Project MACSeminar at MIT during the spring provided the opportunity of trying out some new ideas; these were then codified after lectures at the University of Southern California with the aid of several very helpful discussions on topology with James Dugundji.

The outcome of this development was that I found I could describe the work in purely topological terms in a simple and natural way leaving the lattices to be introduced as a special technique of analysis. This gives the presentation a much less ad hoc appearance, and relates the results to standard point-set topology in a much more understandable way. No doubt the whole idea of using completeness, inverse limits, and continuous functions could be put into a more general, more abstract categorical context, but I am not the man to do it. My interests at present lie in the direction of specific applications, though I can see that there might be some worthwhile directions to pursue.

For example, in understanding the connections of my kind of spaces with other topologies, one should consider the remarks on the topology of lattices in Birkhoff's paper in Abbott (1970). Some

older papers such as Strother (1955) or Michael (1951) might also give some leads. It is curious how little there is of interest in the literature on T0 -spaces. Concerning function spaces there ought to be some connections with the Zimit spaaes of Cook and Fischer (see especially Binz and Keller (1966)) and possibly with the notion of quasi-topology of Spanier (1963), but these are rather vague ideas.

In a different direction note that the algebraia Zattiaes of Gratzer (1968) are in fact continuous lattices in which isolated points are dense. The continuous lattices may be "higher dimensional" while algebraic lattices are "zero dimensional" - in some suitable sense. Every continuous lattice is a retract of an algebraic lattice.

But does this mean anything? Specific bibliographical references follow:

J.C. Abbott, ed., Trends in Lattice Theory, Van Nostrand Reinhold Mathematical Studies, vol. 31 (1970).

P. Alexandro££ and H. Hopf, Topologie I, Springer-Verlag, (1935).

E. Binz and H. H. Keller, Funktionenraume in der Kategorie der Limesraume, Annales Academiae Scientiarum Fennicae, Series A, I.

Mathematica, no, 383 (1966), 21 pp.

G. Birkhoff, Lattice Theory, American Mathematical Society Colloquium Publications, vol. 25, Third (new) edition (1967).

E. tech, Topological Spaces (revised by Z. Frolit and M. Kat~tov), Prague (1966).

G. Gratzer, Universal Algebra, Van Nostrand, (1968).

J. L, Kelley, General Topology, Van Nostrand, (1955).

E. Michael, Topologies on Spaaes of Subsets, Transactions of the American Mathematical Society, vol. 77 (1951), pp. 152-182.

A. Nerode, Some Stone Spaaes and Reaursion Theory, Duke Mathematical Journal, vol. 26 (1959), pp. 397-406.

D. Scott, OutlJne 06 a MathematJcal Theo~y 06 ComputatJon, Proceedings of the Fourth Annual Princeton Conference on Information Sciences and Systems (1970), pp. 169-176.

____ , LattJce Theo~y, Vata Type¢, and SemantJceJ, New York University Symposia in Areas of Current Interest in Computer Science (Randall Rustin ed.) (1971) to appear.

____ , LattJce-theo~etJc Model& 60~ Va~Jou¢ Type-6~ee CalculJ, Proceedings of the IVth International Congress for Logic, Methodology, and the Philosophy of Science, Bucharest (1972), to appear.

E. Spanier, QuaJJ-topologJe&, Duke Mathematical Journal, vol. 30 (1963) pp. 1-14.

W. Strother, FJxed PoJnt&, FJxed SetJ, and M-Ret~actJ, Duke Mathematical Journal, vol. 22 (1955), pp. 551-556.

Correction (Added March, 1972). Robin Milner has pointed out to me

that there is an error in the remark in the paragraph immediately

preceding Proposition 2,5. I was mistaken in saying that if D is

a T0 -space which becomes a complete lattice under its induced

partial ordering, then every set open in the given topology is also

open in the induced topology. There are many counterexamples to

this statement. Let D be any complete lattice. There are two

extreme T0 -topologies which will induce the given partial ordering.

The 6malle6t such topology has as a sub-base for its open sets

those sets of the form:

{x e; D : X g; y}.

These sets are easily proved to be open in any T0 -topology which

induces the partial ordering. At the other extreme consider sets

of the form:

{x e; D y ~ x}.

Such sets will give a base for a T0 -topology that is the

maximal topology inducing the given partial ordering. Clearly they

need not be open in the induced lattice topology; in particular,

they may well fail to satisfy conditions (ii) on open sets. To make

the remark in question correct, we must thus suppose that the given

T 0 -topology is contained within the induced lattice topology. The

equation given in the paragraph indicated will then be a sufficient

condition for the two topologies to be identical.

The remark was employed in the proof of three different pro-

positions: 2.9, 2.10, and 3.3. In the case of 2.9 one must verify

that the product topology is contained within the lattice topology.

This need only be done for the basis for the product topology, and

for such basic open sets the result needed is obvious. In the case

of proposition 2.10 the question concerns a relationship between

the topologies of a space and a subspace; the spaces in question are

also lattices. Note in passing that a lub in the subspace is

generally la~ge~ in the partial ordering than the corresponding lub

relative to the whole space. This puts the inequalities in the

wrong direction, and so it is not immediate that a relativized

open set for the subspace is open in the lattice topology of the

subspace. However, in this case we can appeal to the continuous

retraction.Recall that the relativized open sets of the kind that we

used in the proof of 2.10 are of the form:

u = {z £ D: x < z}

Suppose then that S is a directed set, and that using the lub

in the sense of D we have

Referring back to the proof of 2.10 we know that

which means that

x < j(LJ'S).

From this it follows that

x < j(z), 4ome z e S.

Now j(z) = z , and we have what we need. This argument suffices only for a special type of open sets; but these open sets form a base for the topology, and so the argument is quite general.

Turning now to the proof of theorem 2.3 we note that the topology on the function space is simply the ~ela~ivized product topology.

There is no difficulty with lubs in this case, because, as we showed in the proof of that theorem, all lubs are calculated pointwise.

Thus, it is easy to verify now that the sets open in the product topology are also open in the lattice topology.
