<?php
//swoole version 1.9.5
/*
 * 安装swoole pecl install swoole
 * 设置服务器 ulimit -n 100000
 * 关闭防火墙和后台规则 防止端口不通
 */
error_reporting(E_ERROR);
ini_set('date.timezone', 'Asia/Shanghai');
ini_set("memory_limit", "-1");
define('BASEPATH', dirname(__FILE__));
$config = require_once BASEPATH . '/config.php';
require_once BASEPATH . '/inc/Func.class.php';
require_once BASEPATH . '/inc/Bencode.class.php';//bencode编码解码类
require_once BASEPATH . '/inc/Base.class.php';//基础操作类
require_once BASEPATH . '/inc/Db.class.php';
Func::Logs(date('Y-m-d H:i:s', time()) . " - 服务启动..." . PHP_EOL, 1);//记录启动日志

swoole_set_process_name("php_dht_server:[master] worker");

//SWOOLE_PROCESS 使用进程模式，业务代码在Worker进程中执行
//SWOOLE_SOCK_UDP 创建udp socket
$serv = new Swoole\Server('0.0.0.0', 2345, SWOOLE_PROCESS, SWOOLE_SOCK_UDP);
$serv->set($config);

$serv->on('WorkerStart', function ($serv, $worker_id) use ($config) {
    Db::$config = array(
        'host' => $config['db']['host'],
        'user' => $config['db']['user'],
        'pass' => $config['db']['pass'],
        'name' => $config['db']['name'],
    );

    swoole_set_process_name("php_dht_server:[" . $worker_id . "] worker");
});

$serv->on('Receive', function ($serv, $fd, $from_id, $data) {
    if (strlen($data) == 0) {
        $serv->close($fd, true);
        return false;
    }
    //$fdinfo = $serv->connection_info($fd, $from_id);
    $rs = Base::decode($data);
    if (is_array($rs) && isset($rs['infohash'])) {
        $data = Db::get_one("select 1 from history where infohash = '$rs[infohash]' limit 1");
        if (!$data) {
            Db::insert('history', array('infohash' => $rs['infohash']));
            $files = '';
            $length = 0;
            if ($rs['files'] != '') {
                $files = json_encode($rs['files'], JSON_UNESCAPED_UNICODE);
                foreach ($rs['files'] as $value) {
                    $length += $value['length'];
                }
            } else {
                $length = $rs['length'];
            }
            Db::insert('bt', array(
                    'name' => $rs['name'],
                    'keywords' => Func::getKeyWords($rs['name']),
                    'infohash' => $rs['infohash'],
                    'files' => $files,
                    'length' => $length,
                    'piece_length' => $rs['piece_length'],
                    'hits' => 0,
                    'time' => date('Y-m-d H:i:s'),
                    'lasttime' => date('Y-m-d H:i:s'),
                )
            );
        } else {
            $files=addslashes(json_encode($rs['files'], JSON_UNESCAPED_UNICODE));
            Db::query("update bt set `hot` = `hot` + 1,`files` = '".$files."' where infohash = '$rs[infohash]'");
        }
    }
    $serv->close($fd, true);
});
$serv->on('Packet', function ($serv, $data, $clientInfo) {
    if (strlen($data) == 0) {
        $serv->close($fd, true);
        return false;
    }
    //$fdinfo = $serv->connection_info($fd, $from_id);
    $rs = Base::decode($data);
    if (is_array($rs) && isset($rs['infohash'])) {
        $data = Db::get_one("select 1 from history where infohash = '$rs[infohash]' limit 1");
        if (!$data) {
            Db::insert('history', array('infohash' => $rs['infohash']));
            $files = '';
            $length = 0;
            if ($rs['files'] != '') {
                $files = json_encode($rs['files'], JSON_UNESCAPED_UNICODE);
                foreach ($rs['files'] as $value) {
                    $length += $value['length'];
                }
            } else {
                $length = $rs['length'];
            }
            Db::insert('bt', array(
                    'name' => $rs['name'],
                    'keywords' => Func::getKeyWords($rs['name']),
                    'infohash' => $rs['infohash'],
                    'files' => $files,
                    'length' => $length,
                    'piece_length' => $rs['piece_length'],
                    'hits' => 0,
                    'time' => date('Y-m-d H:i:s'),
                    'lasttime' => date('Y-m-d H:i:s'),
                )
            );
        } else {
            Db::query("update bt set `hot` = `hot` + 1,`files` = $files where infohash = '$rs[infohash]'");
        }
    }
    $serv->close($fd, true);
});
$serv->start();


