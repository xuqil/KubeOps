-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: kubeops
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Table structure for table `assets_idc`
--

DROP TABLE IF EXISTS `assets_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c_time` datetime(6) NOT NULL,
  `u_time` datetime(6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `floor` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_idc`
--

LOCK TABLES `assets_idc` WRITE;
/*!40000 ALTER TABLE `assets_idc` DISABLE KEYS */;
INSERT INTO `assets_idc` VALUES (1,'2020-03-23 15:20:08.626545','2020-03-23 15:20:08.626580','蜂巢','广州大学城','','一楼'),(2,'2020-03-23 15:21:27.737932','2020-03-23 15:21:27.737973','开发','广州大学城A楼','13429842676','三楼');
/*!40000 ALTER TABLE `assets_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_serverassets`
--

DROP TABLE IF EXISTS `assets_serverassets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_serverassets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c_time` datetime(6) NOT NULL,
  `u_time` datetime(6) NOT NULL,
  `marks` longtext NOT NULL,
  `shelves_date` varchar(50) NOT NULL,
  `maintenance_date` varchar(50) NOT NULL,
  `sn` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `device_type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `cabinet` varchar(100) NOT NULL,
  `ip` char(39) DEFAULT NULL,
  `hostname` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `auth_type` varchar(100) NOT NULL,
  `app_env` varchar(100) NOT NULL,
  `os_type` varchar(50) NOT NULL,
  `os_version` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `port` varchar(30) NOT NULL,
  `idc_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_serverassets_ip_061b5a5f_uniq` (`ip`),
  KEY `assets_serverassets_idc_id_08f438e4_fk_assets_idc_id` (`idc_id`),
  CONSTRAINT `assets_serverassets_idc_id_08f438e4_fk_assets_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `assets_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverassets`
--

LOCK TABLES `assets_serverassets` WRITE;
/*!40000 ALTER TABLE `assets_serverassets` DISABLE KEYS */;
INSERT INTO `assets_serverassets` VALUES (1,'2020-03-23 15:41:31.159452','2020-03-24 14:48:24.746665','本机服务器','2020-3-20','无','xqlMagicBook','MagicBook2019','MagicBook','物理机','使用中','无','192.168.1.11','localhost','开发平台','界面和SSH','Python3.7','Linux','Ubuntu19','xql','19218xql','22',2),(2,'2020-03-23 15:43:27.399388','2020-03-23 15:43:27.399416','','2020-3-20','无','MagicBook','MagicBook2019','MagicBook','物理机','使用中','无','192.168.1.12','localhost','生产环境','SSH','Python3.7','Linux','CentOS7','kubeops','kubeops','22',1),(4,'2020-03-24 11:37:25.326920','2020-03-24 14:12:32.930119','DD','D','D','2123','','','','使用中','','127.0.0.1','localhost','D','','','Linux','Ubuntu19.0','','','',1),(5,'2020-03-24 13:50:51.521529','2020-03-24 14:46:10.977396','','2020-3-20','','','','','docker容器','使用中','','192.168.1.13','localhost','','SSH','','Linux','CentOS7','','','',1),(6,'2020-04-01 16:09:22.913685','2020-04-01 16:09:22.913777','','','','','','','','使用中','','192.168.1.15','xql','','','','Linux','','xql','19218xql','22',NULL);
/*!40000 ALTER TABLE `assets_serverassets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_serverassets_tags`
--

DROP TABLE IF EXISTS `assets_serverassets_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_serverassets_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverassets_id` int(11) NOT NULL,
  `tags_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_serverassets_tags_serverassets_id_tags_id_c21ff78e_uniq` (`serverassets_id`,`tags_id`),
  KEY `assets_serverassets_tags_tags_id_8666876c_fk_assets_tags_id` (`tags_id`),
  CONSTRAINT `assets_serverassets__serverassets_id_e52a3f3c_fk_assets_se` FOREIGN KEY (`serverassets_id`) REFERENCES `assets_serverassets` (`id`),
  CONSTRAINT `assets_serverassets_tags_tags_id_8666876c_fk_assets_tags_id` FOREIGN KEY (`tags_id`) REFERENCES `assets_tags` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverassets_tags`
--

LOCK TABLES `assets_serverassets_tags` WRITE;
/*!40000 ALTER TABLE `assets_serverassets_tags` DISABLE KEYS */;
INSERT INTO `assets_serverassets_tags` VALUES (9,1,1),(10,1,2),(11,1,3),(3,2,1),(4,2,2),(7,5,1),(8,5,2);
/*!40000 ALTER TABLE `assets_serverassets_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_tags`
--

DROP TABLE IF EXISTS `assets_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c_time` datetime(6) NOT NULL,
  `u_time` datetime(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_tags`
--

LOCK TABLES `assets_tags` WRITE;
/*!40000 ALTER TABLE `assets_tags` DISABLE KEYS */;
INSERT INTO `assets_tags` VALUES (1,'2020-03-23 15:35:10.374926','2020-03-23 15:35:10.374952','本地服务器','本地服务器'),(2,'2020-03-23 16:29:01.622853','2020-03-23 16:29:01.622878','物理机','物理机'),(3,'2020-03-24 06:47:21.360245','2020-03-24 07:03:21.427526','测试机','测试部');
/*!40000 ALTER TABLE `assets_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`) USING BTREE,
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add menu',7,'add_menu'),(26,'Can change menu',7,'change_menu'),(27,'Can delete menu',7,'delete_menu'),(28,'Can view menu',7,'view_menu'),(29,'Can add permission',8,'add_permission'),(30,'Can change permission',8,'change_permission'),(31,'Can delete permission',8,'delete_permission'),(32,'Can view permission',8,'view_permission'),(33,'Can add role',9,'add_role'),(34,'Can change role',9,'change_role'),(35,'Can delete role',9,'delete_role'),(36,'Can view role',9,'view_role'),(37,'Can add user profile',10,'add_userprofile'),(38,'Can change user profile',10,'change_userprofile'),(39,'Can delete user profile',10,'delete_userprofile'),(40,'Can view user profile',10,'view_userprofile'),(41,'Can add permissions',8,'add_permissions'),(42,'Can change permissions',8,'change_permissions'),(43,'Can delete permissions',8,'delete_permissions'),(44,'Can view permissions',8,'view_permissions'),(45,'Can add 标签表',11,'add_tags'),(46,'Can change 标签表',11,'change_tags'),(47,'Can delete 标签表',11,'delete_tags'),(48,'Can view 标签表',11,'view_tags'),(49,'Can add IDC数据中心',12,'add_idc'),(50,'Can change IDC数据中心',12,'change_idc'),(51,'Can delete IDC数据中心',12,'delete_idc'),(52,'Can view IDC数据中心',12,'view_idc'),(53,'Can add 服务器资产表',13,'add_serverassets'),(54,'Can change 服务器资产表',13,'change_serverassets'),(55,'Can delete 服务器资产表',13,'delete_serverassets'),(56,'Can view 服务器资产表',13,'view_serverassets'),(160,'Can add 分类',39,'add_category'),(161,'Can change 分类',39,'change_category'),(162,'Can delete 分类',39,'delete_category'),(163,'Can view 分类',39,'view_category'),(164,'Can add 评论',40,'add_comment'),(165,'Can change 评论',40,'change_comment'),(166,'Can delete 评论',40,'delete_comment'),(167,'Can view 评论',40,'view_comment'),(168,'Can add 标签云',41,'add_tag'),(169,'Can change 标签云',41,'change_tag'),(170,'Can delete 标签云',41,'delete_tag'),(171,'Can view 标签云',41,'view_tag'),(172,'Can add 文章',42,'add_post'),(173,'Can change 文章',42,'change_post'),(174,'Can delete 文章',42,'delete_post'),(175,'Can view 文章',42,'view_post'),(176,'Can add background settings',43,'add_backgroundsettings'),(177,'Can change background settings',43,'change_backgroundsettings'),(178,'Can delete background settings',43,'delete_backgroundsettings'),(179,'Can view background settings',43,'view_backgroundsettings'),(180,'Can add crontab',44,'add_crontabschedule'),(181,'Can change crontab',44,'change_crontabschedule'),(182,'Can delete crontab',44,'delete_crontabschedule'),(183,'Can view crontab',44,'view_crontabschedule'),(184,'Can add interval',45,'add_intervalschedule'),(185,'Can change interval',45,'change_intervalschedule'),(186,'Can delete interval',45,'delete_intervalschedule'),(187,'Can view interval',45,'view_intervalschedule'),(188,'Can add periodic task',46,'add_periodictask'),(189,'Can change periodic task',46,'change_periodictask'),(190,'Can delete periodic task',46,'delete_periodictask'),(191,'Can view periodic task',46,'view_periodictask'),(192,'Can add periodic tasks',47,'add_periodictasks'),(193,'Can change periodic tasks',47,'change_periodictasks'),(194,'Can delete periodic tasks',47,'delete_periodictasks'),(195,'Can view periodic tasks',47,'view_periodictasks'),(196,'Can add solar event',48,'add_solarschedule'),(197,'Can change solar event',48,'change_solarschedule'),(198,'Can delete solar event',48,'delete_solarschedule'),(199,'Can view solar event',48,'view_solarschedule'),(200,'Can add clocked',49,'add_clockedschedule'),(201,'Can change clocked',49,'change_clockedschedule'),(202,'Can delete clocked',49,'delete_clockedschedule'),(203,'Can view clocked',49,'view_clockedschedule');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$180000$UFPPmUwQyabM$kNnk0cKZmv5zryPIYleeR4Ipln/NBjxVZ7YvsLaR7JE=','2020-04-10 23:28:33.496456',1,'admin','','','',1,1,'2020-03-17 08:09:11.997050');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`) USING BTREE,
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`) USING BTREE,
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-03-17 08:13:19.847670','1','系统首页',1,'[{\"added\": {}}]',7,1),(2,'2020-03-17 08:13:30.484117','2','平台管理',1,'[{\"added\": {}}]',7,1),(3,'2020-03-17 08:14:22.500667','3','资产管理',1,'[{\"added\": {}}]',7,1),(4,'2020-03-17 08:14:37.811705','4','应用部署',1,'[{\"added\": {}}]',7,1),(5,'2020-03-17 08:14:55.021588','5','任务管理',1,'[{\"added\": {}}]',7,1),(6,'2020-03-17 08:15:09.637927','6','用户管理',1,'[{\"added\": {}}]',7,1),(7,'2020-03-17 08:15:31.568354','7','用户列表',1,'[{\"added\": {}}]',7,1),(8,'2020-03-17 08:15:40.479671','8','权限管理',1,'[{\"added\": {}}]',7,1),(9,'2020-03-17 08:15:50.774618','9','账户设置',1,'[{\"added\": {}}]',7,1),(10,'2020-03-17 08:17:41.215393','1','查看用户',1,'[{\"added\": {}}]',8,1),(11,'2020-03-17 08:18:40.564751','1','查看用户',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',8,1),(12,'2020-03-17 08:19:10.225653','2','添加用户',1,'[{\"added\": {}}]',8,1),(13,'2020-03-17 08:19:29.625222','3','删除用户',1,'[{\"added\": {}}]',8,1),(14,'2020-03-17 08:19:49.026494','4','编辑用户',1,'[{\"added\": {}}]',8,1),(15,'2020-03-17 08:20:12.369906','5','查看角色',1,'[{\"added\": {}}]',8,1),(16,'2020-03-17 08:20:31.082238','6','添加角色',1,'[{\"added\": {}}]',8,1),(17,'2020-03-17 08:21:02.225305','7','删除角色',1,'[{\"added\": {}}]',8,1),(18,'2020-03-17 08:21:23.553461','8','编辑角色',1,'[{\"added\": {}}]',8,1),(19,'2020-03-17 08:21:41.649419','3','删除用户',2,'[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]',8,1),(20,'2020-03-17 08:22:52.779833','10','角色管理',1,'[{\"added\": {}}]',7,1),(21,'2020-03-17 08:22:55.128651','9','角色管理',1,'[{\"added\": {}}]',8,1),(22,'2020-03-17 08:23:04.981792','5','查看角色',2,'[{\"changed\": {\"fields\": [\"\\u9ed8\\u8ba4\\u9009\\u4e2d\\u6743\\u9650\"]}}]',8,1),(23,'2020-03-17 08:23:09.983637','6','添加角色',2,'[{\"changed\": {\"fields\": [\"\\u9ed8\\u8ba4\\u9009\\u4e2d\\u6743\\u9650\"]}}]',8,1),(24,'2020-03-17 08:23:14.701905','8','编辑角色',2,'[{\"changed\": {\"fields\": [\"\\u9ed8\\u8ba4\\u9009\\u4e2d\\u6743\\u9650\"]}}]',8,1),(25,'2020-03-17 08:24:48.022944','1','主管',1,'[{\"added\": {}}]',9,1),(26,'2020-03-17 08:25:01.642782','2','组长A',1,'[{\"added\": {}}]',9,1),(27,'2020-03-17 08:25:17.580444','3','人事',1,'[{\"added\": {}}]',9,1),(28,'2020-03-17 08:26:35.083760','1','001',1,'[{\"added\": {}}]',10,1),(29,'2020-03-17 08:26:44.797189','2','002',1,'[{\"added\": {}}]',10,1),(30,'2020-03-17 08:26:53.189542','3','003',1,'[{\"added\": {}}]',10,1),(31,'2020-03-17 10:51:49.720128','10','admin',1,'[{\"added\": {}}]',8,1),(32,'2020-03-17 10:52:01.529080','1','主管',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]',9,1),(33,'2020-03-17 12:11:19.169038','11','查看具体用户',1,'[{\"added\": {}}]',8,1),(34,'2020-03-17 12:11:29.691025','3','人事',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]',9,1),(35,'2020-03-17 12:14:32.944577','11','查看具体用户',3,'',8,1),(36,'2020-03-17 20:32:00.819218','4','admin',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u89d2\\u8272\"]}}]',10,1),(37,'2020-03-17 20:32:11.753221','1','001',3,'',10,1),(38,'2020-03-17 20:32:16.215209','2','002',3,'',10,1),(39,'2020-03-17 20:32:24.797267','3','003',3,'',10,1),(40,'2020-03-17 20:33:26.296291','5','001',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u89d2\\u8272\"]}}]',10,1),(41,'2020-03-17 20:33:29.387269','4','admin',2,'[]',10,1),(42,'2020-03-17 20:33:32.723265','6','002',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u89d2\\u8272\"]}}]',10,1),(43,'2020-03-17 20:33:35.696261','7','003',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u89d2\\u8272\"]}}]',10,1),(44,'2020-03-17 22:11:26.619254','1','系统首页',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(45,'2020-03-17 22:11:36.531603','7','用户列表',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(46,'2020-03-17 22:12:25.236593','2','平台管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(47,'2020-03-17 22:12:28.344580','1','系统首页',2,'[]',7,1),(48,'2020-03-17 22:12:42.236623','8','权限管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(49,'2020-03-17 22:12:56.513618','6','用户管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(50,'2020-03-17 22:13:19.663568','7','用户列表',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\", \"\\u7236\\u7ea7\\u83dc\\u5355\"]}}]',7,1),(51,'2020-03-17 22:13:28.498726','8','权限管理',2,'[]',7,1),(52,'2020-03-17 22:13:48.021594','10','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\", \"\\u6392\\u5e8f\", \"\\u7236\\u7ea7\\u83dc\\u5355\"]}}]',7,1),(53,'2020-03-17 22:14:21.284650','4','应用部署',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(54,'2020-03-17 22:14:31.886388','5','任务管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(55,'2020-03-17 22:50:03.229605','3','资产管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(56,'2020-03-17 22:57:30.550588','11','权限列表',1,'[{\"added\": {}}]',7,1),(57,'2020-03-17 23:09:53.109604','1','系统首页',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(58,'2020-03-17 23:09:55.282418','1','系统首页',2,'[]',7,1),(59,'2020-03-17 23:10:00.134098','10','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(60,'2020-03-17 23:10:04.653583','10','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(61,'2020-03-17 23:10:26.023412','7','用户列表',2,'[]',7,1),(62,'2020-03-17 23:10:30.979577','1','系统首页',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(63,'2020-03-17 23:10:35.466571','10','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(64,'2020-03-17 23:16:02.438107','9','账户设置',2,'[{\"changed\": {\"fields\": [\"\\u56fe\\u6807\", \"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(65,'2020-03-17 23:21:02.677582','7','用户列表',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(66,'2020-03-17 23:21:57.934220','7','用户列表',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(67,'2020-03-17 23:59:49.855582','5','任务管理',2,'[{\"changed\": {\"fields\": [\"\\u56fe\\u6807\"]}}]',7,1),(68,'2020-03-18 00:05:19.204613','8','权限管理',2,'[{\"changed\": {\"fields\": [\"\\u56fe\\u6807\"]}}]',7,1),(69,'2020-03-18 00:05:40.769297','9','账户设置',2,'[{\"changed\": {\"fields\": [\"\\u7236\\u7ea7\\u83dc\\u5355\"]}}]',7,1),(70,'2020-03-18 00:07:05.526595','10','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u56fe\\u6807\"]}}]',7,1),(71,'2020-03-18 00:07:35.767333','10','角色列表',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',7,1),(72,'2020-03-18 00:09:39.382679','12','文件管理',1,'[{\"added\": {}}]',7,1),(73,'2020-03-18 00:10:04.239668','13','文件上传',1,'[{\"added\": {}}]',7,1),(74,'2020-03-18 00:10:32.111608','14','文件下载',1,'[{\"added\": {}}]',7,1),(75,'2020-03-18 00:10:58.214563','15','WIKI',1,'[{\"added\": {}}]',7,1),(76,'2020-03-18 00:11:22.436560','16','监控管理',1,'[{\"added\": {}}]',7,1),(77,'2020-03-18 13:31:30.671947','11','权限列表',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(78,'2020-03-18 13:48:26.181549','10','角色列表',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(79,'2020-03-18 13:53:23.283874','1','主管',2,'[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]',9,1),(80,'2020-03-18 13:53:39.638997','2','组长A',2,'[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]',9,1),(81,'2020-03-18 13:54:01.382157','3','人事',2,'[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]',9,1),(82,'2020-03-18 13:54:04.298940','4','经理',2,'[]',9,1),(83,'2020-03-19 00:05:14.851473','9','账户设置',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\", \"\\u6392\\u5e8f\"]}}]',7,1),(84,'2020-03-23 15:20:08.627511','1','蜂巢',1,'[{\"added\": {}}]',12,1),(85,'2020-03-23 15:21:27.739284','2','开发',1,'[{\"added\": {}}]',12,1),(86,'2020-03-23 15:35:10.375585','1','本地服务器',1,'[{\"added\": {}}]',11,1),(87,'2020-03-23 15:41:31.162580','1','ServerAssets object (1)',1,'[{\"added\": {}}]',13,1),(88,'2020-03-23 15:41:46.747404','1','ServerAssets object (1)',2,'[]',13,1),(89,'2020-03-23 15:43:27.403548','2','ServerAssets object (2)',1,'[{\"added\": {}}]',13,1),(90,'2020-03-23 16:29:01.623519','2','物理机',1,'[{\"added\": {}}]',11,1),(91,'2020-03-23 16:29:04.685435','1','192.168.1.11',2,'[{\"changed\": {\"fields\": [\"\\u8d44\\u4ea7\\u6807\\u7b7e\"]}}]',13,1),(92,'2020-03-23 16:29:26.794690','2','192.168.1.12',2,'[{\"changed\": {\"fields\": [\"\\u8d44\\u4ea7\\u6807\\u7b7e\"]}}]',13,1),(93,'2020-03-24 06:01:32.178371','17','主机管理',1,'[{\"added\": {}}]',7,1),(94,'2020-03-24 06:02:24.208456','18','IDC',1,'[{\"added\": {}}]',7,1),(95,'2020-03-24 06:03:18.693729','19','标签',1,'[{\"added\": {}}]',7,1),(96,'2020-03-24 06:11:26.228446','19','标签',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(97,'2020-03-24 06:51:41.264333','3','测试机',2,'[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]',11,1),(98,'2020-03-24 08:34:35.319628','18','IDC机房',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',7,1),(99,'2020-03-24 08:34:49.753806','19','标签管理',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',7,1),(100,'2020-03-24 08:40:21.484443','20','远程管理',1,'[{\"added\": {}}]',7,1),(101,'2020-03-24 13:40:10.774338','4','127.0.0.1',2,'[{\"changed\": {\"fields\": [\"IDC\"]}}]',13,1),(102,'2020-03-24 13:50:51.526675','5','192.168.1.13',1,'[{\"added\": {}}]',13,1),(103,'2020-04-01 00:14:09.119631','13','文件上传',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(104,'2020-04-01 15:20:49.707903','12','文件管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(105,'2020-04-01 15:20:56.628258','14','文件下载',3,'',7,1),(106,'2020-04-01 15:21:00.194920','13','文件上传',3,'',7,1),(107,'2020-04-03 20:46:53.598537','15','WIKI',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(108,'2020-04-03 20:47:23.864444','21','话题',1,'[{\"added\": {}}]',7,1),(109,'2020-04-03 20:48:13.723129','22','管理',1,'[{\"added\": {}}]',7,1),(110,'2020-04-03 20:48:38.147143','22','添加wiki文章',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',7,1),(111,'2020-04-03 20:48:53.255139','22','添加wiki文章',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(112,'2020-04-03 20:49:12.773700','22','添加wiki文章',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(113,'2020-04-03 20:52:27.480383','22','添加wiki文章',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(114,'2020-04-03 20:54:16.958655','22','添加wiki文章',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(115,'2020-04-03 21:20:16.754447','23','系统设置',1,'[{\"added\": {}}]',7,1),(116,'2020-04-04 01:25:39.955711','1','主管',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]',9,1),(117,'2020-04-04 01:33:13.363624','1','查看用户',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(118,'2020-04-04 01:33:19.542012','2','添加用户',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(119,'2020-04-04 01:33:26.614575','3','删除用户',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(120,'2020-04-04 01:33:32.424198','4','编辑用户',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(121,'2020-04-04 01:33:36.991305','5','查看角色',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(122,'2020-04-04 01:33:41.940911','7','删除角色',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(123,'2020-04-04 01:33:47.724526','8','编辑角色',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(124,'2020-04-04 01:34:01.101544','9','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(125,'2020-04-04 01:34:09.546928','10','admin',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(126,'2020-04-04 01:34:24.987566','9','角色管理',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(127,'2020-04-04 01:34:30.599609','10','admin',2,'[{\"changed\": {\"fields\": [\"\\u52a8\\u4f5c\"]}}]',8,1),(128,'2020-04-04 01:34:34.438426','10','admin',2,'[]',8,1),(129,'2020-04-04 01:34:37.369351','9','角色管理',2,'[]',8,1),(130,'2020-04-04 01:34:40.255082','8','编辑角色',2,'[]',8,1),(131,'2020-04-04 01:34:42.676798','7','删除角色',2,'[]',8,1),(132,'2020-04-04 01:34:45.362498','1','查看用户',2,'[]',8,1),(133,'2020-04-04 01:43:43.956611','1','主管',2,'[]',9,1),(134,'2020-04-04 01:43:53.417692','4','admin',2,'[]',10,1),(135,'2020-04-04 01:45:38.537951','4','admin',2,'[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u89d2\\u8272\"]}}]',10,1),(136,'2020-04-06 16:31:42.261441','24','节点管理',1,'[{\"added\": {}}]',7,1),(137,'2020-04-06 16:32:30.619361','25','kubernetes管理',1,'[{\"added\": {}}]',7,1),(138,'2020-04-06 16:32:38.508275','24','节点管理',2,'[{\"changed\": {\"fields\": [\"\\u6392\\u5e8f\"]}}]',7,1),(139,'2020-04-06 16:33:07.316679','25','kubernetes管理',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(140,'2020-04-06 16:37:53.838870','24','节点管理',3,'',7,1),(141,'2020-04-11 00:22:36.140271','1','2020-04-11 00:22:00 True',1,'[{\"added\": {}}]',49,1),(142,'2020-04-11 00:28:20.921868','1','every 2 minutes',1,'[{\"added\": {}}]',45,1),(143,'2020-04-11 00:30:02.894128','2','测试: every 2 minutes',1,'[{\"added\": {}}]',46,1),(144,'2020-04-10 16:46:50.050010','26','任务列表',1,'[{\"added\": {}}]',7,1),(145,'2020-04-10 16:47:26.481423','27','定时管理',1,'[{\"added\": {}}]',7,1),(146,'2020-04-11 09:29:06.178181','3','蜂巢: every 2 minutes',1,'[{\"added\": {}}]',46,1),(147,'2020-04-11 09:52:51.662246','27','Crontab',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\", \"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',7,1),(148,'2020-04-11 09:55:34.693184','28','时间间隔',1,'[{\"added\": {}}]',7,1),(149,'2020-04-11 09:56:12.023643','29','关闭时间',1,'[{\"added\": {}}]',7,1),(150,'2020-04-11 09:56:35.347502','28','时间间隔',2,'[{\"changed\": {\"fields\": [\"\\u7236\\u7ea7\\u83dc\\u5355\"]}}]',7,1),(151,'2020-04-11 09:58:05.100652','29','计时',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_clockedschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_clockedschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_beat_clockedschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clocked_time` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_clockedschedule`
--

LOCK TABLES `django_celery_beat_clockedschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_clockedschedule` DISABLE KEYS */;
INSERT INTO `django_celery_beat_clockedschedule` VALUES (1,'2020-04-11 00:22:00.000000',1),(2,'2020-04-09 16:00:00.000000',1);
/*!40000 ALTER TABLE `django_celery_beat_clockedschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_crontabschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_crontabschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_beat_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(240) NOT NULL,
  `hour` varchar(96) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(124) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  `timezone` varchar(63) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_crontabschedule`
--

LOCK TABLES `django_celery_beat_crontabschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_crontabschedule` DISABLE KEYS */;
INSERT INTO `django_celery_beat_crontabschedule` VALUES (1,'0','4','*','*','*','UTC'),(2,'2','*','*','*','*','UTC'),(3,'0','4','*','*','*','Asia/Shanghai');
/*!40000 ALTER TABLE `django_celery_beat_crontabschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_intervalschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_intervalschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_beat_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_intervalschedule`
--

LOCK TABLES `django_celery_beat_intervalschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_intervalschedule` DISABLE KEYS */;
INSERT INTO `django_celery_beat_intervalschedule` VALUES (1,2,'hours'),(2,1,'minutes');
/*!40000 ALTER TABLE `django_celery_beat_intervalschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_periodictask`
--

DROP TABLE IF EXISTS `django_celery_beat_periodictask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_beat_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `solar_id` int(11) DEFAULT NULL,
  `one_off` tinyint(1) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `priority` int(10) unsigned DEFAULT NULL,
  `headers` longtext NOT NULL,
  `clocked_id` int(11) DEFAULT NULL,
  `expire_seconds` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` (`crontab_id`),
  KEY `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` (`interval_id`),
  KEY `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` (`solar_id`),
  KEY `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` (`clocked_id`),
  CONSTRAINT `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` FOREIGN KEY (`clocked_id`) REFERENCES `django_celery_beat_clockedschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_periodictask`
--

LOCK TABLES `django_celery_beat_periodictask` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_periodictask` DISABLE KEYS */;
INSERT INTO `django_celery_beat_periodictask` VALUES (1,'celery.backend_cleanup','celery.backend_cleanup','[]','{}',NULL,NULL,NULL,NULL,1,NULL,0,'2020-04-11 14:55:21.493109','',3,NULL,NULL,0,NULL,NULL,'{}',NULL,43200),(3,'蜂巢','apps.tasks.tasks.add','[21,21]','{}',NULL,NULL,NULL,NULL,0,NULL,0,'2020-04-11 12:42:32.384493','',NULL,1,NULL,0,'2020-04-11 09:28:00.000000',NULL,'{}',NULL,NULL),(4,'测试','apps.tasks.tasks.add','[100,100]','{}',NULL,NULL,NULL,NULL,0,NULL,93,'2020-04-11 15:10:52.609360','',NULL,2,NULL,0,NULL,1,'{}',NULL,1);
/*!40000 ALTER TABLE `django_celery_beat_periodictask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_periodictasks`
--

DROP TABLE IF EXISTS `django_celery_beat_periodictasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_periodictasks`
--

LOCK TABLES `django_celery_beat_periodictasks` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_periodictasks` DISABLE KEYS */;
INSERT INTO `django_celery_beat_periodictasks` VALUES (1,'2020-04-11 15:10:52.594829');
/*!40000 ALTER TABLE `django_celery_beat_periodictasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_solarschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_solarschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_beat_solarschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(24) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq` (`event`,`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_solarschedule`
--

LOCK TABLES `django_celery_beat_solarschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_solarschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_solarschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(12,'assets','idc'),(13,'assets','serverassets'),(11,'assets','tags'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(49,'django_celery_beat','clockedschedule'),(44,'django_celery_beat','crontabschedule'),(45,'django_celery_beat','intervalschedule'),(46,'django_celery_beat','periodictask'),(47,'django_celery_beat','periodictasks'),(48,'django_celery_beat','solarschedule'),(18,'django_nyt','notification'),(16,'django_nyt','notificationtype'),(17,'django_nyt','settings'),(19,'django_nyt','subscription'),(14,'file','filemodel'),(7,'rbac','menu'),(8,'rbac','permissions'),(9,'rbac','role'),(10,'rbac','userprofile'),(6,'sessions','session'),(43,'settings','backgroundsettings'),(39,'wiki','category'),(40,'wiki','comment'),(42,'wiki','post'),(41,'wiki','tag');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-03-17 08:06:44.795915'),(2,'auth','0001_initial','2020-03-17 08:06:45.005930'),(3,'admin','0001_initial','2020-03-17 08:06:45.663982'),(4,'admin','0002_logentry_remove_auto_add','2020-03-17 08:06:45.805991'),(5,'admin','0003_logentry_add_action_flag_choices','2020-03-17 08:06:45.818993'),(6,'contenttypes','0002_remove_content_type_name','2020-03-17 08:06:45.953002'),(7,'auth','0002_alter_permission_name_max_length','2020-03-17 08:06:46.029008'),(8,'auth','0003_alter_user_email_max_length','2020-03-17 08:06:46.073012'),(9,'auth','0004_alter_user_username_opts','2020-03-17 08:06:46.089013'),(10,'auth','0005_alter_user_last_login_null','2020-03-17 08:06:46.158019'),(11,'auth','0006_require_contenttypes_0002','2020-03-17 08:06:46.163019'),(12,'auth','0007_alter_validators_add_error_messages','2020-03-17 08:06:46.177020'),(13,'auth','0008_alter_user_username_max_length','2020-03-17 08:06:46.324031'),(14,'auth','0009_alter_user_last_name_max_length','2020-03-17 08:06:46.415039'),(15,'auth','0010_alter_group_name_max_length','2020-03-17 08:06:46.446039'),(16,'auth','0011_update_proxy_permissions','2020-03-17 08:06:46.460042'),(17,'rbac','0001_initial','2020-03-17 08:06:46.655055'),(18,'sessions','0001_initial','2020-03-17 08:06:47.187095'),(19,'rbac','0002_auto_20200317_1626','2020-03-17 08:26:22.537749'),(20,'rbac','0003_userprofile_active','2020-03-17 08:38:42.853443'),(21,'rbac','0004_auto_20200317_1650','2020-03-17 08:51:02.335406'),(22,'rbac','0005_auto_20200317_2024','2020-03-17 12:24:55.474634'),(23,'rbac','0002_auto_20200317_2159','2020-03-17 21:59:36.293487'),(24,'rbac','0003_auto_20200317_2210','2020-03-17 22:10:45.810287'),(25,'rbac','0004_auto_20200318_2023','2020-03-18 20:24:04.513244'),(26,'assets','0001_initial','2020-03-23 15:19:22.229800'),(27,'assets','0002_auto_20200324_0849','2020-03-24 08:49:32.162202'),(28,'rbac','0002_auto_20200324_0849','2020-03-24 08:49:32.185758'),(29,'assets','0003_auto_20200324_0852','2020-03-24 08:52:59.788766'),(30,'file','0001_initial','2020-03-31 23:53:14.761848'),(50,'file','0002_delete_filemodel','2020-04-03 01:30:54.323389'),(51,'wiki','0001_initial','2020-04-03 02:22:33.548060'),(52,'wiki','0002_auto_20200403_0223','2020-04-03 02:23:17.681247'),(53,'wiki','0003_auto_20200403_0240','2020-04-03 02:40:40.129173'),(54,'wiki','0004_auto_20200403_0243','2020-04-03 02:43:18.160884'),(55,'settings','0001_initial','2020-04-03 22:35:53.466028'),(56,'wiki','0005_auto_20200403_2235','2020-04-03 22:35:53.602960'),(57,'settings','0002_auto_20200403_2242','2020-04-03 22:42:40.882137'),(58,'settings','0003_backgroundsettings_code','2020-04-03 22:43:53.942078'),(59,'django_celery_beat','0001_initial','2020-04-10 18:29:26.967309'),(60,'django_celery_beat','0002_auto_20161118_0346','2020-04-10 18:29:27.105899'),(61,'django_celery_beat','0003_auto_20161209_0049','2020-04-10 18:29:27.133070'),(62,'django_celery_beat','0004_auto_20170221_0000','2020-04-10 18:29:27.146018'),(63,'django_celery_beat','0005_add_solarschedule_events_choices','2020-04-10 18:29:27.154395'),(64,'django_celery_beat','0006_auto_20180322_0932','2020-04-10 18:29:27.289028'),(65,'django_celery_beat','0007_auto_20180521_0826','2020-04-10 18:29:27.373705'),(66,'django_celery_beat','0008_auto_20180914_1922','2020-04-10 18:29:27.403430'),(67,'django_celery_beat','0006_auto_20180210_1226','2020-04-10 18:29:27.417188'),(68,'django_celery_beat','0006_periodictask_priority','2020-04-10 18:29:27.454042'),(69,'django_celery_beat','0009_periodictask_headers','2020-04-10 18:29:27.496164'),(70,'django_celery_beat','0010_auto_20190429_0326','2020-04-10 18:29:27.776379'),(71,'django_celery_beat','0011_auto_20190508_0153','2020-04-10 18:29:27.857623'),(72,'django_celery_beat','0012_periodictask_expire_seconds','2020-04-10 18:29:27.902710');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  KEY `django_session_expire_date_a5c62663` (`expire_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0lcup0ylsvk6838z8h0nbfuhwml0623q','MTEzODFhMmQ2YzdjNjg2MDQyYjQ4ODE3Y2IzNmY2OTU2YzIzZjhkOTp7ImxvZ2luX3JlZmVyZXIiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvd2lraS9taXNzaW5nLXJvb3QvIiwidGVzdGNvb2tpZSI6IndvcmtlZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIn0=','2020-04-17 00:39:22.016183'),('6tv69pdv2a59y55yceyfjsf9gzykjl8w','ZDQ5MmQ5NTA2NjA5YmIxNDI1YWZlZjY5OTc3ODk0MmU2ZThjM2MxMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNDJhMWQzYWU0NGRkNzcwNGYwMTkyZGJiMjQ0ODRjODBhNDAwNWU1In0=','2020-03-31 08:47:43.221200'),('7hk8xlzlm2p72m5hph5wycyx4lnek8eh','ODllNjIzYmJkYWZhMWJkNDgwMjRmNzhkNzYzOGZkZWMzNDUzYTZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIn0=','2020-04-17 01:52:13.066241'),('7kcn46ywegaufrhm7u99q5jkwoqqsxt6','MTEzODFhMmQ2YzdjNjg2MDQyYjQ4ODE3Y2IzNmY2OTU2YzIzZjhkOTp7ImxvZ2luX3JlZmVyZXIiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvd2lraS9taXNzaW5nLXJvb3QvIiwidGVzdGNvb2tpZSI6IndvcmtlZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIn0=','2020-04-17 00:30:46.135786'),('ahaj84e9r6alrkgbrsnfyhmfjvu64c4j','ODllNjIzYmJkYWZhMWJkNDgwMjRmNzhkNzYzOGZkZWMzNDUzYTZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIn0=','2020-03-31 20:30:59.906065'),('b6t544gsp409t42cv2ynh0egmmepwjdf','ZDQ5MmQ5NTA2NjA5YmIxNDI1YWZlZjY5OTc3ODk0MmU2ZThjM2MxMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNDJhMWQzYWU0NGRkNzcwNGYwMTkyZGJiMjQ0ODRjODBhNDAwNWU1In0=','2020-03-31 08:11:01.713312'),('cig55n42z2kwof3gwswebkq8hifx486a','ODllNjIzYmJkYWZhMWJkNDgwMjRmNzhkNzYzOGZkZWMzNDUzYTZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIn0=','2020-04-15 00:13:54.221038'),('d9u335dxj3zcatmfyoulkntlzoavlcx5','ODJkNjJkZTZlMzVhZWRiMDYwYThlYTI0ZjAzNjA1ZWQxYTg0OGQ4ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIiwic2ltcGxldWlfMjAyMDA0MDYiOnRydWV9','2020-04-20 00:40:29.344872'),('dxiwckc984hrwyu8uhswywk58yi0pxpl','Y2ZiMTA4ZmMyMGYwOGJkZTEwMGI4ZTE3ZTFhNTllNDc2MzU0ZjRkNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIiwic2ltcGxldWlfMjAyMDA0MTAiOnRydWV9','2020-04-24 18:36:23.983744'),('gkyi3mqmiytyvjthcgtuqi720w9rvwxq','ODllNjIzYmJkYWZhMWJkNDgwMjRmNzhkNzYzOGZkZWMzNDUzYTZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIn0=','2020-04-06 15:19:59.040502'),('kywbfwbjxz0xlzr1zq67ogdsn02pmngl','OGM3NTAyMDliNzUwZWY2ZWJkYjNkNTE3ZTA0MzgxZTk0MGI1ZjBhNzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIiwic2ltcGxldWlfMjAyMDA0MDUiOnRydWUsInNpbXBsZXVpXzIwMjAwNDA2Ijp0cnVlfQ==','2020-04-20 00:19:07.948038'),('zy6wmaiy3kljq68phgkprgxecgq9e418','ZDcxZjhlMDM4Y2FiNzA4ZjA1OTE1ZmQ3YzQ0NmY2NWQ0Yjk1NmNiZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWQ4NWUxNDgwNDhhYmI1NTQwNzgwMjVjOTY0OGU4ZjQwMzlmNTYyIiwic2ltcGxldWlfMjAyMDA0MTAiOnRydWUsInNpbXBsZXVpXzIwMjAwNDExIjp0cnVlfQ==','2020-04-25 00:19:42.107114');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_menu`
--

DROP TABLE IF EXISTS `rbac_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `sort` int(11) NOT NULL,
  `path` varchar(100) NOT NULL,
  `pid_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rbac_menu_pid_id_a43b3c84_fk_rbac_menu_id` (`pid_id`),
  CONSTRAINT `rbac_menu_pid_id_a43b3c84_fk_rbac_menu_id` FOREIGN KEY (`pid_id`) REFERENCES `rbac_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_menu`
--

LOCK TABLES `rbac_menu` WRITE;
/*!40000 ALTER TABLE `rbac_menu` DISABLE KEYS */;
INSERT INTO `rbac_menu` VALUES (1,'系统首页','el-icon-s-home',0,'/home',NULL),(2,'平台管理','el-icon-setting',1,'/platform',NULL),(3,'资产管理','el-icon-goods',2,'/assets',NULL),(4,'应用部署','el-icon-bangzhu',3,'/deploy',NULL),(5,'任务管理','el-icon-time',4,'/task',NULL),(6,'用户管理','el-icon-user',5,'/users/',NULL),(7,'用户列表','el-icon-menu',1,'/users',6),(8,'权限管理','el-icon-office-building',2,'/rights',NULL),(9,'账户设置','el-icon-menu',2,'/user',6),(10,'角色列表','el-icon-menu',1,'/roles',8),(11,'权限列表','el-icon-menu',2,'/rights',8),(12,'文件管理','el-icon-folder',6,'/files',NULL),(15,'WIKI','el-icon-chat-line-square',7,'',NULL),(16,'监控管理','el-icon-monitor',8,'/monitor',NULL),(17,'主机管理','el-icon-menu',1,'/server',3),(18,'IDC机房','el-icon-menu',2,'/idc',3),(19,'标签管理','el-icon-menu',3,'/tags',3),(20,'远程管理','el-icon-menu',2,'/webssh',3),(21,'话题','el-icon-menu',1,'/wiki',15),(22,'添加wiki文章','el-icon-menu',2,'/wiki/add',15),(23,'系统设置','el-icon-menu',0,'/settings',2),(25,'kubernetes管理','el-icon-menu',2,'/Kubernetes',2),(26,'任务列表','el-icon-menu',1,'/tasks',5),(27,'Crontab','el-icon-menu',2,'/crontab',5),(28,'时间间隔','el-icon-menu',3,'/intervals',5),(29,'计时','el-icon-menu',5,'/clocked',5);
/*!40000 ALTER TABLE `rbac_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_permissions`
--

DROP TABLE IF EXISTS `rbac_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `path` varchar(128) NOT NULL,
  `action` varchar(16) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_permissions`
--

LOCK TABLES `rbac_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_permissions` DISABLE KEYS */;
INSERT INTO `rbac_permissions` VALUES (1,'查看用户','/users/','GET'),(2,'添加用户','/users/','POST'),(3,'删除用户','/users/(\\d+)/','DELETE'),(4,'编辑用户','/users/','PUT'),(5,'查看角色','/roles/','GET'),(7,'删除角色','/roles/(\\d+)/','DELETE'),(8,'编辑角色','/roles/(\\d+)/','PUT'),(9,'角色管理','/roles/','GET'),(10,'admin','.*','GET');
/*!40000 ALTER TABLE `rbac_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_role`
--

DROP TABLE IF EXISTS `rbac_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role`
--

LOCK TABLES `rbac_role` WRITE;
/*!40000 ALTER TABLE `rbac_role` DISABLE KEYS */;
INSERT INTO `rbac_role` VALUES (1,'主管','运维部副主管1'),(2,'组长A','运维部组长'),(3,'人事','人事经理'),(4,'经理','副经理'),(8,'测试人员','A组测试人员');
/*!40000 ALTER TABLE `rbac_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_role_permissions`
--

DROP TABLE IF EXISTS `rbac_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permissions_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `rbac_role_permissions_role_id_permission_id_d01303da_uniq` (`role_id`,`permissions_id`) USING BTREE,
  KEY `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` (`permissions_id`) USING BTREE,
  CONSTRAINT `rbac_role_permission_permissions_id_e81352e3_fk_rbac_perm` FOREIGN KEY (`permissions_id`) REFERENCES `rbac_permissions` (`id`),
  CONSTRAINT `rbac_role_permissions_role_id_d10416cb_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role_permissions`
--

LOCK TABLES `rbac_role_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_role_permissions` DISABLE KEYS */;
INSERT INTO `rbac_role_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(7,1,7),(8,1,8),(9,1,9),(120,1,10),(20,2,2),(21,2,3),(101,3,2),(103,4,1),(104,4,2),(118,4,3),(119,4,4),(113,8,2),(114,8,3),(115,8,4),(116,8,5),(117,8,7);
/*!40000 ALTER TABLE `rbac_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_userprofile`
--

DROP TABLE IF EXISTS `rbac_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(32) NOT NULL,
  `mobile` varchar(32) NOT NULL,
  `c_time` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `rbac_userprofile_username_d0c01eff_uniq` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_userprofile`
--

LOCK TABLES `rbac_userprofile` WRITE;
/*!40000 ALTER TABLE `rbac_userprofile` DISABLE KEYS */;
INSERT INTO `rbac_userprofile` VALUES (4,'admin','pbkdf2_sha256$180000$xfYkb2k6qkeG$WEUliPGuWB09Ompj8onCzR4zGC6tMYAzntbd7rx23K8=','13829072355@qq.com','13829072374','2020-03-17 12:25:01.184180',1),(9,'root','pbkdf2_sha256$180000$5WQPNvVF0N2w$0VpoV9KQq3OjdO6k0iiWSkZ1D0OxRqfHfL1vmjSCsLE=','eee@qq.com','13742586745','2020-03-18 00:25:43.790266',0),(10,'CEO','pbkdf2_sha256$180000$eW6FgWRcokn7$3pxbca0cGBbzi5P4M7KMTKNYY4KJX60cStNL97QBqcE=','CEO@QQ.COM','13828832467','2020-03-18 19:25:53.532038',1),(11,'001','pbkdf2_sha256$180000$knuF7TNieI4J$f38z4cTzjdlq4Di9niT3PPQy1FTQTZ6+Uq+pqHRc7gw=','001@qq.com','13834587690','2020-03-18 20:00:41.843961',0),(12,'002','pbkdf2_sha256$180000$ADHiFdLeczwv$9Lf1BzDU7n8rwvCRTmn41zf01xg+UGYudb6QR3oXcGk=','002@qq.com','13834843848','2020-03-18 23:07:23.362929',1),(13,'003','pbkdf2_sha256$180000$fK2arLpEqJyv$WWUtlZAp+ZWKiXpliuL40jy2zGHB0I7c6ICkKhrXIlA=','003@qq.com','13237364758','2020-03-18 23:57:23.747078',1);
/*!40000 ALTER TABLE `rbac_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_userprofile_roles`
--

DROP TABLE IF EXISTS `rbac_userprofile_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_userprofile_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `rbac_userprofile_roles_userprofile_id_role_id_ba9254c5_uniq` (`userprofile_id`,`role_id`) USING BTREE,
  KEY `rbac_userprofile_roles_role_id_ddc12d7e_fk_rbac_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `rbac_userprofile_rol_userprofile_id_3a7afbe9_fk_rbac_user` FOREIGN KEY (`userprofile_id`) REFERENCES `rbac_userprofile` (`id`),
  CONSTRAINT `rbac_userprofile_roles_role_id_ddc12d7e_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_userprofile_roles`
--

LOCK TABLES `rbac_userprofile_roles` WRITE;
/*!40000 ALTER TABLE `rbac_userprofile_roles` DISABLE KEYS */;
INSERT INTO `rbac_userprofile_roles` VALUES (46,4,1),(58,4,2),(59,4,3),(60,4,4),(57,4,8),(54,9,3),(47,10,2),(52,11,4),(56,12,2),(51,13,8);
/*!40000 ALTER TABLE `rbac_userprofile_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_backgroundsettings`
--

DROP TABLE IF EXISTS `settings_backgroundsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_backgroundsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `code` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_backgroundsettings`
--

LOCK TABLES `settings_backgroundsettings` WRITE;
/*!40000 ALTER TABLE `settings_backgroundsettings` DISABLE KEYS */;
INSERT INTO `settings_backgroundsettings` VALUES (1,'rgba(225, 234, 234, 1)','顶部导航栏',1),(2,'rgba(0, 45, 78, 1)','侧边菜单栏',2),(3,'rgba(255, 255, 255, 1)','平台主体',3);
/*!40000 ALTER TABLE `settings_backgroundsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_category`
--

DROP TABLE IF EXISTS `wiki_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_category`
--

LOCK TABLES `wiki_category` WRITE;
/*!40000 ALTER TABLE `wiki_category` DISABLE KEYS */;
INSERT INTO `wiki_category` VALUES (1,'物联平台组'),(2,'蜂巢');
/*!40000 ALTER TABLE `wiki_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_comment`
--

DROP TABLE IF EXISTS `wiki_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_comment` (
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `c_time` datetime(6) NOT NULL,
  `parent_id_id` bigint(20) DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `comment_parent_id_id_47868c13_fk_comment_nid` (`parent_id_id`),
  KEY `comment_post_id_d299ca5f_fk_post_id` (`post_id`),
  KEY `comment_user_id_2224f9d1_fk_rbac_userprofile_id` (`user_id`),
  CONSTRAINT `comment_parent_id_id_47868c13_fk_comment_nid` FOREIGN KEY (`parent_id_id`) REFERENCES `wiki_comment` (`nid`),
  CONSTRAINT `comment_post_id_d299ca5f_fk_post_id` FOREIGN KEY (`post_id`) REFERENCES `wiki_post` (`id`),
  CONSTRAINT `comment_user_id_2224f9d1_fk_rbac_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `rbac_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_comment`
--

LOCK TABLES `wiki_comment` WRITE;
/*!40000 ALTER TABLE `wiki_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_post`
--

DROP TABLE IF EXISTS `wiki_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `body` longtext NOT NULL,
  `excerpt` varchar(200) NOT NULL,
  `views` int(10) unsigned NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `c_time` datetime(6) NOT NULL,
  `u_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `post_author_id_2343ddae_fk_rbac_userprofile_id` (`author_id`),
  KEY `wiki_post_category_id_680167b5_fk_wiki_category_id` (`category_id`),
  CONSTRAINT `post_author_id_2343ddae_fk_rbac_userprofile_id` FOREIGN KEY (`author_id`) REFERENCES `rbac_userprofile` (`id`),
  CONSTRAINT `wiki_post_category_id_680167b5_fk_wiki_category_id` FOREIGN KEY (`category_id`) REFERENCES `wiki_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_post`
--

LOCK TABLES `wiki_post` WRITE;
/*!40000 ALTER TABLE `wiki_post` DISABLE KEYS */;
INSERT INTO `wiki_post` VALUES (2,'6月份英语四六级考试取消不实','教育部辟谣：6月份英语四六级考试取消不实 @人民日报：【教育部辟谣：6月份英语四六级考试取消不实】针对近日“原6月份大学英语四六级考试取消，与下半年考试合并”的传言，记者3日从教育部考试中心证实，教育部考试中心已于2月底发布公告，推迟全国范围内2020年上半年全国大学英语四六级考试（CET）、全国大学英语四六级口语考试（CET-SET）、全国外语水平考试（WSK）、书画等级考试（CCPT）网上报名工作，并未发布取消考试的通知。（新华社）','教育部辟谣：6月份英语四六级考试取消不实',0,4,1,'2020-04-03 12:49:08.730149','2020-04-03 12:49:08.730187'),(4,'v-if vs v-show','v-if 是“真正”的条件渲染，因为它会确保在切换过程中条件块内的事件监听器和子组件适当地被销毁和重建。\n\nv-if 也是惰性的：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。\n\n相比之下，v-show 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基于 CSS 进行切换。\n\n一般来说，v-if 有更高的切换开销，而 v-show 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 v-show 较好；如果在运行时条件很少改变，则使用 v-if 较好。<p><br></p>','v-if 是“真正”的条件渲染，因为它会确保在切换过程中条件块内的事件监听器和子组件适当地被销毁和重建。\n\nv-if 也是惰性的：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。\n\n相比之下，v-show 就简单得多——不管初始条件是什么，元素总是会被渲染，并且...',0,4,2,'2020-04-03 17:33:54.283572','2020-04-03 20:32:16.646179'),(5,'v-if 也是惰性的','销毁和重建。&nbsp;\n<h2>v-if 也是惰性的：如果在初始渲染时条件为假，</h2><div>则什么也不做——直到条件第一<span style=\"font-family: 微软雅黑;\">次变为真时，才会开始</span>渲染条件块。\n\n相比<span style=\"color: rgb(139, 170, 74);\">之下，v-show 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基</span>于 CSS 进行切换。</div><div>&nbsp;一般来说，v-if 有更高的切换开销，而 v-show 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 v-show 较好；如果在运行时条件很少改变，则反反复复<pre><code>created() {<br>      this.postId = this.$route.params.id;<br>      this.getPostDetail(this.postId);<br>    },</code></pre><p><br></p></div>','销毁和重建。v-if 也是惰性的：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。相比之下，v-show 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基于 CSS 进行切换。一般来说，v-if 有更高的切换开销，而',0,4,1,'2020-04-03 17:35:49.855026','2020-04-03 20:42:58.188383'),(7,'javascript获取当前时间','<p style=\"word-spacing: 0.05em; line-height: 1.6em; margin-top: 1.2em; margin-bottom: -1.2em; padding-bottom: 1.2em; position: relative; z-index: 1; color: rgb(48, 68, 85); font-family: &quot;Source Sans Pro&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px; background-color: rgb(255, 255, 255);\">模板内的表达式非常便利，但是设计它们的初衷是用于简单运算的。在模板中放入太多的逻辑会让模板过重且难以维护。例如：</p><pre style=\"border-radius: 2px; position: relative; font-family: &quot;Roboto Mono&quot;, Monaco, courier, monospace; font-size: 0.85em; background-color: rgb(248, 248, 248); -webkit-font-smoothing: initial; color: rgb(48, 68, 85);\"><code style=\"font-family: &quot;Roboto Mono&quot;, Monaco, courier, monospace; font-size: 0.85rem; background-color: rgb(248, 248, 248); -webkit-font-smoothing: initial; color: rgb(82, 82, 82); padding: 1.2em 1.4em; margin-right: 2px; margin-left: 2px; border-radius: 2px; overflow-x: auto; line-height: 1.6rem;\"><span style=\"color: rgb(41, 115, 183);\">&lt;div id=<span style=\"color: rgb(66, 185, 131);\">\"example\"</span>&gt;</span>\n  {{ message.split(\'\').reverse().join(\'\') }}\n<span style=\"color: rgb(41, 115, 183);\">&lt;/div&gt;</span></code></pre><p style=\"word-spacing: 0.05em; line-height: 1.6em; margin-top: 1.2em; margin-bottom: -1.2em; padding-bottom: 1.2em; position: relative; z-index: 1; color: rgb(48, 68, 85); font-family: &quot;Source Sans Pro&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px; background-color: rgb(255, 255, 255);\">在这个地方，模板不再是简单的声明式逻辑。你必须看一段时间才能意识到，这里是想要显示变量&nbsp;<code style=\"font-family: &quot;Roboto Mono&quot;, Monaco, courier, monospace; font-size: 0.85em; background-color: rgb(248, 248, 248); -webkit-font-smoothing: initial; color: rgb(214, 50, 0); margin-right: 2px; margin-left: 2px; border-radius: 2px; white-space: nowrap;\">message</code>&nbsp;的翻转字符串。当你想要在模板中多次引用此处的翻转字符串时，就会更加难以处理。</p><p style=\"word-spacing: 0.05em; line-height: 1.6em; margin-top: 1.2em; margin-bottom: -1.2em; padding-bottom: 1.2em; position: relative; z-index: 1; color: rgb(48, 68, 85); font-family: &quot;Source Sans Pro&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px; background-color: rgb(255, 255, 255);\">所以，对于任何复杂逻辑，你都应当使用<span style=\"font-weight: 600; color: rgb(39, 56, 73);\">计算属性</span>。</p>','<p style=\"word-spacing: 0.05em; line-height: 1.6em; margin-top: 1.2em; margin-bottom: -1.2em; padding-bottom: 1.2em; position: relative; z-index: 1; c...',0,4,2,'2020-04-03 21:04:36.460459','2020-04-03 21:04:50.294935'),(8,'分栏间隔','<pre><code>\n&lt;el-row :gutter=\"20\"&gt;<br>  &lt;el-col :span=\"6\"&gt;&lt;div class=\"grid-content bg-purple\"&gt;&lt;/div&gt;&lt;/el-col&gt;<br>  &lt;el-col :span=\"6\"&gt;&lt;div class=\"grid-content bg-purple\"&gt;&lt;/div&gt;&lt;/el-col&gt;<br>  &lt;el-col :span=\"6\"&gt;&lt;div class=\"grid-content bg-purple\"&gt;&lt;/div&gt;&lt;/el-col&gt;<br>  &lt;el-col :span=\"6\"&gt;&lt;div class=\"grid-content bg-purple\"&gt;&lt;/div&gt;&lt;/el-col&gt;<br>&lt;/el-row&gt;<br><br>&lt;style&gt;<br>  .el-row {<br>    margin-bottom: 20px;<br>    &amp;:last-child {<br>      margin-bottom: 0;<br>    }<br>  }<br>  .el-col {<br>    border-radius: 4px;<br>  }<br>  .bg-purple-dark {<br>    background: #99a9bf;<br>  }<br>  .bg-purple {<br>    background: #d3dce6;<br>  }<br>  .bg-purple-light {<br>    background: #e5e9f2;<br>  }<br>  .grid-content {<br>    border-radius: 4px;<br>    min-height: 36px;<br>  }<br>  .row-bg {<br>    padding: 10px 0;<br>    background-color: #f9fafc;<br>  }<br>&lt;/style&gt;</code></pre><p><br></p>','<pre><code>\n&lt;el-row :gutter=\"20\"&gt;<br>  &lt;el-col :span=\"6\"&gt;&lt;div class=\"grid-content bg-purple\"&gt;&lt;/div&gt;&lt;/el-col&gt;<br>  &lt;el...',0,4,1,'2020-04-03 21:09:21.881761','2020-04-03 21:09:21.881793');
/*!40000 ALTER TABLE `wiki_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_post_tags`
--

DROP TABLE IF EXISTS `wiki_post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_post_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_tags_post_id_tag_id_e786772a_uniq` (`post_id`,`tag_id`),
  KEY `post_tags_tag_id_eb42e8a6_fk_tag_id` (`tag_id`),
  CONSTRAINT `post_tags_post_id_2b0ee768_fk_post_id` FOREIGN KEY (`post_id`) REFERENCES `wiki_post` (`id`),
  CONSTRAINT `post_tags_tag_id_eb42e8a6_fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `wiki_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_post_tags`
--

LOCK TABLES `wiki_post_tags` WRITE;
/*!40000 ALTER TABLE `wiki_post_tags` DISABLE KEYS */;
INSERT INTO `wiki_post_tags` VALUES (2,2,1);
/*!40000 ALTER TABLE `wiki_post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_tag`
--

DROP TABLE IF EXISTS `wiki_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_tag`
--

LOCK TABLES `wiki_tag` WRITE;
/*!40000 ALTER TABLE `wiki_tag` DISABLE KEYS */;
INSERT INTO `wiki_tag` VALUES (2,'Linux'),(1,'平台');
/*!40000 ALTER TABLE `wiki_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-14 12:26:50
