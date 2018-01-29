match ()-[r]->() unwind r.pmids as pmid
return pmid