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

 Date: 18/03/2018 11:07:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE=InnoDB AUTO_INCREMENT=341 DEFAULT CHARSET=utf8mb4;

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
INSERT INTO `helpe_item` VALUES (290, 'test22', 0, 0.00, '/sstetttt.jpg', 0, 1521214999, 1521279949, 1, 0, 133333, 0, 22, 0, 1, 1, 1521214999, 0, 'testtest11tesxt', 0, NULL, '\"\"', 0);
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
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
