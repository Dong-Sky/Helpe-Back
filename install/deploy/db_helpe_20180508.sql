-- MySQL dump 10.13  Distrib 5.6.39, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: db_helpe
-- ------------------------------------------------------
-- Server version	5.6.39-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `helpe_address`
--

DROP TABLE IF EXISTS `helpe_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_address`
--

LOCK TABLES `helpe_address` WRITE;
/*!40000 ALTER TABLE `helpe_address` DISABLE KEYS */;
INSERT INTO `helpe_address` VALUES (1,1,1,'测试地址',1,1,1111,0),(84,1,0,'华东理工大学',1,1,1522162893,1522162893),(85,1,0,'apple store',37.7854,-122.408,1524040260,1524040260),(86,2,0,'apple store',37.7858,-122.406,1524063276,1524063276);
/*!40000 ALTER TABLE `helpe_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_admin`
--

DROP TABLE IF EXISTS `helpe_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_admin`
--

LOCK TABLES `helpe_admin` WRITE;
/*!40000 ALTER TABLE `helpe_admin` DISABLE KEYS */;
INSERT INTO `helpe_admin` VALUES (1,'super','super@admin.com','','administrator',10,'gKkLFMdB2pvIXOFNpF_Aeemvdf1j0YUM','$2y$13$Nuf1mzDRoCMxrWI.rIjENu20QshJG41smdEeHFHxq0qdmS99YytHy','5vLaPpUS-I-XxJaoGP-GZDk474WdnaK3_1469073015',1519919184,'127.0.0.1','湖南省,岳阳市,岳阳县',1519919184,1,1519919184,1),(2,'admin','admin@admin.com','','admin',10,'tArp_Kv4z1JlzBUZYCL33N24AZL-_77p','$2y$13$RNrJ7GK1A5iZRxBpho6sbeCJKfNRxzy5axCeRjZLqvA5W6RuVYBRW','CgScbf1E96N3pqH01b0mVi_Z58j8QsRV_1501916190',1521103495,'127.0.0.1','湖南省,岳阳市,岳阳县',1519919184,1,1521103495,2);
/*!40000 ALTER TABLE `helpe_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_admin_log`
--

DROP TABLE IF EXISTS `helpe_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_admin_log`
--

LOCK TABLES `helpe_admin_log` WRITE;
/*!40000 ALTER TABLE `helpe_admin_log` DISABLE KEYS */;
INSERT INTO `helpe_admin_log` VALUES (1,2,'china','update','/china/update','id=991400','{\"id\":\"991400\",\"name\":\"第十四师\",\"pid\":\"990000\",\"oper\":\"edit\"}',1520069216,2);
/*!40000 ALTER TABLE `helpe_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_arrange`
--

DROP TABLE IF EXISTS `helpe_arrange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_arrange`
--

LOCK TABLES `helpe_arrange` WRITE;
/*!40000 ALTER TABLE `helpe_arrange` DISABLE KEYS */;
/*!40000 ALTER TABLE `helpe_arrange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_auth_assignment`
--

DROP TABLE IF EXISTS `helpe_auth_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_auth_assignment` (
  `item_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `auth_assignment_user_id_idx` (`user_id`),
  CONSTRAINT `helpe_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_auth_assignment`
--

LOCK TABLES `helpe_auth_assignment` WRITE;
/*!40000 ALTER TABLE `helpe_auth_assignment` DISABLE KEYS */;
INSERT INTO `helpe_auth_assignment` VALUES ('admin','2',1519919184),('administrator','1',1519919184);
/*!40000 ALTER TABLE `helpe_auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_auth_item`
--

DROP TABLE IF EXISTS `helpe_auth_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_auth_item`
--

LOCK TABLES `helpe_auth_item` WRITE;
/*!40000 ALTER TABLE `helpe_auth_item` DISABLE KEYS */;
INSERT INTO `helpe_auth_item` VALUES ('admin',1,'管理员',NULL,NULL,1519919184,1519919184),('admin-log/delete',2,'操作日志-删除数据',NULL,NULL,1519919184,1519919184),('admin-log/delete-all',2,'操作日志-批量删除',NULL,NULL,1519919184,1519919184),('admin-log/export',2,'操作日志-导出数据',NULL,NULL,1519919184,1519919184),('admin-log/index',2,'操作日志-显示页面',NULL,NULL,1519919184,1519919184),('admin-log/search',2,'操作日志-搜索数据',NULL,NULL,1519919184,1519919184),('admin/address',2,'管理员信息信息-查询地址',NULL,NULL,1519919184,1519919184),('admin/create',2,'管理员信息-添加数据',NULL,NULL,1519919184,1519919184),('admin/delete',2,'管理员信息-删除数据','admin-delete',NULL,1519919184,1519919184),('admin/delete-all',2,'管理员信息-批量删除',NULL,NULL,1519919184,1519919184),('admin/editable',2,'管理员信息-行内编辑',NULL,NULL,1519919184,1519919184),('admin/export',2,'管理员信息-导出数据',NULL,NULL,1519919184,1519919184),('admin/index',2,'管理员信息-显示数据',NULL,NULL,1519919184,1519919184),('admin/search',2,'管理员信息-搜索数据',NULL,NULL,1519919184,1519919184),('admin/update',2,'管理员信息-修改数据','admin',NULL,1519919184,1519919184),('admin/upload',2,'管理员信息-上传头像',NULL,NULL,1519919184,1519919184),('admin/view',2,'管理员信息-显示详情',NULL,NULL,1519919184,1519919184),('administrator',1,'超级管理员',NULL,NULL,1519919184,1519919184),('arrange/arrange',2,'我的日程-查询数据',NULL,NULL,1519919184,1519919184),('arrange/calendar',2,'我的日程-查看详情',NULL,NULL,1519919184,1519919184),('arrange/create',2,'日程管理-添加数据',NULL,NULL,1519919184,1519919184),('arrange/delete',2,'日程管理-删除数据',NULL,NULL,1519919184,1519919184),('arrange/delete-all',2,'日程信息-批量删除',NULL,NULL,1519919184,1519919184),('arrange/editable',2,'日程管理-行内编辑',NULL,NULL,1519919184,1519919184),('arrange/export',2,'日程信息-导出数据',NULL,NULL,1519919184,1519919184),('arrange/index',2,'日程管理-显示页面',NULL,NULL,1519919184,1519919184),('arrange/search',2,'日程管理-搜索数据',NULL,NULL,1519919184,1519919184),('arrange/update',2,'日程管理-修改数据',NULL,NULL,1519919184,1519919184),('auth-assignment/create',2,'角色分配-添加数据',NULL,NULL,1519919184,1519919184),('auth-assignment/delete',2,'角色分配-删除数据','auth-assignment',NULL,1519919184,1519919184),('auth-assignment/export',2,'角色分配-导出数据',NULL,NULL,1519919184,1519919184),('auth-assignment/index',2,'角色分配-显示页面',NULL,NULL,1519919184,1519919184),('auth-assignment/search',2,'角色分配-搜索数据',NULL,NULL,1519919184,1519919184),('auth-rule/create',2,'规则管理-添加数据',NULL,NULL,1519919184,1519919184),('auth-rule/delete',2,'规则管理-删除数据',NULL,NULL,1519919184,1519919184),('auth-rule/delete-all',2,'规则管理-批量删除',NULL,NULL,1519919184,1519919184),('auth-rule/export',2,'规则管理-导出数据',NULL,NULL,1519919184,1519919184),('auth-rule/index',2,'规则管理-显示数据',NULL,NULL,1519919184,1519919184),('auth-rule/search',2,'规则管理-搜索数据',NULL,NULL,1519919184,1519919184),('auth-rule/update',2,'规则管理-修改数据',NULL,NULL,1519919184,1519919184),('authority/create',2,'权限信息-添加数据',NULL,NULL,1519919184,1519919184),('authority/delete',2,'权限信息-删除数据',NULL,NULL,1519919184,1519919184),('authority/delete-all',2,'权限信息-批量删除',NULL,NULL,1519919184,1519919184),('authority/export',2,'权限信息-导出数据',NULL,NULL,1519919184,1519919184),('authority/index',2,'权限信息-显示页面',NULL,NULL,1519919184,1519919184),('authority/search',2,'权限信息-搜索数据',NULL,NULL,1519919184,1519919184),('authority/update',2,'权限信息-修改数据',NULL,NULL,1519919184,1519919184),('china/create',2,'地址信息-添加数据',NULL,NULL,1519919184,1519919184),('china/delete',2,'地址信息-删除数据',NULL,NULL,1519919184,1519919184),('china/delete-all',2,'地址信息-批量删除',NULL,NULL,1519919184,1519919184),('china/export',2,'地址信息-导出数据',NULL,NULL,1519919184,1519919184),('china/index',2,'地址信息-显示页面',NULL,NULL,1519919184,1519919184),('china/search',2,'地址信息-搜索数据',NULL,NULL,1519919184,1519919184),('china/update',2,'地址信息-修改数据',NULL,NULL,1519919184,1519919184),('menu/create',2,'导航栏目-添加数据',NULL,NULL,1519919184,1519919184),('menu/delete',2,'导航栏目-删除数据',NULL,NULL,1519919184,1519919184),('menu/delete-all',2,'导航栏目-批量删除',NULL,NULL,1519919184,1519919184),('menu/export',2,'导航栏目-导出数据',NULL,NULL,1519919184,1519919184),('menu/index',2,'导航栏目-显示页面',NULL,NULL,1519919184,1519919184),('menu/search',2,'导航栏目-搜索数据',NULL,NULL,1519919184,1519919184),('menu/update',2,'导航栏目-修改数据',NULL,NULL,1519919184,1519919184),('module/create',2,'模块生成-生成预览表单',NULL,NULL,1519919184,1519919184),('module/index',2,'模块生成-显示页面',NULL,NULL,1519919184,1519919184),('module/produce',2,'模块生成-生成文件',NULL,NULL,1519919184,1519919184),('module/update',2,'模块生成-生成预览文件',NULL,NULL,1519919184,1519919184),('role/create',2,'角色信息-添加数据',NULL,NULL,1519919184,1519919184),('role/delete',2,'角色信息-删除数据',NULL,NULL,1519919184,1519919184),('role/edit',2,'角色信息-分配权限',NULL,NULL,1519919184,1519919184),('role/export',2,'角色信息-导出数据',NULL,NULL,1519919184,1519919184),('role/index',2,'角色信息-显示页面',NULL,NULL,1519919184,1519919184),('role/search',2,'角色信息-搜索数据',NULL,NULL,1519919184,1519919184),('role/update',2,'角色信息-修改数据',NULL,NULL,1519919184,1519919184),('role/view',2,'角色权限-查看详情',NULL,NULL,1519919184,1519919184),('uploads/create',2,'上传文件-添加数据',NULL,NULL,1519919184,1519919184),('uploads/delete',2,'上传文件-删除数据',NULL,NULL,1519919184,1519919184),('uploads/delete-all',2,'上传文件-批量删除',NULL,NULL,1519919184,1519919184),('uploads/export',2,'上传文件-导出数据',NULL,NULL,1519919184,1519919184),('uploads/index',2,'上传文件-显示页面',NULL,NULL,1519919184,1519919184),('uploads/search',2,'上传文件-搜索数据',NULL,NULL,1519919184,1519919184),('uploads/update',2,'上传文件-修改数据',NULL,NULL,1519919184,1519919184),('user/create',2,'用户信息-添加数据',NULL,NULL,1519919184,1519919184),('user/delete',2,'用户信息-删除数据',NULL,NULL,1519919184,1519919184),('user/delete-all',2,'用户信息-批量删除',NULL,NULL,1519919184,1519919184),('user/export',2,'用户信息-导出数据',NULL,NULL,1519919184,1519919184),('user/index',2,'用户信息-显示页面',NULL,NULL,1519919184,1519919184),('user/search',2,'用户信息-搜索数据',NULL,NULL,1519919184,1519919184),('user/update',2,'用户信息-修改数据',NULL,NULL,1519919184,1519919184);
/*!40000 ALTER TABLE `helpe_auth_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_auth_item_child`
--

DROP TABLE IF EXISTS `helpe_auth_item_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_auth_item_child` (
  `parent` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `helpe_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `helpe_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `helpe_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_auth_item_child`
--

LOCK TABLES `helpe_auth_item_child` WRITE;
/*!40000 ALTER TABLE `helpe_auth_item_child` DISABLE KEYS */;
INSERT INTO `helpe_auth_item_child` VALUES ('administrator','admin-log/delete'),('administrator','admin-log/delete-all'),('admin','admin-log/export'),('administrator','admin-log/export'),('admin','admin-log/index'),('administrator','admin-log/index'),('admin','admin-log/search'),('administrator','admin-log/search'),('admin','admin/address'),('administrator','admin/address'),('admin','admin/create'),('administrator','admin/create'),('admin','admin/delete'),('administrator','admin/delete'),('admin','admin/delete-all'),('administrator','admin/delete-all'),('admin','admin/editable'),('administrator','admin/editable'),('admin','admin/export'),('administrator','admin/export'),('admin','admin/index'),('administrator','admin/index'),('admin','admin/search'),('administrator','admin/search'),('admin','admin/update'),('administrator','admin/update'),('admin','admin/upload'),('administrator','admin/upload'),('admin','admin/view'),('administrator','admin/view'),('admin','arrange/arrange'),('administrator','arrange/arrange'),('admin','arrange/calendar'),('administrator','arrange/calendar'),('admin','arrange/create'),('administrator','arrange/create'),('admin','arrange/delete'),('administrator','arrange/delete'),('admin','arrange/delete-all'),('administrator','arrange/delete-all'),('admin','arrange/editable'),('administrator','arrange/editable'),('admin','arrange/export'),('administrator','arrange/export'),('admin','arrange/index'),('administrator','arrange/index'),('admin','arrange/search'),('administrator','arrange/search'),('admin','arrange/update'),('administrator','arrange/update'),('administrator','auth-assignment/create'),('administrator','auth-assignment/delete'),('administrator','auth-assignment/export'),('administrator','auth-assignment/index'),('administrator','auth-assignment/search'),('administrator','auth-rule/create'),('administrator','auth-rule/delete'),('administrator','auth-rule/delete-all'),('administrator','auth-rule/export'),('administrator','auth-rule/index'),('administrator','auth-rule/search'),('administrator','auth-rule/update'),('administrator','authority/create'),('administrator','authority/delete'),('administrator','authority/delete-all'),('administrator','authority/export'),('administrator','authority/index'),('administrator','authority/search'),('administrator','authority/update'),('admin','china/create'),('administrator','china/create'),('admin','china/delete'),('administrator','china/delete'),('admin','china/delete-all'),('administrator','china/delete-all'),('admin','china/export'),('administrator','china/export'),('admin','china/index'),('administrator','china/index'),('admin','china/search'),('administrator','china/search'),('admin','china/update'),('administrator','china/update'),('administrator','menu/create'),('administrator','menu/delete'),('administrator','menu/delete-all'),('administrator','menu/export'),('administrator','menu/index'),('administrator','menu/search'),('admin','menu/update'),('administrator','menu/update'),('admin','module/create'),('administrator','module/create'),('admin','module/index'),('administrator','module/index'),('admin','module/produce'),('administrator','module/produce'),('admin','module/update'),('administrator','module/update'),('admin','role/create'),('administrator','role/create'),('admin','role/delete'),('administrator','role/delete'),('admin','role/edit'),('administrator','role/edit'),('admin','role/export'),('administrator','role/export'),('admin','role/index'),('administrator','role/index'),('admin','role/search'),('administrator','role/search'),('admin','role/update'),('administrator','role/update'),('admin','role/view'),('administrator','role/view'),('admin','uploads/create'),('administrator','uploads/create'),('admin','uploads/delete'),('administrator','uploads/delete'),('admin','uploads/delete-all'),('administrator','uploads/delete-all'),('admin','uploads/export'),('administrator','uploads/export'),('admin','uploads/index'),('administrator','uploads/index'),('admin','uploads/search'),('administrator','uploads/search'),('admin','uploads/update'),('administrator','uploads/update'),('admin','user/create'),('administrator','user/create'),('admin','user/delete'),('administrator','user/delete'),('admin','user/delete-all'),('administrator','user/delete-all'),('admin','user/export'),('administrator','user/export'),('admin','user/index'),('administrator','user/index'),('admin','user/search'),('administrator','user/search'),('admin','user/update'),('administrator','user/update');
/*!40000 ALTER TABLE `helpe_auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_auth_rule`
--

DROP TABLE IF EXISTS `helpe_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_auth_rule` (
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_auth_rule`
--

LOCK TABLES `helpe_auth_rule` WRITE;
/*!40000 ALTER TABLE `helpe_auth_rule` DISABLE KEYS */;
INSERT INTO `helpe_auth_rule` VALUES ('admin','O:23:\"backend\\rules\\AdminRule\":3:{s:4:\"name\";s:5:\"admin\";s:9:\"createdAt\";i:1499006069;s:9:\"updatedAt\";i:1499006069;}',1519919184,1519919184),('admin-delete','O:29:\"backend\\rules\\AdminDeleteRule\":3:{s:4:\"name\";s:12:\"admin-delete\";s:9:\"createdAt\";i:1501919066;s:9:\"updatedAt\";i:1501919066;}',1519919184,1519919184),('auth-assignment','O:32:\"backend\\rules\\AuthAssignmentRule\":5:{s:4:\"name\";s:15:\"auth-assignment\";s:9:\"createdAt\";i:1500105238;s:9:\"updatedAt\";i:1500105238;s:47:\" backend\\rules\\AuthAssignmentRule adminRoleName\";s:13:\"administrator\";s:43:\" backend\\rules\\AuthAssignmentRule intUserId\";i:1;}',1519919184,1519919184);
/*!40000 ALTER TABLE `helpe_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_category`
--

DROP TABLE IF EXISTS `helpe_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_category`
--

LOCK TABLES `helpe_category` WRITE;
/*!40000 ALTER TABLE `helpe_category` DISABLE KEYS */;
INSERT INTO `helpe_category` VALUES (1,'古本','',0,1,1,0,NULL),(2,'売買','',0,1,1,0,NULL),(3,'レンタル','',0,1,1,0,NULL),(4,'ペット','',0,1,1,0,NULL),(5,'イベント  ','',0,1,1,0,NULL),(6,'習い事','',0,1,1,0,NULL),(7,'お手伝い','',0,1,1,0,NULL),(8,'その他','',0,1,1,0,NULL);
/*!40000 ALTER TABLE `helpe_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_fav`
--

DROP TABLE IF EXISTS `helpe_fav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_fav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `itemid` (`itemid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_fav`
--

LOCK TABLES `helpe_fav` WRITE;
/*!40000 ALTER TABLE `helpe_fav` DISABLE KEYS */;
INSERT INTO `helpe_fav` VALUES (1,1,1,11111,111111),(3,2,368,1524811190,1524811190);
/*!40000 ALTER TABLE `helpe_fav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_feedback`
--

DROP TABLE IF EXISTS `helpe_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_feedback`
--

LOCK TABLES `helpe_feedback` WRITE;
/*!40000 ALTER TABLE `helpe_feedback` DISABLE KEYS */;
INSERT INTO `helpe_feedback` VALUES (23,'henhao',5,0,99,80,2,1,1522143447,1522160476),(24,'good',368,0,50,81,2,1,1525258417,1525258417);
/*!40000 ALTER TABLE `helpe_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_follow`
--

DROP TABLE IF EXISTS `helpe_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uuid` (`uuid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_follow`
--

LOCK TABLES `helpe_follow` WRITE;
/*!40000 ALTER TABLE `helpe_follow` DISABLE KEYS */;
INSERT INTO `helpe_follow` VALUES (1,1,2,1525173268,1525173268);
/*!40000 ALTER TABLE `helpe_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_item`
--

DROP TABLE IF EXISTS `helpe_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `unit` varchar(30) NOT NULL COMMENT '单位',
  `pet` int(11) NOT NULL COMMENT '发布过期时间，服务90天，求助30天',
  PRIMARY KEY (`id`),
  KEY `aaid` (`aaid`),
  KEY `lng` (`lng`)
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_item`
--

LOCK TABLES `helpe_item` WRITE;
/*!40000 ALTER TABLE `helpe_item` DISABLE KEYS */;
INSERT INTO `helpe_item` VALUES (1,'1',1,1000.00,'/img',0,1520696319,1521261910,1,1,0,1,1,1,1,1,1520696319,0,'contact',0,'2018-05','ci',1520696319),(2,'2',2,1000.00,'/img',0,1520696319,1520696319,1,1,0,1,1,1,1,1,1520696319,0,'contact',0,'2018-05','ci',1520696319),(3,'3',2,1000.00,'/img',0,1520696319,1520696319,1,1,0,1,1,1,1,1,1520696319,0,'contact',0,'2018-05','ci',1520696319),(4,'4',2,1000.00,'/img',0,1520696319,1520696319,1,1,0,1,1,1,1,1,1520696319,0,'contact',0,'2018-05','ci',1520696319),(5,'name555',2,1000.00,'/img',0,1520696319,1520696319,2,1,0,1,1,1,1,1,1520696319,0,'contact',0,'2018-05','ci',1520696319),(266,'test22',0,0.00,'/sstetttt.jpg',1,1521131186,1521131186,1,0,133333,0,22,0,1,1,1521131186,0,'testtest11tesxt',0,NULL,'',0),(270,'test22',0,0.00,'/sstetttt.jpg',1,1521132430,1521132430,1,0,133333,0,22,0,1,1,1521132430,0,'testtest11tesxt',0,NULL,'',0),(271,'test22',0,0.00,'/sstetttt.jpg',1,1521132493,1521132493,1,0,133333,0,22,0,1,1,1521132493,0,'testtest11tesxt',0,NULL,'',0),(281,'test22',0,0.00,'/sstetttt.jpg',1,1521134503,1521134503,1,0,133333,0,22,0,1,1,1521134503,0,'testtest11tesxt',0,NULL,'',0),(282,'test22',0,0.00,'/sstetttt.jpg',1,1521134598,1521134598,1,0,133333,0,22,0,1,1,1521134598,0,'testtest11tesxt',0,NULL,'',0),(283,'test22',0,0.00,'/sstetttt.jpg',1,1521134662,1521134662,1,0,133333,0,22,0,1,1,1521134662,0,'testtest11tesxt',0,NULL,'',0),(284,'test22',0,0.00,'/sstetttt.jpg',1,1521212672,1521212672,1,0,133333,0,22,0,1,1,1521212672,0,'testtest11tesxt',0,NULL,'',0),(285,'test22',0,0.00,'/sstetttt.jpg',1,1521213617,1521213617,1,0,133333,0,22,0,1,1,1521213617,0,'testtest11tesxt',0,NULL,'',0),(286,'test22',0,0.00,'/sstetttt.jpg',1,1521213725,1521213725,1,0,133333,0,22,0,1,1,1521213725,0,'testtest11tesxt',0,NULL,'',0),(287,'test22',0,0.00,'/sstetttt.jpg',1,1521213800,1521213800,1,0,133333,0,22,0,1,1,1521213800,0,'testtest11tesxt',0,NULL,'',0),(288,'test22',0,0.00,'/sstetttt.jpg',1,1521213835,1521213835,1,0,133333,0,22,0,1,1,1521213835,0,'testtest11tesxt',0,NULL,'',0),(289,'test22',0,0.00,'/sstetttt.jpg',1,1521214379,1521214379,1,0,133333,0,22,0,1,1,1521214379,0,'testtest11tesxt',0,NULL,'',0),(290,'test22',0,0.00,'/sstetttt.jpg',1,1521214999,1521701785,1,0,133333,0,22,0,1,1,1521214999,0,'testtest11tesxt',0,NULL,'',0),(291,'test22',0,0.00,'/sstetttt.jpg',1,1521218480,1521218480,1,0,133333,0,22,0,1,1,1521218480,0,'testtest11tesxt',0,NULL,'',0),(295,'test22',0,0.00,'/sstetttt.jpg',1,1521255688,1521255688,1,0,133333,0,22,0,1,1,1521255688,0,'testtest11tesxt',0,NULL,'',0),(296,'test22',0,0.00,'/sstetttt.jpg',1,1521255797,1521255797,1,0,133333,0,22,0,1,1,1521255797,0,'testtest11tesxt',0,NULL,'',0),(297,'test22',0,0.00,'/sstetttt.jpg',1,1521255826,1521255826,1,0,133333,0,22,0,1,1,1521255826,0,'testtest11tesxt',0,NULL,'',0),(298,'test22',0,0.00,'/sstetttt.jpg',1,1521255881,1521255881,1,0,133333,0,22,0,1,1,1521255881,0,'testtest11tesxt',0,NULL,'',0),(299,'test22',0,0.00,'/sstetttt.jpg',1,1521255973,1521255973,1,0,133333,0,22,0,1,1,1521255973,0,'testtest11tesxt',0,NULL,'',0),(300,'test22',0,0.00,'/sstetttt.jpg',1,1521256103,1521256103,1,0,133333,0,22,0,1,1,1521256103,0,'testtest11tesxt',0,NULL,'',0),(301,'test22',0,0.00,'/sstetttt.jpg',1,1521256248,1521256248,1,0,133333,0,22,0,1,1,1521256248,0,'testtest11tesxt',0,NULL,'',0),(302,'test22',0,0.00,'/sstetttt.jpg',1,1521256896,1521256896,1,0,133333,0,22,0,1,1,1521256896,0,'testtest11tesxt',0,NULL,'',0),(320,'test22',0,0.00,'/sstetttt.jpg',1,1521258472,1521258472,1,0,133333,0,22,0,1,1,1521258472,0,'testtest11tesxt',0,NULL,'',0),(340,'test22',0,0.00,'/sstetttt.jpg',1,1521261538,1521261538,1,0,133333,0,22,0,1,1,1521261538,0,'testtest11tesxt',0,NULL,'',0),(347,'test22',0,0.00,'/sstetttt.jpg',1,1521993895,1521993895,1,0,133333,0,22,0,1,1,1521993895,0,'testtest11tesxt',0,NULL,'',0),(348,'Test',0,123.00,'/sstetttt.jpg',1,1522494443,1522494443,1,3,133333,0,1,0,1,1,1522494443,0,'aaa',0,NULL,'',0),(349,'Try',0,12345.00,'',1,1522649625,1522649625,1,2,133333,0,84,0,1,1,1522649625,0,'aa',0,NULL,'',0),(350,'B.B.',0,22.00,'',0,1523254196,1523262707,1,5,133333,0,1,0,1,1,1523254196,0,'null',0,NULL,'',0),(351,'aaaa',0,123.00,'',0,1523269522,1523269522,1,2,133333,0,84,0,1,1,1523269522,1,'null',0,NULL,'',0),(352,'cc',0,123.00,'',0,1523269729,1523269729,1,2,133333,0,1,0,1,1,1523269729,1,'null',0,NULL,'',0),(353,'Www',0,123.00,'',0,1523269887,1523269887,1,4,133333,0,1,0,1,1,1523269887,1,'null',0,NULL,'',0),(354,'test22',0,0.00,'',0,1523277409,1523277409,1,1,133333,1,1,0,1,1,1523277409,0,'testtest11tesxt',0,NULL,'',0),(355,'Dodd',0,123.00,'',1,1523336760,1523336785,1,2,133333,0,84,0,1,1,1523336760,1,'null',0,NULL,'',1531112785),(356,'Try',0,888.00,'',0,1523337515,1523339236,1,4,133333,0,84,0,1,1,1523337515,0,'aaa',0,NULL,'',1531113523),(357,'As',0,213.00,'',1,1523339312,1523339314,1,4,133333,0,84,0,1,1,1523339312,1,'null',0,NULL,'',1531115314),(358,'We’re',0,778.00,'',0,1523339384,1523339384,1,3,133333,0,84,0,1,1,1523339384,1,'null',0,NULL,'',0),(359,'We',0,12345.00,'',0,1523339997,1523339997,1,3,133333,0,84,0,1,1,1523339997,1,'aa',0,NULL,'',0),(360,'lol',0,12.00,'',1,1523340091,1523340095,1,-1,133333,0,84,0,1,1,1523340091,1,'null',0,NULL,'',1531116095),(361,'test22',0,0.00,'',0,1523340290,1523340290,1,0,133333,1,1,0,1,1,1523340290,0,'33333',0,NULL,'',0),(362,'Err',0,31.00,'',0,1523341761,1523341761,1,2,133333,0,84,0,1,1,1523341761,1,'null',0,NULL,'',0),(363,'Err',0,31.00,'',1,1523341803,1523342090,1,2,133333,0,84,0,1,1,1523341803,1,'null',0,NULL,'',1531118090),(364,'Ee',0,123.00,'',0,1523342384,1523342384,1,5,133333,0,1,0,1,1,1523342384,1,'null',0,NULL,'',0),(365,'Kk',0,1123.00,'',0,1523343067,1523343067,1,4,133333,0,84,0,1,1,1523343067,1,'null',0,NULL,'',0),(366,'Try',0,123.00,'',0,1523343544,1523343544,1,3,133333,0,84,0,1,1,1523343544,1,'null',0,NULL,'',0),(367,'Ppp',0,66.00,'/images/itemfiles/qXt2eCJm7XV9hHs_1523351866.jpg',1,1523351866,1524030757,1,2,133333,0,84,0,1,1,1523351866,1,'null',0,NULL,'',1531806757),(368,'Iphone',0,3333.00,'/images/itemfiles/zhJYeTgMsiiBy9z_1524040387.jpg',1,1524040387,1524040399,1,2,133333,0,85,0,37.7854,-122.408,1524040387,1,'12345515',0,NULL,'',1531816399);
/*!40000 ALTER TABLE `helpe_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_itemdetail`
--

DROP TABLE IF EXISTS `helpe_itemdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_itemdetail` (
  `itemid` int(11) NOT NULL,
  `mark` text NOT NULL COMMENT '描述',
  `ct` int(11) NOT NULL,
  `mt` int(11) NOT NULL,
  PRIMARY KEY (`itemid`),
  KEY `itemid` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_itemdetail`
--

LOCK TABLES `helpe_itemdetail` WRITE;
/*!40000 ALTER TABLE `helpe_itemdetail` DISABLE KEYS */;
INSERT INTO `helpe_itemdetail` VALUES (1,'得到的，个，个，个，个，',1520696319,0),(281,'0',1521134503,1521134503),(282,'0',1521134598,1521134598),(283,'0',1521134662,1521134662),(284,'0',1521212672,1521212672),(285,'0',1521213617,1521213617),(286,'0',1521213725,1521213725),(287,'0',1521213800,1521213800),(288,'0',1521213835,1521213835),(289,'0',1521214379,1521214379),(290,'0',1521214999,1521214999),(291,'0',1521218480,1521218480),(295,'0',1521255688,1521255688),(296,'0',1521255797,1521255797),(297,'0',1521255826,1521255826),(298,'0',1521255881,1521255881),(299,'0',1521255973,1521255973),(300,'0',1521256103,1521256103),(301,'111111111',1521256248,1521256248),(302,'111111111',1521256896,1521256896),(320,'111111111',1521258472,1521258472),(340,'333333',1521261538,1521261538),(347,'333333',1521993895,1521993895),(348,'null',1522494443,1522494443),(349,'null',1522649625,1522649625),(350,'null',1523254196,1523254196),(351,'null',1523269522,1523269522),(352,'null',1523269729,1523269729),(353,'null',1523269887,1523269887),(354,'333333',1523277409,1523277409),(355,'null',1523336760,1523336760),(356,'aaaaa',1523337515,1523337515),(357,'null',1523339312,1523339312),(358,'null',1523339384,1523339384),(359,'ada',1523339997,1523339997),(360,'null',1523340091,1523340091),(361,'333333444444',1523340290,1523340290),(362,'null',1523341761,1523341761),(363,'null',1523341803,1523341803),(364,'null',1523342384,1523342384),(365,'null',1523343067,1523343067),(366,'null',1523343544,1523343544),(367,'null',1523351866,1523351866),(368,'aaaaa',1524040387,1524040387);
/*!40000 ALTER TABLE `helpe_itemdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_itemimg`
--

DROP TABLE IF EXISTS `helpe_itemimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_itemimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `ct` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `itemid` (`itemid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_itemimg`
--

LOCK TABLES `helpe_itemimg` WRITE;
/*!40000 ALTER TABLE `helpe_itemimg` DISABLE KEYS */;
INSERT INTO `helpe_itemimg` VALUES (1,1,'/itemimg1',1,1520696319),(2,1,'/itemimg2',1,1520696319),(181,347,'/images/itemfiles/ZkHDQJeJsbQMCfR_1521993895.jpeg',1,1521993895),(182,347,'/images/itemfiles/FaAir9ejSfuKDxN_1521993895.jpg',1,1521993895),(183,354,'/images/itemfiles/xFIAbW4sX3YkQSn_1523277409.jpg',1,1523277409),(184,354,'/images/itemfiles/QV4vYeW4fbNxmvN_1523277409.jpg',1,1523277409),(185,361,'/images/itemfiles/exQxwDUGEhPHjR7_1523340290.jpg',1,1523340290),(186,361,'/images/itemfiles/c4jRN8rjyU5qJ3c_1523340290.jpg',1,1523340290),(187,362,'/images/itemfiles/zaJAMAmA4wF7yRI_1523341761.',1,1523341761),(188,362,'/images/itemfiles/zVFjSRuzTdiKXdi_1523341763.',1,1523341763),(189,362,'/images/itemfiles/98qpFtxdnZYfUjZ_1523341764.',1,1523341764),(190,363,'/images/itemfiles/TpIBGDpgfMJV9h4_1523341803.',1,1523341803),(191,363,'/images/itemfiles/nF78ryitzQ8gKGU_1523341804.',1,1523341804),(192,363,'/images/itemfiles/VzguIDgyAfBMfPa_1523341805.',1,1523341805),(193,364,'/images/itemfiles/thUTy8HRvKRimtX_1523342384.',1,1523342384),(194,364,'/images/itemfiles/qKcxPB8ncsVRyzm_1523342385.',1,1523342385),(195,365,'/images/itemfiles/24bYJtFPruCw4YS_1523343067.jpg',1,1523343067),(196,365,'/images/itemfiles/fKjbRhdd84M5Pz6_1523343068.jpg',1,1523343068),(197,366,'/images/itemfiles/hebAKNfTbBCt7Hp_1523343544.jpg',1,1523343544),(198,367,'/images/itemfiles/qXt2eCJm7XV9hHs_1523351866.jpg',1,1523351866),(199,367,'/images/itemfiles/MzgMJIWFXj3Yzje_1523351867.jpg',1,1523351867),(200,367,'/images/itemfiles/SFqk8n4u3BwVywg_1523351867.jpg',1,1523351867),(201,368,'/images/itemfiles/zhJYeTgMsiiBy9z_1524040387.jpg',1,1524040387);
/*!40000 ALTER TABLE `helpe_itemimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_mail_template`
--

DROP TABLE IF EXISTS `helpe_mail_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_mail_template`
--

LOCK TABLES `helpe_mail_template` WRITE;
/*!40000 ALTER TABLE `helpe_mail_template` DISABLE KEYS */;
INSERT INTO `helpe_mail_template` VALUES ('forgetPassword','忘记密码邮件','service@helpe.online','Forget Password of helpe.online','Helpe アカウント\n認証 コード\n\nHelpe アカウント {{email}}(用户注册的邮箱) には、次の認証コードをお使いください。\n\n認証コード：{{checkDigit}}(位数需要确认下)\n\nお客様がこのコードを請求していない場合は、このメールを無視しても問題ありません。他のユーザーが誤ってお客様のメールアドレスを入力した可能性があります。\n\nサービスのご利用がありがとうございます。\n\nHelpeアカウント チーム',NULL,0,0),('registerCheckDigit','注册确认邮件','service@helpe.online','welcome to helpe.online','Helpe アカウント\n認証 コード\n\nHelpe アカウント {{email}}(用户注册的邮箱) には、次の認証コードをお使いください。\n\n認証コード：{{checkDigit}}(位数需要确认下)\n\nお客様がこのコードを請求していない場合は、このメールを無視しても問題ありません。他のユーザーが誤ってお客様のメールアドレスを入力した可能性があります。\n\nサービスのご利用がありがとうございます。\n\nHelpeアカウント チーム',NULL,0,0);
/*!40000 ALTER TABLE `helpe_mail_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_market_log`
--

DROP TABLE IF EXISTS `helpe_market_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_market_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `tpid` int(11) NOT NULL DEFAULT '0' COMMENT '交易信息类型id',
  `data` varchar(100) DEFAULT NULL COMMENT 'json数据',
  `ct` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_market_log`
--

LOCK TABLES `helpe_market_log` WRITE;
/*!40000 ALTER TABLE `helpe_market_log` DISABLE KEYS */;
INSERT INTO `helpe_market_log` VALUES (1,1,1,'{\"username\":\"null\",\"itemname\":\"Iphone\"}',1524063690),(2,1,9,'{\"username\":\"ycyc1996\"}',1525173268),(3,1,9,'{\"username\":\"ycyc1996\"}',1525173277),(4,2,3,'{\"username\":\"ycyc1996\",\"itemname\":\"Iphone\"}',1525174036),(5,1,5,'{\"username\":\"ycyc1996\",\"itemname\":\"Iphone\"}',1525244398),(6,2,7,'{\"username\":\"null\",\"itemname\":\"Iphone\"}',1525244398);
/*!40000 ALTER TABLE `helpe_market_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_menu`
--

DROP TABLE IF EXISTS `helpe_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='后台导航栏目信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_menu`
--

LOCK TABLES `helpe_menu` WRITE;
/*!40000 ALTER TABLE `helpe_menu` DISABLE KEYS */;
INSERT INTO `helpe_menu` VALUES (1,0,'后台管理','menu-icon fa fa-cog','',1,2,1519919184,1,1519919184,1),(2,1,'管理员信息','','admin/index',1,1,1519919184,1,1519919184,1),(3,1,'角色管理','','role/index',1,2,1519919184,1,1519919184,1),(4,1,'角色分配','icon-cog','auth-assignment/index',1,3,1519919184,1,1519919184,1),(5,1,'权限管理','','authority/index',1,4,1519919184,1,1519919184,1),(6,1,'规则管理','menu-icon fa fa-shield','auth-rule/index',1,5,1519919184,1,1519919184,1),(7,1,'导航栏目','','menu/index',1,6,1519919184,1,1519919184,1),(8,1,'模块生成','','module/index',1,7,1519919184,1,1519919184,1),(9,1,'操作日志','','admin-log/index',1,8,1519919184,1,1519919184,1),(10,0,'地址信息','menu-icon fa fa-bank','china/index',1,4,1519919184,1,1519919184,1),(11,0,'用户信息','menu-icon fa fa-user','user/index',1,3,1519919184,1,1519919184,1),(12,0,'日程管理','menu-icon fa fa-calendar','arrange/index',1,1,1519919184,1,1519919184,1),(13,0,'上传文件','menu-icon fa fa-upload','uploads/index',1,9,1519919184,1,1519919184,1);
/*!40000 ALTER TABLE `helpe_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_migration`
--

DROP TABLE IF EXISTS `helpe_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_migration` (
  `version` varchar(180) CHARACTER SET utf8 NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_migration`
--

LOCK TABLES `helpe_migration` WRITE;
/*!40000 ALTER TABLE `helpe_migration` DISABLE KEYS */;
INSERT INTO `helpe_migration` VALUES ('m000000_000000_base',1519919172),('m130524_201442_init',1519919184),('m140506_102106_rbac_init',1519919174),('m170801_061245_create_menu',1519919184),('m170801_072726_create_admin',1519919184),('m170801_074527_create_arrange',1519919184),('m170801_081237_insert_rabc',1519919184),('m170804_163745_create_china',1519919185),('m170805_100055_create_admin_log',1519919185),('m170907_052038_rbac_add_index_on_auth_assignment_user_id',1519919174),('m171118_082050_create_uploads',1519919185);
/*!40000 ALTER TABLE `helpe_migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_orderaddr`
--

DROP TABLE IF EXISTS `helpe_orderaddr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_orderaddr`
--

LOCK TABLES `helpe_orderaddr` WRITE;
/*!40000 ALTER TABLE `helpe_orderaddr` DISABLE KEYS */;
INSERT INTO `helpe_orderaddr` VALUES (202,1,1,'测试地址',1522076966,1,1,79),(203,1,1,'测试地址',1522077081,1,1,80),(204,2,0,'apple store',1524063690,37.7858,-122.406,81);
/*!40000 ALTER TABLE `helpe_orderaddr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_orderinfo`
--

DROP TABLE IF EXISTS `helpe_orderinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_orderinfo`
--

LOCK TABLES `helpe_orderinfo` WRITE;
/*!40000 ALTER TABLE `helpe_orderinfo` DISABLE KEYS */;
INSERT INTO `helpe_orderinfo` VALUES (79,0,1,0,0,1000.00,1522076966,1520696319,1522076966,5,1,1,2,0.00,'dddddd',1,0),(80,0,1,10,0,1000.00,1522077081,1520696319,1522143447,5,1,1,2,0.00,'dddddd',1,1),(81,0,2,40,0,3333.00,1524063690,1524040387,1525258417,368,1,0,1,0.00,'null',1,1);
/*!40000 ALTER TABLE `helpe_orderinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_passport`
--

DROP TABLE IF EXISTS `helpe_passport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_passport`
--

LOCK TABLES `helpe_passport` WRITE;
/*!40000 ALTER TABLE `helpe_passport` DISABLE KEYS */;
INSERT INTO `helpe_passport` VALUES (1,1,'497414900@qq.com','$2y$13$49scLlPeLBHOzcCbZkcv8uVtTllnDLupFTx/eTSJi6iTVSpyEbjzm','',1522398633,1522398633),(2,1,'answer_yyc@163.com','$2y$13$oB60mFnqbXc8DJxQrU9lyeU8MXYRAAfNbI7PqjXfIe17RZvQGaVaG','',1524060831,1524060831);
/*!40000 ALTER TABLE `helpe_passport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_register`
--

DROP TABLE IF EXISTS `helpe_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_register` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '电子邮件',
  `auth_token` varchar(12) NOT NULL DEFAULT '' COMMENT '校验key',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='注册信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_register`
--

LOCK TABLES `helpe_register` WRITE;
/*!40000 ALTER TABLE `helpe_register` DISABLE KEYS */;
INSERT INTO `helpe_register` VALUES (1,'497414900@qq.com','qEIJvX',1522396808,1522396808),(2,'497414900@qq.com','QjBv4W',1522397049,1522397049),(3,'497414900@qq.com','UWNBFi',1522397235,1522397235),(4,'497414900@qq.com','Wqc7Hc',1522397601,1522397601),(5,'497414900@qq.com','dqrDrH',1522397907,1522397907),(6,'497414900@qq.com','ZB5qEJ',1522398043,1522398043),(7,'123456@qq.com','3PP8Vn',1522679684,1522679684),(8,'ft20082@qq.com','T7J856',1522679710,1522679710),(9,'answer_yyc@163.com','jSjUeN',1524060368,1524060368),(10,'answer_yyc@163.com','3MgvzF',1524060605,1524060605),(11,'answer_yyc@163.com','KS48ZW',1524060771,1524060771);
/*!40000 ALTER TABLE `helpe_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_report`
--

DROP TABLE IF EXISTS `helpe_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_report`
--

LOCK TABLES `helpe_report` WRITE;
/*!40000 ALTER TABLE `helpe_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `helpe_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_uploads`
--

DROP TABLE IF EXISTS `helpe_uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '文件名称',
  `url` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '访问地址[可以是json字符串]',
  `multiple` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为多图片上传',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='上传文件信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_uploads`
--

LOCK TABLES `helpe_uploads` WRITE;
/*!40000 ALTER TABLE `helpe_uploads` DISABLE KEYS */;
/*!40000 ALTER TABLE `helpe_uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_user`
--

DROP TABLE IF EXISTS `helpe_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'passport_id',
  `type` tinyint(4) DEFAULT NULL COMMENT '账号类型',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '电子邮件',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '昵称',
  `access_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '',
  `password_reset_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `face` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `gender` tinyint(4) DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `career` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '职业',
  `city` int(11) DEFAULT NULL COMMENT '所在城市',
  `tel` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电话',
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '最近1次客户端IP',
  `info` int(11) DEFAULT NULL COMMENT '用户说明',
  `status` tinyint(4) DEFAULT '1' COMMENT '用户状态1正常',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`email`),
  KEY `access_token` (`access_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_user`
--

LOCK TABLES `helpe_user` WRITE;
/*!40000 ALTER TABLE `helpe_user` DISABLE KEYS */;
INSERT INTO `helpe_user` VALUES (1,1,'497414900@qq.com','ycyc1996','',NULL,NULL,0,NULL,NULL,NULL,NULL,'49.221.207.205',NULL,1,1522398633,1525244018),(2,1,'answer_yyc@163.com','null','n9xr6rs7rJCIxGYXqcmzCWxfdrWyZgUU9urP6sjk',NULL,NULL,0,NULL,NULL,NULL,NULL,'118.163.201.4',NULL,1,1524060831,1525707110);
/*!40000 ALTER TABLE `helpe_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpe_user_private`
--

DROP TABLE IF EXISTS `helpe_user_private`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpe_user_private` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限编号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `private` varchar(30) NOT NULL DEFAULT '' COMMENT '权限key',
  `expire` int(11) NOT NULL COMMENT '过期时间',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpe_user_private`
--

LOCK TABLES `helpe_user_private` WRITE;
/*!40000 ALTER TABLE `helpe_user_private` DISABLE KEYS */;
/*!40000 ALTER TABLE `helpe_user_private` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-08  0:36:29
