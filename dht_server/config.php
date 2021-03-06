<?php
return array(
    'db' => array(
        'host' => '127.0.0.1',
        'user' => 'root',
        'pass' => 'sisi520a',
        'name' => 'dht',
    ),
    'daemonize' => true,//是否后台守护进程
    'worker_num' => 8,//设置启动的worker进程数
    'max_request' => 100000, //防止 PHP 内存溢出, 一个工作进程处理 X 次任务后自动重启 (注: 0,不自动重启)
    'max_wait_time' => 10,
    'dispatch_mode' => 2,//保证同一个连接发来的数据只会被同一个worker处理
    'log_file' => BASEPATH . '/logs/error.log',
    'max_conn' => 65535,//最大连接数
    'heartbeat_check_interval' => 5, //启用心跳检测，此选项表示每隔多久轮循一次，单位为秒
    'heartbeat_idle_time' => 10, //与heartbeat_check_interval配合使用。表示连接最大允许空闲的时间
);
