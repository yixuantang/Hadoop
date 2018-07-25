beeline
!connect jdbc:hive2://babar.es.its.nyu.edu:10000/
create ytproject;
use ytproject;

CREATE EXTERNAL TABLE FlowGroup (
  station INT,
  day_of_week INT,
  time_range_of_day INT,
  flow_sum FLOAT,
  date STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

INSERT OVERWRITE TABLE FlowGroup
SELECT station,
       day_of_week,
       time_of_day,
       SUM(flow_count) AS flow_sum,
       start_date
FROM flowtable
GROUP BY station, start_date, time_of_day, day_of_week
GROUPING SETS((station, start_date, time_of_day,day_of_week))
ORDER BY station ASC, start_date ASC, time_of_day ASC;
+--------------------+------------------------+------------------------------+---------------------+-----------------+--+
| flowgroup.station  | flowgroup.day_of_week  | flowgroup.time_range_of_day  | flowgroup.flow_sum  | flowgroup.date  |
+--------------------+------------------------+------------------------------+---------------------+-----------------+--+
-----------------------------------------------

CREATE EXTERNAL TABLE Merge (
  station INT,
  day_of_week INT,
  time_of_day INT,
  flow_count INT,
  start_date STRING,
  incid_cnt INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

INSERT OVERWRITE TABLE Merge
SELECT f.station, f.day_of_week, f.time_range_of_day, f.flow_sum, f.date, i.incid_cnt
FROM FlowGroup f LEFT OUTER JOIN incident_count i
ON (f.station = i.station AND f.time_range_of_day = i.time_of_day AND f.date = i.start_date);

+----------------+--------------------+--------------------+-------------------+-------------------+------------------+--+
| merge.station  | merge.day_of_week  | merge.time_of_day  | merge.flow_count  | merge.start_date  | merge.incid_cnt  |
+----------------+--------------------+--------------------+-------------------+-------------------+------------------+--+

select sum(incid_cnt) from Merge;
+-------+--+
|  _c0  |
+-------+--+
| 4152  |
+-------+--+
----------------------------------------
