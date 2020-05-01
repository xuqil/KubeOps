-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: kubeops_rbac
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
INSERT INTO `assets_idc` VALUES (1,'2020-04-30 07:14:48.538662','2020-04-30 07:14:48.538755','开发','大学城A区','21448756829','二楼'),(2,'2020-04-30 07:15:20.898523','2020-04-30 07:15:20.898648','生产环境','大学城B区','3232424','3楼');
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
  UNIQUE KEY `ip` (`ip`),
  KEY `assets_serverassets_idc_id_08f438e4_fk_assets_idc_id` (`idc_id`),
  CONSTRAINT `assets_serverassets_idc_id_08f438e4_fk_assets_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `assets_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverassets`
--

LOCK TABLES `assets_serverassets` WRITE;
/*!40000 ALTER TABLE `assets_serverassets` DISABLE KEYS */;
INSERT INTO `assets_serverassets` VALUES (1,'2020-04-30 07:14:04.342850','2020-04-30 07:20:45.162604','','2020-3-20','2023-3-20','abcf','MagicBook','华为','笔记本','使用中','','192.168.1.15','xql','','SSH','python3.7','Linux','Ubuntu19.10','kubeops','kubeops','22',1),(2,'2020-04-30 07:19:58.559125','2020-04-30 11:12:25.057371','','','','bggepjgg','Hornor','华为','docker容器','使用中','','192.168.1.11','localhost','','SSH','python3','Linux','CentOS7.5','xql','19218xql','22',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverassets_tags`
--

