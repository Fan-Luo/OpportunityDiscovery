MATCH (c1:Concept)-[r]->(c2:Concept) 
return r.EDGE_DEDUPLICATION_HASH,c1.NODE_TEXT,c2.NODE_TEXT;