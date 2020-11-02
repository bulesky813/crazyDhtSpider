/*
Navicat MySQL Data Transfer

Source Server         : google
Source Server Version : 50636
Source Host           : 35.185.171.254:3306
Source Database       : dht

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-09-22 10:27:20
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bt
-- ----------------------------
DROP TABLE IF EXISTS `bt`;
CREATE TABLE `bt`
(
    `id`           int(11)      NOT NULL,
    `name`         varchar(500) NOT NULL COMMENT '名称',
    `keywords`     varchar(250) NOT NULL COMMENT '关键词',
    `length`       bigint(20)   NOT NULL DEFAULT '0' COMMENT '文件大小',
    `piece_length` int(11)      NOT NULL DEFAULT '0' COMMENT '种子大小',
    `infohash`     char(40)     NOT NULL COMMENT '种子哈希值',
    `files`        text         NOT NULL COMMENT '文件列表',
    `hits`         int(11)      NOT NULL DEFAULT '0' COMMENT '点击量',
    `hot`          int(11)      NOT NULL DEFAULT '1' COMMENT '热度',
    `time`         datetime     NOT NULL COMMENT '收录时间',
    `lasttime`     datetime     NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后下载时间'
) ENGINE = MyISAM
  DEFAULT CHARSET = utf8
    PARTITION BY RANGE (id)
        (
        PARTITION p0 VALUES LESS THAN (2000000) ENGINE =MyISAM,
        PARTITION p1 VALUES LESS THAN (4000000) ENGINE =MyISAM,
        PARTITION p2 VALUES LESS THAN (6000000) ENGINE =MyISAM,
        PARTITION p3 VALUES LESS THAN (8000000) ENGINE =MyISAM,
        PARTITION p4 VALUES LESS THAN (10000000) ENGINE =MyISAM,
        PARTITION p5 VALUES LESS THAN (12000000) ENGINE =MyISAM,
        PARTITION p6 VALUES LESS THAN (14000000) ENGINE =MyISAM,
        PARTITION p7 VALUES LESS THAN (16000000) ENGINE =MyISAM,
        PARTITION p8 VALUES LESS THAN (18000000) ENGINE =MyISAM,
        PARTITION p9 VALUES LESS THAN (20000000) ENGINE =MyISAM,
        PARTITION p10 VALUES LESS THAN (22000000) ENGINE =MyISAM
        );

--
-- 转储表的索引
--

--
-- 表的索引 `cd_bt_source`
--
ALTER TABLE `bt`
    ADD PRIMARY KEY (`id`),
    ADD KEY `hot` (`hot`),
    ADD KEY `time` (`time`),
    ADD KEY `hits` (`hits`),
    ADD KEY `name` (`name`(255)),
    ADD KEY `keywords` (`keywords`),
    ADD KEY `infohash` (`infohash`) USING BTREE,
    ADD KEY `lasttime` (`lasttime`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `cd_bt_source`
--
ALTER TABLE `cd_bt_source`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`
(
    `infohash` char(40) NOT NULL,
    PRIMARY KEY (`infohash`),
    UNIQUE KEY `infohash` (`infohash`) USING BTREE
) ENGINE = MyISAM
  DEFAULT CHARSET = utf8;
