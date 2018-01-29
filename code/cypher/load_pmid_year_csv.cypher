CREATE CONSTRAINT ON (p:pmid) ASSERT p.name IS UNIQUE;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM 'file:///pmid_year_processed.csv' AS line
CREATE (:pmid {name:toInteger(line.pmid), year:toInteger(line.year)});
