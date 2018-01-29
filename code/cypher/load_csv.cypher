CREATE CONSTRAINT ON (p:pmc) ASSERT p.name IS UNIQUE;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM 'file:///pmc_year.csv' AS line
CREATE (:pmc {name:toInteger(line.pmc), year:toInteger(line.year)});