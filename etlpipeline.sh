#!/bin/bash

#Extract
echo "Extracting Data"
# Retrieve the columns of insurance.csv
csvcut -n insurance.csv

#print date frome desired columns
csvcut -c age,sex,region,charges insurance.csv | csvlook

#Transform
echo "Transforming Data"
#We only want age sex region charges
cut -d, -f3,4,5 --complement insurance.csv > cleaned.csv

#view cleaned.csv
csvcut -c cleaned.csv | csvlook 

#pre-Load phase
echo "Loading Data"

#connecting to  Postgres CLI
psql --username=postgres --host=localhost

#Create database insurance
CREATE DATABASE insurance;

#connecting to database insurance
\c insurance

#Creating table
CREATE TABLE insured( id SERIAL,PRIMARY KEY (id), age VARCHAR(255), sex VARCHAR(255),region VARCHAR(255),charges VARCHAR(255));

#To  check if table insured was created
\dt

# Load Phase
echo " Loading data"

#Send the instructions to connect to  'insurance database' and
#copy the csv to the table 'Insured' through command pipeline.
#\c - to connect to your database
#\COPY csv into table
COPY insured(age,sex,region,charges) FROM cleaned.csv DELIMITER ',' CSV HEADER;
