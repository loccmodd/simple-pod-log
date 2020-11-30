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

if [ $# -ne 1  ];
then
    echoLog "参数数量不正确，退出";
    exit 1;
fi
echoLog "开始循环日志停止操作";
echo ''> tmp.txt
echo ''> tmp_after.txt
podKeywork=$1 
echoLog ${podKeywork}  
podInfos=`ps -ef|grep $1 | grep logs | grep kubectl >>tmp.txt`
cat tmp.txt | sed -e '/^$/d' > tmp_after.txt
i=1 
lineCount=$(awk '{print NR}' tmp_after.txt)
for i in $lineCount
do
podsid=$(awk 'NR=='$i' {print $2}' tmp_after.txt)
echoLog "开始停止"$podsid"SID的POD的日志跟踪"
sudo kill -9 $podsid
done
echoLog "完成日志停止操作";
exit 0;