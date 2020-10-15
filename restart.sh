#!/bin/bash
ps -ef|grep client|awk '{print $2}'|xargs kill -USR1
ulimit -n 100000
rm -rf /www/wwwroot/crazyDhtSpider/dht_client/logs/*
rm -rf /www/wwwroot/crazyDhtSpider/dht_server/logs/*
php /www/wwwroot/crazyDhtSpider/dht_client/go.php
