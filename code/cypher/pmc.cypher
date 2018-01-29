//method1: 
MATCH ()-[r]->() unwind [e IN r.evidence | split(split(e,'http://www.ncbi.nlm.nih.gov/pmc/articles/')[1], '/\">read more</a>)')[0]] as pmc with collect(distinct pmc) as pmcs, r set r.pmcs = pmcs;




//method2:  Gus use the first query, there are some duplicate pmcs; I use the second query to get distinct pmc

//step1:
//MATCH ()-[r]->() SET r.pmcs = [e IN r.evidence | split(split(e,'http://www.ncbi.nlm.nih.gov/pmc/articles/')[1], '/\">read more</a>)')[0]]
//step2:
//MATCH ()-[r]->() unwind r.pmcs as pmc with r, collect(distinct pmc) as pmcs set r.pmcs = pmcs;
 