from __future__ import print_function

from sklearn.preprocessing import StandardScaler 
from sklearn.naive_bayes import MultinomialNB
from sklearn.linear_model import LogisticRegression
from sklearn.svm import LinearSVC
from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
import scipy.stats as stat
from sklearn.model_selection import GridSearchCV
from imblearn.metrics import classification_report_imbalanced
from sklearn.metrics import classification_report
from imblearn.metrics import (geometric_mean_score, make_index_balanced_accuracy)
from imblearn.under_sampling import NearMiss
from imblearn.metrics import geometric_mean_score as gmean
from imblearn.metrics import make_index_balanced_accuracy as iba
from sklearn import metrics
import numpy as np
import string


X_train = np.loadtxt(open("train_dev.csv", "rb"), delimiter=",",usecols=(0,1,2,3,4,5,6,7,8,9,10,11,12))
y_train = np.loadtxt(open("train_dev.csv", "rb"), delimiter=",",dtype=int,usecols=13)
X_train_polarity = np.loadtxt(open("train_dev.csv", "rb"), delimiter='"',dtype=str,usecols=(7,9))

X_test = np.loadtxt(open("test.csv", "rb"), delimiter=",",usecols=(0,1,2,3,4,5,6,7,8,9,10,11,12))
y_test = np.loadtxt(open("test.csv", "rb"), delimiter=",",dtype=int,usecols=13)
X_test_polarity = np.loadtxt(open("test.csv", "rb"), delimiter='"',dtype=str,usecols=(7,9))

text_test= np.loadtxt(open("test.csv", "rb"), delimiter='"',dtype=str,usecols=(1,3,5))
A_idf = np.loadtxt(open("test.csv", "rb"), delimiter=",",usecols=0)
C_idf = np.loadtxt(open("test.csv", "rb"), delimiter=",",usecols=2)


# change y to three values according to polarity of A->C (r3), so it is a multi-clasiification 
with open("train_dev.csv", 'r') as train:
    content = [t.rstrip("\n") for t in train]
    r3_label_train = [x.split('"')[-2] for x in content] 

with open("test.csv", 'r') as test:
    content = [t.rstrip("\n") for t in test]
    r3_label_test = [x.split('"')[-2] for x in content] 
    r3_id_test = [x.split(' ')[-1] for x in content]   # evidence

for i,train_label in enumerate(r3_label_train):
    if(y_train[i]):
        if(train_label == 'increases'):
            y_train[i] = 1;
        elif(train_label == 'decreases'):
            y_train[i] = 2;
        else:
            print("error")
            print(train_label)

for i,test_label in enumerate(r3_label_test):
    if(y_test[i]):
        if(test_label == 'increases'):
            y_test[i] = 1;
        elif(test_label == 'decreases'):
            y_test[i] = 2;
        else:
            print("error")
            print(test_label)


#add polarity of A->B and B->C as another two features
train_polarity = np.zeros((X_train_polarity.shape[0],2))
test_polarity = np.zeros((X_test_polarity.shape[0],2))

for i in range(X_train_polarity.shape[0]):
    for j,polarity in enumerate(X_train_polarity[i]):
        if(polarity.strip() == 'increases'):
            train_polarity[i][j] = 1.0
        elif(polarity.strip() == 'decreases'):
            train_polarity[i][j] = 0.0
        else:
            print("error")
            print(X_train_polarity[i][j])


for i in range(X_test_polarity.shape[0]):
    for j,polarity in enumerate(X_test_polarity[i]):
        if(polarity.strip() == 'increases'):
            test_polarity[i][j] = 1.0
        elif(polarity.strip() == 'decreases'):
            test_polarity[i][j] = 0.0
        else:
            print("error")
            print(X_test_polarity[i][j])

X_train = np.hstack((X_train,train_polarity))
X_test = np.hstack((X_test,test_polarity))


X_scaler = StandardScaler()
X_train = X_scaler.fit_transform(X_train)
X_test = X_scaler.transform(X_test)


names = [
        # "Nearest Neighbors", 
        # "Linear SVM",  
        #  "Decision Tree", 
         # "Random Forest", 
         "Neural Net"
         # , "AdaBoost",
         # "Naive Bayes", "QDA", 
         # "Logistic Regression"
        ]

classifiers = [
    # KNeighborsClassifier(n_jobs=-1),
    # LinearSVC(dual=False,fit_intercept=False),
    # DecisionTreeClassifier(),
    # RandomForestClassifier(n_jobs=-1),
    MLPClassifier(),
    # AdaBoostClassifier(),
    # GaussianNB(),
    # QuadraticDiscriminantAnalysis(),
    # LogisticRegression(solver='liblinear',dual=False,fit_intercept=False)
]


