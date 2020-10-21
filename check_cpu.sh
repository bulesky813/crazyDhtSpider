#!/bin/sh
i=0
while (($i<=10))
do
pid=`ps aux|grep dht_client_task|sort -rn -k3|head -1|awk '{print $2}'`
cpu=`top -bn1 -n 1  -p $pid | tail -1 | awk '{printf("%d",$9)}' | sed 's/ /,/'`
echo $cpu
echo $pid
if [ "$cpu" -gt "90" ]
then
kill -9 $pid;
echo "kill success";
else
echo "no need to kill";
fi
let i++
done