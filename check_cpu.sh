#!/bin/sh
#i=2
#while (i--)
#do
pid=`ps aux|grep dht_client_task|sort -rn -k3|head -1|awk '{print $2}'`
cpu=`ps -p $pid -o pcpu |egrep -v CPU`
echo $cpu
echo $pid
if [ $cpu > 95 ]
then
kill -9 $pid;
echo "kill success";
fi
#done