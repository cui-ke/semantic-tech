#let title = [Exercises on RDF and RDFS]
#align(left, text(17pt)[
  *#title*
])
G. Falquet


#let number-until-with(max-level, schema) = (..numbers) => {
  if numbers.pos().len() <= max-level {
    numbering(schema, ..numbers)
  }
}

#set heading(numbering: number-until-with(1, "1.1.a."))

= RDF/S Modelling

Write an RDF graph in Turtle, containing an RDFS schema, to represent the following facts

-	The title of film f1 is "The Sixth Hour", the title of film f2 is "What's Next?", and f3 and f4 are films (whose titles we don't know). 
-	Arthur, Ida and Liam are actors. 
-	Bob, Charles, Isabelle and Maya are film characters.
-	A film character is a fictional person
-	An actor is a real person
-	A person can be real or fictional
-	Arthur plays Bob in the film f1 and Charles in the film f4
-	Ida plays Jessica and Maya in the film f2
-	If someone plays a role he or she is real

Your schema must not introduce more than 8 different properties (apart from the RDF/S properties rdf:type, rdfs:subClassOf, rdfs:domain, rdfs:range, ...)

== Solution

```RDF

  :f1 a :Film ; :title “The Sixth Hour” .
  :f2 a :Film ; :title “What’s Next?” .
  :f3 a :Film ; :f4 a :Film .
  :arthur a :Actor . :ida a :Actor .
  :bob a :Character . :charles a :Character. 
  :isabelle a :Character . :maya a :Character . 
  :Character rdfs:subClassOf :FictionalPerson .
  :Actor rdfs:subClassOf :RealPerson .
  :FictionalPerson rdfs:subClassOf :Person .
  :RealPerson rdfs:subClassOf :Person .
  :Film a rdfs:Class .
  :Person a rdfs:Class .
  :arthur :plays [:character :bob ; :in :f1] , [:character :charles ; :in :f4] .
  :ida :plays [:character :jessica , maya ; :in :f2] .
  :plays rdfs:domain :RealPerson .
```

= Relational to RDFS 

A relational database contains information about equipments, rooms and users. The database schema is as follows:

```sql
create table Equipment(
  id varchar(100) primary key, 
  name varchar(100), 
  location varchar(100),
  foreign key (location) REFERENCES Room(id))
  -- constraint: the location of an equipment must be a room with category = "laboratory"

create table User(
  id varchar(100) primary key,
  firstname varchar(100), lastname varchar(100), 
  department varchar(100),
  check (department in ('admin','sales','research')))
  
create table AccessRight(
  user varchar(100), room varchar(100),
  foreign key (user) REFERENCES User(id)))
  foreign key (room) REFERENCES Room(id)))
  
create table Room(
  id varchar(100), name varchar(100), 
  location varchar(100), 
  category varchar(100),
  check (category in ('office', 'laborartory'))
```

Your goal is to put the contents of this database on the semantic web, as an RDF graph. 

1.	Define an RDFS schema (classes, properties, subclasses, sub-properties, domains, ranges) for this database that 

  a)	represents the contents of the database 
  
  b)	represents the integrity constraints of the database
  
  c)	is not a trivial direct mapping where each table is represented by a class and each column is prepresented by a property. In particular the id columns must not be represented by an id property

2.	For each table show on an example how a row of this table will be represented by triples in the RDF graph

== Solution

1. RDFS Schema

```json 
:Equipment a rdfs:Class.
:User a rdfs:Class.
:Room a rdfs:Class .
:Laboratory rdfs:subClassOf :Room
:Office rdfs:subClassOf :Room .
:Department a rdfs:Class .

:location rdfs:domain :Equipment ; rdfs:range Laboratory .
:room-location rdfs:domain :Room ; rdfs:range xsd:string .

:name rdfs:range xsd:string .
-- no domain constraint because it is used for Equipment and Room

:firstname rdfs:domain:User ; rdfs:range xsd:string .
:lastname rdfs:domain:User ; rdfs:range xsd:string .

:department rdfs:domain :User ; rdfs:range Department .
:hasAccess rdfs:domain :User ; rdfs:range Room .

:admin a Department . :sales a Department . :research a Department .
```

2. Translation 

Relational:

```sql
insert into Equipment values ('eq1', 'name1', 'lab1')
insert into Room values ('lab1', 'main room', 'main building', 'laboratory')
insert into User values ('u1', 'Marc', 'Chagall', 'research')
insert into AccessRight values('u1','r1')
```

RDF graph:

```
@prefix . . . 
:equip-id1 a :Equipment ; :name "name1" ; :location :lab1 .
:lab1 a :Laboratory ; :name "main room" ; 
    :room-location "main building" .
:u1 a :User ; :firstname "Marc" ; :lastname "Chagall" ;
    :department :research ;
    :hasAccess :lab1 .
```

