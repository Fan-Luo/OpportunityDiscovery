MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept) 
with c1, r1, c2, r2, c3 MATCH (c1)-[r3]->(c3) 
WHERE toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 AND toInteger(r3.EDGE_YEAR) >= 2007
RETURN count(r3);

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept) 
WHERE NOT (c1)-[]->(c3) AND toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007
RETURN count(r1);

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept)
WHERE toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 
RETURN count(r2);

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept) 
with c1, r1, c2, r2, c3 MATCH (c1)-[r3]->(c3) 
WHERE toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 AND toInteger(r3.EDGE_YEAR) < 2007
RETURN count(r3);


//seen >= 2

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept)
with c1, r1, c2, r2, c3 MATCH (c1)-[r3]->(c3)
WHERE toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 AND toInteger(r3.EDGE_YEAR) >= 2007 AND toInteger(r1.DOCS_SEEN)>=2 AND toInteger(r2.DOCS_SEEN)>=2 AND toInteger(r3.DOCS_SEEN)>=2 AND r1.NEGATED_COUNT = 0 AND r2.NEGATED_COUNT = 0 AND r3.NEGATED_COUNT = 0 AND c1.AVE_IDF >= 1.0 AND c2.AVE_IDF >= 1.0 AND c3.AVE_IDF >= 1.0
RETURN count(r3);

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept)
WHERE NOT (c1)-[]->(c3) AND toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 AND toInteger(r1.DOCS_SEEN)>=2 AND toInteger(r2.DOCS_SEEN)>=2 AND r1.NEGATED_COUNT = 0 AND r2.NEGATED_COUNT = 0 AND c1.AVE_IDF >= 1.0 AND c2.AVE_IDF >= 1.0 AND c3.AVE_IDF >= 1.0
RETURN count(r1);

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept)
WHERE toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 AND toInteger(r1.DOCS_SEEN)>=2 AND toInteger(r2.DOCS_SEEN)>=2 AND r1.NEGATED_COUNT = 0 AND r2.NEGATED_COUNT = 0 AND c1.AVE_IDF >= 1.0 AND c2.AVE_IDF >= 1.0 AND c3.AVE_IDF >= 1.0
RETURN count(r2);

MATCH (c1:Concept)-[r1]->(c2:Concept)-[r2]->(c3:Concept)
with c1, r1, c2, r2, c3 MATCH (c1)-[r3]->(c3)
WHERE toInteger(r1.EDGE_YEAR) < 2007 AND toInteger(r2.EDGE_YEAR) < 2007 AND toInteger(r3.EDGE_YEAR) < 2007 AND toInteger(r1.DOCS_SEEN)>=2 AND toInteger(r2.DOCS_SEEN)>=2 AND toInteger(r3.DOCS_SEEN)>=2 AND r1.NEGATED_COUNT = 0 AND r2.NEGATED_COUNT = 0 AND r3.NEGATED_COUNT = 0 AND c1.AVE_IDF >= 1.0 AND c2.AVE_IDF >= 1.0 AND c3.AVE_IDF >= 1.0
RETURN count(r3);