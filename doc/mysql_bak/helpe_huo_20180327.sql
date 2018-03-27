/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : helpe_v1

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 27/03/2018 22:27:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for helpe_address
-- ----------------------------
DROP TABLE IF EXISTS `helpe_address`;
CREATE TABLE `helpe_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  `info` varchar(50) NOT NULL,
  `ct` int(11) NOT NULL,
  `lat` float NOT NULL DEFAULT '0',
  `lng` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_address
-- ----------------------------
BEGIN;
INSERT INTO `helpe_address` VALUES (1, 1, 1, '测试地址', 1111, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for helpe_category
-- ----------------------------
DROP TABLE IF EXISTS `helpe_category`;
CREATE TABLE `helpe_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jp_name` varchar(50) NOT NULL,
  `cn_name` varchar(50) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  `flag` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  `mt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_category
-- ----------------------------
BEGIN;
INSERT INTO `helpe_category` VALUES (1, '古本', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (2, '売買', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (3, 'レンタル', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (4, 'ペット', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (5, 'イベント  ', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (6, '習い事', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (7, 'お手伝い', '', 0, 1, 1, 0, NULL);
INSERT INTO `helpe_category` VALUES (8, 'その他', '', 0, 1, 1, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for helpe_fav
-- ----------------------------
DROP TABLE IF EXISTS `helpe_fav`;
CREATE TABLE `helpe_fav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `itemid` (`itemid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_fav
-- ----------------------------
BEGIN;
INSERT INTO `helpe_fav` VALUES (1, 1, 1, 11111, 111111);
COMMIT;

-- ----------------------------
-- Table structure for helpe_feedback
-- ----------------------------
DROP TABLE IF EXISTS `helpe_feedback`;
CREATE TABLE `helpe_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `itemid` int(11) DEFAULT NULL,
  `flag` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `orderid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT '0',
  `owner` int(1) DEFAULT '0',
  `ct` int(11) DEFAULT NULL,
  `mt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_oid` (`orderid`) USING BTREE,
  KEY `idx_item` (`itemid`) USING BTREE,
  KEY `idx_uid` (`uid`) USING BTREE,
  KEY `idx_uuid` (`owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_feedback
-- ----------------------------
BEGIN;
INSERT INTO `helpe_feedback` VALUES (23, 'henhao', 5, 0, 99, 80, 2, 1, 1522143447, 1522160476);
COMMIT;

-- ----------------------------
-- Table structure for helpe_item
-- ----------------------------
DROP TABLE IF EXISTS `helpe_item`;
CREATE TABLE `helpe_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `appid` int(11) NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `img` varchar(50) CHARACTER SET utf8 NOT NULL,
  `flag` tinyint(4) NOT NULL COMMENT '0, 上架 1下架',
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `tag` int(11) NOT NULL,
  `type` smallint(3) NOT NULL COMMENT '0 商品 1 求助',
  `aid` int(11) NOT NULL COMMENT '我的地址里面的id',
  `aaid` int(11) NOT NULL COMMENT '日本地区的地区id',
  `lat` float NOT NULL,
  `lng` float NOT NULL,
  `pt` int(11) NOT NULL COMMENT '发布时间',
  `paytp` tinyint(2) NOT NULL DEFAULT '0',
  `contact` varchar(200) NOT NULL COMMENT '联系方式',
  `salenum` int(11) NOT NULL DEFAULT '0' COMMENT '交易数量',
  `deadline` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '可能是发布过期时间的文字描述',
  `unit` varchar(30) NOT NULL DEFAULT '""' COMMENT '单位',
  `pet` int(11) NOT NULL COMMENT '发布过期时间，服务90天，求助30天',
  PRIMARY KEY (`id`),
  KEY `aaid` (`aaid`),
  KEY `lng` (`lng`)
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_item
-- ----------------------------
BEGIN;
INSERT INTO `helpe_item` VALUES (1, '1', 1, 1000.00, '/img', 0, 1520696319, 1521261910, 1, 1, 0, 1, 1, 1, 1, 1, 1520696319, 0, 'contact', 0, '2018-05', 'ci', 1520696319);
INSERT INTO `helpe_item` VALUES (2, '2', 2, 1000.00, '/img', 0, 1520696319, 1520696319, 1, 1, 0, 1, 1, 1, 1, 1, 1520696319, 0, 'contact', 0, '2018-05', 'ci', 1520696319);
INSERT INTO `helpe_item` VALUES (3, '3', 2, 1000.00, '/img', 0, 1520696319, 1520696319, 1, 1, 0, 1, 1, 1, 1, 1, 1520696319, 0, 'contact', 0, '2018-05', 'ci', 1520696319);
INSERT INTO `helpe_item` VALUES (4, '4', 2, 1000.00, '/img', 0, 1520696319, 1520696319, 1, 1, 0, 1, 1, 1, 1, 1, 1520696319, 0, 'contact', 0, '2018-05', 'ci', 1520696319);
INSERT INTO `helpe_item` VALUES (5, 'name555', 2, 1000.00, '/img', 0, 1520696319, 1520696319, 2, 1, 0, 1, 1, 1, 1, 1, 1520696319, 0, 'contact', 0, '2018-05', 'ci', 1520696319);
INSERT INTO `helpe_item` VALUES (266, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521131186, 1521131186, 1, 0, 133333, 0, 22, 0, 1, 1, 1521131186, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (270, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521132430, 1521132430, 1, 0, 133333, 0, 22, 0, 1, 1, 1521132430, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (271, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521132493, 1521132493, 1, 0, 133333, 0, 22, 0, 1, 1, 1521132493, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (281, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521134503, 1521134503, 1, 0, 133333, 0, 22, 0, 1, 1, 1521134503, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (282, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521134598, 1521134598, 1, 0, 133333, 0, 22, 0, 1, 1, 1521134598, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (283, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521134662, 1521134662, 1, 0, 133333, 0, 22, 0, 1, 1, 1521134662, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (284, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521212672, 1521212672, 1, 0, 133333, 0, 22, 0, 1, 1, 1521212672, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (285, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521213617, 1521213617, 1, 0, 133333, 0, 22, 0, 1, 1, 1521213617, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (286, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521213725, 1521213725, 1, 0, 133333, 0, 22, 0, 1, 1, 1521213725, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (287, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521213800, 1521213800, 1, 0, 133333, 0, 22, 0, 1, 1, 1521213800, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (288, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521213835, 1521213835, 1, 0, 133333, 0, 22, 0, 1, 1, 1521213835, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (289, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521214379, 1521214379, 1, 0, 133333, 0, 22, 0, 1, 1, 1521214379, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (290, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521214999, 1521701785, 1, 0, 133333, 0, 22, 0, 1, 1, 1521214999, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (291, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521218480, 1521218480, 1, 0, 133333, 0, 22, 0, 1, 1, 1521218480, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (295, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521255688, 1521255688, 1, 0, 133333, 0, 22, 0, 1, 1, 1521255688, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (296, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521255797, 1521255797, 1, 0, 133333, 0, 22, 0, 1, 1, 1521255797, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (297, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521255826, 1521255826, 1, 0, 133333, 0, 22, 0, 1, 1, 1521255826, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (298, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521255881, 1521255881, 1, 0, 133333, 0, 22, 0, 1, 1, 1521255881, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (299, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521255973, 1521255973, 1, 0, 133333, 0, 22, 0, 1, 1, 1521255973, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (300, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521256103, 1521256103, 1, 0, 133333, 0, 22, 0, 1, 1, 1521256103, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (301, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521256248, 1521256248, 1, 0, 133333, 0, 22, 0, 1, 1, 1521256248, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (302, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521256896, 1521256896, 1, 0, 133333, 0, 22, 0, 1, 1, 1521256896, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (320, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521258472, 1521258472, 1, 0, 133333, 0, 22, 0, 1, 1, 1521258472, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (340, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521261538, 1521261538, 1, 0, 133333, 0, 22, 0, 1, 1, 1521261538, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
INSERT INTO `helpe_item` VALUES (347, 'test22', 0, 0.00, '/sstetttt.jpg', 1, 1521993895, 1521993895, 1, 0, 133333, 0, 22, 0, 1, 1, 1521993895, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
COMMIT;

-- ----------------------------
-- Table structure for helpe_itemdetail
-- ----------------------------
DROP TABLE IF EXISTS `helpe_itemdetail`;
CREATE TABLE `helpe_itemdetail` (
  `itemid` int(11) NOT NULL,
  `mark` text NOT NULL COMMENT '描述',
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`itemid`),
  KEY `itemid` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_itemdetail
-- ----------------------------
BEGIN;
INSERT INTO `helpe_itemdetail` VALUES (1, '得到的，个，个，个，个，', 1520696319, 0);
INSERT INTO `helpe_itemdetail` VALUES (281, '0', 1521134503, 1521134503);
INSERT INTO `helpe_itemdetail` VALUES (282, '0', 1521134598, 1521134598);
INSERT INTO `helpe_itemdetail` VALUES (283, '0', 1521134662, 1521134662);
INSERT INTO `helpe_itemdetail` VALUES (284, '0', 1521212672, 1521212672);
INSERT INTO `helpe_itemdetail` VALUES (285, '0', 1521213617, 1521213617);
INSERT INTO `helpe_itemdetail` VALUES (286, '0', 1521213725, 1521213725);
INSERT INTO `helpe_itemdetail` VALUES (287, '0', 1521213800, 1521213800);
INSERT INTO `helpe_itemdetail` VALUES (288, '0', 1521213835, 1521213835);
INSERT INTO `helpe_itemdetail` VALUES (289, '0', 1521214379, 1521214379);
INSERT INTO `helpe_itemdetail` VALUES (290, '0', 1521214999, 1521214999);
INSERT INTO `helpe_itemdetail` VALUES (291, '0', 1521218480, 1521218480);
INSERT INTO `helpe_itemdetail` VALUES (295, '0', 1521255688, 1521255688);
INSERT INTO `helpe_itemdetail` VALUES (296, '0', 1521255797, 1521255797);
INSERT INTO `helpe_itemdetail` VALUES (297, '0', 1521255826, 1521255826);
INSERT INTO `helpe_itemdetail` VALUES (298, '0', 1521255881, 1521255881);
INSERT INTO `helpe_itemdetail` VALUES (299, '0', 1521255973, 1521255973);
INSERT INTO `helpe_itemdetail` VALUES (300, '0', 1521256103, 1521256103);
INSERT INTO `helpe_itemdetail` VALUES (301, '111111111', 1521256248, 1521256248);
INSERT INTO `helpe_itemdetail` VALUES (302, '111111111', 1521256896, 1521256896);
INSERT INTO `helpe_itemdetail` VALUES (320, '111111111', 1521258472, 1521258472);
INSERT INTO `helpe_itemdetail` VALUES (340, '333333', 1521261538, 1521261538);
INSERT INTO `helpe_itemdetail` VALUES (347, '333333', 1521993895, 1521993895);
COMMIT;

-- ----------------------------
-- Table structure for helpe_itemimg
-- ----------------------------
DROP TABLE IF EXISTS `helpe_itemimg`;
CREATE TABLE `helpe_itemimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `itemid` (`itemid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of helpe_itemimg
-- ----------------------------
BEGIN;
INSERT INTO `helpe_itemimg` VALUES (1, 1, '/itemimg1', 1, 1520696319);
INSERT INTO `helpe_itemimg` VALUES (2, 1, '/itemimg2', 1, 1520696319);
INSERT INTO `helpe_itemimg` VALUES (181, 347, '/images/itemfiles/ZkHDQJeJsbQMCfR_1521993895.jpeg', 1, 1521993895);
INSERT INTO `helpe_itemimg` VALUES (182, 347, '/images/itemfiles/FaAir9ejSfuKDxN_1521993895.jpg', 1, 1521993895);
COMMIT;

-- ----------------------------
-- Table structure for helpe_orderaddr
-- ----------------------------
DROP TABLE IF EXISTS `helpe_orderaddr`;
CREATE TABLE `helpe_orderaddr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  `info` varchar(50) NOT NULL,
  `ct` int(11) NOT NULL,
  `lat` float NOT NULL DEFAULT '0',
  `lng` float NOT NULL DEFAULT '0',
  `orderid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of helpe_orderaddr
-- ----------------------------
BEGIN;
INSERT INTO `helpe_orderaddr` VALUES (202, 1, 1, '测试地址', 1522076966, 1, 1, 79);
INSERT INTO `helpe_orderaddr` VALUES (203, 1, 1, '测试地址', 1522077081, 1, 1, 80);
COMMIT;

-- ----------------------------
-- Table structure for helpe_orderinfo
-- ----------------------------
DROP TABLE IF EXISTS `helpe_orderinfo`;
CREATE TABLE `helpe_orderinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` bigint(20) NOT NULL COMMENT '应该是订单号',
  `uid` int(11) NOT NULL COMMENT '下单者IDuid',
  `status` int(11) NOT NULL,
  `ordertp` int(11) NOT NULL,
  `cash` decimal(11,2) NOT NULL COMMENT '价格',
  `ct` int(11) NOT NULL,
  `pt` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `num` int(11) NOT NULL COMMENT '数量',
  `type` smallint(2) NOT NULL COMMENT '商品item类型',
  `owner` int(11) NOT NULL COMMENT '商品item的所有者uid',
  `changeprice` decimal(11,2) NOT NULL COMMENT '差价',
  `remark` varchar(200) NOT NULL,
  `paytp` smallint(3) NOT NULL DEFAULT '1' COMMENT '支付类型',
  `fd` smallint(1) DEFAULT '0' COMMENT '是否评论',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_orderinfo
-- ----------------------------
BEGIN;
INSERT INTO `helpe_orderinfo` VALUES (79, 0, 1, 0, 0, 1000.00, 1522076966, 1520696319, 1522076966, 5, 1, 1, 2, 0.00, 'dddddd', 1, 0);
INSERT INTO `helpe_orderinfo` VALUES (80, 0, 1, 10, 0, 1000.00, 1522077081, 1520696319, 1522143447, 5, 1, 1, 2, 0.00, 'dddddd', 1, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
