---
source_pdf: PRG19.pdf
ocr_method: cursor-vision-triple-merge
verification_status: draft
---

# Transcription (LLM vision OCR)


<!-- page 1 -->

Oxford University Computing Laboratory  
OXFORD OX1 3QD

# LECTURES ON A MATHEMATICAL THEORY OF COMPUTATION

by

Dana S. Scott

Technical Monograph PRG-19  
May 1981  
Oxford University Computing Laboratory,  
Programming Research Group,  
45, Banbury Road,  
OXFORD, OX2 6PE

<!-- page 2 -->

© 1981 by Dana S. Scott  
University of Oxford  
Mathematical Institute  
24-29 St. Giles  
Oxford OX1 3LB

Lecture Course  
Michaelmas Term 1980  
<u>Preliminary Version</u>  
<u>Completed November 1980</u>  
<u>Revised May 1981</u>

<!-- page 3 -->

<!-- page i -->

# TABLE OF CONTENTS

INTRODUCTION (ii)

LECTURE I : *Domains given by neighbourhoods* 1

LECTURE II : *Mappings between domains* 19

LECTURE III : *Domain constructs* 33

LECTURE IV : *Fixed points and recursion* 51

LECTURE V : *Typed $\lambda$-calculus* 69

LECTURE VI : *Introduction to domain equations* 89

LECTURE VII : *Computability in effectively given domains* 113

LECTURE VIII : *Retracts of the universal domain* 133

<!-- page 4 -->

# INTRODUCTION

These notes were written in conjunction with the lectures delivered by me for the Semantics of Programming Languages sequence during Michaelmas Term 1980 at Oxford. I started writing around the first week of October and finished at the end of November. The purpose of the course was to provide the foundations needed for the method of denotational semantics; in particular, I wanted to make the connections with recursive function theory more definite and to show explicit, effectively given solutions to domain equations. Roughly, these chapters cover the first half of the book of J.E. Stoy. I plan soon to expand the notes into a book by adding additional chapters on other theoretical topics that time did not permit me to cover in one eight-week term.

When I started writing Lecture I in October, I did not know what the later lectures would contain: I could see no further ahead than part of Lecture III in the beginning. The lectures had to be typed in advance of the class meetings, however, so there was at the time of composition no opportunity for second thoughts of any major proportions: I had to write the text straight through. As a consequence there are many remarks I would like to transpose and many additional points of explanation I see are needed; further worked examples and easier exercises are also required. During the spring, after receiving many helpful comments, I was able to introduce a few changes in the text and make some necessary corrections. However, a complete retyping was impossible. Nevertheless, this preliminary version of the book seems to provide a quite detailed introduction and is sufficient to exhibit the scope of the approach and several applications.

The idea of using neighbourhood systems to give set-theoretical representations of domains had been in the back of

<!-- page 5 -->

my mind for some time in connection with specific examples. But the thought that a systematic development along these lines might be easier to follow than the more abstract lattice-theoretic and topological approach used by myself and others in many publications only came to me during the IFIP Working Group 2.2 meeting in Copenhagen in mid-June 1980. I gave a brief public presentation at ICALP '80 in Holland in mid-July.

One large mistake I have made is to de-emphasize partial orderings too much, since at the right point the concepts and the language are in fact helpful. The basic plan is that, instead of axiomatizing the theory using partial orderings, the necessary facts come out as *theorems*. For a neighbourhood system $\mathcal{D}$, the set of elements $|\mathcal{D}|$, which consists of filters, is naturally partially ordered. And approximable mappings naturally *preserve* the ordering. And so on. The advantage I see from the point of view of exposition is that properties can be brought out one at a time instead of having to put them down all in advance of any experience with the ideas. My own feeling after writing these chapters is that the plan has worked out far better than I could have dared to hope. I was especially glad that I could generate so many *exercises*, and I hope eventually to provide many more. One interesting place at which partial orderings prove their usefulness is in visualizing domains. As it stands now the text does not contain enough in the way of pictures. This will have to be remedied in a future version. Undoubtedly to include enough explanation, several of the lectures will have to be sub-divided into separate chapters.

One major improvement is needed: to bring Exercise 2.22 into the main text. I did not know in advance how often I would need this result for giving (easy) set-theoretical characterizations of domains and structure on them. This will be an easy repair, but it will cause quite a bit of rewriting. Clearly

<!-- page 6 -->

much more has to be said about the interplay between elements and neighbourhoods. In particular, the character of the elements of a domain, like the power set of a set, has not been sufficiently illustrated, and quite a bit of expansion on this topic is also needed.

Finally I have to explain that I had no time whatsoever to put in references and a bibliography. The ideas I have used have occurred to many, many people who have worked on domains, and I do not wish to claim originality. I *am* claiming some advantage to my style of representation, but I fully realize that a published version will have to have detailed historical references and notes at the ends of the lectures. Needless to say I should very much appreciate any advice or criticism from readers of this preliminary version.

I would like to give a warm word of thanks to the many people who have already commented on the preliminary text both at Oxford and in Boston, where I gave lectures. Very special thanks are due to Steve Comer and Steve Brookes, who spent many hours proof reading the typescripts. The biggest word of thanks, however, is reserved for Elsie Hinkes who, under very considerable pressure, did a wonderful job of typing.

Dana S. Scott  
Merton College  
Oxford  
May 1981

<!-- page 7 -->

# LECTURE I

<u>DOMAINS GIVEN BY NEIGHBOURHOODS</u>

Often an object (or element) can be determined by a selection of its properties. Often it is also the case that it is easier (more convenient, more elementary) to think of these properties than it is to think of the elements themselves. Let us term the properties under consideration *neighbourhoods*, the family of those allowed a *neighbourhood system*.

Generally, the collection of these neighbourhoods is, for one reason or another, somewhat restricted; that is, a completely arbitrary property may not be allowable as a neighbourhood. Therefore, the elements determined by selections of neighbourhoods may not be as separable into the discrete objects common to the classical view of set theory. This is particularly true in working with infinite objects: it is hard to specify an infinite element completely. The theory of elements to be studied here, then, is going to permit *partial elements* as well as *total elements*, and each neighbourhood system will define a *domain* of such elements.

