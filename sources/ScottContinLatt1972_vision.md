---
source_pdf: ScottContinLatt1972.pdf
ocr_method: cursor-vision-triple-merge
verification_status: draft
---

# Transcription (LLM vision OCR)


<!-- page 1 -->

Scott, D. Continuous lattices. In: Toposes, Algebraic Geometry and Logic, edited by F. Lawvere. Springer-Verlag, LNM, vol. 274, 1972, pp. 97-136.

# CONTINUOUS LATTICES

BY

Dana Scott

## ABSTRACT

Starting from the topological point of view a certain wide class of $T_0$-spaces is introduced having a very strong extension property for continuous functions with values in these spaces. It is then shown that all such spaces are complete lattices whose lattice structure determines the topology - these are the *continuous lattices* - and every such lattice has the extension property. With this foundation the lattices are studied in detail with respect to projections, subspaces, embeddings, and constructions such as products, sums, function spaces, and inverse limits. The main result of the paper is a proof that every topological space can be embedded in a continuous lattice which is homeomorphic (and isomorphic) to its own function space. The function algebra of such spaces provides mathematical models for the Church-Curry $\lambda$-calculus.

## CONTENTS

0. Introduction  
1. Injective Spaces  
2. Continuous Lattices  
3. Function Spaces  
4. Inverse Limits  
References

<!-- page 2 -->

98

## 0. Introduction

Through a roundabout chain of mathematical events I have become interested in $T_0$-spaces, those topological spaces satisfying the weakest separation axiom to the effect that two distinct points cannot share the same system of open neighborhoods. These spaces seem to have been originally suggested by Kolmogoroff and were introduced first in Alexandroff and Hopf (1935). Subsequent topology textbooks have dutifully recorded the definition but without much enthusiasm: mainly the idea is introduced to provide exercises. In the book Čech (1966) for example, $T_0$-spaces are called *feebly semi-separated spaces*, which surely is a term expressing mild contempt. Some interest has been shown in finite $T_0$-spaces (finite $T_1$-spaces are necessarily discrete), but generally topology seems to go better under at least the Hausdorff separation axiom. The reason for this is no doubt the strong motivation we get from geometry, where points *are* points and where distinct points *can* be separated.

What I hope to show in this paper is that from a less geometric point of view $T_0$-spaces can be not only interesting but also natural. The interest for me lies in the construction of *function spaces*, and the main result is the production of a large number of $T_0$-spaces $D$ such that $D$ and $[D \to D]$ are *homeomorphic*. Here $[D \to D]$ is the space of all continuous functions from $D$ into $D$ with the topology of pointwise convergence (the product topology). It will be shown that every space can be embedded in such a space $D$, and that $D$ can be chosen to have quite strong extension properties for $D$-valued continuous functions. These properties make $D$ most convenient for applications to logic and recursive function theory, which was the author's original motivation. Some of the facts about these spaces seem to be most easily proved with the aid of some lattice theory, a circumstance that throws new light on the connections between topology and lattices. In fact, the required spaces are at the same time complete lattices whose topology is determined by the lattice structure in a special way, whence my title.

<!-- page 3 -->

<!-- page 99 -->

99

**1. INJECTIVE SPACES.** All spaces are $T_0$-spaces, and we begin by defining a class of spaces to be called *injective*.

**1.1 Definition.** A $T_0$-space $D$ is *injective* iff for arbitrary spaces $X$ and $Y$ if $X \subseteq Y$ as a subspace, then every continuous function $f: X \to D$ can be extended to a continuous function $\bar{f}: Y \to D$. As a diagram we have:

$$
\begin{gathered}
X \subseteq Y \\
X \xrightarrow{f} D \\
Y \xrightarrow{\bar{f}} D
\end{gathered}
$$

Some people will object to this terminology because I use the subspace relationship rather than a monomorphism in the category of $T_0$-spaces and continuous maps. However, only the trivial 1-point space is injective in the sense of monomorphisms in that category, and so the notion is uninteresting. If the reader prefers another terminology, I do not mind. As we shall see these spaces have very strong retraction properties.

A slightly less trivial example of an injective space is the 2-point space $\mathbb{O}$ with "points" $\bot$ and $\top$ where $\{\top\}$ is open but $\{\bot\}$ is not. (This space is sometimes called the *Sierpinski Space*.)

**1.2 Proposition.** The space $\mathbb{O}$ is injective.

**Proof:** As is obvious, the continuous maps $f: X \to \mathbb{O}$ are in a one-one correspondence with the open subsets of $X$ (consider $f^{-1}(\{\top\})$). If $X \subseteq Y$ as a subspace, then an open subset of $X$ is the restriction of some open subset of $Y$. Thus any $f: X \to \mathbb{O}$ can be extended to $\bar{f}: Y \to \mathbb{O}$. $\square$

