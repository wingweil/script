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




列出mysql数据库中的所有数据库
sqoop list-databases --connect jdbc:mysql://$ip:$port/ -username $user -password $pwd

连接mysql并列出数据库中的表
sqoop list-tables --connect jdbc:mysql://$ip:$port/$db_name --username $user --password $pwd


pdate="`date +%Y-%m-%d`" 
sqoop import \--connect jdbc:mysql://$ip:$port/$db_name \--username $user \--password $pwd \--table T_CONTACT -m 1 \--null-string '' \--target-dir /home/mwop/cmcs_data/ODS_CMCS_T_CONTACT_TMP --as-textfile \--delete-target-dir \--hive-import \--hive-overwrite \--hive-database mams_cmcs \--hive-table ODS_CMCS_T_CONTACT_TMP \--hive-partition-key pdate \--hive-partition-value ${pdate}


sqoop eval \
--connect jdbc:mysql://$ip:$port/$db_name \
--username $user \
--password $pwd \
--query "insert into $tab_name (select count(1) cnt_all,'T_CONTACT' table_name,CURRENT_DATE() updated_time from $tab_name t )"


sqoop export \-D mapred.job.queue.name=${job_name} \
--connect $mysqljdbc \
--username $dest_user \
--password $dest_password \
--update-key "mem_id,category_code,stat_date,key" \
--update-mode allowinsert \
--table $tab_name -m 1 \
--export-dir /user/hive/warehouse/$db_name.db/ads_cmwt_data_insight_report_tmp \
--columns mem_id,category_code,stat_date,key,value,create_time,notice_id \
--input-null-string '\\N' \
--input-null-non-string '\\N' \
--input-fields-terminated-by ','


sqoop import \
--connect $mysqljdbc \
--username $dest_user \
--password $dest_password \
--table $tab_name \
--null-string '' \
--null-non-string '\\N' \
--fields-terminated-by '\001' -m 2 \
--delete-target-dir \
--hive-import \
--hive-overwrite \
--hive-database $db_name \
--hive-table cmwt_t_hive_exception_notice_tmp
