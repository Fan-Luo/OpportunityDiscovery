# Scientific Discovery as Link Prediction in Influence and Citation Graphs

## Introduction
This repository contains the code and data used in the paper "Scientific Discovery as Link Prediction in Influence and Citation Graphs". The paper presents a novel approach to scientific discovery by treating it as a link prediction problem in influence and citation graphs.

We introduce a machine learning approach for the identification of "white spaces" in scientific knowledge. Our approach addresses this task as link prediction over a graph that contains over 2M influence statements such as "CTCF activates FOXA1", which were automatically extracted using open-domain machine reading. We model this prediction task using graph-based features extracted from the above influence graph, as well as from a citation graph that captures scientific communities. We evaluated the proposed approach through backtesting. Although the data is heavily unbalanced (50 times more negative examples than positives), our approach predicts which influence links will be discovered in the "near future" with a F1 score of 27 points, and a mean average precision of 68\%.

## Requirements
The code is written in Python and requires the following packages:

- Neo4j Cypher
- NumPy
- SciPy
- scikit-learn
- imbalanced-learn

## Data
The data used in the experiments is included in the repository. It consists of a collection of scientific papers and their citation relationships.