Since we may wish to use a neighbourhood system to introduce elements not previously investigated, the neighbourhoods do not have to be regarded as sets of the as-yet-to-be-defined objects. We can take a non-empty set $\Delta$ of *tokens* (or "traces") that function as "parts" of elements — or even as parts of "descriptions" of elements. Then a neighbourhood is a subset $X \subseteq \Delta$ containing all those tokens that provide sufficient information when taken together to "approximate" a possible element up to a certain "degree". All these words in inverted commas are vague, and in any case we shall have at the start only a *qualitative* theory of "degree of approximation". A token should be considered as a very "rough" representative of an element, and a neighbourhood should be regarded as "smoothing out" irrelevant details by grouping together *all* those representatives sharing some common feature. One neighbourhood, then,

<!-- page 8 -->

may be only a very incomplete specification of an (ideal) element; fuller specifications can be secured by taking "convergent" sequences of neighbourhoods. Even then convergence need not be to a total element.

Let us call the family of allowed neighbourhoods $\mathcal{D}$; it is a family of subsets of the set $\Delta$. An obvious first question is: when are two neighbourhoods $X$, $Y \in \mathcal{D}$ neighbourhoods of the "same" element? This question of course generalizes to a (finite) sequence of neighbourhoods. This property we will call the *consistency* of the sequence of neighbourhoods. By definition this will mean that the given neighbourhoods all contain a common neighbourhood in $\mathcal{D}$. That is, for $X$, $Y$ to be consistent, there must be a $Z \in \mathcal{D}$ with $Z \subseteq X$ and $Z \subseteq Y$. This is not a very informative definition, but it has something of the flavour of a notion of consistency insofar as it can be expressed within $\mathcal{D}$. When consistency holds it seems reasonable enough at first glance to say that the intersection $X \cap Y$ is also an approximation to this common element. If this is reasonable, then $X \cap Y$ should also be regarded as a neighbourhood. This assumption has many consequences, but as a preliminary theory of approximation we will find it quite workable with many natural instances. Taking intersections just means taking more and more properties of the element and putting them together "conjunctively". It is something we do all the time. We therefore accept the idea for the present for giving our first principal definition.

DEFINITION 1.1. A family $\mathcal{D}$ of subsets of a given set $\Delta$ is called a *neighbourhood system* (over $\Delta$) iff it is a non-empty family closed under the intersection of finite consistent sequences of neighbourhoods. That is to say, $\mathcal{D}$ must fulfill these two conditions:

(i) $\Delta \in \mathcal{D}$;

(ii) whenever $X$, $Y$, $Z \in \mathcal{D}$ and $Z \subseteq X \cap Y$, then $X \cap Y \in \mathcal{D}$. $\square$

<!-- page 9 -->

We remark that by convention $\Delta$ corresponds to the intersection of an empty sequence of neighbourhoods; in particular,

$$
\bigcap_{i < n} X_i = \Delta, \text{ if } n = 0;
$$

$$
= \left(\bigcap_{i < n-1} X_i\right) \cap X_{n-1}, \text{ if } n > 0.
$$

Of course, from (ii), we can extend the intersection property to any finite sequence. Consequently, we can say $X_0, \dots, X_{n-1}$ is consistent in $\mathcal{D}$ iff

$$
\bigcap_{i < n} X_i \in \mathcal{D}.
$$

Some examples will help us understand the notions better.

EXAMPLE 1.2. Let $\Delta = \{0, 1\}$ and let $\mathcal{D} = \{\{0, 1\}, \{0\}, \{1\}\}$.

In pictures we have:

```
╭──────────────────────────╮
│   ╭───╮       ╭───╮      │
│   │ 0 │       │ 1 │      │
│   ╰───╯       ╰───╯      │
╰──────────────────────────╯
```

The intention is that 0 and 1 can be completely specified and that they can be identified with the total elements. As we shall see, there is only one partial element: either we give no information (the neighbourhood $\{0, 1\}$), or we decide between 0 and 1 (by giving $\{0\}$ or $\{1\}$). $\square$

EXAMPLE 1.3. Let $\Delta = \{0, 1, 2\}$ and let $\mathcal{D} = \{\{0, 1, 2\}, \{1, 2\}, \{2\}\}$.

In pictures we have:

