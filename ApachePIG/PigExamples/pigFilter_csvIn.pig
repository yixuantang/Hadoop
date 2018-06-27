allsales = LOAD '/user/cloudera/class5/input/sales.csv' USING PigStorage(',') AS (name, price);

bigsales = FILTER allsales BY price > 3999;

STORE bigsales INTO '/user/cloudera/class5/output_CsvIn';