**1.3 Proposition.** The Cartesian product of any number of injective spaces is injective under the product topology.

**Proof:** The argument is standard. A map into the product can be projected onto each of the factors. Each of these projections can be extended. Then the separate maps can be put together again to make the required extended map into the product. $\square$

We now have a large number of injective spaces, and further examples could be found using the next fact.

**1.4 Proposition.** A retract of an injective space is injective.

**Proof:** Let $D$ be injective. By a retract of $D$ we understand a subspace $D' \subseteq D$ for which there exists a retraction map $j: D \to D'$ such that

<!-- page 4 -->

<!-- page 100 -->

100

$$
D' = \{x \in D : j(x) = x\}.
$$

Then if $f: X \to D'$ and $X \subseteq Y$, we have $f: X \to D$ as a continuous map also. Taking $\bar{f}: Y \to D$, we have only to form

$$
j \circ \bar{f} : Y \to D'
$$

to show that $D'$ is injective. $\square$

The relationship between arbitrary $T_0$-spaces and the injective spaces is given by the embedding theorem.

**1.5 Proposition.** Every $T_0$-space can be embedded in an injective space; in fact, in a Cartesian power of the 2-element space $\mathbb{O}$.

**Proof:** The proof is well known (cf. Čech (1966), Theorem 26B.9, p. 484.) But we give the argument for completeness sake. Let $X$ be the given space, and let $\mathfrak{O}$ be the class of open subsets of $X$. Let

$$
D = \mathbb{O}^{\mathfrak{O}}
$$

be the Cartesian power of $\mathbb{O}$. Then $D$ is injective by 1.3. Define the map $e: X \to D$ by:

$$
e(x)(U) = \begin{cases} \top & \text{if } x \in U, \\ \bot & \text{if } x \notin U, \end{cases}
$$

for $x \in X$ and $U \in \mathfrak{O}$. This map $e$ is continuous in view of the topology given to $\mathbb{O}$ and to $D$. The map $e$ is one-one, because $X$ is $T_0$. Finally, if $U \subseteq X$ is open, then

$$
\begin{aligned}
e(U) &= \{e(x) : x \in U\} \\
&= \{e(x) : e(x)(U) = \top\} \\
&= e(X) \cap \{t \in D : t(U) \in \{\top\}\},
\end{aligned}
$$

which shows that the image $e(U)$ is open in the subspace $e(X) \subseteq D$. Therefore $e: X \to D$ is an embedding of $X$ as a subspace in $D$. $\square$

**1.6 Corollary.** The injective spaces are exactly the retracts of the Cartesian powers of $\mathbb{O}$.

**Proof:** Such a retract is injective by 1.4. If $D$ is injective, then it is (homeomorphic to) a subspace of a power of $\mathbb{O}$. But since $D$ is injective the identity function on the subspace to itself can be extended to the whole of the power of $\mathbb{O}$ providing the required retraction. $\square$

**1.7 Corollary.** A space is injective iff it is a retract of every space of which it is a subspace.

<!-- page 5 -->

101

**Proof:** As in the proof of 1.6, this property is obvious for injective spaces. But in view of 1.5 every such space is a retract of a power of $\mathbb{O}$ and hence is injective. $\square$

As a result of these very elementary considerations, the injective spaces could be called *absolute retracts*, if one remembers to modify the standard definitions by using *arbitrary* subspaces rather than just *closed* subspaces. Note too that it is easy to show that the only continuous maps $e: X \to Y$ for which the extension property

$$
\begin{gathered}
X \xrightarrow{e} Y \\
X \xrightarrow{f} \mathbb{O} \\
Y \xrightarrow{\bar{f}} \mathbb{O}
\end{gathered}
$$

could hold for *all* continuous $f: X \to \mathbb{O}$ are embeddings as subspaces.

Thus it would seem that we have a reasonably good initial grasp of the notion of injective spaces, but further constructions are considerably facilitated by the introduction of the lattice structure.

**2. CONTINUOUS LATTICES.** Every $T_0$-space becomes a partially ordered set under the definition:

$$
x \sqsubseteq y \text{ iff whenever } x \in U \text{ and } U \text{ is open, then } y \in U.
$$

Indeed, though this relation is reflexive and transitive, the condition that it be *antisymmetric* is exactly equivalent to the $T_0$-axiom.

In the converse direction, every partially ordered set $\langle X, \sqsubseteq \rangle$ can be so obtained, for we have only to define $U \subseteq X$ as being open if it satisfies the condition:

(i) whenever $x \in U$ and $x \sqsubseteq y$, then $y \in U$.

