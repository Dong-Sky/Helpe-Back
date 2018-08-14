/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : db_helpe

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 12/08/2018 22:48:51
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
  `lat` float NOT NULL DEFAULT '0',
  `lng` float NOT NULL DEFAULT '0',
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_address
-- ----------------------------
BEGIN;
INSERT INTO `helpe_address` VALUES (1, 1, 1, '测试地址', 1, 1, 1111, 0);
INSERT INTO `helpe_address` VALUES (84, 1, 0, '华东理工大学', 1, 1, 1522162893, 1522162893);
INSERT INTO `helpe_address` VALUES (85, 1, 0, 'apple store', 37.7854, -122.408, 1524040260, 1524040260);
INSERT INTO `helpe_address` VALUES (86, 2, 0, 'apple store', 37.7858, -122.406, 1524063276, 1524063276);
INSERT INTO `helpe_address` VALUES (87, 4, 0, 'kuresuto', 35.8393, 139.736, 1526341226, 1526341226);
INSERT INTO `helpe_address` VALUES (88, 6, 0, 'apple', 37.7855, -122.407, 1526384136, 1526384136);
INSERT INTO `helpe_address` VALUES (89, 1, 0, '家', 31.2584, 121.444, 1526384481, 1526384481);
INSERT INTO `helpe_address` VALUES (90, 1, 0, '家', 35.7738, 103.184, 1526384496, 1526384496);
INSERT INTO `helpe_address` VALUES (91, 8, 0, '家', 35.705, 139.767, 1526385016, 1526385016);
INSERT INTO `helpe_address` VALUES (92, 9, 0, '2567777', 31.2486, 121.562, 1526449536, 1526449536);
INSERT INTO `helpe_address` VALUES (93, 1, 0, 'apple street', 37.7858, -122.406, 1531486096, 1531486096);
INSERT INTO `helpe_address` VALUES (94, 1, 0, 'apple street', 37.7858, -122.406, 1531486474, 1531486474);
INSERT INTO `helpe_address` VALUES (95, 8, 0, '東大', 35.7097, 139.76, 1531580822, 1531580822);
INSERT INTO `helpe_address` VALUES (96, 7, 0, '新宿駅東口', 35.6765, 139.852, 1531582024, 1531582024);
COMMIT;

-- ----------------------------
-- Table structure for helpe_admin
-- ----------------------------
DROP TABLE IF EXISTS `helpe_admin`;
CREATE TABLE `helpe_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '管理员账号',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '管理员邮箱',
  `face` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员头像',
  `role` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员角色',
  `status` tinyint(1) NOT NULL DEFAULT '10' COMMENT '状态',
  `auth_key` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password_hash` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_time` int(11) NOT NULL DEFAULT '0' COMMENT '上一次登录时间',
  `last_ip` char(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '上一次登录的IP',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '地址信息',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `created_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建用户',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `updated_id` int(11) NOT NULL DEFAULT '0' COMMENT '修改用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='管理员信息表';

-- ----------------------------
-- Records of helpe_admin
-- ----------------------------
BEGIN;
INSERT INTO `helpe_admin` VALUES (1, 'super', 'super@admin.com', '', 'administrator', 10, 'gKkLFMdB2pvIXOFNpF_Aeemvdf1j0YUM', '$2y$13$Nuf1mzDRoCMxrWI.rIjENu20QshJG41smdEeHFHxq0qdmS99YytHy', '5vLaPpUS-I-XxJaoGP-GZDk474WdnaK3_1469073015', 1532145965, '127.0.0.1', '', 1519919184, 1, 1532145965, 1);
INSERT INTO `helpe_admin` VALUES (2, 'admin', 'admin@admin.com', '', 'admin', 10, 'tArp_Kv4z1JlzBUZYCL33N24AZL-_77p', '$2y$13$RNrJ7GK1A5iZRxBpho6sbeCJKfNRxzy5axCeRjZLqvA5W6RuVYBRW', 'CgScbf1E96N3pqH01b0mVi_Z58j8QsRV_1501916190', 1521103495, '127.0.0.1', '', 1519919184, 1, 1521103495, 2);
COMMIT;

-- ----------------------------
-- Table structure for helpe_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `helpe_admin_log`;
CREATE TABLE `helpe_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '日志类型',
  `controller` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '方法',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `index` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '数据标识',
  `params` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '请求参数',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `created_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建用户',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`created_id`) USING BTREE COMMENT '管理员'
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COMMENT='管理员信息表';

