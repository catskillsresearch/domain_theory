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
