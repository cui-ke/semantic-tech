#let title = [Exercises on Description Logics]
#align(left, text(17pt)[
  *#title*
])
G. Falquet



#let II = $cal(I)$
#let subclass = $subset.eq.sq$
#let ors = $union.sq$
#let ands = $sect.sq$



= 1. Interpretations and models

1. Prove that the DL expressions

  / E1 = : $forall r . (C union.sq D)$ 
  / E2 =: $(forall r.C) union.sq (forall r . D)$

  are not equivalent by finding an interpretation $cal(I) = (C^II, D^II, r^II)$ such that $"E1"^II != "E2"^II$.

2. Find an interpretation $II$ that satisfies the following axioms:

  1. $A equiv forall s.L$,
  2. $L subclass (exists r.A) ands (forall r.(exists s.top)),$
  3. $L(u)$

3. Find an interpretation $II$ that satisfies the following axioms:

  1. $A subclass forall s.L$,
  2. $L subclass (exists r.A) ands (forall r.(exists s.top)),$
  3. $L(u)$

4. Find an acyclic interpretation that satisfies the above axioms.

== Solutions

1. With the interpretation $Delta^II= {a,c,d }, C^(  II}= {c }, D^II= {d }, r^II= {(a,c),(a,d) }$ we have

  $A^II=( forall r.(C union.sq D))^II= {a }$ and

  $B^II=(( forall r.C) ors ( forall r.D))^II=(( forall r.C))^II union ( forall r.D))^II = emptyset union emptyset = emptyset$ 

2. An interpretation that satisfies the axioms:  $Delta^II= {u, a}, L^II= {u}, A^II= {u, a}, r^II= {(u,a) }, s^II= {(a, u) }$. Note that $u$ must be in $A^II$ because it trivially satisfies $forall s.L$.

#import "@preview/diagraph:0.2.0": *
#let renderc(code) = render(code.text)

#renderc(
  ```
  digraph {
    rankdir=LR
    node [shape=diamond]
    u 
    a
    node [shape=ellipse]
    u -> a [label = "  r"]
    u -> A [label = "instance of"]
    u -> L [label = "instance of"]
    a -> u [label = " s "]
    a -> A [label = "instance of"]
    
  }
  ```
)

3. A minimal interpretation that satisfies the axioms:  $Delta^II= {u}, L^II= {u}, A^II= {u}, r^II= {(u,u) }, s^II= {(u,u) }$


#raw-render(
  ```
  digraph {
    rankdir=LR
    node [shape=diamond]
    u
    node [shape=ellipse]
    u -> u [label = "  r"]
    u -> A [label = "instance of"]
    u -> L [label = "instance of"]
    u -> u [label = s]
  }
  ```)
)

4. An acyclic interpretation:  $Delta^II = {u_1,u_2,...,a_1,a_2,... }$, $L^II= {u_1,u_2,... }$, $A^II= {a_1,a_2,... }$, $r^II= {(u_1,a_1),(u_2,a_2),... }$, $s^II= {(a_1,u_2),(a_2.u_{3}),... }$. This interpretation is infinite.

#renderc(
  ```
  digraph {
    rankdir=LR;
    node [shape=diamond]
    u1 u2 u3 [label="...", shape=none] a1 a2 
    node [shape=ellipse]
    u1 -> a1 [label = " r"]
    a1 -> u2 [label = " s"]
    u2 -> a2 [label = " r"]
    a2 -> u3 [label = " s"]
    
    
  }
  ```
)

== 2. DL Logical consequences

*Source:* Rudolph, S. (2011). Foundations of Description Logics. Longman Publishing. http://www.aifb.kit.edu/images/1/19/DL-Intro.pdf 

Consider the knowledge base  $cal("KB")$ with

#let HCO = $sans("HappyCatOwner")$
#let Cat = $sans("Cat")$
#let Dead = $sans("Dead")$
#let Alive = $sans("Alive")$
#let Healthy = $sans("Healthy")$
#let owns = $sans("owns")$
#let caresFor = $sans("caresFor")$

RBox 

- $sans("owns") subset.eq.sq sans("caresFor")$

TBox 

- $Healthy subclass not Dead)$
- $Cat subclass Dead ors Alive$
- $HCO subclass exists owns . Cat) ands forall caresFor . Healthy$

ABox 

- $sans("HappyCatOwner")(sans("schrödinger")) $
- $sans("Cat")(sans("hbar")),$
- $sans("owns")(sans("schrödinger"),sans("psi")), sans("owns")(sans("schrödinger"),sans("hbar"))$

Decide whether the following propositions about the knowledge base are true and give evidence: 

1.  $cal("KB")$ is satisfiable, 

2.  $cal("KB") models sans("Alive")(sans("schrödinger"))$,

3.  $cal("KB") models sans("Dead") sect.sq sans("Alive") subset.eq.sq bot$ , 

4.  $cal("KB") models sans("Alive")(sans("psi"))$,

5.  $cal("KB") models sans("Alive")(sans("hbar"))$.


== Solutions

