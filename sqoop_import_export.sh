#sqoop:
#for instance:

sqoop export \-D mapred.job.queue.name=${job_name} \
--connect $mysqljdbc \
--username $dest_user \
--password $dest_password \
--update-key "column1,column2,column3,column4" \
--update-mode allowinsert \
--table t_tab_tmp -m 1 \
--export-dir /user/hive/warehouse/path/tab_tmp \
--columns column1,column2,column3,column4,column5,column6,column7 \
--input-null-string '\\N' \
--input-null-non-string '\\N' \
--input-fields-terminated-by ','


sqoop import \
--connect $mysqljdbc \
--username $dest_user \
--password $dest_password \
--table t_tab -m 1 \
--null-string '' \
--delete-target-dir \
--hive-import \--hive-overwrite \
--hive-database database \
--hive-table hive_tab
