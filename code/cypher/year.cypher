//1. use pmc.cypher to extract pmcs from evidence
//2. use load_csv.cypher to import pmc_year.csv
//3.
MATCH ()-[r]->() 
unwind r.pmcs as p
match (n:pmc) where n.name = toInteger(p)
with r, min(n.year) as min_year
set r.year = min_year;


//method2: take too long
//USING PERIODIC COMMIT
//LOAD CSV WITH HEADERS FROM
//'file:///pmc_year.csv' AS line1
//MATCH ()-[r]->() where line1.pmc in r.pmids
//set r.year = 
//CASE 
//WHEN not exists(r.year) THEN line1.year
//WHEN line1.year < r.year THEN line1.year
//else r.year
//END