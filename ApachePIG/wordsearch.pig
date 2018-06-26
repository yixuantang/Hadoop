A = LOAD '/input/wordinput.txt' AS (line:chararray);
B = FOREACH A GENERATE LOWER(line) as word;
C = FOREACH B GENERATE ((word matches '.*hackathon.*'? 1:0)) as word1,((word matches '.*dec.*'?1:0)) as word2,((word matches '.*chicago.*'?1:0)) as word3,((word matches '.*java.*'?1:0)) as word4;
D = GROUP C ALL;
E = FOREACH D GENERATE FLATTEN(TOBAG(CONCAT('hackathon',' ',(chararray)SUM(C.word1)),CONCAT('Dec',' ',(chararray)SUM(C.word2)),CONCAT('Chicago',' ',(chararray)SUM(C.word3)),CONCAT('Java',' ',(chararray)SUM(C.word4))));
STORE E INTO '/user/yt1369/output' USING PigStorage();