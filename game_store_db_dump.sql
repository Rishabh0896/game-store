CREATE DATABASE  IF NOT EXISTS `game_store_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `game_store_db`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: game_store_db
-- ------------------------------------------------------
-- Server version	8.0.34

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
  CONSTRAINT `customer_address_fk` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (4,5,'455','Cambridge St','MA','02141'),(1,5,'469','Cambridge St','MA','');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'customer_group'),(3,'manager_group'),(2,'staff_group');
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
  UNIQUE KEY `unique_group_permission` (`group_id`,`permission_id`),
  KEY `fk_permission_id` (`permission_id`),
  CONSTRAINT `fk_group_id_auth_group` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fk_permission_id_auth_permission` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (2,1,61),(3,1,62),(4,1,63),(1,1,64);
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
  UNIQUE KEY `unique_content_type_codename` (`content_type_id`,`codename`),
  CONSTRAINT `fk_content_type_id_django_content_type` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
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
  UNIQUE KEY `unique_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$AdgjEL68ZHDA12IlXpv1xR$PiNQHxwn/25fNc3QqncAnWS3Sbye8sGT9/ouhzqFqKk=','2023-12-08 01:05:07.077659',1,'admin','','','admin@admin.com',1,1,'2023-11-19 15:33:16.000000'),(3,'pbkdf2_sha256$600000$ZTld5skHgRjNITq97JX8GW$dAV3UUml084GyRG4yiacNTdbBxg0wqN6g0CtYFwfq5k=','2023-12-07 21:43:15.223694',0,'testStaff','','','testStaff@gmail.com',0,1,'2023-11-27 02:13:36.000000'),(5,'pbkdf2_sha256$600000$iJpX40MPKJtHI8qMr0fZ1h$Lse2gI4lNaZORvOYiBzlJe7PllJdfpD8qGz9hE0wsOo=','2023-12-07 01:51:40.736099',0,'testCustomer','','','customer@gmail.com',0,1,'2023-12-06 16:17:20.000000'),(6,'pbkdf2_sha256$600000$yF0C4ZT6QH4ici7l9LMjfH$P/TTPG5QA36iLsPmWI9pTJ+j7ADiojTDg2BUGEmNEGU=','2023-12-07 21:41:04.243943',0,'testManager','','','manager@gmail.com',0,1,'2023-12-06 20:17:53.000000');
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
  UNIQUE KEY `unique_user_group` (`user_id`,`group_id`),
  KEY `fk_group_id_auth_group` (`group_id`),
  CONSTRAINT `fk_group_id_auth_group_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fk_user_id_auth_user_2` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (7,1,1),(8,1,2),(9,1,3),(3,3,2),(2,5,1),(4,6,1),(5,6,2),(6,6,3);
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
  UNIQUE KEY `unique_user_permission` (`user_id`,`permission_id`),
  KEY `fk_permission_id_auth_perm` (`permission_id`),
  CONSTRAINT `fk_permission_id_auth_permission_2` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `fk_user_id_auth_user_3` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  CONSTRAINT `customer_cc_fk` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `credit_card_chk_1` CHECK (((`expiration_month` >= 0) and (`expiration_month` <= 12)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (1,5,'1111111111111111',11,1111,'111'),(2,5,'2222222222222222',11,1111,'111'),(3,5,'1111111113333312',11,1111,'111'),(4,5,'1111111111111113',11,1111,'111');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  KEY `fk_content_type_id_django_content_type` (`content_type_id`),
  KEY `fk_user_id_auth_user` (`user_id`),
  CONSTRAINT `fk_content_type_id_django_content_type_2` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `fk_user_id_auth_user_4` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_check_action_flag` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-11-27 06:20:30.246706','1','testRishabh Profile',1,'[{\"added\": {}}]',16,1),(2,'2023-11-27 06:20:53.217300','2','testStaff Profile',1,'[{\"added\": {}}]',16,1),(3,'2023-11-27 06:30:08.666549','2','testStaff Profile',3,'',16,1),(4,'2023-11-27 06:30:08.668543','1','testRishabh Profile',3,'',16,1),(5,'2023-11-27 06:30:16.181076','3','testRishabh Profile',1,'[{\"added\": {}}]',16,1),(6,'2023-11-27 06:30:25.242568','4','testStaff Profile',1,'[{\"added\": {}}]',16,1),(7,'2023-11-27 07:09:54.726649','6','admin Profile',1,'[{\"added\": {}}]',16,1),(8,'2023-12-06 15:42:35.508044','1','customer_group',1,'[{\"added\": {}}]',3,1),(9,'2023-12-06 15:43:02.770693','1','customer_group',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(10,'2023-12-06 15:54:58.099568','2','testRishabh',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(11,'2023-12-06 16:10:50.253463','2','staff_group',1,'[{\"added\": {}}]',3,1),(12,'2023-12-06 16:10:58.468512','3','manager_group',1,'[{\"added\": {}}]',3,1),(13,'2023-12-06 16:15:38.391727','4','newUser4',3,'',4,1),(14,'2023-12-06 16:15:38.409506','2','testRishabh',3,'',4,1),(15,'2023-12-06 18:04:37.047526','3','testStaff',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(16,'2023-12-06 18:05:27.360383','3','testStaff',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(17,'2023-12-06 18:05:32.394980','5','testCustomer',2,'[]',4,1),(18,'2023-12-06 20:20:39.444130','6','testManager',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(19,'2023-12-06 20:20:47.558960','1','admin',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(20,'2023-12-08 01:05:35.322119','5','testCustomer',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1);
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
  UNIQUE KEY `unique_app_label_model` (`app_label`,`model`)
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-19 15:32:08.225985'),(2,'auth','0001_initial','2023-11-19 15:32:08.507959'),(3,'admin','0001_initial','2023-11-19 15:32:08.586520'),(4,'admin','0002_logentry_remove_auto_add','2023-11-19 15:32:08.602117'),(5,'admin','0003_logentry_add_action_flag_choices','2023-11-19 15:32:08.602117'),(6,'contenttypes','0002_remove_content_type_name','2023-11-19 15:32:08.665070'),(7,'auth','0002_alter_permission_name_max_length','2023-11-19 15:32:08.696330'),(8,'auth','0003_alter_user_email_max_length','2023-11-19 15:32:08.721965'),(9,'auth','0004_alter_user_username_opts','2023-11-19 15:32:08.727997'),(10,'auth','0005_alter_user_last_login_null','2023-11-19 15:32:08.759274'),(11,'auth','0006_require_contenttypes_0002','2023-11-19 15:32:08.759274'),(12,'auth','0007_alter_validators_add_error_messages','2023-11-19 15:32:08.774944'),(13,'auth','0008_alter_user_username_max_length','2023-11-19 15:32:08.822236'),(14,'auth','0009_alter_user_last_name_max_length','2023-11-19 15:32:08.884616'),(15,'auth','0010_alter_group_name_max_length','2023-11-19 15:32:08.900265'),(16,'auth','0011_update_proxy_permissions','2023-11-19 15:32:08.915890'),(17,'auth','0012_alter_user_first_name_max_length','2023-11-19 15:32:08.947640'),(18,'sessions','0001_initial','2023-11-19 15:32:08.963248'),(19,'dashboard','0001_initial','2023-11-24 03:12:38.064168'),(20,'users','0001_initial','2023-11-27 06:17:45.453134'),(21,'crud','0001_initial','2023-12-06 16:02:18.498484'),(22,'crud','0002_alter_gameitem_game_id','2023-12-06 16:02:18.507819'),(23,'crud','0003_designer_gamemechanic_gametype_publisher_and_more','2023-12-06 16:02:18.512250'),(24,'dashboard','0002_address_creditcard_orderitem_storeorder_and_more','2023-12-06 16:02:18.517238');
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
  KEY `index_expire_date` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_mechanic`
--

LOCK TABLES `game_mechanic` WRITE;
/*!40000 ALTER TABLE `game_mechanic` DISABLE KEYS */;
INSERT INTO `game_mechanic` VALUES (3,'Area Control'),(8,'Card Drafting'),(5,'Cooperative Play'),(1,'Deck Building'),(7,'Dice Rolling'),(9,'Hidden Role'),(43,'Miniature'),(10,'Pattern Building'),(6,'Set Collection'),(4,'Tile Placement'),(2,'Worker Placement');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `price` int DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `game_name` (`game_name`),
  KEY `fk_designer` (`designer_id`),
  KEY `fk_publisher` (`publisher_id`),
  KEY `fk_mechanic` (`mechanic_id`),
  KEY `fk_type` (`type_id`),
  CONSTRAINT `fk_designer` FOREIGN KEY (`designer_id`) REFERENCES `designer` (`designer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mechanic` FOREIGN KEY (`mechanic_id`) REFERENCES `game_mechanic` (`mechanic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_type` FOREIGN KEY (`type_id`) REFERENCES `game_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `complex_range` CHECK (((`rated_complexity` >= 0) and (`rated_complexity` <= 10))),
  CONSTRAINT `language_dependency_rating` CHECK (((`rated_language_dependency` >= 0) and (`rated_language_dependency` <= 10))),
  CONSTRAINT `rating_range` CHECK (((`avg_rating` >= 0) and (`avg_rating` <= 10))),
  CONSTRAINT `std_dev_rating` CHECK (((`std_dev_rating` >= 0) and (`std_dev_rating` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameitem`
--

LOCK TABLES `gameitem` WRITE;
/*!40000 ALTER TABLE `gameitem` DISABLE KEYS */;
INSERT INTO `gameitem` VALUES (1,'Twilight Imperium',1997,3,6,14,240,480,0,0,0,0,0,0,2,1,1,1,100),(2,'Scythe',2016,1,7,14,90,115,0,1,8,0,3.5,4,2,2,2,2,80),(3,'Gloomhaven',2017,1,4,12,60,120,1,2,7,1,9,9,3,3,3,3,140),(4,'Carcassonne',2000,2,5,7,30,45,0,0,0,0,0,0,4,4,4,4,30),(5,'Ticket to Ride',2004,2,5,8,30,60,0,0,0,0,0,0,5,5,5,5,45),(6,'Pandemic',2008,2,4,10,45,60,1,0,0,0,0,0,6,6,6,6,35),(7,'7 Wonders',2010,2,7,10,30,45,0,0,0,0,0,0,7,7,7,7,40),(8,'Codenames',2015,4,8,12,15,30,0,0,0,0,0,0,8,8,8,8,25),(9,'Wingspan',2019,1,5,10,40,70,1,2,5.5,3.20156,4,2.5,9,9,9,9,60),(10,'Terraforming Mars',2016,1,5,12,120,180,0,1,10,0,10,10,10,10,10,10,55);
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
  CONSTRAINT `fk_game` FOREIGN KEY (`game_id`) REFERENCES `gameitem` (`game_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `store_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,3,3),(2,2,3,1),(3,3,3,1),(4,4,3,2),(5,5,3,1),(10,10,8,2);
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
  PRIMARY KEY (`publisher_id`),
  UNIQUE KEY `publisher_name` (`publisher_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (4,'Blue Orange Games'),(3,'Cephalofair Games'),(7,'Days of Wonder'),(6,'Eagle-Gryphon Games'),(1,'Fantasy Flight Games'),(5,'Garphill Games'),(9,'Plan B Games'),(8,'Queen Games'),(10,'Rio Grande Games'),(2,'Stonemaier Games');
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
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `gameitem` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_complex_range` CHECK (((`complexity_rating` >= 0) and (`complexity_rating` <= 10))),
  CONSTRAINT `review_language_dependency_rating` CHECK (((`language_dependency_rating` >= 0) and (`language_dependency_rating` <= 10))),
  CONSTRAINT `review_review_range` CHECK (((`rating` >= 0) and (`rating` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,5,2,8,'',7,8),(2,5,3,8,'Great!',8,8),(3,5,9,1,'Good!',1,1),(4,5,3,6,'Enjoyed playing this!',6,6),(5,5,10,10,'Good Game',10,10),(7,6,9,6,'Amazing game!!!',7,4);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_review_update` AFTER UPDATE ON `review` FOR EACH ROW BEGIN
    DECLARE avg_rating_new FLOAT;
    DECLARE std_dev_rating_new FLOAT;
    -- Update gameitem scores for updated review
    UPDATE gameitem 
    SET 
        avg_rating = (avg_rating * num_review - OLD.rating + NEW.rating) / num_review,
        rated_complexity = (rated_complexity * num_review - OLD.complexity_rating + NEW.complexity_rating) / num_review,
        rated_language_dependency = (rated_language_dependency * num_review - OLD.language_dependency_rating + NEW.language_dependency_rating) / num_review
    WHERE
        game_id = NEW.game_id;
    
    SELECT 
        avg_rating
    INTO avg_rating_new
    FROM
        gameitem
    WHERE
        game_id = NEW.game_id;
    
    SELECT 
        POW(SUM(POWER(rating - avg_rating_new, 2))/ COUNT(*), 0.5) 
    INTO std_dev_rating_new
    FROM
        review
    WHERE
        game_id = NEW.game_id
    GROUP BY game_id;
    
    UPDATE gameitem
    SET std_dev_rating = std_dev_rating_new
    WHERE game_id = NEW.game_id;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_review_delete` AFTER DELETE ON `review` FOR EACH ROW BEGIN
    DECLARE avg_rating_new FLOAT;
    DECLARE std_dev_rating_new FLOAT;
    -- Update gameitem scores for deleted review
    UPDATE gameitem
    SET
        avg_rating = CASE WHEN num_review > 1 THEN (avg_rating * num_review - OLD.rating) / (num_review - 1) ELSE 0 END,
        rated_complexity = CASE WHEN num_review > 1 THEN (rated_complexity * num_review - OLD.complexity_rating) / (num_review - 1) ELSE 0 END,
        rated_language_dependency = CASE WHEN num_review > 1 THEN (rated_language_dependency * num_review - OLD.language_dependency_rating) / (num_review - 1) ELSE 0 END,
        num_review = GREATEST(num_review - 1, 0)
    WHERE game_id = OLD.game_id;
    
    SELECT 
        avg_rating
    INTO avg_rating_new FROM
        gameitem
    WHERE
        game_id = OLD.game_id;
    
    SELECT 
        POW(SUM(POWER(rating - avg_rating_new, 2)) / COUNT(*),
            0.5)
    INTO std_dev_rating_new FROM
        review
    WHERE
        game_id = OLD.game_id
    GROUP BY game_id;
    
    UPDATE gameitem 
    SET 
        std_dev_rating = IFNULL(std_dev_rating_new, 0)
    WHERE
        game_id = OLD.game_id;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  `address_id` int NOT NULL,
  `credit_card_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_order_fk` (`customer_id`),
  KEY `address_fk` (`address_id`),
  KEY `credit_card_fk` (`credit_card_id`),
  CONSTRAINT `address_fk` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `credit_card_fk` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`credit_card_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `customer_order_fk` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_order`
--

LOCK TABLES `store_order` WRITE;
/*!40000 ALTER TABLE `store_order` DISABLE KEYS */;
INSERT INTO `store_order` VALUES (1,'Placed','2023-12-05',5,1,1),(2,'Placed','2023-12-06',5,1,1),(3,'Placed','2023-12-06',5,1,1),(4,'Placed','2023-12-06',5,1,2),(5,'In Progress','2023-12-06',5,1,2),(10,'Placed','2023-12-07',5,4,4);
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
  UNIQUE KEY `unique_user_id` (`user_id`),
  CONSTRAINT `fk_user_id_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_profile`
--

LOCK TABLES `users_profile` WRITE;
/*!40000 ALTER TABLE `users_profile` DISABLE KEYS */;
INSERT INTO `users_profile` VALUES (4,'default.jpg',3),(6,'profile_pics/business_cover_WIETqpE.jpeg',1),(7,'default.jpg',5),(8,'default.jpg',6);
/*!40000 ALTER TABLE `users_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'game_store_db'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_total_revenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_total_revenue`() RETURNS float
    READS SQL DATA
BEGIN
    DECLARE total_revenue FLOAT;
    
    SELECT SUM(o.quantity * g.price)
    INTO total_revenue
    FROM store_order s
    JOIN order_item o ON s.order_id = o.order_item_id
    JOIN gameitem g ON o.game_id = g.game_id;
    
    RETURN total_revenue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calculate_game_revenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_game_revenue`()
BEGIN
    SELECT 
        g.game_name,
        COALESCE(SUM(quantity * g.price), 0) AS total_revenue
    FROM
        gameitem g
        LEFT JOIN
        order_item o ON g.game_id = o.game_id
        LEFT JOIN
        store_order s ON o.order_id = s.order_id
    GROUP BY g.game_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_most_grossing_designer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_most_grossing_designer`()
BEGIN
    SELECT 
        designer_name, SUM(o.quantity * g.price) AS sum_designer
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        designer d ON g.designer_id = d.designer_id
    GROUP BY d.designer_name
    ORDER BY sum_designer DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_most_grossing_game_mechanic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_most_grossing_game_mechanic`()
BEGIN
    SELECT 
        mechanic_name, SUM(o.quantity * g.price) AS sum_mechanic
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        game_mechanic gm ON g.mechanic_id = gm.mechanic_id
    GROUP BY gm.mechanic_name
    ORDER BY sum_mechanic DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_most_grossing_game_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_most_grossing_game_type`()
BEGIN
    SELECT 
        type_name, SUM(o.quantity * g.price) AS sum_type
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        game_type gt ON g.type_id = gt.type_id
    GROUP BY gt.type_name
    ORDER BY sum_type DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_most_grossing_publisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_most_grossing_publisher`()
BEGIN
    SELECT 
        publisher_name, SUM(o.quantity * g.price) AS sum_publisher
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        publisher p ON g.publisher_id = p.publisher_id
    GROUP BY p.publisher_name
    ORDER BY sum_publisher DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_review_and_update_score` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
    
    UPDATE gameitem
    SET
        avg_rating = (avg_rating * num_review + p_rating) / (num_review + 1),
        std_dev_rating = POWER((std_dev_rating * std_dev_rating * num_review + (p_rating - avg_rating) * (p_rating - avg_rating_new)) / (num_review + 1), 0.5),
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

-- Dump completed on 2023-12-07 20:06:39
