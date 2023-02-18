#!/bin/bash

#Extraction
# Retrieve the columns of insurance.csv
csvcut -n insurance.csv

#print date frome desired columns
csvcut -c age,sex,region,charges insurance.csv | csvlook

#Transformation
#We only want age sex region charges
cut -d, -f3,4,5 --complement insurance.csv > cleaned.csv