-- ----------------------------
-- Records of helpe_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `helpe_admin_log` VALUES (1, 2, 'menu', 'update', '/menu/update', 'id=13', '{\"id\":\"13\",\"pid\":\"0\",\"menu_name\":\"上传文件\",\"icons\":\"menu-icon fa fa-upload\",\"url\":\"uploads/index\",\"status\":\"0\",\"sort\":\"9\"}', 1532142636, 1);
INSERT INTO `helpe_admin_log` VALUES (2, 2, 'menu', 'update', '/menu/update', 'id=13', '{\"id\":\"13\",\"pid\":\"0\",\"menu_name\":\"上传文件\",\"icons\":\"menu-icon fa fa-upload\",\"url\":\"uploads/index\",\"status\":\"1\",\"sort\":\"9\"}', 1532142674, 1);
INSERT INTO `helpe_admin_log` VALUES (3, 2, 'menu', 'update', '/menu/update', 'id=10', '{\"id\":\"10\",\"pid\":\"0\",\"menu_name\":\"地址信息\",\"icons\":\"menu-icon fa fa-bank\",\"url\":\"china/index\",\"status\":\"0\",\"sort\":\"4\"}', 1532143519, 1);
INSERT INTO `helpe_admin_log` VALUES (4, 2, 'menu', 'update', '/menu/update', 'id=12', '{\"id\":\"12\",\"pid\":\"0\",\"menu_name\":\"日程管理\",\"icons\":\"menu-icon fa fa-calendar\",\"url\":\"arrange/index\",\"status\":\"0\",\"sort\":\"1\"}', 1532143527, 1);
INSERT INTO `helpe_admin_log` VALUES (5, 2, 'menu', 'update', '/menu/update', 'id=13', '{\"id\":\"13\",\"pid\":\"0\",\"menu_name\":\"上传文件\",\"icons\":\"menu-icon fa fa-upload\",\"url\":\"uploads/index\",\"status\":\"0\",\"sort\":\"9\"}', 1532143533, 1);
INSERT INTO `helpe_admin_log` VALUES (6, 2, 'menu', 'update', '/menu/update', 'id=1', '{\"id\":\"1\",\"pid\":\"0\",\"menu_name\":\"后台功能管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"\",\"status\":\"1\",\"sort\":\"2\"}', 1532147019, 1);
INSERT INTO `helpe_admin_log` VALUES (7, 1, 'authority', 'create', '/authority/create', 'name=', '{\"type\":\"2\",\"name\":\"\",\"newName\":\"user/userinfo\",\"description\":\"获取用户详情\",\"rule_name\":\"admin\"}', 1532148836, 1);
INSERT INTO `helpe_admin_log` VALUES (8, 2, 'authority', 'update', '/authority/update', 'name=user/userinfo', '{\"type\":\"2\",\"name\":\"user/userinfo\",\"newName\":\"user/userinfo\",\"description\":\"获取用户详情\",\"rule_name\":\"\"}', 1532148844, 1);
INSERT INTO `helpe_admin_log` VALUES (9, 2, 'authority', 'update', '/authority/update', 'name=user/userinfo', '{\"type\":\"2\",\"name\":\"user/userinfo\",\"newName\":\"user/userinfo\",\"description\":\"用户信息-用户详情\",\"rule_name\":\"admin\"}', 1532148864, 1);
INSERT INTO `helpe_admin_log` VALUES (10, 3, 'user', 'delete', '/user/delete', 'id=10', '{\"id\":\"10\",\"type\":\"1\",\"email\":\"494376395@qq.com\",\"username\":\"大徒弟\",\"access_token\":\"8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp\",\"password_reset_token\":\"\",\"face\":\"\",\"gender\":\"0\",\"birthday\":\"\",\"career\":\"\",\"city\":\"\",\"cityinfo\":\"\",\"tel\":\"\",\"ip\":\"115.238.194.18\",\"info\":\"\",\"status\":\"1\",\"created_at\":\"1532069429\",\"updated_at\":\"1532076136\"}', 1532170905, 1);
INSERT INTO `helpe_admin_log` VALUES (11, 2, 'user', 'delete', '/user/delete', 'id=10', '{\"id\":\"10\",\"type\":\"1\",\"email\":\"494376395@qq.com\",\"username\":\"大徒弟\",\"access_token\":\"8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp\",\"password_reset_token\":\"\",\"face\":\"\",\"gender\":\"0\",\"birthday\":\"\",\"career\":\"\",\"city\":\"\",\"cityinfo\":\"\",\"tel\":\"\",\"ip\":\"115.238.194.18\",\"info\":\"\",\"status\":\"1\",\"created_at\":\"1532069429\",\"updated_at\":\"1532076136\"}', 1532176633, 1);
INSERT INTO `helpe_admin_log` VALUES (12, 2, 'user', 'update', '/user/update', 'id=10', '{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"1\"}', 1532180732, 1);
INSERT INTO `helpe_admin_log` VALUES (13, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"\"}', 1533961891, 1);
INSERT INTO `helpe_admin_log` VALUES (14, 2, 'category', 'update', '/category/update', 'id=2', '{\"id\":\"2\",\"jp_name\":\"売買\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"\"}', 1533962031, 1);
INSERT INTO `helpe_admin_log` VALUES (15, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"0\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533961891\"}', 1533962315, 1);
INSERT INTO `helpe_admin_log` VALUES (16, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"0\",\"ct\":\"0\",\"mt\":\"1533962315\"}', 1533962331, 1);
INSERT INTO `helpe_admin_log` VALUES (17, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533962331\"}', 1533962338, 1);
INSERT INTO `helpe_admin_log` VALUES (18, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"0\",\"ct\":\"0\",\"mt\":\"1533962338\"}', 1533963104, 1);
INSERT INTO `helpe_admin_log` VALUES (19, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533963104\"}', 1533963111, 1);
INSERT INTO `helpe_admin_log` VALUES (20, 2, 'user', 'update', '/user/update', 'id=10', '{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"0\"}', 1533965466, 1);
INSERT INTO `helpe_admin_log` VALUES (21, 2, 'user', 'update', '/user/update', 'id=10', '{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"1\"}', 1533965470, 1);
INSERT INTO `helpe_admin_log` VALUES (22, 2, 'user', 'update', '/user/update', 'id=10', '{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"0\"}', 1533965480, 1);
INSERT INTO `helpe_admin_log` VALUES (23, 2, 'user', 'update', '/user/update', 'id=10', '{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"1\"}', 1533965487, 1);
INSERT INTO `helpe_admin_log` VALUES (24, 2, 'category', 'delete', '/category/delete', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533963111\"}', 1533965939, 1);
INSERT INTO `helpe_admin_log` VALUES (25, 2, 'category', 'update', '/category/update', 'id=1', '{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\"}', 1533965952, 1);
INSERT INTO `helpe_admin_log` VALUES (26, 2, 'user', 'update', '/user/update', 'id=10', '{\"id\":\"10\",\"username\":\"大徒弟\",\"email\":\"494376395@qq.com\",\"access_token\":\"8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp\",\"password_reset_token\":\"\",\"ip\":\"115.238.194.18\",\"gender\":\"1\",\"birthday\":\"\",\"career\":\"\",\"cityinfo\":\"\",\"tel\":\"\",\"status\":\"1\"}', 1533968601, 1);
INSERT INTO `helpe_admin_log` VALUES (27, 2, 'menu', 'update', '/menu/update', 'id=20', '{\"id\":\"20\",\"pid\":\"0\",\"menu_name\":\"举报信息管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"report/index\",\"status\":\"1\",\"sort\":\"100\"}', 1533971332, 1);
INSERT INTO `helpe_admin_log` VALUES (28, 3, 'report', 'delete', '/report/delete', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"username\":\"Answer123\"}', 1533973112, 1);
INSERT INTO `helpe_admin_log` VALUES (29, 2, 'report', 'delete', '/report/delete', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"username\":\"Answer123\"}', 1533973200, 1);
INSERT INTO `helpe_admin_log` VALUES (30, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}', 1533974186, 1);
INSERT INTO `helpe_admin_log` VALUES (31, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}', 1533974193, 1);
INSERT INTO `helpe_admin_log` VALUES (32, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\"}', 1533974209, 1);
INSERT INTO `helpe_admin_log` VALUES (33, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}', 1533974213, 1);
INSERT INTO `helpe_admin_log` VALUES (34, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}', 1533974217, 1);
INSERT INTO `helpe_admin_log` VALUES (35, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}', 1533974224, 1);
INSERT INTO `helpe_admin_log` VALUES (36, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\"}', 1533974228, 1);
INSERT INTO `helpe_admin_log` VALUES (37, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}', 1533974245, 1);
INSERT INTO `helpe_admin_log` VALUES (38, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}', 1533974249, 1);
INSERT INTO `helpe_admin_log` VALUES (39, 3, 'fav', 'delete', '/fav/delete', 'id=1', '{\"id\":\"1\",\"uid\":\"1\",\"itemid\":\"1\",\"ct\":\"0\",\"mt\":\"0\",\"username\":\"Answer123\",\"itemname\":\"test1\"}', 1533975687, 1);
INSERT INTO `helpe_admin_log` VALUES (40, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}', 1533976832, 1);
INSERT INTO `helpe_admin_log` VALUES (41, 2, 'report', 'update', '/report/update', 'id=1', '{\"id\":\"1\",\"item_type\":\"2\",\"item_value\":\"1\",\"reason\":\"2\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"5\"}', 1533976854, 1);
INSERT INTO `helpe_admin_log` VALUES (42, 2, 'menu', 'update', '/menu/update', 'id=21', '{\"id\":\"21\",\"pid\":\"0\",\"menu_name\":\"评论后台管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"feedback/index\",\"status\":\"1\",\"sort\":\"100\"}', 1533982108, 1);
COMMIT;

-- ----------------------------
-- Table structure for helpe_arrange
-- ----------------------------
DROP TABLE IF EXISTS `helpe_arrange`;
CREATE TABLE `helpe_arrange` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '事件标题',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '事件描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态[0 - 待处理 1 - 已委派 2 - 完成 3 延期]',
  `time_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '事件状态[0 - 延缓 1 - 正常 2 - 紧急]',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '委派管理员',
  `start_at` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_at` int(11) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `created_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建用户',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `updated_id` int(11) NOT NULL DEFAULT '0' COMMENT '修改用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日程记录信息表';

-- ----------------------------
-- Table structure for helpe_auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `helpe_auth_assignment`;
CREATE TABLE `helpe_auth_assignment` (
  `item_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `auth_assignment_user_id_idx` (`user_id`),
  CONSTRAINT `helpe_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_auth_assignment
-- ----------------------------
BEGIN;
INSERT INTO `helpe_auth_assignment` VALUES ('admin', '2', 1519919184);
INSERT INTO `helpe_auth_assignment` VALUES ('administrator', '1', 1519919184);
COMMIT;

-- ----------------------------
-- Table structure for helpe_auth_item
-- ----------------------------
DROP TABLE IF EXISTS `helpe_auth_item`;
CREATE TABLE `helpe_auth_item` (
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `helpe_auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `helpe_auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_auth_item
-- ----------------------------
BEGIN;
INSERT INTO `helpe_auth_item` VALUES ('admin', 1, '管理员', NULL, NULL, 1519919184, 1523084344);
INSERT INTO `helpe_auth_item` VALUES ('admin-log/delete', 2, '操作日志-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin-log/delete-all', 2, '操作日志-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin-log/export', 2, '操作日志-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin-log/index', 2, '操作日志-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin-log/search', 2, '操作日志-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/address', 2, '管理员信息信息-查询地址', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/create', 2, '管理员信息-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/delete', 2, '管理员信息-删除数据', 'admin-delete', NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/delete-all', 2, '管理员信息-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/editable', 2, '管理员信息-行内编辑', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/export', 2, '管理员信息-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/index', 2, '管理员信息-显示数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/search', 2, '管理员信息-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/update', 2, '管理员信息-修改数据', 'admin', NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/upload', 2, '管理员信息-上传头像', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('admin/view', 2, '管理员信息-显示详情', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('administrator', 1, '超级管理员', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/arrange', 2, '我的日程-查询数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/calendar', 2, '我的日程-查看详情', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/create', 2, '日程管理-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/delete', 2, '日程管理-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/delete-all', 2, '日程信息-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/editable', 2, '日程管理-行内编辑', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/export', 2, '日程信息-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/index', 2, '日程管理-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/search', 2, '日程管理-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('arrange/update', 2, '日程管理-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-assignment/create', 2, '角色分配-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-assignment/delete', 2, '角色分配-删除数据', 'auth-assignment', NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-assignment/export', 2, '角色分配-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-assignment/index', 2, '角色分配-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-assignment/search', 2, '角色分配-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/create', 2, '规则管理-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/delete', 2, '规则管理-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/delete-all', 2, '规则管理-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/export', 2, '规则管理-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/index', 2, '规则管理-显示数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/search', 2, '规则管理-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('auth-rule/update', 2, '规则管理-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/create', 2, '权限信息-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/delete', 2, '权限信息-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/delete-all', 2, '权限信息-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/export', 2, '权限信息-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/index', 2, '权限信息-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/search', 2, '权限信息-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('authority/update', 2, '权限信息-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('category/create', 2, '添加数据-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('category/delete', 2, '删除数据-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('category/delete-all', 2, '批量删除-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('category/export', 2, '导出数据-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('category/index', 2, '显示数据-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('category/search', 2, '搜索数据-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('category/update', 2, '修改数据-分类管理', NULL, NULL, 1523082391, 1523082391);
INSERT INTO `helpe_auth_item` VALUES ('china/create', 2, '地址信息-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('china/delete', 2, '地址信息-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('china/delete-all', 2, '地址信息-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('china/export', 2, '地址信息-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('china/index', 2, '地址信息-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('china/search', 2, '地址信息-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('china/update', 2, '地址信息-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('fav/create', 2, '添加数据-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('fav/delete', 2, '删除数据-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('fav/delete-all', 2, '批量删除-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('fav/export', 2, '导出数据-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('fav/index', 2, '显示数据-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('fav/search', 2, '搜索数据-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('fav/update', 2, '修改数据-用户收藏管理', NULL, NULL, 1523090512, 1523090512);
INSERT INTO `helpe_auth_item` VALUES ('feedback/create', 2, '添加数据-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('feedback/delete', 2, '删除数据-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('feedback/delete-all', 2, '批量删除-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('feedback/export', 2, '导出数据-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('feedback/index', 2, '显示数据-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('feedback/search', 2, '搜索数据-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('feedback/update', 2, '修改数据-评论后台管理', NULL, NULL, 1533982077, 1533982077);
INSERT INTO `helpe_auth_item` VALUES ('follow/create', 2, '添加数据-用户关注管理', NULL, NULL, 1524401961, 1524402489);
INSERT INTO `helpe_auth_item` VALUES ('follow/delete', 2, '删除数据-用户关注管理', NULL, NULL, 1524401961, 1524402495);
INSERT INTO `helpe_auth_item` VALUES ('follow/delete-all', 2, '批量删除-用户关注管理', NULL, NULL, 1524401961, 1524402516);
INSERT INTO `helpe_auth_item` VALUES ('follow/export', 2, '导出数据-用户关注管理', NULL, NULL, 1524401961, 1524402500);
INSERT INTO `helpe_auth_item` VALUES ('follow/index', 2, '显示数据-用户关注管理', NULL, NULL, 1524401961, 1524402483);
INSERT INTO `helpe_auth_item` VALUES ('follow/search', 2, '搜索数据-用户关注管理', NULL, NULL, 1524401961, 1524402505);
INSERT INTO `helpe_auth_item` VALUES ('follow/update', 2, '修改数据-用户关注管理', NULL, NULL, 1524401961, 1524402511);
INSERT INTO `helpe_auth_item` VALUES ('market-log/create', 2, '添加数据-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('market-log/delete', 2, '删除数据-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('market-log/delete-all', 2, '批量删除-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('market-log/export', 2, '导出数据-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('market-log/index', 2, '显示数据-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('market-log/search', 2, '搜索数据-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('market-log/update', 2, '修改数据-推送信息查看', NULL, NULL, 1524408977, 1524408977);
INSERT INTO `helpe_auth_item` VALUES ('menu/create', 2, '导航栏目-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('menu/delete', 2, '导航栏目-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('menu/delete-all', 2, '导航栏目-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('menu/export', 2, '导航栏目-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('menu/index', 2, '导航栏目-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('menu/search', 2, '导航栏目-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('menu/update', 2, '导航栏目-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('module/create', 2, '模块生成-生成预览表单', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('module/index', 2, '模块生成-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('module/produce', 2, '模块生成-生成文件', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('module/update', 2, '模块生成-生成预览文件', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/create', 2, '登录信息表-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/delete', 2, '登录信息表-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/delete-all', 2, '登录信息表-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/export', 2, '登录信息表-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/index', 2, '登录信息表-显示数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/search', 2, '登录信息表-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('passport/update', 2, '登录信息表-更新数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/create', 2, '注册信息表-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/delete', 2, '注册信息表-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/delete-all', 2, '注册信息表-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/export', 2, '注册信息表-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/index', 2, '注册信息表-显示数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/search', 2, '注册信息表-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('register/update', 2, '注册信息表-更新数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('report/create', 2, '添加数据-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('report/delete', 2, '删除数据-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('report/delete-all', 2, '批量删除-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('report/export', 2, '导出数据-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('report/index', 2, '显示数据-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('report/search', 2, '搜索数据-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('report/update', 2, '修改数据-举报信息管理', NULL, NULL, 1533969672, 1533969672);
INSERT INTO `helpe_auth_item` VALUES ('role/create', 2, '角色信息-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/delete', 2, '角色信息-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/edit', 2, '角色信息-分配权限', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/export', 2, '角色信息-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/index', 2, '角色信息-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/search', 2, '角色信息-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/update', 2, '角色信息-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('role/view', 2, '角色权限-查看详情', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/create', 2, '上传文件-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/delete', 2, '上传文件-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/delete-all', 2, '上传文件-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/export', 2, '上传文件-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/index', 2, '上传文件-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/search', 2, '上传文件-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('uploads/update', 2, '上传文件-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/create', 2, '用户信息-添加数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/delete', 2, '用户信息-删除数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/delete-all', 2, '用户信息-批量删除', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/export', 2, '用户信息-导出数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/index', 2, '用户信息-显示页面', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/search', 2, '用户信息-搜索数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/update', 2, '用户信息-修改数据', NULL, NULL, 1519919184, 1519919184);
INSERT INTO `helpe_auth_item` VALUES ('user/userinfo', 2, '用户信息-用户详情', NULL, NULL, 1532148836, 1532148864);
COMMIT;

-- ----------------------------
-- Table structure for helpe_auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `helpe_auth_item_child`;
CREATE TABLE `helpe_auth_item_child` (
  `parent` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `helpe_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `helpe_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_auth_item_child
-- ----------------------------
BEGIN;
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin-log/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin-log/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin-log/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin-log/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin-log/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin-log/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin-log/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin-log/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin-log/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin-log/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/address');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/address');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/editable');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/editable');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/upload');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/upload');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'admin/view');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'admin/view');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/arrange');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/arrange');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/calendar');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/calendar');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/editable');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/editable');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'arrange/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'arrange/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-assignment/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-assignment/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-assignment/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-assignment/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-assignment/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-assignment/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-assignment/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-assignment/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-assignment/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-assignment/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'auth-rule/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'auth-rule/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'authority/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'authority/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'category/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'category/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'china/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'china/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'fav/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'feedback/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'follow/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'market-log/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'menu/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'menu/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'module/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'module/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'module/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'module/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'module/produce');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'module/produce');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'module/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'module/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'passport/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'passport/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'register/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'register/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'report/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/edit');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/edit');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'role/view');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'role/view');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'uploads/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'uploads/update');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/create');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/create');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/delete');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/delete-all');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/export');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/export');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/index');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/index');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/search');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/search');
INSERT INTO `helpe_auth_item_child` VALUES ('admin', 'user/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/update');
INSERT INTO `helpe_auth_item_child` VALUES ('administrator', 'user/userinfo');
COMMIT;

-- ----------------------------
-- Table structure for helpe_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `helpe_auth_rule`;
CREATE TABLE `helpe_auth_rule` (
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_auth_rule
-- ----------------------------
BEGIN;
INSERT INTO `helpe_auth_rule` VALUES ('admin', 0x4F3A32333A226261636B656E645C72756C65735C41646D696E52756C65223A333A7B733A343A226E616D65223B733A353A2261646D696E223B733A393A22637265617465644174223B693A313439393030363036393B733A393A22757064617465644174223B693A313439393030363036393B7D, 1519919184, 1519919184);
INSERT INTO `helpe_auth_rule` VALUES ('admin-delete', 0x4F3A32393A226261636B656E645C72756C65735C41646D696E44656C65746552756C65223A333A7B733A343A226E616D65223B733A31323A2261646D696E2D64656C657465223B733A393A22637265617465644174223B693A313530313931393036363B733A393A22757064617465644174223B693A313530313931393036363B7D, 1519919184, 1519919184);
INSERT INTO `helpe_auth_rule` VALUES ('auth-assignment', 0x4F3A33323A226261636B656E645C72756C65735C4175746841737369676E6D656E7452756C65223A353A7B733A343A226E616D65223B733A31353A22617574682D61737369676E6D656E74223B733A393A22637265617465644174223B693A313530303130353233383B733A393A22757064617465644174223B693A313530303130353233383B733A34373A22206261636B656E645C72756C65735C4175746841737369676E6D656E7452756C652061646D696E526F6C654E616D65223B733A31333A2261646D696E6973747261746F72223B733A34333A22206261636B656E645C72756C65735C4175746841737369676E6D656E7452756C6520696E74557365724964223B693A313B7D, 1519919184, 1519919184);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='分类信息表';

-- ----------------------------
-- Records of helpe_category
-- ----------------------------
BEGIN;
INSERT INTO `helpe_category` VALUES (1, '古本', '', 0, 1, 1, 0, 1533965952);
INSERT INTO `helpe_category` VALUES (2, '売買', '', 0, 1, 1, 0, 1533962031);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_fav
-- ----------------------------
BEGIN;
INSERT INTO `helpe_fav` VALUES (2, 1, 2, 0, 0);
INSERT INTO `helpe_fav` VALUES (3, 1, 3, 0, 0);
INSERT INTO `helpe_fav` VALUES (4, 1, 4, 0, 0);
INSERT INTO `helpe_fav` VALUES (5, 4, 1, 0, 0);
INSERT INTO `helpe_fav` VALUES (6, 4, 2, 0, 0);
INSERT INTO `helpe_fav` VALUES (7, 4, 3, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for helpe_feedback
-- ----------------------------
DROP TABLE IF EXISTS `helpe_feedback`;
CREATE TABLE `helpe_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `content` text COMMENT '内容',
  `itemid` int(11) DEFAULT NULL COMMENT '商品编号',
  `flag` int(11) NOT NULL COMMENT '状态',
  `score` int(11) NOT NULL COMMENT '得分',
  `orderid` int(11) DEFAULT NULL COMMENT '订单编号',
  `uid` int(11) DEFAULT '0' COMMENT '评论用户',
  `owner` int(1) DEFAULT '0' COMMENT '所有者',
  `ct` int(11) DEFAULT NULL COMMENT '创建时间',
  `mt` int(11) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_oid` (`orderid`) USING BTREE,
  KEY `idx_item` (`itemid`) USING BTREE,
  KEY `idx_uid` (`uid`) USING BTREE,
  KEY `idx_uuid` (`owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='评论后台管理表';

-- ----------------------------
-- Records of helpe_feedback
-- ----------------------------
BEGIN;
INSERT INTO `helpe_feedback` VALUES (1, '测试不知道', 1, 1, 99, 1000001, 4, 7, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for helpe_follow
-- ----------------------------
DROP TABLE IF EXISTS `helpe_follow`;
CREATE TABLE `helpe_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uuid` (`uuid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_follow
-- ----------------------------
BEGIN;
INSERT INTO `helpe_follow` VALUES (1, 1, 1, 0, 0);
INSERT INTO `helpe_follow` VALUES (2, 1, 4, 0, 0);
INSERT INTO `helpe_follow` VALUES (3, 1, 5, 0, 0);
INSERT INTO `helpe_follow` VALUES (4, 4, 5, 0, 0);
INSERT INTO `helpe_follow` VALUES (5, 5, 5, 0, 0);
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
  `deadline` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '可能是发布过期时间的文字描述',
  `unit` varchar(30) NOT NULL COMMENT '单位',
  `pet` int(11) NOT NULL COMMENT '发布过期时间，服务90天，求助30天',
  PRIMARY KEY (`id`),
  KEY `aaid` (`aaid`),
  KEY `lng` (`lng`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- ----------------------------
-- Records of helpe_item
-- ----------------------------
BEGIN;
INSERT INTO `helpe_item` VALUES (1, 'test1', 0, 100.00, '/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg', 0, 1531580403, 1531580600, 8, 5, 133333, 0, 91, 0, 35.705, 139.767, 1531580403, 1, 'null', NULL, '次', 1539356405);
INSERT INTO `helpe_item` VALUES (2, '阿森纳球衣', 0, 5000.00, '/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg', 1, 1531580700, 1531580864, 8, 2, 133333, 0, 91, 0, 35.705, 139.767, 1531580700, 0, 'null', NULL, '件', 1539356864);
INSERT INTO `helpe_item` VALUES (3, '美国点心', 0, 5000.00, '/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg', 1, 1531580829, 1531580832, 8, 2, 133333, 0, 95, 0, 35.7097, 139.76, 1531580829, 1, 'null', NULL, '箱', 1539356832);
INSERT INTO `helpe_item` VALUES (4, '家庭教師', 0, 20000.00, '/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg', 0, 1531582035, 1531582036, 7, 6, 133333, 0, 96, 0, 35.6765, 139.852, 1531582035, 1, 'null', NULL, '円', 0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品详情表';

-- ----------------------------
-- Records of helpe_itemdetail
-- ----------------------------
BEGIN;
INSERT INTO `helpe_itemdetail` VALUES (1, 'null', 1531580403, 1531580403);
INSERT INTO `helpe_itemdetail` VALUES (2, 'null', 1531580700, 1531580700);
INSERT INTO `helpe_itemdetail` VALUES (3, 'null', 1531580829, 1531580829);
INSERT INTO `helpe_itemdetail` VALUES (4, 'null', 1531582035, 1531582035);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商品图片表';

-- ----------------------------
-- Records of helpe_itemimg
-- ----------------------------
BEGIN;
INSERT INTO `helpe_itemimg` VALUES (1, 1, '/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg', 8, 1531580403);
INSERT INTO `helpe_itemimg` VALUES (2, 2, '/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg', 8, 1531580700);
INSERT INTO `helpe_itemimg` VALUES (3, 3, '/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg', 8, 1531580829);
INSERT INTO `helpe_itemimg` VALUES (4, 4, '/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg', 7, 1531582035);
COMMIT;

-- ----------------------------
-- Table structure for helpe_mail_template
-- ----------------------------
DROP TABLE IF EXISTS `helpe_mail_template`;
CREATE TABLE `helpe_mail_template` (
  `type` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '类型',
  `desc` varchar(512) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '类型说明',
  `from` varchar(256) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '邮件来源',
  `subject` varchar(1024) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '邮件主题',
  `text` text CHARACTER SET utf8 COMMENT '文本内容',
  `html` text CHARACTER SET utf8 COMMENT '网页内容',
  `update_at` int(11) NOT NULL COMMENT '更新时间',
  `create_at` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮件模板信息表';

-- ----------------------------
-- Records of helpe_mail_template
-- ----------------------------
BEGIN;
INSERT INTO `helpe_mail_template` VALUES ('forgetPassword', '忘记密码邮件', 'service@helpe.online', 'Forget Password of helpe.online', 'Helpe アカウント\n認証 コード\n\nHelpe アカウント {{email}} には、次の認証コードをお使いください。\n\n認証コード：{{checkDigit}}\n\nお客様がこのコードを請求していない場合は、このメールを無視しても問題ありません。他のユーザーが誤ってお客様のメールアドレスを入力した可能性があります。\n\nサービスのご利用がありがとうございます。\n\nHelpeアカウント チーム', NULL, 0, 0);
INSERT INTO `helpe_mail_template` VALUES ('registerCheckDigit', '注册确认邮件', 'service@helpe.online', 'welcome to helpe.online', 'Helpe アカウント\n認証 コード\n\nHelpe アカウント {{email}} には、次の認証コードをお使いください。\n\n認証コード：{{checkDigit}}\n\nお客様がこのコードを請求していない場合は、このメールを無視しても問題ありません。他のユーザーが誤ってお客様のメールアドレスを入力した可能性があります。\n\nサービスのご利用がありがとうございます。\n\nHelpeアカウント チーム', NULL, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for helpe_market_log
-- ----------------------------
DROP TABLE IF EXISTS `helpe_market_log`;
CREATE TABLE `helpe_market_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `tpid` int(11) NOT NULL DEFAULT '0' COMMENT '交易信息类型id',
  `data` varchar(100) DEFAULT NULL COMMENT 'json数据',
  `ct` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='推送信息表';

-- ----------------------------
-- Records of helpe_market_log
-- ----------------------------
BEGIN;
INSERT INTO `helpe_market_log` VALUES (1, 1, 1, '{\"username\":\"null\",\"itemname\":\"Iphone\"}', 1524063690);
INSERT INTO `helpe_market_log` VALUES (2, 1, 9, '{\"username\":\"ycyc1996\"}', 1525173268);
INSERT INTO `helpe_market_log` VALUES (3, 1, 9, '{\"username\":\"ycyc1996\"}', 1525173277);
INSERT INTO `helpe_market_log` VALUES (4, 2, 3, '{\"username\":\"ycyc1996\",\"itemname\":\"Iphone\"}', 1525174036);
INSERT INTO `helpe_market_log` VALUES (5, 1, 5, '{\"username\":\"ycyc1996\",\"itemname\":\"Iphone\"}', 1525244398);
INSERT INTO `helpe_market_log` VALUES (6, 2, 7, '{\"username\":\"null\",\"itemname\":\"Iphone\"}', 1525244398);
INSERT INTO `helpe_market_log` VALUES (7, 9, 1, '{\"username\":\"null\",\"itemname\":\"\\u53d1\\u5e03\\u7b2c\\u4e00\\u6761\"}', 1528185124);
INSERT INTO `helpe_market_log` VALUES (8, 9, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"\\u53d1\\u5e03\\u7b2c\\u4e00\\u6761\"}', 1528960335);
INSERT INTO `helpe_market_log` VALUES (9, 8, 1, '{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}', 1528961178);
INSERT INTO `helpe_market_log` VALUES (10, 1, 3, '{\"username\":\"DMChoicer\",\"itemname\":\"Test\"}', 1528961216);
INSERT INTO `helpe_market_log` VALUES (11, 9, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"\\u53d1\\u5e03\\u7b2c\\u4e00\\u6761\"}', 1529497105);
INSERT INTO `helpe_market_log` VALUES (12, 1, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}', 1530162995);
INSERT INTO `helpe_market_log` VALUES (13, 1, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}', 1530167546);
INSERT INTO `helpe_market_log` VALUES (14, 8, 1, '{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}', 1530186479);
INSERT INTO `helpe_market_log` VALUES (15, 1, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}', 1530197405);
INSERT INTO `helpe_market_log` VALUES (16, 1, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}', 1530197412);
INSERT INTO `helpe_market_log` VALUES (17, 1, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}', 1530197418);
INSERT INTO `helpe_market_log` VALUES (18, 1, 1, '{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}', 1530197425);
INSERT INTO `helpe_market_log` VALUES (19, 8, 1, '{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}', 1530197880);
INSERT INTO `helpe_market_log` VALUES (20, 8, 1, '{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}', 1530197894);
INSERT INTO `helpe_market_log` VALUES (21, 1, 15, '{\"username\":\"ycyc1996120\",\"itemname\":\"test22\"}', 1530204602);
INSERT INTO `helpe_market_log` VALUES (22, 8, 16, '{\"username\":\"ycyc1996120\",\"itemname\":\"test22\"}', 1530204603);
INSERT INTO `helpe_market_log` VALUES (23, 8, 9, '{\"username\":\"DMChoicer\"}', 1530269299);
COMMIT;

-- ----------------------------
-- Table structure for helpe_menu
-- ----------------------------
DROP TABLE IF EXISTS `helpe_menu`;
CREATE TABLE `helpe_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '导航栏目ID',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父类ID(只支持两级)',
  `menu_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '导航栏目',
  `icons` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'icon-desktop' COMMENT '使用的小图标',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'site/index' COMMENT '访问地址',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` smallint(6) NOT NULL DEFAULT '100' COMMENT '排序',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `created_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建用户',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `updated_id` int(11) NOT NULL DEFAULT '0' COMMENT '修改用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='后台导航栏目信息表';

-- ----------------------------
-- Records of helpe_menu
-- ----------------------------
BEGIN;
INSERT INTO `helpe_menu` VALUES (1, 0, '后台功能管理', 'menu-icon fa fa-cog', '', 1, 2, 1519919184, 1, 1532147019, 1);
INSERT INTO `helpe_menu` VALUES (2, 1, '管理员信息', '', 'admin/index', 1, 1, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (3, 1, '角色管理', '', 'role/index', 1, 2, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (4, 1, '角色分配', 'icon-cog', 'auth-assignment/index', 1, 3, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (5, 1, '权限管理', '', 'authority/index', 1, 4, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (6, 1, '规则管理', 'menu-icon fa fa-shield', 'auth-rule/index', 1, 5, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (7, 1, '导航栏目', '', 'menu/index', 1, 6, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (8, 1, '模块生成', '', 'module/index', 1, 7, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (9, 1, '操作日志', '', 'admin-log/index', 1, 8, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (10, 0, '地址信息', 'menu-icon fa fa-bank', 'china/index', 0, 4, 1519919184, 1, 1532143519, 1);
INSERT INTO `helpe_menu` VALUES (11, 0, '用户信息', 'menu-icon fa fa-user', 'user/index', 1, 3, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (12, 0, '日程管理', 'menu-icon fa fa-calendar', 'arrange/index', 0, 1, 1519919184, 1, 1532143527, 1);
INSERT INTO `helpe_menu` VALUES (13, 0, '上传文件', 'menu-icon fa fa-upload', 'uploads/index', 0, 9, 1519919184, 1, 1532143533, 1);
INSERT INTO `helpe_menu` VALUES (14, 0, '注册信息表', 'menu-icon fa fa-cog', 'register/index', 1, 30, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (15, 0, '登录信息表', 'menu-icon fa fa-cog', 'passport/index', 1, 100, 1519919184, 1, 1519919184, 1);
INSERT INTO `helpe_menu` VALUES (16, 0, '分类管理', 'menu-icon fa fa-cog', 'category/index', 1, 100, 1523082391, 1, 1523082391, 1);
INSERT INTO `helpe_menu` VALUES (17, 0, '用户收藏管理', 'menu-icon fa fa-cog', 'fav/index', 1, 100, 1523090512, 1, 1523090512, 1);
INSERT INTO `helpe_menu` VALUES (18, 0, '用户关注管理', 'menu-icon fa fa-cog', 'follow/index', 1, 120, 1524401961, 1, 1524402547, 1);
INSERT INTO `helpe_menu` VALUES (19, 0, '推送信息查看', 'menu-icon fa fa-cog', 'market-log/index', 1, 100, 1524408977, 1, 1524409010, 1);
INSERT INTO `helpe_menu` VALUES (20, 0, '举报信息管理', 'menu-icon fa fa-cog', 'report/index', 1, 100, 1533969672, 1, 1533971332, 1);
INSERT INTO `helpe_menu` VALUES (21, 0, '评论后台管理', 'menu-icon fa fa-cog', 'feedback/index', 1, 100, 1533982077, 1, 1533982108, 1);
COMMIT;

-- ----------------------------
-- Table structure for helpe_migration
-- ----------------------------
DROP TABLE IF EXISTS `helpe_migration`;
CREATE TABLE `helpe_migration` (
  `version` varchar(180) CHARACTER SET utf8 NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of helpe_migration
-- ----------------------------
BEGIN;
INSERT INTO `helpe_migration` VALUES ('m000000_000000_base', 1519919172);
INSERT INTO `helpe_migration` VALUES ('m130524_201442_init', 1519919184);
INSERT INTO `helpe_migration` VALUES ('m140506_102106_rbac_init', 1519919174);
INSERT INTO `helpe_migration` VALUES ('m170801_061245_create_menu', 1519919184);
INSERT INTO `helpe_migration` VALUES ('m170801_072726_create_admin', 1519919184);
INSERT INTO `helpe_migration` VALUES ('m170801_074527_create_arrange', 1519919184);
INSERT INTO `helpe_migration` VALUES ('m170801_081237_insert_rabc', 1519919184);
INSERT INTO `helpe_migration` VALUES ('m170804_163745_create_china', 1519919185);
INSERT INTO `helpe_migration` VALUES ('m170805_100055_create_admin_log', 1519919185);
INSERT INTO `helpe_migration` VALUES ('m170907_052038_rbac_add_index_on_auth_assignment_user_id', 1519919174);
INSERT INTO `helpe_migration` VALUES ('m171118_082050_create_uploads', 1519919185);
COMMIT;

-- ----------------------------
-- Table structure for helpe_orderaddr
-- ----------------------------
DROP TABLE IF EXISTS `helpe_orderaddr`;
CREATE TABLE `helpe_orderaddr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `aid` int(11) NOT NULL COMMENT '地址id',
  `info` varchar(50) NOT NULL COMMENT '同address表中info',
  `ct` int(11) NOT NULL,
  `lat` float NOT NULL DEFAULT '0' COMMENT '同address表中对应字段',
  `lng` float NOT NULL DEFAULT '0' COMMENT '同address表中对应字段',
  `orderid` int(11) NOT NULL COMMENT '订单id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `orderid` (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单地址表';

-- ----------------------------
-- Table structure for helpe_orderinfo
-- ----------------------------
DROP TABLE IF EXISTS `helpe_orderinfo`;
CREATE TABLE `helpe_orderinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` bigint(20) NOT NULL COMMENT '应该是订单号',
  `uid` int(11) NOT NULL COMMENT '下单者IDuid',
  `status` int(11) NOT NULL COMMENT 'status \n0 初始状态\n10 订单接受\n20 订单到达\n30 订单付款\n40 订单结束\n50 订单拒绝\n60 订单取消',
  `ordertp` int(11) NOT NULL COMMENT '订单类型，暂时未使用，默认0',
  `cash` decimal(11,2) NOT NULL COMMENT '价格',
  `ct` int(11) NOT NULL COMMENT '创建时间',
  `pt` int(11) NOT NULL COMMENT 'item发布时间',
  `mt` int(11) NOT NULL COMMENT '修改时间',
  `itemid` int(11) NOT NULL COMMENT '商品id',
  `num` int(11) NOT NULL COMMENT '数量',
  `type` smallint(2) NOT NULL COMMENT '商品item类型',
  `owner` int(11) NOT NULL COMMENT '商品item的所有者uid',
  `changeprice` decimal(11,2) NOT NULL COMMENT '差价',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `paytp` smallint(3) NOT NULL DEFAULT '1' COMMENT '支付类型',
  `fd` smallint(1) DEFAULT '0' COMMENT '是否评论',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单详情表';

-- ----------------------------
-- Table structure for helpe_passport
-- ----------------------------
DROP TABLE IF EXISTS `helpe_passport`;
CREATE TABLE `helpe_passport` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` tinyint(4) NOT NULL COMMENT '用户类型',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名(邮件名)',
  `password` varchar(60) DEFAULT '' COMMENT '密码',
  `token` varchar(512) DEFAULT '' COMMENT 'token',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='登录信息表';

-- ----------------------------
-- Records of helpe_passport
-- ----------------------------
BEGIN;
INSERT INTO `helpe_passport` VALUES (1, 1, '497414900@qq.com', '$2y$13$49scLlPeLBHOzcCbZkcv8uVtTllnDLupFTx/eTSJi6iTVSpyEbjzm', '', 1522398633, 1522398633);
INSERT INTO `helpe_passport` VALUES (3, 1, 'mcz1515@yahoo.co.jp', '$2y$13$gSich53s4kxtQ2sZSEze0Oq61d6/gm7wZtdJ3QiD19ssjyWXEgVMu', '', 1526340889, 1526340889);
INSERT INTO `helpe_passport` VALUES (4, 1, '824322790@qq.com', '$2y$13$OZwQ.SLJ2RavvaSMPCbRF.Ou1ZjN8HPYItCwG4mpntN.lZBWfeo6q', '', 1526381754, 1526381754);
INSERT INTO `helpe_passport` VALUES (5, 1, 'answer_yyc@163.com', '$2y$13$9LuKrVXQD4Z8t032H6c5feZ3Q3zrp5aBqB0Z/KpoklhbIg8A3UZCK', '', 1526382334, 1526382334);
INSERT INTO `helpe_passport` VALUES (6, 1, 'morningciciq@gmail.com', '$2y$13$ZfE32Kl/Dww9kh9hsgycnOjjlYtoAYrnjRMLtaF4EHXF6UK.EAVWS', '', 1526382402, 1526382402);
INSERT INTO `helpe_passport` VALUES (7, 1, 'dongzhutian09@qq.com', '$2y$13$sf4Iz8AETNrPNtna/q9eoOInAYvfpKpqyraJSBL0SRPP6zAdh8woK', '', 1526384999, 1526384999);
INSERT INTO `helpe_passport` VALUES (8, 1, '524881676@qq.com', '$2y$13$zSefnIsSgEkNPElSljhNSO8iZP8tSlBESpXmWI7zAaXgL5eUG3VgG', '', 1526440454, 1526440454);
INSERT INTO `helpe_passport` VALUES (9, 2, '494376395@qq.com', '$2y$13$iMXTlO8e4m8Zei4OUaR3Aez66SbKvSoyd3x/pGz8.01kpTgaoDOzC', '', 1532069429, 1532069429);
COMMIT;

-- ----------------------------
-- Table structure for helpe_recommend
-- ----------------------------
DROP TABLE IF EXISTS `helpe_recommend`;
CREATE TABLE `helpe_recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `img` varchar(255) NOT NULL COMMENT '宣传图链接',
  `rcid` int(11) NOT NULL COMMENT '发布类型',
  `mark` text NOT NULL COMMENT '详情',
  `url` varchar(255) NOT NULL COMMENT '官网地址',
  `itemid` int(11) NOT NULL COMMENT '商品id',
  `pub_username` varchar(255) NOT NULL COMMENT '发布人名字',
  `ct` int(11) NOT NULL COMMENT '创建时间',
  `mt` int(11) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='推荐商品，发现功能';

-- ----------------------------
-- Records of helpe_recommend
-- ----------------------------
BEGIN;
INSERT INTO `helpe_recommend` VALUES (1, '好东西', '/', 1, 'jjsj', 'http://aaaa', 2, 'test11', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for helpe_recommend_category
-- ----------------------------
DROP TABLE IF EXISTS `helpe_recommend_category`;
CREATE TABLE `helpe_recommend_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jp_name` varchar(50) NOT NULL,
  `cn_name` varchar(50) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  `flag` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  `mt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='发布推荐分类信息表';

-- ----------------------------
-- Records of helpe_recommend_category
-- ----------------------------
BEGIN;
INSERT INTO `helpe_recommend_category` VALUES (1, 'jp name', 'cn name', 0, 1, 1, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for helpe_register
-- ----------------------------
DROP TABLE IF EXISTS `helpe_register`;
CREATE TABLE `helpe_register` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '电子邮件',
  `auth_token` varchar(12) NOT NULL DEFAULT '' COMMENT '校验key',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='注册信息表';

-- ----------------------------
-- Records of helpe_register
-- ----------------------------
BEGIN;
INSERT INTO `helpe_register` VALUES (1, '497414900@qq.com', 'qEIJvX', 1522396808, 1522396808);
INSERT INTO `helpe_register` VALUES (2, '497414900@qq.com', 'QjBv4W', 1522397049, 1522397049);
INSERT INTO `helpe_register` VALUES (3, '497414900@qq.com', 'UWNBFi', 1522397235, 1522397235);
INSERT INTO `helpe_register` VALUES (4, '497414900@qq.com', 'Wqc7Hc', 1522397601, 1522397601);
INSERT INTO `helpe_register` VALUES (5, '497414900@qq.com', 'dqrDrH', 1522397907, 1522397907);
INSERT INTO `helpe_register` VALUES (6, '497414900@qq.com', 'ZB5qEJ', 1522398043, 1522398043);
INSERT INTO `helpe_register` VALUES (7, '123456@qq.com', '3PP8Vn', 1522679684, 1522679684);
INSERT INTO `helpe_register` VALUES (8, 'ft20082@qq.com', 'T7J856', 1522679710, 1522679710);
INSERT INTO `helpe_register` VALUES (12, 'mcz1515@yahoo.co.jp', 'CENdwm', 1526340841, 1526340841);
INSERT INTO `helpe_register` VALUES (13, 'morningciciq@gmail.com', 'jhnNa7', 1526373662, 1526373662);
INSERT INTO `helpe_register` VALUES (14, '824322790@qq.com', 'DXcwFD', 1526381452, 1526381452);
INSERT INTO `helpe_register` VALUES (15, '824322790@qq.com', 'HUgw2i', 1526381727, 1526381727);
INSERT INTO `helpe_register` VALUES (16, 'answer_yyc@163.com', 'k6jJyy', 1526381971, 1526381971);
INSERT INTO `helpe_register` VALUES (17, 'morningciciq@gmail.com', 'ppx7qm', 1526382348, 1526382348);
INSERT INTO `helpe_register` VALUES (18, 'dongzhutian09@qq.com', 'X3CDbm', 1526384959, 1526384959);
INSERT INTO `helpe_register` VALUES (19, '524881676@qq.com', '8tKa4X', 1526440318, 1526440318);
INSERT INTO `helpe_register` VALUES (20, 'aaa@aaa.aaa.aaa', 'ABFUFK', 1529412490, 1529412490);
INSERT INTO `helpe_register` VALUES (21, '1115290u@g.hit-u.ac.jp', 'HfyHuN', 1529498527, 1529498527);
INSERT INTO `helpe_register` VALUES (22, 'ft20082@qq.com', 'EA9sHS', 1529641494, 1529641494);
INSERT INTO `helpe_register` VALUES (23, '78909230@qq.com', 'nE8NpU', 1531117395, 1531117395);
INSERT INTO `helpe_register` VALUES (24, '494376395@qq.com', 'g5hWTB', 1532066875, 1532066875);
INSERT INTO `helpe_register` VALUES (25, '494376395@qq.com', 'cXvikQ', 1532066875, 1532066875);
INSERT INTO `helpe_register` VALUES (26, '494376395@qq.com', 'qpHnms', 1532066875, 1532066875);
INSERT INTO `helpe_register` VALUES (27, '494376395@qq.com', 'w4vBun', 1532067355, 1532067355);
COMMIT;

-- ----------------------------
-- Table structure for helpe_report
-- ----------------------------
DROP TABLE IF EXISTS `helpe_report`;
CREATE TABLE `helpe_report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `item_type` int(11) NOT NULL COMMENT '类型',
  `item_value` int(11) NOT NULL COMMENT '商品/道具ID',
  `reason` tinyint(11) NOT NULL COMMENT '举报原因',
  `info` text COMMENT '举报详细',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态,1系统提交2人工处理',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '举报用户编号',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='举报表';

-- ----------------------------
-- Records of helpe_report
-- ----------------------------
BEGIN;
INSERT INTO `helpe_report` VALUES (1, 2, 1, 2, '看不懂啊', 0, 5, 0, 1533976854);
COMMIT;

-- ----------------------------
-- Table structure for helpe_uploads
-- ----------------------------
DROP TABLE IF EXISTS `helpe_uploads`;
CREATE TABLE `helpe_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '文件名称',
  `url` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '访问地址[可以是json字符串]',
  `multiple` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为多图片上传',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='上传文件信息表';

-- ----------------------------
-- Table structure for helpe_user
-- ----------------------------
DROP TABLE IF EXISTS `helpe_user`;
CREATE TABLE `helpe_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'passport_id',
  `type` tinyint(4) DEFAULT '1' COMMENT '账号类型',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '电子邮件',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `access_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '',
  `password_reset_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `face` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `gender` tinyint(4) DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `career` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '职业',
  `city` int(11) DEFAULT NULL COMMENT '所在城市',
  `cityinfo` varchar(120) DEFAULT NULL,
  `tel` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电话',
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '最近1次客户端IP',
  `info` int(11) DEFAULT NULL COMMENT '用户说明',
  `status` tinyint(4) DEFAULT '1' COMMENT '用户状态1正常',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`email`),
  KEY `access_token` (`access_token`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of helpe_user
-- ----------------------------
BEGIN;
INSERT INTO `helpe_user` VALUES (1, 1, '497414900@qq.com', 'Answer123', 'RvE247BZIz6wT8uDXAhGX2ndvM5TPHftz9Aj4ymZ', NULL, '/images/avatars/su2CQMbceqHk8eW_1527001293.jpg', 0, NULL, 'Stu', 0, NULL, NULL, '49.221.207.189', NULL, 1, 1522398633, 1532108408);
INSERT INTO `helpe_user` VALUES (4, 1, 'mcz1515@yahoo.co.jp', 'user4', 'MtqY473r3nDcKddFQTjvShh8FasHCQkDmVPy8ihb', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '126.11.212.29', NULL, 1, 1526340889, 1526340890);
INSERT INTO `helpe_user` VALUES (5, 1, '824322790@qq.com', 'user5', '', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '49.221.207.244', NULL, 1, 1526381754, 1526381950);
INSERT INTO `helpe_user` VALUES (6, 1, 'answer_yyc@163.com', 'user6', 'XSVGVpEEFDYMNUcjVCbvuTrwYaPWYRyb2CiGCqGc', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '49.221.207.6', NULL, 1, 1526382334, 1526644120);
INSERT INTO `helpe_user` VALUES (7, 1, 'morningciciq@gmail.com', 'user7', 'da8FeIsgvxgRxPPUyappYaiCWcj9p8442mNIkMie', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '49.98.149.114', NULL, 1, 1526382402, 1526382402);
INSERT INTO `helpe_user` VALUES (8, 1, 'dongzhutian09@qq.com', 'DMChoicer', 'e3EmfFx5cWiGVN5WXw4nmmEesKQDfhiWgrPSeQek', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '118.21.152.179', NULL, 1, 1526384999, 1531580355);
INSERT INTO `helpe_user` VALUES (9, 1, '524881676@qq.com', 'f1111', 'ZJpbFsPvbxBxwYRNbyXGsbahy9WrQnqQkzDsASVp', NULL, '/images/avatars/69tFNyZAgY2YtZq_1526991995.jpeg', 3, NULL, NULL, NULL, 'x1234', NULL, '218.80.0.27', NULL, 1, 1526440454, 1527781098);
INSERT INTO `helpe_user` VALUES (10, 1, '494376395@qq.com', '大徒弟', '8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '115.238.194.18', NULL, 1, 1532069429, 1533968601);
COMMIT;

-- ----------------------------
-- Table structure for helpe_user_private
-- ----------------------------
DROP TABLE IF EXISTS `helpe_user_private`;
CREATE TABLE `helpe_user_private` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限编号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `private` varchar(30) NOT NULL DEFAULT '' COMMENT '权限key',
  `expire` int(11) NOT NULL COMMENT '过期时间',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户特定功能限制,设计思路,某个功能限制多久,默认都是开放,如果有,则限制时间,private:timestamp';

SET FOREIGN_KEY_CHECKS = 1;
