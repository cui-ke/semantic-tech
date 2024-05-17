# The Mondial Database (with some additions)

The database home is http://www.dbis.informatik.uni-goettingen.de/Mondial/ . Consult the [E-R diagram](http://www.dbis.informatik.uni-goettingen.de/Mondial/mondial-ER.pdf) for information about the graph content.

The RDF graph in Turtle is at http://www.dbis.informatik.uni-goettingen.de/Mondial/Mondial-RDF/mondial.n3

The file _FlowThrough.ttl_ contains additional triples to represent more precisely the fact that a river flows through a lake. In the original graph we have triples of the form 

    <thisRiver> :flowsThrough <thisLake>
    
However, if a river flows through several lakes there is no information about the order of the lakes along the course of the river. This file defines a class :FlowThrough whose members are typically defined by

    [ a :FlowTrough ; :river <aRiver> ; :through <aLake> ; :seq <sequence no. of this lake for this river> ]
    