The axioms for partial order make $X$ a $T_0$-space, because for any $y \in X$ the set

$$
\{x \in X : x \not\sqsubseteq y\}
$$

is open. This connection is not very interesting, however.

What *is* interesting in topological spaces is *convergence* and the properties of *limit points*. We shall discuss limits in terms of *nets*, in particular in terms of *monotone nets*. A monotone net in a $T_0$-space $X$ is a function

$$
x : I \to X
$$

<!-- page 6 -->

<!-- page 102 -->

102

where $\langle I, \le \rangle$ is a directed set and where $i \le j$ implies $x_i \sqsubseteq x_j$ for all $i, j \in I$. In a $T_1$-space a monotone net is constant (hence, uninteresting) because the $\sqsubseteq$-relation is the identity. As usual (cf. Kelley (1955), p.66) we say that a net $x$ *converges* to an element $y$ iff whenever $U$ is open and $y \in U$, then for some $i \in I$ we have $x_j \in U$ for all $j \ge i$. Note that a monotone net $x$ converges to each of its terms $x_i$. Suppose that a monotone net $x$ converges to an element $y$ which is an upper bound to all the terms of $x$. Then $y$ must be the *least upper bound*, which we write as:

$$
y = \bigsqcup \{x_i : i \in I\}.
$$

To see this, assume that $z$ is any other upper bound with $x_i \sqsubseteq z$ for all $i \in I$. If $U$ is open and $y \in U$, then $x_i \in U$ for some $i \in I$. But then $z \in U$, and so $y \sqsubseteq z$ follows.

We shall find that most of the facts about the topology of the spaces we are concerned with here can be expressed in terms of least upper bounds (lubs). It is not always the case, however, that lubs are limits. Thus, for a partially ordered set $X$, we impose a further restriction on its topology beyond condition (i) for saying when a subset $U$ is open:

(ii) whenever $S \subseteq X$ is *directed*, $\bigsqcup S$ exists, and $\bigsqcup S \in U$, then $S \cap U \neq \emptyset$.

By a directed subset of $X$ we of course mean that it is directed in the sense of the partial ordering $\sqsubseteq$. Note that in this paper directed sets are always *non-empty*. The sets satisfying (i) and (ii) form the *induced topology* on a partially ordered set $X$, which is still a $T_0$-space because the sets $\{x \in X : x \not\sqsubseteq y\}$ remain open even in the sense of (ii). Obviously a directed set $S \subseteq X$ can be regarded as a net, and now in view of (ii) it follows that $S$ converges to $\bigsqcup S$ — if this lub exists. We can summarize this discussion as follows.

**2.1 Proposition.** *In a partially ordered set $X$ with the induced topology, a monotone net $x : I \to X$ with a least upper bound converges to an element $y \in X$ iff*

$$
y \sqsubseteq \bigsqcup \{x_i : i \in I\}.
$$

$\square$

Our main interest will lie with those partially ordered sets in which every subset has a lub: namely, *complete lattices*. If $D$ is such a space we write $\bot = \bigsqcup \emptyset$ and $\top = \bigsqcup D$ for the smallest and largest elements (read: bottom and top). As is well known, greatest lower bounds must exist, for:

$$
\sqcap S = \bigsqcup \{x \in D : x \sqsubseteq y \text{ for all } y \in S\}
$$

gives the definition.

Given a complete lattice $D$ we define

<!-- page 7 -->

103

$$
x \ll y \text{ iff } y \in \text{Int}\,\{z \in D : x \sqsubseteq z\},
$$

where the interior is taken in the sense of the induced topology. The relation $x \ll y$ behaves somewhat like a strict ordering relation; at least its meaning is clearly that $y$ should be definitely larger than $x$ in the partial ordering. Such a relation has many pleasant properties.

The primary purpose of introducing it is to provide a simple definition for the kind of spaces that are most useful to us. We first mention the most elementary features of this relation.

**2.2 Proposition.** In a complete lattice $D$ we have:

(i) $\bot \ll x$;

(ii) $x \ll z$ and $y \ll z$ imply $x \sqcup y \ll z$;

(iii) $x \ll y \sqsubseteq z$ implies $x \ll z$;

(iv) $x \sqsubseteq y \ll z$ implies $x \ll z$;

(v) $x \ll y$ implies $x \sqsubseteq y$;

(vi) $x \ll x$ iff $\{z \in D : x \sqsubseteq z\}$ is open;

(vii) if $S \subseteq D$ is directed, then $x \ll \bigsqcup S$ iff $x \ll y$ for some $y \in S$. $\square$

The proofs of these statements can be safely left to the reader.

**2.3 Definition.** A *continuous lattice* is a complete lattice $D$ in which for every $y \in D$ we have:

