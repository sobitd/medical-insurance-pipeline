#!/bin/bash

#Extract
echo "Extracting Data"

echo "columns in insurance.csv"
# Retrieve the columns of insurance.csv
csvcut -n insurance.csv


echo "desired data inside insurance.csv\n"

#print date frome desired columns
csvcut -c age,sex,region,charges insurance.csv | csvlook

#Transform

echo "Transforming Data \n"

#We only want age sex region charges
cut -d, -f3,4,5 --complement insurance.csv > cleaned.csv

# print cleaned.csv
echo "\n cleaned data\n"
csvlook cleaned.csv

# Load 

echo "\n Loading Data \n"

#Create a database called insuranced

psql -U postgres -c "CREATE DATABASE insurancedb;"


# Creating table in insurance where the csv data will be loaded

psql -U postgres -d insurancedb -c " CREATE TABLE insured( id SERIAL PRIMARY KEY,
		      age VARCHAR(255),
		      sex VARCHAR(255),
		      region VARCHAR(255),
		      charges VARCHAR(255)
);"



# Load Phase
echo " \n Loading data \n"

#\COPY csv into table insured

psql -U postgres -d insurancedb -c "\copy insured(age,sex,region,charges)
FROM 'cleaned.csv'
DELIMITER ','
CSV HEADER;"