```
╭──────────────────────────────────────╮
│  0   ╭──────────────────────╮        │
│      │  1        ╭───╮       │        │
│      │           │ 2 │       │        │
│      │           ╰───╯       │        │
│      ╰──────────────────────╯        │
╰──────────────────────────────────────╯

<!-- page 10 -->

Instead of stepping to the total element (here represented by 2) in one big step, the passage is divided into two steps. (Note 0 and 1 cannot be taken as representing total elements.) This example is not very interesting because the direction of approximation is unique. We need an example with some choice. $\square$

EXAMPLE 1.4. Let $\Delta = \{\Lambda, 0, 1, 00, 01, 10, 11\}$ and let $\mathcal{D} = \{\Delta, \{0, 00, 01\}, \{1, 10, 11\}, \{00\}, \{01\}, \{10\}, \{11\}\}$.

Or more understandably in pictures:

```
╭──────────────────────────────────────────────────────────────╮
│   ╭───╮      ╭───╮      ╭───╮      ╭───╮                     │
│   │00 │      │01 │      │10 │      │11 │                     │
│   ╰───╯      ╰───╯      ╰───╯      ╰───╯                     │
│     ╭──────────────────╮    ╭──────────────────╮             │
│     │ 0    00     01   │    │ 1    10     11   │             │
│     ╰──────────────────╯    ╰──────────────────╯             │
│          ╭──────────╮              ╭──────────╮              │
│          │    0     │              │    1     │              │
│          ╰──────────╯              ╰──────────╯              │
│                 ╭──────────────────────────╮                 │
│                 │            Λ             │                 │
│                 ╰──────────────────────────╯                 │
╰──────────────────────────────────────────────────────────────╯
```

The tokens are finite sequences of 0's and 1's (up to length 2) with $\Lambda$ the empty sequence; they form — in the picture — the binary tree with the sequences as the nodes. The neighbourhoods are the subtrees of all nodes above a given node. Obviously this can be generalized to sequences of any length (and to trees less regular than the binary tree). The total elements of the example correspond to the top nodes 00, 01, 10, 11 and the lower nodes to the partial elements. When we are not at a top node we have only partially determined a sequence, and the branching indicates that we have some choice as to how the sequence can be extended. $\square$

It should be noted that, in these three examples, the reason that we have a neighbourhood system is a simple consequence of a

**Resolutions from the image:** “is unique” (not “in unique”); $\mathcal{D}$ begins with $\Delta$, not $\Lambda$; Pass 1’s nested-box diagram matches the neighborhood boundaries in the scan; em dashes around “in the picture” as in the source.

<!-- page 11 -->

very special circumstance: in these systems two neighbourhoods are either disjoint or one is included in the other. This arrangement of neighbourhoods is by no means necessary.

EXAMPLE 1.5. Let $\Delta = \{0, 1, 2, 3\}$ and let $\mathcal{D}$ be the family of all non-empty subsets of $\Delta$.

This system is a direct generalization of Example 1.2., which was special owing to the small number of tokens. (The other examples were special by virtue of the choice of neighbourhoods.) The verification that the present $\mathcal{D}$ is a neighbourhood system rests on nothing more than the remark that sets are consistent in $\mathcal{D}$ iff they have a non-empty intersection. Clearly the arrangement of neighbourhoods in $\mathcal{D}$ can be as varied as a four-element set will allow; if $\Delta$ were made larger, the possible combinations of neighbourhoods could be made as complex as you wish. $\square$

Having some idea now of the variety of neighbourhood systems, we have to discuss what it is they do. As stressed before, the tokens do not have to correspond directly to the elements; but where, we ask, do the elements come from? One obvious suggestion for determining an element is to produce a sequence of "better and better" neighbourhoods:

$$
X_0 \supseteq X_1 \supseteq \cdots \supseteq X_n \supseteq \cdots
$$

Trivially, any finite initial segment of this sequence is consistent, and so each $X_n$ is a partial approximation to the "limit". If $\mathcal{D}$ were always to be taken as *finite*, of course, there would be no point in discussing limits since any such sequence would eventually be constant. The elements in the finite case would therefore be completely represented by neighbourhoods with the *minimal* neighbourhoods corresponding to the total elements. But there are many reasons to go beyond the finite (though perhaps not too far beyond).

Suppose $\langle Y_n \rangle_{n=0}^\infty$ is another "convergent" sequence with

<!-- page 12 -->

$Y_{n+1} \subseteq Y_n$ for all indices: when do the two sequences of neighbourhoods determine the *same limit*? The two sequences can surely be different; for example, $\langle Y_n \rangle_{n=0}^\infty$ could be a subsequence of $\langle X_n \rangle_{n=0}^\infty$, say, $Y_n = X_{2n}$. Still we would want to say that the same limit is obtained. Without being given any further structure on the neighbourhoods, a simple answer is just to say that each sequence goes *equally deep* as the other:

for each $m$ there is an $n$ with $X_n \subseteq Y_m$, and

for each $n$ there is an $m$ with $Y_m \subseteq X_n$.

This definition obviously puts sequences into equivalence classes, and so elements could be identified with these. But such a definition is clumsy for two reasons: it is always tiresome to work with equivalence classes, and there is no reason to think that simple infinite sequences are adequate for determining elements without some rather drastic assumptions on $\mathcal{D}$. Nevertheless, the idea is *suggestive*; we just have to find some construct to represent elements in a unique way and to phrase it in a general enough manner.

Start with $\langle X_n \rangle_{n=0}^\infty$ again, which "converges" as before. Think of all the other sequences equivalent to this one in the sense just defined. We can define the class of all terms of all such sequences very easily as being the family:

$$
x = \{Z \in \mathcal{D} \mid X_n \subseteq Z \text{ for some } n\}.
$$

It is easy to prove that if we form the analogous class for $\langle Y_n \rangle_{n=0}^\infty$, then the two families are *equal* if and only if the sequences are *equivalent*. Thus, we seem justified in letting $x$ represent the limit of $\langle X_n \rangle_{n=0}^\infty$. All we have to do now is to remark on what sort of class $x$ is as a subfamily of $\mathcal{D}$; what we abstract from the construction, however, will be just a bit more general than taking those $x$ that result from sequences.

DEFINITION 1.6. The (ideal) elements of a neighbourhood system $\mathcal{D}$ are those subfamilies $x \subseteq \mathcal{D}$ where:

(i) $\Delta \in x$;

(ii) $X, Y \in x$ always implies $X \cap Y \in x$; and

(iii) whenever $X \in x$ and $X \subseteq Y \in \mathcal{D}$, then $Y \in x$.

The *domain* of all such elements is written as $|\mathcal{D}|$. $\square$

<!-- page 13 -->

The idea of 1.6 is a well-known mathematical device: the families $x$ satisfying (i)–(iii) are usually called *filters*. Most frequently the emphasis is put on the *maximal* filters, and these would be our *total* elements; however, in general, the proof that maximal filters exist is non-constructive, so for our purposes it is better not to neglect the partial filters. When maximal filters can be found, well and good, but we do not have to insist on them. Note that the generality of 1.6 is achieved by not requiring that there is a sequence of neighbourhoods that "generates" the filter $x$. (See Exercise 1.22.)

We have often said that neighbourhoods determine partial elements by themselves; we now make this remark precise.

DEFINITION 1.7. For $X \in \mathcal{D}$, the *principal filter* determined by $X$ is defined by:

$$
\uparrow X = \{ Y \in \mathcal{D} \mid X \subseteq Y \}.
$$

The principal filters form what we shall call the *finite elements* of the domain $|\mathcal{D}|$. $\square$

It is obvious that the correspondence between $X$ and $\uparrow X$ is one-one and inclusion *reversing*, in the sense that

$$
X \subseteq Y \quad \text{iff} \quad \uparrow Y \subseteq \uparrow X
$$

for all $X, Y \in \mathcal{D}$. But, except in very special cases, there is much more to $|\mathcal{D}|$ than just the finite elements. Much of our investigation will be concerned with finding out how much more. The finite elements are, in a certain sense, "dense" in $|\mathcal{D}|$, however, because it is also obvious from the definitions that for each $x \in |\mathcal{D}|$

$$
x = \bigcup \{ \uparrow X \mid X \in x \}.
$$

That is, every element is a certain type of "limit" of finite elements. (This statement is made more precise in Exercise 1.21)

We note that we have now had several occasions to use inclusion relationships between elements; this is an important relationship, and we give it a special name.

<!-- page 14 -->

DEFINITION 1.8. For $x, y \in |\mathcal{D}|$, we say that $x$ *approximates* $y$ iff $x \subseteq y$. The element that approximates all others, $\{\Delta\}$, is called $\perp$ (read: *bottom*); it is the "least defined" element, or the "most partial" element. Elements maximal with respect to the approximation relation are called *total elements*. $\square$

EXAMPLES 1.2 – 1.5 (Revisited). The examples as given were all finite, so any explicitly given filter $x$ is principal, the element is finite, the minimal $X \in x$ tells us all we need to know. In such simple situations there is essentially no difference between elements and neighbourhoods — except for the reversal of the order as noted. This (necessary) reversal should not, however, become a matter of confusion: the smaller the neighbourhood has become, the more it has "converged", and so the better defined the element has become. In the approximation relation the "poorer" elements are placed below the "better" with the total up at the top. This will become clearer in discussing "infinite" elements.

Example 1.3 will be generalized in Exercise 1.1. Let us here generalize first 1.4. We let

$$
\Delta = \Sigma^*,
$$

where $\Sigma = \{0, 1\}$ and $\Sigma^*$ means the set of all finite sequences of 0's and 1's, with $\Lambda$ being the empty sequence. We write $\sigma\tau$ for the *concatenation* or *juxtaposition* of two sequences $\sigma, \tau \in \Sigma^*$. Define

$$
B = \{\sigma\Sigma^* \mid \sigma \in \Sigma^*\}, \text{ where}
$$

$$
\sigma X = \{\sigma\tau \mid \tau \in X\},
$$

for an arbitrary set $X \subseteq \Sigma^*$. In other words, a neighbourhood in $B$ consists of all *extensions* of a given sequence $\sigma$. (Refer back to the finite version of 1.4.) We use the letter "B" to remind us of "binary", and this is an example we shall refer to many times. The proof (if it is not obvious) that $B$ is a neighbourhood system should be done as an exercise.

What do we find in $|B|$? Of course $\perp = \{\Delta\} \in |B|$. For any $x \in |B|$ and $\sigma \in \Sigma^*$ define

$$
\sigma x = \{Y \mid \sigma X \subseteq Y \text{ some } X \in x\}.
$$

<!-- page 15 -->

Again there is an exercise here to show $\sigma x \in |B|$. In particular $\sigma\perp \in |B|$ for all $\sigma \in \Sigma^*$, and these are just the finite elements. The minimal element of $\sigma\perp$ is $\sigma\Delta$. Note that $\sigma_0\perp \subseteq \sigma_1\perp$ if and only if $\sigma_0$ is an *initial segment* of the sequence $\sigma_1$.

If now $x \in |B|$ is any explicitly given element (that is, if we know for any $X \in B$ whether or not $X \in x$), we have but to work out from these definitions that

$$
x = \bigcup_{n=0}^{\infty} \sigma_n\perp,
$$

where the $\sigma_n \in \Sigma^*$ and each $\sigma_n$ is an initial segment of the next $\sigma_{n+1}$. *In general, in any domain, an element is uniquely determined by its finite approximations, and we are just making this explicit in $|B|$.* When we have complete knowledge of $x$, then there are two cases: either the approximations $\sigma_n\perp$ become constant from some point on (where $n > n_0$), or not. In the first case $x$ is finite and equal to $\sigma_{n_0}\perp$; in the second case $x$ is infinite and the $\sigma_n$ fill out an infinite (one-way) sequence.

The generalization of 1.5 to the infinite case where $\Delta = \mathbf{N} = \{0, 1, 2, 3, \ldots, n, \ldots\}$ can be made in more than one way: for instance either we use as neighbourhoods *all* non-empty subsets of $\Delta$ or just those omitting but a finite number of integers. And, as will become apparent, there are other choices giving domains of quite different characters. $\square$

Many constructions (choices of $\mathcal{D}$) lead to the "same" domain; "sameness" is an important notion and it is to be defined in terms of "isomorphism", which in turn is to be defined in terms of approximation preserving correspondences.

DEFINITION 1.9. Two neighbourhood systems $\mathcal{D}_0$ and $\mathcal{D}_1$ determine *isomorphic domains* iff there is a one-one correspondence between $|\mathcal{D}_0|$ and $|\mathcal{D}_1|$ which preserves inclusion between the elements of the domains. In symbols we write $\mathcal{D}_0 \cong \mathcal{D}_1$. $\square$

<!-- page 16 -->

It is certain that the property of 1.9 is necessary, but it may not be so clear that it is sufficient. We shall in fact prove in the next lecture that an isomorphism between domains always maps finite elements to finite elements, so it always results from a one-one inclusion-preserving correspondence between neighbourhoods. This is surely as strong as could be hoped. This general result is not needed to see that particular domains are isomorphic.

In some of the examples tokens corresponded to total elements and in some to partial elements; it is not difficult to see (ex post facto) that every domain can be presented with tokens exactly corresponding to partial elements.

**THEOREM 1.10.** Given any neighbourhood system $\mathcal{D}$, define for $X \in \mathcal{D}$

$$
[X] = \{x \in |\mathcal{D}| \mid X \in x\}.
$$

The subsets $[X] \subseteq |\mathcal{D}|$ for $X \in \mathcal{D}$ form a neighbourhood system over $|\mathcal{D}|$ which determines a domain isomorphic to $|\mathcal{D}|$.

**Proof:** We note first that

(1) $[\Delta] = |\mathcal{D}|.$

Next note that

(2) $X, Y$ are consistent in $\mathcal{D}$ iff $[X] \cap [Y] \neq \emptyset$;

and that for $X, Y \in \mathcal{D}$

(3) $[X] \cap [Y] = [X \cap Y]$ if $X \cap Y \in \mathcal{D}.$

Inasmuch as

(4) $\uparrow X \in [X]$ for all $X \in \mathcal{D},$

it easily follows that $\mathcal{D}$ and the family

$$
\{[X] \mid X \in \mathcal{D}\}
$$

are in a one-one, inclusion-preserving correspondence. Thus, we can induce the desired one-one correspondence between the elements of the two systems. $\square$

<!-- page 17 -->

The import of 1.10 is that the original tokens in $\Delta$ can be replaced by the elements of $|\mathcal{D}|$. This process replaces the neighbourhood $X \subseteq \Delta$ by the subset $[X] \subseteq |\mathcal{D}|$. As the passage is inclusion preserving, the domain has not really changed, only its presentation. Though of some theoretical charm, the theorem is not of much use since we still have to get $\mathcal{D}$ from somewhere. It does emphasize, though, that the rôle of the tokens is simply to keep the inclusions (and intersections) of neighbourhoods sorted out. It is *not* always true that the tokens can be identified with the total elements.

The last theorem in this lecture is a result on *closure properties* of a domain with respect to set-theoretical operations which have interesting meanings with respect to approximation.

**THEOREM 1.11.** If $\mathcal{D}$ is a neighbourhood system and $x_n \in |\mathcal{D}|$ for $n = 0, 1, 2, \ldots$, then

(i) $\bigcap_{n=0}^{\infty} x_n \in |\mathcal{D}|$; and

(ii) $\bigcup_{n=0}^{\infty} x_n \in |\mathcal{D}|$, provided

$$
x_0 \subseteq x_1 \subseteq x_2 \subseteq \cdots \subseteq x_n \subseteq x_{n+1} \subseteq \cdots .
$$

*Proof:* The conditions of 1.6 have to be checked. For the case of intersection, all of 1.6(i)–(iii) are quite obvious. For the case of union, only 1.6(ii) gives pause and it requires the proviso. If $X$ and $Y$ belong to the union, then $X \in x_n$, say, and $Y \in x_m$. But, either $n < m$ or $m < n$, and if $k = \max(n, m)$, then $X, Y \in x_k$. Since $x_k \in |\mathcal{D}|$, we have $X \cap Y \in x_k$; thus, $X \cap Y$ belongs to the union. This proves (ii). $\square$

In words, the intersection is the best element that is at the same time an approximation to all of the elements $x_n$; the intersection is exactly what is common to all the given elements. The union on the other hand is just what the (increas-

<!-- page 18 -->

The union on the other hand is just what the (increasing sequence of the) $x_n$ approximates; the union combines contributions from all the $x_n$ into a "better" element -- but no more than that.

In thinking about domains a rough diagram of the partial-ordering relation $\subseteq$ between elements is often helpful. The picture of 1.4 is an example where the nodes represent the elements. Any finite tree growing up from a root node would also be an example. Indeed, any finite partially ordered set with least element would be an example. (Here no distinction between tokens and elements is necessary.) A lattice diagram is also illustrated.

**A TREE**

```
        ○
       ╱ ╲
      ○   ○
     ╱│╲ ╱│
    ○ ○ ○ ○
     ╲│╱ ╲│
      ○   ○
       ╲ ╱
        ○
        ⊥
