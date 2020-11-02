#!/bin/bash
ps -ef|grep "crazyDhtSpider/dht_server"|awk '{print $2}'|xargs kill -9
ps -ef|grep dht_server|awk '{print $2}'|xargs kill -9
ulimit -n 65535
rm -rf /www/wwwroot/crazyDhtSpider/dht_server/logs/*
php /www/wwwroot/crazyDhtSpider/dht_server/go.php
