# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.23)
# Database: db_helpe
# Generation Time: 2018-08-18 12:07:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table helpe_address
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_address` WRITE;
/*!40000 ALTER TABLE `helpe_address` DISABLE KEYS */;

INSERT INTO `helpe_address` (`id`, `uid`, `aid`, `info`, `lat`, `lng`, `ct`, `mt`)
VALUES
	(84,1,0,'华东理工大学',1,1,1522162893,1522162893),
	(85,1,0,'apple store',37.7854,-122.408,1524040260,1524040260),
	(86,2,0,'apple store',37.7858,-122.406,1524063276,1524063276),
	(87,4,0,'kuresuto',35.8393,139.736,1526341226,1526341226),
	(88,6,0,'apple',37.7855,-122.407,1526384136,1526384136),
	(89,1,0,'家',31.2584,121.444,1526384481,1526384481),
	(90,1,0,'家',35.7738,103.184,1526384496,1526384496),
	(91,8,0,'家',35.705,139.767,1526385016,1526385016),
	(92,9,0,'2567777',31.2486,121.562,1526449536,1526449536),
	(93,1,0,'apple street',37.7858,-122.406,1531486096,1531486096),
	(94,1,0,'apple street',37.7858,-122.406,1531486474,1531486474),
	(95,8,0,'東大',35.7097,139.76,1531580822,1531580822),
	(96,7,0,'新宿駅東口',35.6765,139.852,1531582024,1531582024);

/*!40000 ALTER TABLE `helpe_address` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_admin
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员信息表';

LOCK TABLES `helpe_admin` WRITE;
/*!40000 ALTER TABLE `helpe_admin` DISABLE KEYS */;

INSERT INTO `helpe_admin` (`id`, `username`, `email`, `face`, `role`, `status`, `auth_key`, `password_hash`, `password_reset_token`, `last_time`, `last_ip`, `address`, `created_at`, `created_id`, `updated_at`, `updated_id`)
VALUES
	(1,'super','super@admin.com','','administrator',10,'gKkLFMdB2pvIXOFNpF_Aeemvdf1j0YUM','$2y$13$Nuf1mzDRoCMxrWI.rIjENu20QshJG41smdEeHFHxq0qdmS99YytHy','5vLaPpUS-I-XxJaoGP-GZDk474WdnaK3_1469073015',1534384602,'127.0.0.1','',1519919184,1,1534384602,1),
	(2,'admin','admin@admin.com','','admin',10,'tArp_Kv4z1JlzBUZYCL33N24AZL-_77p','$2y$13$RNrJ7GK1A5iZRxBpho6sbeCJKfNRxzy5axCeRjZLqvA5W6RuVYBRW','CgScbf1E96N3pqH01b0mVi_Z58j8QsRV_1501916190',1521103495,'127.0.0.1','',1519919184,1,1521103495,2);

/*!40000 ALTER TABLE `helpe_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_admin_log
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员信息表';

LOCK TABLES `helpe_admin_log` WRITE;
/*!40000 ALTER TABLE `helpe_admin_log` DISABLE KEYS */;

