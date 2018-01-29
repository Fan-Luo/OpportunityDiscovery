#!/bin/bash
  
cols_file="cols.txt"
file_to_change="classifiers_polarity.py"   #"classifiers.py"
file_bak="classifiers_polarity.py.bak"   #"classifiers.py.bak"
file_recovery=$file_to_change'.orig'

result_name="all_results.txt"

if [ -f "$result_name" ] 
then  
	rm -f $result_name
fi

sed -i '.bak' "s|train_dev.csv|train.csv|g" $file_to_change
mv $file_bak $file_recovery

sed -i '.bak' "s|test.csv|dev.csv|g" $file_to_change
rm -rf $file_bak

str1="X_train = np.loadtxt(open(\"train.csv\", \"rb\"), delimiter=\",\",usecols="
str2="X_test = np.loadtxt(open(\"dev.csv\", \"rb\"), delimiter=\",\",usecols="

source activate scikit

cat $cols_file | while read col
do
	sed -i '.bak' -e "s|${str1}\(.*\))|${str1}${col})|g" $file_to_change
	rm -rf $file_bak
	sed -i '.bak' -e "s|${str2}\(.*\))|${str2}${col})|g" $file_to_change
	rm -rf $file_bak

	echo $col >> $result_name
	python3 $file_to_change >> $result_name
	echo  >> $result_name
	echo  >> $result_name

done


rm -rf $file_to_change
mv $file_recovery $file_to_change