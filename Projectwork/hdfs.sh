hadoop jar /opt/cloudera/parcels/CDH-5.11.1-1.cdh5.11.1.p0.4/lib/hadoop-mapreduce/hadoop-streaming.jar \
-D mapreduce.job.reduces=1 \
-files hdfs://dumbo/user/yt1369/project/MTAmapper.py,hdfs://dumbo/user/yt1369/project/MTAreducer.py \
-mapper "python MTAmapper.py" \
-reducer "python MTAreducer.py" \
-input /user/yt1369/project/MTAdata.csv \
-output /user/yt1369/project/output1

hadoop jar /opt/cloudera/parcels/CDH-5.11.1-1.cdh5.11.1.p0.4/lib/hadoop-mapreduce/hadoop-streaming.jar \
-D mapreduce.job.reduces=1 \
-files hdfs://dumbo/user/yt1369/project/723FlowMapper.py \
-mapper "python 723FlowMapper.py" \
-input /user/yt1369/project/MRdata724_withweekday.csv \
-output /user/yt1369/project/output_withDoW

hdfs dfs -get /user/yt1369/project/output_withDoW/part-00000 ./project_Output

scp /Users/yixuantang/Downloads/mta_data.csv yt1369@dumbo.es.its.nyu.edu:/scratch/yt1369/ 
hdfs dfs -mkdir project
hdfs dfs -put /scratch/yt1369/mta_data.csv /user/yt1369/project