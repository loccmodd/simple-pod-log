#!/bin/bash
#set -x # 

function getCurrentTime()
{
    echo `date '+%Y-%m-%d %H:%M:%S'`;
}

function echoLog(){
   echo "`getCurrentTime`:$1"; 
}

set -e
echoLog "参数数量:$#";  

if [ $# -ne 2  ];
then
    echoLog "参数数量不正确，退出";
    exit 1;
fi
echoLog "开始聚合日志操作";
echo ''> tmp.txt
echo ''> tmp_after.txt
podKeywork=$1
logFileName=$2
podInfos=`sudo kubectl get pod -n inspur-netmgr |grep $1 >>tmp.txt`
cat tmp.txt | sed -e '/^$/d' > tmp_after.txt
i=1 
lineCount=$(awk '{print NR}' tmp_after.txt)
for i in $lineCount
do
podName=$(awk 'NR=='$i' {print $1}' tmp_after.txt)
echoLog "正在重定向Pod"$podName"的日志到文件"$logFileName
nohup sudo kubectl logs $podName -n inspur-netmgr -f=true --tail=50 >>$logFileName &
done
echoLog "完成聚合日志操作，现在可以通过"$logFileName"文件跟踪当前关键字为"$podKeywork"的所有Pod的日志";
exit 0;