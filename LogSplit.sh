#!/bin/bash
##########################################################
# 脚本默认分割大小100M 判断单位byte
# 默认分割文件/cihi/logs/catalina.out
# 默认会在/var/log/logsplit.log 生成一个记录脚本动作的日志
# 分割后的文件名形式：原文件名当前时间.原文件后缀
# 如：【/tmp/testpy160805112152.log】
#		   年月日时分秒.log

#日志文件名
Fname=$1
#分割条件文件大小,目前只接受Mb级
Fsize=""
#记录本脚本动作的日志文件
self_log="/var/log/logsplit.log"
#是否无值,并赋于默认值
if [ -z $1 ]; then
	Fname="/cihi/logs/catalina.out"
fi
#是否无值
if [ -z $2 ]; then
        # 默认分割条件100MB byte单位
        Fsize=104857600
else	
	#计算Mb
        Fsize=$[ $2 * 1048576 ]
fi
#记录脚本执行时间到分钟
printf $(date "+%Y-%m-%d-%T") >> ${self_log}
if [ ! -f ${Fname} ]; then
	echo ": 日志文件不存在,请检查日志文件名或路径" >> ${self_log}
	exit
fi
#获取日志文件大小
log_size=`du -b ${Fname} | awk '{print $1}'`
if [ ${log_size} -le ${Fsize} ]; then
	echo "日志文件小于$2M" >> ${self_log}
	exit
fi

#生成新的文件名
Fnamea=`echo ${Fname} | awk -F '.' '{print $1}'`
Fnameb=`echo ${Fname} | awk -F '.' '{print $2}'`

#这么做主要是为了迎合不同日志文件名的后缀
NewFname=${Fnamea}$(date "+%Y%m%d%H%M%S")"."${Fnameb}
echo ${NewFname}
cp ${Fname} ${NewFname} && > ${Fname}

#判断命令是否执行成功 $?返回状态码 and 文件大小
Newlog_size=`du -b ${Fname} | awk '{print $1}'`
if [ $?=0 -a ${Newlog_size} -lt ${log_size} ];then	
	echo ": 日志${Fname}分割成功" >> ${self_log}
else
	echo ": CP或清空 【>】 命令为执行成功" >> ${self_log}
fi