= RDFS Modelling

Write an RDF graph in Turtle, containing an RDFS schema, to represent the following facts

-	Tree A01 is an oak tree in Carouge. It was 1.30 m tall in 2001, 2.10 m tall in 2010, 2.22 m tall in 2011 and 3.40 m tall in 2021. 
-	Tree A04 is a maple, planted in 2000, measuring 2.30 m in 2002, 4.15 m in 2007 and 6.30 m in 2010.
-	Tree A55 was planted in 2005 and is located in Versoix.
-	Beech, oak, maple and cherry trees are all trees.
-	One tree was 15.30 metres tall in 2020.
-	Trees are plants.
-	A tree is found in a geographical location.

Your schema must not introduce more than 8 different properties (apart from the RDF/S properties rdf:type, rdfs:subClassOf, rdfs:domain, rdfs:range, ...)

== Solution

```
@prefix . . .

:A01 rdf:type :Oak ; :location :Carouge ; 
  :measurement [:date 2001 ; :h 1.3] , [:date 2010 ; :h 2.1] , 
     [:date 2011 ; :h 2.22] , :measurement [:date 2021 ; :h 3.4].

:A04 rdf:type :Maple; :planting 2000; 
  :measurement [:date 2002; :h 2.3], [:date 2007; :h 4.15], 
      [:date 2010; :h 6.3] .

:A55 rdf:type :Tree ; :plantation 2005 ; :location :Versoix .

:Beech rdfs:subClassOf :Tree .
:Oak rdfs:subClassOf :Tree .
:Maple rdfs:subClassOf :Tree .
:Cherry rdfs:subClassOf :Tree .

_:aaa rdf:type :Tree ; :measurement [:date 2020 ; :h 15.30] .

:Tree a rdfs:Class ; rdfs:subClassOf :Plant .

:GeographicLocation a rdfs:Class .

:place rdfs:domain :Tree ; rdfs:range :GeographicLocation .
```

= RDFS Inference

Consider the following RDF graph (reminder: a is an abbreviation of rdf:type):

```
@prefix : . . .
:LegalEntity a rdfs:Class . 
:Person a rdfs:Class; rdfs:subClassOf :LegalEntity .
:Organisation a rdfs:Class ; rdfs:subClassOf :LegalEntity .
:Work a rdfs:Class . 
:Book a rdfs:Class ; rdfs:subClassOf :Work .

:author a rdf:Property ; rdfs:subPropertyOf :creator ; rdfs:domain :Book .
:creator a rdf:Property ; rdfs:domain :Work ; rdfs:range :Person .
:publisher a rdf:Property ; rdfs:range :Organization .

:abc :publisher :lagarde ; :author :zero .
:dào :creator :dào .
```

What will be the triples about `:abc`, :lagarde, :zero, :dào of the inferred graph generated by the RDFS inference rules? 

#[
#set text(
  font: "New Computer Modern Sans",
) 
#set align(center)
#table(stroke: 0.5pt, columns: (auto, auto,auto),
  table.header(
    [*Premises*],	[*Rule*], [*Conclusion*]),
    [:publisher rdfs:range :Organization \
    :abc :publisher :lagarde], [rdfs3],	[:lagarde a :Organization],
    
    [:Organisation rdfs:subClassOf :LegalEntity \ :lagarde a :Organization	],[rdfs9],	[:lagarde a :LegalEntity],
    
    [:author rdfs:subPropertyOf :creator \
     :abc:author :zero .],       [rdfs7],   [:abc :creator :zero] ,
   
    [:creator rdfs:range :Person \
      :abc :creator :zero	],     [rdfs3],	  [:zero a :Person],

    [:Person rdfs:subClassOf :LegalEntity \
     :zero a :Person],           [rdfs9	], [:zero a :LegalEntity],

    [:author rdfs:domain :Book .\ 
     :abc:author :zero .	],      [rdfs2],    [:abc a :Book],

    [:Book rdfs:subClassOf :Work .\ 
     :abc a :Book],	           [rdfs9],	   [:abc a :Work],

    [:creator rdfs:domain :Work \ 
     :dào :creator :dào .],	   [rdfs2],	   [:dào a :Work],

    [:creator rdfs:range :Person .\ 
     :dào :creator :dào .],      [rdfs3],	[:dào a :Person],

     [:abc :publisher :lagarde \
    abc :publisher :lagarde \
    :abc :author :zero . \
    :dào :creator :dào .	],

    [rdfs4a \
    rdfs4b \
    rdfs4b \
    rdfs4a	],
    
    [:abc a rdfs:Resource \
    :lagarde a rdfs:Resource \
    :zero a rdfs:Resource \
    :dào a rdfs:Resource ]
 )
]





