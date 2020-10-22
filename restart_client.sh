#!/bin/bash
ps -ef|grep client|awk '{print $2}'|xargs kill -9
ulimit -n 65535
rm -rf /www/wwwroot/crazyDhtSpider/dht_client/logs/*
php /www/wwwroot/crazyDhtSpider/dht_client/go.php