LOCK TABLES `assets_serverassets_tags` WRITE;
/*!40000 ALTER TABLE `assets_serverassets_tags` DISABLE KEYS */;
INSERT INTO `assets_serverassets_tags` VALUES (2,1,1),(1,1,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_tags`
--

LOCK TABLES `assets_tags` WRITE;
/*!40000 ALTER TABLE `assets_tags` DISABLE KEYS */;
INSERT INTO `assets_tags` VALUES (1,'2020-04-30 07:15:46.260895','2020-04-30 07:15:46.260970','开发','用于开发的主机'),(2,'2020-04-30 07:15:58.929224','2020-04-30 07:15:58.929313','测试','用于测试的主机'),(3,'2020-04-30 07:16:15.972430','2020-04-30 07:16:15.972534','生产环境','生产环境的主机'),(4,'2020-04-30 07:16:42.883458','2020-04-30 07:16:42.883575','KubeOps','用于部署KubeOps');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add crontab',6,'add_crontabschedule'),(22,'Can change crontab',6,'change_crontabschedule'),(23,'Can delete crontab',6,'delete_crontabschedule'),(24,'Can view crontab',6,'view_crontabschedule'),(25,'Can add interval',7,'add_intervalschedule'),(26,'Can change interval',7,'change_intervalschedule'),(27,'Can delete interval',7,'delete_intervalschedule'),(28,'Can view interval',7,'view_intervalschedule'),(29,'Can add periodic task',8,'add_periodictask'),(30,'Can change periodic task',8,'change_periodictask'),(31,'Can delete periodic task',8,'delete_periodictask'),(32,'Can view periodic task',8,'view_periodictask'),(33,'Can add periodic tasks',9,'add_periodictasks'),(34,'Can change periodic tasks',9,'change_periodictasks'),(35,'Can delete periodic tasks',9,'delete_periodictasks'),(36,'Can view periodic tasks',9,'view_periodictasks'),(37,'Can add solar event',10,'add_solarschedule'),(38,'Can change solar event',10,'change_solarschedule'),(39,'Can delete solar event',10,'delete_solarschedule'),(40,'Can view solar event',10,'view_solarschedule'),(41,'Can add clocked',11,'add_clockedschedule'),(42,'Can change clocked',11,'change_clockedschedule'),(43,'Can delete clocked',11,'delete_clockedschedule'),(44,'Can view clocked',11,'view_clockedschedule'),(45,'Can add 菜单',12,'add_menu'),(46,'Can change 菜单',12,'change_menu'),(47,'Can delete 菜单',12,'delete_menu'),(48,'Can view 菜单',12,'view_menu'),(49,'Can add 权限',13,'add_permission'),(50,'Can change 权限',13,'change_permission'),(51,'Can delete 权限',13,'delete_permission'),(52,'Can view 权限',13,'view_permission'),(53,'Can add 角色',14,'add_role'),(54,'Can change 角色',14,'change_role'),(55,'Can delete 角色',14,'delete_role'),(56,'Can view 角色',14,'view_role'),(57,'Can add 用户',15,'add_userprofile'),(58,'Can change 用户',15,'change_userprofile'),(59,'Can delete 用户',15,'delete_userprofile'),(60,'Can view 用户',15,'view_userprofile'),(61,'Can add IDC数据中心',16,'add_idc'),(62,'Can change IDC数据中心',16,'change_idc'),(63,'Can delete IDC数据中心',16,'delete_idc'),(64,'Can view IDC数据中心',16,'view_idc'),(65,'Can add 标签表',17,'add_tags'),(66,'Can change 标签表',17,'change_tags'),(67,'Can delete 标签表',17,'delete_tags'),(68,'Can view 标签表',17,'view_tags'),(69,'Can add 服务器资产表',18,'add_serverassets'),(70,'Can change 服务器资产表',18,'change_serverassets'),(71,'Can delete 服务器资产表',18,'delete_serverassets'),(72,'Can view 服务器资产表',18,'view_serverassets'),(73,'Can add 分类',19,'add_category'),(74,'Can change 分类',19,'change_category'),(75,'Can delete 分类',19,'delete_category'),(76,'Can view 分类',19,'view_category'),(77,'Can add 标签云',20,'add_tag'),(78,'Can change 标签云',20,'change_tag'),(79,'Can delete 标签云',20,'delete_tag'),(80,'Can view 标签云',20,'view_tag'),(81,'Can add 文章',21,'add_post'),(82,'Can change 文章',21,'change_post'),(83,'Can delete 文章',21,'delete_post'),(84,'Can view 文章',21,'view_post'),(85,'Can add 评论',22,'add_comment'),(86,'Can change 评论',22,'change_comment'),(87,'Can delete 评论',22,'delete_comment'),(88,'Can view 评论',22,'view_comment'),(89,'Can add 背景颜色',23,'add_backgroundsettings'),(90,'Can change 背景颜色',23,'change_backgroundsettings'),(91,'Can delete 背景颜色',23,'delete_backgroundsettings'),(92,'Can view 背景颜色',23,'view_backgroundsettings');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_rbac_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_rbac_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `rbac_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-04-29 16:53:55.547312','29','查看菜单',2,'[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]',13,1),(2,'2020-04-29 16:55:46.371996','1','管理员',1,'[{\"added\": {}}]',14,1),(3,'2020-04-29 16:56:14.033494','77','管理员',1,'[{\"added\": {}}]',13,1),(4,'2020-04-29 16:57:36.812133','1','管理员',2,'[{\"changed\": {\"fields\": [\"\\u6743\\u9650\"]}}]',14,1),(5,'2020-04-29 16:58:18.667831','1','首页',1,'[{\"added\": {}}]',12,1),(6,'2020-04-29 16:58:50.980626','1','管理员',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',14,1),(7,'2020-04-29 17:02:56.135147','1','admin',2,'[{\"changed\": {\"fields\": [\"Last login\", \"\\u89d2\\u8272\"]}}]',15,1),(8,'2020-04-30 05:38:32.035861','1','首页',2,'[{\"changed\": {\"fields\": [\"\\u94fe\\u63a5\\u5730\\u5740\"]}}]',12,1),(9,'2020-04-30 05:39:05.680295','1','首页',2,'[{\"changed\": {\"fields\": [\"\\u56fe\\u6807\"]}}]',12,1),(10,'2020-04-30 05:40:00.508284','1','系统首页',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\\u540d\\u79f0\"]}}]',12,1),(11,'2020-04-30 05:42:53.555980','1','系统首页',2,'[{\"changed\": {\"fields\": [\"\\u6fc0\\u6d3b\\u72b6\\u6001\"]}}]',12,1),(12,'2020-04-30 05:43:05.753107','1','系统首页',2,'[{\"changed\": {\"fields\": [\"\\u6fc0\\u6d3b\\u72b6\\u6001\"]}}]',12,1),(13,'2020-04-30 05:45:27.381951','2','平台管理',1,'[{\"added\": {}}]',12,1),(14,'2020-04-30 05:45:53.867631','3','系统设置',1,'[{\"added\": {}}]',12,1),(15,'2020-04-30 05:46:15.664266','4','kubernetes管理',1,'[{\"added\": {}}]',12,1),(16,'2020-04-30 05:47:05.527467','5','资产管理',1,'[{\"added\": {}}]',12,1),(17,'2020-04-30 05:47:22.779657','6','主机管理',1,'[{\"added\": {}}]',12,1),(18,'2020-04-30 05:47:36.607729','7','IDC机房',1,'[{\"added\": {}}]',12,1),(19,'2020-04-30 05:47:51.305337','8','标签管理',1,'[{\"added\": {}}]',12,1),(20,'2020-04-30 05:48:10.250551','9','远程管理',1,'[{\"added\": {}}]',12,1),(21,'2020-04-30 05:48:17.188919','8','标签管理',2,'[{\"changed\": {\"fields\": [\"\\u6392\\u5e8f\\u6807\\u8bb0\"]}}]',12,1),(22,'2020-04-30 05:48:56.181110','10','应用部署',1,'[{\"added\": {}}]',12,1),(23,'2020-04-30 05:49:40.146694','11','任务管理',1,'[{\"added\": {}}]',12,1),(24,'2020-04-30 05:49:50.511248','12','任务列表',1,'[{\"added\": {}}]',12,1),(25,'2020-04-30 05:50:21.300398','13','Crontab',1,'[{\"added\": {}}]',12,1),(26,'2020-04-30 05:50:39.115808','14','时间间隔',1,'[{\"added\": {}}]',12,1),(27,'2020-04-30 05:50:54.137400','15','计时',1,'[{\"added\": {}}]',12,1),(28,'2020-04-30 05:51:17.407075','16','用户管理',1,'[{\"added\": {}}]',12,1),(29,'2020-04-30 05:52:15.887617','17','用户列表',1,'[{\"added\": {}}]',12,1),(30,'2020-04-30 05:52:51.885163','18','账户设置',1,'[{\"added\": {}}]',12,1),(31,'2020-04-30 05:53:25.055972','19','权限管理',1,'[{\"added\": {}}]',12,1),(32,'2020-04-30 05:53:34.065876','19','权限管理',2,'[]',12,1),(33,'2020-04-30 05:54:34.628666','20','角色列表',1,'[{\"added\": {}}]',12,1),(34,'2020-04-30 05:54:48.429563','21','权限列表',1,'[{\"added\": {}}]',12,1),(35,'2020-04-30 05:55:07.816063','22','文件管理',1,'[{\"added\": {}}]',12,1),(36,'2020-04-30 05:55:22.494042','23','WIKI',1,'[{\"added\": {}}]',12,1),(37,'2020-04-30 05:55:41.574288','24','话题',1,'[{\"added\": {}}]',12,1),(38,'2020-04-30 05:55:54.984375','25','添加wiki文章',1,'[{\"added\": {}}]',12,1),(39,'2020-04-30 05:56:26.507622','1','管理员',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',14,1),(40,'2020-04-30 06:02:16.496022','1','蜂巢',1,'[{\"added\": {}}]',19,1),(41,'2020-04-30 06:02:23.026627','1','用户管理',1,'[{\"added\": {}}]',20,1),(42,'2020-04-30 06:06:25.597916','7','IDC机房',2,'[{\"changed\": {\"fields\": [\"\\u4e0a\\u7ea7\\u83dc\\u5355\"]}}]',12,1),(43,'2020-04-30 06:31:24.909039','2','001',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',15,1),(44,'2020-04-30 06:39:48.228199','1','admin',2,'[{\"changed\": {\"fields\": [\"\\u89d2\\u8272\"]}}]',15,1),(45,'2020-04-30 06:40:48.989469','1','管理员',2,'[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]',14,1),(46,'2020-04-30 07:23:33.330272','1','顶部导航栏',1,'[{\"added\": {}}]',23,1),(47,'2020-04-30 07:23:50.252182','2','侧边菜单栏',1,'[{\"added\": {}}]',23,1),(48,'2020-04-30 07:24:06.841111','3','平台主体',1,'[{\"added\": {}}]',23,1),(49,'2020-04-30 07:42:17.894070','3','测试人员',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\"]}}]',14,1),(50,'2020-04-30 07:42:45.891051','2','001',2,'[{\"changed\": {\"fields\": [\"Last login\", \"Active\"]}}]',15,1),(51,'2020-04-30 12:41:13.598081','79','用户管理',1,'[{\"added\": {}}]',13,1),(52,'2020-04-30 12:41:25.498077','41','查看用户',2,'[{\"changed\": {\"fields\": [\"\\u4e0a\\u7ea7\\u6743\\u9650\"]}}]',13,1),(53,'2020-04-30 12:41:46.337050','42','添加用户',2,'[{\"changed\": {\"fields\": [\"\\u4e0a\\u7ea7\\u6743\\u9650\"]}}]',13,1),(54,'2020-04-30 12:42:00.322559','43','删除用户',2,'[{\"changed\": {\"fields\": [\"\\u4e0a\\u7ea7\\u6743\\u9650\"]}}]',13,1),(55,'2020-05-01 06:23:14.062966','3','测试人员',2,'[{\"changed\": {\"fields\": [\"\\u6743\\u9650\"]}}]',14,1);
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
INSERT INTO `django_celery_beat_clockedschedule` VALUES (1,'2020-04-30 16:00:00.000000',1),(2,'2020-04-20 16:00:00.000000',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_crontabschedule`
--

LOCK TABLES `django_celery_beat_crontabschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_crontabschedule` DISABLE KEYS */;
INSERT INTO `django_celery_beat_crontabschedule` VALUES (1,'1','*','*','*','*','Asia/Shanghai'),(2,'0','4','*','*','*','Asia/Shanghai');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_intervalschedule`
--

LOCK TABLES `django_celery_beat_intervalschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_intervalschedule` DISABLE KEYS */;
INSERT INTO `django_celery_beat_intervalschedule` VALUES (1,1,'minutes');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_periodictask`
--

LOCK TABLES `django_celery_beat_periodictask` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_periodictask` DISABLE KEYS */;
INSERT INTO `django_celery_beat_periodictask` VALUES (1,'celery.backend_cleanup','celery.backend_cleanup','[]','{}',NULL,NULL,NULL,NULL,1,NULL,0,'2020-04-30 12:03:16.264686','',2,NULL,NULL,0,NULL,NULL,'{}',NULL,43200),(2,'测试','apps.tasks.tasks.add','[22,100]','{}',NULL,NULL,NULL,NULL,0,NULL,9,'2020-04-30 12:13:31.487762','测试任务',NULL,1,NULL,0,NULL,NULL,'{}',NULL,NULL),(3,'乘法测试','apps.tasks.tasks.mul','[100,100]','{}',NULL,NULL,NULL,NULL,0,NULL,6,'2020-04-30 12:13:31.477375','乘法测试',NULL,1,NULL,0,'2020-04-30 12:06:59.000000',NULL,'{}',NULL,NULL);
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
INSERT INTO `django_celery_beat_periodictasks` VALUES (1,'2020-04-30 12:13:29.354454');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(16,'assets','idc'),(18,'assets','serverassets'),(17,'assets','tags'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(11,'django_celery_beat','clockedschedule'),(6,'django_celery_beat','crontabschedule'),(7,'django_celery_beat','intervalschedule'),(8,'django_celery_beat','periodictask'),(9,'django_celery_beat','periodictasks'),(10,'django_celery_beat','solarschedule'),(12,'rbac','menu'),(13,'rbac','permission'),(14,'rbac','role'),(15,'rbac','userprofile'),(5,'sessions','session'),(23,'settings','backgroundsettings'),(19,'wiki','category'),(22,'wiki','comment'),(21,'wiki','post'),(20,'wiki','tag');
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-04-29 15:32:01.863107'),(2,'contenttypes','0002_remove_content_type_name','2020-04-29 15:32:01.926214'),(3,'auth','0001_initial','2020-04-29 15:32:02.004573'),(4,'auth','0002_alter_permission_name_max_length','2020-04-29 15:32:02.156623'),(5,'auth','0003_alter_user_email_max_length','2020-04-29 15:32:02.168252'),(6,'auth','0004_alter_user_username_opts','2020-04-29 15:32:02.175352'),(7,'auth','0005_alter_user_last_login_null','2020-04-29 15:32:02.183538'),(8,'auth','0006_require_contenttypes_0002','2020-04-29 15:32:02.186215'),(9,'auth','0007_alter_validators_add_error_messages','2020-04-29 15:32:02.192336'),(10,'auth','0008_alter_user_username_max_length','2020-04-29 15:32:02.204435'),(11,'auth','0009_alter_user_last_name_max_length','2020-04-29 15:32:02.210756'),(12,'auth','0010_alter_group_name_max_length','2020-04-29 15:32:02.248108'),(13,'auth','0011_update_proxy_permissions','2020-04-29 15:32:02.259831'),(14,'rbac','0001_initial','2020-04-29 15:32:02.451034'),(15,'admin','0001_initial','2020-04-29 15:32:02.943974'),(16,'admin','0002_logentry_remove_auto_add','2020-04-29 15:32:03.019103'),(17,'admin','0003_logentry_add_action_flag_choices','2020-04-29 15:32:03.030730'),(18,'assets','0001_initial','2020-04-29 15:32:03.136085'),(19,'django_celery_beat','0001_initial','2020-04-29 15:32:03.341340'),(20,'django_celery_beat','0002_auto_20161118_0346','2020-04-29 15:32:03.480425'),(21,'django_celery_beat','0003_auto_20161209_0049','2020-04-29 15:32:03.498964'),(22,'django_celery_beat','0004_auto_20170221_0000','2020-04-29 15:32:03.511897'),(23,'django_celery_beat','0005_add_solarschedule_events_choices','2020-04-29 15:32:03.519543'),(24,'django_celery_beat','0006_auto_20180322_0932','2020-04-29 15:32:03.657637'),(25,'django_celery_beat','0007_auto_20180521_0826','2020-04-29 15:32:03.743784'),(26,'django_celery_beat','0008_auto_20180914_1922','2020-04-29 15:32:03.764841'),(27,'django_celery_beat','0006_auto_20180210_1226','2020-04-29 15:32:03.781995'),(28,'django_celery_beat','0006_periodictask_priority','2020-04-29 15:32:03.827822'),(29,'django_celery_beat','0009_periodictask_headers','2020-04-29 15:32:03.871132'),(30,'django_celery_beat','0010_auto_20190429_0326','2020-04-29 15:32:04.133834'),(31,'django_celery_beat','0011_auto_20190508_0153','2020-04-29 15:32:04.215474'),(32,'django_celery_beat','0012_periodictask_expire_seconds','2020-04-29 15:32:04.267921'),(33,'file','0001_initial','2020-04-29 15:32:04.295514'),(34,'file','0002_delete_filemodel','2020-04-29 15:32:04.309397'),(35,'sessions','0001_initial','2020-04-29 15:32:04.332307'),(36,'settings','0001_initial','2020-04-29 15:32:04.372728'),(37,'wiki','0001_initial','2020-04-29 15:32:04.508633');
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
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ufmu5bdlnub8rwof64ueb9irjf0ni7ow','MmRmMTc1ZWFhYWYwMmQ1ZmVjMjQ4NzQ3MWZhZTZkYmZjNzEwYTY3ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwNWI1NDQ1MjE5ODk0MWM3NmMzZjM4NjY3NmNmMzkzZDE5MDUxMTI1Iiwic2ltcGxldWlfMjAyMDA0MjkiOnRydWUsInNpbXBsZXVpXzIwMjAwNDMwIjp0cnVlLCJzaW1wbGV1aV8yMDIwMDUwMSI6dHJ1ZX0=','2020-05-15 05:26:03.218973');
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
  `name` varchar(32) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `path` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `pid_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `rbac_menu_pid_id_a43b3c84_fk_rbac_menu_id` (`pid_id`),
  CONSTRAINT `rbac_menu_pid_id_a43b3c84_fk_rbac_menu_id` FOREIGN KEY (`pid_id`) REFERENCES `rbac_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_menu`
--

LOCK TABLES `rbac_menu` WRITE;
/*!40000 ALTER TABLE `rbac_menu` DISABLE KEYS */;
INSERT INTO `rbac_menu` VALUES (1,'系统首页','el-icon-s-home','/home',1,0,NULL),(2,'平台管理','el-icon-setting','/platform',1,1,NULL),(3,'系统设置','el-icon-menu','/settings',1,1,2),(4,'kubernetes管理','el-icon-menu','/Kubernetes',1,2,2),(5,'资产管理','el-icon-goods','/assets',1,2,NULL),(6,'主机管理','el-icon-menu','/server',1,1,5),(7,'IDC机房','el-icon-menu','/idc',1,2,5),(8,'标签管理','el-icon-menu','/tags',1,4,5),(9,'远程管理','el-icon-menu','/webssh',1,3,5),(10,'应用部署','el-icon-bangzhu','/deploy',1,3,NULL),(11,'任务管理','el-icon-time','/task',1,4,NULL),(12,'任务列表','el-icon-menu','/tasks',1,1,11),(13,'Crontab','el-icon-menu','/crontab',1,2,11),(14,'时间间隔','el-icon-menu','/intervals',1,3,11),(15,'计时','el-icon-menu','/clocked',1,4,11),(16,'用户管理','el-icon-user','/users/',1,5,NULL),(17,'用户列表','el-icon-menu','/users',1,1,16),(18,'账户设置','el-icon-menu','/user',1,2,16),(19,'权限管理','el-icon-office-building','/rights',1,6,NULL),(20,'角色列表','el-icon-menu','/roles',1,1,19),(21,'权限列表','el-icon-menu','/rights',1,2,19),(22,'文件管理','el-icon-folder','/files',1,7,NULL),(23,'WIKI','el-icon-chat-line-square','',1,8,NULL),(24,'话题','el-icon-menu','/wiki',1,1,23),(25,'添加wiki文章','el-icon-menu','/wiki/add',1,2,23);
/*!40000 ALTER TABLE `rbac_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_permission`
--

DROP TABLE IF EXISTS `rbac_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `path` varchar(128) NOT NULL,
  `method` varchar(16) NOT NULL,
  `pid_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `rbac_permission_pid_id_6939354d_fk_rbac_permission_id` (`pid_id`),
  CONSTRAINT `rbac_permission_pid_id_6939354d_fk_rbac_permission_id` FOREIGN KEY (`pid_id`) REFERENCES `rbac_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_permission`
--

LOCK TABLES `rbac_permission` WRITE;
/*!40000 ALTER TABLE `rbac_permission` DISABLE KEYS */;
INSERT INTO `rbac_permission` VALUES (1,'查看日志记录','/logs/','GET',NULL),(5,'查看solar event','/tasks/solar_schedule/','GET',102),(6,'添加solar event','/tasks/solar_schedule/','POST',102),(7,'删除solar event','/tasks/solar_schedule/(?P<pk>[^/.]+)/','DELETE',102),(8,'修改solar event','/tasks/solar_schedule/(?P<pk>[^/.]+)/','PUT',102),(9,'查看interval','/tasks/interval_schedule/','GET',103),(10,'添加interval','/tasks/interval_schedule/','POST',103),(11,'删除interval','/tasks/interval_schedule/(?P<pk>[^/.]+)/','DELETE',103),(12,'修改interval','/tasks/interval_schedule/(?P<pk>[^/.]+)/','PUT',103),(13,'查看clocked','/tasks/clocked_schedule/','GET',104),(14,'添加clocked','/tasks/clocked_schedule/','POST',104),(15,'删除clocked','/tasks/clocked_schedule/(?P<pk>[^/.]+)/','DELETE',104),(16,'修改clocked','/tasks/clocked_schedule/(?P<pk>[^/.]+)/','PUT',104),(17,'查看crontab','/tasks/crontab_schedule/','GET',105),(18,'添加crontab','/tasks/crontab_schedule/','POST',105),(19,'删除crontab','/tasks/crontab_schedule/(?P<pk>[^/.]+)/','DELETE',105),(20,'修改crontab','/tasks/crontab_schedule/(?P<pk>[^/.]+)/','PUT',105),(21,'查看periodic tasks','/tasks/periodic_tasks/','GET',116),(22,'添加periodic tasks','/tasks/periodic_tasks/','POST',116),(23,'删除periodic tasks','/tasks/periodic_tasks/','DELETE',116),(24,'修改periodic tasks','/tasks/periodic_tasks/','PUT',116),(25,'查看periodic task','/tasks/periodic_task/','GET',106),(26,'添加periodic task','/tasks/periodic_task/','POST',106),(27,'删除periodic task','/tasks/periodic_task/(?P<pk>[^/.]+)/','DELETE',106),(28,'修改periodic task','/tasks/periodic_task/(?P<pk>[^/.]+)/','PUT',106),(29,'查看菜单','/power/menu/','GET',83),(30,'添加菜单','/power/menu/','POST',83),(31,'删除菜单','/power/menu/(?P<pk>[^/.]+)/','DELETE',83),(32,'修改菜单','/power/menu/(?P<pk>[^/.]+)/','PUT',83),(33,'查看权限','/power/permissions/','GET',107),(34,'添加权限','/power/permissions/','POST',107),(35,'删除权限','/power/permissions/(?P<pk>[^/.]+)/','DELETE',107),(36,'修改权限','/power/permissions/(?P<pk>[^/.]+)/','PUT',107),(37,'查看角色','/power/roles/','GET',109),(38,'添加角色','/power/roles/','POST',109),(39,'删除角色','/power/roles/(?P<pk>[^/.]+)/','DELETE',109),(40,'修改角色','/power/roles/(?P<pk>[^/.]+)/','PUT',109),(41,'查看用户','/power/users/','GET',108),(42,'添加用户','/power/user/','POST',108),(43,'删除用户','/power/users/(?P<pk>[^/.]+)/','DELETE',108),(44,'修改用户','/power/users/(?P<pk>[^/.]+)/','PUT',108),(45,'查看IDC数据中心','/assets/idc/','GET',110),(46,'添加IDC数据中心','/assets/idc/','POST',110),(47,'删除IDC数据中心','/assets/idc/(?P<pk>[^/.]+)/','DELETE',110),(48,'修改IDC数据中心','/assets/idc/(?P<pk>[^/.]+)/','PUT',110),(49,'查看资产标签','/assets/tags/','GET',111),(50,'添加资产标签','/assets/tags/','POST',111),(51,'删除资产标签','/assets/tags/(?P<pk>[^/.]+)/','DELETE',111),(52,'修改资产标签','/assets/tags/(?P<pk>[^/.]+)/','PUT',111),(53,'查看服务器资产主机','/assets/servers/','GET',88),(54,'添加服务器资产主机','/assets/servers/','POST',88),(55,'删除服务器资产主机','/assets/servers/(?P<pk>[^/.]+)/','DELETE',88),(56,'修改服务器资产主机','/assets/servers/(?P<pk>[^/.]+)/','PUT',88),(57,'查看wiki分类','/wiki/categories/','GET',112),(58,'添加wiki分类','/wiki/categories/','POST',112),(59,'删除wiki分类','/wiki/categories/(?P<pk>[^/.]+)/','DELETE',112),(60,'修改wiki分类','/wiki/categories/(?P<pk>[^/.]+)/','PUT',112),(61,'查看wiki标签','/wiki/tags/','GET',113),(62,'添加wiki标签','/wiki/tags/','POST',113),(63,'删除wiki标签','/wiki/tags/(?P<pk>[^/.]+)/','DELETE',113),(64,'修改wiki标签','/wiki/tags/(?P<pk>[^/.]+)/','PUT',113),(65,'查看wiki文章','/wiki/posts/','GET',114),(66,'添加wiki文章','/wiki/posts/','POST',114),(67,'删除wiki文章','/wiki/posts/(?P<pk>[^/.]+)/','DELETE',114),(68,'修改wiki文章','/wiki/posts/(?P<pk>[^/.]+)/','PUT',114),(69,'查看wiki评论','/wiki/comments/','GET',115),(70,'添加wiki评论','/wiki/comments/','POST',115),(71,'删除wiki评论','/wiki/comments/(?P<pk>[^/.]+)/','DELETE',115),(72,'修改wiki评论','/wiki/comments/(?P<pk>[^/.]+)/','PUT',115),(73,'查看背景颜色','/platform/settings/','GET',86),(76,'修改背景颜色','/platform/settings/(?P<pk>[^/.]+)/','PUT',86),(77,'管理员','.*','*',NULL),(78,'获取首页菜单','/power/menu/tree/','GET',NULL),(79,'用户管理','/users','GET',NULL),(80,'权限管理','/power/permissions/','*',NULL),(81,'获取所有权限(添加和编辑权限时)','/power/permissions/all/','GET',80),(82,'任务管理','/tasks/task/','*',NULL),(83,'菜单管理','/abc/','*',NULL),(84,'资产管理','/abc/','*',NULL),(85,'wiki管理','/abc/','*',NULL),(86,'设置管理','/abc/','*',NULL),(87,'查看wiki文章详情','/wiki/posts/(?P<pk>[^/.]+)/','GET',85),(88,'主机管理','/abc/','*',84),(89,'查看solar event详情','/tasks/solar_schedule/(?P<pk>[^/.]+)/','GET',102),(90,'查看interval详情','/tasks/interval_schedule/(?P<pk>[^/.]+)/','GET',103),(91,'查看clocked详情','/tasks/clocked_schedule/(?P<pk>[^/.]+)/','GET',104),(92,'查看crontab详情','/tasks/crontab_schedule/(?P<pk>[^/.]+)/','GET',105),(93,'查看periodic tasks详情','/tasks/periodic_task/(?P<pk>[^/.]+)/','GET',116),(94,'查看periodic task详情','/tasks/periodic_task/(?P<pk>[^/.]+)/','GET',106),(95,'查看菜单详情','/power/menu/(?P<pk>[^/.]+)/','GET',83),(96,'查看权限详情','/power/permissions/(?P<pk>[^/.]+)/','GET',107),(97,'查看角色详情','/power/roles/(?P<pk>[^/.]+)/','GET',109),(98,'查看用户详情','/power/users/(?P<pk>[^/.]+)/','GET',108),(99,'修改用户密码','/power/password/','PUT',108),(100,'查看IDC数据中心详情','/assets/idc/(?P<pk>[^/.]+)/','GET',110),(101,'查看服务器资产主机详情','/assets/servers/(?P<pk>[^/.]+)/','GET',88),(102,'solar','/abc/','*',82),(103,'interval','/abc/','*',82),(104,'clocked','/abc/','*',82),(105,'crontab','/abc/','*',82),(106,'任务','/abc/','*',82),(107,'权限','/abc/','*',80),(108,'用户','/abc/','*',80),(109,'角色','/abc/','*',80),(110,'IDC','/abc/','*',84),(111,'资产标签','/abc/','*',84),(112,'wiki分类','/abc/','*',85),(113,'wiki标签','/abc/','*',85),(114,'wiki文章','/abc/','*',85),(115,'wiki评论','/abc/','*',85),(116,'periodic tasks','/abc/','*',82);
/*!40000 ALTER TABLE `rbac_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_role`
--

DROP TABLE IF EXISTS `rbac_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role`
--

LOCK TABLES `rbac_role` WRITE;
/*!40000 ALTER TABLE `rbac_role` DISABLE KEYS */;
INSERT INTO `rbac_role` VALUES (1,'管理员','管理员'),(3,'测试人员','测试人员'),(4,'普通人员','普通用户');
/*!40000 ALTER TABLE `rbac_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_role_menus`
--

DROP TABLE IF EXISTS `rbac_role_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_role_menus_role_id_menu_id_579f5861_uniq` (`role_id`,`menu_id`),
  KEY `rbac_role_menus_menu_id_180f4f9a_fk_rbac_menu_id` (`menu_id`),
  CONSTRAINT `rbac_role_menus_menu_id_180f4f9a_fk_rbac_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `rbac_menu` (`id`),
  CONSTRAINT `rbac_role_menus_role_id_323259a4_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role_menus`
--

LOCK TABLES `rbac_role_menus` WRITE;
/*!40000 ALTER TABLE `rbac_role_menus` DISABLE KEYS */;
INSERT INTO `rbac_role_menus` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(27,3,1),(35,3,2),(41,3,3),(29,3,5),(30,3,6),(31,3,7),(32,3,8),(33,3,9),(64,3,16),(65,3,18),(28,3,23),(26,3,24),(34,3,25),(45,4,1),(46,4,2),(47,4,4),(48,4,5),(49,4,6),(50,4,7),(51,4,8),(52,4,9),(53,4,11),(54,4,12),(55,4,13),(56,4,14),(57,4,15),(62,4,16),(63,4,18),(58,4,22),(59,4,23),(60,4,24),(61,4,25);
/*!40000 ALTER TABLE `rbac_role_menus` ENABLE KEYS */;
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
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_role_permissions_role_id_permission_id_d01303da_uniq` (`role_id`,`permission_id`),
  KEY `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` (`permission_id`),
  CONSTRAINT `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` FOREIGN KEY (`permission_id`) REFERENCES `rbac_permission` (`id`),
  CONSTRAINT `rbac_role_permissions_role_id_d10416cb_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role_permissions`
--

LOCK TABLES `rbac_role_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_role_permissions` DISABLE KEYS */;
INSERT INTO `rbac_role_permissions` VALUES (1,1,77),(108,3,5),(215,3,6),(216,3,7),(217,3,8),(218,3,9),(219,3,10),(220,3,11),(221,3,12),(222,3,13),(223,3,14),(224,3,15),(225,3,16),(226,3,17),(227,3,18),(228,3,19),(229,3,20),(230,3,21),(231,3,22),(232,3,23),(233,3,24),(234,3,25),(235,3,26),(236,3,27),(237,3,28),(20,3,29),(50,3,30),(51,3,31),(52,3,32),(110,3,33),(111,3,34),(112,3,35),(113,3,36),(114,3,37),(115,3,38),(116,3,39),(117,3,40),(238,3,41),(106,3,42),(92,3,43),(239,3,44),(105,3,45),(94,3,46),(95,3,47),(96,3,48),(97,3,49),(182,3,50),(89,3,51),(100,3,52),(101,3,53),(102,3,54),(103,3,55),(104,3,56),(86,3,57),(179,3,58),(70,3,59),(71,3,60),(88,3,61),(72,3,62),(181,3,63),(74,3,64),(5,3,65),(180,3,66),(76,3,67),(77,3,68),(8,3,69),(78,3,70),(79,3,71),(80,3,72),(120,3,73),(81,3,76),(83,3,78),(99,3,79),(118,3,80),(119,3,81),(107,3,82),(46,3,83),(90,3,84),(48,3,85),(49,3,86),(85,3,87),(109,3,88),(240,3,89),(241,3,90),(242,3,91),(243,3,92),(244,3,93),(245,3,94),(196,3,95),(192,3,96),(193,3,97),(194,3,98),(195,3,99),(246,3,100),(247,3,101),(248,3,102),(267,3,103),(268,3,104),(269,3,105),(270,3,106),(271,3,107),(272,3,108),(273,3,109),(274,3,110),(275,3,111),(276,3,112),(277,3,113),(278,3,114),(279,3,115),(280,3,116),(121,4,5),(122,4,6),(123,4,7),(124,4,8),(125,4,9),(126,4,10),(127,4,11),(128,4,12),(129,4,13),(130,4,14),(131,4,15),(132,4,16),(133,4,17),(134,4,18),(135,4,19),(136,4,20),(137,4,21),(138,4,22),(139,4,23),(140,4,24),(141,4,25),(142,4,26),(143,4,27),(144,4,28),(283,4,29),(284,4,30),(285,4,31),(281,4,32),(202,4,33),(203,4,34),(204,4,35),(205,4,36),(206,4,37),(207,4,38),(208,4,39),(209,4,40),(251,4,41),(252,4,42),(255,4,43),(256,4,44),(145,4,45),(146,4,46),(147,4,47),(148,4,48),(149,4,49),(150,4,50),(151,4,51),(152,4,52),(153,4,53),(154,4,54),(155,4,55),(156,4,56),(157,4,57),(158,4,58),(159,4,59),(160,4,60),(161,4,61),(162,4,62),(163,4,63),(164,4,64),(165,4,65),(166,4,66),(167,4,67),(168,4,68),(169,4,69),(170,4,70),(171,4,71),(172,4,72),(197,4,73),(212,4,76),(173,4,78),(189,4,80),(213,4,81),(174,4,82),(266,4,83),(175,4,84),(176,4,85),(198,4,86),(177,4,87),(178,4,88),(183,4,89),(184,4,90),(185,4,91),(186,4,92),(187,4,93),(188,4,94),(214,4,95),(201,4,96),(210,4,97),(190,4,98),(191,4,99),(199,4,100),(200,4,101),(211,4,102),(249,4,103),(250,4,104),(258,4,105),(259,4,106),(253,4,107),(254,4,108),(257,4,109),(260,4,110),(261,4,111),(262,4,112),(263,4,113),(264,4,114),(265,4,115),(282,4,116);
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
  `mobile` varchar(32) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `superior_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `rbac_userprofile_superior_id_5d0a3780_fk_rbac_userprofile_id` (`superior_id`),
  CONSTRAINT `rbac_userprofile_superior_id_5d0a3780_fk_rbac_userprofile_id` FOREIGN KEY (`superior_id`) REFERENCES `rbac_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_userprofile`
--

LOCK TABLES `rbac_userprofile` WRITE;
/*!40000 ALTER TABLE `rbac_userprofile` DISABLE KEYS */;
INSERT INTO `rbac_userprofile` VALUES (1,'pbkdf2_sha256$180000$eYxMOX36jXYG$ElfM5hfPYENqAD90WqNa6686Z7dJkzR8Oxo6Xyc7vy4=','2020-05-01 07:52:39.841675',1,'admin','','','admin@kubeops.com',1,1,'2020-04-29 15:32:00.000000','',NULL,NULL),(2,'pbkdf2_sha256$180000$3wOHgm1aJwcM$28TbC5jaZFusD2ZpfdlNo0Wj8mkUuitJsC6Okjpzpfs=','2020-05-01 07:27:02.356675',0,'001','','','1114@11.com',1,1,'2020-04-30 06:29:00.000000','13828732678',NULL,NULL),(3,'pbkdf2_sha256$180000$Q1z78YjGPLxC$LZWp710yJeuQ3LGv1nOCCEBwDaTtX6adZ0GTLAYFY0E=','2020-05-01 07:52:10.353667',0,'test','','','test@kubeops.com',0,1,'2020-05-01 07:32:33.798655','13267487537',NULL,NULL);
/*!40000 ALTER TABLE `rbac_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_userprofile_groups`
--

DROP TABLE IF EXISTS `rbac_userprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_userprofile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_userprofile_groups_userprofile_id_group_id_4d710b30_uniq` (`userprofile_id`,`group_id`),
  KEY `rbac_userprofile_groups_group_id_2c47610b_fk_auth_group_id` (`group_id`),
  CONSTRAINT `rbac_userprofile_gro_userprofile_id_9cacde37_fk_rbac_user` FOREIGN KEY (`userprofile_id`) REFERENCES `rbac_userprofile` (`id`),
  CONSTRAINT `rbac_userprofile_groups_group_id_2c47610b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_userprofile_groups`
--

LOCK TABLES `rbac_userprofile_groups` WRITE;
/*!40000 ALTER TABLE `rbac_userprofile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `rbac_userprofile_groups` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_userprofile_roles_userprofile_id_role_id_ba9254c5_uniq` (`userprofile_id`,`role_id`),
  KEY `rbac_userprofile_roles_role_id_ddc12d7e_fk_rbac_role_id` (`role_id`),
  CONSTRAINT `rbac_userprofile_rol_userprofile_id_3a7afbe9_fk_rbac_user` FOREIGN KEY (`userprofile_id`) REFERENCES `rbac_userprofile` (`id`),
  CONSTRAINT `rbac_userprofile_roles_role_id_ddc12d7e_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_userprofile_roles`
--

LOCK TABLES `rbac_userprofile_roles` WRITE;
/*!40000 ALTER TABLE `rbac_userprofile_roles` DISABLE KEYS */;
INSERT INTO `rbac_userprofile_roles` VALUES (4,1,1),(5,2,3),(6,3,4);
/*!40000 ALTER TABLE `rbac_userprofile_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_userprofile_user_permissions`
--

DROP TABLE IF EXISTS `rbac_userprofile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_userprofile_user_pe_userprofile_id_permissio_16bbd20f_uniq` (`userprofile_id`,`permission_id`),
  KEY `rbac_userprofile_use_permission_id_740ad67c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `rbac_userprofile_use_permission_id_740ad67c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `rbac_userprofile_use_userprofile_id_38afd71d_fk_rbac_user` FOREIGN KEY (`userprofile_id`) REFERENCES `rbac_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_userprofile_user_permissions`
--

LOCK TABLES `rbac_userprofile_user_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_userprofile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `rbac_userprofile_user_permissions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_category`
--

LOCK TABLES `wiki_category` WRITE;
/*!40000 ALTER TABLE `wiki_category` DISABLE KEYS */;
INSERT INTO `wiki_category` VALUES (1,'蜂巢');
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
  KEY `wiki_comment_parent_id_id_a262e031_fk_wiki_comment_nid` (`parent_id_id`),
  KEY `wiki_comment_post_id_3b7dbaf4_fk_wiki_post_id` (`post_id`),
  KEY `wiki_comment_user_id_b436f931_fk_rbac_userprofile_id` (`user_id`),
  CONSTRAINT `wiki_comment_parent_id_id_a262e031_fk_wiki_comment_nid` FOREIGN KEY (`parent_id_id`) REFERENCES `wiki_comment` (`nid`),
  CONSTRAINT `wiki_comment_post_id_3b7dbaf4_fk_wiki_post_id` FOREIGN KEY (`post_id`) REFERENCES `wiki_post` (`id`),
  CONSTRAINT `wiki_comment_user_id_b436f931_fk_rbac_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `rbac_userprofile` (`id`)
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
  `c_time` datetime(6) NOT NULL,
  `u_time` datetime(6) NOT NULL,
  `excerpt` varchar(200) NOT NULL,
  `views` int(10) unsigned NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `wiki_post_author_id_907c2b12_fk_rbac_userprofile_id` (`author_id`),
  KEY `wiki_post_category_id_680167b5_fk_wiki_category_id` (`category_id`),
  CONSTRAINT `wiki_post_author_id_907c2b12_fk_rbac_userprofile_id` FOREIGN KEY (`author_id`) REFERENCES `rbac_userprofile` (`id`),
  CONSTRAINT `wiki_post_category_id_680167b5_fk_wiki_category_id` FOREIGN KEY (`category_id`) REFERENCES `wiki_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_post`
--

LOCK TABLES `wiki_post` WRITE;
/*!40000 ALTER TABLE `wiki_post` DISABLE KEYS */;
INSERT INTO `wiki_post` VALUES (1,'Vue','<p><h3font-size: 22px;=\"\" font-weight:=\"\" 400;=\"\" color:=\"\" rgb(31,=\"\" 45,=\"\" 61);=\"\" margin:=\"\" 0px=\"\" 30px;=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">一致性 Consistency<ulmargin-bottom: 50px;=\"\" padding-left:=\"\" 0px;=\"\" color:=\"\" rgb(0,=\"\" 0,=\"\" 0);=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-size:=\"\" medium;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">与现实生活一致：与现实生活的流程、逻辑保持一致，遵循用户习惯的语言和概念；<lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">在界面中一致：所有的元素和结构需保持一致，比如：设计样式、图标和文本、元素的位置等。<h3font-size: 22px;=\"\" font-weight:=\"\" 400;=\"\" color:=\"\" rgb(31,=\"\" 45,=\"\" 61);=\"\" margin:=\"\" 0px=\"\" 30px;=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">反馈 Feedback<ulmargin-bottom: 50px;=\"\" padding-left:=\"\" 0px;=\"\" color:=\"\" rgb(0,=\"\" 0,=\"\" 0);=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-size:=\"\" medium;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">控制反馈：通过界面样式和交互动效让用户可以清晰的感知自己的操作；<lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">页面反馈：操作后，通过页面元素的变化清晰地展现当前状态。<h3font-size: 22px;=\"\" font-weight:=\"\" 400;=\"\" color:=\"\" rgb(31,=\"\" 45,=\"\" 61);=\"\" margin:=\"\" 0px=\"\" 30px;=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">效率 Efficiency<ulmargin-bottom: 50px;=\"\" padding-left:=\"\" 0px;=\"\" color:=\"\" rgb(0,=\"\" 0,=\"\" 0);=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-size:=\"\" medium;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">简化流程：设计简洁直观的操作流程；<lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">清晰明确：语言表达清晰且表意明确，让用户快速理解进而作出决策；<lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">帮助用户识别：界面简单直白，让用户快速识别而非回忆，减少用户记忆负担。<h3font-size: 22px;=\"\" font-weight:=\"\" 400;=\"\" color:=\"\" rgb(31,=\"\" 45,=\"\" 61);=\"\" margin:=\"\" 0px=\"\" 30px;=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">可控 Controllability<ulmargin-bottom: 50px;=\"\" padding-left:=\"\" 0px;=\"\" color:=\"\" rgb(0,=\"\" 0,=\"\" 0);=\"\" font-family:=\"\" &quot;helvetica=\"\" neue&quot;,=\"\" helvetica,=\"\" &quot;pingfang=\"\" sc&quot;,=\"\" &quot;hiragino=\"\" sans=\"\" gb&quot;,=\"\" &quot;microsoft=\"\" yahei&quot;,=\"\" simsun,=\"\" sans-serif;=\"\" font-size:=\"\" medium;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">用户决策：根据场景可给予用户操作建议或安全提示，但不能代替用户进行决策；<lifont-size: 14px;=\"\" margin-bottom:=\"\" 10px;=\"\" color:=\"\" rgb(153,=\"\" 169,=\"\" 191);=\"\" list-style:=\"\" none;\"=\"\"><strongcolor: rgb(94,=\"\" 109,=\"\" 130);=\"\" font-weight:=\"\" 400;\"=\"\">结果可控：用户可以自由的进行操作，包括撤销、回退和终止当前操作等。</strongcolor:></lifont-size:></strongcolor:></lifont-size:></ulmargin-bottom:></h3font-size:></strongcolor:></lifont-size:></strongcolor:></lifont-size:></strongcolor:></lifont-size:></ulmargin-bottom:></h3font-size:></strongcolor:></lifont-size:></strongcolor:></lifont-size:></ulmargin-bottom:></h3font-size:></strongcolor:></lifont-size:></strongcolor:></lifont-size:></ulmargin-bottom:></h3font-size:><br></p>','2020-04-30 05:58:42.915116','2020-05-01 07:29:50.737280','一致性 Consistency与现实生活一致',0,1,1);
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
  UNIQUE KEY `wiki_post_tags_post_id_tag_id_2ce54a0d_uniq` (`post_id`,`tag_id`),
  KEY `wiki_post_tags_tag_id_0d1e9a57_fk_wiki_tag_id` (`tag_id`),
  CONSTRAINT `wiki_post_tags_post_id_a2c5fe07_fk_wiki_post_id` FOREIGN KEY (`post_id`) REFERENCES `wiki_post` (`id`),
  CONSTRAINT `wiki_post_tags_tag_id_0d1e9a57_fk_wiki_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `wiki_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_post_tags`
--

LOCK TABLES `wiki_post_tags` WRITE;
/*!40000 ALTER TABLE `wiki_post_tags` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_tag`
--

LOCK TABLES `wiki_tag` WRITE;
/*!40000 ALTER TABLE `wiki_tag` DISABLE KEYS */;
INSERT INTO `wiki_tag` VALUES (1,'用户管理');
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

-- Dump completed on 2020-05-01 16:27:16
