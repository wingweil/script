#shell for url:
#for instance:

callWingdata(){
  curl -X POST http://*.*.*.*/Wingdata/post/taskStatus \
	--header "Content-Type: application/json" \
	--header "Accept: application/json" \
	-d "{
  	\"code\": \"$1\",
  	\"message\": \"$2\",
 	\"runSerialNo\": \"$3\",
  	\"taskName\": \"$4\"
	}"
}


sh_directory=`echo ${job_path%/*}`
pdate=${inc_start:0:8}
ftp_server=$src_ip
ftp_user=$src_user
ftp_pwd=$src_password
ftp_port=$src_port
gate=${p1}
log_name=${p2}
ftp_adm=${p3}
ftp_data_rootdir=/nfsvol/yun_ftp/yun/$gate/${pdate}
local_record=$sh_directory/record.log
info='未上传文件,请联系相关人员处理.'
taskName=""
taskNo=""
business=""
date=""
member=""
message=""
sxdm_host="###.####.com"
# 默认端口
sxdm_port=8060

if [[ $sxdm_host == *sxdm* ]];then
    url='https://'$sxdm_host'/sxdm/handleInfo'
else
    url='http://'$sxdm_host':'$port'/###/handleInfo'
fi
callwqe(){
  curl -X POST ${url} \
  --header "Content-Type: application/json" \
  --header "Accept: application/json" \
  -d "{
    \"htype\": \"$htype\",
    \"info\": \"$info\",
    \"code\": \"$code\",
    \"date\": \"$pdate\"
    \"business\": \"$business\",
    \"member\": \"$member\",
    \"taskName\": \"$taskName\",
    \"taskNo\": \"$task_name\"
  }"
}
while true;
do

cat /dev/null > ${local_record}

lftp $ftp_user:$ftp_pwd@$ftp_server:$p3 -e "cd ${ftp_data_rootdir};exit" > ${local_record} 2>&1
return_result=`grep -c 'Failed to change directory' ${local_record}`
  if [[ ${return_result} -eq 0 ]];then
       echo "已上传文件！"
       break
   fi
   print_log 'waiting...'
   callwqe
   sleep 10m

done
