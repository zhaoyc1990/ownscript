#!/bin/bash
# Author zhaoyanchang
# fuction: 专治dockerhub 镜像下载不下来
while true
do
	docker pull webdevops/php-nginx
	# $? 用来判断上次bash 命令执行结果，成功返回0。，加“x”是为了保证不判断式参数不为空
	if [ `echo $?`x = "0"x ]; then
		exit 
	fi
done
