---
source_pdf: PRG19.pdf
title: "Lectures on a Mathematical Theory of Computation"
author: Dana Scott
year: 1981
citation_key: Sco81
alias: "The PRG-19 blue pamphlet (neighborhood systems)"
bibliography: "Scott, D. Lectures on a Mathematical Theory of Computation. Technical Monograph PRG-19, Oxford University Computing Laboratory, May 1981."
pages: 152
extraction_method: "pdftotext"
verification_status: draft
verified_by: null
verified_date: null
---

# Lectures on a Mathematical Theory of Computation

**Author:** Dana Scott (1981)  
**Source file:** `PRG19.pdf`  
**Also known as:** The PRG-19 blue pamphlet (neighborhood systems)

> **Human verification required.** This file is a machine-generated *draft*.
> Compare each `<!-- page N -->` block to the PDF. Correct OCR errors, restore
> mathematical notation, and check off items below. When done, set
> `verification_status: verified` in the YAML front matter and record your name
> and date.

## Bibliography

Scott, D. Lectures on a Mathematical Theory of Computation. Technical Monograph PRG-19, Oxford University Computing Laboratory, May 1981.

## Verification checklist

- [ ] p.8: DEFINITION 1.1.      A family D of subsets of a given set A is
- [ ] p.12: DEFINITION 1.6.            The (ideal) el.ements       of a neighbourhood system
- [ ] p.13: DEFINITION 1.7.       For XE V. the principaZ fater     determined by
- [ ] p.14: DEFINITION. 1.8. For x. y e lVI, .....e say th·at x approzimates r i f f
- [ ] p.15: DEFINITION 1.9.       Two neighbourhood systems V o and V 1 determine
- [ ] p.16: THEOREM 1.10.             Given any neighbollrhoo3 system V", define for
- [ ] p.17: THEOREM 1.11.       If V is a neighbourhood system and XnE IV! for
- [ ] p.28: THEOREM 2.5.     The class of neighbourhood systems and approximable
- [ ] p.30: PROPOSITION 2.6.     Given f : '0 0 +'0 1 and g: '0 1 +'0 2 ' the following
- [ ] p.30: THEOREM 2.7.    Every isomorphism between domains results from an
- [ ] p.37: DEFINITION 3.1.    Let neighbourhood systems 1'0 and 1'1 be
- [ ] p.37: PROPOSITION 3.2.   The con!;'truct 1'0 x 1'1 always gives a neigh­
- [ ] p.38: DEFINITION 3.3.             Projection mappinga
- [ ] p.39: PROPOSITION 3.4..     The mappings PO' P1 and           < f.g)o   are approx­
- [ ] p.40: THEOREM 3.5.     An elementwise function
- [ ] p.40: LEMMA 3.6.     Given be I'D, 1) the constant function
- [ ] p.42: DEFINITION 3.8. Given neighbourhood systems Va and V • the
- [ ] p.43: PROPOSITION 3.9.     Let neighbourhoods Xi E Va and Y E 01 be given
- [ ] p.44: THEOREM 3.10.                                  and '0 ' the function
- [ ] p.45: THEOREM 3.".        Given neighbourhood systems      V, and P 2 , there is a
- [ ] p.46: 2 I 3FE(V,        ~V2)3XEx.fEFand FUXevalY
- [ ] p.48: THEOREM 3.13.       For approximable functions f,g: VO ... V, we have
- [ ] p.55: THEOREM 4.1. For any approximable mapping f: V ... V on any domain,
- [ ] p.56: 0 Yo) f (X
- [ ] p.56: 0       Yi) f · · · f(X n 0 Yn ) = XOY.
- [ ] p.56: THEOREM 4.2.     For any domain V, there is an approximable mapping
- [ ] p.65: THEOREM 4.6.          All models of Peano's Axioms are isomorphic.
- [ ] p.77: THEOREM 5.'.           Every typed), - term t defines an approximable function
- [ ] p.81: PROPOSITION 5.3.           The least fixed point of
- [ ] p.82: PROPOSITION 5.4.           Let x. Y J      and T(X, y) be of the same type V
- [ ] p.84: THEOREM 5.6.    For every partial recursive function h: }J .... tJ, there
- [ ] p.93: 1 X u 2Y Sr.
- [ ] p.101: DEFINITION 6.3.      A functor on a category (into itself) associates
- [ ] p.102: DEFINITION 6.4.          A T-tItgebra is a domain E in the category to­
- [ ] p.103: DEFINITION 6.5.        A T-algebra is initiaZ if and only if there is
- [ ] p.103: PROPOSITION 6.6.        Any two initial T-algebras are uniquely iso­
- [ ] p.104: DEFINITION 6.B.   On the category of domains and strict approxi­
- [ ] p.105: THEOREM 6.9.     If the functor T is continuous on maps and if
- [ ] p.105: DEFINITION 6.10.      For two neighbourhood systems V and Ewe
- [ ] p.106: PROPOSITION 6.11           For a given neighbourhood system E. the set

---

## Transcription


<!-- page 1 (pdftotext) -->

                                                                                    "


                             Oyf,",~,..j t 1,~;,,~r~:"f ,-..---,­



                                               (j)l.\VI U \ )/'-_ \
                                                                      ,j\ ...   J




                               LECTU,ES
                                  ON A

                       l'l~THEr'~T ICAL     THEORY
                                    OF
                             CO~lPUTAT JON




                                    by


                             Dana S, Scott




Technical Monograph PRG-19
May 1981
Oxford University Computing laboratory,
Programming Research Group.
45, Banbury Road.
OXFORD,   OX2 6PE

<!-- page 2 (pdftotext) -->

\~   198· by Dana S.   Scott

     Uni~ersity of Oxford
     MaUematical Institute
     24-29 St. Gi les
     Oxford OXl 3LB




                              Lecture Course
                           Michaelmas Term 1980
                               Preliminary Version
                         Completed November 1980
                               Revised May 1981

<!-- page 3 (pdftotext) -->

                                                                      (i)



                             TABLE OF CONTENTS




INTRODUCTION                                                   (ii)


LECTURE     I   : Do1TO.ins given by nsighbou:t'hoods


LECTURE    II     Mappings between donnins                      19


LECTURE   III     Domain constructs                             33


LECTURE    IV   : Fixed points and recursion                    51


LECTURE     V   : Typed A - caLculus                            69


LECTURE    VI     In troduction to donuin equations             89


LECTURE   VII   : Computability in effectively given domains   113


LECTURE VII I   : Retracts of tM universal dontlin             133

<!-- page 4 (pdftotext) -->

( i i)




                           INTRODUCTION


      These notes were written in conjunction with the lectures
delivered by me for the Semantics of Programming Languages
sequence during Michaelmas Term 1980 at Oxford.       I started
writing around the first week of October and finished at the
end of November. The purpose of the course was to provide the
foundations needed for the method of denotational semantics;
in particula~ I wanted to make the connections with recursive
function theory more definite and to show explicit, effectively
given solutions to domain equations.   Roughly. these chapters
cover the first half of the book of J.E. Stay.    I    plan soon to
expand the notes into a book by adding additional chapters on
other theoretical topics that time did not permi t me to cover
in one eight-week term.

      Khen I started writing Lecture I in October~ I did not
know what the later lectures would contain: I could see no
further ahead than part of Lecture III in the beginning.
The lectures had to be typed in advance of the class meetings)
however) so there was at the time of composition no opportunity
for second thoughts of any major proportions: I had to ...'rite
the text s~raight through. As a consequence there are many
remarks I would like to transpose and many additional points
of explanation 1 see are needed; further worked examples and
easier exercises are also required. During the spring, after
receiving many helpful comments. I was able to introduce a few
changes in the text and make some necessary corrections. Howeve~
a complete retyping was impossible. Nevertheless. this prelimin­
ary version of the book seems to provide a quite detailed
introduction and is sufficient to exhibit the scope of the
approach and several applications.

     The idea of using neighbourhood systems to give set­
theoretical representations of domains had been in the back of

<!-- page 5 (pdftotext) -->

                                                                 ( iii)

my mind for some time in connection with specific examples.
But the thought that a systematic development along these
lines might be easier to follow than the more abstract
lattice-theoretic and topological approach used by myself
and others in many publications only came to me during the
IFIP Working Group 2.2 meeting in Copenhagen in mid-June 19BO.
I gave a brief public presentation at ICALP '80 in Holland in
mid-July.

      One large mistake I have made is to de-emphasize partial
orderings too much, since at the right point the concepts and
the language are in fact helpful. The basic plan is that,
instead of ax iomati zing the theory using partial orderings,
the necessary facts come out as theorems. For a neighbourhood
system 0, the set of elements lVI, which consists of filters,
is naturally partially ordered.    And approximable mappings
naturally preserve the ordering. And so on. The advantage
I see from the point of view of exposition is that properties
can be brought out one at a time instead of having to put them
down all in advance of any experience with the ideas. My o~n
feeling after writing these chapters is that the plan has
worked out far better than I could have dared to hope. I was
especially glad that I could generate so many exercises. and
I hope eventually to provide many more. One interesting place
at which partial orderings prove their usefulness is in
visualizing domains. As it staRds now the text does not contain
enough in the way of pictures. This will have to be remedied
in a future version.      Undoubtedly toinclude enough explanation.
several of the lectures will have to be sub-divided into separate
chapters.

     One major improvement is needed: to bring Exercise 2.22
into the main text. I did not know in advance how often I \wuld
need this result for giving (easy) set-theoretical characteriza­
tions of domains and structure on them. This will be an easy
repair. but it will cause quite a bit of rewriting. Clearly

<!-- page 6 (pdftotext) -->

(iv)

much mOTe has to be said about the interplay between elements
and neighbourhoods.   In particular, the character of the elements
of a domain. like the power set of a set. has not been sufficient­
ly illustrated I and quite a bit of expansion on this topic is
also needed.


       Finally I have to explain that I had no time whatsoever
to put in references and a bibliography.  The ideas I have
used have occurred to many. many people who have 'Worked on
domains, and I do not wish to claim originality.   I am claim­
ing some advantage to my style of representation, but I fully
realize that a published version will have to have detailed
historical references and notes at the ends of the lectures.
Needless to say I shOUld very much appreciate any advice or
criticism from readers of this preliminary version.


       I would like to give a warm word of thanks to the many
people 'Who have already commented on the preliminary text both
at Oxford and in Boston, where I gave lectures.       Very special
thanks are due to Steve Comer and Steve Brookes, who spent
many hours proof reading the typescripts. The biggest 'Word
of thanks, however, is reserved for Elsie Hinkes who, under
very considerable pressure. did a wonderful job of typing.




                                           Dana S. Scott
                                           Merton College
                                           Oxford
                                           May 19B1

<!-- page 7 (pdftotext) -->

                                                                            1


                                LECTURE I
                     DOMAINS GIVEN BY NEIGHBOURHOODS


     Often an object (or element) can be determined by a
selection of its properties. Often it is also the case that
it is easier (more convenient, more elementary) to think of
these properties than it is to think of the elements them­
selves. Let us term the properties under consideration
neighhoW'hoods, the family of those allowed a neighoowohLJod system.
Generally, the collection of these neighbourhoods is, for one
reason or another, somewhat restricted; that is, a completely
arbitrary property may not be allowable as a neighbourhood.
Therefore, the elements determined by selections of neighbour­
hoods may not be as separable into the discrete objects common
to the classical view of set theory.        This is particularly true
in working with infinite objects:       it is hard to specify an
infinite element completely.      The theory of elements to be
studied here, then, is going to permit partiatelements as well
as totaZ   elements, and each neighbourhood system will define a
dOmain of such elements.

      Since we may wish to use a neighbourhood system to intro­
duce elements not previously investigated,the neighbourhoods do
not have to be regarded as sets of the as-yet-to-be-defined
objects.    We can take a non-empty set 4 of tvkens (or "traces")
that function as "parts"    of elements - or even as parts of
"descriptions" of elements.      Then a neighbourhood is a subset
X E...6. containing all those tokens that provide sufficient
information when taken together to t'approximate"      a possible
element up to a certain "degree".      All these words in inverted
commas are vague. and in any case we shall have at the start
only a quaUtatitJe   theory of ltdegree of approximation".     A.   token
should be considered as a very "rough" representative of an
element, and a neighbourhood should be regarded as "smoothing
out" irrelevant details by grouping together       aU those repres­
mtatives sharing some common feature.        One neighbourhood, then,

<!-- page 8 (pdftotext) -->

2
may be only a very incomplete specification of an (ideal)
element;   fuller specifications can be secured by taking
"coTIvergent" sequences of neighbourhoods.       Even then conver­
gence need not be to a total element.

    Let us call the family of allowed neighbourhoods V; it
is a family of subsets of the set A.       An obvious    first
question is:   when are two neighbourhoods X. ye V neighbour­
hoods of the "same" element?      This question of course generalizes
to a (finite) sequence of neighbourhoods. This property we will
call the   consistenc.l,f of the sequence of neighbourhoods.     By
definition this Nill mean that the given neighbourhoods all contain
a common neighbourhood in V.      That is, for X, Y to be consistent,
there must be a ZeV with 2=:X and Z=:Y.         This is not a very in­
formative definition, but it has something of the flavour of a
notion of consistency insofar as it can be expressed within V.
When consistency holds it seems reasonable enough at first
glance to say that the intersection X n Y is also an approximation
to this COmmon element.     If this is reasonable.      then X n Y should
also be regarded as a neighbourhood.       This assumption has many
consequences, but as a preliminary theory of approximation we
will find it quite workable with many natural instances.
Taking intersections just means taking more and more properties
of the element and putting them togetherl1conjunctively~1 It is
something we do all the time.      We therefore accept the idea for
the present for giving our first principal definition.



DEFINITION 1.1.      A family D of subsets of a given set A is
called a   neighbourhood system (over A) iff it is a non-empty
family closed under the intersection of finite consistent
sequences of neighbourhoods.      That is to say. V must fulfill
these two conditions:

    (i)    "EV;
    (ii)   whenever X J Y) Z E V and Z s.X n Y J then X n Y E V. 0

<!-- page 9 (pdftotext) -->

                                                                        3

    We remark tha t by convention lJ. corresponds to the     inter~

