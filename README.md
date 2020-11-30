# simple-pod-log
一个非常简单的K8S的POD的统一的日志输出脚本
# 运行
`chmod a+x run.sh`
`./run.sh podkeyword logfilename`
# 结束
` chmod a+x stop.sh`
` ./stop.sh podkeyword`
# 版本说明
V20201130 初版本，具备通过run.sh基本的将名称中包括相同关键词的所有Pod的日志统一输出到脚本同目录的自定义的文件中，具备通过stop.sh将名称中包括相同关键词的所有Pod的日志的统一输出进行关闭；
