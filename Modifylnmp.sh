#!/bin/bash
Sourfile="/root/Dockerfile/Dep/lnmp1.3-full.tar.gz"
Destfile="lnmp1.3-full.tar.gz"
echo "当前目录:"`pwd`
read -s -n1 -p "按任意键继续"
if [ ! -f ${Sourfile} ]; then
  echo "源文件存在"
fi
filelist=`ls`
for filea in ${filelist}
do
    if [ -d ${filea} -a ${filea} != "Dep" ]; then
      rm -rf ${filea}/${Destfile}
      ln ${Sourfile} ${filea}/${Destfile}
    fi
done