INSERT INTO `helpe_admin_log` (`id`, `type`, `controller`, `action`, `url`, `index`, `params`, `created_at`, `created_id`)
VALUES
	(1,2,'menu','update','/menu/update','id=13','{\"id\":\"13\",\"pid\":\"0\",\"menu_name\":\"上传文件\",\"icons\":\"menu-icon fa fa-upload\",\"url\":\"uploads/index\",\"status\":\"0\",\"sort\":\"9\"}',1532142636,1),
	(2,2,'menu','update','/menu/update','id=13','{\"id\":\"13\",\"pid\":\"0\",\"menu_name\":\"上传文件\",\"icons\":\"menu-icon fa fa-upload\",\"url\":\"uploads/index\",\"status\":\"1\",\"sort\":\"9\"}',1532142674,1),
	(3,2,'menu','update','/menu/update','id=10','{\"id\":\"10\",\"pid\":\"0\",\"menu_name\":\"地址信息\",\"icons\":\"menu-icon fa fa-bank\",\"url\":\"china/index\",\"status\":\"0\",\"sort\":\"4\"}',1532143519,1),
	(4,2,'menu','update','/menu/update','id=12','{\"id\":\"12\",\"pid\":\"0\",\"menu_name\":\"日程管理\",\"icons\":\"menu-icon fa fa-calendar\",\"url\":\"arrange/index\",\"status\":\"0\",\"sort\":\"1\"}',1532143527,1),
	(5,2,'menu','update','/menu/update','id=13','{\"id\":\"13\",\"pid\":\"0\",\"menu_name\":\"上传文件\",\"icons\":\"menu-icon fa fa-upload\",\"url\":\"uploads/index\",\"status\":\"0\",\"sort\":\"9\"}',1532143533,1),
	(6,2,'menu','update','/menu/update','id=1','{\"id\":\"1\",\"pid\":\"0\",\"menu_name\":\"后台功能管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"\",\"status\":\"1\",\"sort\":\"2\"}',1532147019,1),
	(7,1,'authority','create','/authority/create','name=','{\"type\":\"2\",\"name\":\"\",\"newName\":\"user/userinfo\",\"description\":\"获取用户详情\",\"rule_name\":\"admin\"}',1532148836,1),
	(8,2,'authority','update','/authority/update','name=user/userinfo','{\"type\":\"2\",\"name\":\"user/userinfo\",\"newName\":\"user/userinfo\",\"description\":\"获取用户详情\",\"rule_name\":\"\"}',1532148844,1),
	(9,2,'authority','update','/authority/update','name=user/userinfo','{\"type\":\"2\",\"name\":\"user/userinfo\",\"newName\":\"user/userinfo\",\"description\":\"用户信息-用户详情\",\"rule_name\":\"admin\"}',1532148864,1),
	(10,3,'user','delete','/user/delete','id=10','{\"id\":\"10\",\"type\":\"1\",\"email\":\"494376395@qq.com\",\"username\":\"大徒弟\",\"access_token\":\"8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp\",\"password_reset_token\":\"\",\"face\":\"\",\"gender\":\"0\",\"birthday\":\"\",\"career\":\"\",\"city\":\"\",\"cityinfo\":\"\",\"tel\":\"\",\"ip\":\"115.238.194.18\",\"info\":\"\",\"status\":\"1\",\"created_at\":\"1532069429\",\"updated_at\":\"1532076136\"}',1532170905,1),
	(11,2,'user','delete','/user/delete','id=10','{\"id\":\"10\",\"type\":\"1\",\"email\":\"494376395@qq.com\",\"username\":\"大徒弟\",\"access_token\":\"8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp\",\"password_reset_token\":\"\",\"face\":\"\",\"gender\":\"0\",\"birthday\":\"\",\"career\":\"\",\"city\":\"\",\"cityinfo\":\"\",\"tel\":\"\",\"ip\":\"115.238.194.18\",\"info\":\"\",\"status\":\"1\",\"created_at\":\"1532069429\",\"updated_at\":\"1532076136\"}',1532176633,1),
	(12,2,'user','update','/user/update','id=10','{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"1\"}',1532180732,1),
	(13,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"\"}',1533961891,1),
	(14,2,'category','update','/category/update','id=2','{\"id\":\"2\",\"jp_name\":\"売買\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"\"}',1533962031,1),
	(15,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"0\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533961891\"}',1533962315,1),
	(16,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"0\",\"ct\":\"0\",\"mt\":\"1533962315\"}',1533962331,1),
	(17,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533962331\"}',1533962338,1),
	(18,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"0\",\"ct\":\"0\",\"mt\":\"1533962338\"}',1533963104,1),
	(19,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533963104\"}',1533963111,1),
	(20,2,'user','update','/user/update','id=10','{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"0\"}',1533965466,1),
	(21,2,'user','update','/user/update','id=10','{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"1\"}',1533965470,1),
	(22,2,'user','update','/user/update','id=10','{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"0\"}',1533965480,1),
	(23,2,'user','update','/user/update','id=10','{\"id\":\"10\",\"username\":\"大徒弟\",\"password\":\"\",\"repassword\":\"\",\"email\":\"494376395@qq.com\",\"status\":\"1\"}',1533965487,1),
	(24,2,'category','delete','/category/delete','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\",\"ct\":\"0\",\"mt\":\"1533963111\"}',1533965939,1),
	(25,2,'category','update','/category/update','id=1','{\"id\":\"1\",\"jp_name\":\"古本\",\"cn_name\":\"\",\"pid\":\"0\",\"sort\":\"1\",\"flag\":\"1\"}',1533965952,1),
	(26,2,'user','update','/user/update','id=10','{\"id\":\"10\",\"username\":\"大徒弟\",\"email\":\"494376395@qq.com\",\"access_token\":\"8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp\",\"password_reset_token\":\"\",\"ip\":\"115.238.194.18\",\"gender\":\"1\",\"birthday\":\"\",\"career\":\"\",\"cityinfo\":\"\",\"tel\":\"\",\"status\":\"1\"}',1533968601,1),
	(27,2,'menu','update','/menu/update','id=20','{\"id\":\"20\",\"pid\":\"0\",\"menu_name\":\"举报信息管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"report/index\",\"status\":\"1\",\"sort\":\"100\"}',1533971332,1),
	(28,3,'report','delete','/report/delete','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"username\":\"Answer123\"}',1533973112,1),
	(29,2,'report','delete','/report/delete','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"username\":\"Answer123\"}',1533973200,1),
	(30,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}',1533974186,1),
	(31,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}',1533974193,1),
	(32,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\"}',1533974209,1),
	(33,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}',1533974213,1),
	(34,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}',1533974217,1),
	(35,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}',1533974224,1),
	(36,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"1\"}',1533974228,1),
	(37,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}',1533974245,1),
	(38,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"2\",\"user_id\":\"1\"}',1533974249,1),
	(39,3,'fav','delete','/fav/delete','id=1','{\"id\":\"1\",\"uid\":\"1\",\"itemid\":\"1\",\"ct\":\"0\",\"mt\":\"0\",\"username\":\"Answer123\",\"itemname\":\"test1\"}',1533975687,1),
	(40,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"1\",\"item_value\":\"2\",\"reason\":\"1\",\"info\":\"看不懂啊\",\"status\":\"1\",\"user_id\":\"1\"}',1533976832,1),
	(41,2,'report','update','/report/update','id=1','{\"id\":\"1\",\"item_type\":\"2\",\"item_value\":\"1\",\"reason\":\"2\",\"info\":\"看不懂啊\",\"status\":\"0\",\"user_id\":\"5\"}',1533976854,1),
	(42,2,'menu','update','/menu/update','id=21','{\"id\":\"21\",\"pid\":\"0\",\"menu_name\":\"评论后台管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"feedback/index\",\"status\":\"1\",\"sort\":\"100\"}',1533982108,1),
	(43,2,'menu','update','/menu/update','id=22','{\"id\":\"22\",\"pid\":\"0\",\"menu_name\":\"订单详情管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"orderinfo/index\",\"status\":\"1\",\"sort\":\"100\"}',1534006396,1),
	(44,2,'orderinfo','update','/orderinfo/update','id=1','{\"id\":\"1\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"60\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"pt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"remark\":\"1111\",\"paytp\":\"1\",\"fd\":\"1\",\"ct\":\"0\",\"mt\":\"0\"}',1534008599,1),
	(45,2,'orderinfo','update','/orderinfo/update','id=1','{\"id\":\"1\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"0\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"pt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"remark\":\"1111\",\"paytp\":\"1\",\"fd\":\"1\",\"ct\":\"0\",\"mt\":\"1534008599\"}',1534008605,1),
	(46,2,'orderinfo','update','/orderinfo/update','id=1','{\"id\":\"1\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"50\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"pt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"remark\":\"1111\",\"paytp\":\"1\",\"fd\":\"1\",\"ct\":\"0\",\"mt\":\"1534008605\"}',1534008609,1),
	(47,3,'orderinfo','delete','/orderinfo/delete','id=1','{\"id\":\"1\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"50\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"ct\":\"0\",\"pt\":\"0\",\"mt\":\"1534008609\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"remark\":\"1111\",\"paytp\":\"1\",\"fd\":\"1\"}',1534008670,1),
	(48,2,'orderinfo','update','/orderinfo/update','id=1','{\"id\":\"1\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"60\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"pt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"paytp\":\"1\",\"remark\":\"1111\",\"fd\":\"1\",\"ct\":\"0\",\"mt\":\"0\"}',1534037775,1),
	(49,3,'orderinfo','delete','/orderinfo/delete','id=2','{\"id\":\"2\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"10\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"ct\":\"0\",\"pt\":\"0\",\"mt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"remark\":\"1111\",\"paytp\":\"1\",\"fd\":\"1\",\"address_info\":\"\"}',1534037980,1),
	(50,2,'menu','update','/menu/update','id=23','{\"id\":\"23\",\"pid\":\"0\",\"menu_name\":\"地址管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"address/index\",\"status\":\"1\",\"sort\":\"100\"}',1534038593,1),
	(51,3,'address','delete','/address/delete','id=1','{\"id\":\"1\",\"uid\":\"1\",\"aid\":\"1\",\"info\":\"测试地址\",\"lat\":\"1\",\"lng\":\"1\",\"ct\":\"1111\",\"mt\":\"0\"}',1534038630,1),
	(52,2,'menu','update','/menu/update','id=24','{\"id\":\"24\",\"pid\":\"0\",\"menu_name\":\"服务求助管理\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"item/index\",\"status\":\"1\",\"sort\":\"100\"}',1534041032,1),
	(53,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"name\":\"test1\",\"price\":\"100.00\",\"flag\":\"0\",\"uid\":\"8\",\"cid\":\"5\",\"tag\":\"133333\",\"type\":\"0\",\"aid\":\"91\",\"aaid\":\"0\",\"lat\":\"35.705\",\"lng\":\"139.767\",\"pt\":\"1531580403\",\"paytp\":\"1\",\"contact\":\"null\",\"deadline\":\"\",\"unit\":\"次\",\"pet\":\"1539356405\",\"ct\":\"1531580403\",\"mt\":\"1531580600\"}',1534042063,1),
	(54,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"name\":\"test1\",\"price\":\"100.00\",\"flag\":\"0\",\"uid\":\"8\",\"cid\":\"5\",\"tag\":\"133333\",\"type\":\"1\",\"aid\":\"91\",\"aaid\":\"0\",\"lat\":\"35.705\",\"lng\":\"139.767\",\"pt\":\"1531580403\",\"paytp\":\"1\",\"contact\":\"null\",\"deadline\":\"\",\"unit\":\"次\",\"pet\":\"1539356405\",\"ct\":\"1531580403\",\"mt\":\"1534042063\"}',1534042068,1),
	(55,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"flag\":\"1\",\"type\":\"0\"}',1534042371,1),
	(56,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"flag\":\"0\",\"type\":\"0\"}',1534042375,1),
	(57,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"flag\":\"0\",\"type\":\"1\"}',1534042413,1),
	(58,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"flag\":\"0\",\"type\":\"1\"}',1534042417,1),
	(59,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"flag\":\"1\"}',1534042546,1),
	(60,2,'item','update','/item/update','id=1','{\"id\":\"1\",\"flag\":\"0\"}',1534042550,1),
	(61,3,'item','delete','/item/delete','id=1','{\"id\":\"1\",\"name\":\"test1\",\"appid\":\"0\",\"price\":\"100.00\",\"img\":\"/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg\",\"flag\":\"0\",\"ct\":\"1531580403\",\"mt\":\"1534042550\",\"uid\":\"8\",\"cid\":\"5\",\"tag\":\"133333\",\"type\":\"1\",\"aid\":\"91\",\"aaid\":\"0\",\"lat\":\"35.705\",\"lng\":\"139.767\",\"pt\":\"1531580403\",\"paytp\":\"1\",\"contact\":\"null\",\"deadline\":\"\",\"unit\":\"次\",\"pet\":\"1539356405\"}',1534042621,1),
	(62,1,'authority','create','/authority/create','name=','{\"type\":\"2\",\"name\":\"\",\"newName\":\"item/iteminfo\",\"description\":\"服务求助详情-服务请求管理\",\"rule_name\":\"\"}',1534045247,1),
	(63,2,'orderinfo','update','/orderinfo/update','id=3','{\"id\":\"3\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"0\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"pt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"paytp\":\"1\",\"remark\":\"1111\",\"fd\":\"1\",\"ct\":\"1534037775\",\"mt\":\"0\"}',1534056448,1),
	(64,2,'orderinfo','update','/orderinfo/update','id=4','{\"id\":\"4\",\"no\":\"1\",\"uid\":\"1\",\"status\":\"60\",\"ordertp\":\"0\",\"cash\":\"100.00\",\"pt\":\"0\",\"itemid\":\"1\",\"num\":\"1110\",\"type\":\"2\",\"owner\":\"1\",\"changeprice\":\"100.00\",\"paytp\":\"1\",\"remark\":\"1111\",\"fd\":\"1\",\"ct\":\"1534027775\",\"mt\":\"0\"}',1534056454,1),
	(65,1,'authority','create','/authority/create','name=','{\"type\":\"2\",\"name\":\"\",\"newName\":\"statistics/topn\",\"description\":\"商品排行-统计功能\",\"rule_name\":\"\"}',1534066469,1),
	(66,1,'menu','create','/menu/create','id=25','{\"id\":\"\",\"pid\":\"0\",\"menu_name\":\"商品排行\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"statistics/topn\",\"status\":\"1\",\"sort\":\"100\"}',1534066503,1),
	(67,1,'menu','create','/menu/create','id=26','{\"id\":\"\",\"pid\":\"0\",\"menu_name\":\"经营概况\",\"icons\":\"menu-icon fa fa-cog\",\"url\":\"statistics/index\",\"status\":\"1\",\"sort\":\"100\"}',1534066534,1),
	(68,1,'authority','create','/authority/create','name=','{\"type\":\"2\",\"name\":\"\",\"newName\":\"statistics/index\",\"description\":\"经营概况-统计功能\",\"rule_name\":\"\"}',1534066596,1);

/*!40000 ALTER TABLE `helpe_admin_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_arrange
# ------------------------------------------------------------

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



# Dump of table helpe_auth_assignment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_auth_assignment`;

CREATE TABLE `helpe_auth_assignment` (
  `item_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `auth_assignment_user_id_idx` (`user_id`),
  CONSTRAINT `helpe_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_auth_assignment` WRITE;
/*!40000 ALTER TABLE `helpe_auth_assignment` DISABLE KEYS */;

INSERT INTO `helpe_auth_assignment` (`item_name`, `user_id`, `created_at`)
VALUES
	('admin','2',1519919184),
	('administrator','1',1519919184);

/*!40000 ALTER TABLE `helpe_auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_auth_item
# ------------------------------------------------------------

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

LOCK TABLES `helpe_auth_item` WRITE;
/*!40000 ALTER TABLE `helpe_auth_item` DISABLE KEYS */;

INSERT INTO `helpe_auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`)
VALUES
	('address/create',2,'添加数据-地址管理',NULL,NULL,1534038198,1534038198),
	('address/delete',2,'删除数据-地址管理',NULL,NULL,1534038198,1534038198),
	('address/delete-all',2,'批量删除-地址管理',NULL,NULL,1534038198,1534038198),
	('address/export',2,'导出数据-地址管理',NULL,NULL,1534038198,1534038198),
	('address/index',2,'显示数据-地址管理',NULL,NULL,1534038198,1534038198),
	('address/search',2,'搜索数据-地址管理',NULL,NULL,1534038198,1534038198),
	('address/update',2,'修改数据-地址管理',NULL,NULL,1534038198,1534038198),
	('admin',1,'管理员',NULL,NULL,1519919184,1523084344),
	('admin-log/delete',2,'操作日志-删除数据',NULL,NULL,1519919184,1519919184),
	('admin-log/delete-all',2,'操作日志-批量删除',NULL,NULL,1519919184,1519919184),
	('admin-log/export',2,'操作日志-导出数据',NULL,NULL,1519919184,1519919184),
	('admin-log/index',2,'操作日志-显示页面',NULL,NULL,1519919184,1519919184),
	('admin-log/search',2,'操作日志-搜索数据',NULL,NULL,1519919184,1519919184),
	('admin/address',2,'管理员信息信息-查询地址',NULL,NULL,1519919184,1519919184),
	('admin/create',2,'管理员信息-添加数据',NULL,NULL,1519919184,1519919184),
	('admin/delete',2,'管理员信息-删除数据','admin-delete',NULL,1519919184,1519919184),
	('admin/delete-all',2,'管理员信息-批量删除',NULL,NULL,1519919184,1519919184),
	('admin/editable',2,'管理员信息-行内编辑',NULL,NULL,1519919184,1519919184),
	('admin/export',2,'管理员信息-导出数据',NULL,NULL,1519919184,1519919184),
	('admin/index',2,'管理员信息-显示数据',NULL,NULL,1519919184,1519919184),
	('admin/search',2,'管理员信息-搜索数据',NULL,NULL,1519919184,1519919184),
	('admin/update',2,'管理员信息-修改数据','admin',NULL,1519919184,1519919184),
	('admin/upload',2,'管理员信息-上传头像',NULL,NULL,1519919184,1519919184),
	('admin/view',2,'管理员信息-显示详情',NULL,NULL,1519919184,1519919184),
	('administrator',1,'超级管理员',NULL,NULL,1519919184,1519919184),
	('arrange/arrange',2,'我的日程-查询数据',NULL,NULL,1519919184,1519919184),
	('arrange/calendar',2,'我的日程-查看详情',NULL,NULL,1519919184,1519919184),
	('arrange/create',2,'日程管理-添加数据',NULL,NULL,1519919184,1519919184),
	('arrange/delete',2,'日程管理-删除数据',NULL,NULL,1519919184,1519919184),
	('arrange/delete-all',2,'日程信息-批量删除',NULL,NULL,1519919184,1519919184),
	('arrange/editable',2,'日程管理-行内编辑',NULL,NULL,1519919184,1519919184),
	('arrange/export',2,'日程信息-导出数据',NULL,NULL,1519919184,1519919184),
	('arrange/index',2,'日程管理-显示页面',NULL,NULL,1519919184,1519919184),
	('arrange/search',2,'日程管理-搜索数据',NULL,NULL,1519919184,1519919184),
	('arrange/update',2,'日程管理-修改数据',NULL,NULL,1519919184,1519919184),
	('auth-assignment/create',2,'角色分配-添加数据',NULL,NULL,1519919184,1519919184),
	('auth-assignment/delete',2,'角色分配-删除数据','auth-assignment',NULL,1519919184,1519919184),
	('auth-assignment/export',2,'角色分配-导出数据',NULL,NULL,1519919184,1519919184),
	('auth-assignment/index',2,'角色分配-显示页面',NULL,NULL,1519919184,1519919184),
	('auth-assignment/search',2,'角色分配-搜索数据',NULL,NULL,1519919184,1519919184),
	('auth-rule/create',2,'规则管理-添加数据',NULL,NULL,1519919184,1519919184),
	('auth-rule/delete',2,'规则管理-删除数据',NULL,NULL,1519919184,1519919184),
	('auth-rule/delete-all',2,'规则管理-批量删除',NULL,NULL,1519919184,1519919184),
	('auth-rule/export',2,'规则管理-导出数据',NULL,NULL,1519919184,1519919184),
	('auth-rule/index',2,'规则管理-显示数据',NULL,NULL,1519919184,1519919184),
	('auth-rule/search',2,'规则管理-搜索数据',NULL,NULL,1519919184,1519919184),
	('auth-rule/update',2,'规则管理-修改数据',NULL,NULL,1519919184,1519919184),
	('authority/create',2,'权限信息-添加数据',NULL,NULL,1519919184,1519919184),
	('authority/delete',2,'权限信息-删除数据',NULL,NULL,1519919184,1519919184),
	('authority/delete-all',2,'权限信息-批量删除',NULL,NULL,1519919184,1519919184),
	('authority/export',2,'权限信息-导出数据',NULL,NULL,1519919184,1519919184),
	('authority/index',2,'权限信息-显示页面',NULL,NULL,1519919184,1519919184),
	('authority/search',2,'权限信息-搜索数据',NULL,NULL,1519919184,1519919184),
	('authority/update',2,'权限信息-修改数据',NULL,NULL,1519919184,1519919184),
	('category/create',2,'添加数据-分类管理',NULL,NULL,1523082391,1523082391),
	('category/delete',2,'删除数据-分类管理',NULL,NULL,1523082391,1523082391),
	('category/delete-all',2,'批量删除-分类管理',NULL,NULL,1523082391,1523082391),
	('category/export',2,'导出数据-分类管理',NULL,NULL,1523082391,1523082391),
	('category/index',2,'显示数据-分类管理',NULL,NULL,1523082391,1523082391),
	('category/search',2,'搜索数据-分类管理',NULL,NULL,1523082391,1523082391),
	('category/update',2,'修改数据-分类管理',NULL,NULL,1523082391,1523082391),
	('china/create',2,'地址信息-添加数据',NULL,NULL,1519919184,1519919184),
	('china/delete',2,'地址信息-删除数据',NULL,NULL,1519919184,1519919184),
	('china/delete-all',2,'地址信息-批量删除',NULL,NULL,1519919184,1519919184),
	('china/export',2,'地址信息-导出数据',NULL,NULL,1519919184,1519919184),
	('china/index',2,'地址信息-显示页面',NULL,NULL,1519919184,1519919184),
	('china/search',2,'地址信息-搜索数据',NULL,NULL,1519919184,1519919184),
	('china/update',2,'地址信息-修改数据',NULL,NULL,1519919184,1519919184),
	('fav/create',2,'添加数据-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('fav/delete',2,'删除数据-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('fav/delete-all',2,'批量删除-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('fav/export',2,'导出数据-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('fav/index',2,'显示数据-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('fav/search',2,'搜索数据-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('fav/update',2,'修改数据-用户收藏管理',NULL,NULL,1523090512,1523090512),
	('feedback/create',2,'添加数据-评论后台管理',NULL,NULL,1533982077,1533982077),
	('feedback/delete',2,'删除数据-评论后台管理',NULL,NULL,1533982077,1533982077),
	('feedback/delete-all',2,'批量删除-评论后台管理',NULL,NULL,1533982077,1533982077),
	('feedback/export',2,'导出数据-评论后台管理',NULL,NULL,1533982077,1533982077),
	('feedback/index',2,'显示数据-评论后台管理',NULL,NULL,1533982077,1533982077),
	('feedback/search',2,'搜索数据-评论后台管理',NULL,NULL,1533982077,1533982077),
	('feedback/update',2,'修改数据-评论后台管理',NULL,NULL,1533982077,1533982077),
	('follow/create',2,'添加数据-用户关注管理',NULL,NULL,1524401961,1524402489),
	('follow/delete',2,'删除数据-用户关注管理',NULL,NULL,1524401961,1524402495),
	('follow/delete-all',2,'批量删除-用户关注管理',NULL,NULL,1524401961,1524402516),
	('follow/export',2,'导出数据-用户关注管理',NULL,NULL,1524401961,1524402500),
	('follow/index',2,'显示数据-用户关注管理',NULL,NULL,1524401961,1524402483),
	('follow/search',2,'搜索数据-用户关注管理',NULL,NULL,1524401961,1524402505),
	('follow/update',2,'修改数据-用户关注管理',NULL,NULL,1524401961,1524402511),
	('item/create',2,'添加数据-服务求助管理',NULL,NULL,1534039580,1534039580),
	('item/delete',2,'删除数据-服务求助管理',NULL,NULL,1534039580,1534039580),
	('item/delete-all',2,'批量删除-服务求助管理',NULL,NULL,1534039580,1534039580),
	('item/export',2,'导出数据-服务求助管理',NULL,NULL,1534039580,1534039580),
	('item/index',2,'显示数据-服务求助管理',NULL,NULL,1534039580,1534039580),
	('item/iteminfo',2,'服务求助详情-服务请求管理',NULL,NULL,1534045247,1534045247),
	('item/search',2,'搜索数据-服务求助管理',NULL,NULL,1534039580,1534039580),
	('item/update',2,'修改数据-服务求助管理',NULL,NULL,1534039580,1534039580),
	('market-log/create',2,'添加数据-推送信息查看',NULL,NULL,1524408977,1524408977),
	('market-log/delete',2,'删除数据-推送信息查看',NULL,NULL,1524408977,1524408977),
	('market-log/delete-all',2,'批量删除-推送信息查看',NULL,NULL,1524408977,1524408977),
	('market-log/export',2,'导出数据-推送信息查看',NULL,NULL,1524408977,1524408977),
	('market-log/index',2,'显示数据-推送信息查看',NULL,NULL,1524408977,1524408977),
	('market-log/search',2,'搜索数据-推送信息查看',NULL,NULL,1524408977,1524408977),
	('market-log/update',2,'修改数据-推送信息查看',NULL,NULL,1524408977,1524408977),
	('menu/create',2,'导航栏目-添加数据',NULL,NULL,1519919184,1519919184),
	('menu/delete',2,'导航栏目-删除数据',NULL,NULL,1519919184,1519919184),
	('menu/delete-all',2,'导航栏目-批量删除',NULL,NULL,1519919184,1519919184),
	('menu/export',2,'导航栏目-导出数据',NULL,NULL,1519919184,1519919184),
	('menu/index',2,'导航栏目-显示页面',NULL,NULL,1519919184,1519919184),
	('menu/search',2,'导航栏目-搜索数据',NULL,NULL,1519919184,1519919184),
	('menu/update',2,'导航栏目-修改数据',NULL,NULL,1519919184,1519919184),
	('module/create',2,'模块生成-生成预览表单',NULL,NULL,1519919184,1519919184),
	('module/index',2,'模块生成-显示页面',NULL,NULL,1519919184,1519919184),
	('module/produce',2,'模块生成-生成文件',NULL,NULL,1519919184,1519919184),
	('module/update',2,'模块生成-生成预览文件',NULL,NULL,1519919184,1519919184),
	('orderinfo/create',2,'添加数据-订单详情管理',NULL,NULL,1534006320,1534006320),
	('orderinfo/delete',2,'删除数据-订单详情管理',NULL,NULL,1534006320,1534006320),
	('orderinfo/delete-all',2,'批量删除-订单详情管理',NULL,NULL,1534006320,1534006320),
	('orderinfo/export',2,'导出数据-订单详情管理',NULL,NULL,1534006320,1534006320),
	('orderinfo/index',2,'显示数据-订单详情管理',NULL,NULL,1534006320,1534006320),
	('orderinfo/search',2,'搜索数据-订单详情管理',NULL,NULL,1534006320,1534006320),
	('orderinfo/update',2,'修改数据-订单详情管理',NULL,NULL,1534006320,1534006320),
	('passport/create',2,'登录信息表-添加数据',NULL,NULL,1519919184,1519919184),
	('passport/delete',2,'登录信息表-删除数据',NULL,NULL,1519919184,1519919184),
	('passport/delete-all',2,'登录信息表-批量删除',NULL,NULL,1519919184,1519919184),
	('passport/export',2,'登录信息表-导出数据',NULL,NULL,1519919184,1519919184),
	('passport/index',2,'登录信息表-显示数据',NULL,NULL,1519919184,1519919184),
	('passport/search',2,'登录信息表-搜索数据',NULL,NULL,1519919184,1519919184),
	('passport/update',2,'登录信息表-更新数据',NULL,NULL,1519919184,1519919184),
	('register/create',2,'注册信息表-添加数据',NULL,NULL,1519919184,1519919184),
	('register/delete',2,'注册信息表-删除数据',NULL,NULL,1519919184,1519919184),
	('register/delete-all',2,'注册信息表-批量删除',NULL,NULL,1519919184,1519919184),
	('register/export',2,'注册信息表-导出数据',NULL,NULL,1519919184,1519919184),
	('register/index',2,'注册信息表-显示数据',NULL,NULL,1519919184,1519919184),
	('register/search',2,'注册信息表-搜索数据',NULL,NULL,1519919184,1519919184),
	('register/update',2,'注册信息表-更新数据',NULL,NULL,1519919184,1519919184),
	('report/create',2,'添加数据-举报信息管理',NULL,NULL,1533969672,1533969672),
	('report/delete',2,'删除数据-举报信息管理',NULL,NULL,1533969672,1533969672),
	('report/delete-all',2,'批量删除-举报信息管理',NULL,NULL,1533969672,1533969672),
	('report/export',2,'导出数据-举报信息管理',NULL,NULL,1533969672,1533969672),
	('report/index',2,'显示数据-举报信息管理',NULL,NULL,1533969672,1533969672),
	('report/search',2,'搜索数据-举报信息管理',NULL,NULL,1533969672,1533969672),
	('report/update',2,'修改数据-举报信息管理',NULL,NULL,1533969672,1533969672),
	('role/create',2,'角色信息-添加数据',NULL,NULL,1519919184,1519919184),
	('role/delete',2,'角色信息-删除数据',NULL,NULL,1519919184,1519919184),
	('role/edit',2,'角色信息-分配权限',NULL,NULL,1519919184,1519919184),
	('role/export',2,'角色信息-导出数据',NULL,NULL,1519919184,1519919184),
	('role/index',2,'角色信息-显示页面',NULL,NULL,1519919184,1519919184),
	('role/search',2,'角色信息-搜索数据',NULL,NULL,1519919184,1519919184),
	('role/update',2,'角色信息-修改数据',NULL,NULL,1519919184,1519919184),
	('role/view',2,'角色权限-查看详情',NULL,NULL,1519919184,1519919184),
	('statistics/index',2,'经营概况-统计功能',NULL,NULL,1534066596,1534066596),
	('statistics/topn',2,'商品排行-统计功能',NULL,NULL,1534066469,1534066469),
	('uploads/create',2,'上传文件-添加数据',NULL,NULL,1519919184,1519919184),
	('uploads/delete',2,'上传文件-删除数据',NULL,NULL,1519919184,1519919184),
	('uploads/delete-all',2,'上传文件-批量删除',NULL,NULL,1519919184,1519919184),
	('uploads/export',2,'上传文件-导出数据',NULL,NULL,1519919184,1519919184),
	('uploads/index',2,'上传文件-显示页面',NULL,NULL,1519919184,1519919184),
	('uploads/search',2,'上传文件-搜索数据',NULL,NULL,1519919184,1519919184),
	('uploads/update',2,'上传文件-修改数据',NULL,NULL,1519919184,1519919184),
	('user/create',2,'用户信息-添加数据',NULL,NULL,1519919184,1519919184),
	('user/delete',2,'用户信息-删除数据',NULL,NULL,1519919184,1519919184),
	('user/delete-all',2,'用户信息-批量删除',NULL,NULL,1519919184,1519919184),
	('user/export',2,'用户信息-导出数据',NULL,NULL,1519919184,1519919184),
	('user/index',2,'用户信息-显示页面',NULL,NULL,1519919184,1519919184),
	('user/search',2,'用户信息-搜索数据',NULL,NULL,1519919184,1519919184),
	('user/update',2,'用户信息-修改数据',NULL,NULL,1519919184,1519919184),
	('user/userinfo',2,'用户信息-用户详情',NULL,NULL,1532148836,1532148864);

/*!40000 ALTER TABLE `helpe_auth_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_auth_item_child
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_auth_item_child`;

CREATE TABLE `helpe_auth_item_child` (
  `parent` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `helpe_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `helpe_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_auth_item_child` WRITE;
/*!40000 ALTER TABLE `helpe_auth_item_child` DISABLE KEYS */;

INSERT INTO `helpe_auth_item_child` (`parent`, `child`)
VALUES
	('administrator','address/create'),
	('administrator','address/delete'),
	('administrator','address/delete-all'),
	('administrator','address/export'),
	('administrator','address/index'),
	('administrator','address/search'),
	('administrator','address/update'),
	('admin','admin-log/delete'),
	('administrator','admin-log/delete'),
	('admin','admin-log/delete-all'),
	('administrator','admin-log/delete-all'),
	('admin','admin-log/export'),
	('administrator','admin-log/export'),
	('admin','admin-log/index'),
	('administrator','admin-log/index'),
	('admin','admin-log/search'),
	('administrator','admin-log/search'),
	('admin','admin/address'),
	('administrator','admin/address'),
	('admin','admin/create'),
	('administrator','admin/create'),
	('admin','admin/delete'),
	('administrator','admin/delete'),
	('admin','admin/delete-all'),
	('administrator','admin/delete-all'),
	('admin','admin/editable'),
	('administrator','admin/editable'),
	('admin','admin/export'),
	('administrator','admin/export'),
	('admin','admin/index'),
	('administrator','admin/index'),
	('admin','admin/search'),
	('administrator','admin/search'),
	('admin','admin/update'),
	('administrator','admin/update'),
	('admin','admin/upload'),
	('administrator','admin/upload'),
	('admin','admin/view'),
	('administrator','admin/view'),
	('admin','arrange/arrange'),
	('administrator','arrange/arrange'),
	('admin','arrange/calendar'),
	('administrator','arrange/calendar'),
	('admin','arrange/create'),
	('administrator','arrange/create'),
	('admin','arrange/delete'),
	('administrator','arrange/delete'),
	('admin','arrange/delete-all'),
	('administrator','arrange/delete-all'),
	('admin','arrange/editable'),
	('administrator','arrange/editable'),
	('admin','arrange/export'),
	('administrator','arrange/export'),
	('admin','arrange/index'),
	('administrator','arrange/index'),
	('admin','arrange/search'),
	('administrator','arrange/search'),
	('admin','arrange/update'),
	('administrator','arrange/update'),
	('admin','auth-assignment/create'),
	('administrator','auth-assignment/create'),
	('admin','auth-assignment/delete'),
	('administrator','auth-assignment/delete'),
	('admin','auth-assignment/export'),
	('administrator','auth-assignment/export'),
	('admin','auth-assignment/index'),
	('administrator','auth-assignment/index'),
	('admin','auth-assignment/search'),
	('administrator','auth-assignment/search'),
	('admin','auth-rule/create'),
	('administrator','auth-rule/create'),
	('admin','auth-rule/delete'),
	('administrator','auth-rule/delete'),
	('admin','auth-rule/delete-all'),
	('administrator','auth-rule/delete-all'),
	('admin','auth-rule/export'),
	('administrator','auth-rule/export'),
	('admin','auth-rule/index'),
	('administrator','auth-rule/index'),
	('admin','auth-rule/search'),
	('administrator','auth-rule/search'),
	('admin','auth-rule/update'),
	('administrator','auth-rule/update'),
	('admin','authority/create'),
	('administrator','authority/create'),
	('admin','authority/delete'),
	('administrator','authority/delete'),
	('admin','authority/delete-all'),
	('administrator','authority/delete-all'),
	('admin','authority/export'),
	('administrator','authority/export'),
	('admin','authority/index'),
	('administrator','authority/index'),
	('admin','authority/search'),
	('administrator','authority/search'),
	('admin','authority/update'),
	('administrator','authority/update'),
	('admin','category/create'),
	('administrator','category/create'),
	('admin','category/delete'),
	('administrator','category/delete'),
	('admin','category/delete-all'),
	('administrator','category/delete-all'),
	('admin','category/export'),
	('administrator','category/export'),
	('admin','category/index'),
	('administrator','category/index'),
	('admin','category/search'),
	('administrator','category/search'),
	('admin','category/update'),
	('administrator','category/update'),
	('admin','china/create'),
	('administrator','china/create'),
	('admin','china/delete'),
	('administrator','china/delete'),
	('admin','china/delete-all'),
	('administrator','china/delete-all'),
	('admin','china/export'),
	('administrator','china/export'),
	('admin','china/index'),
	('administrator','china/index'),
	('admin','china/search'),
	('administrator','china/search'),
	('admin','china/update'),
	('administrator','china/update'),
	('administrator','fav/create'),
	('administrator','fav/delete'),
	('administrator','fav/delete-all'),
	('administrator','fav/export'),
	('administrator','fav/index'),
	('administrator','fav/search'),
	('administrator','fav/update'),
	('administrator','feedback/create'),
	('administrator','feedback/delete'),
	('administrator','feedback/delete-all'),
	('administrator','feedback/export'),
	('administrator','feedback/index'),
	('administrator','feedback/search'),
	('administrator','feedback/update'),
	('administrator','follow/create'),
	('administrator','follow/delete'),
	('administrator','follow/delete-all'),
	('administrator','follow/export'),
	('administrator','follow/index'),
	('administrator','follow/search'),
	('administrator','follow/update'),
	('administrator','item/create'),
	('administrator','item/delete'),
	('administrator','item/delete-all'),
	('administrator','item/export'),
	('administrator','item/index'),
	('administrator','item/iteminfo'),
	('administrator','item/search'),
	('administrator','item/update'),
	('administrator','market-log/create'),
	('administrator','market-log/delete'),
	('administrator','market-log/delete-all'),
	('administrator','market-log/export'),
	('administrator','market-log/index'),
	('administrator','market-log/search'),
	('administrator','market-log/update'),
	('admin','menu/create'),
	('administrator','menu/create'),
	('admin','menu/delete'),
	('administrator','menu/delete'),
	('admin','menu/delete-all'),
	('administrator','menu/delete-all'),
	('admin','menu/export'),
	('administrator','menu/export'),
	('admin','menu/index'),
	('administrator','menu/index'),
	('admin','menu/search'),
	('administrator','menu/search'),
	('admin','menu/update'),
	('administrator','menu/update'),
	('admin','module/create'),
	('administrator','module/create'),
	('admin','module/index'),
	('administrator','module/index'),
	('admin','module/produce'),
	('administrator','module/produce'),
	('admin','module/update'),
	('administrator','module/update'),
	('administrator','orderinfo/create'),
	('administrator','orderinfo/delete'),
	('administrator','orderinfo/delete-all'),
	('administrator','orderinfo/export'),
	('administrator','orderinfo/index'),
	('administrator','orderinfo/search'),
	('administrator','orderinfo/update'),
	('admin','passport/create'),
	('administrator','passport/create'),
	('admin','passport/delete'),
	('administrator','passport/delete'),
	('admin','passport/delete-all'),
	('administrator','passport/delete-all'),
	('admin','passport/export'),
	('administrator','passport/export'),
	('admin','passport/index'),
	('administrator','passport/index'),
	('admin','passport/search'),
	('administrator','passport/search'),
	('admin','passport/update'),
	('administrator','passport/update'),
	('admin','register/create'),
	('administrator','register/create'),
	('admin','register/delete'),
	('administrator','register/delete'),
	('admin','register/delete-all'),
	('administrator','register/delete-all'),
	('admin','register/export'),
	('administrator','register/export'),
	('admin','register/index'),
	('administrator','register/index'),
	('admin','register/search'),
	('administrator','register/search'),
	('admin','register/update'),
	('administrator','register/update'),
	('administrator','report/create'),
	('administrator','report/delete'),
	('administrator','report/delete-all'),
	('administrator','report/export'),
	('administrator','report/index'),
	('administrator','report/search'),
	('administrator','report/update'),
	('admin','role/create'),
	('administrator','role/create'),
	('admin','role/delete'),
	('administrator','role/delete'),
	('admin','role/edit'),
	('administrator','role/edit'),
	('admin','role/export'),
	('administrator','role/export'),
	('admin','role/index'),
	('administrator','role/index'),
	('admin','role/search'),
	('administrator','role/search'),
	('admin','role/update'),
	('administrator','role/update'),
	('admin','role/view'),
	('administrator','role/view'),
	('administrator','statistics/index'),
	('administrator','statistics/topn'),
	('admin','uploads/create'),
	('administrator','uploads/create'),
	('admin','uploads/delete'),
	('administrator','uploads/delete'),
	('admin','uploads/delete-all'),
	('administrator','uploads/delete-all'),
	('admin','uploads/export'),
	('administrator','uploads/export'),
	('admin','uploads/index'),
	('administrator','uploads/index'),
	('admin','uploads/search'),
	('administrator','uploads/search'),
	('admin','uploads/update'),
	('administrator','uploads/update'),
	('admin','user/create'),
	('administrator','user/create'),
	('admin','user/delete'),
	('administrator','user/delete'),
	('admin','user/delete-all'),
	('administrator','user/delete-all'),
	('admin','user/export'),
	('administrator','user/export'),
	('admin','user/index'),
	('administrator','user/index'),
	('admin','user/search'),
	('administrator','user/search'),
	('admin','user/update'),
	('administrator','user/update'),
	('administrator','user/userinfo');

/*!40000 ALTER TABLE `helpe_auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_auth_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_auth_rule`;

CREATE TABLE `helpe_auth_rule` (
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_auth_rule` WRITE;
/*!40000 ALTER TABLE `helpe_auth_rule` DISABLE KEYS */;

INSERT INTO `helpe_auth_rule` (`name`, `data`, `created_at`, `updated_at`)
VALUES
	('admin',X'4F3A32333A226261636B656E645C72756C65735C41646D696E52756C65223A333A7B733A343A226E616D65223B733A353A2261646D696E223B733A393A22637265617465644174223B693A313439393030363036393B733A393A22757064617465644174223B693A313439393030363036393B7D',1519919184,1519919184),
	('admin-delete',X'4F3A32393A226261636B656E645C72756C65735C41646D696E44656C65746552756C65223A333A7B733A343A226E616D65223B733A31323A2261646D696E2D64656C657465223B733A393A22637265617465644174223B693A313530313931393036363B733A393A22757064617465644174223B693A313530313931393036363B7D',1519919184,1519919184),
	('auth-assignment',X'4F3A33323A226261636B656E645C72756C65735C4175746841737369676E6D656E7452756C65223A353A7B733A343A226E616D65223B733A31353A22617574682D61737369676E6D656E74223B733A393A22637265617465644174223B693A313530303130353233383B733A393A22757064617465644174223B693A313530303130353233383B733A34373A22206261636B656E645C72756C65735C4175746841737369676E6D656E7452756C652061646D696E526F6C654E616D65223B733A31333A2261646D696E6973747261746F72223B733A34333A22206261636B656E645C72756C65735C4175746841737369676E6D656E7452756C6520696E74557365724964223B693A313B7D',1519919184,1519919184);

/*!40000 ALTER TABLE `helpe_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_category
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分类信息表';

LOCK TABLES `helpe_category` WRITE;
/*!40000 ALTER TABLE `helpe_category` DISABLE KEYS */;

INSERT INTO `helpe_category` (`id`, `jp_name`, `cn_name`, `pid`, `sort`, `flag`, `ct`, `mt`)
VALUES
	(1,'古本','',0,1,1,0,1533965952),
	(2,'売買','',0,1,1,0,1533962031),
	(3,'レンタル','',0,1,1,0,NULL),
	(4,'ペット','',0,1,1,0,NULL),
	(5,'イベント  ','',0,1,1,0,NULL),
	(6,'習い事','',0,1,1,0,NULL),
	(7,'お手伝い','',0,1,1,0,NULL),
	(8,'その他','',0,1,1,0,NULL);

/*!40000 ALTER TABLE `helpe_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_fav
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_fav` WRITE;
/*!40000 ALTER TABLE `helpe_fav` DISABLE KEYS */;

INSERT INTO `helpe_fav` (`id`, `uid`, `itemid`, `ct`, `mt`)
VALUES
	(2,1,2,0,0),
	(3,1,3,0,0),
	(4,1,1,0,0),
	(5,4,1,0,0),
	(6,4,2,0,0),
	(7,8,1,0,0);

/*!40000 ALTER TABLE `helpe_fav` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_feedback
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论后台管理表';

LOCK TABLES `helpe_feedback` WRITE;
/*!40000 ALTER TABLE `helpe_feedback` DISABLE KEYS */;

INSERT INTO `helpe_feedback` (`id`, `content`, `itemid`, `flag`, `score`, `orderid`, `uid`, `owner`, `ct`, `mt`)
VALUES
	(1,'测试不知道',1,1,99,1000001,4,7,NULL,NULL);

/*!40000 ALTER TABLE `helpe_feedback` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_follow
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_follow` WRITE;
/*!40000 ALTER TABLE `helpe_follow` DISABLE KEYS */;

INSERT INTO `helpe_follow` (`id`, `uuid`, `uid`, `ct`, `mt`)
VALUES
	(1,1,1,0,0),
	(2,1,4,0,0),
	(3,1,5,0,0),
	(4,4,5,0,0),
	(5,5,5,0,0);

/*!40000 ALTER TABLE `helpe_follow` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_item
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

LOCK TABLES `helpe_item` WRITE;
/*!40000 ALTER TABLE `helpe_item` DISABLE KEYS */;

INSERT INTO `helpe_item` (`id`, `name`, `appid`, `price`, `img`, `flag`, `ct`, `mt`, `uid`, `cid`, `tag`, `type`, `aid`, `aaid`, `lat`, `lng`, `pt`, `paytp`, `contact`, `deadline`, `unit`, `pet`)
VALUES
	(1,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',0,1531580700,1531580864,1,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(3,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(4,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(5,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(6,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(7,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(8,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(9,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(10,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(11,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(12,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(13,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(14,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(15,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(16,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(17,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(18,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(19,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(20,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(21,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(22,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(23,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(24,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(25,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(26,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(27,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(28,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(29,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(30,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(31,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,1,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(32,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(33,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(34,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(35,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(36,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(37,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(38,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(39,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(40,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(41,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(42,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(43,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(44,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(45,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(46,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(47,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(48,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(49,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(50,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(51,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(52,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(53,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(54,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(55,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(56,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0),
	(57,'test1',0,100.00,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',0,1531580403,1531580600,8,5,133333,0,91,0,35.705,139.767,1531580403,1,'null',NULL,'次',1539356405),
	(58,'阿森纳球衣',0,5000.00,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',1,1531580700,1531580864,8,2,133333,0,91,0,35.705,139.767,1531580700,0,'null',NULL,'件',1539356864),
	(59,'美国点心',0,5000.00,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',1,1531580829,1531580832,8,2,133333,0,95,0,35.7097,139.76,1531580829,1,'null',NULL,'箱',1539356832),
	(60,'家庭教師',0,20000.00,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',0,1531582035,1531582036,7,6,133333,0,96,0,35.6765,139.852,1531582035,1,'null',NULL,'円',0);

/*!40000 ALTER TABLE `helpe_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_itemdetail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_itemdetail`;

CREATE TABLE `helpe_itemdetail` (
  `itemid` int(11) NOT NULL,
  `mark` text NOT NULL COMMENT '描述',
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`itemid`),
  KEY `itemid` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品详情表';

LOCK TABLES `helpe_itemdetail` WRITE;
/*!40000 ALTER TABLE `helpe_itemdetail` DISABLE KEYS */;

INSERT INTO `helpe_itemdetail` (`itemid`, `mark`, `ct`, `mt`)
VALUES
	(1,'null',1531580403,1531580403),
	(2,'null',1531580700,1531580700),
	(3,'null',1531580829,1531580829),
	(4,'null',1531582035,1531582035);

/*!40000 ALTER TABLE `helpe_itemdetail` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_itemimg
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品图片表';

LOCK TABLES `helpe_itemimg` WRITE;
/*!40000 ALTER TABLE `helpe_itemimg` DISABLE KEYS */;

INSERT INTO `helpe_itemimg` (`id`, `itemid`, `url`, `uid`, `ct`)
VALUES
	(1,4,'/images/itemfiles/H3PYsaweW2aQqMF_1531580403.jpg',8,1531580403),
	(2,2,'/images/itemfiles/4B8svn6WI9Aj4Sp_1531580700.jpg',8,1531580700),
	(3,2,'/images/itemfiles/GemcFCjYxsAXcMs_1531580829.jpg',8,1531580829),
	(4,1,'/images/itemfiles/cVd5p7YbFDGd5XD_1531582035.jpg',7,1531582035);

/*!40000 ALTER TABLE `helpe_itemimg` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_mail_template
# ------------------------------------------------------------

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

LOCK TABLES `helpe_mail_template` WRITE;
/*!40000 ALTER TABLE `helpe_mail_template` DISABLE KEYS */;

INSERT INTO `helpe_mail_template` (`type`, `desc`, `from`, `subject`, `text`, `html`, `update_at`, `create_at`)
VALUES
	('forgetPassword','忘记密码邮件','service@helpe.online','Forget Password of helpe.online','Helpe アカウント\n認証 コード\n\nHelpe アカウント {{email}} には、次の認証コードをお使いください。\n\n認証コード：{{checkDigit}}\n\nお客様がこのコードを請求していない場合は、このメールを無視しても問題ありません。他のユーザーが誤ってお客様のメールアドレスを入力した可能性があります。\n\nサービスのご利用がありがとうございます。\n\nHelpeアカウント チーム',NULL,0,0),
	('registerCheckDigit','注册确认邮件','service@helpe.online','welcome to helpe.online','Helpe アカウント\n認証 コード\n\nHelpe アカウント {{email}} には、次の認証コードをお使いください。\n\n認証コード：{{checkDigit}}\n\nお客様がこのコードを請求していない場合は、このメールを無視しても問題ありません。他のユーザーが誤ってお客様のメールアドレスを入力した可能性があります。\n\nサービスのご利用がありがとうございます。\n\nHelpeアカウント チーム',NULL,0,0);

/*!40000 ALTER TABLE `helpe_mail_template` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_market_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_market_log`;

CREATE TABLE `helpe_market_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `tpid` int(11) NOT NULL DEFAULT '0' COMMENT '交易信息类型id',
  `data` varchar(100) DEFAULT NULL COMMENT 'json数据',
  `ct` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推送信息表';

LOCK TABLES `helpe_market_log` WRITE;
/*!40000 ALTER TABLE `helpe_market_log` DISABLE KEYS */;

INSERT INTO `helpe_market_log` (`id`, `uid`, `tpid`, `data`, `ct`)
VALUES
	(1,1,1,'{\"username\":\"null\",\"itemname\":\"Iphone\"}',1524063690),
	(2,1,9,'{\"username\":\"ycyc1996\"}',1525173268),
	(3,1,9,'{\"username\":\"ycyc1996\"}',1525173277),
	(4,2,3,'{\"username\":\"ycyc1996\",\"itemname\":\"Iphone\"}',1525174036),
	(5,1,5,'{\"username\":\"ycyc1996\",\"itemname\":\"Iphone\"}',1525244398),
	(6,2,7,'{\"username\":\"null\",\"itemname\":\"Iphone\"}',1525244398),
	(7,9,1,'{\"username\":\"null\",\"itemname\":\"\\u53d1\\u5e03\\u7b2c\\u4e00\\u6761\"}',1528185124),
	(8,9,1,'{\"username\":\"DMChoicer\",\"itemname\":\"\\u53d1\\u5e03\\u7b2c\\u4e00\\u6761\"}',1528960335),
	(9,8,1,'{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}',1528961178),
	(10,1,3,'{\"username\":\"DMChoicer\",\"itemname\":\"Test\"}',1528961216),
	(11,9,1,'{\"username\":\"DMChoicer\",\"itemname\":\"\\u53d1\\u5e03\\u7b2c\\u4e00\\u6761\"}',1529497105),
	(12,1,1,'{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}',1530162995),
	(13,1,1,'{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}',1530167546),
	(14,8,1,'{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}',1530186479),
	(15,1,1,'{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}',1530197405),
	(16,1,1,'{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}',1530197412),
	(17,1,1,'{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}',1530197418),
	(18,1,1,'{\"username\":\"DMChoicer\",\"itemname\":\"test22\"}',1530197425),
	(19,8,1,'{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}',1530197880),
	(20,8,1,'{\"username\":\"ycyc1996120\",\"itemname\":\"Test\"}',1530197894),
	(21,1,15,'{\"username\":\"ycyc1996120\",\"itemname\":\"test22\"}',1530204602),
	(22,8,16,'{\"username\":\"ycyc1996120\",\"itemname\":\"test22\"}',1530204603),
	(23,8,9,'{\"username\":\"DMChoicer\"}',1530269299);

/*!40000 ALTER TABLE `helpe_market_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_menu
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台导航栏目信息表';

LOCK TABLES `helpe_menu` WRITE;
/*!40000 ALTER TABLE `helpe_menu` DISABLE KEYS */;

INSERT INTO `helpe_menu` (`id`, `pid`, `menu_name`, `icons`, `url`, `status`, `sort`, `created_at`, `created_id`, `updated_at`, `updated_id`)
VALUES
	(1,0,'后台功能管理','menu-icon fa fa-cog','',1,2,1519919184,1,1532147019,1),
	(2,1,'管理员信息','','admin/index',1,1,1519919184,1,1519919184,1),
	(3,1,'角色管理','','role/index',1,2,1519919184,1,1519919184,1),
	(4,1,'角色分配','icon-cog','auth-assignment/index',1,3,1519919184,1,1519919184,1),
	(5,1,'权限管理','','authority/index',1,4,1519919184,1,1519919184,1),
	(6,1,'规则管理','menu-icon fa fa-shield','auth-rule/index',1,5,1519919184,1,1519919184,1),
	(7,1,'导航栏目','','menu/index',1,6,1519919184,1,1519919184,1),
	(8,1,'模块生成','','module/index',1,7,1519919184,1,1519919184,1),
	(9,1,'操作日志','','admin-log/index',1,8,1519919184,1,1519919184,1),
	(10,0,'地址信息','menu-icon fa fa-bank','china/index',0,4,1519919184,1,1532143519,1),
	(11,0,'用户信息','menu-icon fa fa-user','user/index',1,3,1519919184,1,1519919184,1),
	(12,0,'日程管理','menu-icon fa fa-calendar','arrange/index',0,1,1519919184,1,1532143527,1),
	(13,0,'上传文件','menu-icon fa fa-upload','uploads/index',0,9,1519919184,1,1532143533,1),
	(14,0,'注册信息表','menu-icon fa fa-cog','register/index',1,30,1519919184,1,1519919184,1),
	(15,0,'登录信息表','menu-icon fa fa-cog','passport/index',1,100,1519919184,1,1519919184,1),
	(16,0,'分类管理','menu-icon fa fa-cog','category/index',1,100,1523082391,1,1523082391,1),
	(17,0,'用户收藏管理','menu-icon fa fa-cog','fav/index',1,100,1523090512,1,1523090512,1),
	(18,0,'用户关注管理','menu-icon fa fa-cog','follow/index',1,120,1524401961,1,1524402547,1),
	(19,0,'推送信息查看','menu-icon fa fa-cog','market-log/index',1,100,1524408977,1,1524409010,1),
	(20,0,'举报信息管理','menu-icon fa fa-cog','report/index',1,100,1533969672,1,1533971332,1),
	(21,0,'评论后台管理','menu-icon fa fa-cog','feedback/index',1,100,1533982077,1,1533982108,1),
	(22,0,'订单详情管理','menu-icon fa fa-cog','orderinfo/index',1,100,1534006320,1,1534006396,1),
	(23,0,'地址管理','menu-icon fa fa-cog','address/index',1,100,1534038198,1,1534038593,1),
	(24,0,'服务求助管理','menu-icon fa fa-cog','item/index',1,100,1534039580,1,1534041032,1),
	(25,0,'商品排行','menu-icon fa fa-cog','statistics/topn',1,100,1534066503,1,1534066503,1),
	(26,0,'经营概况','menu-icon fa fa-cog','statistics/index',1,100,1534066534,1,1534066534,1);

/*!40000 ALTER TABLE `helpe_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_migration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_migration`;

CREATE TABLE `helpe_migration` (
  `version` varchar(180) CHARACTER SET utf8 NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `helpe_migration` WRITE;
/*!40000 ALTER TABLE `helpe_migration` DISABLE KEYS */;

INSERT INTO `helpe_migration` (`version`, `apply_time`)
VALUES
	('m000000_000000_base',1519919172),
	('m130524_201442_init',1519919184),
	('m140506_102106_rbac_init',1519919174),
	('m170801_061245_create_menu',1519919184),
	('m170801_072726_create_admin',1519919184),
	('m170801_074527_create_arrange',1519919184),
	('m170801_081237_insert_rabc',1519919184),
	('m170804_163745_create_china',1519919185),
	('m170805_100055_create_admin_log',1519919185),
	('m170907_052038_rbac_add_index_on_auth_assignment_user_id',1519919174),
	('m171118_082050_create_uploads',1519919185);

/*!40000 ALTER TABLE `helpe_migration` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_orderaddr
# ------------------------------------------------------------

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

LOCK TABLES `helpe_orderaddr` WRITE;
/*!40000 ALTER TABLE `helpe_orderaddr` DISABLE KEYS */;

INSERT INTO `helpe_orderaddr` (`id`, `uid`, `aid`, `info`, `ct`, `lat`, `lng`, `orderid`)
VALUES
	(1,1,1,'测试功能',0,100,100,1);

/*!40000 ALTER TABLE `helpe_orderaddr` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_orderinfo
# ------------------------------------------------------------

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

LOCK TABLES `helpe_orderinfo` WRITE;
/*!40000 ALTER TABLE `helpe_orderinfo` DISABLE KEYS */;

INSERT INTO `helpe_orderinfo` (`id`, `no`, `uid`, `status`, `ordertp`, `cash`, `ct`, `pt`, `mt`, `itemid`, `num`, `type`, `owner`, `changeprice`, `remark`, `paytp`, `fd`)
VALUES
	(1,1,1,40,0,100.00,1529510400,0,1534037775,1,1110,2,1,100.00,'1111',1,1),
	(3,1,1,40,0,100.00,1534037775,0,1534056448,3,1110,2,1,100.00,'1111',1,1),
	(4,1,1,40,0,100.00,1534027775,0,1534056454,4,1110,2,1,100.00,'1111',1,1),
	(5,1,1,40,0,100.00,1529910400,0,0,5,1110,2,1,100.00,'1111',1,1),
	(6,1,1,40,0,100.00,1532102400,0,0,6,1110,2,1,100.00,'1111',1,1),
	(7,1,1,40,0,100.00,1532132400,0,0,7,1110,2,1,100.00,'1111',1,1),
	(8,1,1,40,0,100.00,1533139200,0,0,8,1110,2,1,100.00,'1111',1,1),
	(9,1,1,40,0,100.00,1533139900,0,0,9,1110,2,1,100.00,'1111',1,1),
	(10,1,1,40,0,100.00,1532448000,0,0,10,1110,2,1,100.00,'1111',1,1),
	(11,1,1,40,0,100.00,1532448400,0,0,11,1110,2,1,100.00,'1111',1,1),
	(12,1,1,40,0,100.00,1531929600,0,0,12,1110,2,1,100.00,'1111',1,1),
	(13,1,1,40,0,100.00,1531929900,0,0,13,1110,2,1,100.00,'1111',1,1),
	(14,1,1,40,0,100.00,1534014000,0,0,14,1110,2,1,100.00,'1111',1,1),
	(15,1,1,40,0,100.00,1534014100,0,0,15,1110,2,1,100.00,'1111',1,1),
	(16,1,1,40,0,100.00,1533927600,0,0,16,1110,2,1,100.00,'1111',1,1),
	(17,1,1,40,0,100.00,1533927900,0,0,17,1110,2,1,100.00,'1111',1,1),
	(18,1,1,40,0,100.00,1533841200,0,0,18,1110,2,1,100.00,'1111',1,1),
	(19,1,1,40,0,100.00,1533841800,0,0,19,1110,2,1,100.00,'1111',1,1),
	(20,1,1,40,0,100.00,1533754800,0,0,20,1110,2,1,100.00,'1111',1,1),
	(21,1,1,40,0,100.00,1533755000,0,0,21,1110,2,1,100.00,'1111',1,1),
	(22,1,1,40,0,100.00,1533668400,0,0,22,1110,2,1,100.00,'1111',1,1),
	(23,1,1,40,0,100.00,1533668900,0,0,23,1110,2,1,100.00,'1111',1,1),
	(24,1,1,40,0,100.00,1533582000,0,0,24,1110,2,1,100.00,'1111',1,1),
	(25,1,1,40,0,100.00,1533582700,0,0,25,1110,2,1,100.00,'1111',1,1),
	(26,1,1,40,0,100.00,1533495600,0,0,26,1110,2,1,100.00,'1111',1,1),
	(27,1,1,40,0,100.00,1533495700,0,0,27,1110,2,1,100.00,'1111',1,1),
	(28,1,1,40,0,100.00,1533409200,0,0,28,1110,2,1,100.00,'1111',1,1),
	(29,1,1,40,0,100.00,1533409800,0,0,29,1110,2,1,100.00,'1111',1,1),
	(30,1,1,40,0,100.00,1533322800,0,0,30,1110,2,1,100.00,'1111',1,1),
	(31,1,1,40,0,100.00,1533323800,0,0,31,1110,2,1,100.00,'1111',1,1),
	(32,1,1,40,0,100.00,1534089600,0,0,30,1110,2,1,100.00,'1111',1,1),
	(33,1,1,40,0,100.00,1534094600,0,0,31,1110,2,1,100.00,'1111',1,1),
	(34,1,1,40,0,100.00,1533571200,0,0,31,1110,2,1,100.00,'1111',1,1),
	(35,1,1,40,0,1200.00,1533573200,0,0,30,1110,2,1,1000.00,'1111',1,1),
	(36,1,1,40,0,100.00,1533572200,0,0,30,1110,2,1,1500.00,'1111',1,1),
	(37,1,1,40,0,100.00,1533744000,0,0,30,1110,2,1,1500.00,'1111',1,1),
	(38,1,1,40,0,900.00,1533748000,0,0,30,1110,2,1,1500.00,'1111',1,1),
	(39,1,1,40,0,900.00,1527782400,0,0,30,1110,2,1,1500.00,'1111',1,1),
	(40,1,1,40,0,900.00,1527785400,0,0,30,1110,2,1,1500.00,'1111',1,1),
	(41,1,1,40,0,300.00,1527785400,0,0,25,1110,2,1,1500.00,'1111',1,1),
	(42,1,1,40,0,100.00,1527785400,0,0,25,1110,2,1,1500.00,'1111',1,1);

/*!40000 ALTER TABLE `helpe_orderinfo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_passport
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录信息表';

LOCK TABLES `helpe_passport` WRITE;
/*!40000 ALTER TABLE `helpe_passport` DISABLE KEYS */;

INSERT INTO `helpe_passport` (`id`, `type`, `email`, `password`, `token`, `created_at`, `updated_at`)
VALUES
	(1,1,'497414900@qq.com','$2y$13$49scLlPeLBHOzcCbZkcv8uVtTllnDLupFTx/eTSJi6iTVSpyEbjzm','',1522398633,1522398633),
	(3,1,'mcz1515@yahoo.co.jp','$2y$13$gSich53s4kxtQ2sZSEze0Oq61d6/gm7wZtdJ3QiD19ssjyWXEgVMu','',1526340889,1526340889),
	(4,1,'824322790@qq.com','$2y$13$OZwQ.SLJ2RavvaSMPCbRF.Ou1ZjN8HPYItCwG4mpntN.lZBWfeo6q','',1526381754,1526381754),
	(5,1,'answer_yyc@163.com','$2y$13$9LuKrVXQD4Z8t032H6c5feZ3Q3zrp5aBqB0Z/KpoklhbIg8A3UZCK','',1526382334,1526382334),
	(6,1,'morningciciq@gmail.com','$2y$13$ZfE32Kl/Dww9kh9hsgycnOjjlYtoAYrnjRMLtaF4EHXF6UK.EAVWS','',1526382402,1526382402),
	(7,1,'dongzhutian09@qq.com','$2y$13$sf4Iz8AETNrPNtna/q9eoOInAYvfpKpqyraJSBL0SRPP6zAdh8woK','',1526384999,1526384999),
	(8,1,'524881676@qq.com','$2y$13$zSefnIsSgEkNPElSljhNSO8iZP8tSlBESpXmWI7zAaXgL5eUG3VgG','',1526440454,1526440454),
	(9,2,'494376395@qq.com','$2y$13$iMXTlO8e4m8Zei4OUaR3Aez66SbKvSoyd3x/pGz8.01kpTgaoDOzC','',1532069429,1532069429);

/*!40000 ALTER TABLE `helpe_passport` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_recommend
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_recommend`;

CREATE TABLE `helpe_recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `img` varchar(255) DEFAULT NULL COMMENT '宣传图链接',
  `type` int(11) DEFAULT NULL COMMENT '发布类型',
  `mark` text COMMENT '详情',
  `url` varchar(255) DEFAULT NULL COMMENT '官网地址',
  `pub_username` varchar(255) DEFAULT NULL COMMENT '发布人名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推荐商品，发现功能';



# Dump of table helpe_recommend_category
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发布推荐分类信息表';



# Dump of table helpe_register
# ------------------------------------------------------------

DROP TABLE IF EXISTS `helpe_register`;

CREATE TABLE `helpe_register` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '电子邮件',
  `auth_token` varchar(12) NOT NULL DEFAULT '' COMMENT '校验key',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='注册信息表';

LOCK TABLES `helpe_register` WRITE;
/*!40000 ALTER TABLE `helpe_register` DISABLE KEYS */;

INSERT INTO `helpe_register` (`id`, `email`, `auth_token`, `created_at`, `updated_at`)
VALUES
	(1,'497414900@qq.com','qEIJvX',1522396808,1522396808),
	(2,'497414900@qq.com','QjBv4W',1522397049,1522397049),
	(3,'497414900@qq.com','UWNBFi',1522397235,1522397235),
	(4,'497414900@qq.com','Wqc7Hc',1522397601,1522397601),
	(5,'497414900@qq.com','dqrDrH',1522397907,1522397907),
	(6,'497414900@qq.com','ZB5qEJ',1522398043,1522398043),
	(7,'123456@qq.com','3PP8Vn',1522679684,1522679684),
	(8,'ft20082@qq.com','T7J856',1522679710,1522679710),
	(12,'mcz1515@yahoo.co.jp','CENdwm',1526340841,1526340841),
	(13,'morningciciq@gmail.com','jhnNa7',1526373662,1526373662),
	(14,'824322790@qq.com','DXcwFD',1526381452,1526381452),
	(15,'824322790@qq.com','HUgw2i',1526381727,1526381727),
	(16,'answer_yyc@163.com','k6jJyy',1526381971,1526381971),
	(17,'morningciciq@gmail.com','ppx7qm',1526382348,1526382348),
	(18,'dongzhutian09@qq.com','X3CDbm',1526384959,1526384959),
	(19,'524881676@qq.com','8tKa4X',1526440318,1526440318),
	(20,'aaa@aaa.aaa.aaa','ABFUFK',1529412490,1529412490),
	(21,'1115290u@g.hit-u.ac.jp','HfyHuN',1529498527,1529498527),
	(22,'ft20082@qq.com','EA9sHS',1529641494,1529641494),
	(23,'78909230@qq.com','nE8NpU',1531117395,1531117395),
	(24,'494376395@qq.com','g5hWTB',1532066875,1532066875),
	(25,'494376395@qq.com','cXvikQ',1532066875,1532066875),
	(26,'494376395@qq.com','qpHnms',1532066875,1532066875),
	(27,'494376395@qq.com','w4vBun',1532067355,1532067355);

/*!40000 ALTER TABLE `helpe_register` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_report
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='举报表';

LOCK TABLES `helpe_report` WRITE;
/*!40000 ALTER TABLE `helpe_report` DISABLE KEYS */;

INSERT INTO `helpe_report` (`id`, `item_type`, `item_value`, `reason`, `info`, `status`, `user_id`, `created_at`, `updated_at`)
VALUES
	(1,2,1,2,'看不懂啊',0,5,0,1533976854);

/*!40000 ALTER TABLE `helpe_report` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_uploads
# ------------------------------------------------------------

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



# Dump of table helpe_user
# ------------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

LOCK TABLES `helpe_user` WRITE;
/*!40000 ALTER TABLE `helpe_user` DISABLE KEYS */;

INSERT INTO `helpe_user` (`id`, `type`, `email`, `username`, `access_token`, `password_reset_token`, `face`, `gender`, `birthday`, `career`, `city`, `cityinfo`, `tel`, `ip`, `info`, `status`, `created_at`, `updated_at`)
VALUES
	(1,1,'497414900@qq.com','Answer123','RvE247BZIz6wT8uDXAhGX2ndvM5TPHftz9Aj4ymZ',NULL,'/images/avatars/su2CQMbceqHk8eW_1527001293.jpg',0,NULL,'Stu',0,NULL,NULL,'49.221.207.189',NULL,1,1522398633,1532108408),
	(4,1,'mcz1515@yahoo.co.jp','user4','MtqY473r3nDcKddFQTjvShh8FasHCQkDmVPy8ihb',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'126.11.212.29',NULL,1,1526340889,1526340890),
	(5,1,'824322790@qq.com','user5','',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'49.221.207.244',NULL,1,1526381754,1526381950),
	(6,1,'answer_yyc@163.com','user6','XSVGVpEEFDYMNUcjVCbvuTrwYaPWYRyb2CiGCqGc',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'49.221.207.6',NULL,1,1526382334,1526644120),
	(7,1,'morningciciq@gmail.com','user7','da8FeIsgvxgRxPPUyappYaiCWcj9p8442mNIkMie',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'49.98.149.114',NULL,1,1526382402,1526382402),
	(8,1,'dongzhutian09@qq.com','DMChoicer','e3EmfFx5cWiGVN5WXw4nmmEesKQDfhiWgrPSeQek',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'118.21.152.179',NULL,1,1526384999,1531580355),
	(9,1,'524881676@qq.com','f1111','ZJpbFsPvbxBxwYRNbyXGsbahy9WrQnqQkzDsASVp',NULL,'/images/avatars/69tFNyZAgY2YtZq_1526991995.jpeg',3,NULL,NULL,NULL,'x1234',NULL,'218.80.0.27',NULL,1,1526440454,1527781098),
	(10,1,'494376395@qq.com','大徒弟','8nZI3x5AcJz4aZiFPBYDgZKBhNrfuDbdZ4YHBEAp',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'115.238.194.18',NULL,1,1532069429,1533968601);

/*!40000 ALTER TABLE `helpe_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table helpe_user_private
# ------------------------------------------------------------

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




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
