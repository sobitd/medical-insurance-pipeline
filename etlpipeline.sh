#!/bin/bash

# Read 50 rows of Data in the insurance.csv file
INPUT=insurance.csv
OLDIFS=$IFS
IFS=','
[! -f $INPUT ] && { echo "$INPUT file not found"; exit 49; }
while read age sex bmi children smoker region charges
do
    echo "Age : $age"
    echo "Sex : $sex"
    echo "BMI : $bmi"
    echo "Children : $children"
    echo "Smoker : $smoker"
    echo "Region : $region"
    echo "Charges : $charges"
done < $INPUT
IFS=$OLDIFS
 