1. $cal("KB")$ is satisfiable , with the model $cal(M)$ defined as

  - $Delta^cal(M)={s,h,p}$
  - $sans("schrödinger")^cal(M)=s$, $sans("psi")^cal(M)=p$, $sans("hbar")^cal(M)=h$,
  - $sans("Cat")^cal(M)={h,p}$, 
  - $sans("HappyCatOwner")^cal(M)={s}$
  - $sans("Healthy")^cal(M)={h, p}$,
  - $sans("Alive")^cal(M)={h}$,
  - $sans("Dead")^cal(M)={}$,
  - $sans("owns")^cal(M)={(s,p), (s,h)}$,
  - $sans("caresFor")^cal(M)={(s,p), (s,h)}$,

2. $cal("KB") models sans("Alive")(sans("schrödinger"))$ is false. For instance in the model $cal(M)$  $s in.not sans("Alive")(sans("schrödinger"))^cal(M)$

3. $cal("KB") models sans("Dead") sect.sq sans("Alive") subset.sq bot$ is false. If we add $s$ to $sans("Alive")^cal(M)$ and $sans("Dead")^cal(M)$ we obtain a model of $cal("KB")$ in which the interpretation of $sans("Dead") sect.sq sans("Alive")$ is not empty.

4. $cal("KB") models sans("Alive")(sans("psi"))$ is false, in the model $cal(M)$ $p$ is not in $sans("Alive")^cal(M)$

5. $cal("KB") models sans("Alive")(sans("hbar"))$ is true. In every model $cal(J)$ of KB $h$ must be in $sans("Cat")^cal(J)$ and in $sans("Healthy")^cal(J)$ because of $sans("HappyCatOwner") subset.eq.sq exists sans("owns").sans("Cat") sect.sq forall sans("caresFor").sans("Healthy")$  so it must be in $not sans("Dead")^cal(J)$ bacause of $sans("Healthy") subset.eq.sq not sans("Dead")$ and hence in $sans("Alive")^cal(J)$ because $sans("Cat") subset.eq.sq sans("Dead") union.sq sans("Alive") $

= 3. Inference 

Use the tableau DL algorithm to show that $( forall r.(B sect.sq C))sect.sq( exists r.(not C))$ is not satisfiable

== Solution

Let's start with the ABox $ {( forall r.(B sect.sq C))sect.sq( exists r.(not C))(a)} $

Applying the $sect.sq$ rule adds
$  ( forall r.(B sect.sq C))(a), \ 
 ( exists r.(not C))(a) $

The $exists$ rule adds

$ r(a,b), (not C)b $

The $forall$ rule adds

$ (B sect.sq C))(b) $

The $sect.sq$ rule adds

$ B(b), \ 
C(b) $

There is a clash between $not C(a)$ and $C(a)$ $=>$ the starting concept was inconsistent.


= 4. OWL-RL inference

Use the OWL-RL inference rules to find the ABox logical consequences of the following knowledge bases

$cal("KB1")$:

  1. $exists  sans("owns") .  sans("Cat") subclass  sans("CatOwner")$
  2. $exists  sans("owns") .  sans("Mouse") subclass  sans("MouseOwner")$
  3. $sans("CatOwner") subclass forall  sans("owns").  sans("Cat")$
  4. $sans("owns(felix, max)")$,   
  5. $sans("owns(felix, illi)")$, 
  6. $sans("owns(marta, chesee)")$,
  7. $sans("owns(marta, bob)")$,
  8. $sans("Cat(max)")$,   
  9. $sans("Cat(bob)")$
  10. $sans("Mouse(cheese)")$

== Solution

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: 0.5pt,
  table.header(
    [*Rule*], [*Applied on (IF)*], [*Infers (THEN)*],
  ),
  [*some*], [1, 4, 8], [11. $sans("CatOwner(felix)")$],
  [*some*], [1, 7, 9], [12. $sans("CatOwner(marta)")$],
  [*some*], [2, 6, 10], [13. $sans("MouseOwner(marta)")$],
  [*only*], [3, 11, 5], [14, $sans("Cat(illi)")$],
  [*only*], [3, 12, 10], [14, $sans("Cat(cheese)")$],
)

So, $sans("cheese")$ is both a Cat and a Mouse 🤔

= Exercise 6. Closing the world 

Consider the knowledge base $cal("KB")$

#let BlueRun = $sans("BlueRun")$
#let RedRun = $sans("RedRun")$
#let SkiRun = $sans("SkiRun")$
#let RedOnlyPlace = $sans("RedOnlyPlace")$
#let Place = $sans("Place")$
#let isEndOf = $sans("isEndOf")$
#let p1 = $sans("p1")$
#let sr1 = $sans("sr1")$
#let isEndOf = $sans("isEndOf")$
#let IsEndOfOnlyOneRun = $sans("IsEndOfOnlyOneRun")$

TBox

1. $BlueRun subclass SkiRun$
2. $BlueRun subclass SkiRun}$,
3. $RedOnlyPlace equiv Place sect.sq exists isEndOf . SkiRun) sect.sq (forall isEndOf . RedRun)$

ABox 

4. $isEndOf(p1,sr1)$, 
5. $RedRun(sr1)$,
6. $Place(p1)$

What must be added to the ABox and/or TBox to ensure that $cal("KB") models RedOnlyPlace(p1)$? Test your answer with a DL reasoner (in Protégé).

== Solution

For example:

7. $IsEndOfOnlyOneRun equiv " " <=""_1 isEndOf . top$
8. $IsEndOfOnlyOneRun(p1)$