$$
y = \bigsqcup \{x \in D : x \ll y\}.
$$

As an alternate definition we find:

**2.4 Proposition.** A complete lattice $D$ is continuous iff for every $y \in D$ we have:

$$
y = \bigsqcup \{\sqcap U : y \in U\},
$$

where $U$ ranges over the open subsets of $D$.

**Proof:** Suppose $D$ is continuous. If $y \in D$ and $x \ll y$, then let $U = \text{Int}\,\{z : x \sqsubseteq z\}$, an open set. Now $y \in U$ by definition, and $U \subseteq \{z : x \sqsubseteq z\}$. Thus,

$$
x \sqsubseteq \sqcap U \sqsubseteq y.
$$

It easily follows by lattice theory that the equation of 2.3 implies that of 2.4.

In the converse direction we have only to note that if $U$ is open and $y \in U$, then $\sqcap U \ll y$. The implication from 2.4 to 2.3 results at once. $\square$

<!-- page 8 -->

<!-- page 8 -->

104

What is the idea of this definition? A continuous lattice is more special than a complete lattice: not only are lubs to be limits but every element must be a limit from below. This rather rough remark can be made more precise. In any complete lattice $D$ define the *principal limit* of a net $x : I \to D$ by the formula:

$$
\lim \langle x_i : i \in I \rangle = \bigsqcup \{\sqcap \{ x_j : j \ge i \} : i \in I \}.
$$

Then specify that $x$ converges to $y \in D$ iff

$$
y \sqsubseteq \lim \langle x_i : i \in I \rangle.
$$

Having a notion of convergence, we can then say that $U \subseteq D$ is open iff every net converging to an element of $U$ is eventually in $U$. This gives nothing more than what we have called the induced topology above, as is easily checked. But now being in possession of a topology, we can redefine convergence in the usual way. Question: when do the two notions of convergence agree? Answer: if and only if $D$ is a continuous lattice.

For obviously by construction the limit definition of convergence implies the topological. Now if $D$ is a continuous lattice and $x$ converges to $y$ topologically, consider an open $U \subseteq D$ with $y \in U$. For some $i \in I$ we shall have $x_j \in U$ for all $j \ge i$. Therefore

$$
\sqcap U \sqsubseteq \sqcap \{ x_j : j \ge i \} \sqsubseteq \lim \langle x_i : i \in I \rangle.
$$

From the formula of 2.4 it at once follows that $y \sqsubseteq \lim \langle x_i : i \in I \rangle$. Thus, in continuous lattices, we have shown that the two notions of convergence are the same.

Finally, suppose that the two notions coincide for a complete lattice $D$. Define a directed set $I = \{(U, z) : y, z \in U\}$, where $z$ ranges over $D$ and $U$ over open subsets of $D$. This set is directed by the relation: $(U, z) \le (V, w)$ iff $U \supseteq V$. Let $x : I \to D$ be given by: $x(U, z) = z$. Then $x$ is a net converging to $y$ topologically. But

$$
\lim \langle x_i : i \in I \rangle = \bigsqcup \{\sqcap U : y \in U\}.
$$

In this way we see that the assumption about the two styles of convergence implies that $D$ is a continuous lattice in view of 2.4.

In $T_0$-spaces continuous functions are always monotonic (i.e. $\sqsubseteq$-preserving). For continuous lattices, by virtue of the remarks we have just made about limits, we can define the continuity of $f : D \to D'$ to mean that

$$
f(\lim \langle x_i : i \in I \rangle) \sqsubseteq \lim' \langle f(x_i) : i \in I \rangle
$$

for all nets $x : I \to D$. This is all very fine, but general limits are messy to work with; we shall find it easier to state results in terms of lubs as in 2.5–2.7 below.

Before going any deeper, however, we should clear up another point about topologies. Suppose that $D$ is any $T_0$-space which becomes a complete lattice under its induced partial ordering. Then it is evident from our definitions that every set open in the given topology is also open in the topology induced from the lattice structure. Question: when do the two topologies agree? Answer: a sufficient condition is that the equation:

$$
y = \bigsqcup \{\sqcap U : y \in U\}
$$

hold for all $y \in D$, where $U$ ranges over the given open sets. Because in that case if $V$ is open in the lattice sense and $y \in V$, then $\sqcap U \in V$ for some set $U$, open in the given sense, where $y \in U$. But $U \subseteq V$ follows, and so $V$ is a union of given open sets and is itself open in the given topology. Of course this equation implies that $D$ is a continuous lattice by virtue of 2.4. Notice that by the same token the sets of the form $\{y \in D : x \ll y\}$ will form a basis for the open sets of a continuous lattice.
