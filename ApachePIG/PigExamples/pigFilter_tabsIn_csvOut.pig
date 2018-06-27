allsales = LOAD '/user/cloudera/class5/input/sales.txt' AS (name, price);

bigsales = FILTER allsales BY price > 3999;

STORE bigsales INTO '/user/cloudera/class5/output_tabsIn_csvOut' USING PigStorage(',');
