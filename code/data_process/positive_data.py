#!/usr/bin/python3  
#author: Fan Luo

import numpy as np
import string
from collections import Counter  

c1 = np.genfromtxt('positive_data.csv', delimiter=',', usecols=0, dtype=str,skip_header=1)
c2 = np.genfromtxt('positive_data.csv', delimiter=',', usecols=2, dtype=str,skip_header=1)
c3 = np.genfromtxt('positive_data.csv', delimiter=',', usecols=4, dtype=str,skip_header=1)
c1_name = np.genfromtxt('positive_data.csv', delimiter=',', usecols=1, dtype=str,skip_header=1)
c2_name = np.genfromtxt('positive_data.csv', delimiter=',', usecols=3, dtype=str,skip_header=1)
c3_name = np.genfromtxt('positive_data.csv', delimiter=',', usecols=5, dtype=str,skip_header=1)
r1 = np.genfromtxt('positive_data.csv', delimiter=',', usecols=6, dtype=str,skip_header=1)
r2 = np.genfromtxt('positive_data.csv', delimiter=',', usecols=7, dtype=str,skip_header=1)
r3 = np.genfromtxt('positive_data.csv', delimiter=',', usecols=8, dtype=str,skip_header=1)

node_counts = Counter()						#initialize
relation_counts = Counter()
concept_dict = {};
relation_dict = {};

for i,concept in enumerate(c1):		
	concept = concept.strip(' "')						 
	node_counts[concept] += 1
	concept_dict[concept] = c1_name[i].strip(' '); 

for i,concept in enumerate(c2):		
	concept = concept.strip(' "')						 
	node_counts[concept] += 1
	concept_dict[concept] = c2_name[i].strip(' '); 
 
for i,concept in enumerate(c3):		
	concept = concept.strip(' "')						 
	node_counts[concept] += 1
	concept_dict[concept] = c3_name[i].strip(' '); 


for r,relation in enumerate(r1):	
	relation = relation.strip(' "')				 
	relation_counts[relation] += 1
	relation_dict[relation] = c1_name[r].strip(' ')+'\t'+c2_name[r].strip(' ')

for r,relation in enumerate(r2):	
	relation = relation.strip(' "')				 
	relation_counts[relation] += 1
	relation_dict[relation] = c2_name[r].strip(' ')+'\t'+c3_name[r].strip(' ')

for r,relation in enumerate(r3):	
	relation = relation.strip(' "')				 
	relation_counts[relation] += 1
	relation_dict[relation] = c1_name[r].strip(' ')+'\t'+c3_name[r].strip(' ')

with open('positive_concept.txt', 'w') as output1:
	for concept, count in node_counts.most_common():
		concept_name = concept_dict[concept]
		output1.write("%s\t%s\t%s\n" % (str(concept),str(concept_name),str(count)))
		# output1.write("%s\t%s\n" % (str(concept),str(count)))

with open('positive_relation.txt', 'w') as output2:
	for relation, count in relation_counts.most_common():
		relation_ends = relation_dict[relation] 
		output2.write("%s\t%s\t%s\n" % (str(relation),str(count),str(relation_ends)))
		# output2.write("%s\t%s\n" % (str(relation),str(count)))

