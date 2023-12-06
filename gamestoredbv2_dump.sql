-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: game_store_db_ver2
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `street_no` varchar(10) NOT NULL,
  `street_name` varchar(255) NOT NULL,
  `state_abbreviation` enum('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY') NOT NULL,
  `zip_code` varchar(5) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_ak` (`customer_id`,`street_no`,`street_name`,`state_abbreviation`,`zip_code`),
  CONSTRAINT `customer_address_fk` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,5,'469','Cambridge St','MA','');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add designer',7,'add_designer'),(26,'Can change designer',7,'change_designer'),(27,'Can delete designer',7,'delete_designer'),(28,'Can view designer',7,'view_designer'),(29,'Can add game mechanic',8,'add_gamemechanic'),(30,'Can change game mechanic',8,'change_gamemechanic'),(31,'Can delete game mechanic',8,'delete_gamemechanic'),(32,'Can view game mechanic',8,'view_gamemechanic'),(33,'Can add game type',9,'add_gametype'),(34,'Can change game type',9,'change_gametype'),(35,'Can delete game type',9,'delete_gametype'),(36,'Can view game type',9,'view_gametype'),(37,'Can add publisher',10,'add_publisher'),(38,'Can change publisher',10,'change_publisher'),(39,'Can delete publisher',10,'delete_publisher'),(40,'Can view publisher',10,'view_publisher'),(41,'Can add game item game type',11,'add_gameitemgametype'),(42,'Can change game item game type',11,'change_gameitemgametype'),(43,'Can delete game item game type',11,'delete_gameitemgametype'),(44,'Can view game item game type',11,'view_gameitemgametype'),(45,'Can add game item designer',12,'add_gameitemdesigner'),(46,'Can change game item designer',12,'change_gameitemdesigner'),(47,'Can delete game item designer',12,'delete_gameitemdesigner'),(48,'Can view game item designer',12,'view_gameitemdesigner'),(49,'Can add game item',13,'add_gameitem'),(50,'Can change game item',13,'change_gameitem'),(51,'Can delete game item',13,'delete_gameitem'),(52,'Can view game item',13,'view_gameitem'),(53,'Can add game item publisher',14,'add_gameitempublisher'),(54,'Can change game item publisher',14,'change_gameitempublisher'),(55,'Can delete game item publisher',14,'delete_gameitempublisher'),(56,'Can view game item publisher',14,'view_gameitempublisher'),(57,'Can add game item game mechanic',15,'add_gameitemgamemechanic'),(58,'Can change game item game mechanic',15,'change_gameitemgamemechanic'),(59,'Can delete game item game mechanic',15,'delete_gameitemgamemechanic'),(60,'Can view game item game mechanic',15,'view_gameitemgamemechanic'),(61,'Can add profile',16,'add_profile'),(62,'Can change profile',16,'change_profile'),(63,'Can delete profile',16,'delete_profile'),(64,'Can view profile',16,'view_profile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$AdgjEL68ZHDA12IlXpv1xR$PiNQHxwn/25fNc3QqncAnWS3Sbye8sGT9/ouhzqFqKk=','2023-12-01 23:51:08.384117',1,'admin','','','admin@admin.com',1,1,'2023-11-19 15:33:16.148965'),(2,'pbkdf2_sha256$600000$hqP1GbhtVFKw6BVnoBcljK$P9GkEiAs4Om75OfIuKAoxeZj7ANE7WDj6ENcqSt62I0=','2023-11-27 06:40:27.683894',0,'testRishabh','','','gg@gmail.com',0,1,'2023-11-22 18:13:10.793757'),(3,'pbkdf2_sha256$600000$JcjDuhfwgJZATMDB2VIxzf$MZ+lndDIuQNf7pQydrFu547nFgzfnKXHHrz2xfE/PTo=','2023-11-27 02:13:48.653373',0,'testStaff','','','testStaff@gmail.com',0,1,'2023-11-27 02:13:36.986490'),(4,'pbkdf2_sha256$600000$a550Z1MOYakuzjL7Xcyc6R$V2ky0dflUpk4AUp89b67TCTusvGA95A9GTPVSHiwK74=','2023-11-27 06:50:05.648124',0,'newUser4','','','emailnew@email.com',0,1,'2023-11-27 06:49:51.816143'),(5,'pbkdf2_sha256$600000$UDIsfqIVG1VQiyhYr6Y747$nkE4uM+Qd+YIXXnxlF2P9yBi5QOdwxeETOG+xoCmX4E=','2023-12-06 04:46:47.157272',0,'trang','','','trangkch1997@gmail.com',0,1,'2023-12-06 04:46:39.181213');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card` (
  `credit_card_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `credit_card_number` varchar(16) NOT NULL,
  `expiration_month` int NOT NULL,
  `expiration_year` int NOT NULL,
  `security_code` varchar(4) NOT NULL,
  PRIMARY KEY (`credit_card_id`),
  UNIQUE KEY `customer_id` (`customer_id`,`credit_card_number`),
  CONSTRAINT `customer_cc_fk` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `credit_card_chk_1` CHECK (((`expiration_month` >= 0) and (`expiration_month` <= 12)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (1,5,'1111111111111111',11,1111,'111'),(2,5,'2222222222222222',11,1111,'111');
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designer`
--

DROP TABLE IF EXISTS `designer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `designer` (
  `designer_id` int NOT NULL AUTO_INCREMENT,
  `designer_name` varchar(255) NOT NULL,
  PRIMARY KEY (`designer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designer`
--

LOCK TABLES `designer` WRITE;
/*!40000 ALTER TABLE `designer` DISABLE KEYS */;
INSERT INTO `designer` VALUES (1,'Eric Lang'),(2,'Jamey Stegmaier'),(3,'Isaac Childres'),(4,'Elaine Reese'),(5,'Shem Phillips'),(6,'Vital Lacerda'),(7,'Bruno Cathala'),(8,'Reiner Knizia'),(9,'Elizabeth Hargrave'),(10,'Uwe Rosenberg');
/*!40000 ALTER TABLE `designer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-11-27 06:20:30.246706','1','testRishabh Profile',1,'[{\"added\": {}}]',16,1),(2,'2023-11-27 06:20:53.217300','2','testStaff Profile',1,'[{\"added\": {}}]',16,1),(3,'2023-11-27 06:30:08.666549','2','testStaff Profile',3,'',16,1),(4,'2023-11-27 06:30:08.668543','1','testRishabh Profile',3,'',16,1),(5,'2023-11-27 06:30:16.181076','3','testRishabh Profile',1,'[{\"added\": {}}]',16,1),(6,'2023-11-27 06:30:25.242568','4','testStaff Profile',1,'[{\"added\": {}}]',16,1),(7,'2023-11-27 07:09:54.726649','6','admin Profile',1,'[{\"added\": {}}]',16,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'dashboard','designer'),(13,'dashboard','gameitem'),(12,'dashboard','gameitemdesigner'),(15,'dashboard','gameitemgamemechanic'),(11,'dashboard','gameitemgametype'),(14,'dashboard','gameitempublisher'),(8,'dashboard','gamemechanic'),(9,'dashboard','gametype'),(10,'dashboard','publisher'),(6,'sessions','session'),(16,'users','profile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-19 15:32:08.225985'),(2,'auth','0001_initial','2023-11-19 15:32:08.507959'),(3,'admin','0001_initial','2023-11-19 15:32:08.586520'),(4,'admin','0002_logentry_remove_auto_add','2023-11-19 15:32:08.602117'),(5,'admin','0003_logentry_add_action_flag_choices','2023-11-19 15:32:08.602117'),(6,'contenttypes','0002_remove_content_type_name','2023-11-19 15:32:08.665070'),(7,'auth','0002_alter_permission_name_max_length','2023-11-19 15:32:08.696330'),(8,'auth','0003_alter_user_email_max_length','2023-11-19 15:32:08.721965'),(9,'auth','0004_alter_user_username_opts','2023-11-19 15:32:08.727997'),(10,'auth','0005_alter_user_last_login_null','2023-11-19 15:32:08.759274'),(11,'auth','0006_require_contenttypes_0002','2023-11-19 15:32:08.759274'),(12,'auth','0007_alter_validators_add_error_messages','2023-11-19 15:32:08.774944'),(13,'auth','0008_alter_user_username_max_length','2023-11-19 15:32:08.822236'),(14,'auth','0009_alter_user_last_name_max_length','2023-11-19 15:32:08.884616'),(15,'auth','0010_alter_group_name_max_length','2023-11-19 15:32:08.900265'),(16,'auth','0011_update_proxy_permissions','2023-11-19 15:32:08.915890'),(17,'auth','0012_alter_user_first_name_max_length','2023-11-19 15:32:08.947640'),(18,'sessions','0001_initial','2023-11-19 15:32:08.963248'),(19,'dashboard','0001_initial','2023-11-24 03:12:38.064168'),(20,'users','0001_initial','2023-11-27 06:17:45.453134');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0nn86d4m4yia5tldtz1d7dnjbc80y9lh','e30:1r7VhW:jsS2mzihSfsZlpporaxwfDEOrsCAEgUBUCrAQH0RiaA','2023-12-11 07:06:38.280006'),('82npqo65zyd3ourpo610vpl2u52kueab','e30:1r7Vhm:_cz1mdmFU0OU0XROvP3pdVDfTZ4sMnHBfi46GfirQ1o','2023-12-11 07:06:54.157957'),('af77a0vk415imhn1e8o3sn4fjhmqhkhb','e30:1r7VjD:U5ZjoMYC07MloUb7iV4XUD8Js1x2eesTSuel_ysDd_A','2023-12-11 07:08:23.500905'),('b4uhalwa5u2069rghmh90cbw9rg956ut','.eJxVjDsOwyAQBe9CHSHA5pcyvc-AlmUJTiKQjF1FuXuE5CJp38y8Nwtw7CUcnbawJnZlml1-twj4pDpAekC9N46t7tsa-VD4STtfWqLX7XT_Dgr0MmoPWoGaXZ68Mg6s0YRJoyQx-WiylCDcTFZmRCu0SejJKfCYxeSijezzBeKeOBA:1rAjo7:V1hX16g0RfsVT-vgvvw_pu0uldo-44SJjqzD9xG-Ko0','2023-12-20 04:46:47.161681'),('w2srd1by20pv6sdua9nvyv8mfog1qp5h','e30:1r6Mfq:JrNSsys72UR8hwZ6kui6u9pqhnGtJp8oF1OpjnxTBPw','2023-12-08 03:16:10.194913');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_mechanic`
--

DROP TABLE IF EXISTS `game_mechanic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_mechanic` (
  `mechanic_id` int NOT NULL AUTO_INCREMENT,
  `mechanic_name` varchar(50) NOT NULL,
  PRIMARY KEY (`mechanic_id`),
  UNIQUE KEY `mechanic_name` (`mechanic_name`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_mechanic`
--

LOCK TABLES `game_mechanic` WRITE;
/*!40000 ALTER TABLE `game_mechanic` DISABLE KEYS */;
INSERT INTO `game_mechanic` VALUES (3,'Area Control'),(8,'Card Drafting'),(5,'Cooperative Play'),(1,'Deck Building'),(7,'Dice Rolling'),(9,'Hidden Role'),(10,'Pattern Building'),(6,'Set Collection'),(4,'Tile Placement'),(2,'Worker Placement');
/*!40000 ALTER TABLE `game_mechanic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_type`
--

DROP TABLE IF EXISTS `game_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_type`
--

LOCK TABLES `game_type` WRITE;
/*!40000 ALTER TABLE `game_type` DISABLE KEYS */;
INSERT INTO `game_type` VALUES (6,'Adventure Game'),(8,'Cooperative Campaign Game'),(4,'Deck Builder'),(5,'Eurogame'),(2,'Family Game'),(3,'Party Game'),(10,'Role-Playing Game'),(7,'Social Deduction'),(1,'Strategy Board Game'),(9,'Tile-Laying Game');
/*!40000 ALTER TABLE `game_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameitem`
--

DROP TABLE IF EXISTS `gameitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameitem` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `game_name` varchar(255) NOT NULL,
  `published_year` int NOT NULL,
  `min_player` int NOT NULL,
  `max_player` int NOT NULL,
  `min_age` int NOT NULL,
  `min_time` int NOT NULL,
  `max_time` int NOT NULL,
  `is_cooperative` tinyint(1) NOT NULL DEFAULT '0',
  `num_review` int NOT NULL DEFAULT '0',
  `avg_rating` float NOT NULL DEFAULT '0',
  `std_dev_rating` float NOT NULL DEFAULT '0',
  `rated_complexity` float NOT NULL DEFAULT '0',
  `rated_language_dependency` float NOT NULL DEFAULT '0',
  `designer_id` int DEFAULT NULL,
  `publisher_id` int DEFAULT NULL,
  `mechanic_id` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `price` int NOT NULL DEFAULT '15',
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `game_name` (`game_name`),
  KEY `fk_designer` (`designer_id`),
  KEY `fk_publisher` (`publisher_id`),
  KEY `fk_mechanic` (`mechanic_id`),
  KEY `fk_type` (`type_id`),
  CONSTRAINT `fk_designer` FOREIGN KEY (`designer_id`) REFERENCES `designer` (`designer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mechanic` FOREIGN KEY (`mechanic_id`) REFERENCES `game_mechanic` (`mechanic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_type` FOREIGN KEY (`type_id`) REFERENCES `game_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameitem`
--

LOCK TABLES `gameitem` WRITE;
/*!40000 ALTER TABLE `gameitem` DISABLE KEYS */;
INSERT INTO `gameitem` VALUES (1,'Twilight Imperium',1997,3,6,14,240,480,0,0,0,0,0,0,1,1,1,1,100),(2,'Scythe',2016,1,7,14,90,115,0,1,8,0,3.5,4,2,2,2,2,80),(3,'Gloomhaven',2017,1,4,12,60,120,1,2,7,1,11,11,3,3,3,3,140),(4,'Carcassonne',2000,2,5,7,30,45,0,0,0,0,0,0,4,4,4,4,30),(5,'Ticket to Ride',2004,2,5,8,30,60,0,0,0,0,0,0,5,5,5,5,45),(6,'Pandemic',2008,2,4,10,45,60,1,0,0,0,0,0,6,6,6,6,35),(7,'7 Wonders',2010,2,7,10,30,45,0,0,0,0,0,0,7,7,7,7,40),(8,'Codenames',2015,4,8,12,15,30,0,0,0,0,0,0,8,8,8,8,25),(9,'Wingspan',2019,1,5,10,40,70,1,1,1,0,1,1,9,9,9,9,60),(10,'Terraforming Mars',2016,1,5,12,120,180,0,2,9.5,0.5,9.5,9.5,10,10,10,10,55);
/*!40000 ALTER TABLE `gameitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `game_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_item_id`),
  UNIQUE KEY `order_id` (`order_id`,`game_id`),
  KEY `fk_game` (`game_id`),
  CONSTRAINT `fk_game` FOREIGN KEY (`game_id`) REFERENCES `gameitem` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `store_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,3,3),(2,2,3,1),(3,3,3,1),(4,4,3,2),(5,5,3,1);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(255) NOT NULL,
  `num_published` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`publisher_id`),
  UNIQUE KEY `publisher_name` (`publisher_name`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Fantasy Flight Games',0),(2,'Stonemaier Games',0),(3,'Cephalofair Games',0),(4,'Blue Orange Games',0),(5,'Garphill Games',0),(6,'Eagle-Gryphon Games',0),(7,'Days of Wonder',0),(8,'Queen Games',0),(9,'Plan B Games',0),(10,'Rio Grande Games',0);
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `game_id` int NOT NULL,
  `rating` int NOT NULL,
  `text_review` text,
  `complexity_rating` int NOT NULL,
  `language_dependency_rating` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `customer_id` (`customer_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `gameitem` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,5,2,8,'',7,8),(2,5,3,8,'',8,8),(3,5,9,1,'',1,1),(4,5,3,6,'',6,6),(5,5,10,10,'',10,10),(6,5,10,9,'',9,9);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_order`
--

DROP TABLE IF EXISTS `store_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_status` enum('In Progress','Placed','Fulfilled') NOT NULL,
  `date_ordered` date NOT NULL,
  `customer_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  `credit_card_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_order_fk` (`customer_id`),
  KEY `address_fk` (`address_id`),
  KEY `credit_card_fk` (`credit_card_id`),
  CONSTRAINT `address_fk` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `credit_card_fk` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`credit_card_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customer_order_fk` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_order`
--

LOCK TABLES `store_order` WRITE;
/*!40000 ALTER TABLE `store_order` DISABLE KEYS */;
INSERT INTO `store_order` VALUES (1,'Placed','2023-12-05',5,1,1),(2,'Placed','2023-12-06',5,1,1),(3,'Placed','2023-12-06',5,1,1),(4,'Placed','2023-12-06',5,1,2),(5,'In Progress','2023-12-06',5,NULL,NULL);
/*!40000 ALTER TABLE `store_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_profile`
--

DROP TABLE IF EXISTS `users_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_profile_user_id_2112e78d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_profile`
--

LOCK TABLES `users_profile` WRITE;
/*!40000 ALTER TABLE `users_profile` DISABLE KEYS */;
INSERT INTO `users_profile` VALUES (3,'profile_pics/business_cover.jpeg',2),(4,'default.jpg',3),(5,'profile_pics/business_cover_eR9PJ5M.jpeg',4),(6,'profile_pics/business_cover_WIETqpE.jpeg',1),(7,'default.jpg',5);
/*!40000 ALTER TABLE `users_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'game_store_db_ver2'
--
/*!50003 DROP PROCEDURE IF EXISTS `insert_review_and_update_score` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_review_and_update_score`(
    IN p_customer_id INT,
    IN p_game_id INT,
    IN p_rating INT,
    IN p_text_review TEXT,
    IN p_complexity_rating INT,
    IN p_language_dependency_rating INT
)
BEGIN
	DECLARE avg_rating_new FLOAT;
    DECLARE std_dev_rating_new FLOAT;
    -- Insert new review
    INSERT INTO review (
        customer_id, game_id, rating, text_review, complexity_rating, language_dependency_rating
    ) VALUES (
        p_customer_id, p_game_id, p_rating, p_text_review, p_complexity_rating, p_language_dependency_rating
    );
    


	SELECT 
		(avg_rating * num_review + p_rating) / (num_review + 1) INTO avg_rating_new
	FROM gameitem
	WHERE game_id = p_game_id;

	SELECT
	POWER((std_dev_rating * std_dev_rating * num_review + (p_rating - avg_rating) * (p_rating - avg_rating_new)) / (num_review + 1), 0.5) INTO std_dev_rating_new
	FROM gameitem
	WHERE game_id = p_game_id;
    
    UPDATE gameitem
    SET
        avg_rating = avg_rating_new,
        std_dev_rating = std_dev_rating_new,
        rated_complexity = (rated_complexity * (num_review) + p_complexity_rating) / (num_review + 1),
        rated_language_dependency = (rated_language_dependency * (num_review) + p_language_dependency_rating) / (num_review + 1),
		num_review = num_review + 1
    WHERE game_id = p_game_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-06 11:57:11