param_grids = [
    # [{'n_neighbors': [5,10,20],'weights':['uniform','distance']}],
    # [{'C': [0.025, 1, 10, 100],'max_iter':[100,300],'class_weight':[None,'balanced']}],
    # [{'max_depth': [5,None], 'max_features':[1,None,'auto'],'class_weight':[None,'balanced']}],
    # [{'max_depth': [5,None], 'max_features':[1,None,'auto'],'class_weight':[None,'balanced']}],
    # [{'random_state':[76],'activation':['identity', 'logistic', 'tanh', 'relu'],'solver':['lbfgs', 'sgd', 'adam'],'alpha': [0.00001,0.0001,0.1,10],'learning_rate_init': [0.00001,0.0001,0.1,10],'learning_rate':['constant', 'invscaling', 'adaptive'],'max_iter':[100,300],'hidden_layer_sizes':[(100,),(60,20),(30,20,10,)],'batch_size':['auto',100,500],'power_t':[0.05,0.5,5],'shuffle':[False,True],'tol':[0.00001,0.0001,0.1,10],'momentum':[0.1,0.5,0.9],'nesterovs_momentum':[False,True],'early_stopping':[False,True],'shuffle':[False,True],'validation_fraction':[0.1,0.5,0.9],'beta_1':[0.1,0.5,0.9],'beta_2':[0.1,0.5,0.9]}]
    #,'epsilon':[1e-8,1e-9,1e-7]
    # [{'random_state':[830],'activation':['relu'], 'learning_rate': ['constant'], 'max_iter': [100], 'shuffle': [False]}]
    # [{'random_state':[6930],'activation':['identity', 'logistic', 'tanh', 'relu'], 'learning_rate': ['constant', 'invscaling', 'adaptive'], 'max_iter': [100,300,600,1000], 'shuffle': [False,True]}]
    # [{'random_state':[6666],'hidden_layer_sizes':[(10,10,)],'early_stopping':[True], 'learning_rate': [ 'adaptive'], 'learning_rate_init':[1], 'max_iter': [10000000], 'momentum': [0.9], 'solver':['sgd']}]
    [{'random_state':[10008],'hidden_layer_sizes':[(50,),(100,),(150,),(20,5,)],'early_stopping':[True], 'learning_rate': ['constant', 'adaptive'], 'learning_rate_init':[0.001,0.01,0.1,1], 'max_iter': [10000000], 'momentum': [0.1,0.5,0.9], 'solver':['sgd']}]
    # [{'random_state':[830],'hidden_layer_sizes':[(100,)],'early_stopping':[True], 'learning_rate': ['adaptive'], 'learning_rate_init':[0.1], 'max_iter': [10000000], 'momentum': [0.9], 'solver':['sgd']}]
    # [{'alpha': [0.00001], 'activation': ['logistic'], 'solver': ['adam'], 'random_state': [830], 'learning_rate': ['constant'], 'max_iter': [100]}]
    # ,
    # [{'n_estimators': [10,50,100],'learning_rate':[0.1,1,10]}],
    # [{}],
    # [{}],
    # [{'C': [0.1, 1, 10, 100],'max_iter':[100,300],'class_weight':[None,'balanced']}]
]

# gmean = iba(alpha=0.1, squared=True)(gmean)
# scorer = metrics.make_scorer(gmean)
avg_f1 = metrics.make_scorer(metrics.f1_score, average = 'macro', labels=[1,2])

# iterate over classifiers
for name, clf, param_grid in zip(names, classifiers,param_grids):
    print("# classifier: %s" % name)
    print()
    grid = GridSearchCV(clf, param_grid=param_grid,scoring=avg_f1)  #scoring='f1', scoring=scorer
    grid.fit(X_train, y_train)
    print()
    print("Best parameters set found on development set:")
    print()
    print(grid.best_params_)

    print()
    print("Scores for all configurations:")
    for i in range(len(grid.cv_results_['mean_test_score'])):
        print("params:", grid.cv_results_['params'][i])
        print("mean_test_score:", grid.cv_results_['mean_test_score'][i])
        print("std_test_score:", grid.cv_results_['std_test_score'][i])
        print("----")

    print()
    print("Detailed classification report:")
    print()
    print("The model is trained on the full development set.")
    print("The scores are computed on the full evaluation set.")
    print()
    y_true, y_pred = y_test, grid.predict(X_test)
    print(classification_report_imbalanced(y_true, y_pred))
    print("F1_macro among labels[1,2]:")
    print(metrics.f1_score(y_true, y_pred, average='macro',labels=[1,2])) 
    print()
    print("F1_micro among labels[1,2]:")
    print(metrics.f1_score(y_true, y_pred, average='micro',labels=[1,2])) 
    

    # y_pro = grid.predict_proba(X_test)
    # with open('classifiers_probabilities.tsv', 'w') as output:
    #     output.write("pro_0\tpro_1\tpredict\tgold\tconceptA\tconceptB\tconceptC\tA-idf\tC-idf\tnew finding\tgold-r3-id\tgold-r3-polarity\n")
    #     for i in range(len(y_test)):
    #         output.write(str(y_pro[i][0]))
    #         output.write('\t')
    #         output.write(str(y_pro[i][1]))
    #         output.write('\t')
    #         output.write(str(y_pred[i]))
    #         output.write('\t')
    #         output.write(str(y_true[i]))
    #         output.write('\t')
    #         output.write(str(text_test[i][0]))
    #         output.write('\t')
    #         output.write(str(text_test[i][1]))
    #         output.write('\t')
    #         output.write(str(text_test[i][2]))
    #         output.write('\t')
    #         output.write(str(A_idf[i]))
    #         output.write('\t')
    #         output.write(str(C_idf[i]))
    #         output.write('\t')
    #         output.write(str(text_test[i][0])+" -> "+str(text_test[i][2]))
    #         if(y_true[i]):
    #             output.write('\t')
    #             output.write(str(r3_id_test[i]))
    #             output.write('\t')
    #             output.write(str(r3_label_test[i]))
    #         output.write('\n')
    # print()