section of an     empty sequence of neighbourhoods;    in particular,

              (I Xi =..6., if n = 0;
              i<n
                    .((lX i ) n n-1
                                  X , i f n > O.

                       i<n-1


Of COUTse, from     (ii) t we can extend the intersection property
to any finite sequence.        Consequently, we can say X "'"
                                                         O
                                                                  X_
                                                                  n 1
is consistent in V iff


              (I
              i<n
                  Xi E V.


Some examples will help us understand the notions better.

EXAMPLE 1.2.       Let a= {O,n and let

                  V· {( 0,1), {OJ, (1) j .

In pictures
               we have©             Q
The intention is     that 0 and 1 can be completely specified and
that they can be identified with the total elements.         As 'We
shall see t    there is only one partial element:     either we give
no info·rma tien (the neighbourhood {D.'}), or we decide between
o and 1 (by giving (OJ or In).         0


EXAMPLE 1.3.       Let lJ. = {D.1,2} and let

                  V<{{0.1,2),     {1.2}, (2l]

In pictures we have:




                      CCQ))

<!-- page 10 (pdftotext) -->

4

Instead of stepping to the total element (here represented by
2)   in one big step, the passage is divided into two steps.
(Note 0 and 1 cannot be taken as representing to't.al elements.)
This example is not very interesting because the       direction of
approximation in unique.     We need an example with some choice. 0



EXAMPLE 1. 4    Let

                t:. = {A.O , 1.00.01,10,11}
                V = {t:..{O,OO.Ol}. {1.10,11},
                      {ool, {O1}, {10l,   (11) l.
Or more understandably in pictures:




The tokens aTe fini te sequences of 0 Isand l' 5 (up to length 2)
wi th A the empty sequence; they form - in the pic ture - the
binary tree with the sequences as the nodes.        The neighbourhoods
are the subtrees of all nodes above a given node.   Obviously
this can be generalized to sequences of any length (and to
trees less regUlar than the binary tree). The total elements
of the example correspond to the top nodes 00. 01 J 10. 11 and
the lower nodes to the partial elements. When we are not at a
top node we have only partially determined a sequence, and the
branching indicates that we have some choice as to how the
sequence can be extended. 0

    It shOUld be noted that. in these three examples, the reason
that we have a neighbourhood system is a simple consequence of a

<!-- page 11 (pdftotext) -->

                                                                                5
very special ci rcumstance:        in these systems t ..... o neighbollrhoods
are either disjoint or one is inCluded in the other. This
arrangement of neighbourhoods is by no means necessary.

EXAMPLE 1.5.     Let .6..=-{O,1,2,3} and let V be the family of all
non-empty subsets of A.
    This system is a direct generalization of Example 1.2.,
which was special owing to the Small number of tokens.               (The
other examples were special by virtue of the choice of neigh­
bourhoods.)    The verification that the present V is a neighbour­
hood system rests on nothing more than the remark that sets are
consistent in V iff they have a non-empty intersection. Clearly
the arrangement of neighbourhoods in '0 can be as varied as a
four-element set will allow; if d were made larger, the possible
combinations of neighbourhoods could be made as complex as you
wish. 0

    Having some idea now of the variety of neighbourhood systems,
we have to discuss what it is they do. As stressed before, the
tokens do not have to correspond directly to the elements; but
where. we ask, do the elements come from? One obvious suggestion
for determining an element is to produce a sequence of 'tbetter
and better" neighbourhoods:

                 X
                     o ~ X1 :?   •• 2 X 2'"
                                       n
Trivially, any finite initial segment of this sequence is con­
sistent. and so each Xn is a partial approximation to the
"limit". If 0 were always to be taken as finite, of course,
there would be no point in discussing limits since any such
sequence would eventually be constant. The elements in the
finite case would therefore be completely represented by neigh­
bourhoods with the ntininnl. neighbourhoods corresponding to the
total elements. But there are many reasons to go beyond the
finite (though perhaps not too far beyond).

    Suppose ( y n) n=O
                     ~
                            is another "convergent" sequence with

<!-- page 12 (pdftotext) -->

6

Yn+1S)'n fOT all indices:                  when do the two sequences of neigh­
bourhoods determine the                same limit?     The two sequences can
surely be different;             fOT   example, (Yn>;::=o    could be a subsequence
of    <Xn);=o' say, )'n=X Zn "             Still we would want to    say that the
same limit is obtained.                Without being given any further structure
on the neighbourhoods, a simple answer is just to                    say that each
sequence goes "equally deep" as the other:

                fOT   each m there is an n with X SY , and
                                                  n    m
                fOT   each n there is an m wi th Ym £ X .
                                                       n
This definition obviously puts sequences into equivalence
classes, and so elements could be identified ld th                   these.     But
such a definition is clumsy                 fOT   two reasons:   it is always
tiresome to work with equivalence classes. and there is no
reason to think that simple infinite sequences are adequate for
determining elements without some rather drastic assumptions
on V.         Nevertheless,      the idea is suggestive; we just have to
find some construct to represent elements in a unique way and
to phrase it in a general enough manner.

       Start with (Xn);=o again, which "converges" as before.
Think of all the other sequences equivalent to this one in the
sense just defined.             We can define the class of all terms of all
such sequences very easily as being the family:

                      x = {Z E V I XnS Z    for some n}.

It is easy to prove that if we form the analogous                    class for
(Yn>';;.=o' then the two families are equal. if and only if the
sequences are            equivalent.    Thus, we seem justified in letting
x represent the limit of (X n )O;>n;O'                All we have to do now is
to remark on what sort of class x is as a subfamily of Vj
what we abstract from the construction, however, will be just
a bit more general than taking those x that result from sequences.


DEFINITION 1.6.            The (ideal) el.ements       of a neighbourhood system
V are those subfamil ies x S V where:

       ( i)      f),Ex;
       ( i i)     X, ¥EX     always implies XnYEx; and
       ( iii) whenever X E X and X So ¥ E V, then Y EX".

The    domin of all such elements is written as I V I.                 0

<!-- page 13 (pdftotext) -->

                                                                              7
     The idea of 1.6 is a well-known mathematical device:            the
families x satisfying (i) - (iii) are usually called faters.
Most frequently the emphasis is put on the maximal filters,          and
these would be our         total elements; however,   in general, the proof
that maximal filters exist is non-constructive, so for OUT
purposes it is    better not to neglect the partial filters.         When
maximal filters can be found, well and good, but we do not have
to insist on them.         Note that the generality of 1.6 is acHeved
by not requiring that there is a sequence of neighbourhoods
that I1generatesll the filter x.         (See Exercise 1.22.)

    We have often said that neighbourhoods determine partial
elements by themselves; we now make this remark precise.


DEFINITION 1.7.       For XE V. the principaZ fater     determined by
X is defined by:

                  tX= (yEP IXs;Yl.

The principal fil ters form what Ioo'e shall call the       finite
eLements   of the domain     I VI.   0


     It is obvious that the correspondence between X and + X is
one-one and inclusion reversing, in the sense that

                    Xs.Y     iff     +YS+X

for all X, Y E V.     But, except in very special cases, there is
much more to I V I    than just the finite elements.       Much of our
investigation will be concerned with finding out how much more.
The finite elements are. in a certain sense. "dense" in
IVI. however, because it is also obvious from the definitions
that for each xE IVI

                       x =   Ul t X I X Ex).
That is, every element is a certain type of-limit'l of finite
elements.     (This statement is made more precise in Exercise 1.21)

     We note that we have now had several occasions to use
inclusion relationships between elements; this is an important
relationship, and we give it a special name.

<!-- page 14 (pdftotext) -->

8

 DEFINITION. 1.8. For x. y e lVI, .....e say th·at x approzimates r i f f
 x oS. y. The element that approximates all others ~ {.a.}. is called .1
 (read: bottom) i it is the "least defined" element, or the
"most partial" element. Elements maximal ..... ith respect to the
 approximation relation are called total. elements. D



EXAMPLES 1.2 -1.5 (Revisited).       The examples as given .....ere
all finite, so any explicitly given filter x is principal,
the elenent is finite. the minimal xe x tells us all ..... e need
to know. In such simple situations there is essentially no
difference bet.....een elements and neighbourhoods -- except for
the reversal of the order as noted. This (necess arr) rever­
sal should not, ho.....ever. become a matter of confusion: the
smaller the neighbourhood has bec9me •. the more it has IIconverged".
and so the better defined the element has become..      In the approx­
imation relation the "poorer" elements are placed bela..... the
"better" .....ith the total up at the top. This will become clearer
in discussing "infinite" elements.

     Example 1.3 will be generalized in Exercise 1.1. Let us
here generalize first 1.4. We let
                          a = I- •
where :r" {O.1} and I · means the set of all finite sequences of
O's and l' s ......i th A being the empty sequence. We write a 't for
the concatenation or juztapoeition of twe sequences a."'t e I · .
Define
                B = {a I · I a e I · }. where

                  a X' la   ,I' Xl
                                EO

for an arbitrary set X k; I·. In other .....ords, a ne i ghbourhood in
B consists of all ezteneione of a given sequence a.         (Refer
back to the finite version of 1.4.) We use the letter "6" to
remind us of "binary". and this is an example .....e shall refer to
many times. The proof (if it is not obvious) that 6 is a
neighbourhood system should be done as an exercise.

       What do we find in I BI?      Of course .1 = {ale I B I..   For any
x e I B I and a e I* de £ ine
                 a x .. {Y I a X£" Y some X EX}.

<!-- page 15 (pdftotext) -->

                                                                        9

Again there is an exercise here to show axEIBI. In particular
0.1 E 181 for all aE~". and these are just the finite elements.
The minimal element of 0.1 is 0.6.. Note that 0o.1S 01.1 if and
only if "0 is an initial segment of the sequence 1 "        °
     If now xE lSI is any explicitly given element (that is,
if we know for any XE 8 whether or not X Ex). we have but tD
work out from these definitions that

                       x =   0
                             n=O
                                   0n.1.


where the an E:t· and each on is an initial segment of the next
"n+l0  In general, in any domain, an element is uniquely
determined by its finite approximations, and we are just making
this explicit in I BI. When we have complete knowledge of X,
then there are two cases: either the approximations 0n.1 become
constant from some point on (where n;;' nO)' or not. In the first
case x is finite and equal to 0nO J.; in the second case x is
infinite and the 0nfill out an infinite (one-way) sequence.

        The generalization of 1.5 to the infinite case where
                    .6.= N =. {0.1.2,3,    ... , n, ••• }
can be made in more than one way: for instance either we use
as neighbourhoods all non-empty subsets of 4 or just those
omitting but a finite number of integers. And, as will become
apparent, there are other choices giving domains of quite
different characters. 0

     Many constructions (choices of V) lead to the II same 'l
domain; "sameness" is an important notion and it is to be
defined in terms of "isomorphism", which in turn is to be
defined in terms of approximation preserving correspondences.


DEFINITION 1.9.       Two neighbourhood systems V o and V 1 determine
isomorphic dorrrzins iff there is a one-one correspondence between
I "01 and IV 1 1 which preserves inclusion between the elements of
 the domains. In symbols we write V o !!! V 1 " 0

<!-- page 16 (pdftotext) -->

10

      It is certain that the property of 1.9 is necessary. but
it may not be so clear that it is sufficient. We sQ.all in fact
prove in the next lecture that an isomorphism be tween domains
always maps finite elements to finite elements, so it always
resul ts from a one-one inclusion-preserving correspondence
between neighbourhoods. This is surely 39 strong as could be
hoped.     This general result is not needed to see that particular
domains are isomorphic.

      In some of the examples tokens corresponded to total
elements and in some to partial elements; it is not difficult
to see (ex post facto) that every domain can be presented with
tokens exactly corresponding to partial elements.


THEOREM 1.10.             Given any neighbollrhoo3 system V", define for
XE V

                         [Xl < (x E IVI   I XE x).
The subsets [Xl £.IVI for XE'O form a neighbourhood system over
IVI which determines a domain isomorphic to IVI.



       ~oof:     We note first that
(1)      (l1]. I V I .

Next note that
(2)   X, Yare consistent in '0 iff {Xl n {Yl .. '1>
and that for X, YE V
(3)      (X]n[Y]=[Xny]             ifXnYEV.

Inasmuch as
(4)      tXE[XlforallXEV,
it easily follows that '0 and the family
                              {[X1IXEV}

are in a one-one, inclusion-preserving correspondence. T:has,
we can induce the desired one-one correspondence between the
elements of the two systems. 0

<!-- page 17 (pdftotext) -->

                                                                     11
      The import of 1.10 is that the original tokens in A can
be replaced by the elements of 1'01. This process replaces the
neighbourhood X :5 A by the subset [Xl £ 1'01. As the passage
is inclusion preserving. the domain has not really changed, Dnly
its presentation. Though of some theoretical charm, the
theorem is not of much use since we still have to get V from
somewhere.   It does emphasize. though, that the r8le of thE
tokens is simply to keep the inclusions (and intersections) of
neighbourhoods sorted out.          It is not always true that the
tokens can be identified with the total elements.

     The last theorem in this lecture is a result on e~08Ul'e
properties of a domain with respect to set-theoretical opera­
tions which have interesting meanings wi th respect to approxi­
mation.

THEOREM 1.11.       If V is a neighbourhood system and XnE IV! for
n'" 0,1,2, •.• , then

      (i)     nXn
             n-O
                ~


                        EIVI; and


      (ii)    Ox
             n"'O n
                       EIVI, provided



             Xo S Xl     =x =: •••
                             2        !i xn E   x n + 1 £ '"   •

      Proof: The conditions of 1.6 have to be checked. For
the case of intersection, all of 1.6(i) - (iii) are quite obvious.
For the case of union, only 1.6(ii) gives pause and it requires
the proviso.  I f X and Y belong to the union, then X E x ' say,
                                                            n
and YEx • But, either n<rn or m<n, and if k=max (n,m), then
          m
X, Y E x . Since x k E lVI, we have X n Y EX ; thus, X n Y belongs
        k                                   k
to the union. This proves (ii). 0

     In words, the intersection is the best element that is at
the same time an approximation to all of the elements x ; the
                                                       n
intersection is exactly what is common to all the given ele­
ments. The union on the other hand is just what the (increas­

<!-- page 18 (pdftotext) -->

12

ing sequence of the) xn approximates; the union combines
contributions from all the x n into a "better" element -­
but no more than that.

     In thinking about domains a rough diagram. of the partial­
ordering relation S between elements is often helpfuL    The
picture of 1.4 is an example where the nodes represent the
elements. Any finite tree growing up from a root node would
also be an example. Indeed. any finite partially ordered set
with least element would be an example. (Here no distinction
between tokens and elements is necessary.) A lattice diagram
is also illustrated.




        .I.                                     .l.
     A TREE                                  A LATTICE




                           .l.


                    A ROUGH PICTURE


The root node is the element 1. of 1'0 I; there need be no top
node T. Appro:rimation is represented by a passage from a lower
node to a higher node along the rising lines. The system V of
neighbourhoods is the collection of sets each of which is all

<!-- page 19 (pdftotext) -->

                                                                         13
the nodes above a given node. For infinite examples, however,
care must be given to introduce limit nodes. The first few
exercises should he provided with pictures to illustrate the
structure.

                        EXERCISES

EXERCISE 1.12.   Let /1=:IN .. {O,1,2, ••• ,n •••• }be the set of non­
negative integers. Use as neighbourhoods final segments;
                       {mEJN     Im>nl
for nE:N. Veri£y that this is a neighbourhood system. What
are the total elements? What are the finite elements? Dra'Ji
a picture of the apprOXimation relation in this domain.
(Hint: there is only one limit element.)

EXERCISE 1.13.   Verify all the assertions made about the
system 8 defined as the infinite generalization of Example 1.4.
Draw a picture similar to that given in the text which includes
nodes for all oE I:.. Show the neighbourhoods, how the approx­
imation relation behaves, and where the total elements lie.
(The picture is closely related to the "binary tree", but has
to have limit nodes all along the top.)


EXERCISE 1.14.    Let /1 "'}l and let V be the family of finite non­
empty subsets of .li plus the set /1. Show that this is a neigh­
bourhood system.    What are the total elements? What are the
fini te elements?   Draw a picture.


EXERCISE 1.15. Construct non-isomorphic infinite domains where
all elements are finite but where there are no infinite chains
<xn > ~=O of elements with x n   =x n l but x n ¢xn l for all n.
                                     +            +

<!-- page 20 (pdftotext) -->

14
EXERCISE 1.16. Let.6. '" JJ and let V be the family of cOfinite
subsets of :N. Show that IV I is isomorphic to the partially
ordered set of aU subsets of :N under inclusion • Construct
some other neighbourhood systems where V is closed under finite
intersection. What happens to the total elements in such systems?


EXERCISE 1.17. Let.6.=:m. be the real line. Let V be the set of
non-empty open intervals with rational end points plus the set .6.
Show that this is a neighbourhood system. For any real t e lR, show
that

                         { XE V   I tE Xl
is a filter.     Is it always total?        What are the total elements
of IVI?  (Hint: When t is rational consider all intervals with
t as a right-hand end point.)


EXERCISE 1.18.     Let V be a neighbourhood system.        Call a subset
C ~V consist~nt iff every finite subset of C is consistent in:V.
Give an example where C is a subset with more than two elements.
every pair of neighbourhoods in C is consistent. but C is not
consistent. Show that if C is consistent, then there is a
l.~a6t fil ter x E J V I with C s x. Show generally tha t the inter­
section of any non-empty collectio:1 of filters is again a fil ter.


EXERCISE 1.19.   Define a positive neighbozaohood system to be a
family D where (ii) of 1.1 is replaced ~y

       (ii ' )   whenever X.YEV. then XnY-:lCfl iff .XnYEV.
Prove that a positive neighbourhood system is indeed a neighbour­
hood system in the sense of the earlier definition.           Give an
example of a neighbourhood system that is not positive.     (Hint:
(suggested by C.A.R. Hoare). Let.6. '" :N xlJ. in the plane. Let
V be the family of subsets X S lJ x :N where all but a finite
number of places the vertical. sections of X are the whole of lJ
but at the other places the sections are finite and nonempty.
Smaller examples are of course possible.)

<!-- page 21 (pdftotext) -->

                                                                       15
EXERCISE 1.20. Let V be any neighbourhood system over a set A.
Let .6.' :: V and define

                   v ' • I +X I XED}
where
                   +X· {YED IYsX}.

Show that V' is a positive neighbourhood system and that 1'01 and
IV'I are isomorphic. Note that for V' finite elements and tokens
are- in a one-one correspondence.


EXERCISE 1.2·1.    Work out in greater detail the proof of 1.10.
Remark that the neighbourhood system over 1'01 so constructed is
positive, thereby obtaining in a different way the same kind of
conclusion as in 1.20.    Show also that the system over 1'01 is
complete in the sense that every £i1 ter is fixed by a u.nique
member of the underlying set.   (A filter is fixed by a point iff it
is the filter of all neighbourhoods containing that point.)
Remark that a complete system is one where tokens and (partial)
elements can always be identified (under a suitable one-one
correspondence).      Show also that consistency of a set {Xi[i<n}
of neighbourhoods in V is equivalent to saying


                       n[X.J*9>
                       i<n    1




EXERCISE 1.22.  (For topologists). Show that the neighbourhoods
(Xl for Xe V make IVI into a topological space where the open
subsets U £IVI can be characterized by the following two conditions:

        (i)    wheneverxEUandxsyEIVI,thenyEUj               and
        (ii)   whenever x E U, then +X E U for some X EX.

Prove also that the inclusion relation on IV! can be defined
topologically as:

        (iii) x5;Y   iff for all open U 5; lVI, if xE U then yEU.

<!-- page 22 (pdftotext) -->

16
Is IVI ever a Hausdorff space? Show that if {Xn);;':::Q is a
sequence of elements of IVI with x SX + for all n, then
                                  n  n 1
                                  ~




                                 U xn
                                 n- 0

is, not only in IVI but is a topological limit point of the
sequence.    Show that any element x is a limit point of the set
{tX1XEx}. Are there other limit points?


EXERCISE 1.23. Suppose that the neighbourhood system V is
coun table, say,

                  v ~ {X O' X"          X,2' •••• Xn , ••• }a

Suppose further that the property of consistency of finite
sequences of neighbourhoods is decidable (or lI e ffectively
known"). Then the following sequence is well defined:

            Yo-   Xo
            Yn+1 • Xn + 1 , if this set is consistent with
                                YO' Yl'    ••• , Y
                                                     n
                  • y
                        n • if not •
Show that {yo' Y"        •• "
                        Y , ••• } is a total element of IVI.
                         n
(Hint: Show first that YO' Y1' ••• , Yn-1 is consistent for all n.)
In such a system show that all filters can be determined by
sequences.


EXERCISE 1.24. (For set theorists). Prove, using the Axiom
of Choice, or some equivalent principle, that in every domain
a partial element can always be extended to a total element.
Is this assertion equivalent to the Axiom of Choice? (Hint:
Remember to prove that the union of every (transfinite) chain
of filters is again a filter.)

<!-- page 23 (pdftotext) -->

                                                                        17

EXERCISE 1.25.     (For set theorists).  Let Ii. be any well-ordered
set (ordinal).     (Even small ordinals like w.3 or wS are inter­
esting.)   Let V be the family of non-empty finat segments of .6."
What is IVI?     Are all elements finite?     Is every approximation
to a finite element finite?


EXERCISE 1.26.     (For algebraists).     Let A be a commutative
ring with unit.     Let a be the set of finite subsets F SA.       Define
       reF) '" {G e!J..1 FS   the ideal generated by G}.

Prove that the sets of the form reF) form a neighbourhood system,
and that the corresponding domain is isomorphic to the set of
ring-theoretic ideals of A partially ordered by inclusion. What
would happen if we excluded from.6. all F with I(F):::: I({1}), where
1 is the unit of A?



EXERCISE 1.27.       Further closure properties of domains can be
proved for bounded sets.      We say Xs IVI is bounded iff for
some y E IV I we h ave x£: y for all x EX. This Y is called an
upper bound. We let

                    UX' nlyEIVilx:y all xE U.
Prove that if X is bounded, then         Ux is the teast upper bound
for X in IV I. Prove al so: if U, VE V are neighbourhoods, then
{U ,V} is consistent in V iff {tU ,tV} is bounded in IVI.  (That
is, boundedness is for elements what consistency is for neigh­
bourhoods.) Prove finally with the aid of 1.18 that XEIVI is
bounded iff every finite subset of X is bounded.

<!-- page 24 (pdftotext) -->

                                                                      19


                                 LECTURE II
                          MAPPINGS BETWEEN DOMAINS


    The   elem~nts    of a domain are regarded as being specified
by approximations: the neighbourhoods. With the idea of
approximation as the dominant notion, therefore, it is natural
to look for a concept of mapping (transformation of domains)
that in some suitable senSe preserves the spirit of the approx­
imations.  In a 'theory of computability) where the (finite)
approximations to the elements are all we can ever know at one
time, the only mappings that can be computed are those that
proceed by approximation. somehow passing from the neighbour­
hoods of one domain over to the neighbourhoods of the other.

    Suppose X E V 0 is given - it is an approximation to certain
elements of I Vol..     (More precisely tX is the approximation in
the domain, but i t is easier to speak of the neighbourhood X.)
What can be said      about the approximations of the images of
these elements under the mapping we will call f1        If X is not
a very sharp approximation, then not very much can be said
about the image in the other domain 1 V1 1. Trivially, of
course, we can say that A is an approximation - because it
                         1
approximates everything in its domain. Suppose, however, that
we could say more.      Suppose we could say that both Y and Y'
approximate the image of X.       If the mapping f is coherent,
then it is reasonable to suppose that such a statement would
imply that Y and y' are consistent in V . But if this is so,
                                         1
then since the two neighbourhoods are meant to cluster around
the same images,      we can feel some confidence in saying that
y n Y' approximates these images.,      In other words to specify f
we do not supply a unique      image of X, but we say which of the
Y E V approximate the (ideal) image. To make this idea work a
     o
m:motonicity condition is also needed since we are trying to
express the idea      that "if we give at least X as an approximate
input to £, then we can expect at least Y as output."       Thus,

<!-- page 25 (pdftotext) -->

20
a mapping is taken as a kind of relation beh'een neighbourhoods.



DEFINITION 2.1.        An approorinr:zble mapping f: '0 0 -+ '0           between domains
                                                                  1
is a binary relation fs.V OX '0             between neighbourhoods such that
                                        1

     (il    t> Oft>1
     (ii)   X f Y and X f y' always imply X f (Y n Y ')
     (iii) XfY~ X'S;X, and Y5Y' always imply X'fY'.                            0

    Condition (i) we have already discussed; in a sense it
means "ask me no questions and I shall tell you no lies."
In other words "zero input can expect at least zero output. II
The other conditions are compatible with having
                           f:{< X ,t>1>IXEP };
                                           O
that is, f might be the least informative relation and nothing
more. But if it is more, then (ii) is, as we explained, ::I
consistency condition. To explain monotonicity in (iii),
suppose a mapping relationship is already known, X f Y J say.
If we improve the accuracy of X to X' £. X and if we degrade the
accuracy of Y to y'? Y, then we can still assert X IfY' since this
relationship is  laBB infonmtiva   than the former relationship,
which was already known.    Thus, we see that conditions (i) ­
(iii) are all reasonably argued as necessary.

     One indication that the conditions of 2.1 are sufficient
for a definition is that they are exactly what we need to show
that f as a neighbourhood relation determines an equivalent
elementllise mapping from 1001 into 1'0 1. (Owing to the
                                       1
equivalence, we use the same symbol f for both.)



PROPOSITION 2.2.        Given neighbourhood systems '0                    and '0 ' an
                                                                      0        1
approximable mapping f: '0 -+ '0   always determines a function
                             0   1
f: I '0 1-+ I '0 I between domains by virtue of the formula:
       0        1
     (i)    f(x) = {YEP,       I 3XEx. XfYl
for all x E I Vol.       Conversely, this function uniquely determines

<!-- page 26 (pdftotext) -->

                                                                        21
the original re 1 ation by the equivalence:
      (ii)        X fy   iff    ye f (tX)
for all XEVO and YE'Oto Approximable functions are always
monotone in the following sense:
      (iii)       x.s y always implies f(x) s; f (y).
for x t Y E I'0 0 I; moreover two approximable functions f : PO'" V 1
and g : DO ... D1 aTe identical as relations iff
     (iv)     f(x) - g(x), for all x E IVOI.

     Proof:        The argument that fomula (i) always gives us
f (x) E 11'1 I when x E 1'0 1 can be safely left to the reader.
                           0
Note, however, that all the conditions of 2.1 are required tc
show this. As for (ii). the implication from left to right
follows directly from. (i) because xe + X.   In the other
direction yef(+X) means that ZfY holds fot some ZE+X.
But from X.s. Z i t follows that X fY, as we wished.

     To prove monotonici ty. assume x ~ y. Now XE X and X f Y
always imply XE y and X fY. This means YE f(x) always implies
yef(y); that is, f(x),;;f(y).

     Finally, to check that (iv) means f· g as relations, all
that has to be remarked that this follows from formulae (i)
and (ii).     0


              Note that the right-hand side of (ii) can be written:
                               tY,;;f(tX),
which can be read as saying that the partial element determined
by the neighbourhood Y approximates the function value at the
element determined by X. This precise relationship of course
fits the informal discussion of mapping given earlier. Indeed
whenever xE [Xl and XfY hold, then f(x)E[Y] always follows.
which is another way to construe the mapping character of f.
Some examples of mappings are now called for.

<!-- page 27 (pdftotext) -->

22
EXAMPLE 2.3. Let r be the neighbourhood system of the two-token
domain of Example 1.2. To avoid confusion with some other
domains, we will call the two total elements of 1rl respectively
true and false. There is only one other finite element here. namely
.1 = undefined.    We often use these elements as indicators of
results:       true indicates a positive outcome; false, a negative
outcome; and .1 indicates that there is not enough information
to decide the outcome totally.

        Let 8 be the system for the binary tree as in the last
chapter.       What we wish to define is an approximable mapping
f : B ... r.
          The intui tive idea of the mapping we have in mind is
that the binary sequence is being read from left to right, and
we are counting the number of 0 I 5 seen before the first 1 is en­
countered. We then test the parity of this count; if it is
p.ven, the output is truej if not, false.  Using a suggestive
informal notation with three dots, some resul ts of the function
that does the counting and testing can be written as:

                       f   (000010'···J • true
                       f   (1101110 .. ·J • true
                       f   (011101' .. ·) = false
                       f   (0000000···)'        .L.

The last equation is necessary, because 0000000 as a partial
element cannot be counted as either even or odd since it can
have inconsistent extensions:

                       OOOOOOO.Ls OOOOOOO'.L
                       0000000 .L S 0000000000' .L •

So, as far as f is concerned, a plain string of a's is
indefinite. The same answer holds if the a's go on infinitely.

        To be more precise we want
                       f   (On,.L J   true         if n is evenj
                                      fa 1 se      if n is odd.
As a binary relation f S. B x T we will have
     X f Y iff Y E.1 or X.= On 1 ..6. for some n E :N and ei ther n is
                           even and YE true or n is odd and Ye false.
It should be checked that 2.I(i)-(ii) are satisfied.               0

<!-- page 28 (pdftotext) -->

                                                                                       23
EXAMPLE 2.4.      Let us briefly describe an approximable mapping
g: B+ B.  Informally, g: can be said to "read a sequence from
left to right and eliminate the first consecutive run of 1'5
while copying all the other digits as read. 1I              We will have
                 g (On,k 0 x) "" On+,x

provided k > o.  (Here ,)(; means a string of 1'5 of length ]<.)
However, if 1<» is the infinite sequences of 1 1 5, then
                 g (1~) : J.. and
                 g(On1~)·On.


This example is instructive, since it shows that a non-trivial
mapping can transform a total element into a partial element. D

      Aside from our being able to define particular functions
outright, we can       combine functions in many different ways;                 the
idea of composition is probably the most basic scheme of combina­
tion, and there is a technical name for a family of structures
with mappings that can be so combined.



THEOREM 2.5.     The class of neighbourhood systems and approximable
mappings form a        catego't'Y, where the   identi'ty mzppin.g IV : V..,. V
relates X, YE V    as follows:

      (i)      X IV Y      iff   XS;Y.

If f: V "" V, and g: V,"" V 2 are given, then the composition
       O
g of:V ""V'2. relates XEV and ZEV as follows:
       o                    O         2
      (ii)     Xg• f    Z iff 3 YE V l' X f Y and Y g Z.

      Proof:    (We may use MacLane       [197~]   as the st'andard reference
on category theory, but we require hardly more than the basic
definitions at this stage.)          To check that we have a category,
we need to know that the identity and composition maps really are
maps in the category and that certain identity and associative
laws hold.     Now i t is obvious that IV satisfies            2.' (i)-(iii).
Moreover if f: V          °
                   o ..,. 1 , all we have to prove is:

<!-- page 29 (pdftotext) -->

24
      for           = [        of·!
            V             V1
                o
Checking one of these equations is enough.                       Thus~   for XE'PO
and Z EO, we find

      Xfol              Z iff 3YEV ' XS;Y and YfZ
                V                  O
                    o
                          iff XfZ,

So, f and f . IV            are the same mapping.
                        o
     Suppose now that f : '0
                            0
                              -+ 0, and g : 0, -+            °
                                                  2 " We have to
verify that g .. f is an approximable mapping. First off, there
is no trouble in seeing that ./log" £ Ii. 2 holds. Next, suppose
that XgorZ and Xgo fZr hold. Then we have XfY and YgZ
for some choice of YEO"    Also XfY' and Y'g Z' hold for some
choice of yIED,' By 2.1 (ii) it follows that X f (YOy').
Since YnY '!:Y, we conclude (Y n y"& Z       by 2.1 (iii) j similarly
(VnY')gz/.      Invoking 2.1 (ii) again, we obtain (YOY')g(Znz'),
and Xgof(ZnZ') is proved.

     Suppose finally that X' s: X go f Z s;: Z' • Now X f Y and Y g Z
for some YEV,. But· then X'fY holds; for a similar reason
Y g Z' holds also. Therefore, X 'got Z' is established, which
means that we have checked 2.1 (iii) for g f and have completed
                                                             D


the proof that g" f: V O .... V 1 •

       The verification of associativity is a purely logical
deduction. Thus suppose that in addition to £ and g we have
h : V 2 .... 0)" If XE V o and WE 03 we find
     Xh 0 (g 0 f) W            iff 3 Z E 1!:l' X g 0 f Z and Z h W
                               iff 3 Z E 02 3 Y E   °1 , X f Y and Y. g Z and Z h W
                               iff 3 Y E V, 3 Z E V • X f Y and Y g Z and Z h W
                                                   2
                               iff 3YEV , XfY and Y(hog) W
                                          1
                               iff X (h 0 g) 0 f W ,

So, as relations, h" (g" f) '" (h              D    g)" f.   0

      It may seem as though we have, in the definition of composi­
tion, written things backwards. But the reason is that when
mappings are taken as elementwise functions, then the order is
preserved in expressions involving the usual function value notation.
We have, for example:

<!-- page 30 (pdftotext) -->

                                                                              25
PROPOSITION 2.6.     Given f : '0 0 +'0 1 and g: '0 1 +'0 2 ' the following
equations hold:
     (i)     IV (x) :: x, and
               0
     (ii)    (g • f) (x) " g(f (x) l.

for all xE 1'001.   0


     The proof is not troublesome and is left as an exercise.
In technical language the result shows that the category defined
in Theorem 2.5 is equivalent to a "concrete category" of sets
and functions, namely the domains and elementwise transformations
of 2.2.

     Toward the end of the last lecture (see 1.9) we promised to
show that isomorphisms of domains always come from approximable
mappings, and this we now do. It means that the category contains
all the isomorphisms it should have.


THEOREM 2.7.    Every isomorphism between domains results from an
approximable mapping between the neighbourhood systems. More­
over, finite elements are always transformed into finite elements.

       Proof: Suppose that f: 1'0 1"'" 1'0 ' is a one-one, inclusion­
                                  0       1
preserving function defined On elements, where the range of the
func tion is the whole of 1'0 1 I. of course. Taking the hint from
2.2, there is only one way we could define a neighbourhood
mapping j namely, we cons ider the Tela tion YE f (t X) for XE V
                                                                 o
and YE '0 , What has to be shown is that this is an approximable
          1
mapping which determines the original function via the formula
2.2 (i).

     The first part is easy; indeed, there is a general result
that monotone functions on finite elements of one domain to
arbitrary elements of another domain always determine appr1>xi­
mabIe mappings (c£. Exercise 2.8). What remains, then, is to
show that the relation re-defines the function. This comes down
to showing that for xE 1'0 1
                          0
            f(x) O(YEV
                         1
                             I 3XEx. YEfCH)).

<!-- page 31 (pdftotext) -->

26
Consider the right-hand side of this equation:              i t is a filter.
(This either can be proved directly or Exercise 2.11 can be
used.)    Because f is an onto-function, we can cal1 the right­
hand side f (x') for some x'EIVal.              But since XE x implies
+ X ~ x and f(t X) ~    f (x), the right-hand ?ide is included in
the left-hand side.      In other words f(x') Sf(x).            But, since
f   is an isomorphism x 's x     follows.

       In the other direction. if Xe x, then f(t X) s f(x')            holds
bi·definition. so +Xs-x'.             This implies XEx' ; and, as X is
arbitrary, xs-x     follows.      So x=x'. and f (x) '" £ex') as desired.

       Finally. consider any finite element tXE 100' where XEV '
                                                              O
What we have to show is that f(tX) is finite in IV,I. Because
f is an isomorphism. we can associate uniquely to every Y E f(+X)
an element Yys+X in IVai where f(yy) =tY.               (Just apply the
inverse of the function f.)            Define

                       z =   U {Y y    lYE f ( +Xl l.

Because Y' sY     always implies yy' Syyand each YyE IVoi l it is
easy to show z is a filter and hence is in IVai also (cf.
Exercise 2.11).     Because each YystX. then zstX.            too.    But each
Yy So z, so tY = f(y y ) '£ f( z) and hence Y E f(z).     As this holds for
all YEf(tX), the inclusion f(tX) Sf(z)              follows~as well   as
tXsz.     Therefore, z=tX and so XEz.              But then XEyy for some
YE f(tX), by definition of Z. Since tXSYy' we obtain f(tX) stY.
but of course the opposite inclusion is also true from the choice
of Y. This means that f(tX) = tY is finite in IV I as claimed.
                                                1
We can apply the same argument to the inverse function; and,thus,
the finite elements of IVai and IV I are in a one-one inclusion­
                                  1
preserving correspondence under the isomorphism.  0



                             EXERCISES
EXERCISE 2.8.     With reference to the proof of 2.2 show that an
approximable mapping is uniquely determined by its elementwise
effect on finite elements.            Moreover any arbitrary monotone
function on finite elements of IVol with values in IV 1 comes
                                                     1
from an approximable f: 00"'01'

<!-- page 32 (pdftotext) -->

                                                                                 27
EXERCISE 2.9. Prove that if f: Va ... 0, is an approximable
mapping, then the element..... ise mapping f: IV I ... IV 1 satisfies
                                                o        1
the equa ticn

                  f(x)= U(f(tx) I XEx}
for all XE IVaI.  Conversely. sho .... that every element.... ise function
satisfying this equation comes from an approximable mapping as
defined in 2.2.



EXERCISE 2.10.  Carry out the proof of Proposition 2.6; and in
addition show that, if f,g: Va +V are two approximable mappings,
                                               1
there exists h : V O '" 01 such that
                  hex) • f(x) n g(x)
for all x E I Vol.


EXERCISE 2.11.      Let (1 t <) be a non-empty abstract partially
ordered set; suppose it is diroec::ted in the sense that .... henever
i.jEI,then iCi:k and j<k for some kEI. Suppose that a: l"'IVI
is such that

                            i '" j   implies       3
                                                       i sa j
foral1i J jEI.          Prove that
                            U (a         liE Il
                                     i
is always a filter in I V I. (Note the ways this lemma could be
used in the proof of 2.7; but be careful in defining the partially
ordered set and do not confuse sand 2.) In 'Words ..... e could say
that the domain of filters is cl.osed undero directed unions. Prove also
that if f: V .. V' is an approximable mapping, then for any directed
union
              f (U{ailiE Il)'             U (f(ail liE Il;
tha t is, appro:r:inrlbLe rrnppings al.wys proeserve directed lOIions.   If an
element..... ise function preserves directed unions. must it come from
an approximable mapping? (Hint: Invoke 2.9.)

<!-- page 33 (pdftotext) -->

28
EXERCISE 2.12.      Suppose (I,<)      is a directed, partially ordered
set and £1: Va -+ '0      is a family of approximable mappings indexed
                  1
by i E I, where we as sume

                        i" j implies £1 (x) s f j (x)
for all it j E I and all xE IVai.         Prove that there is an approxi­
mable mapping g : Va -+ '0 1 where

                        g(x)" Ulfi(x)1 iE I}

for all XE IVaI.


EXERCISE 2.13. (For topologists.) Recall Exercise 1.22 where it
was shown that any domain 1'01 is a topological space. Prove from
Exercise 2.9 that the functions f : IVai -+ 1'0 1 1 determined by
approximable mappings are exactly        the continuous functions between
these Bp:2Ces.   (Hint:    To prove continuity, remark that by 2.9

                 r 1 [Y]: U{[Xl I YE f(tX)};
hence. the inverse image of any open set is open.                In the other
direction, suppose that f; 1'0 1-+ 1'0 1 is topologically continuous.
                              0       1
Argue that for all XE IVai and all open subsets Us 1'0 1 1 we have
                  f(x) EU iff 3 XE x. f(tX) E U.

This holds because an open subset of IVa I is always a union of
basic open subsets of the form (X'}            for XEV       and because
                                                         O
                 x ·UltX IXEx}
for all x E IVai.)


EXERCISE 2.14. Let f: 1'0 1-+ 1'0 1 be an isomorphism between
                            0     1
domains.  Let <p: Va -+ '0 be the one-one correspondence between
                          1
neighbourhoods provided by Theorem 2.7 where
                             f(tX) = t ,,(X)

for all XEVO'       Show that the approximable mapping determined
by f   is just the relationship <p(X) S Y.         In addition prove that
if X. :x' E Va   are consistent, then
                       <p(XnX' ) • ,,(X) n" (X').

<!-- page 34 (pdftotext) -->

                                                                           29
Remark that the isomorphisms between domains correspond exactly
to the isomorphisms between neighbourhood systems (in the sense
of one-one inclusion preserving correspondences).


EXERCISE 2.15.   (For topologists).             Consider the one-taken system
",i th

                            ~= {    {OJ, 91)

We can regard I ~I as having just two finite elements .1 (bottom)
and T (top), where 1. s:: T. For any system '0. show that the open
subsets U of 1'01 are in a one-one correspondence with the approxi­
mable mappings f : '0 + a-', where the correspondence is given by the
equation
                    u- {xE IVI I f(x) :T).
Wha t are the open subsets of I0"1 ?           of IT I?   of 181?


EXERCISE 2.16.   In the discussion of 8 in Chapter 1 we defiTled
a mapping x ~a x for any given aE t·o Is this (elementwise)
mapping approximable? Show in addition that the mapping
£ : B... T of 2.3 is uniquely determined among approximable
mappings by the equations:
                     f (1x)        • true.
                     f   (01x) • false, and
                     f   (OOx) • f (x) •




EXERCISE 2.17. Establish in detail that the mapping g: B+B
of Exercise 2.4 is approximable. Is it uniquely determined by
these equations:
                     g(Ox) • Og(x).
                     g(11x) • g(1x),
                     g(10x) • Ox,
                     g(1)    .~.

or are some missing?

<!-- page 35 (pdftotext) -->

30
EXERCISE 2.18.          What is the meaning in words of the approximable
mapping    r. : B + B, where
                           h(Ox) = OOh(x). and
                           h(1x) = 10h(x).
for all elements xE 161? Is h an isomorphism?               Does there exist
a map k : B + B where

                           koh=I S '
and is k one-one?



EXERCISE 2.19. Generalize Definition 2.1 in an appropriate way
in order to define the concept of an appro:r:imabZ-e rrapping

                           f : Vox V,+ V 2

of tlXl vrrriabZ-es.     (Hint: f can be taken to be a certain kind of
ternary relation
                           fS;:V
                                   O
                                       x V, xV 2 •

where we can write
                           x, Y f Z
for the relationship among neighbourhoods.) What is the
corresponding version of Proposition 2.2 for functions of two
variables?



EXERCISE 2.20.          Discuss again the example of Exercise 1.15
where the domain turns out to be the powerset (set of all sub­
sets) of :N.           Show how the finite elements can be         taken to be
the finite subsets of :N                and can be identified with the tokens of
a sui table neighbourhood sys tern P.                (Hint: Define t F for finite
sets F ~ ~ .)          Show that both union and intersection (x U y and
x n y) are functions on IPl that are approximable in the sense of
Exercise 2.19. (The elements of IPI are being identified with
arbi trary sets xc:::N .)              Show also the following transformations
approximable:
                           x • 1         {n + 1 1 n EX}, and

                           x - 1         {n 1 n + 1 EX}.

<!-- page 36 (pdftotext) -->

                                                                                      31

EXERCISE 2.21.      The system I:i at 2.3 has as its total elements
only the infinite sequences.              Modify the construction of B to
another neighbourhood system C which has both                   the finite and
infinite sequences as total elements.                    (Hint: BSe.)     Show that
there is an approximable map x y              on elements naturally extending
ordinary juxtaposition of sequences.                    (Hint: Write 01001 for a
total finite sequence and 010011 for the corresponding finite
partial element.        Remember to distinguish between A (the total
empty sequence)    and.L (the undefined sequence).                The definition
should work out    50    that if x is an infinite sequence (hence, total),
then xy"'x     for all y.       What will xy equal if x is not total?
In other words, the construction possesses a rather strong 1eft­
to-right bias.)



EXERCISE 2.22.     (For set theorists).                 We have remarked in Exercise
1.18 and in Exercise 2.11 that any domain lVI, as a family of sets
(in factI a family of subsets of the set V itself). is closed under
the intersection of an arbitrary non-empty sub family and under
the union of any directed sub family.                    For those familiar with the
subject matter. the example of the (proper) ideals of a commutative
ring {with unit)    is also seen to be such a family.                   What is the
abstract situation?       Let    e be any family of sets with these closure
properties.     It is to be shOl.. . n that C is inclusion-isomorphic to
a domain.     (Hint: Let 11 be the set of fini te sets included in sets
in C.   For FE 11, define its "c1osure" by the equation:
                    "1"= n{XECIF~X).
Every FE C, and these will prove to be the "fini te" elements of C.
The neighbourhood system V over 11 can be taken tQ be the sets of
the form

                    C (F) •     (G E '"   I F "- 1; )
for Fe 11.    Notice that for all X E C

                    X •   U(I' I F £ X and F l» . )     E

Check that approximable functions on these families are just those
preserving directed unions.

<!-- page 37 (pdftotext) -->

                                                                     33


                               LECTURE II I
                            DOMAIN CONSTRUCTS


     Having now seen a number of domains presented through
their neighbourhood systems, we need next to introduce general
constructs for forming new domains from old. There are an
unlimited number of such constructs (technically called func~or8),
but we have time only to single out a few of the more important
ones. Outstanding among all of them is the notion of product
of systems, which in our chosen category has all the expected
properties. For the time being in order to simplify notation
we assume of the underlying sets Aa and A1 of systems Va and
V that they are disjoint. There is no loss of generality as
 1
D can always be replaced by an isomorphic system disjoint from
 1
DO in the required sense.


DEFINITION 3.1.    Let neighbourhood systems 1'0 and 1'1 be
given over disjoint sets dO and d • The product system over
                                  1
dO U d   is defined by:
       1
               Vo.V,' (XUYIXEV O andYEV,).
For elements xe IVai and ye IV l     we also define:
                              1
               <x:, y> = {X u Y I X e x and Ye y}.   0


PROPOSITION 3.2.   The con!;'truct 1'0 x 1'1 always gives a neigh­
bourhood system where for elements x.x' e IVai and y,y'-E IV ! we
                                                              1
have
(i 1        <x,y> .b <x',y'>   iff   x::x'and YSY'.
Moreover, there is a one-One correspondence between the elements
of 11'0 XV 1 , and pairs of elements of IVaI and '°11 since all
elements of IVa l< '0 1 1 are of the form <x,y>.

     Proof: Owing to the disjointness of dO and d 1 , we note
that for X, x'e 1'0 and Y, Ye '0 1 we have

('l          Xu Ys: X' u y' iff XS;X' and YSY'.
Thus, {XuY, X'UY'} is consistent in VOxV1 iff {X, X'} is

<!-- page 38 (pdftotext) -->

34

consistent in V and {Y , y'} is consistent in V,_                            In the con­
               o
sistent case we find
 (2)               (X U Y) n (X' U Y'J • (X n X') U (Y n y 'J,

and so Va x 0, is closed under consistent intersection.                           As
.10UA,EVO x 0"  it is certainly a neighbourhood system.


          It is easy to check by the previous calculations that
<x,y>e I VoxV,1 if XE IVai and ye IV,I. The proof of 3.2(i)
follows directly from the definition and (1).
           Suppose z E IVa x 0,1.         Define as a temporary notation:
                    1
                        0
                            = {XEV
                                     O
                                       I X U~1 E zl,      and

                    ' , ' lYE V,       I !lOUYE,),
Clearly. both zOE IVai and z, E IV,I.                     In view of the formula

(3)                (XU!l,ln(!lOUY)=XUY.
we can calculate that

                   z=<zo,z,>.
Moreover, if z'"            <x,Y> f    then

                   < X I Y >0 = x and < x, y >1 = y.

The one-one correspondence required is thus established.                           0

     There is more going on in the proof of 3.2 than just a ane­
one correspondence between elements and pairs. The extra inform­
ation is best formalized by introducing a notation for mappings.

DEFINITION 3.3.             Projection mappinga

                   PO: '0 0 )( '0 1 .... '0 0 and p1 : '0 0 )( '0 1 + '0 1
are defined as relations where

         (XUY) Po X' iff           X~X' ,and          (XUY) P1 Y' iff         y~y'

hold for all X, X'EV               and Y J Y'EV,"        Given f: '02 -'00 and
                               O
g ; '0     '" '0 ' the paired rrrzpping
         2      1
                     < f ,g >: '0 + '0 x '0 1
                                 2      0
is defined as a relation where
                   Z <f. g > (X U Y)       iff Z f X and Z g Y

holds for all XEV O' YEV"                  and ZEV 2 •       o

<!-- page 39 (pdftotext) -->

                                                                                             35
PROPOSITION 3.4..     The mappings PO' P1 and           < f.g)o   are approx­
imable mappings.     provided f and g are, and we have:
      (i)    PO" < f. g >   ::I.   f and P1" < f) g> :: g.

Moreover, for z E 1'00 x '0 1 1. we have:

      (ii)   poC'): '0 and P, (,) = '"
in the notation of the proof of 3.2.               Further if h : '0       .... V x '0
                                                                       2        o        1
is any approximable mapping, then
      (iii} h '" <PO" h, P1" h>.
Moreover, for all wE 117 1, we have:
                          2
     (iv)  <f,g> (101') = <few), g( 101') >,

where again on the right-hand side the notation of the proof of
3.2 is used.    0

        The proof o£ this result is left as an exercise. Note the
consequence that there is a one-one correspondence between pairs
of approximable mappings f : '02 ..... Va and g : '0 2 ..... '01 and mappings
h : '0 -+'£'0 x V " It is clear that we generalize all this to products
      2          1
                        Va x P1 x··, xVn_1
of several systems.

      The product construct also neatly explains fllnctions of
several variables~      In Exercise 2.n9 we used the informal notation

                        f:VOxV1-t>V2
and suggested regarding f as a ternary relation
                        x, Y f Z •
But now wi th V x V given an independent meaning, all we have to
               o 1
do is to regard £ as a binary relation with

                        (X U Y) f       Z

equivalent to the old relationship. We can also employ an element-
wise notation as in f «x, y » • which can more easily be written
f ( x. y). Similar remarks apply to functions of more than two
arguments.

<!-- page 40 (pdftotext) -->

36
      We have discussed several times what it means for a
function f (x) to come from an approximable mapping.   It is
interesting to asl the analogous question for functions of
several arguments.


THEOREM 3.5.     An elementwise function
                      f : IV O XV,I   ~   IV 2 1

~f   two arguments comes from an approximable mapping iff for each
fixed aE IVa' and each fixed bE IV,'               the transformations

                 x .... f (x. b) and y .... f (a, y )
come fTom approximable mappings of one argument.

      Proof:    As this is the first time we have had to deal with
constants in functions, a lemma is useful.


LEMMA 3.6.     Given be I'D, 1) the constant function

                     b: IVol ~ IV,I

where b (x) = b for all x E IVa I, comes from the approximable
mapping such that
                      X bY, iff Ye b,

for all XE Va and ye '0,"       0

     There is no real confusion here in using lib" both for function
and value. Returning. then, to the proof of 3.5) we see that
the reason that x 1-+ f (x, b) comes from an approximable mapping
is that the mapping in question is the composition of two approx­
imable mappings) namely f 0 <IV ,b >. Clearly we can interchange
the r81es of V and V, to get Rt y 1-+ f (a, y J.
              o
     Conversely) assume that both these functions come from
approximable mappings no matter the choice of a and b. Clearly
the mapping to determine f is the relation from XU Y to 1. where
                             Z E f (IX, + Y) : f (+ (X U Y)) •

To prove that this determines f we calculate by the formula of
Exercise 2.9:

<!-- page 41 (pdftotext) -->

                                                                           37
             f ( x. y) •      U If ( t X, y) I x e x}
                          • UIUlf(tX,tY) \yey)                    I xex}
                          · U X , Y) I x e x and Ye y }
                                  (f ( t     t

                          · UIf ( X u Y)) I (X u e <x.y > } •
                                       t (                   Y)

And, again by 2.9, this is what was needed.                  0

     Said more informally, a function of several arguments is
approximable in all the variables joi:flttll if it is approximable
in each of the variables separately.

     The type of argument used in 3.5 in the first half of the
proof also provides a generalization of 2.6 to functions of
several arguments. When we form a function like
             f(g(x,z •••• ), h(y,x,. •• ), k(z,w •.•. }. ••• )
from given functions f,g,h,'k, ••• ; we call the process eubetitution.


P~OPOSITIOH 3.7.  The functions of several arguments between
domains coming from approximable mappings are closed under
substitution.

     Proof: An example will establish the method. Suppose there
are four variables involved taking values in domains provided by
systems Va • V 1 • '0 2 • V 3 • We might have a substitution like:

          f ( g ( x O' xl)' h ( Xl • x 2), ~ ( x 3' x 0 • x 2 )) .

Here it might be that the values of the functions inside co~e
from quite other systems; for instance.
                k : V 3 x V o x V2 " V4
might be possible. By using projections

                    Pi: 'OOx 01 x V 2 )( '0 3 ~Op
where i < 4. we can assure that we have several functions all On
the same product; thus.

     k • <P3 • PO ' P2> : V o x V1 )( '0 2 )( V 3 ... V 4·
Now no matter on what domains f is defined, the following COm­
position makes sense:

<!-- page 42 (pdftotext) -->

38
     f o<g 0 <Po' P, >,h 0 <P1' P2>' k <l <P3' PO' P2»    ;
and in fact this is the desired function. Writing it this way
makes it clear that the function comes from an approximable
mapping:    we apply 3.3 (generalized, of course, to products with
several terms) to construe the parts beh·een brackets < and>
as approximable mappings, and then by this trick the composition
  is the ordinary composition of 2.6.             0

     I t has to be admitted that there is a slight point overlooked
in forming products like        v )( V wi th two identical domains.      This
is discussed in Exercise 3.14, invoking explicit isomorphisms.

     The construct that makes the whole theory of domains work so
smoothly is the function - space construct:  it is possible to
regard functions as obJoects which form a domain. Look back at
Definition 2.1 and compare it wi th the original de fini tion of
element in i.6. There are obvious formal similarities. except
that filters are sets of neighbourhoods and mappings are sets of
pairs of neighbourhoods (relations).          But as we saw in 1.10
it is possible to turn the filters into tokens via            a simple
defini tion of neighbourhood.        Ne apply the sa.me kind of defini­
tion to the mappings.



DEFINITION 3.8. Given neighbourhood systems Va and V • the
                                                         1
function space (Va .. ( ) is the system whose set of tokens is the
                       1
set of approxim'lble mappings of Definition 2.1 and whose neigh­
bourhoods are finite non-empty intersections of set.s of the form

              [x, Y1 = (f : V 0 ~ V 1 I x f Y),
where XE Va and ¥e (/1'     0


     We have been calling our mappings "approximable" for a long
time now without saying exactly how they can be approximated:
Definition 3.8 supplies the missing key. because once a domain
has been defined. then the general theory gives an explicit
meaning to the word approximation.         We still have t.o verify.
however, that the mappings do correspond to the elements of the
domain.

<!-- page 43 (pdftotext) -->

                                                                                            39
PROPOSITION 3.9.     Let neighbourhoods Xi E Va and Y E 01 be given
                                                     i
for i<n. Then the set of [Xi,Y ] for i<o is consistent in
                                   i
(00 ... V,) iff the £ol1owing condition holds:

       (i)        whenever I=-{O,', ... ,n-1} and {Xi I ie I} is consistent
in Va' then {Yi liE I) must be consistent in 0"
Moreover, when consistency holds, the least approximable mapping
fa belonging to t.he intersection of the [Xi' Y i] is defined by:

       (ii)       XfaY        iff        nfYi        I XSXi)sY

for XEV
              O
                  and ye      0,.
    Proof:          Suppose the [Xi,Yil are consistent in (Va ... 0,).
Since the function space is being defined outright as a positive
system, consistency means
                                   f E n {[X. ,Y. J I i < n }
                                                 1    1

for some f :       ° °
                     0
                         '"
                               1
                                   ,    Now, with f in hand, let us check condition
(i).     Suppose {Xi I ieI} is consistent.                         This means

                                XE n         {[ Xi J liE I}

for some XE IVOI.                      Suppose iEI, so XE[XiJ             Since XifY
                                                                                       i
holds) f(x}E [Y ].                       This means, therefore, that
               i
                              f(X)En{[YiJ                 liE!},

and so {Y         I iEI}        is consistent.
              i

       For the converse) suppose (i) is the caSe.                         We take (ii) as
the definition of a mapping and remark that for an arbitrary
XE Va' the set {Xi I Xs: Xi} is automatically consistent in VO'
By our assumption) the set {Vi 1Xs:Xi} is therefore consistent.
This means that

                               n       {Y i I X s: Y i ) e V 1 •

(Keep in mind that i is restricted to those i < n) and there are
only finitely many neighbourhoods being considered here.)                              It
is thus almost immediate that the relation fa defined by (ii)
satisfies conditions of 2.1 and so is an approximable mapping
fa ; Va ... V1 •         By construction

                                         Xi faY i

<!-- page 44 (pdftotext) -->

40

holds trivially for all i (n; therefore,

                      fOE n{[Xi'YiJ Ii <n)
and the desired consistency is established.

       Finally suppose that f is any mapping in the neighbourhood
under discussion; this means Xi f Yi holds for all i (n.                                              Suppose
X fa Y holds.     We have for X£:Xi,X fY ;                                   50
                                        i
                     Xf      n{y. I XeX.) cL
                                                  1         -    1       ­

Thus, X f Y follows; hence, 35 relations. fa s: f.                                           In other words
fa is the minimal element of the neighbourhood.                                              o
       We note that. as a consequence of what we have just proved,
~hen    the neighbourhood is consistent, then

                 n    ([ Xi' Yi J I i < n ) !; [X. YJ
is exactly equivalent to
                      n     {Y i         I X s: Xi}             s: Y •
Note also that a single neighbourhood [XO,Y O] is                                            al~ays   consist­
ent since it contains the                             aonatant mapping            k 'Where
                             XkY                      iff       YOS: Y,
for all XE Va and YE '0 '
                       1
                          Some other simple observations about
these neighbourhoods are just translations of the conditions of
Definition 2.1:

                             [~o ' ~1 J • I V 0 ~ Vl' ;
                [ X, Yl n    [X. Y' l • [X, Y nY' ] i and

              X' s:X and Ys: Y'                         imply (X,Y] So (X', Y'] ..
for all X, X' E Va and Y. Y' E '0
                                ' We are now ready to prove
                              1
the main result about the construct.



THEOREM 3.10.                                  and '0 ' the function
                     Given neighbourhood systems '0
                                             0       1
space system (Va ~ '0 ) is complete in the sense that every filter
                             1
in 1'00 ~ '0 1 is fixed by a unique approximable mapping.
            1
     Proof:     Let f: Va            ~       '0        be an approximable mapping. By the
                                                   1
very definition of ('0                   ~        '0 ) it determines a filter by the definition:
                                 0                   1

<!-- page 45 (pdftotext) -->

                                                                               41

                 f.{FE(VO~V,) I fEF).
Trivially [X,Yl E f iff fe [X,Y] iff X iY; so this filter
uniquely determines the relation f.           ~~at   we have to show is
that every filter in IVa ..        v, I is of this form.
    Suppose (pE I V o .. 01[ is any filter.      A relation can be de­
fined at once by
                 X .. Y   iff   [X,Yl E",.

In view of the remarks we made just before stating this theorem,
there is no problem in showing that ~ is an approximable mapping.
Since the neighbourhoods of the function space are in any case
finite intersect.ions of sets like (X,Yl. those [X,n Eql generate
(p. This means that ~ ""(p. By definition f '" f, so there is a one-
one correspondence between mappings and £i1 ters.    (This corres­
pondence is obviously inclusion preserving, too.) D

   We now know j US! about everything about IVa" V,I as a
domain:  the elements correspond isomorphically to the approximable
mappings; the finite elements are explained completely by 3.9i and
we have seen how to calculate with neighbourhoods. The final
step is to relate the function space to other domains by appro­
priate mappings.  In doing this we shall freely construe elements
of I Va" V,l as approximable mappings in view of 3.' a.


THEOREM 3.".        Given neighbourhood systems      V, and P 2 , there is a
uniquely determined approximable mapping

                      eval: (V, .. P ) xV," V 2 '
                                    2

where for all f: V, .... V     and all xE IV,' we have
                             2
      (i)      eval (f. x) • f (x).

      Proof:    For FE (P, .... P ) and XE P, and Y E V define eval
                                 2                     2
as a relation by:
                   F u X eva 1 Y iff X f Y for all f E F.

<!-- page 46 (pdftotext) -->

42

Remember that neighbourhoods in the function space are sets of
approximable mappings.                   It is easily checked that this defini­
tion makes eval approximable.                      We now calculate the function
values by the formula of 2.2 (i):
              ev.l (f, x)           = (YEV
                                                2 I 3FE(V,        ~V2)3XEx.fEFand FUXevalY

Because, again by 2.2 (1) t we have
                      f       (x)    (YEV       13XEx. XfYl,
                                            2
we can see from the definition of eval that eva] (f, x )~f (x).
Suppose that Y E f{x). Then X f Y holds for some X E x. We can
write fe [X. y ]          E     ('D, ~ 02) and it is clear that

                                    [X, Yl uX eval Y
holds by definition.                 Therefore, Ye eval (f,x).              and so
f(x) S eva' (f,x).                   0

     This theorem is essential for our programme;                           it shows that in
taking functions as objects the very basic operation of forming
the function value is an approximable mapping.                         In other words
we can treat the expression f( x) not just as a function of x.
as we have done from the start, but also as a function of f as
well.       The result also indicates that there are useful maps
defined on domains that themselves are function spaces;                              we shall
meet many more of these.                   The next theorem prOVides further
examples.



THEOREM 3.'2.             Given neighbourhood systems Va 'V                 ,V there is
                                                                       1      2
associated with every approximable mapping g : V                           x V, ~ V 2 a
                                                                       o
uniquely determined approximable mapping

              curry       (g) : Va ~ (V, ~         V2 )
such that for xE 1°01 and yEIV,1
      (i)     curry (g)(x)(y) = g(x,y).
Moreover we have these functional equations:

      (ii) eval       0   (    curry (g)    0   PO' P ) '" g, and
                                                     1
     (iii) curry (evat 0 (h 0 PO' p,»)                    '" h.

<!-- page 47 (pdftotext) -->

                                                                               43
where the Pi; Va x '0 1 ... Vi are the projection mappings and
h: '0 ... ('0 .. 02) is any approximable mapping. This provides
     0       1
an isomorphism between the domains IV x V -+- '0 1 and 1° 0 ... ('0 -+'0 ) I
                                         o   1    2                1    2
and so we can regard

          curry: (1 0 x 1 1 - 1 2 ) -
                                 (Do - (1 1 - 1 2 ))
as itself being an approximable mapping .

    Proof: Given g as indicated, ..... e can define curry (g) as a
relation and as an approximable mapping by:
          X curry (g) [Y,ZI             iff X u Y g Z     (but see Ex. 3.21)

fOT all xe '0 ' y E
             0
                      °1
                           , Z E '0 '
                                   2
                                          This is sufficient because an
approximable mapping is intersective in the right-hand neighbour­
hood, so we know from the above exactly what X curry(g) (){O' i' 2'i] I i < n
means for all finite intersections. The remark after 3.9 is then
helpful in checking that by this definition curry (g) satisfies the
monotonicity condition and so is indeed approximable. We now
calculate:
          curry (g) (x) (y) =           (Z e D I 3ye y. Y curry (g) (x) Z )
                                               2
                                  •     (zeI213yey3Xex. X curry(g)lY.Z))

                                        (zeI213Yey3xex. XUYgZ)
                                        (zeI   13We<x,y>. WgZ)
                                             2
                                  •     g «x,y» • g(x,y).

This proves (i). We also see, that if we take the left-hand side
of (ii) and apply it to a pair <x,y>, it reduces to g(x,y) by
virtue of (i).      ThUS, the two functions in (ii) are the same.

    Turning to (iii), call the left-hand side k.               Using (i)
again, we find

          k(x)(y)    • eva1 0 <h 0 PO' P1> «x,Y»

                       eval «h 10 PO «x,Y>}, P1 «x,Y»»
                     • eval «h (x) ,Y»
                     = h (x)(y).

As this is true for all ye IV 1, then k(x)· hex) follows. As this
                               1
is true for all x e I V I, then k .. h follows, and (iii) is proved.
                            o

<!-- page 48 (pdftotext) -->

44
       Taking (ii) and (iii) together. it is clear that the
domains IVOxV1 ... V21 and 1° 0   "(°,,,°
                                   2 )1 are in a one-one cor­
respondence. But from the very defini tion of curry it is clear
that
                   curry (g) 5 curry (g') iff g 5 g'.
Hence, curry is an isomorphism, and we can invoke 2.1 to con­
elude that it comes from an approximable mapping.  o



     We close this lecture with some order-theoretic properties
of function spaces that characterize inclusion and upper bounds
of functions in a "pointwise" manner.


THEOREM 3.13.       For approximable functions f,g: VO ... V, we have

     (i)     f =g iff f(x) =g(x) fOT all xe IVai.

For subsets F~IVO" °11 we have
     (ii)    F is bounded in IVa ~ V 1 iff (f(x) lieF}
                                  1
           is bounded in 1V 1 1 for each xe IVai;
and in that case for all xE IVai:


     (iii)   (U F)(x)· U (f(x) I fe Fl.
     Proof.   The implication in (i) from left to right follows
because evaluation is monotone in the function as well as the
argument. The converse implication is a consequence of 2.2(ii).

     For the proof of (ii) and (iii) we see that by (i) if F
is bounded, so is every set {f(x)lfe F}. For the converse
direction, it is clear that (iii) defines 80me pointwise mapping;
we have only to prove that it is approzimabl.e. The calcula­
tion that      U
             F preserves di rected unions (see 2.9 and 2.11) is
probably the simplest way to reach the conclusion.   0

<!-- page 49 (pdftotext) -->

                                                                                            45


                                          EXERCISES


EXERCISE 3.14.   For the most part we can assume that there is
at most a countable nwmbe~ of tokens; thus, without loss of
generality the underlying Sets oI1 i of given systems    could be      J;\
assumed to be subsets of 1:* where 1: .. {O,1}. (Any denumerable
set would do.)  Show that the product DO )( V, could be defined
as the system over the set 0011 U 1 011 where
                               0       1
            Vox    V,.    (OXulY      I xeO O and YeO,).
In other 'Words,   the ass\DIlption of the disjointness of 4                     and   ~1
                                                                             0
is unnecessary.  Give, therefore, the revised definition of
<x,y> for elements, and prove that for a single system V, there
exists an approximable mapping
                          diag : D ~ V x '0

where diag(x) c <x,x> for all xE 101.                 Also extend the definition
to a product of n-factors
                     'Oox'O, x· •• x D _
                                      n 1
which will be a system over the set

                               .u
                               l<n
                                     ,i 04i

Note that. fOT a 2-termed product we simplify' 04, to '4,.




EXERCISE 3.'5.     Establish the usual isomorphisms:
    (i)    00 x V, e: 0, x         °0 ;
    (ii)   V o xeD, x 02) '" (00 xV,) x
                                    2 " 00 x 0,  °
                                                x '0 •
                                                    2
How does the product of no factoTs fit in? Prove also:
    (iii) 00 .. D '0     and   °1 .. 0',      imply 00 x 0,   2!   'O'Ox V; .

<!-- page 50 (pdftotext) -->

46

EXERCISE 3.16.         Let V be a given neighbourhood system over
!i. ~ X·.   Define

                        !:J.CO ..    0
                                    n=O
                                          ,nO!i.


so that!i.m is split into infini tely many disjoint copies of d.
Let V.., be the least family of subsets of 1:* where

(1)         It' e V"'. and
(2)         whenever XED and YEV.... then OXU1yev<l>

Show that V"" is a neighbourhood system over /i.....             Prove the
isomorphism
                                p"" S!! D)( 0'"

Show, mereover, that the elements of I V"'I are in a one-one
correspondence with arbitrary infinite sequences <xn>n=O
of elements x E IVI by using combinations of neighbourhoods
             n
                      OX     u, OX u •• · u ,n OX u ...
                           0'                        n
where from some point on all the X are equal to tJ..
                                  m




EXERCISE 3.17. Using the 6 and T of Example 2.3 show there is a
one-one approximable mapping
                                f: B      -+   r'"
and another approximable mapping
                                g:   ra> -+ B
such that

                                g 0 f =I     and fog ~ I •
                                           B              y
Are B and roo isomorphic?                 Are 8 and T)( B isomorphic?

<!-- page 51 (pdftotext) -->

                                                                                        47
EXERCISE 3.18.              Let Va and '0 1 be neighbourhood systems over
6 and 6 • where we again assume that these are subsets of 2:*.
 0       1
We as sume that in addi tion no n12ighbourhood is empty. Why is
this possible without loss of generality?                        Define the Bum
system by:
        V
            o + V,.       {{A}U06
                                      0
                                          U,6,}U{OXIXEV }U{1YIYEV,}.
                                                       O
Prove that this is a neighbourhood system over {A}U06 U16 ,
                                                     0   1
(Throwing in {A} was not all that necessary, but note that
                                  8 = B+ B

and this is an equality of sets not just an isomorphism of
systems.)       Prove that in general there are mappings
              in i :'Di - Vo + '0 1       and outi : 'Do + '0 1 " Vi

where out.      0   in . ., IV.     Where does the assumption ~ f1 V. come in
              I I i                                                        1
here?  How can these sums be generalized to n-tenns?                           (Hint:
As for products use sets 1106io) Draw some pictures.




EXERCISE 3.19.              Suppose we are given systems and approximable
mappings

              f : 1)0 ... Va      and g : V1 ... V ~ •
Prove there are approximable mappings

              fxg:O O x V, .... VO 'Il; V; and f+g:Vo+V,'" V~                   + V
                                                                                    1
such that

    (i)         (fXg)       (x,r) =       <f(x), g{r) >

for all xE IVaI and yE IV, I , and rewrite this as:

    (ii)       f X g = <f' PO' g' P, >.
In addition prove that


    (iii) outo' (f+g)                     ina     f, and
    (iv)        out       , (f+g)         in,     g.
                      1

Do equations (iii) and (iv) uniquely determine f + g?

<!-- page 52 (pdftotext) -->

48
EXERCISE 3.20. (For category theorists). Show that the result
of 3.19 can be used to prove that + and X on the category of
domains and approximable maps are indeed functors.   Show further
that X is the categorical product for this category.


EXERCISE 3.21.       In the proofs of 3.12 in the definition of
curry (g) it is rather cavalierly assumed that the neighbourhood
[Y',Zl uniquely determines Y and 1.. Show that this is true II
Z*n. ' (Hint: Find explicitly the least of fE [Y,Zl.) Show
      Z
that if z., ~2 the biconditional stated at the start of the proof
is still valid even though Y is not uniquely determined. (Hint:
Remember that 4 g 4 must hold.) For arbitrary pairs of neigh­
                1   2
bourhoods of ('0 " 02) is there a simple criterion for identity?
                1




EXERCISE 3.22.       Prove that there is an approximable mapping

         comp:       (V, ~    ~). (Va ~ V1)~ (Va ~ ~)

where for all g : D .. 02 and f : Do ... 01 we have
                   1
         comp (g. f) • g 0 f.

Show this directly by writing down the neighbourhood relation
and by building the mapping up from eval and curry (on suitable
domains) using 0 and <. >. (Hint: Fill in maps in the following
sequence of domains:

                           (Va ~ Vi x va ~   v1
            (V 1 ~ V ) • «Va ~ V ) • Va)          ~   (V   V ) • v
                                                               ~
                    2           1                          12     1
           (V        ~   V ) x (Va ~ V )) • va    ~   (V ~ V ) xV
                 1        2           1                 1   2     1
           ((V       ~   V ) x (Va ~ V 1 )) x va ~ V 2
                 1        2
            (V  ~ V ) x (Va ~ V ) ~ (Va~ ~).
              1    2           1
The maps are of course not uniquely determined, but the
shifting of brackets ought to suggest the right choice.)

<!-- page 53 (pdftotext) -->

                                                                                                 49
EXERCISE 3.23.                (For category theorists.)                  Show that the results
of 3.11  and 3.12 prove that the category of domains and approx­
imable mappings is a cartesian dosed catego11l. (Mac Lane [1971] pp.
95-96 may be consulted for a very brief introduction.)                                 What
is the terminal domin                   in this category?              What sort of functor
is (V -+1' )?
      O      1



EXERCISE 3.24.                 Establish some mOTe isomorphisms:

     (i)         (V
                      o~       (V, xV2)) "          (VO~Vl)       x (VO~V2)

     (ii)        (VO~Ol·)" (VO~Vl)m
     (iii) V
                  o x (0 1 + V2 ) "(V O x V 1 ) + (V O x V 2 )
     (iv)        (V       +    V ) ~V "        (V       ~ V )   x (V, ~ V 2 ) ••
                      O         1    2              O      2

If some of the above are not true, perhaps at least some mapping
relationships can be established.


EXERCISE 3.25. (For topologists.) Recall from Exercises
1.21 and 2.13 on how to regard a domain IVI as a topological
space. Using 3.10 Show that the family of open subsets of IV I
is isomorphic to a domain.


EXERCISE 3.26.                Show that for every domain V there is an approx­
imable mapping
                                       cand : T x D x D -+ V,

called the condit;-ior.al opemtol' J satisfying

     (i)         cand (true,x,y)=x
     (i i)       cand (false, x, y) "' y
     ( iii) cand              (~,   x, y)   :: 1. •

(Hint: Recalling                that T={{O), {n, {O,n}, define tand as a
relation by

    OC U 1OX U 11 OY cond Z iff 0 E C and X ~ Z or
                                1EC and Y~Z or
                              0,1 E C and .6. s: Z

<!-- page 54 (pdftotext) -->

50
where CE T and XE V and Y E V and where we are using the constructior.
of Exercise 3.14.) Find a similar operator in the domain
               T )( Va )( '0              -+   VA + '0        •
                                      1                   1
Show also there is an approximable mapping
               which:        '0       +   '01 -+T
                                  0
such that for all x ElVa + V 1 1
         cond (which(x). ino(outo(x)). in 1 (out 1 (x))) = x.



EXERCISE 3.27.  (For set theorists.) Give another proof that
the family of approximable mappings f : Va ... '0 is isomorphic
                                                 1
to a domain by employing the general argument of Exercise 2.22.
How does this compare with the proof method of 3.9 and 3.101
Can the general remarks also be employed to show that
                 eval : ('0 1 -+'0 2 )          )(   '0 1 ... '0 2
is approximable without bringing in the neighbourhoods in such
an explicit way?       (Hint:             Use 3.5             and the idea of Exercise
2.12.)



EXERCISE 3.28.      In the function space                            (Vo~   V ) let
                                                                             1

                         n{[X i • Yi]1 i<nl
be a (non-empty) neighbourhood.                          In 3.9 the minimal element of
this neighbourhood is characterized as a relation fa. Show that
as an elementwise mapping it can be defined by the formula

                    fO(x) •               U {tYi I xE [\]l.
forxEIVOI. Try to draw a picture of IVaI with neighbourhoods
[X.] and the corresponding values of the function £0'
     1

<!-- page 55 (pdftotext) -->

                                                                                51



                                       LECTURE IV
                      FIXED POINTS AND RECURSION

    Having at this point a large supply of examples of domains
(and further constructs of new domains), we now have to consider
some other ways of defining functions - other than by explicit
compositions of the very basic functions already mentioned.               One
of the most frui tful techniques is an infinitely iterated compos­
i ticn that is at the back of the idea of recursion.              We will use
the process over and over again in these lectures J not only to
define new functions but also to define new domains. The heart
of the matter lies in the so-called "Fixed-point Theorem":


THEOREM 4.1. For any approximable mapping f: V ... V on any domain,
there exists a teast element x E I V I where
                               f(x) • x.

    Proof:   Let £n for n E :N stand for the n - fold composition of
f with itself.    That   ~s.
                                   o
                               f       '" IV' and
                               fn+l"'fof n •
Define
                  x = IX E V           !:J.fnX, for some nE:N}.

We see X E x iff there is a finite sequence !:J. '" XO' X ' •.• , X "'x ""here
                                                         1         n
Xi f X + holds for all i < n. Now since !:J. f!:J. automatically
      i l
holds, a sequence for an X E X can always be extended to a longer
sequence just by adding more !:J.'s on the front.

    We want to prove x E I V I.           Clearly !:J.Ex;and if X£.Y and XEx.
then Y Ex. All that remains to be shoW'll is the closure of x under
intersection. Note that if
                      U f V and U' f V •
hold and U, U'   are consistent in V, then V and V' are consistent and

<!-- page 56 (pdftotext) -->

52
                                 (U 0 U • 1         f       (V 0 V' 1

must hold.     Generalizing this to sequences, if

                          A· X
                                 o f X1 f                       f X = X, and
                                                                   n
                          A· Yo f Y1 f                          f Y • Y
                                                                   n
both hold (and note we have arranged the lengths o£ the two
sequences to be equal). then each pair Xi'Y i is consistent and we have
             A= (X
                     o
                         0 Yo) f (X
                                           1
                                                0       Yi) f · · · f(X n 0 Yn ) = XOY.
This establishes the desired closure.

    We also note that if XEX and XfY then VEx. Therefore. f(x)s:x and
indeed by its very construction x is the least element of 101 with
this property.           (Why?)     But f is monotone, so f(f(x)) 5: f(x);
hence. x"'f(x). By what we have already said it must be the
least such element. 0

     Because the element we have shown to exist in 4.1 is a
least element, it is unique. That is, we have associated with
each f: '0 .. '0 a special element XfE 1'01 determined by the choice
of f. A function has therefore been defined mapping the set
I V .... VI into I.VI. The next result shows that this function,
or operator on functions, is in fact approximable.


THEOREM 4.2.     For any domain V, there is an approximable mapping
                           fi. : (V    ~       V)       ~   V

such that if f: V ... V is any approximable mapping~ then

     (il     fh ( f l ' f (fl. (f)).

Furthermore, ifxEIVI, then
     (iii    f(x) s; x implies fh(f) s; x.

And this last property implies that fix is unique.                             Explicitly .....e
can characterize f1x by the equation:

     (iii) fh ( f ) '        0
                             n"'O
                                     fn(J.)         •


 for all f:V ... V.

<!-- page 57 (pdftotext) -->

                                                                              53
         Proo f:   Formula (iii) can be put in a more elementary form:
             fix (f) '" {X I tt.fnX, for some nE ~}.

To show an elementwise mapping approximable we can use the formula
of Exercise 2.9" applied to the above as the defini ticD of fi x:
   (.)       fix (f) = UlfiX (tF) I fE [F]).
where F ranges over the neighbourhoods of (V ~ P). and where
tF can be considered to be the least element of F as calculated
in 3.9.

     Now from the definition of fix, it is clear that whenever
fs;:g, then fix (f);: fix (gl. because f"Sgn,    (That is, fix is
obViously monotone.) Next. if f e F J then tF is a (finite)
approximation to fj so tF;: f and fix (tF)S fix (f). This
means that half of equation (III) already holds by monotonicity.
All that is left is to prove the other half.

    50 suppose xe fix (f) •  Then, as we have already remarked,
there is a finite sequence of neighbourhoods where
                    tl. ~ X   f X, ••• X _, f X • X.
                          o             n      n

Let the function-space neighbourhood be defined as

                    F ~
                    nUXi' Xi +,] I i< n).
and note that since f E[F]we have at once consistency.              But, by
3.9, tFE[F), so the 8ame         sequence of Xi is sufficient to show that
                              XEfix (+F).
In other words, if X belongs to the left-hand side of (-), it also
belongs to the right-hand side. This completes the proof of (-).

    Formula (i) is just a restatement of what we proved in 4.1.
And (ii) follows easily, because f(x) s x implies that .6.E x and
whenever XEx and XfY, then YEx.                Thus, by induction, if
.t.. f n X, then X ex.    So fix (f) s: x.

     Finally, if 'fax: (V ... V) ... V were any other operator satisfying
(i) and (ii), we 'Would prove at once that

                     f 1 x (f)    S;   fax (f) and
                     f ax (f)     S;   fix (f).

That is to say. the two operators are identical.              0

<!-- page 58 (pdftotext) -->

54
     The reader may have noticed that we used recursion in the
proof of 4.1 (we had to define fn for all n E }i ) •             But 4.' and
4.2 can be used to justify definitions by recursion on a large
number of domains - definitions where the process             of iteration
is far from being as straightforward.              In discussing this point,
let us start with some basic examples.



EXAMPLE 4.3.      The infinite generalization of our original example
1.2 is the system
                     N = {{n}1 nE       rn U {IN}.
The total elements are clearly in a one-one correspondence with
the integers in }oJ. We can apply the construction of Exercise
3.16 to obtain a domain
                          F ;:: NOD

So we already know quite a bit about this domain -                but it has a
much more familiar presentation.

      Let 4J be the set of all        finite partial functions   <P s: }J x }J
(that is, finite sets of ordered pairs of integers where, if
(n. m) E'll and (n J m' ) E <P, then m:::: m' ).    Define
                     t<p= {w E 4> !<PSiW}.

Consider the neighbourhood system

                    F' =(t<p I <pE4>).

It is an easy exercise to show that F and f ' are isomorphic
and that the elements of these domains correspond exactly to
the (possibly infinite)        partial fWICtions n S}J x}J.       Moreover,
the totaZ elements just correspond to the total              functions
""t: }J ..,N   ("function" in the ordinary, set-theoretical sense of
the word).

      Another easy exercise is to show that the domains

                         Fand(N~N)

by our definitions are NOT isomorphic; though the                two domains
are closely related.        We can define a mapping

<!-- page 59 (pdftotext) -->

                                                                                  55
                 val         FxN-+N

by the relationship

         t",U{n}       val {m} iff (n,m)E",.

(Of course val has to relate other neighbourhoods such as:
                 te,pu·)lJval lN,

but these are a11.)               It is then simple to prove that if nE IFI
is regarded as a partial function n: :IN -+ IN             and if for n E::N we
define fie INI by

                     !l ={ {n}, IN},
then we have

         val   (n,     til
                                   .-....
                                   n(n). if n is defined at n;

                                   ON}, otherwise.

(Remember that ON} E INI is the "undefined" element.)
This means that

         curry       (val): F -+ (N-+N)

is a one-one function on elements.                 (The rather slight trouble with
(N-+N) is that it hasmol'eelements than F.)

    So much for the construction of F, we now wish to consider
mappings
                                  f:F ... F
and their uses.        Consider the possibility
         f (n) (n)           0,               if n = 0 ;
                             n(n-1) +n-1, if n>O.

If n were a total        function, then f        (n) would be total.   But if n
is partial, and i f it is, say, undefined at k, then fen) becomes
undefined at k + 1.           Note that fen) is always defined at O.        Note,
too, that f is an        approximable mapping because it is completely
determined by what it does to finite (partial) functions.                  Indeed,

         fen) = UU(",) I ",s;n },

<!-- page 60 (pdftotext) -->

56
where ~ ranges over ~.

    Well, we have proved that every approximable map of a domain
into itself has a (least) fixed point. What is the least fixed
point of this f? Suppose a '" f(o). Then 0(0) = O. and
                        0(n+1)           f(o)(n+l)
                                        o(n) +n.

By induction, then

                        o(n) =     Li
                                 i<n
and 0" is a total function.                  (Therefore. f has a un-ique fixed point.)

      Actually, we can make the procedure mOTe systematic by defining
as fixed points elements of (N -.14) rather than F.                  In the first
place we have 6 E 1141, and from now on we will not distinguish
between nand       n.     Next we have two mappings:
            succ, pred :         f,j ... N

where, as approximable mappings we have
            x suec Y iff 3 n e :N. n e X and n + 1 E Y.
            X pred Y         iff 3nE:N. n+1EX and nEY.

fOT all X, ye N.  This is correct • but what we mean in more under­
standable terms is:
         suee (n) :: n + 1;
         pred (n) :: n - 1, if n > 0;
                     .1. •  if n:: O.
Here, n has been identified with fie INI and .1.:: ON } e IN!.                 More­
over, we have a mapping
            zero: N-+T
which is such that
            zero(n)           true, if n:: 0 ;
                              false, if n > O.
The   stl'uctured dom:z:in

           (N. O. suec. pred. zero>

<!-- page 61 (pdftotext) -->

                                                                        57
can be called liTHE domain of integers" for our present theorye
We shall meet many other structured domains in the sequel.

    Now the iterated summation function a can be completely
characterized - as a map a: loS ... f.J rather than as an element
a elF I - by the following equation:

          o(n) = cond (2Oro(n). 0.0 (pred(n)) + pred(n)).

The only problem is that we have not defined + : Ii x Ii + N. (A
direct definition is left to the readerj general remarks are given
later.) But + could be any function of two variables in order to
make the point about the form of the definition of a. Remember
                         cond : T x loS x f.J -+ foJ,

as defined in Exercise 3.26. We do not put cond in as part of
the structure of Ii because (as should be clear from 3.26) it is
part of the structure of T.

    The above equation for a is properly called a fwtctional
equation; it will be written as a fixed-point equation in Lecture V
when we have the notation for the>.. - calculus. 0


EXAMPLE 4.4. The domain C of finite or infinite binary sequences
mentioned in Exercise 2.21 may be regarded as a generalization of
N.   This can be made plain by saying how we wish to regard C as a
structured domain. To do this we should recall what C is as a
neighbourhood syst.em. In the first place
                   B •   {a I 'It laEI'It}

wheTe I = {O.1}.     To form the system C we have
                   C-BU ((a)loEl:·j.


The total elements of B correspond to infinite binary sequences;
while the total elements of C to finite or infinite sequences.
To simplify notation let us write for oE I'lt
                            0= Hal               (a total element);
                         a .l = to I'lt          (a partial element).

<!-- page 62 (pdftotext) -->

58
In other words we identify c with the corresponding total element
in I C I.


        We wish now to think of C as a structured domain seen as
a kind of generalization of W. The empty sequence A will play
the rOle of De INI; the map succ has two different analogues
for C J however. Just as for 8 we define for x E I C I and a E 1:" :
                    a x :: {Y , 0' X .s i' some X Ex} ,
where of course now X and Y range over C.                 It should be checked
tha t O't' has the right meaning whether we think of 'te1:* or
't E I C I. The two "successoru mappings we are looking for are
             x   I-+Ox     and       x 1-+ 1 x.
All the maps x I-+ax can be obtained as compositions of these
iterated as many times as needed.

     Here are two questions which we now shOUld ask:

    What plays the role of pred? The mapping wil1 be called
tail, and it is characterized by:.
                    tan (Ox) • x,
                    tan (1x) • x, and
                    tan (A) - .L.
It is left to the reader to show that tail exists as an approxi­
mable mapping.


    What plays the role of zero? The answer is not unique. because
in C there are several distinctions that have to be made; in fact
we will define three maps:
                   empty. zero, one:C .. r
where the three maps take on truth-values to distinguish various
kinds of elements in ICI as follows:

<!-- page 63 (pdftotext) -->

                                                                              59
                 ~mpty   (A)      =  true   1


                 empty   (Ox)     '" fa 1 5 e,
                 empty   (1 x)    = false,
                 ze ro   (A)      = false
                 zero    (Ox)     :: true
                 ze ro   (' x)    = fa 1 se
                 one     ( A)     = false
                 one     (Ox)     = false
                 one     (1 x)    '" true.

Again, it is an exercise to show these are approximable.                The
structured domain is therefore
           (e,A,o. 1, tail. empty. zero, one).
Note that we have changed the meaning of some of the symbols in
passing from N to C. Note too that there is a confusion between
o as an element and 0 as the map x j-+ 0 x.            There are just too few
symbols:    In any case this is only an example and not a philosophy
of life. so the reader can be expected not to suffer too much.

    An example of a definition of an element             of lei by a fixed­
point equation is:

                           a '" 0 1 a.
This equation has one and only one solution in ICI. the infinite
sequence that alt:.ernates 0'5 and 1'5.           Note that a is also
characterized by:

                           a '" 0101a.
Another element is
                           b=010b.

which is quite different from a.

    An example of amap         in IC ... C I has the characterization

                           d( A)        A
                           d(Ox)        OOd(x) I and
                           de1 x)       11d(x).

We can write:

<!-- page 64 (pdftotext) -->

60
           d(x) : cond (empty (x), A,
                   cond (zero(x), OOd(tail (x)) , 11d(tail(x)))).

As we shall see in due course. this can be regarded as a fixed­
point definition of d.

      An example of a map in ICxC ... CI was suggested in 2.21.
We can wTi te:

           x y:: cond (empty (x). Y.
                 cond (zero (x), O(tail(x) y), 1 (tail (x) y))).

It should be checked that this equation exactly characterizes
the intended mapping.    0

     The examples we have given wi th Nand C are examples of de­
finitions of functions by recursion.     The literal meaning of
"recursion" is "running backwards" J and a look at the equations
for our examples will show that the functions are characterized
by giving their values either outright    (e.g. at 0   OT   at A) or at
earlier arguments (e.g. at pred(x) or at tail (x)). The reader
should keep in mind that a recursive "definition" is not really
a definition in the sense of explicit definition but rather is a
characterization; a theorem has to be proved to show that such
functions exist. Now we have a general definition of domain and
a general theorem on fixed points and a general construction of
function-space domainj THEREFORE. we know that there are solutions
to our equations PROVIDED THAT the variables range over elements
of a domain and that the other, given functions that appear in
the equations are already known to be approximable (continuous).
This proviso is very important. and we shall remark on it time
after time.

    But. as is well known. recursion also can be done over eete
like ll. and we shOUld examine now the connection between the
familiar kind of recursion and what we are doing over domains.
Of course. one simple connection is already provided by the
way we regard :N as a subset of N. But there are other useful
connections that can be employed in a way that may seem more direct.

<!-- page 65 (pdftotext) -->

                                                                                         61

DEFIIUTION 4.5.             A structured set <l'J,O) + > J where De:N           and
+::N ... lN     is a unary function. is said to be a mode1.fOl'Pea:no's
Axioms        if the following conditions are satisfied:

      (i)       0   '* nolo. for all n E :N ;
      (ii)      n+ ::m+     implies n "'m, for all n, mE :N i

      (iii) whenever xs::N              and Qe x and x+ ~x. then x = tJ.

Here x+"'{n+lnExL                0

      Clause (iii)          is recognized as the principle of ~
~                stated
                 in terms of sets. We usually think of :N as
being "God given", and (i) - (iii) as known without question.
Suppose God, however. decides to withdraw His set of integers
and substitute another.                 We can ask: "Oh: Why did You take from
us our beloved numbers?                 Why must we now live with these- strange
new beasts?"          God will probably reply "Trust Me:"                Perhaps 'We
should in view of the theorem:



THEOREM 4.6.          All models of Peano's Axioms are isomorphic.

     Proof:         There    are several ways to give the proof. but, for
the sake of illustration, an application of the fixed-point theorem
is appropriate here.                 Let <IN. 0, + >   be one model. and let df, 0.# >
be another.          Let    ~   )( M be the ordinary cartesian product of the
two sets and let

                                     P(NxM)

be the powerset (s et of all subsets) of                  ~   x }.f.   As in Exercises
1.15 and         2.20, we regard this set of elements as a domain, whose
finite elements are just the finite subsets of the given set
~   )( }of.     The following mapping on us:            1N x Ill: is easily proved
approximable

                u f-o«(O. O)} U ((n • ,Dl)
                                        #        I (n, rn) E U 1.
(This assertion shOUld be checked as an exercise.)                        We thus let
r be the (least) fixed pOint:

                r={(O, O)} u ((n·,m#)           I (n,m)Er).

<!-- page 66 (pdftotext) -->

62
This       r~lN'   )(:M as a binary relation will tUTn out to be a one-one
correspondence giving the required isomorphism.

       First of all we see by construction that

          ( i)      OrO;

       ( ii)        nrm implies n+rm#.

So, if r proves to be a one-one correspondence. i t will then be
the desired isomorphism.            Now, the two sets shown                  in the equation
                                   #       +
                   ((0,0)) n ((n ,m ) I (n,m) Er} : ~

are disjoint by virtue of axiom 4.5(i).                          Therefore. 0 in m
corresponds by r to one and only one element of                          }.f •   namely the
element O. Let x S :N be the set of all elements of :N corres­
ponding by r to a unique element of )1. We have just shown
o Ex.            Suppose n E x, and let mE:M                be the unique element with
                         +        #                 +
nrm.             Now n       rm       holds, so ncorresponds to at least one
element of :M.                    If n+rl< also holds. then since (n+, k) *- (0,0),
the fixed-point equation implies

                   n + = n + and k = m :#
                             a                  a
for some (nO,m ) E r.   By axiom 4.5{ii) I n = nO' and, by uniqueness
              O
(remember n EX), m = m j thus, m# is the unique correspondent fo . . .
                      O
n+.  We have proved n+E:.. Therefore, x+o;; x; so by 4.5(iii),
x =:}oJ      holds.          Otherwise said, every element in:N           corresponds to
a unique element of                     }.f.


       Note that the roles of :N and M                       are completely symmetric,
and they satisfy the same axioms as structured sets. It follows,
then, that every element of :M corresponds to a unique element of
:tJ. The proof that r is a one-one correspondent~ is now complete. 0



                                                EXERCISES
EXERCISE 4.7.                         Formula 4.2(iii) shows how to find the Least
fixed point of f : V ... V.                     Suppose on the other hand that a e IV I
is such that asf(a).                           Will there be a fixed point x==f(x) with
as x1

<!-- page 67 (pdftotext) -->

                                                                                          63

(Hint:      How do we know          0
                                   n=O
                                         fnCa)       E   IV I 1)




EXERCISE 4.8.          Suppose f : V ... V and S<;: IVI are such that

     (i)      1 E S

     (ii)     xE S always implies f(x) E S;

     (iii) whenever {xn}n:O S Sand x n S x n + 1

                 fOT   all n, then       I ""I xES.
                                         }In     n

Conclude that fi x (f) E S.            (This could he called the principle of
fi:J:ed-poi'Ylt inductio11.)     Apply the method to a set of the form

             s • (x E I V I      a(x) : h(x)),

where a, b :0 ... 0 are approximable, and where we know a(l) = bel).
and f" a = a .. f and fob:. b " f.



EXERCISE 4.9.          Show that there is an approximable operator
            '" : ((V _ Vj_ V)      -   ((V - V) _ V)

such that for El: (0 ... V) ... V and f: V ... V we have

            '"    (8) (f) :      f (8 ( f)) .

Prove further that fix: (D ... 0) -+ V is the least fixed point of '1'.
                                                                   ~




EXERCISE 4.10.          Given a domain V and an element                 aE   lVI, construct
a domain Va where
                        IVai: (XE IVII x sa).

Show that if f: V -0 is approximable, then f can be restri~ted
to an approximable map ft : Vfix (f) ... V    (f)                      where f'   (x) =f(x)
                                          fix
for all     xE    IV fix (f)1.

How many fixed points does ft have in IDfix (f) \1

<!-- page 68 (pdftotext) -->

64

EXERCISE 4.11.   (Suggested by G. Plotkin). We can regard
fix as assigning a fixed-point operator to each domain V.
Show that fix is uniquely determined by the following general
condi hons on an assignment V I~ F :
                                  V
        (il      F : (V~V)
                  V
                                 ~v    ;
        (E)      FV(f)=f(FV(f))            foral1f:V~V;

        (iii) whenever fa: DO'"            DO and £, : D,    -+   0, aTe given and

                 h : DO -+D, is such that h(l) '" 1. and h .. fa = £," h, then

                                   h(F V (foll=FV (f,l.
                                           o           1

(Hint:        Apply 4.7 to prove fix satisfies (iii).                  In the other
direction use 4.10.)


EXERCISE 4.12.              Need an approximable f: V-+D have a rTnrimum fixed
point?        Give an example where there are many fixed points.


EXERCiSE 4.13.              The proof of 4.1 uses the integers, whereas the
proof of 4.6 uses 4.1.                There is a hint of cirCUlarity here!             It
can be eliminated by the following steps:

        (1)   ,!.! a domain V has an element a where, for f: V .... V the
relation £(a) sa holds,               ~        the least fixed point can be defined by

               fix(f)=        nlxEIVI          I f(x),;x).
Note that fix(f) =:a.             (Hint:       Remark that by 1.17 the formula
gives a well-defined element.                    Call the element b.      Prove that
feb) sb by showing that feb) c:x whenever f(x) c;:x.                     Then note
that f(f(b)),; feb) so that b,; f(b) also.                   Conclude b = fix(f)
as least fixed point.)

        (2) Remark that this proof uses only the mono tonIcIty property
o f f : I V I .... I V I.    Remark. too J that (1) can always be appl ied to power­
set domains P A for any set A.

        0) Review the proof of 4.6 and establish by a fixed-point
method that for any structured set (Z, z.-) there is a unique function
s : :N ... Z such that
               (i] 5(0) = 2;
               (ii) s(n+) '" s(n)-. for nE}l.
       (4) Employ (3) for the proof of 4.1 by identifying                    (Z,z, 0).

<!-- page 69 (pdftotext) -->

                                                                                     65
EXERCISE 4.14.      Need amonotone          function f     P-,\ ... PAalways have
a maximum fixed point?



EXERCISE 4.15.       (For set theorists.)          Let f : I V 1 ... 1 VI be a
monotone function on (the elements of) a domain.                  Shaw that f
has a maximal.    fixed point (i. e. a fixed point that cannot be ex­
tended to a larger fixed point).              (Hint:     By Zorn's Lemma
ctlnsider a m aximal chain

                         Cs{x E IVII xsf(x)}

and use 2.11 to remark that             UCE IVI.)        No\<,' argue that f has a
least f ixed point.
~




EXERClS:: 4.16.      (For fixed-point nuts).            Show that a monotone
function as in 4.15 has an "optimal" fixed po-int in the sense that it
is the greatest fixed point below all the maximal fixed points and
at the same time it is the largest fixed point consistent with all
other fixed poin 'ts. Consistency for sets of eZements means having a
common upper bound.    (Hint: Follow these steps:
     (1)   Show t.hat any non-empty set 5 of fixed points has a
largest fixed point ~~ by using the formula

                    fCnS) s n s
and finding the least fixed point over                  ns.
      (2)     Letting a be the fixed point, of (1) constructed from the
set of maximal fixed points, remark that a is consistent with any
other fixed point. x=. f(x), since x can be extended to a maximal one.
Suppose b is consistent with all fixed points, then bSY if Y
is maximal.      (Why?).)



EXERCISE 4.17.       (For algebraists).          Suppose <5,1,,> is a semi­
group with unit      (sometimes called amonoid).              Remark that PS is
a domain.     For a.... b E 5, what is the least x E P S         such that

            x={1}     u {a.b}Ux.x.
where in general      for x. Y.5. 5

            x • y =. (t . II   \   t E X and u E y }?
Need the fixed point be unique?

<!-- page 70 (pdftotext) -->

66
EXERCISE 4.16.       In Example 4.3 there are many unproved assertions
about Nand F.        These should be checked.  In part icular, the isomor­
phism theorem of 4.6 could be proved by constructing a simple domain
M from   ~f   in the way N is constructed from :IN •



EXERCISE 4.19.   There are many unproved assertions in Example 4.4 I
In particular discuss "Peano's Axioms" for {D.n .... Show, moreover,
that one: C ~ T can be defined from the rest of the structure by a
fixed-point equation.



EXERCISE 4.20.       For approximable £, g :D-+V prove that

              fi, (f.g) = f ( f i « g . f ) ) .



EXERCISE 4.21.       Show that the less-than-or-equal-to relation
t S:N x:tJ    is uniquely determined by the fixed point equation

              t={(n,n)    I nElN) U ((n,m+)       l(n,m)Et).

Consider the structured set <PlN, IN J + > where, as before,
                      x+={n+lnExL

What is the unique function [oJ::N ... PlNgiven by 4.13(3)7            Prove
that tile structures < N.O,+>        and <[mJ,m,+> are uniquely isomorphic
for each mE i'l. and connect the isomorphism with ordinary addition
of integers.      Can the same be done for multiplication?         (Hint:
Consider the fixed-point equation:

              n·:N:: CO} U {n+m!mEn.:N}.

where n E:N     is fixed.)



EXERCISE 4.22.             • is a structured set satisfying only
                      Suppose:N
axioms (i) and (li) of 4.5. Must there be a subset :N S:N • that
satisfies (i), (li), and (iii)?            (Hint:   Use a least fixed point
in P ~ •• )     (For set theorists):       How do we know from the axioms
of set theory that there exists such a set :N • 7

<!-- page 71 (pdftotext) -->

                                                                                                  67
EXERCISE 4.23.              (Suggested by S. Eilenberg).                   Suppose f : V .. V
is approximable on a given domain                          V.   Suppose a : V -+ V is a
                                                                            n
sequence of approximable maps where
       (i)      aO(x) =.1:, for all                 xE 'VI;
       (ii)     ansan+1 in '0"'0, for all nE:N



       (iii)     o
                TI"'Q
                        a
                            n
                                .. 1
                                       V in V -+ V

       (iv)     a n + 1o f = a n + 1 cfoan' for all n E:N •

Prove that f has                aunique fixed point.             (Hint:     Show that i f x = f(x).
then an(x) s;an(fix(f)) fer all nE :Nby induction on n.)



EXERCISE 4.24.              (For set theorists).                Let f : A ... B and g: S .. A
be one-one functions (into) not necessarily onto:) Prove the
Schroeder - Bernstein theorem to the effect that there exists a one­
one correspondence h : A-B.    (Hint: (Suggested by A. Tarski).
By the fixed-pain t theorem find X £ A where

               X= (A- geE)} u g(f(X))

where f(X) '" the image of the set f under the function f.                               Define
h !: A x B as a union of two restrictions:
                                       - 1
               h = fIX u g                   1 (A - X) .
A picture helps.)

EXERCISE 4.25.              Perhaps the domains Nand C are not exactly
analogous?       C was based on {O.1} as the underlying set of tokens.
Construct a system C based on {1}* ('" finite strings of 1 1 s)
                      1
wi th neighbourhoods:
                                 m                               n
                C = {(1              I m;'n) I nE N} U {{1           } I nE N}.
                 1

What st~ucture should be put on C  strictly analogous to that on
                                 1
C (=C )? What kinds of approximable maps relate N.C • and C2?
     2                                              1
Draw some pictures.

<!-- page 72 (pdftotext) -->

                                                                           69


                                     LECTURE V
                              TYPED    >. - CALCULUS

      In Examples 4.3 and 4.4. after suitable domains have been
constructed, functions are characterized by recursion equations
whose form of expression is - basically - a composition or substi­
tution of known    functions together .... ith the function to be defined.
This method can be made       mOTe    precise and more easily usable by ex­
panding our nota tion for functions - particularly by inventing a
"temporary" notation for a function as a thing in itself .... ithout
having to have special letters for functions. The device is called
). - abstraotion. It is related to ordinary set abstraction (the
{x I···} - notation already much used in these lectures), but we
gear the approach to domains and their elements, and especially
to function spaces.

      At this stage it would not be so helpful to produce a rigor­
ously formal defini tion of the SYntax of the typed>' - calculus;
we shall try to suggest what is needed by example.          There are so
many examples at    hand. the less formal discussion ought to be
sufficient.

      In the first place we should set aside. in the notational
store room as it were. a stock of variables

                              x, y, z. WI' ••
These variables will be required in different "sizes" or "types".
Roughly speaking    there should be an infinite number of variables
to range over the elements of ~ domain O.              We could perhaps write

                          v       c      V   ... ,
                        X-o ' x 1 ' x 2 •
but the subscrip ts to insure an ir..finity of variables and the       super_
scripts to record the typing of the variables lead to a notation as

<!-- page 73 (pdftotext) -->

70

tiresome to write as it is to read. We simply agree that we can
have as many variables as we need and that they come in all the types.

          Strictly speaking we should also introduce type symbols            and
not confuse types with domains.           But if the reader    ~ill    simply keep
in mind that fOr'm in language has always to be kept distinct from
content, the confusion at the type level will not matter so very
much.       A point at which the confusion might cause a Teal confusion
concerns compound types.         Given Va and V, we can form such com­
pounds as

                    va + V"     va x v"      va.... v,.
What has to be remembered is that a compound domain (neighbourhood
system), Va         x V, say, does not uniquely determine the "parts"
Va and V '  (We could make it do 50. but it would cost some effort.)
        1
Of course, thesymbot "Va )( V 1! has well defined parts. The point
                                    1
is thatdifferent ways of forming a compound domain could lead to
the same         result, meaning that a domain does not let us retrace its
exact history of construction.          Compound symbols,     ho~ever,    always
carry their histories around with them, since otherwise they would
not be readable.         What we want, of course, are both      domain symbols
and    domains. the latter being the meanings of the former.              Most of
the time we can happily pretend that it is only the domains them­
selves we have to think about.

          Besides variables, we will also need certain constants.              For
instance, the symbol 0 (perhaps, better ON) denotes a certain
element of INI.         Similarly, in view of Theorem 4.2, for each domain
V there is a well-determined eleme~t fix V of the compound type
((V ... O) ...   0) denoting the least fixed-point operator.          We have con­
sidered any number of similar constants of a great             variety of types
already (cf. 4.3 and 4.4; cond is an especially good one).                 l\"e can
say that the variables and constants are atomic terms, where
"a tomic" here means non-compound.

          To form compound terms, there are several means:             for example,
if T, . . ,,0 is a list of already obtained terms (including variables
or constants), then we can form an ordered tupl.e

<!-- page 74 (pdftotext) -->

                                                                                               71
We have already       done so in 3.'.              If the types of     "to   ••••   a   are
V •••• ,V'   I   respectively, then the type of the tuple is the product
domain
                      v x ••• x V '
because we intend that the tuple denote an element of this domain.
(The tuple notat ion for functions                 as in 3.3 is being forgotten for
the time being.)

         Next suppose that," has type (V O '"                01)    and a has type V o '        then
the usual function-value notation

                                 "[   (0 )

is a compound term of type              °1,   VJe also use

                           ,   (00' .... °n-1)

as an abbreviation of
                           "" «°0' ... ,on_1>).
where, if the types of 00' ...• 0n_1 aTe V o' •..• Vn _ 1 '                    then the type
of , has to be of the form
                     ((V
                           o )( ... x 0n_1)   -t    On)

where On is the type of the compound.                     In this manner, ...; ith functions
applied to tuples, we have the full facility of substitution into
functions of many variables just by iterating the notation.

         Having taken into account function value J                   it remains to
provide for func tion definition.       Suppose that x o •...• xn_,is a
list of distinct       variables of types Do' ••• , 0n_1'  Suppose further
that" is a term            no matter how complicated - of type On'                      Then
we can regard" as defining a function of n - variables of type

                      ((DO < ••• < D _ ) ~Vn)'
                                    n 1
What we have not       done is to reward our regard by. as yet, providing
a quick-to-write       "name" for that function.               This we now do; it is
called

                     AX o,····X n_1 · " •
where we stress that the Xi must be distinct                       variables and that this

<!-- page 75 (pdftotext) -->

72
expression deflotes the               whoLe function.             That is why we provide it
with a special symbol.

      Here is an example of the J.. - notation

                                  A x. y. x)

which is read "lambda ex wye •..                      (pause) ... ex".       If the types
of x and yare V 0         and 11 , then the type of the above is
                                1
                    ((Vox V ,) ~ Vo)·

 Indeed, we know this function very well:                          it is the first projection
function Po    of 3.3 and the equation

                    Po = A x • y. x
is true, as is the equation

                     P,       =   AX.Y· y.
In the notation of 3.3, we also find the true equation

              < f, g> = AW. <f(w), g(w) >,

where on the right-hand side we are using "official" A - notation
for a function of type
                     (V           ~   (V       x V, )).
                          2                o
The notation on the left is just an  abbreviation and it should not
be confused wi th the pair (2-tuple) of type

                     ((V          ~   Vo)x (V         ~   V,)).
                              2                   2

(Since the two domains just mentioned are isomorphic, the possible
confusion is not all that serious.                         On the other hand, one con­
fusion we will completely overlook is that between 1-tuples <x>
and elements x.     Strictly speaking they are different. but we shall
not bother to make the distinction.)

      Here are some other examples of true equations:

              eval = >.. f, x. f(x)                         (ef. 3.")
              curry = >..g>..x>..y. g(x,y) (cf. 3.12)

The first should be immediately clear; while the second is particularly
instructive.     What is being illustrated is that the A - notation can

<!-- page 76 (pdftotext) -->

                                                                                                        73

be iterated.       The distinction being drawn is between

              A x 0"        x •••• J x _ .. T                   and A Xo A x 1 ••• A x n _ r   'to
                             1        n 1

The fiTst has type

              (CVo         x 01 x ••• x V _ )              -+   On)
                                                  n 1

while the second has type

              (V       -    (V,       ~   ( •.•        (V _, ~Vn) " ' ) ) ) .
                   o                                     n
This is related also to the true equation
              curry (AX,y."t)                     =:    AX>..y.1".

which shows that            there aTe operators relating to the two notations.
The first is the            mJ.ltival'iate              form; the second is the curried form.

      Here is another true equation

              fix =         fix       (>.F >. f. f (F (f))),

where the fix on            the left has type                    « V -+ 0) -+ 0) and that on the
right type
             ((((V- V)            ~   V)    ~     ((V~V)        ~   V)) ~((V~V) ~V)).

This is the content of Exercise 4.9.                                  (This also shows why type
superscripts aTe            tiresome.)

      The combina tion

                                      fix ( A x."t)

occurs so often.            that from time to time we abbreviate it as
                                      ! x . T,

but remember it only makes sense if x and                                 't   have the 8ame    type.
For example in 4.3 we could have written

      0=     I fAn.          cond          (zero (n). O. f (pred (n))                 +   pred (n))

and read this as

      "0   is the 1east (recursively defined) function f whose
           value at n is cond ( . . . )."

We note that in the so-called \od/ of the expression inside the

<!-- page 77 (pdftotext) -->

74
cand-part the variable f occurs again.                     That is j us! the point!
This is a recursive definition; it is made into an expZicit                     defin­
ition by invoking the least fixed-point operator.

      In a A-expression, AX,Y, z.t, say, the variables x,y, z
are being bound                 in -c;     but"t may have other variables that are no­
where bound in             "t    and these remain free variables of the whole
expression.           Bound variables aTe dummy variables and may be re­
written by other variables; thus

                 A x       ."t           >'y."t[y!x]

is a true equation PROVIDED the variable y does not occur in t .
In the equation the notation t[ y / x] means the result of substituting
(rewriting) the variable y fOT the variable x throughout the term T.
We can also write "t [0 I xl for substituting a whole term 0 for a
variable in the other term.

      We have 0.1 ready spoken of "true equations" ~ but how do we
know that these curious equations are meaningful at all?                      They are,
but this is something that has to be proved.



THEOREM 5.'.           Every typed), - term t defines an approximable function
of its free variables.

      Proof:           We argue by an induction on the complexity of "; there
will only be a few cases to consider since the "syntax" of ). - terms
is limited             even though terms can be of any length.

      If " is a variable or a constant there is nothing to prove.
We already know that

                 x I_X               and      x I-k
are approximable functions.

      Suppose " has the form

                 <0
                      0,        ••• , on -1 > •

Then the o. a re less complex terms. and so we can assume - as our
             1
induction hypothesis                        that they define approximable functions of
the free variables.                      Having said this, we just apply the already

<!-- page 78 (pdftotext) -->

                                                                                        75
proved 3.4 to conclude (after a suitable generalization to the
multivariate case) that T, which takes on tuples as values, also
defines an approximable function.

      Next. suppose T has the form

                                     00 ( 01     J,
where we are sure that the types of all the terms match properly.
Again we can assume the 0i to be well behaved.                   But the values we
seek can also be written as

                        eva' (0 0 ,      °1 ),
Since eval is approximable by 3.11, we just have to invoke an
instance of 3.7     to gain the desired conclusion.

      Finally, suppose that T has the form
                           A x . cr.

By a judicious choice of the order of the variables in 0 (including
x), we can assume that 0 defines an approximable function
             g:V                         V     -+0'
                   o x···)(O n-1 x        n
where V' is the     type 6£ 0, Pn is the type of x. and Va • ••••                   0n_1

are the types of the remaining free variables of o.                  Ke apply 3.12
and obtain an approximable function

             curry (g) : V
                             o x •• • x Vn _1 -+ (V n -+ V ')~
But. this is just exactly the function defined by T.

      We leave as an exercise the more general case of a term                       T   of
the form

                        AX       '   •••• x _,. 0
                             O             k
which has a string of bound variables.                0

    We can now say more precisely what it means to call                 0 ="[   a
"true equation".      This means that. if we employ the method of the
proof of 5.', the two terms define the same f'u.nation of the free
variables.    For example,

<!-- page 79 (pdftotext) -->

76

                                 AX.,"Ay., [y/xl
is true, provided y does not occur free in the term "
since the systematic generation of the function defined by
>.. X. "t does not depend on what the variable x                        ~ooks       Uke but only
on its position in the term..                      Some other obviously desirable rules
for generating true equations are stated in the exercises.                                   But one
rule is so basic that we state it here in full generality.



THEOREM 5.2.             For sui tably typed A - terms the folloft'ing equation is
true:

             (;'\X O J   ••••   x _ ' .. ) (00'
                                 n 1
                                                   ••.• 0n_1) ::: .. (0-0 / x
                                                                                o •... , 0n_1 / x n _ 1 1.
         Proof:           It will be sufficient to carry out the proof                      fOT   n = 1.
The proof proceeds by induction on the complexity                               0   £ the term".     In
case    "t    is a constant        k. the result reads

                            (Ax.k)(a):k.

and this is a true equation.

             In case .. is a variabLe             (in particular, the variable x).
the result reads

                            (A x . x) ( a ) : a.

and again this is a true equation.

             In case. is a tupLe           (say, <·0 '.1 >               the result reads

             (;'\x. <.0 , . , »      (0) =    <.0 [a/xl '.1          [a/x]>          .

This is true, because the left-hand side can be transformed by the
true equation

             (>..x:.<.0'.1»         (o)=«Ax·.o)(a),            (Ax·. 1 ) ( O » i

and then we apply the inductive assumption for .0 and for .1.

             In case. is an appLication. we want (supposing the term is
'0 ('1)),
             (A'. '0 ('1) ) (a) : '0 [a / xl ('1 [a / xl)
We can proceed as in the last case, noting that the left-hand side
equal s

<!-- page 80 (pdftotext) -->

                                                                                77
         eval (()"X.<'t"O"1»(0))

     In case '[ is anabst't'Qct     (say, >..y. "["a). we want

         ("x. "-y .'0)(0)       ~"y.,o [o/xl


PROVIDED the variable y is not free in c.         For this we require
the true equation

         (>.x."y.,) (0) ~"y. (I. x. ,)        (0).

We argue for this by letting g be the function of n + 2 free
variables defined by ••      Then, by 5.1. the ,),,-term ).x . .>..y .•
defines the fonction curry      (curry (g)) of n arguments.         We can
call this function h for the moment.        We can write

         h (Y)( o)(y) • g(v, 0, y),

where v is a    ~ist   of arguments.    But, with an appropriate com­
binator inv, which applied to g inverts the order of the last
two arguments, we can write

         h (Y)( a) (y) = curry (in. (g))(y,y)(o).

But, curry (inv (g)) is just the function defined by          p.. x .TJ.   SO
what we have proved as' true is

         (l.x.l.y.,) (o)(y)-(I.x.,) (0),

But if Y is not    free in a. and

                             a(y)=a

is true, then so is
                             a=l.y.a

This completes the proof.       0

     We note that if 't' is the term Ax,y.'t. then 't' (x.y) means
the same as 'to    This gives a convenient way of indicating free
variables:     we just write a (x,y) - where x, yare         not   free in
o - and this will have the same values as any term .. which does
involve the extra free variables x and y.         We use this notational
device in the next theorem.

<!-- page 81 (pdftotext) -->

78
PROPOSITION 5.3.           The least fixed point of
           Ax,y. ,qex,Y), o(x,Y»

is the pair with coordinates
               x . "t (x • ! Y . 0 ex, y))          and

               y . a ( ! x. "t ex. y ) , y ) .

       Proof;      (We are assuming that x and yare not                free in   "t   and
0.)    The purpose of the fixed-point search is to find the least
solution of the pair            of equations

           X="t{x,Y)            andy=o(x,Y)·

In other words, we are generalizing the fixed-point equation                          fro~

Que to two variables - and, of course, we could go much further
to any number of variables.                   To this end, let

           Y. =     ! Y • a ( ! X. 't (x • y) , y),            and

           x.    = !x."t(x,y.).

Then
           x.="t(x.,y.),
and
           r.;:     O e ! L . (X,y".), y.)

                    o(x.,y.).
This proves that <x.' y. >                is one fixed-point pair.

     Suppose, then. that <x • YO> is the least solution.  (Why does
                           o
a least solution have to exist? Hint:   Consider a suitable mapping
of type

                           00    x   0,   1    00   x   0, ,
where 00 is the type of x and 0                     the type of y.)   Then we know
                                                1
           X
               o = "t(x O ' YO) and yo              = o(xo'yo),

and also xO~x .. and YOs:y ...                But from

                           "t (x o ' yo) s;:x O'
it follows that

                             x."t (x'Yo) s;: xO'

<!-- page 82 (pdftotext) -->

                                                                                   79
Consequently

              o(!x. -r (x. Yo), yo) ~o(;X:a'Yo) SY o '

By the fixed-point definition of YotE • we have Y.5O YO' so Y. = yo;
whence,
              x.=!Xo.(x,y.J             = !Xo"t(x,yo) S;:X
                                                             O•
So also x. = x .         We have the right fo:rnrula for YO' and a similar argunent gi,ves
              o
xO'   0
          The purpose of giving the above proof was to illustrate the
USe of the least- fixed-point operator in pI'oofs                   We have such true
principles as:
                          ! x. ,(x)     '" "te! x. "!(x));
and
                          "t(Y) r.=yimplies ! x •• (x) s;: Y.

provided. of course, that x is not free in"t.                     These, together with
the monotonicity of all the functions. were just the methods used in
the above proof.           Here is another example.



PROPOSITION 5.4.           Let x. Y J      and T(X, y) be of the same type V
and let g be of type (V             -+ 0).   then the equation

              AX! y. -r(x, y)     =1g>..x."t ex, g (x))

is true.

          Proof   Let f be the function on the left-hand side.               We
can write
              f (x)       ! y . • (x, y)      .(x,f(x)).

Therefore

              f , AX • • (x,f(x)),

and it follows that

              go:= 19.).X •• (x,g(x)) S f .

Then we have at          once, by definition of go'

              go (x) ,   • (x ,gO(x)),

for any given x.           But by definition of f ....' e find

              f(x)'      !y .• (x,y) Sgo(x).

<!-- page 83 (pdftotext) -->

80
As this holds for all x. then                              f~go   follows.    So the equation
is true.        0

     The last proof is instructive as it uses equations and in­
clusions between functions                          In particular we have just made use
of the principle:

           if         "[so holds for all values of x.
           then       AX. "[SAX. 0 holds.

This is another form of Theorem 3.13(i).


TABLE 5.5.           In the displayed table we give a summary of uses of the
). - notation to define various combinators.                            We have mentioned some
of these equations before. and there are some combinators here we
have not mentioned before - their meanings, however, should be clear.

                              Po=>..x.y.x
                              P,   :II<   ).x,y. Y

                        pair              ). x ). y. <x. y>
                    n-tuple "" ). x ). x, ... ). x n _ 1 • <xO' x, •••.• x n
                                    o
                                                                                           _,>
                       diag    >.. x. <X.X>

                    funpair               AfAgAX. <f(x), g(x) >

                      prOji               >.. Xo ')(1' ... J x n _ 1 . xi
                          n
                     i nv i. j            AX Q • " 0 , Xi' •••• x j '   "0'   x n _ 1 .<x o" .. ,x j •...•
                                                                                       x i ····,x n _ 1 >

                        eval              A f, x.     f (x)

                      curry               >..g>"XAy. g(x.y)

                        cemp              Ag, fAx. g[f(x))

                      canst               >.. k >.. x. k
                          fix             Af! x. f(x)




                                 A TABLE OF COMBINATORS

<!-- page 84 (pdftotext) -->

                                                                                  81
    It is important to note that since we have not typed the
variables. these equations aTe ambiguous: they only become pre­
cise when the types aTe specified. It follows, therefore, that
what we find in     the table are          acheme8     for combinators; there
are actually infinitely many distinct combinatOTS corresponding
to anyone equation depending on how the variables have types
chosen fOT them. Clearly it is better to imagine this variety
of combinators than it is to try to notate them with type super­
scripts.

    One interest of combinators is that it is often possible to
write expressions without variables - if enough combinators are
used.    This is sometimes useful. but it can become clumsy.                  On the
other hand. if      the same combination occurs over and over, it is
sometimes useful to give it a name.                  This is what we do with, say,
composition where

                      comp    (g. f) :      g 0 f.

On the one side we have the prefix notation, and on the other,
the more common     infix notation.          With either notation the variable
seen in AX. g(f(x)) has been got rid of.                 The choice between
equivalent notations ought to be based on a desire for readability. 0

    The reader will have noted that there are Some combinators
not appearing in Table 5.5.              The reason is that combinators like
cond, succ, pred ~ zero, 0 cannot be defined in the pure A-notation
but are specific to domains like T and N; we. thus, have to regard
them as primitive.      But once they are in hand, a very large number
of other functions can be defined from these combined with A­
expressions.    The next theorem gives an indication of the possibil­
ities.



THEOREM 5.6.    For every partial recursive function h: }J .... tJ, there
is a A - term 't of type (N .... N) such that the only constants occurr­
ing in 't are

                condo succ, pred, zero, 0

and where if hen)     = m.    then

                        't   (n)   = m

<!-- page 85 (pdftotext) -->

82
is true; and if h (n)              is undefined, then

                             "t    (n)       =.1

is true,        The equation        "t   (.1) =.1     is also true.

       Proof:     We have only formulated the theorem for functions of
one vanable - but to give the proof, it is convenient to pass
through functions of any number of (integer) variables.                                  We shall
also have to recall the precise definition of the notion of
partial recursive function.

       It is also convenient to work with(very)stri<:Jt                  functions

                             f:Nk-+N.

These are functions such that if nO' ...• TI k _ 1 E INI                  and   TI
                                                                                     i
                                                                                         =.1 for
at least one i < k. then

                       f(n
                             o' ... , n k _1 ) =.1.
It is easy to check that compositions of strict functions are
strict.     It is also easy to see that any partial, function
                             g:lNk-+JJ

extends to a strict (approximable) function
                             -           k
                             g: N            ~N


which takes the same values as g as long as g is defined; other­
wise   g takes the value.l.                  What we want to show for partial, recursive
g is that the corresponding                       g is defined by a A - expression.
       In the first place we have to check that primi.t;ive recursive
functions have A- definitions in this sense.                          We recall that
primitive recursive functions are generated from certain elementary
starting functions by multi-variate composition and the scheme of
primitive recrusion.               The starting functions are the constant
function with value zero and the "identity" or "projection't
functions.        For example, gena, n"                  n 2 ) =n 1 for all nO' n"         n 2 E lJ
is one of the starting functions.                        Now we cannot just use the A-term

                                  AX O 'X 1 ,X 2 ·X,

to represent g, because the function so defined is not strict.
But any function in INk                  -+ N I    can be cut down to a strict function
by a simple device.                Consider

<!-- page 86 (pdftotext) -->

                                                                                        83
                                  }.. x. cand (zero (x),.x, x)

with x of type /IJ.               This is the strict version of the identity
function of one argument.                   The strict projection function of two
arguments can be defined by

                                  A X o ,x," cand (zero(x 1 ), X ,x o ).
                                                                o
The one of three            arguments by:

     A x • x, • x • cond             (zero(.x ) ' cand   (zero(x ). x • x ). cand (zero
        O        2                           o                  2    1   1
                                                                        ex 2 ). x,. x 1 )).
This is not done very elegantly, and the reader can find for him­
self a general solution based on perhaps a better notation for the
required compositions of functions.

    As we remarked, strict functions are closed under substitution,
and any substitution of a batch of functions into another function
can be given by a >..- term, if the various functions can themselves
be so defined.          It only remains to ),,- define functions obtained by
primitive recursion.                  Thus, suppose, for the sake of argument, that

          f : :N ... :N          and g : ~ ... :N

are given as total functions with f and g being A - definable.
From them, we obtain by primitive recursion h: :N ... :N where

          h(O,m)            • fern),
          h(n+1, m)         '=    g(n,ID.h(n,m))

for all n, mE ~.                  The A- term defining fi is

          !kAX,y. cond (zero(x),f(y),g(pred{x),y.k(pred(x),y))).

Here we have had            to use the fixed-point operator on a variable k
              2
of type (N        ... N).         The variables x, yare of type N and the cond ­
construction puts the two traditional equations into two clauses
of one expression.                 It is easy to see that the fixed-point function
i8 strict and is nothing more than h.

     That completes the representation of ~ recursive
functions.        To obtain the            ~        recursive functions, the idea
is to use the so-called lJ.-scheme (least number operator) and,
further, to close           up under substitution.           We need only treat the
lJ.-scheme.       Suppose, by way of example, f(n,m) is given as a

<!-- page 87 (pdftotext) -->

84
primitive recursive function.             We then define h (generally, a
partial function) by

                       hem) '" the least n where f(n.m)      = O.
This is often wri tten

                       hem)    '" '\.In. f(n,m) :: O.

Supposing, as we may, t i s ),,- definable, we introduce first
     g~! gAX, y.      cand     (zera (f(x,y)), x, g (succ(x), y)).

Then h=>..y. g(O,y).         This is easily seen to be strict.       Also easy
to see is that if hem)         is defined, then g(O.m) = h(m).      But, if hem)
is not defined, it takes some argument to make sure that the least
fixed-point construction forces g(O,m) = 1.             However, the argument
is not very difficult.          0

     What is not     said in 5.6 is that every)" - term defines a
partial recursive function.            This is true (with suitable control
over the constants and types in the expression). but the proof
requires a full analys,is of computability properties of domain
constructions. This is the topic of Lecture VII.

        It should be remarked that the types of variables needed for
 the proof of 5.6 never get very high. In fact, types like N, NkJand
(Nk .... N) were the only ones needed (with perhaps T thrown in also).

    Recurs ion on N was the topic of 5.6; further examples of
recursion on other domains are included in the exercises.


                                EXERCISES
EXERCISE 5.7.       Find definitions of
                   )" x,y ••    and   a (x,y)
which use only)" v with one variable and applications only to
one argument at a time. Note that use must be made of the com­
binators PO' Pl' pair. Generalize the result to functions of
many variables.

<!-- page 88 (pdftotext) -->

                                                                                  85
EXERCISE 5.8.       (For combinator nuts.)             Table 5.5 was meant
to show how comb inators could be defined in terms of A. - expres­
sions.    Can the    tables be turned to show that with enough
combinatoTs avai lable, every A. - expression can be defined by
combining combinatoTsJusing 0(.) as the                 ~nll   mode of combination?



EXERCISE 5.9.       Suppose that i, g : V... V aTe approximable and f., g '"
go f.    Show that     f and g have a le.astcommon             fixed point x=f(x)"'g(x).
(Hint:    Refer back to Exercise 4.20)            If in addition f(l.) = g(.1).
sho . . . that fix ( f ) = fix (g).     In particular will fix ef) = fix(f 2 )?
What if we only assume f., g = &2., f?



EXERCISE 5.10.       Suppose Va and 0,         are neighbourhood systems
over disjoint Sets AO and A"                Define the 81Ttlsh product V 0 @ V1
. . . ith neighbourhoods

    {~o u ~,} u {X U Y I X E VOl {A }        and ye V"     {"',}).
                                        O
Show that this      is a neighbourhood system. Define (VO ... .L V ) so
                                                                  1
that IVO ... .i °11 consists exactly of the strict functions. By intro­
ducing appropriate combinators, show that

           (Vo~~     (V,~~ V 2 )) and        ((VO@V,)~~V2)

are isomorphic.



EXERCISE 5.11.       For any domain 0 we may regard v<O as consisting
of (bottomless) s'tacks         of elements of V.         With this image in
mind. define appropriate comb ina tors wi th the obvious meanings:

                        head        v<O ... 0 ,
                        ta il   :   v<O ... v<O;
                        push :      o x 0"" ... 0<0.
Using the fixed-point theorem argue that there is a combinator

                        diag:       0.0""

where for all x E I V I we have

                        didg(X) "'" <x>n:o'

<!-- page 89 (pdftotext) -->

86
(Hint:       Try a recursive definition. say

                             diag(x) = push (x, diag(x)),

but be sure to proveatt terms of diag(x) equal x.)                          Also intro­
duce by an appropriate recursion a combinator
                            map:    (D   -+    V)""')(V   -+   p""

where for elements of the suitable types:

                  map «£n>n:O' xl              '" <fn(x»n:O'


EXERCISE 5.12.              On any domain V introduce(as a least fixed point)
a combinator

                  wh il e      (V ~ T)   x (V ~ V)        ~    (V ~ V)

by the recursion

              wh i I e (p, f) (x) = con d (p (x), wh il e (p, f) (f (x)) , x ) •

Prove that

               while (p, while (p,f)) = while (p,f).

Show how while could have been used to obtain the least number
operator mentioned in the proof of 5.6. Generalize the idea to
define a combinator

                             find    V- x (V ~ T) ~ V

wi th the meaning "find the                   fiTS t   term of the sequence (if any)
which satisfies the given precicate."


EXERCIS£ 5.13.              Prove the existence of a one-one              function
num : :IN x :IN .... :IN    such that

                            num (0,0) '"        °
                             num (n,m+1)            num(n-+1,m) + 1 ~

                             num (n+1.0)            num(O,n) + 1.

Draw a picture (i.e. an infinite matrix) for the function and
find a closed form for its values. if possible.                          Use the function
to prove the isomorphism of the domains

                             P 1'1 ,P(JN x IN), P :Nx P :N.

<!-- page 90 (pdftotext) -->

EXERCISE 5.14.        Show that there are approximable mappings
           graph      ( P:N       -+    P:N)        -+    P]Ii   and

           fun        PIN     ~        (PIN     ~        PJNl.

where we have

           fun 0 graph'" A f. £, and

           graph 0 fun? AX. x.

(~int:    Using the notation

           [no'    0" .... ok]              =   num(no,[n"         .... ilk])

two such combinators can be given by formulae
           fun(u)(x):::: {mI3n
                                        o
                                            ,o ••• n k _,Ex.fn o +1, •.• ,n k _,.1,O,rn]Eu}

           graph(f)    = {[no+1,••. ,nk_'+',O,mJ[mEf({no •••• ,nk_1})                        J,
where k is variable - meaning all finite sequences are to be
considered.)



EXERCISE 5.15.       (For algebraists.)                      We can regard < {O , 1} • , A, • >
as the free semigroup on two generators 0 and 1. The powerset
P{O,1}- is taken as a domain as in Exercise 4.17. For "words"
eE {O,n
          • define
           e•
                        2   3         n
                {A, e, e , e , ... , e , ... }.

Show that the leas! fixed point of
           z:{e).ZUCe')

in p{O,n • is z: e • . {e'l.            Show further (as suggested by David
Park) that the least solution of

           X   :a·xU b·yu c

           y"'b·xua·yud

has

           x"'(aub-a·b) ••              (cub·a·dL        •
where the {.} has been dropped off {a}.                                {b} etc., and where
the   •-notation has been extended to the whole domain, so that
           z•: A u z•· z .
(Hint:    Apply 5.3.)

<!-- page 91 (pdftotext) -->

88
EXERCISE 5.16. Return to the discussion of Example 4.4 and
the construction of the domain of finite and infinite binary
sequences.     Give a fixed-point definition of neg: C -+C. where

                          neg (Ox)         1 neg (x);
                          neg (1x)         Oneg (x).

Prove that neg (neg (x) ) '" x for all x E Ie I.            Also define
merge: C xC .... C. where for    E. 6 E   {O, 1} we have:
                   merge (E X, 5 y) = E 5 merge (x,y).

(Note:     There may be a little trouble 'With merge (x,Y) when x
is finite and total and y is infinite - you have to decide what
yo~ want in e.g. merge (A,Y).)  Prove that
                   merge (x,x) '" d (x) ,

in the notation of 4.4.         Consider also the infinite non-periodic
sequence

                   t·O merge (neg(t), tail (t)).

Prove that the nth digit of t is the sum mod 2 of the digits
of the number n written in the binary scale (a suggestion of
J. Lambek). Show also that t -+ u a a a v where a is any fini te
sequence *" A, and where u is fini te.

<!-- page 92 (pdftotext) -->

                                                                      89


                                LECTURE VI
                   INTRODUCTION TO DOMAIN EQUATIONS


      The maj or reason for introducing the theory of domains is
to have a notion of computabi1.ity incorporating both finite and
infinite elements. In our many examples already explored 'fie
have seen how functions (functionals, operators, combinatoTs)
ca~ be defined on domainsj owing to the property of approximab­

ility (continuity) of these functions, we have also seen how they
can be "calculated" by finite approximation.   In this lecture
further examples of domains will be constructed -- especially
domains having infinite elements, which can be introduced in a
variety of ways giving rise to interesting structural possibil­
ities. The next lecture then treats a precise notion of compu­
tability appropriate to these domains; while the last lecture
opens up new methods of domain construction.



EXAMPLE 6.1. Let V be fixed as a given domain. We are now
familiar wi th a useful construct like V x V whose elements are
ordered pairs <x.y> of elements x, yof V. The question is:
can this construct be iterated? The answer is obviously yes,
since V x (V xV) and (V x V) x (V x V) and so on can be formed with
elements <x,<y.z» and «u,v>. <x,y» and the like. But the
real question is:   can the construct be iterated indefinitely?
AND can the resul ts be collected together into a eingle domain?
The answer is yes~ but it requires a bit of work to get it right.
The method to be introduced will be open to many variations, so
more than one answer is possible, giving non-isomorphic domains.

      In order to collect all the iterates into one large domain
we give ourselves first a very big domain inside of which the
desired family of neighbourhoods will be found. There are many
ways to make this choice, and we are fixing on one that will
keep the notation simple. We have often used binary sequences
for examples and constructions, but for this example let us use

<!-- page 93 (pdftotext) -->

90
ternary sequences. Let 1:= {O,1.2} and let r'" be all finite
sequences from this three-letter alphabet. We will select
subsets of ';. for our neighbourhoods. As 1:. is countably
infinite, it is without much loss of generality to assume
that V is a neighbourhood system over f::,. where we take 6::: r"'.
Also without loss of generali ty we can assume 0lf l?   (Why?)
                                 =
We wi sh to find another set r r'" to be the set of tokens for
the nell domain. After we find it, we will still have to say
just which XSr are appropriate for the structure we want.


      The totality {X 1 X =:1:"'} is, as a powerset. isomorphic
to the set of elements of a domain: a point we have remarked
several times. So, by the Fixed-Point Theorem we know there
is a set rSI:· where

                      r=Ol>U1rU2r.

In fact r", U,2}· 06, because we can say:

              {1.2}"={A}     U 1l1,2J" U 2{1.2}"

The domain we are looking for will be found as a domain V§
over r. The reason for spli tting r up, as shown in the equa­
tion above, is to ensure that if X,YEV§ are two neighbourhoods
in the system V§, then    1 X U 2 Y   has a chance of be ing also in
V§ because

                          1 X u 2Y Sr.

This will make V§ )( V§ isomorphic to a part of V§.  If we make
V also isomorphic to a part of V§, then all the iterated products
will be contained in V§.

       \ll'hat is a neighbourhood system? Just a set of sets. But
p p ~" is a domain (as a power set) and because r      ==!:.,
                                                        we find
                           v§eppr·
as an element. But elements of domains can often be defined by
fixed-point equations. Indeed we will introduce V§ this way:
       V§ = {f} U {OX I XEV} U {1X U 2Y I X,Y E VI}.

The reader should stop to think why V§ can be immediately seen
to exist by writing such an equation. Of course another way
to describe V§ is to say it is the least family of sets containing
(i) the set r, (ii) the sets OX for X in the given system V, and
(iii) sets 1 Xu 2Y whenever it already contains X and Y (closure

<!-- page 94 (pdftotext) -->

                                                                                91

under a set-forming operation).                By saying "least l l • we mean
(iv) nothing else belongs to V§ except as allowed by (i)-CliiJ;
this mak.es the truth of the ,equation for V§ clear. So V§exists
as a family of sets, but what good is it?

      By our construction of r. all the sets W'e put into V§
are subsets of r (why?) J so Vi has a chance of being a system
over r if we can check the closure under intersection. So
suppose Z~ XnY where Z.X,YEV§; we want to show XnYEV§. We
argue by induction on the number of steps required to put X and
Y into V§ by (1) - (iii). There are several cases.

      If X '" r or Y = r, there is nothing to prove, because both
sets are subsets of r.    We note that 0EfV§, because (i)-(iii)
cannot introduce Si' as a member of vi. So, if X~OA for AEV,
then Y must have this form also (if it is not r). because

                        OAn(1 BU2C) •              0
(That is, if Y had the form (iii). then Z 0 would be a consequence,
                                                        II<



which is impossible.) Thus, if X'" OA for Ae V, then Y = OB for sane
BE V. But by the same reasoning Z "" OC for some CE V also. But
the relationship OC.sOAOOBis equivalent to       C=.AnB. We see,
therefore. that A n BE V. and so
                xnY- OAnOB- D(AnB)

must belong to V§.

      The final case has X,Y.Z all of the form (iii):

                        x- 'A       U 2A
                                1          2
                        Y ;; 1B U 2B . and
                               1    2
                        Z:1C        U2C
                                1          2
We can think of the Ai and B put into V§ earlier and the inter­
                              i
section result as being already established for them. But the
relationship Z c X n Y is equivalent to C. cA. n B. for i;; 1,2.
Therefore Ai n ;i e V§. and so does      1. - 1.  1.

      XnY-(1A       UZA ) n (1B1U2Bzl-1(A1n B,l U Z(A n Bzl
                1      z                             2

<!-- page 95 (pdftotext) -->

92

      We have now seen that V§ is a neighbourhood system~ but
why was it constructed that wa;? The reason is simply this
isomorphism (or domain equation):
                           V§~V+(V§xV§)

as can be seen by reference to the equation for V§ and the
definitions of + and)(. What are the elements of V§? There
is always
                            l ' {f).

Next if xE IVI we define
                   x § • {f} U {a x I x EX} •

That gives an isomorphic injection
                           Ax.x§: V~V§.

Then for x. y E I V § I we can define

               <x. y> • {f} U {1X U 2 Y I X E X and Y E y).

We have another isomorphic injection
                                       .       I
                      AX,y.<X.y> . V               x   V § ... V § •
Indeed by looking at the neighbourhood definition of V§ we con­
clude that the finite elements of V§ are exactly those that are
either of the form (i) 1, or (ii) a§, where a is finite in /Vl
or (iii) <a,b>, where a and b are previously obtained finite
elements of I V§ I.

       Suppose a""J f         are finite in lVI.                               We can picture the
elemer.t
                       §          I        §           §               §           §
                u = «a , «b , c >, d ». <e                                 J   f       »
in IP§I as a tree:
                                           u




           a                                                      e                        f



                              d



           b           c

<!-- page 96 (pdftotext) -->

                                                                          93
Note that the tree has binary branching with the elements of
101 at the ends of the branches.           Any such tree could be given
a notation as an    element of IV§ I.       The finite elements of
IV§I correspond exactly to such finite trees.

      What of the infinite elements of IV§I? Are there infin­
He trees?   Let a, be rV§j be any elements of IV§1. Since
palTlng is an approximable mapping, we can solve the fixed­
point equation
                        v;:: <a,<b. v».
In pictures we can diagram v roughly as:

                                       v


                         a




                                                                 a
                                                                          etc.

The word is " roug hlyll here. since if a or b were not in the IVI
part of I V§ I. then in the diagram the letters tra"and "bIT should
be replaced by the corresponding tree diagrams for a and b.

      Suppose that a and b are finite.          Then we can easily see
that the infinite   tree v is the limit of the following sequence
of finite trees:

                         V
                             o = .i.
                         v    +  =<a.<b,v » , and
                             n 1         n
                                  00



                         V    =   U  v '
                                  n=D n

<!-- page 97 (pdftotext) -->

94
The reader should think how to explain from tree diagrams the
approximation relation vn=v and more general such relationships.

        We could call P§ a tree algebra over V.               There may be
others.     A general one is a structure of the fOTm

                                 < E. ; n,   p a ; r>
where
                                 in:V ... E,and

                                 pa;r:cxE ... E.

The algebra
                        §           §
                   <v       J   AX.X , AX.y. <x,y»      ,
however, is a very special one:               it is "minimal" among all tree
algebras over V in a sense we shall have to make precise.

        To do this think of how E and V§ can differ.                In view of
the isomorphism ~hat V§ satisfies the injection of V and the
pairing are one-one, so no "information" is lost by these
mappings.    The same may not at all be true of E. but it is
reasonable to think that at least we can define an approximable
mapping g : P§ -+ E where

(1)        gU)-lE'

(2)        g (x§)· in(x), fOT XE lVI, and

(3)        g «x,y» = pa1r(g(x), g(y)), fOT x,yE IV§ I.

By what we said earlier, g will be uniquely determined by (1)-(3).
because these equations tell us exactly how to calculate g on all
finite elements of IP§I.            An approximable mapping is a,lways
determined by its action on the finite elements.                  But why does
g exist?

        It would not be too hard to give an inductive construction
of g as a neighbourhood relation, but a fixed-point equation is
easier to write down for the same purpose.                  We need, though,
to have the inverse ("predecessor") functions:

<!-- page 98 (pdftotext) -->

                                                                                   95
                           out:    v§ .. 'o
                           proji: V§ .... V§, for i"'O,1,

where
                           outCx§) "" x J
                           projO«x,y»         = x,   and
                           proj,«x,y»         =y.
We also need
                           atom:V§ .. r.
where
                           atom(x§) = true, and

                           atom«x,y» '" false.

We can then write

    g (x) = can d ( a t am (x) • in ( out (x)) , pair (g (p r ojo (x)). g ( pro j 1 (x)))) •

This g exists by     fixed-point theory. and it satisfies (1)-(3)
by what we know about the structure of IV§ I.              As we said, g is
unique because the values on finite elements are fixed.

        In algebraic language g is a homomorphism of tree                alge~

bras; and V§ is called an initial algebra, because for any tree
algebra E there is a unique homomorphism g : V§ -+ E We note at
once that any two      initial algebras are isomorphic.             For i f 0* were
another, there would exist homomorphisms in both directions
between V§ anc V·.  But the compositions of homomorphisms are
again homomorphisms, and in the case of V§ if we go from V§
V* and back to V§,      the result must be the identity.             The reason
is that the identity can be the only homomorphism of an initial
algebra into itself. We thus have a precise meaning of the
minimal character of V§. But note it still took a construction
to show that the domain V§ e:d8ts.              0

<!-- page 99 (pdftotext) -->

96
EXAMPLE 6,2.       OUT staple examples Band C satisfy "domain equa­
tions" in the form of isomorphisms as we have previously seen.
Indeed
                                 B ~ B ... B. and

                                 c '" {{A}} + C + C
where i f we liked we could construct beth systems over {O,11*
and have

        B={{O.1l"jU{OXIXEB}U {1XIXEB}.                                and

        C= {( 0 • 1l") U {{A}} U {O X I X E C } U {1 X I X E C } •

We leave to the exercises the explanations of what kinds of
algebras Band C are and why they are initial. Here we want to
propose a simple, yet interesting generalization of B.

         Consider this domain equation
                             A::!! An + An

where An atands for the n-fold cartesian power of A.   We can,
wi th the aid of some encoding solve this equation as a neigh­
bourhood system over {O,1}* as follows:
                                              j
         A· {{O,1l"} U       U         {   iU1 OX          I XjEA all j<n}     .
                                                       j
                            i=0,1          j<n
For instance, if n =. 3, then a typical neighbourhood in A is
something like

                             00X       U010X         U0110X       '
                                   O             1            2
where X ,X ,X E A. The first '0' could also be a                            '1' in front
       O 1 2
of each of the terms.

      In words. an element of A (other than 1) is an n-tuple of
elements of A:  but there are two separate copies of these, the
left one and the right one.                 We can write for aE IAI

                         a'" :t<a O,a 1 J." .a n _ 1>.
where    +   is chosen if a is on the right, and - if on the left.
As a tree diagram a might look like this for n'" :5 :

<!-- page 100 (pdftotext) -->

                                                                                       97

                                    a +


                                        ~1
                                                                +




That is, a is an infinite ternary tree with + or - labels at
each node.    If each node (subtree) is truly infinite, the eement
is total; if 1. is ever encountered, it is only partiaL; i f every
branch ends with 1., the tree is a finite element of IAI.

        What can be done with such trees'?           Let   aE       {OJ1 •••• ,n-1}*
be a finite sequence of "digits" each less than n.                      We let
I={O,1 ••..• n-1}.      We can define for aE IAI the operation                   o~aa

by recursion on    0:

                         a A '" a , and
                         aio;(3 )0.
                               i
The 30 are just. the Bubtrees of a with 0" as a sel-ector. We also

have a map
                         pas: A ... T
where
                         pos(+<aO,a1, •• "an_1» "'true, and
                         pos(-<aO,a 1 , •.•• an_ 1»   '" false.
We say that a (total) tree a is eventually pepiodic iff the set
{ao ICE I·} is finite.        The result is that the "language"

                  La = {crE 2:*1 pos (acr) = true}
corresponding to     an eventually periodic tree is always a reguZar
event of automata theory, and every such language has this form.
In fact, a just represents the initial state of an automaton,
and acr represents the state after "reading" a tape cr.                     a

<!-- page 101 (pdftotext) -->

98
       In order to formulate more generally the idea of a domain
equation and initial algebra, we must introduce a small amount of
the terminology of category theory. To be as specific as possible.
think of systems V over sets .6.~~. with E= {OJ1},               say.   They form
quite an interesting category with respect to the approximable
maps f: V .... D'.   Recall that to be a category of "domains" and
"maps" all that is required is an associative composition g" £
of maps with identity maps I: V .... V for each domain of the category.
And this we certainly have for the systems indicated. And
there are many other categories waiting around: for instanc~
restrict systems to those where ~ If V. This is not much of a
restriction, as every system is isomorphic to one                like this.
Or restrict the maps to being the strict maps f : V .... V' where
f(1. ) =lV"      This is an essentially different, though related
     V
category.     We shall find many others.

         What examples       6.1 and 6.2 suggest is the notion of a
construct which makes new domains out of old.              For example,
with V fixed, 6.1 suggests for any domain X over r=.r* a domain

                           T( X) • V + (X x X).

More specifically (converting from:E= {O,1,2) to                ~ ~ {O,1»we

could write

          T(X)' (r')" (OXIXEV) u (10Xu 1nIX,YEX),

where we have f' =O.6.U10fU11f.              (By the way. here we definitely
want to assume Ii' Ef:V and ~ Ef:X and to get Ii' Ef: T(X) .)     This construct
is an example of a functor, a notion that can be defined ab­
stractly on any category.



DEFINITION 6.3.      A functor on a category (into itself) associates
with every domain X in the category another domain T(X)and to
every map

                               f: X .... Y

another map
                         T(f) : T(X) 1 T(Y)

<!-- page 102 (pdftotext) -->

                                                                                             99
in such a way that identity maps and compositions are preserved:

                              T(I X ) • 'T(X)' and

                              T(g. f) • T(g) • l(f).

whenever f : X .. V and g : Y .. Z. 0


         In the example from 6.1 we have not checked how the special
T is a functor.          The hint is that whenever f : X .. Y. then there
is a map
                              fxf:XxX ..... VXV.

But there is also a map
                     1       + f)( f    :V + (X)( X) .. V + (Y x Y)
                         0
and this suggests the definition of Tef). The details are left
to the exercises~ Note that the map Tef) just suggested is al­
ways strict. so T is a functor also for the category of strict
maps.

      One good reason for a little of the category-theoretic
language is that the next definition becomes very neat indeed.



DEFINITION 6.4.          A T-tItgebra is a domain E in the category to­
gether with a map
                                       k: T(E) ~E.
If m: TeF) .. F is       another T-algebra. then a              h()m()m()~phism   is a map
h : E .. F in the ca tegory such that the diagram

                                             k
                               T(E) _             E


                  T(h)
                                1
                               T(F) _
                                            m
                                                  1
                                                  F
                                                      h


commutes; that is. the equation

                               h • k • m • T(h)

holds.     0

<!-- page 103 (pdftotext) -->

100

       In our example from 6.1 a T-algebra is astrict map

                              k: V + (E x E) ~ E •
But such strict maps are in a one-one correspondence with pairs
of (not necessarily strict) maps

                          n : V -+ E   and p:   E x E ... E

And the structure <E,n,p> is what we called a tree algebra.
Definition 6.4 just makes this abstract.                 The reader should also
work out the details showing that 6.4 I 5 definition of homomor­
phism is just what we ought to expect.

      Note that the T-algebras and homomorphisms form a cate­
gory. (Why?) The following definition is so abstract that                    it
could be given for any category.



DEFINITION 6.5.        A T-algebra is initiaZ if and only if there is
a unique homomorphism from it into any other T-algebra.                 0

      The word    l1   o ther" here is not meant to imply "distinct".
For an initial algebra there is one and only one homomorphism
into itself:     the identity map.         As we already indicated in 6.1
it is a general fact that the next proposition holds.


PROPOSITION 6.6.        Any two initial T-algebras are uniquely iso­
morphic.   0

      Slightly more interesting is the behaviour of T on initial
algebras.


PROPOSITIDN 6.7.   If i: T(V) -+V is an initial T-algebra. then so
          2
is T(i): r (V) -+T(V) and i is the isomorphism from T(V) to V.

      Proof:   Clearly since T is a functor. the map T(i) has
the right mapping character to make T(V) a T-algebra.                Since
V is initial, we have a commuting diagram:

<!-- page 104 (pdftotext) -->

                                                                 101
                                       i          v
                                      -1
                               T(V)           >

                        T(j)
                                 v
                                  I
                                      T( i)
                               T2(V) -->T(V)

But we also have the trivial diagram:

                                      T( i)
                                2
                               T (V) -->T(V)

                        T(i)
                                 v
                                  I    i
                                                  I i
                                                  v
                               T(V) - - > V

It follows that    i   ~   j    is a homomorphism, so

                                 i o j = I V'

But then because T is a functor we find:

                               T(i) 0 T(j) '!T(V).

and, since j is a homomorphism, we have

                                  joi·!T(V).

This shows that i          is an isomorphism.           0

      From 6.7 we see that if we are going to have initial alge­
bras at all we have to satisfy the domain equation
                                 V~T(V).


But generally that is not enough to assure that V is initial.
There is a condition that our functors satisfy. however, which
guarantees the existence of homomorphisms.


DEFINITION 6.B.   On the category of domains and strict approxi­
mable maps a functor T is continuous on maps if for any systems
V and E the induced mapping
             Ai.       T(f): (V~.l E) ~ (T(V) ~.l T(E))


is approximable.

<!-- page 105 (pdftotext) -->

102
THEOREM 6.9.     If the functor T is continuous on maps and if
V:!! TeV), so in particular V is a T-algebra, then for any T­
algebra k: TeE) .. E there is a homomorphism h : V -to E.

        Proof:   Let i : T(V) .... V make VaT-algebra, where
j : V ... T(V) is the inverse so that i is an isomorphism of domains.
Suppose that k : TeE) .... E is any T-algebra.      A homomorphism
h : V .... E would satisfy

                             hoi = k 0 T(h) •

Rewrite this equation as
                             h=koT(h)oj.

In the domain of strict maps (D .... E) this is a fixed-point
equation for an approximable map

                             Xh.koT(h)oj

by our assumption on T.        Thus, the desired homomorphism exists. 0

        The final question we have to answer is why in our cate­
gory the minimal V exist.           The reason is that the functors T
that we have in mind possess further continuity properties on
domains. This is conveniently expressed in terms           of a notion
of "subdomain tl •



DEFINITION 6.10.      For two neighbourhood systems V and Ewe
write

                             V<lE

to mean that these are neighbourhood systems over the same set
of tokens ..6. and not only is V £ E but whenever X2 y E V and
X n Y E f) then X n Y E V. 0

        For the subdomain relation V <I E to hold, V has to be a
smaller family of neighbourhoods, but the notion of consistency
in V also has to be the same as in E.           Note that if V
                                                                 o <J E
and V <J E then
     1

<!-- page 106 (pdftotext) -->

                                                                                          103

                           V
                               o q V 1 iff          V
                                                        o S V1
It is also easy      to prove that the union of a directed family
of subdornains of E is again a subdomain.                           As a consequence of
this remark 'We have:



PROPOSITION 6.11           For a given neighbourhood system E. the set
of subsystems
                                 (VIV<JE)

forms a domain in its own right.                        0

        The subdomain relationship implies a mapping relationship
between the doma ins.


PROPOSITION 6.'2.          If V<JE. then there exists a projection pair
of approximable mappings:
                                i : V ... E       and j : E ... V

where j " i::: IV and i "j S IE' which are determined as elernent­
wise functions by these equations:
                   i(X)={YEEI3XEX.X~Y}, and

                   j (y) = y n V.

for all    xE   IVI and yE lEI. 0

        The proof is left for the exercises.


DEFINITION 6.13.       A functor T is monotone on domains iff whenever
V<J~.then    not only do we have T(V) <JT(E) but the projection pair
i, j of 6.12 is mapped to the same kind of projection pair T(i),
TCj).     A monotone functor is continuous on domains iff whenever
E is a domain, then the mapping

            ,V. T CV) : lV I VoolE)           ~    lV' 'V' <JT(E)}

is approximable.       0

<!-- page 107 (pdftotext) -->

104

       ~e   can now state an existence theorem that covers in
fairly wide generality the examples of this lecture.



THEOREM 6.14,      If the functor T is continuous on maps and
monotone and continuous on domains, and if there is a set r
such that
                          {r} <l T {{rl},

then there exis ts an ini t ial T-algebra.

       Froof:     We proceed as in the proof of the fixed-point
theorem by iterating the functor.               The assumption about r
means that, as a neighbourhood system, T({r}) is a system oyer
the sal1!e set r. Thus, if we iterate T to form TnC {I'}). all
these systems are over r and indeed
                          T"{{r)} <lTn + 1 ({rl}

for all n.      We can thus introduce
                                  00


                         V =     UTn {{r l} ,
                                 n=O
and it is easy to check that V is a system over rand
                           T" ({rl) <lV

holds for all n.        But then we have for all n:
                     T"{{r}) <IT''+I({r}} <l T(V},

which imp! ies V <I T CO) •            But T is continuous on domains. so

                 T(V}   = T(      o
                                 n"'O
                                         T"({r}}}

                            00


                           U T"+1 ({r))
                           n=O

                           V •

<!-- page 108 (pdftotext) -->

                                                                                           105
Thus, not only          is VaT-algebra. but the isomorphism we get
for D and T(V)          is just the identity mapping.                     We know by 6.9
that homomorphisms exist; what remains to show is that homomor­
phism from '0 are unique. As in the examples, we will show in
effect they are             determined uniquely on the finite elements of V.

      Since each Tn((r}) <iV, there are projection mappings
            i       : Tn ((r)) ~ D and j              ; D ~ Tn ((n) .
                n                                 n

Define P n : V ... 'O by P '" in I> in' Projection pairs are always
                          n
pairs of strict mappings (Why?). and so are in the category.
By assumption and 6.13, the functor T preserves these maps, so
we have
            T(P n ) :: Te i n )      I>   TUn) '" i n + l   I>   i n +! = Pn+l
As a neighbourhood relation Pn can be characterized by
            XP          Y    iff 3zeTn((r}). XSZSY.
                    n
We thus see that            Pn~Pn+l       and



                                U
                               noD
                                     On = IV'


      Now suppos e k: T(E) -+ E is any T-algebra and h : '0-+ E
is a homomorphism.             The mapping will satisfy the fixed-point
equation

                                h = k 0 T(h).

where no other mappings need be written in because '0= T(O) and so

                                T(h) ; D ~ T (E)        •

We wish to show that h really is the least fixed point of this
equation.

      Define h = h " On : V -+ E. For n = 0, the map Po is the
               n
trivial map where 0o(x) =.i for all xE 1'01. But h must be
                             V
strict, so hO(x) =.i for all xE IV!; that is, h is the least
                      E                            o
element of IV-+l.E I. Now calculate:

<!-- page 109 (pdftotext) -->

106

                         k 0 T(hnJ         k 0 T(h) 0 T(P )
                                                         n

                                           h " 0n+l

                                           hn + 1 .

This shows that the union of the h                     is the least fixed point of
                                                   n
I.h.koT(hJ.     But
                          00          00



                         Uv U
                         n=O         n=O
                                           h" On

                                            00



                                     h"    UIOn
                                           n=O
                                     hoIV=h,
so the given h is in fact the least fixed point. The homomor­
phism is uniquely determined, and V is the initial T-algebra. 0

      Having the existence of initial T-algebras. we can prove
one more result that shows just how minimal they are. We need
a lemma about projection pairs. first. that shows where 5uh­
domains fit it.         We write V:;gE as ShOTt for '0 2!! '0' for some
'O'<JE in the following.            The lemma gives a converse to 6.12.



LEMMA 6.15.      For two neighbourhood systems                  f)   and E.   if there
exist a projection pair

                               i : V .. E and j : E .. V

with j oi=I         and ioj£IE. then V';lE
                V
       Proof.         What we want to show is that i maps £inite ele­
ments to finite elements, and that the desired V'                         is the image
of V in E.

       Suppose Xe V.           We can write:

                        i(tX) = UltYIYE i              (tX)}.

Applying j    to both sides we have:

<!-- page 110 (pdftotext) -->

                                                                                          107

                  tX=joi ('X) = U{j(,y) lYe i('Xl)·
But then, since         XE t X, we find Xe j (+ Y) for some ye i (+ X).
This implies

                  t    X ~ j (+ Y) ; and   50   i (t X) ~ i   CI   j (+ Y) stY.

Since t Y s:: i (+ X) in any case, we conclude i (+ X) '" + Y.                    This
proves finite e1ements are mapped to finite elements.

       What of..6.; that is, what is i (+ ..6.)? We find, supposing
 E to be a neighbourhood system over a set ..6.'. that since
 +A sj (tA'), then i (tA)stA' and so i (tA) =tA'. This means
 that A corresponds to A'. So we have established that V is in an
 inclusion preserving one-one correspondence with a subset V' of E
'Where A' E V'.  But it remains to show that V'is a neighbourhood
 system and that V' <J E holds. All we really have to show is that
V'is closed under intersection whenever the intersection belongs
to E.

        Suppose Y', Z'ED' andY'nZ'EE.                  Let X'",Y'nz'.               We have,
for suitable Y, Z EV,

                             i(+Y) =+Y', and so +Y==j(+Y');                   and
                             i{+Z)==+Z', and so tZ=j(+Z').

Bu ttY' s; + X'       and j (+ Y' ) =: j (+ X' );    thus Y E j (t X' ).          For
similar reasons ZEj (+X').              But then X=YnZEj(+X'), and
therefore Y n Z E V.            (The element j (+ X')     must be a filter.)
Notice, however.         that
                             t Y s; + X, and so + Y' £ i (+ X) ; and
                             tZstX, and so +Z'£i (+X)
It follows that 'Y'n Z' == X' E i(+ X).             On the other hand we already
knew XE j (+ X'),       which implies i(+ X)::. + X'.              We may thus con­
clude that i(+ X) = + X'             In other words X' E V'.             0

<!-- page 111 (pdftotext) -->

108

THEOREM 6.16.  If on the category of domains and strict approxi­
mable maps the functor T is continuous on maps, and if V is an
initial T-algebra, then for any system                                     E~T(E)       we have V'$IE.

        Proof:   There is a homomorphism h: V ... E.                                     By    6.9 there is
a homomorphism g : E . . . V.           Now g "h : V -+ V is also a homomorphism,
so g" h:: IV because V is initial.                                  In view of 6.15, all we have
to prove now is that h " g S IE'

        Let the maps i : TeO) -+ V and j : V ... TeO) give the isomor­
phism for V, and let u: T(E) ... E and v: E ... TeE) do the same for
E.    By the proof of 6.9 we know

                          g = i " T(g) "v and h = u " T(h) " j

and each of these maps             is        the least fixed point                            of its
respective equation.               Let

                          go= ",~v                and          hO="v ~ E

and define by recursion

                    En ... != i" T (En) "v and h n + 1 = u" T (hnJ "j.
By the fixed-point calculation

                    g =     0
                           n"'O
                                    gn            and          h '"       0
                                                                          n"'O
                                                                                 hn ·


        Now we see that

                          hO   0   go            lE ... E'
and for each n that

                 h n + l " gn+l "'U" T(h n ) .. j .. i c T(gn) .. v
                                      '" U   (I   T(h )            (I   T(gn) .. v
                                                     n
                                      '" U ..     T(h          c    gn) .. v.
                                                           n
But this means that
                                             ~


                          h .. g '"
                                         U
                                         n"'O
                                                  (h
                                                       n
                                                           0   g )
                                                                    n

is the least fixed point for the equation
                          k=uoT(k)ov.

But IE is one of the fixed points; whence he g.::: IE must follow.                                            0

<!-- page 112 (pdftotext) -->

                                                                             109


                                   EXERCISES

EXERCISE 6.17.     What are the algebras for which C is initial?
If A of 6.2 is a    generalization of         a, what is the corresponding
generalization of C? Prove that it exists and explain what aTe
the algebras involved.


EXERCISE 6.18.     With reference back to Exercise 3.16 discuss the
construction of    V'" as an initial algebra and as a solution to
the domain equation
                         vOl> <!! V X V"" •

(I do not know whether all solutions must be of the form V'" x E.)



EXERCISE 6.19. For the sake of uniformity restrict attention to
systems Von sets a={O.n*, where Ae1::J.. and ~lfV. and to the
category of strict maps. Define sum and product by:
       Vo + V1    ((A}UO"OUO"1) U (OXIXEV o }U{1YIYEV 1 1.

       V xV     { (A) U 0 X U 1Y I X E V 0 and Y E V1 }.
        o   1
Are these correct up to isomorphism? Now generate all con­
structs T(X) formed by the constants (that is, 1'(X) = V for a
fixed V), by the    identity (T (X) = X), and by sums and products
(TO(X) +T (XL etc.) Show that these are all functors, contin­
         1
uous on maps, and monotone and continuous on domains.



EXERCISE 6.20.     For any system V let tok(V) be the underlying
set of tokens, so that V is a system over tok (0).             For the
category of Exercise 6.19 show that the function

                        "f. tok{T ( (O) )
is continuous on the domain {rS {O,1}·!AEr}, where T is any
of the functors generated in 6.19.            Conclude that there must
exist a set
                        f : tok(T ({f})) •
so that {r} <l T( {rn J and so 6.14 applies.

<!-- page 113 (pdftotext) -->

110

EXERCISE 6.21.      Do the same as 6.19 and 6.20 when the functors
are also allowed to be generated by the operations:
 V o" V • ({A)uo a uta 1 ) u (OXI XEV ' (a )) u (1YIYEV ' {~1))
       1          o                  O    O            1
 V 0 '" V 1 • ({A)UOaOU 1a 1 ) U ({A}UOXU1Y I XEV 0' laO) and YEV   l'   {a )) •
                                                                           1

Generalize all of +, x. EEl, Q to combinations of several terms,
not just the binary sums and products.


EXERCISE 6.22.     Comment on these domain equations:
                 N"'{(O).{O.A)) .. N.

                 M'" ({A)) + M.

                 N+"'N III (N",N+).



EXERCISE 6.23.      Construe the initial solution to

                 Exp ~ N .. «(E,p x E,p) + (E,p x E'p))

as a "syntactical domain" of e.rpreSSi01'lB generated from infin­
itely many "variables" by means of two binary "operation symbols".
Given an algebra V with two operations
                 u : V )( V ... V and v : V x V ... V

show how any strict map        5 :   IJ .... V determines a unique map

                 vales} : Exp .... O
that can be regarded as the "evaluation of an expression".


EXERCISE 6.24.      Show that there must exist domains satisfying:

                      V:!! V + (V x El. and

                  E:!! V + E.
by using a double fixed-point method. First decide what the
underlying set of tokens should be, and then define V and E
by simultaneous fixed points. (Syntactical domains as in 6.23
may very well require several simultaneous equations.}

<!-- page 114 (pdftotext) -->

                                                                                111

EXERCISE 6.25.      For a projection pair g: D ..... E and h: E... V
show that for xE 1'01 and ye lEI we have:

               g(x)SY iff xSh(y).

Thus, conclude that:

               hey) = U{x E IVllg(x) Sy}. and

               g(x) = n{yE IEllxSh(y)}.
for all xE 1'01 and ye lEI.         So each of the functions determines
the other. In the first equation check that the set on the
right is directed, and in the second equation that the set on
the right is non empty. Prove also that g maps consistent sets
to consistent sets and preserves              U (not just directed unions).

EXERCISE 6.26.     For systems D as in 6.19 define
               V~ = {{A} U Oll} U      (OXIXEV).

Describe the construct in terms of elements.                 Is this a suitable
functor?      Prove that

                           Dl.EElEl.::!!D+E.

What is
                           Dl.@   fl.!:!"?1



EXERCISE 6.27.    Which of the following relationships are true:

                           (V.H) ;J (Vx E)         D:9VxE
                           (V EB E) ;J (V + E)     V;JVEBE
                           (V ~~ E) ;J (V~ E); O;JVllH ?



EXERCISE 6.28.  (Suggested by G. Plotkin).              Show that i f V and E
are finite systems and
                           V:jE;JV
then V2! E.   Need the same be true of infinite systems?

<!-- page 115 (pdftotext) -->

112
EXERCISE 6.29.    Generalize    +   and x to infinitary operations on
domains:

                  =                  =
                  L Dn    and        IT Dn
                 n"'O               n ;0


Would a similar generalization be possible for Etl and e ?

<!-- page 116 (pdftotext) -->

                                                                                        113



                                               LECTURE VII
                 COMPUTABILITY IN EFFECTIVELY GIVEN DOMAINS


       For the domain N the strict functions from N into N, the
strict maps f: N ... N ,correspond exactly to the partial functions
g: W .... lN   (as we wrote in 5.6 we had f = g).                   For such functions
there is a standard theory of computability:                        g is called comput­
able if it can be defined as a partial recursive function with
its "program"          written down in a certain standard form.                  The
non-strict maps h:        /oJ ...   N are all constant, and so are intuitively
computable; so we know all about computable maps in IN .... N I in
general.       The question is:               what are the computable maps on
(elements of) other domains?

       The answer will of course depend on how the domain is presented
to us.       Even with N. there are continuum many isomorphisms n:,IJ ... ~
of N onto itself, not all of which can be computable.                        That is, if
we permute N and,       so to speak, present t-he integers in a different
order, then a well-behaved computable function f : N .... N may "'ell
be trans formed in to a non-computable func t ion,
                        n 0 f       0   n -1 : N .... N.

(Hint:       Consider the characteristic function e of the even numbers.
Take f "'"   e and let n be very horrid.)                  The reason we imagined we
knew which were the computable f: N .. N is that 1J is always thought
of in a standard presentation.                         We must thus define "in general"
a concept of an effeotivel.y given dol1t1in.                 that is to say. one with a
sufficiently computable presentation to represent the additional
knowledge about the domain.

       The main idea will be that the finite elements of IDlshould
be regarded as the ones initially known.                        Abstractly, to know a
finite element is       to know how it is rel.ated to other finite elements.

<!-- page 117 (pdftotext) -->

114

Of course, this will mean that we will allow at most a countable
infinity of finite elements - but this restriction well accords
with intuition.       To make precise the terminology "related to"
it proves most convenient to go back to the neighbourhoods (in
any case they are in a one-one correspondence with the finite
elements) •



DEFINITION 7.',      A neighbourhood system V has a r:omputabLe
presentation provided we can wIi te

                     V' {XnlnEJNJ,

where the following two relations

        ( i)   xn n Xm    X ;
                           k
                                   and


        (ii)   3kE}l. Xk~Xn and Xk!;X
                                   m
are recursively decidable (in integer indices       fl.   m, k and in
n, m. respectively).       0

        More strictly the sequence,
                          <X > m
                               n n==O'
is    the presentation.    Even more strictly. when it     is required to
cope with infinitely many domains at a time, it would be neces­
sary to gi,ve the actual GBdel numbers of the recursive relations
(i)   and (ii)    (rather than just saying there exists some way of
showing them to be recursively decidable).

        The intuitive idea of 7.1 is that the system is effectively
given if you know how to do elementary "calculations" with neigh­
bourhoods.       The basic calculations are the forming of inter­
sections.      The neighbourhoods have to be laid out      in a systematic
way; and, if we are asked for an intersection of two given
neighbourhoods, we have to be able to locate it in the standard
sequence.      Relation (ii) is the consiste~y conaition ,which is the
necessary and sufficient condition for the intersection to exist
in V.     When (ii) is true. therefore. we have only       to try k=O,1,2 •
.•• until we discover that we have found the intersection.              We are

<!-- page 118 (pdftotext) -->

                                                                                        115
assuming that these basic decisions can be carried out in
"finite time".  Note that the obvious biconditional,
                    X      SX       iff X n X :: X ,
                     n          m        n   m    n
assures us that           the inclusion relation between neighbourhoods is
itself decidable in terms of the indices.            So in (ii) if k exists,
then   it {or the         first one) can indeed be found in finite time.
The rub is that           if it does not exist, no finite number of inclusion
checks will determine that fact.                     That is why we have to assume
that (ii) is always decidable.                     The information contained in
(ii)   is a fundamental part of the neighbourhood structure. (An
axiomatic characterization of neighbourhood structures is
given in Exercise 7.13.which may make clearer what we are
assuming and what a presentation is.)



DEFINITION 7.2. Given two recursively presented domains,
            v = IXn I nE IN) and              E = Om I mE IN ) ,

an approximable mapping f : V .... E is said to be compu.table                iff the
relation

                                    xn fY m
is recursively enumerable in nand m.                      0

     The question to ask first is why .trecursively enumerable"
rather than "recursive tl ('=' tlrecursively decidable tl )? The answer
will become clear when we let V degenerate to the one - element
domain,    V'=' {tt..}.      Then what we are considering is merely a single
element

                          y = f (I "}) E I E I •

Therefore, 7.2 incorporates the notion of acomputabte eZement of a
domain.    And the condition reduces to the statement that the
filtel' yE lEI is such that the set

                          ImElNlYmEy}
is a recursively enumerable set of integers.                       The point is that
the elements of I E I are finite or infinite.                      If y were finite,
the set of indices above would indeed be recursive in view of

<!-- page 119 (pdftotext) -->

116

OUT    assllmptions on E.    But an infinite element can in general
only be approximated "a little at a time".       We cannot expect to
know the whole story of its approximations in a flash. What it
means to be recursively enumerable is that there is a primitive
recursive function (hence, a totaL     function) J r: N -+:N. such
that

                            y=IYr(i)1 iEN}.

That is to say, aU the approximations to y can e'lJen-tuaUy be
listed. In the case of the mapping f we could write

                            f=((Xs(i)' Yr(i) lliEN),
for a suitable pair of primitive recursive functions       5   and r.

        Definitions 7.1 and 7.2 may very well irritate the person
hearing them for the first time:        instead of explaining com­
putability in direct terms, the whole question is thrown into
the lap of reCursion theory: There are several answers. "You
have to start somewhere" is one thing I always say. Recursion
on the integers is a well-understood theory. and we shall not
need the refined parts of the development. fortunately.     In any
case, our definitions apply to rrany domains of qui te different
structure, not just to the domain N. And the next step we shall
take is to show how to build up computable functions (and also
effectively given domains) from simpler ones. Thus. often it
will not be necessary to go"back to the seemingly over-precise
definitions involving the indices but to appeal to some broad
general principles.


PROPOSITION 7.3.  The identity map on an effectively given domain
is computable; the composition of computable mappings on effect­
ively given domains is again computable. 0

       The proofs for 7.3 are so trivial they are hardly worth an
exercise. Note the immediate and useful consequence: if
f: V .... E is computable and xE IV! is computable. then f(x) E lEI
is also computable. The next result is, however. worth working
out eVen though it is quite easy.

<!-- page 120 (pdftotext) -->

                                                                                  117
THEOREM 7.4.          1£ VA and '0           are effectively given, then so are
                                         1
                               (V
                                    o + V,) and (V OxV 1 ).
Moreover the combinators in i and out i and prOj~ are all CO~­
putable; further          if f and g are computable maps. then so are
f + g and f x g.

        Proof:        Let the computable presentations be given as:

                               Vi={X~lnEW}.
We can assume that the sets of tokens dO and d 1 are disjoint
and (/J(f Vi'    Then     the construction of the sum is just

                        V 0 + V,=       {"o u ",) U V 0 u V, •
As an enumeration we define for nEW

           Zo = "0 U ", ;           Z2n+1 -- XnO            Z2n+2 '" Xn
                                                                       1

We leave as an exercise the check of 7.1(i)-(ii).

        For the product we want:
                                             o       ,
                          Vox V 1 '" {Xu U X
                                                     m
                                                         In. m E :N}
What ..... e then need are recursive functions p: :IN ... :N, q: W .. :N ,
and r: ]'oJ x W ... }II     where for m, n, ke :Nwe have:

  p(r(n, m)) • nand q(r(n, m)) = m, and r(p(k), q(k)) = k.

Thus r is a "one-one pa1Tlng function"; there are many ways
to find such functions (see Exercise 5.13). We can then define
for k E :N :
                                    o            ,
                          Wk = Xp(k) U Xq(k)

Again we leave as an exercise the check that this provides a com­
putable presentati.on of Va x V1 ­
      As for the combinators. the neighbourhood relations have
to be worked out in terms of the indices. For example

                  n ina Zm iff either m = a or for some k
                 XO
                                              o    0
                                          m = 2k + 1 and Xn      =kX


            Wk proji X~ iff X~(k) £ X~
The reader needs to check that these are recursively enumerable

<!-- page 121 (pdftotext) -->

118
relations in the indices. For this purpose it may be conveni­
ent to recall some closure properties of these relations:
taking conjunctions, disjunctions, substituting recursive
functions, applying an existential quantifier to the front. 0

              Products give us a way of providing an immediate meaning
to the notion of a computable function of several variables.
Note that the proof of 3.7 is "effective" and shows that
substitution of computable functions of several variables
into each other always gives computable functions.                         We turn
next to the function spaces.


THEOREM 7.5.             If Va and '0            are effectively given,   then so is
                                        1
(V       ~    P1)'    The combinators eva' and curry are computable.
     O
provided all the domains involved are effectively given. The
computable elements fE 1'0 -+'0 1 are exactly the computable maps
                          0    1
£:OQ<V"

             Proof:    The proofs of 3.9. 3.11, and 3.12 were set up with
this theorem in mind.              If

                     Va' {Xn!n E N} and V                = (YmlmE N)
                                                     1
are two effectively given neighbourhood systems, then the
neighbourhoods of (Va -+ '0 ), by Definition 3.B. are non-empty
                                        1
in tersections like


                                 n
                                 i<q
                                        [X
                                             n
                                                 i
                                                     , y
                                                           m
                                                           i
                                                               l ,

where <nO' n , •..• n q _ 1 > and <rna, m , ...• mq _ > are two finite
            1                            1           1
sequences of integers determining the choice of the function-space
neighbourhood.             In 3.9(i) the test for nonemptiness is given.
Assuming the decidability of relations in Va and '0 1 ' one remarks
that the consistency of finite sequences of neighbourhoods is also
decidable.             (Hint:   Test the first two, then form             their inter­
section.             Next test the third given neighbourhood against this
one set; if consistent. form the intersection. and carryon.)
By 3.9(i) at most 2.2 q such sequential checks must be carried out
to determine whether the function-space neighbourhood is non empty.

<!-- page 122 (pdftotext) -->

                                                                                                  119

It may not be fun. but the checks can be carried out in finite
time.          Owing to this decidability. we can therefore enumerate in
a systematic way aLL the pairs of finite sequences <nO""> and
<rnO J    •••       > that de termine neighbourhoods:                  tha t   is the way tna t
(DO .... V,)        obtains     its enumeration.

          Concerning the decidability of the required relations on
(Va ...   ° 1
                ), we remark first off that consistency is more of the
same:           to test two finite intersections against each other, just
form one big intersection and test it for non-emptiness as
before.              Secondly, the testing for intersection comes down in
the end to testing one typical intersection of [X. Y] - neigh­
bourhoods for equality with another.                            But equality amounts to
two inclusions; inclusion in an intersection amounts to inclusion
in each term.              Therefore. what we need to do is to check a finite
number of statements of the form:


                                  n
                                  1<q
                                          [X .• Y ]
                                            n
                                             1
                                                 m
                                                   1
                                                       S [X k , Ye].


As we pointed out after the proof of 3.9. this inclusion is
equivalent to

                                      nrYm.IXk S Xn . } S Ye·
                                             1           1

By decidability in VO" we can effectively find the n i that are
needed. Then in V we form the intersection of the correspond­
                                  1
ing Y           •     Finally ~       we check the inclusion.            Again. one check in
          mi
(V
     o .... V,)      requires     a whole sequence of checks in Voand in V"                   but
the process is fini teo                      So we have argued that (V o .... V ) is
                                                                               1
effectively given.

          In showing that the combinators are computable, we refer
first to the proof of 3.11.                        The typical pair of neighbourhoods
possibly belonging                    to eval is


                         .n[X         .• Y .] UX k eval Y{.
                                  n       m
                         1<q          1      1


As we needed not to be so specific. we expressed the holding of
this relationship in terms of aU                             the functions in the function­

<!-- page 123 (pdftotext) -->

120
space neighbourhood. But we know that the neighbourhood, by
3.9(ii), has a minimal element; it is then sufficient to test
for the holding of X f 0 Y! at this minimal function f O ' But
                    k
this test, we have already seen, is decidable.  So the pairs in
eval actually form a recursive set, not juS! a recursively enum­
erable set; thus, eval is a computable function.

       The case of curry involves three domains and is a bit more
messy.     But again, if the required neighbourhoods are written out
in full, it will be seen that currY,tOa,is computable.               We leave
this minor struggle to the exercises.

       The final statement is an easy consequence of the fundamental
connection between approximable f : V
                                                 o ~ V 1 as relations and as
elements.            Recall, as in the proof of 3.10, that we have

                 fE [ X, YJ   iff     X f Y.
for all XE V
                 o and YE V 1 •     Therefore,

         fE
              l<q
                 n   [X n .' Ym· 1 iffvi<q.Xn fY m
                          1    1             i    i

It follows that if f is recursively enumerable as              a set of pairs,
then, by forming all the non-empty intersections              (as shown), we
get an enumeration of all the neighbourhoods to which f belongs;
and this is the same as the filter corresponding to f as an
element of the function space.             The converse direction is clear. 0

       We have nearly all our favourite combinators computable,
but perhaps the most important one - since it is the key to
recursive definitions - is the fixed-point combinator.                It is
not left out.



THEOREM 7.6.         For any effectively given domain 0,       the combinator
fi x : (D ~ V)      V is computable.

       Proof:    Referring back to the proof of Theorem 4.2 and
thinking of

                        V={Xn[nE!'i}

as effectively given. fix as a relation Comes down to

<!-- page 124 (pdftotext) -->

                                                                                      121

nIXn.'Xm] fix X.e.   iff for some finite sequence
l<q   1   1          .6,;X k       J   •••   ,X);:       =-X!
                               a                     p
                     we have, for each j<p,

                     n   (Xm.IX x . '" XnJ'" Xx. 1
                            1    J      1      J+

Inside the "for some finite sequence" all the checks are decidable
by assumption on D. But the existential quantification of a
decidable predicate always gives a recursively enumerable predicate.
(And, as there is no implied bound on the she of the finite sequence
'We are looking fOT. this really is                       an enumerable set and not
generally a recursive set.)                  0

       The major consequence of what we have done up to this point
concerns typed h - calculus.       Any expression involving onlY~ffect­
ivel.y given types and, perhaps, some basic computabl.e constants using
only the A. : -notation defines a computable function of its free
variables. And such functions applied to computable arguments
give computable values. And such functions have computable least
fixed points. Et:c .• etc.       In a definite sense then we have in the
"metalanguage", as people say, a quite precise and fully nnthennt­
ical. progranrning language for defining computable operators. It is
not a machine implemented language,but it is a mathematically
well-defined and easy-to-use language. And when we combine the
usual type-de fin i t:ion faci Ii ty together with domin equations J we
have an especially powerful language.



PROPOSITION 7.7.   For any effectively given domain V, the domain
V§ is also effectively given, and all the combinators of
Example 6.1 prove to be computable.

     Proof: This proof is essentially an exercise. but it is use­
ful to have an easy-to-grasp example. Indeed, to make things
easy to reason about, we can assume that V is a system over !J.:::::N
and that in the presentation where

                         V={Xn!nEll),
the relation k E X is recursive in lc and n.  (It is worth .thinking
                  n
why this is so.)    Of course, a lot of other things are recursive
also.

<!-- page 125 (pdftotext) -->

122

      Now what kind of a system is V§?            The cons t ruction of
6.1 made it a system over a certain set of strings                  r.     FOT
the sake of checking various assertions about computability,
we are transposing everything back to :IN.             (These are all denum­
erable sets in any case.)      The set r is divided into three equally
big parts, and "':e can do the same        for~.      Let us write for any
m, kE}J and subset Xs:!N:          mX+k; {m.n+k I nEX}.
Then by splitting the integers modulo 3 we have:
               IN =3I'1u (3lN+ 1) U (3lN+2),

and this equation is quite analogous to that for               r.        We then
propose this definition for V§

      VI=llN}U 13XIXEVlu{(3X+l)                 U (3Y+2)IX,YEV§),

but this does not make the enumeration of V§ all that obvious.
This is one way to do it:
      V = IN       V 2n+1 = 3X n        V 2n + 2 = (3V p (n) + 1 ) U (3V q (n) + 2).
       o
Here p and q are the inverse of the pairing functions mentioned
in 7.4 They must be chosen so that p(n)"'n and q(n)"'n for
all n E l'i. Thus, in calculating V where k = Zn+Z we will be
                                   k
uSlng \p(n) and Vq(n) where both subscripts are strictly less
than k, This observation is required so that mE V is going to
                                                   k
be a recursive relation. What we claim is that
                        V§ = IV        I kElN).
                                   k
It should be clear that everything on the right belongs to V§
What needs an inductive argument is that everything in V§ is
eventually of the form Vk • But this should be fairly obvious
OWing to the properties of r: :IN x:IN ++:IN.

      The reader also has to check that 7.1(i)-(ii) hold for
the Vk , The idea is that any such check is either (1) trivial, or
(2) something already assumed about V and the X , or (3) can
                                               n
be thrown back to some sets V with strictly smaller subscripts.
                             m
Therefore, the checks will give an answer in finite time accord­
ing to an effective reduction.

      Next for the combinators. we have to translate neighbour­
hood relations into relations among integer indices. A selec tion
of examples must suffice.
                    Xn(AX.X§) Vk iff VZn +1        =Vk

<!-- page 126 (pdftotext) -->

                                                                                   123
       V proj Vk iff k =: 0o
         m                 or 3nE:N. m=2n+2
                                       p    and V ( ) c Vko
                                                   n -

The reader should write out other cases.                 0



EXAMPLE 7.9.       We have often made reference to the powerset PlN
as a domain and we should check here that it is effectively
given.     One easy way to see this is to note

                           p N ~ IT"",.

The (slight) trouble with          P:IN   is that we usually think of it
in terms of el.ements rather than neighbourhoods.                 Going back to
Exercise 1.16, we can argue that the neighbourhoods of PW are
ordered not like       the finite sets of integers but in the partial
ordering eonvel'se to that.          But this is of no trouble, since
all will be decidable.         What we need first is an enumeration
of all finite sets of integers.               We can do this by:
                                              k            .    k  . k+l
                   En = {k I 3 i. j . i < Z       and n =: 1 + 2 + J • Z }•

The idea is tha t      kEEn means that the exponent k does occur in
the binary expans ion of n as a sum of powers of 2.                 All finite
subsets of :N are of the form E •                 We then find that as a
                                          n
neighbourhood sys tem

                    (P:I') •   (N \ En I n EN) .

As the relationship En U Em = Eis recursive, there is no trouble
                             k
in proving that this is a computable presentation.  In this
system, of course. any tloiO neighbourhoods are consistent.                   Various
combinators on PlN       are suggested in Exercise 7.23.            0



 We end this chapt er wi th an example of another kind of domain
construct.   This construct is known as the smyth Power Domain.         It is defined
for any neighbourhood system V and resul ts in a new system we
shall call here lP V.       The elements of IP V behave rather like
sets Of elements   of V, but since our elements can be either partial
or total, there are certain dangers to pushing the analogy too
far.   For some purposes a rival construct called the PZ.otkin Power
Donuin is better, but i t leads outside the category of neighbourhood
 systems as defined in these lectures.               Do not confuse PW with
JP V.

<!-- page 127 (pdftotext) -->

124

DEFINITION 7.!.         Let V be any neighbourhood system and define
           If' V =   {U
                     i<n
                         (+ X.) I ~ i < n. X. E V} •
                              1                 1


We recall that for any X E V
                     + X = {Y E V I Y S; X} •
The finite unions in PD can be empty (i.e. if 0=0).                   0

      Formally, the system lP V is just more or less the closure of
V under £ini te unions; however. this would not be an isomorphism­
invariant construct unless V is "prepared".                The preparation
consists of replacing V by the isomorphic domain

                           V+={+ xlxEV}.
(In this connection refer back to Exercise 1.20.)                 We remark that

          .. X n. Y:I= rp iff (X, Y} is consistent in V,

and in that case
          + X n .j. Y     +(xnY).


PROPOSITION 7.10.The power domain lP V is a neighbourhood system
if V is, and it is effectively given if V is.

      ~oof:     The system V+ is a neighbourhood system as we just
remarked; indeed it is a positive neighbourhood system.                   It is
easy to prove that the closure of any positive system under finite
unions is a neighbourhood system, because the resulting family of
sets is closed under          an finite intersections.         (If we left out
the empty union, the result would be a positive system.)                  The
proof is obvious since intersection of sets distributes over
finite union.        So P V is a neighbourhood system.

      For the second half of the proposition, we just have to
constructivi2ethe preVious argument.                Thus, if

                        V = (XnlnEN),

then the elements of 1P V can be written as:


                        U
                        l<q
                              (Un.),
                                  1

<!-- page 128 (pdftotext) -->

                                                                                         125

and hence aTe indexed by the finite sequences <nO' •. '. n _ >
                                                          q 1
of integers. Now one of the standard devices of recursion theory
is to put the finite sequences of integers into a recursive ane­
one correspondence wi th the integers themselves.                        This is the
start of the recursive presentation of 1P V, since it means we
can list effectively all the required neighbourhoods.

     Next consider an intersection


      I I UX n )
     ~q       1
                    n   U
                        j<T
                                 (+X
                                       m
                                        J
                                         )        U <e Xn . n Xm.lJ
                                                  l<q     1
                                                  j <r

Some of the terms which are ¢ have to be thrown out - but this
requires only a finite number of decisions all computable by
assumption.        Now we have to rewrite

                        Xn.   n Xm . = Xk . . •
                          1       J       1 J

but the finding 0 £ k ij is also computable. FinaUy. we have to
re-order the doubly indexed sequence into a singly indexed sequence
of length q.r. but this is easily seen to be computable also.
Therefore, intersections can be "calculated".

     It remains to be shown that equality between neighbourhoods
in lP V is decidable.         The question really comes down to deciding
something 1 i ke:

                         i- Xk     S     U
                                        i<q
                                              +X n . .
                                                  ~

Now since X e + X • we find that the above is just equivalent to:
           k     k
                         3 i < q. Xk £ X .
                                        n
                                                      1

By our assumptions       on V, this is decidable.                (It is this part of
the argument that       required the passage to V+.                   It does not seem
to be generally true that the closure under finite unions of
an effectively given system is again effectively given.)                         0

     One of the main reasons that lP V is like a power domain is
the possibility of forming "finite sets".

<!-- page 129 (pdftotext) -->

126
DEFINITION 7.11.       For elements x ' .•.• x n _ 1 E IV' we define
                                     O
    {x O' ... ,xn_1)=(ZEIPVI3XoEXo···3Xn_1Exn_1             .UCHi)SZ}.
                                                            l<n

(Note, we could also wyite vi < n,X E Z).               0
                                   i


PROPOSITION 7.12.        The mapping
          )., x O' ••• J x n _ 1 , {x o •..•• x _ 1}: Vn .. lP V
                                               n
is approximable and is computable if V is effectively given.
Moreover. the map)., x. (x} shows that V:;jlP V, and we also have
the law:

            {x O' " ' , x n _ 1 } = {xO) n··· n (x n _ 1}
as an intersection of filters.

      Proof:    The second part shows that everything reduces to
>..x.{x}.   We see that

       X (Ax. {x»)U (' X . ) iff 3 i<q. XksX . •
        k        l<q
                        n1                  n1

Thus J >.. x. (x) is an approximable mapping and is computable in the
effectively given case.

      The proof of the law can be reduced to the special case
                     {x) n {y} = {x,y)

for the sake of illustration.            In terms of finite elements of the
two domains V and lP V we find

                      {+X) ~ HX ,
and so.

               {+X) n {tY) - HX n HY
                             ~   t (H U • Y)
                             -{tX,tY}.

An equation between approximable functions that checks for finite
elements also holds for all elements.


      Finally, we note that

                       V'" V' <l ll' V

<!-- page 130 (pdftotext) -->

                                                                                    127
and that the isomorphism involved is just AX. {x} by what 'We
saw on the finite elements.               0

        Further combinators on the power domain are given in the
exercises.



                                 EXERCISES

EXERCISE 7.13.  Show that an effectively given domain can always
be identified with a relation
                    INC L (n, m )

on integers. where the two derived relations
        CONS(n,m)           iff 3k. INCL(k,n) and INCL(k,m);
MEET (n,m,k)        i££ Vj [INCL (j,k) iff INCL (j,n) and INCL(j,m)]

are both recursively decidable. and where the following axioms
hold:

        (il     vn.INCL(n,n);

        (ii)     Vn,ro.k. INC L (n,m)         and 1 N C L (m,k)   imply INC L (n,k)

        (iii) 3m \In.       INC L (n,m)

        (iv)    viJ.,m.    CON S (n.m)    implies 3k. ME E T (n,m,k).

(Hint:        Consider     the neighbourhood system

                 v = ({rn E IN I INC L (m,n) J I n E IN ).
Is this essentially any effectively given system?)


EXERCISE 7.14.            (For recursive-function theorists.)           Prove the
statements after definition 7.2 about the existence of primitive
recursive functions for showing things recursively enumerable.
(Recall that a non-empty set is r.e. iff it is the range of a
primitive recursive function.)                 Show also that every computable
element yE lEI can be written

                           y'   U(tYt(i)liE~J,
where t : :N .... :N      is primitive recursive and where we may assume

<!-- page 131 (pdftotext) -->

 128

                                  )'t(i+1) S )'t(i)

 for all i E }l' •



 EXERCISE 7.15.          Finish the proof of 1.4 and establish similar
 reSults for the constructs (V 0 0V,), (Vo@'O,) and 0"".                 Take
 into account the various appropriate combinators.



 EXERCISE 7.'6. Let Vo={XnlnEN}, V,={Ym!mEJ>ll and
° 2
    '" {Z,,!kEN} be three effectively given domains.  Complete
 the proof of 7.5 by writing out curry as a relation between
 neighbourhoods.  Is it a recursive set or only a recursively
 enumerable set?

 EXERCISE 7.17.          Complete the proof of 7.7 for showing

that V§ is effectively given 1£ V is.                   Include all the comb ina­
tors of 6.2.         Prove also that if E is effectively given and

                    u : V .... E and v : E x E .... E
are computable, then the unique strict mapping

                          g :    V § -+ E ,

where, for xE 1'01 and Y. zE lEI

             g (in (x))         = u   (g (x)) . and

              g (pair (Y,,))            v (g(y), g (z)),

is a computable mapping.



EXERCISE 7.18.          Two effectively given systems V and E are
effectiL'el,y wOI1II::rpphic    iff ... (complete the sentence: J.     Show
that if V is effectively given then the isomorphism
                               vO:>~(vQ»O:>


is effective.

<!-- page 132 (pdftotext) -->

                                                                                        129
HERCISE 7.19.                   Prove that'D f- il V is a functor by defining fOr
each f : V -+ E a mapping
                                         IPf:IPV~IPE


by the formula

   Un.
   i<n     1
                      IPf        U+Y.J iff vi<n3j<rn. X.fY.J
                                 j<m                           1


Be sure to check that lP f is approximable and that lP preserves
identity maps and composition. If f is computable is P f?                          Is
there a combinator A£.F f? What is

                                         II' f({x,y» = ??



EXERCISE 7.20.                  Show that there is a combinator

                  union         lP(IPV)-+lPV

. . . here fOr suitab1e neighbourhoods

u (U
i<n
      +
          j <ro
                  i
                      iX .. )
                           1)
                                 union     U iY k iff Vi<nVj<rni3k<q'XijSYk'
                                           k<q

Is union computable if V is effectively given?                           What is

                  union ({{xl, {Y,z}}) = ??
Are IP (IP V) and lP V generally isomorphic??



EXERCISE 7.21.                  Is there a non-trivial combinator of type
                  II' (V    ~   E)   ~   (lP V ~ lP E) ?

Are there in general any isomorphismsbet.. . . een the systems
                  (V + II' E), II' (V x E),         lP V x lP E ??

Is there a non-trivial combinator of type
                  lP (V x E) x lP (E x f)           +   lP (V x f) ???

Is there any connection between
                  lP Nand P ~              ????

<!-- page 133 (pdftotext) -->

130

EXERCISE 7.22.          (For algebraists.)      Let E", {O,n • be the free
semigroup.        A ne.. . . domain is constructed by defining       a family
of sets by the least fixed point theorem as follows

           S=(E}C{{o} 10E E}u{XYIX,YE SJu

                  {XnYIX,YES andXnY"Ii'J.

He re we !iTi te:

           Xy= {o-rloEX and "tEY}.
Prove that S is an effectively given. positive neighbourhood
system.    (Hint:        The sets in S are each "regular events" in the
terminology of automata theory, and we have a decision method
for the set algebra of regular events.)                  Define mUltiplication
on IS) by

           Xy"'{ZES13XEx3YEy.                XY,=Z}.

and show lSI becomes a semi group with t embedded into lSI by
the homomorphism 0 1_ {XE sloE X}.  Investigate some infinite
words in S, say those defined by least fixed points such as:

           (; '" 0 (;   and    (5 '" 00.

Are these equations true:

           00=0,000=0,0101=01,

           and     01 D1 OT 51 = t1 01 ?


EXERCISE 7.23.          Complete the discussion of PlN of
Exampl~   7.fl.         Show that the combinators fun and graph of
Exercise 5.14 are computable.              Also do the same for

           ,l. x. y. x n Y. A x, y. x U y,    and,l. x, y. x + y ,

whe re for x. yEP IN          we define

           x + y = {n +m I n E x and m E y} .

What are the computable elements of PN               ?

<!-- page 134 (pdftotext) -->

                                                                              131

EXERCISE 7.24.      (Suggested by the LUCID language of Ashcroft
and Wadge:     SIA.M Jour. Comp. yolo 5 (1976).)        Define a set r   by

                      r· UC!i}XrJU(*J.
                          i=O
Define a system
             L = (r} U{(i} x X liE N     and X E L).

Show that L is effectively given.            Show that the elements of I L f
can be iden!i fied with the finite and intioi te sequences of
natural numbers.      What is the connection between Band L?
Show that the combinators of LUCID can be construed as computable
mappings of type
                         (L~TJ ~    (L~T)

or of type
                     (L~T)   x   (L~T)   ~   (L~T)


Conclude that programs in LUCID define computable maps.

<!-- page 135 (pdftotext) -->

                                                                          133



                                          LECTURE VI II
                      RETRACTS OF THE UNIVERSAL DOMAIN

      In order to be able to have a fully flexible Illethod of solving
 domain equations and to be able to see why the domains obtained
 are effectively given, we shall embed all the desired domains in
 one "largest" domain. This universal domain will be easily shown
 to be effectively given. and the mappings needed to extract the
 other domains wi 11 be found to be computable.  In order to be
 able to carry out this programme, we investigate first how certain
 subdomains correspond to mappings - the so-called retracts. An
 advantage of this analysis is that all t'he necessary definitions
 can be written out in A - calculus notation, thus demonstrating the
'power of our mathematical programming language.


 DEFINITION 8.1.     A ret:ruction of a given domain E is an approximable
 mapping a: E ... E such that a 0 a '" a.    CJ

PROPOSITION 8.1.       If V<1 E and if a : E ... E is defined by
               Xa Z     iff       3 Y EV.          XSYS-Z

for all X,ZE E, then a is 8 retraction and IV I is isomorphic to the
fixed-point set of 8) the set {yE lEI! a (y):::: y}, under inclusion.

     Proof: Tha t a is an approximable mapping is a direct consequence
afDefinition 6.10. Indeed, in the notation of Proposition 6.12,we
have
                        a:::: i .. j.

and this is another proof that a is approximable.            This remark is
also convenient, since we know from 6.10

                              j 0 i:::: Iv •
 Therefore, we find:
             a o a - i ..        i .. j        i .. j "" a
 and so a is a retraction.

     We can also employ i and j to give the isomorphism on IVI.
 If xE lVI, then i (x)E If I and we calculate:

<!-- page 136 (pdftotext) -->

134

               a (i (x) ) •    i   0   j   0   i (x) • i (x).

Thus>     i{x) belongs to the fixed-point set of a.                          In the other
direction, if a(y) "'" y, then i(j (y)) = y.                        But j (y) E I V I. so i
maps I VI one-one and onto the fixed-point set of   3.  As i and
j    are monotone. the map is an isomorphism with respect to S. o

       Not every retraction comes from a relationship like V <I E;
in fact, we can see from the definition of a above                             that a!: IE"
But. as is indicated in Exercise 8.11 • even this condition is
not sufficient to characterize the kind of retractions provided
by 8.2. The characterization is as follows.



DEFINITION 8.3.        A retraction a                 E ... E is called a     pl'ojection
provided
                               asI E ;
it is ~ni~y iff its fixed-point set is isomorphic to a domain.C


EXAMPLES 8.4.         If a system V over li. is not trivial. then the
two element system 0 = {{OJ, {o.H) comes from a retraction
on V.     Specifically, define a combinator


                          check: V ... O

    by the relation

              X check Y       iff either Y= {O,n or X*.6..

                    iff x = .lV.
We see check(x) ::::.1                               We leave to the reader the
                  0
definition of a combinator:

                         fade:OxV ... V

where we have for tE 101 and xE IVI:

                         fade (t,x) = .lV' if t "'.1
                                                                0
                                               =x,    if not.

Now, take any uE IVI with u¢.l, and define

                         a(x) • fade (check(x). u).

Then a is a retraction (not a projection in general) and the
range of a is isomorphic to O.

<!-- page 137 (pdftotext) -->

                                                                                         135
              Another way of using these combinators is to find
(0 ....       £)    as a retraction of (0 .... £).         Specifically. define a
          1
combinator
                                  str;ct: (V~E) ~ (V~E)

by the equation

                                  strict(f) :;'x. rade (ched(xJ, f(x)),

where this time
                                  fade       0 x E-f E •

The range of strict consists exactly of the strict functions
and this time strict is a projection whose range is indeed
a domain.

              Similarly,      we can find a projection on V x E with a range
isomorphic to V ~ E by the combinator such that:

                   smash(x,y):: fade (check.(xJ,fade (check.(y),<x,y»),


fOT X E            I V I and y E IE\.    0




THEOREM 8.5.                For an approximable mapping a : E .... E the following
are equivalent:

          (i)        a is a    finitary projection;

          (ii)       a(x) = {YE E 13 XE x.           XaX~Y}.       for all xE lEI.

      Proof:            Suppose a satisfies (ii) first.              Inasmuch as

                    XEX and     X~Y     always imply YEx.

for all xE lEI, we see a(x)s:x must always hold.                          Moreover, it
is obvious that

                    X E x and X a X always imply X E a(x);

therefore, a(x) s: a (a (x))                   for all x E I El.   This shows that a

<!-- page 138 (pdftotext) -->

136

is indeed a projection.

     Let V'" {xe E 1 X a X} J then it is easy to check that V '<:1 E
and that a is determined from V exactly as in 8.2;      thus, the
fixed-point set of a is isomorphic to a domain, by what we have
already proved. So we have shown (ii) implies (i).

      In the converse direction. assume that a is a finitary
proj ection. And let the system V be isomorphic to the fixed
point set of a. We have the situation of Theorem 6.15. There
is a projection pair.
                         i ; V - f E and j : E - f V,

where the connection with a gives:

                 j   0   i =   IV   and i   0   j .. a s: IE'

By 6.1.5 Vii!! V' <l E and we want to identify V I in terms of a as
follows:

                         V' = (X EEl X a Xl •

~ow from a reading of the proof of 6.15 the neighbourhoods of
V' are just those corresponding to the finite elements of V.
But any such element is a fixed point of a. We have

             XE V'       implies aCt X) .. t X implies X a X.
Conversely, if XaX holds, then tX5a(tX).                        But a   is a projec­
tion, so t X is a fixed point. But i(j (t X) ) .. t X lI1eans j (+ X)
is a finite element of IVI. So XE V'. and we have '0' identified
as desired.

      Finally, if we calculate a'" i • j by the formulae of 6.12
(with V' for '0, of course), we obtain our formula (ii).                     0

     The criterion for being a finitary projection just obtained
provides us with a very interesting new combinator.


THEOREM 8.6.     For any domain f define
      sub;   (E~El ~ (E~El

by the formula

       X sub (fl         Z   iff 3YEE.          XSYfYSZ,

<!-- page 139 (pdftotext) -->

                                                                               137

for all X. Z E E and all f: E ... E.        Then the range of sub consists
exactly of the      finitary projections on E, and mOreover sub itself
is a finitary projection on (E ... E).              If E is effectively given,
then sub is computable.

      Proof:    It is trivial to check that subef) is always approx­
imable. Also,       it is obvious from the definition that the corre­
spondence
                               f    I- ,"b(f)

preserves directed unions of f's.               Thus, sub is itself approximable.
We note that

            X,=Y £ YSZ always implies X fZ;

hence, sub(f):= £ holds.           Also

            Y fy always implies Y sub (f) Y,

hence, sub(f) ~ sub (subef})          hold~This     shows sub to be a proJec­
tion on (E ... E).     The effectiveness of the definition makes it
also clear that      sub is cO'/ll[!utable "'hen E has a computable present­
ation.

      Since, sub     is a projection. its range is the same as its
fixed-point set..      If

                            sub (a) '" a,

then there is no problem in checking that a satisfies 8.S(ii)
and COnVel'Be"ly.    So the range of sub picks out exactly the finitary
projections in view of B.S.

      Finally. to prove that sub is a finitary projection of
(E .. E), we invoke 6.1' and remark that, in view of 8.2, the fixed
point set (range) of sub is in a one-one inclusion-preserving
correspondence wi th the domain {V I V <t E}.            0

      These resul ts have almost completely translated the theory of
<l- subdomains into ).,- calculus via the sub-combinator.           One last
step will comple te the passage, and then we shall be able to
return to solving domain equations.

<!-- page 140 (pdftotext) -->

138

DEFINITION 8.1.          Let <l! be the set of rational numbers, and let

               [0,1) = {qE~                  I O<;Q<1l,
and similarly for [r, 5) for any r < 5 in <11..       The neighbourhood
system U o....er [0,1) is the set of all non-empty finite unions of inter­
vals of rational intervals [T. 5) with 0< r< 5 <1.                                      0


        A picture of a typical element of U could be drawn like this:




                    o        TO         T,             T
                                                        2
                                                               T
                                                                   3   T.       T5


Note that any union can be taken as a diajoint union of the form


                                 U      [T 2i , T2i • 1 )
                                 i<n
where O( TO < T
                    1
                        <T
                             2
                                 < ••• < T
                                             2n < T 2n + 1 < 1.        (Hint:        Any overlapping

intervals or abutting intervals can always be combined into one
long interval.) It is a most elementary exercise to show that, by
virtue of this representation, the system U has a computable
presentation.           (Some isomorphic versions of U - equally effective
-   are recorded in the exercises.)                         Note that U has no minimal
neighbourhoods:          every set in U can be wri tten as                           the union of two
disj oint sets in U.               (Hint:       Use the densi ty of the ordering of
<I!.)   The significance of U can now be explained.



THEOREM 8.8.        The system U is universal in the sense that, for
every countable neighbourhood system V, we have

                                       v j U.
Moreover, if V is effectively given, then the projection pair
making the embedding can be taken as computable.                                     Indeed there is
a correspondence between effectively presented domains and the
computable, finitary projections of U.

        ~of:   As    V is countable, we can assume that
                                       V={XnlnE:N},

<!-- page 141 (pdftotext) -->

                                                                                            139

where V is a system over a set d (say, Xo " A). We shall do the
effective and general cases together, where for the latter all
remarks on recursiveness are just left out.                       So, if we want V
effectively given. the above enumeration should be taken as the
computable presentation.

      Without loss of generality we can assume 05""0"', since other­
wise we would just replace V by V+                       The advantage of this pre­
paration is tha t unions in V· keep things rather                        sepa1"ate   (as we
noticed in cons tructing lP 0).                  In particular, we can be sure of
this equi valenc e:

       Ct)            X   s I I X                iff     3 id.
                       m        i":rlc   ni                               ,
                                                                 Xm S X n .


This property, £or example, fails for the system U as presented
in Definition 8.7.          However, that observation is of no moment.
because we are employing the assumption with respect to V not                              U.

      The reasOn     for the assumption is this:                  for 6E {+.-} define
forXEV:

                          6X=X                if6"'+
                                =d\Xif6=­

(A similar notat ion will be used for yE U.)                           Then for 6E {+ ,_}n
the sets of the      form


                          n
                          i<n
                                  6 i Xi      (= X • for short)
                                                  6

form a partition of ~ into (at most) Zn parts.                          The reason for
assumption (t)     is that we can effectively decide for each
6E {+,_}n whether one of these intersections is empty or not.
(Why? - assuming      that V is effectively given, of course).                        If
for some reason we had not wanted to pass to Vi, we could have
made this stronger assumption of decidability on the (positive)
system V.    (U, for example, satisfies ito)

       Suppose. co r responding to X o ' X , '" , X _1 • we have selected
                                          1        n
YO'   Y1' •.•• Y -   ~ E U so that. for all 6E {+,-)D,

       CO)
                n 1
                   no., ,
                   l<n
                            X. : '/'       iff     no; ,
                                                   i<n
                                                            Y•• '/'.

<!-- page 142 (pdftotext) -->

140

We wish to show - effectively - how to choose Y corresponding
                                               n
to Xn • so that (.) holds with n-t1 replacing n. Proceeding in­
ductively, we obtain a recursive enumeration of sets Y E U so
                                                       n
that

                                     P",(Y       InEIl}.q            u.
                                             n
Clearly the isomorphism (matching X. to Y.) will be computable
                                                           1              1
and the projection is computable.                          (It will then remain only to
consider the arbitrary finitary computable projection to complete
the 'proof of the theorem.)

        So, consider Xn; for each oE {+,-:fthere are four cases:

             X nX              I{J           Xo n-X n          I{J
              o   n
             X nX
              o   n
                          ., I{J             Xo n-x n     '" I{J

Corresponding to X is a similar intersection Yo"  If Xc were rp,
                  o
then Yo would be also. If not, YeS [0,1) is a union of rational
intervals that can be written do.... n explicitly.                            (Why?)   In our
four cases on X , the first implies the fourth. (Why?)                                 Thus, we
               n
need only make some choices in these circumstances:

                  X.I: n X "" rp             : choose I.I:u,n = rp ;
                      u        n
                  Xo n- Xn '" ¢ : choose Io,n'" Yo;

                  otherwise                  : choose Io,n~Yo' with rp+J 6 ,n*'Y o ·
All these cases are decidable by assumption on V,                               and the effective
choice of (unions of) intervals is effective by construction of U.
Now set

                          Yn           U
                                      OE {+,-}
                                                     n   Io,n l ¢

The set Y E U. it can be found effectively, and (-) is obViously
         n
satisfied for n+1

        Finally, suppose that a is a computable, finitary projection
of U.     As we have seen in the proof of 6.5, the domain correspond­
ing to the range of a is isomorphic to the neighbourhood system

                                     {Y E U      I YaY} <l U.•

<!-- page 143 (pdftotext) -->

                                                                                                                      141
Clearly. if a as a set of ordered pairs of neighbourhoods is
recursively enumerable, then the above set is also recursively
enumerable (because equality between neighbourhoods is deddable).
It follows eas ily that the subsystem is effectively given as a
neighbourhood           system in its o.. . n right.                            0

      We have now proved that U is a nice and big domain that is
nicely behaved with respect to computable mappings.                                                       It has some
very interesting subdomains; to name a few:

               u+u,            U~U.           UxU.               U0 U

               UU~              U§       WU             U        U
                 .1 )      •         •            •         0+


That all of these are :j U follows from knowing that they are all
effectively presented.                        What we wish to check next is that they
all combine well with respect to projections.                                                    To this end the
explicit definitions are given for the constructs +, x, and ..... and
the details of the others are left for the exercises.



DEFINITION 8.9.                Let the computable projection pairs

                           i + : U + U... U and j +                     U ... U + U

be fixed.        Simi1arly choose ix' jx                               and i ... , j ....       for U x U and U .... U.
Define:

  a+b = cond 0 <which, i+ 0 1n o 0 a 0 out o .' i+ 0 1n                                         0   b 0 out, > 0 j+
                                                                                            1
  axb=ixo<a o projo.b o p ro 9 1 > ojx;

  a ...b = i .... 0 (>.. f. b 0 f    0   a)   0       j ... '

for all a. b :U_ U.                  0


       These interesting(computable:)combinators on elements of
U .... U have many,many properties.                                  We shall, however, only see what
they do to projections.



PROPOSITION 8.10· If a, b: U .... U are projections, then so are a+b.
axb, and a....b.        I f a and b are finitary, then so are the others;
for the fixed-po i nt set of each of them is isomorphic to the
corresponding construct applied to the domains determined by a
and b.

<!-- page 144 (pdftotext) -->

142
        Proof:      Suppose that a, b S I                      (= I for short).    Then
                                                         U
                               a+b S       I + I = i+ " j+ OS I.
The other cases are similar.

        Suppose a == a 0 a and b:::: bob, then, for example,

  (axbJ 0 (axb) = i x 0 <3" projo' b" proj1>" <3" projo' b oproj1>" jx

                        == i x " <3 "    a" projO' b " b <> proj1 > " j X
                        ::: a x b.

The other cases are similar.

        Now in case the fixed-point sets of a and b are domains. they
are respectively isomorphic to
              Va = {X E U I X a X} and

              Vb = {Y E U I Y b Yl •


We have to show, for example. that

                 Va.... VbS!!D a ... b •

Now to simplify matters, remark. that the fixed-point set of a .... b
on U is isomorphic to the fixed-point set of ~ f. b " f" a on (U -+ U) •
(Hint:      use i .... and j .... to set up the isomorphism.)                     So we have to
think what it is            fOT      an f : U .... U to satisfy

                                      f=b=f=a.

Notice that we might as well say that a: U --Va and that this map
is the other half of an obvious projection pair Where

                                      ia:Va-+U.

            a = a and a" i
                                     a =i a
and i                                                 So if g :Va-+V , let
        a                                                           b
                                      f = i       G   g " a.
                                              b
then b" f" a = f.            Conversely, if f is like this,                   then let

                                      g '" b " f "i a .
Thus. i b " g " a '" b f" a'" f; so there is an order-preserving isomor­
ph ism be tWeen the g : Va'" Vb and the f '" b " f " a.

<!-- page 145 (pdftotext) -->

                                                                                                      143
        The isomorphism proofs for                     +        and   ~     are similar.   0

        iI.'ell, this was a lot of work, but the pay-off is rather
handsome.     What . . . e have done is transpose all the
                                            Va <! U
over to finitary projections a: U .... U.                             This transposition is an
isomorphism, because
                                    V       <1V       iff         as:b.
                                        a         b
Moreover. by the method of 8.9 and 8.10 .. atl. our favourite con­
structs have bean made into combinators. that is, approximable ­
even computable - maps on the domain of fini tary projections.
ALL APPROXIMABLE (COMPUTABLE) MAPS HAVE (COMPfRABLE) FIXED POINTS. And there
you   are~   Tjle standard fixed-point method is available to obtain
computable (i.e. effectively given) solutions to aU domain equations
(even sets of equations) where the constructs can be reworked in
this way to be defined on projections. Examples are suggested in
the exercises.

        Another pay-off concerns the}" - calculus itself.                                      Inasmuch
as
                                u+u,           U><U,            U ... Us, U.

we might just as well forget the outside world and regard all these
useful domains as being part of U. For example. on the left we
have the new notation and on the right the old notation:
              which       (z) =         which(j.(z))

               in i       (x)   ~       i+(ini(x)),                i ;; 0,

               out        (x)   ~       out i (j +(x)). i;; 0.1
                      i
                < x. y>         ~
                                        i >«<x.Y»           j


              proj i      (z) =         proji (j x(z)),i              0    0,

                      u (x) -           j.(u) (x);

                }" x. "t        =       i .... (:Xx. "t).

And. there is no          reason to stop here.                            The system
              T'" ([0,1/2),[1/2,1),[0,1)) <1 U ,

so we might as we 11 think of

<!-- page 146 (pdftotext) -->

 144

                        true, falseE lUI

and think of cond: UxUxU ... U.        No! that is wrong:        under the new
regime EVERYTHING IS AN ELEMENT OPU.    With the new meaning of A, all
functions, all pairs, all combinators, all constructs become
e7,ements of U.

       It takes a little time to get used to "universal conscription"
with all elements doing (at least) double duty in the same domain,
but there are many advantages, both notational and conceptual.



                           EXERCISES

EXERCISE 8.1'. Let ~ be the set of rational. numbers and define a
neighbourhood system by the equation
             R • ([ O. r) IrE ~ and   a< r "   1).

Show that the following defines an approximable map a: R ... R

             [O,r)a[O,s) iff r<s or r::s=1.

Show in addition that a is a projection where the fixed-point set
of a is in a one-one correspondence with the real. numbers between
o and 1 inclusive.      (Hint:   Recall Dedekind cuts and show 5" matches
<.)    Conclude that a is NOT finitary.        (Hint:   Aside from 1. there
areno finite elements for {xIx'" a(x)}.)




EXERCISE 8.12. Gener:llize the notation 2X+1 for subsets XSJll'
to sets of the form

                     2 k X +l, where l < 2 k •
                                                        k
Let V be the non-empty fini te unions of sets 2             :N -+i.   Show that
U ~ V and that the isomorphism is effective, thus obtaining another
presentation of U.



EXERCISE 8.13.  (For logicians.) Prove that the universal domain
U is isomorphic to the domain of all proper filters of the free
Boolean algebra on ~o-generators (= the Lindenbaum algebra of
propositional calculus).  (For topologists.)  Connect this

<!-- page 147 (pdftotext) -->

                                                                                   145
representation of U wi th the collection of non-empty open subsets
of the product space Z:N (= Cantor space).


EXERCISE 8.14.      A retraction a :-0 .... 0 is called a closure opel"atoZ'
iff Ipsa.       On a domain like P:N. give some examples of closure
operators.      (Hint: Close up a set of integers under addition.            Is
this continuous on P:N 1) Prove in general for any closure
a: V .... O that the fixed-point set of a is ah.ays a finitary domain.
(Hint: Show that the fixed-point set is closed under intersec­
tions and directed unions.)        What are the finite elements of the
fixed-point set?



EXERCISE 8.15.     Give a direct proof that the domain {X I X <IV}
is effectively presented if V is.         (Hint:      The finite elements of
the domain correspond exactly to the finite systems X<] V.)                   In
the case of V::: U, show that the computable elements of the domain
correspond exactly to the effectively presented domains (up to
effective isomorphism).



EXERCISE B.16.     For finitary projections a          E .. E. write
                          V.=(XEE      I X.X}
(cL B.5.).     Show that for any two such projections a, b :E .. E
we have

                          asb    iff   Va <I   Vb'

(This fills in the gap at the end of the proof of B.6.)                Also
finish off the proof of 8.8 by shOWing that if E is effectively
given and a: E .. E is computable, then Va is effectively given.



EXERCISE 8.17.    Find explici tly (if possible) the projection pairs
for U + U, U x U, and U -+ U needed for 8.9.         Are any of these domains
isomorphic with U?       (The author does not know a really good con­
struction for U -+ U.)    Find a universal domain        V~ U.

<!-- page 148 (pdftotext) -->

146

EXERCISE 8.1 e.        Many of the cases of 8.10 were left unproved.
Please establish these assertions explicitly.


EXERCISE 8.19.         Suppose we know both

                           T and E ~ E :8 E •

Does it follow that E + E and E)( f                S E?


EXERCISE 8.20.         For any system we know V "1 V + V, but ...., hat about

                   V   :s V )( V and V ;S V .... V ?
Would these projections be computable if V is effectively given?
Are there more than one projection pair in each case?


EXERCISE 8.21.         Using the fixed-point construction, show that
there is a continuous and computable operator A a. a§, such that
if a is a finitary projection of U, then

                               v § ~ (V a ) §
                                 a

EXERCISE 8.22.         Which of the two relations hold;

                              B S C or C :8 B ?

Or do they both hold?          In general if we use domain equations
                              V' T(V) + S(V). and
                              E = T(E)

will f   ~   V hold?     What projections do you see in the examples in
6.2?



EXERCISE 6.23.         Suppose a construct T on domains can be made into
a computable operator t : [U .... U) -(U .... U) so that whenever a : U .... U
is a finitary projection, then so is tea) and

                               Vt(a) " T(V a )·
Does it follow that II til = fix.(t) is such that
                                V           S   T (V           )
                                    lltll              lltl1

<!-- page 149 (pdftotext) -->

really is the    initial solution of the domain equation with respect
to projections?     Since t is computable, . . ; ill this solution be
effectively   g~ven?




EXERCISE 8.24.     Suppose Sand T are two (binary-argument) con­
structs on domains that can be made into computable operators on
projections of the universal domain.               Sho~'   that we can therefore
find a pair of effectively presented domains such that

                  v " S(V,E) and EaT (V,E) •



EXERCISE 8.25.    The problem is to find non-trivial solutions to
the domain equa t ion

     (' )                 V=:-V-+V.

8how that the "obvious" solution by retracts is of no use because

                          1-+1"'1

for projections.     Change the method as follows.               Show first
                         uO> x uO> ~ uC:O

Next solve
                          v~ V    -+   U""

and remark that U .q V ; so V is universal and non-trivial.                   Finally
prove (') for this V.     (Hint:             First show

                          VxV~V,

and then show V satisfies (').) Is this               V effectively given?


EXERCISE 8.26.     Discuss in more detail the "pay_offl! for U, name­
ly the translation of t'untyped" A - calculus into U as shown by
the equations at the end of the lecture after the proof of 8.9.
In particular show how the whole of the               typed   A - calculus can
beretranslated back into U with the aid of projections.                   (Hint:
1';'henever you want to write

                            f:Va-+V b •

<!-- page 150 (pdftotext) -->

148

wri te instead
                                £=bofoa.
where   3, b    are finitary projections.         Whenever you want to form
a A. - abstrac tion
                                     Va
                                AX        0,

where (1 is of type Vb' instead form
                           AX. b(o·[a(x)/x)).

where 0' is the further translation of 0 into untyped ).,- calculus.
Be sure to show that this result Tlhas the right type" in the sense
defined above.)


EXERCISE 8.27.        (Suggested by James Donahue.)          Finite cartesian
 products of domains are formed by the 17 0 x 17 1 - construct we have
 used so often. The problem is to define - computably - some
infinite cartesian products.  In particular, as applied to the
 universal domain U. the combinator sub is to be regarded as a
 finitary projection of U whose fixed points are exactlya~~
 the finitary projections. A map

                               d=subodosub
can be regarded as a polymorphic type (because, whenever t is a
finitary projection (::: type), then so is d(t)).               The continuous
pro~tof all         these types would be the domain of all approximable
functions x such that
                           x(t) = d(t)(x(t))

for all types t.         (Why does this equation mean that x is in the
product?)       Define IT as a combinator by
               II • A d A X At. sub (d (s ub (t))) (x ( sub (t) Jl .

Show that for d a polymorphic type, ned) is a type.                    (Hint:
It is easy to check that ned) is a projection; the problem is to
show it is finitary.)

<!-- page 151 (pdftotext) -->

           PROGRAMMING RESEARCH GROUP TECHNICAL MONOORAPHS

                                    JUNE 1961


This IS a series of technical monographs on tOPiCS in the field of computation.
copies may be obtained from the Programming Research Group. <Technical
Monographs), 45 Banbury Road. Oxford. OX2 6PE. England.


PRG-1       (out of prtnt)

PRG-2       Dana Scali
              Outline of a Mathematical Theory of Computation

PRG-3       Dana Scott
              The Lattice of Flow Diagrams

PRG-4       (cancelled)

PRG-5       Dana Scali
              Data Types as Lattices

PRG-6       Dana Scott and Christopher Strachey
              Toward 11 Mathematical Semantics for Computer Languages

PAG-7       Dana Scott
              Continuous Larllces

PAG-B       Joseph Slay and Christopher Strachey
              OS6 - an Experimental Operaring System for   a Small Computer

PRG-9       Christopher Strachey and Joseph Stoy
              The Teltt of OSPub

PRG-10      Christopher Strachey
              The Vaneties 01 Programming Language

PAG-l1      Christopher Strachey and Christopher P. Wadsworth
              ContinuatIons: A Mathematical Semantics for Handflng Full Jumps

PRG-12      Peter Mosses
              The Mathematical Semantics 01 Algol 60

PRG-13      Robert Milne
              The Formel Semantics of Computer Languages
              and their Implementations

PRG-14      Shan S Kuo, Michael H. Linck and Sohrab Saadat
              A Guide to Communicaling Sequential Processes

PRG- 15     Joseph Stoy
               The Congruanca of Two Programming Language Definitions

PRG-16      C. A. R. Hoare. S. D. Brookes and A. W. Roscoe
               A Theory of Communicating Sequential Processes

<!-- page 152 (pdftotext) -->

PRG-17     Andrew P Black
             Report on the Programming Notation 3R

PRG-18     Elizabeth Fielding
              The Specification of Absfract Mappm(}s
              and thelf Implementation as a-+-rrees

PRG-19     Dana Scott
             Lectures on a Mathematical Theory of Computation

PRG-20     ZhOU Chao Chen and C A. A. Hoare
              Pan/al Correctness of Communicating Processes 8.nd Protocols

PRG-21     Bernard Sulfln
             Formal Specification of   a   Display Editor

PRG-22     C    A. R I-loare
               A Model lor Communlcatin(} Sequential Processes

PRG-23     CAR Hoare
            A Calculus for Total Correctness of Communicating Processes

PRG-2<:l   Bernard Sufrin
             Readm(} Formal Speclfica(ions
