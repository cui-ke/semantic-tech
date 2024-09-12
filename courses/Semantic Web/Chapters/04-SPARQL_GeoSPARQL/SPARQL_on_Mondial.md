
## Exercise

Write SPARQL queries to answer the following questions:

- What are the cities whose altitude (elevation) is more than 3000 meters?
- What are the cities in France (the country named "France")?
- For each city in France what was its population in 2011?
- What are the river that flow through more than one lake?
- For each river what are the lakes it flows into, either directly or indirectly?
- For each river what is the last lake it flows into?
- What are the countries that can be reached from Spain by crossing at least three borders?

## Relevant classes an properties 

### :City 

:population 	
:longitude 	
:latitude 	
:locatedAt 	(links to a :Sea or :River or :Lake)

### :Country

rdf:type 	
:name 	
:carCode 	
:area 	
:population 	
:populationGrowth 	
:infantMortality 	
:gdpTotal 	
:gdpAgri 	
:inflation 	
:government 	
:independenceDate 		
:gdpInd 	
:gdpServ 	
:capital
:dependentOf 	-> :Country
:encompassed -> :Continent
:hasCity 	-> :City
:hasProvince 	-> :Province
:isMember 	-> :Organization
:neighbor 	-> :Country
:wasDependentOf 	-> :Country

### :River

:name 	
:area 	
:length 	
:flowsInto 	-> :Sea or :Lake or :River
:flowsThrough 	-> :Lake
:hasEstuary 	-> :Estuary
:hasSource 	-> :Source
:locatedIn 	-> :Country or :Province

### :Lake

:name 	
:area 	
:longitude 	
:latitude 	
:depth 	
:elevation 	
:flowsInto 	-> :River or :Sea or :Lake
:locatedIn 	-> :Country or :Province
