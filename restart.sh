#!/bin/bash
ps -ef|grep client|awk '{print $2}'|xargs kill -9
top -c -n1 | grep dht_client | head -1 | awk '{print $1}'|xargs kill -9
ulimit -n 100000
rm -rf /www/wwwroot/crazyDhtSpider/dht_client/logs/*
rm -rf /www/wwwroot/crazyDhtSpider/dht_server/logs/*
php /www/wwwroot/crazyDhtSpider/dht_client/go.php