```

**A ROUGH PICTURE**

```
   ∿∿∿∿∿∿∿∿∿∿∿
  ╱ │ │ │ │ ╲
 ╱  │ │ │ │  ╲
╱   │ │ │ │   ╲
╲   │ │ │ │   ╱
 ╲  │ │ │ │  ╱
  ╲ │ │ │ │ ╱
   ╲│ │ │ │╱
    ○
    ⊥
```

**A LATTICE**

```
       ○
      ╱│╲
     ╱ │ ╲
    ○  ○  ○
    │╲ │ ╱│
    │ ╲│╱ │
    ○  ○  ○
     ╲ │ ╱
      ╲│╱
       ○
       ⊥
```

The root node is the element $\perp$ of $|\mathcal{D}|$; there need be no top node $\top$. *Approximation* is represented by a passage from a lower node to a higher node along the rising lines. The system $\mathcal{D}$ of neighbourhoods is the collection of sets each of which is all

<!-- page 19 -->

the nodes above a given node. For infinite examples, however, care must be given to introduce limit nodes. The first few exercises should be provided with pictures to illustrate the structure.

## EXERCISES

**EXERCISE 1.12.** Let $\Delta = \mathbb{N} = \{0, 1, 2, \ldots, n, \ldots\}$ be the set of non-negative integers. Use as neighbourhoods final segments:

$$
\{m \in \mathbb{N} \mid m > n\}
$$

for $n \in \mathbb{N}$. Verify that this is a neighbourhood system. What are the total elements? What are the finite elements? Draw a picture of the approximation relation in this domain. (Hint: there is only one limit element.)

**EXERCISE 1.13.** Verify all the assertions made about the system $B$ defined as the infinite generalization of Example 1.4. Draw a picture similar to that given in the text which includes nodes for all $\sigma \in \Sigma^*$. Show the neighbourhoods, how the approximation relation behaves, and where the total elements lie. (The picture is closely related to the "binary tree", but has to have limit nodes all along the top.)

**EXERCISE 1.14.** Let $\Delta = \mathbb{N}$ and let $\mathcal{V}$ be the family of finite non-empty subsets of $\Delta$ plus the set $\Delta$. Show that this is a neighbourhood system. What are the total elements? What are the finite elements? Draw a picture.

**EXERCISE 1.15.** Construct non-isomorphic infinite domains where all elements are finite but where there are no infinite chains $\langle x_n \rangle_{n=0}^{\infty}$ of elements with $x_n \sqsubseteq x_{n+1}$ but $x_n \neq x_{n+1}$ for all $n$.

<!-- page 20 -->

**EXERCISE 1.16.** Let $\Delta = \mathbf{N}$ and let $\mathcal{D}$ be the family of *cofinite* subsets of $\mathbf{N}$. Show that $|\mathcal{D}|$ is isomorphic to the partially ordered set of *all* subsets of $\mathbf{N}$ under inclusion. Construct some other neighbourhood systems where $\mathcal{D}$ is closed under finite intersection. What happens to the total elements in such systems?

**EXERCISE 1.17.** Let $\Delta = \mathbf{R}$ be the real line. Let $\mathcal{D}$ be the set of non-empty open intervals with rational end points plus the set $\Delta$. Show that this is a neighbourhood system. For any real $t \in \mathbf{R}$, show that $\{ X \in \mathcal{D} \mid t \in X \}$ is a filter. Is it always total? What are the total elements of $|\mathcal{D}|$? (Hint: When $t$ is rational consider all intervals with $t$ as a right-hand end point.)

**EXERCISE 1.18.** Let $\mathcal{D}$ be a neighbourhood system. Call a subset $C \subseteq \mathcal{D}$ *consistent* iff every finite subset of $C$ is consistent in $\mathcal{D}$. Give an example where $C$ is a subset with more than two elements, every pair of neighbourhoods in $C$ is consistent, but $C$ is *not* consistent. Show that if $C$ is consistent, then there is a *least* filter $x \in |\mathcal{D}|$ with $C \subseteq x$. Show generally that the *intersection* of any non-empty collection of filters is again a filter.

**EXERCISE 1.19.** Define a *positive neighbourhood system* to be a family $\mathcal{D}$ where (ii) of 1.1 is replaced by **(ii')** whenever $X, Y \in \mathcal{D}$, then $X \cap Y \neq \emptyset$ iff $X \cap Y \in \mathcal{D}$. Prove that a positive neighbourhood system is indeed a neighbourhood system in the sense of the earlier definition. Give an example of a neighbourhood system that is *not* positive. (Hint: (suggested by C.A.R. Hoare). Let $\Delta = \mathbf{N} \times \mathbf{N}$, in the plane. Let $\mathcal{D}$ be the family of subsets $X \subseteq \mathbf{N} \times \mathbf{N}$ where all but a finite number of places the *vertical* sections of $X$ are the whole of $\mathbf{N}$ but at the other places the sections are finite and nonempty. Smaller examples are of course possible.)

<!-- page 21 -->

**EXERCISE 1.20.** Let $\mathcal{D}$ be any neighbourhood system over a set $\Delta$. Let $\Delta' = \mathcal{D}$ and define

$$
\mathcal{D}' = \{ \uparrow X \mid X \in \mathcal{D} \},
$$

where

$$
\uparrow X = \{ Y \in \mathcal{D} \mid Y \subseteq X \}.
$$

Show that $\mathcal{D}'$ is a positive neighbourhood system and that $|\mathcal{D}|$ and $|\mathcal{D}'|$ are isomorphic. Note that for $\mathcal{D}'$ finite elements and tokens are in a one-one correspondence.

**EXERCISE 1.21.** Work out in greater detail the proof of 1.10. Remark that the neighbourhood system over $|\mathcal{D}|$ so constructed is positive, thereby obtaining in a different way the same kind of conclusion as in 1.20. Show also that the system over $|\mathcal{D}|$ is complete in the sense that every filter is fixed by a unique member of the underlying set. (A filter is *fixed by a point* iff it is the filter of *all* neighbourhoods containing that point.) Remark that a complete system is one where tokens and (partial) elements can always be identified (under a suitable one-one correspondence). Show also that consistency of a set $\{ X_i \mid i < n \}$ of neighbourhoods in $\mathcal{D}$ is equivalent to saying

$$
\bigcap_{i < n} [ X_i ] \neq \emptyset.
$$

**EXERCISE 1.22.** (For topologists). Show that the neighbourhoods $[X]$ for $X \in \mathcal{D}$ make $|\mathcal{D}|$ into a topological space where the open subsets $\mathcal{U} \subseteq |\mathcal{D}|$ can be characterized by the following two conditions:

(i) whenever $x \in \mathcal{U}$ and $x \sqsubseteq y \in |\mathcal{D}|$, then $y \in \mathcal{U}$; and

(ii) whenever $x \in \mathcal{U}$, then $[X] \in \mathcal{U}$ for some $X \in x$.

Prove also that the inclusion relation on $|\mathcal{D}|$ can be defined topologically as:

(iii) $x \sqsubseteq y$ iff for all open $\mathcal{U} \subseteq |\mathcal{D}|$, if $x \in \mathcal{U}$ then $y \in \mathcal{U}$.

<!-- page 22 -->

Is $|D|$ ever a Hausdorff space?

Show that if $(x_n)_{n=0}^{\infty}$ is a sequence of elements of $|D|$ with $x_n \subseteq x_{n+1}$ for all $n$, then

$$
\bigcup_{n=0}^{\infty} x_n
$$

is not only in $|D|$ but is a topological limit point of the sequence. Show that any element $x$ is a limit point of the set $\{\uparrow X \mid X \in x\}$. Are there other limit points?

**EXERCISE 1.23.** Suppose that the neighbourhood system $D$ is countable, say,

$$
D = \{X_0, X_1, X_2, \ldots, X_n, \ldots\}.
$$

Suppose further that the property of consistency of finite sequences of neighbourhoods is decidable (or "effectively known"). Then the following sequence is well defined:

$$
\begin{aligned}
Y_0 &= X_0 \\
Y_{n+1} &= X_{n+1}, \text{ if this set is consistent with } Y_0, Y_1, \ldots, Y_n; \\
&= Y_n, \text{ if not.}
\end{aligned}
$$

Show that $\{Y_0, Y_1, \ldots, Y_n, \ldots\}$ is a total element of $|D|$. (Hint: Show first that $Y_0, Y_1, \ldots, Y_{n-1}$ is consistent for all $n$.) In such a system show that all filters can be determined by sequences.

**EXERCISE 1.24.** (For set theorists). Prove, using the Axiom of Choice, or some equivalent principle, that in every domain a partial element can always be extended to a total element. Is this assertion equivalent to the Axiom of Choice? (Hint: Remember to prove that the union of every (transfinite) chain of filters is again a filter.)

<!-- page 23 -->

**EXERCISE 1.25.** (For set theorists). Let $\Delta$ be any well-ordered set (ordinal). (Even small ordinals like $\omega \cdot 3$ or $\omega^5$ are interesting.) Let $\mathcal{D}$ be the family of non-empty *final* segments of $\Delta$. What is $|\mathcal{D}|$? Are all elements finite? Is every approximation to a finite element finite?

**EXERCISE 1.26.** (For algebraists). Let $A$ be a commutative ring with unit. Let $\Delta$ be the set of finite subsets $F \subseteq A$. Define

$$
I(F) = \{G \in \Delta \mid F \subseteq \text{the ideal generated by } G\}.
$$

Prove that the sets of the form $I(F)$ form a neighbourhood system, and that the corresponding domain is isomorphic to the set of ring-theoretic ideals of $A$ partially ordered by inclusion. What would happen if we excluded from $\Delta$ all $F$ with $I(F) = I(\{1\})$, where $1$ is the unit of $A$?

**EXERCISE 1.27.** Further closure properties of domains can be proved for bounded sets. We say $X \subseteq |\mathcal{D}|$ is *bounded* iff for some $y \in |\mathcal{D}|$ we have $x \subseteq y$ for all $x \in X$. This $y$ is called an *upper bound*. We let

$$
\bigsqcup X = \bigcap \{y \in |\mathcal{D}| \mid x \subseteq y \text{ all } x \in X\}.
$$

Prove that if $X$ is bounded, then $\bigsqcup X$ is the *least upper bound* for $X$ in $|\mathcal{D}|$. Prove also: if $U, V \in \mathcal{D}$ are neighbourhoods, then $\{U, V\}$ is consistent in $\mathcal{D}$ iff $\{\uparrow U, \uparrow V\}$ is bounded in $|\mathcal{D}|$. (That is, boundedness is for elements what consistency is for neighbourhoods.) Prove finally with the aid of 1.18 that $X \subseteq |\mathcal{D}|$ is bounded iff every finite subset of $X$ is bounded.

<!-- page 24 -->

# LECTURE II

<u>MAPPINGS BETWEEN DOMAINS</u>

The elements of a domain are regarded as being specified by approximations: the neighbourhoods. With the idea of approximation as the dominant notion, therefore, it is natural to look for a concept of mapping (transformation of domains) that in some suitable sense preserves the spirit of the approximations. In a 'theory of computability,' where the (finite) approximations to the elements are all we can ever know at one time, the only mappings that can be computed are those that proceed by approximation, somehow passing from the neighbourhoods of one domain over to the neighbourhoods of the other.

Suppose $X \in \mathcal{D}_0$ is given - it is an approximation to certain elements of $|\mathcal{D}_0|$. (More precisely $\uparrow X$ is the approximation in the domain, but it is easier to speak of the neighbourhood $X$.) What can be said about the approximations of the images of these elements under the mapping we will call $f$? If $X$ is not a very sharp approximation, then not very much can be said about the image in the other domain $|\mathcal{D}_1|$. Trivially, of course, we can say that $\Delta_1$ is an approximation - because it approximates everything in its domain. Suppose, however, that we could say more. Suppose we could say that both $Y$ and $Y'$ approximate the image of $X$. If the mapping $f$ is coherent, then it is reasonable to suppose that such a statement would imply that $Y$ and $Y'$ are *consistent* in $\mathcal{D}_1$. But if this is so, then since the two neighbourhoods are meant to cluster around the same images, we can feel some confidence in saying that $Y \cap Y'$ approximates these images. In other words to specify $f$ we do not supply a unique image of $X$, but we say which of the $Y \in \mathcal{D}_1$ approximate the (ideal) image. To make this idea work a *monotonicity condition* is also needed since we are trying to express the idea that "if we give at least $X$ as an approximate input to $f$, then we can expect at least $Y$ as output." Thus,

<!-- page 25 -->

a mapping is taken as a kind of relation between neighbourhoods.

**DEFINITION 2.1.** An *approximable mapping* $f : D_0 \to D_1$ between domains is a binary relation $f \subseteq D_0 \times D_1$ between neighbourhoods such that

(i) $\Delta_0 f \Delta_1$ ;

(ii) $X f Y$ and $X f Y'$ always imply $X f (Y \cap Y')$ ;

(iii) $X f Y$, $X' \subseteq X$, and $Y \subseteq Y'$ always imply $X' f Y'$. $\square$

Condition (i) we have already discussed; in a sense it means “ask me no questions and I shall tell you no lies.” In other words “zero input can expect at least zero output.” The other conditions are compatible with having

$$
f = \{ \langle X, \Delta_1 \rangle \mid X \in D_0 \};
$$

that is, $f$ might be the least informative relation and nothing more. But if it is more, then (ii) is, as we explained, a consistency condition. To explain monotonicity in (iii), suppose a mapping relationship is already known, $X f Y$, say. If we *improve* the accuracy of $X$ to $X' \subseteq X$ and if we *degrade* the accuracy of $Y$ to $Y' \supseteq Y$, then we can still assert $X' f Y'$ since this relationship is *less informative* than the former relationship, which was already known. Thus, we see that conditions (i)–(iii) are all reasonably argued as necessary.

One indication that the conditions of 2.1 are sufficient for a definition is that they are exactly what we need to show that $f$ as a neighbourhood relation determines an equivalent elementwise mapping from $|D_0|$ into $|D_1|$. (Owing to the equivalence, we use the same symbol $f$ for both.)

**PROPOSITION 2.2.** Given neighbourhood systems $D_0$ and $D_1$, an approximable mapping $f : D_0 \to D_1$ always determines a function $f : |D_0| \to |D_1|$ between domains by virtue of the formula:

(i) $f(x) = \{ Y \in D_1 \mid \exists X \in x.\ X f Y \}$

for all $x \in |D_0|$. Conversely, this function uniquely determines

<!-- page 26 -->

the original relation by the equivalence:

(ii) $X f Y$ iff $Y \in f(\uparrow X)$

for all $X \in D_0$ and $Y \in D_1$. Approximable functions are always monotone in the following sense:

(iii) $x \subseteq y$ always implies $f(x) \subseteq f(y)$,

for $x, y \in |D_0|$; moreover two approximable functions $f : D_0 \to D_1$ and $g : D_0 \to D_1$ are identical as relations iff

(iv) $f(x) = g(x)$, for all $x \in |D_0|$.

**Proof:** The argument that formula (i) always gives us $f(x) \in |D_1|$ when $x \in |D_0|$ can be safely left to the reader. Note, however, that all the conditions of 2.1 are required to show this. As for (ii), the implication from left to right follows directly from (i) because $X \in \uparrow X$. In the other direction $Y \in f(\uparrow X)$ means that $Z f Y$ holds for some $Z \in \uparrow X$. But from $X \subseteq Z$ it follows that $X f Y$, as we wished.

To prove monotonicity, assume $x \subseteq y$. Now $X \in x$ and $X f Y$ always imply $X \in y$ and $X f Y$. This means $Y \in f(x)$ always implies $Y \in f(y)$; that is, $f(x) \subseteq f(y)$.

Finally, to check that (iv) means $f = g$ as relations, all that has to be remarked that this follows from formulae (i) and (ii). $\square$

Note that the right-hand side of (ii) can be written:

$$\uparrow Y \subseteq f(\uparrow X),$$

which can be read as saying that the partial element determined by the neighbourhood $Y$ approximates the function value at the element determined by $X$. This precise relationship of course fits the informal discussion of mapping given earlier. Indeed whenever $x \in [X]$ and $X f Y$ hold, then $f(x) \in [Y]$ always follows, which is another way to construe the mapping character of $f$. Some examples of mappings are now called for.

<!-- page 27 -->

**EXAMPLE 2.3.** Let $T$ be the neighbourhood system of the two-token domain of Example 1.2. To avoid confusion with some other domains, we will call the two total elements of $|T|$ respectively true and false. There is only one other finite element here, namely $\perp = \text{undefined}$. We often use these elements as indicators of results: true indicates a positive outcome; false, a negative outcome; and $\perp$ indicates that there is not enough information to decide the outcome totally.

Let $B$ be the system for the binary tree as in the last chapter. What we wish to define is an approximable mapping $f : B \to T$. The intuitive idea of the mapping we have in mind is that the binary sequence is being read from left to right, and we are counting the number of 0's seen before the first 1 is encountered. We then test the parity of this count; if it is even, the output is true; if not, false. Using a suggestive informal notation with three dots, some results of the function that does the counting and testing can be written as:

$$
\begin{aligned}
f(0000101\dots) &= \text{true} \\
f(1101110\dots) &= \text{true} \\
f(0111011\dots) &= \text{false} \\
f(0000000\dots) &= \perp.
\end{aligned}
$$

The last equation is necessary, because $0000000$ as a partial element cannot be counted as either even or odd since it can have inconsistent extensions:

$$
\begin{aligned}
0000000\,\perp &\sqsubseteq 00000001\,\perp \\
0000000\,\perp &\sqsubseteq 000000000001\,\perp.
\end{aligned}
$$

So, as far as $f$ is concerned, a plain string of 0's is indefinite. The same answer holds if the 0's go on infinitely.

To be more precise we want

$$
\begin{aligned}
f(0^n 1\,\perp) &= \text{true} && \text{if } n \text{ is even;} \\
&= \text{false} && \text{if } n \text{ is odd.}
\end{aligned}
$$

As a binary relation $f \subseteq B \times T$ we will have

$$
X f Y \text{ iff } Y \in \perp \text{ or } X \sqsubseteq 0^n 1 \Delta \text{ for some } n \in \mathbf{N} \text{ and either } n \text{ is even and } Y \in \text{true or } n \text{ is odd and } Y \in \text{false.}
$$

It should be checked that 2.1(i)–(ii) are satisfied. $\square$

<!-- page 28 -->

**EXAMPLE 2.4.** Let us briefly describe an approximable mapping $g : B \to B$. Informally, $g$ can be said to "read a sequence from left to right and eliminate the first consecutive run of 1's while copying all the other digits as read." We will have

$$
g(0^n 1^k 0 x) = 0^{n+1} x
$$

provided $k > 0$. (Here $1^k$ means a string of 1's of length $k$.) However, if $1^\infty$ is the infinite sequences of 1's, then

$$
\begin{aligned}
g(1^\infty) &= \perp, \text{ and} \\
g(0^n 1^\infty) &= 0^n.
\end{aligned}
$$

This example is instructive, since it shows that a non-trivial mapping can transform a total element into a partial element. $\square$

Aside from our being able to define particular functions outright, we can combine functions in many different ways; the idea of composition is probably the most basic scheme of combination, and there is a technical name for a family of structures with mappings that can be so combined.

**THEOREM 2.5.** The class of neighbourhood systems and approximable mappings form a *category*, where the identity mapping $I_D : D \to D$ relates $X, Y \in D$ as follows:

(i) $X\ I_D\ Y$ iff $X \subseteq Y$.

If $f : D_0 \to D_1$ and $g : D_1 \to D_2$ are given, then the *composition* $g \circ f : D_0 \to D_2$ relates $X \in D_0$ and $Z \in D_2$ as follows:

(ii) $X\ g \circ f\ Z$ iff $\exists Y \in D_1.\ X\ f\ Y$ and $Y\ g\ Z$.

*Proof:* (We may use MacLane [1971] as the standard reference on category theory, but we require hardly more than the basic definitions at this stage.) To check that we have a category, we need to know that the identity and composition maps really are maps in the category and that certain identity and associative laws hold. Now it is obvious that $I_D$ satisfies 2.1 (i)-(iii). Moreover if $f : D_0 \to D_1$, all we have to prove is:

<!-- page 29 -->

$$
f \circ I_{D_0} = I_{D_1} \circ f = f
$$

Checking one of these equations is enough. Thus, for $X \in D_0$ and $Z \in D_1$ we find

$$
\begin{aligned}
X\ f \circ I_{D_0}\ Z &\text{ iff } \exists Y \in D_0.\ X \subseteq Y \text{ and } Y\ f\ Z \\
&\text{ iff } X\ f\ Z.
\end{aligned}
$$

So, $f$ and $f \circ I_{D_0}$ are the same mapping.

Suppose now that $f : D_0 \to D_1$ and $g : D_1 \to D_2$. We have to verify that $g \circ f$ is an approximable mapping. First off, there is no trouble in seeing that $\Delta_0\ g \circ f\ \Delta_2$ holds. Next, suppose that $X\ g \circ f\ Z$ and $X\ g \circ f\ Z'$ hold. Then we have $X\ f\ Y$ and $Y\ g\ Z$ for some choice of $Y \in D_1$. Also $X\ f\ Y'$ and $Y'\ g\ Z'$ hold for some choice of $Y' \in D_1$. By 2.1 (ii) it follows that $X\ f\ (Y \cap Y')$. Since $Y \cap Y' \subseteq Y$, we conclude $(Y \cap Y')\ g\ Z$ by 2.1 (iii); similarly $(Y \cap Y')\ g\ Z'$. Invoking 2.1 (ii) again, we obtain $(Y \cap Y')\ g\ (Z \cap Z')$, and $X\ g \circ f\ (Z \cap Z')$ is proved.

Suppose finally that $X' \subseteq X$, $X\ g \circ f\ Z$, and $Z \subseteq Z'$. Now $X\ f\ Y$ and $Y\ g\ Z$ for some $Y \in D_1$. But then $X'\ f\ Y$ holds; for a similar reason $Y\ g\ Z'$ holds also. Therefore, $X'\ g \circ f\ Z'$ is established, which means that we have checked 2.1 (iii) for $g \circ f$ and have completed the proof that $g \circ f : D_0 \to D_2$.

The verification of associativity is a purely logical deduction. Thus suppose that in addition to $f$ and $g$ we have $h : D_2 \to D_3$. If $X \in D_0$ and $W \in D_3$ we find

$$
\begin{aligned}
X\ h \circ (g \circ f)\ W &\text{ iff } \exists Z \in D_2.\ X\ g \circ f\ Z \text{ and } Z\ h\ W \\
&\text{ iff } \exists Z \in D_2\ \exists Y \in D_1.\ X\ f\ Y \text{ and } Y\ g\ Z \text{ and } Z\ h\ W \\
&\text{ iff } \exists Y \in D_1\ \exists Z \in D_2.\ X\ f\ Y \text{ and } Y\ g\ Z \text{ and } Z\ h\ W \\
&\text{ iff } \exists Y \in D_1.\ X\ f\ Y \text{ and } Y\ (h \circ g)\ W \\
&\text{ iff } X\ (h \circ g) \circ f\ W.
\end{aligned}
$$

So, as relations, $h \circ (g \circ f) = (h \circ g) \circ f$. $\square$

It may seem as though we have, in the definition of composition, written things backwards. But the reason is that when mappings are taken as elementwise functions, then the order is preserved in expressions involving the usual function value notation. We have, for example:
