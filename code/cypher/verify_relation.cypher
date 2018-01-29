MATCH (c1:Concept)-[r]->(c2:Concept) 
where r.seen = 1 
return c1 as concept1, c2 as concept2, r.label as relation, r.evidence as evidence;
