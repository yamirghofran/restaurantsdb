-- MySQL dump 10.13  Distrib 9.0.1, for macos14.4 (arm64)
--
-- Host: localhost    Database: restaurantdb
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add dietary restriction',7,'add_dietaryrestriction'),(26,'Can change dietary restriction',7,'change_dietaryrestriction'),(27,'Can delete dietary restriction',7,'delete_dietaryrestriction'),(28,'Can view dietary restriction',7,'view_dietaryrestriction'),(29,'Can add menu section',8,'add_menusection'),(30,'Can change menu section',8,'change_menusection'),(31,'Can delete menu section',8,'delete_menusection'),(32,'Can view menu section',8,'view_menusection'),(33,'Can add restaurant',9,'add_restaurant'),(34,'Can change restaurant',9,'change_restaurant'),(35,'Can delete restaurant',9,'delete_restaurant'),(36,'Can view restaurant',9,'view_restaurant'),(37,'Can add menu version',10,'add_menuversion'),(38,'Can change menu version',10,'change_menuversion'),(39,'Can delete menu version',10,'delete_menuversion'),(40,'Can view menu version',10,'view_menuversion'),(41,'Can add processing log',11,'add_processinglog'),(42,'Can change processing log',11,'change_processinglog'),(43,'Can delete processing log',11,'delete_processinglog'),(44,'Can view processing log',11,'view_processinglog'),(45,'Can add search index',12,'add_searchindex'),(46,'Can change search index',12,'change_searchindex'),(47,'Can delete search index',12,'delete_searchindex'),(48,'Can view search index',12,'view_searchindex'),(49,'Can add menu item',13,'add_menuitem'),(50,'Can change menu item',13,'change_menuitem'),(51,'Can delete menu item',13,'delete_menuitem'),(52,'Can view menu item',13,'view_menuitem'),(53,'Can add menu statistics',14,'add_menustatistics'),(54,'Can change menu statistics',14,'change_menustatistics'),(55,'Can delete menu statistics',14,'delete_menustatistics'),(56,'Can view menu statistics',14,'view_menustatistics');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'menu','dietaryrestriction'),(13,'menu','menuitem'),(8,'menu','menusection'),(14,'menu','menustatistics'),(10,'menu','menuversion'),(11,'menu','processinglog'),(9,'menu','restaurant'),(12,'menu','searchindex'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-11-24 16:12:30.853518'),(2,'auth','0001_initial','2024-11-24 16:12:30.967959'),(3,'admin','0001_initial','2024-11-24 16:12:30.993240'),(4,'admin','0002_logentry_remove_auto_add','2024-11-24 16:12:30.996143'),(5,'admin','0003_logentry_add_action_flag_choices','2024-11-24 16:12:30.998391'),(6,'contenttypes','0002_remove_content_type_name','2024-11-24 16:12:31.014764'),(7,'auth','0002_alter_permission_name_max_length','2024-11-24 16:12:31.028049'),(8,'auth','0003_alter_user_email_max_length','2024-11-24 16:12:31.037715'),(9,'auth','0004_alter_user_username_opts','2024-11-24 16:12:31.041080'),(10,'auth','0005_alter_user_last_login_null','2024-11-24 16:12:31.052762'),(11,'auth','0006_require_contenttypes_0002','2024-11-24 16:12:31.053674'),(12,'auth','0007_alter_validators_add_error_messages','2024-11-24 16:12:31.056430'),(13,'auth','0008_alter_user_username_max_length','2024-11-24 16:12:31.070792'),(14,'auth','0009_alter_user_last_name_max_length','2024-11-24 16:12:31.085256'),(15,'auth','0010_alter_group_name_max_length','2024-11-24 16:12:31.090943'),(16,'auth','0011_update_proxy_permissions','2024-11-24 16:12:31.094009'),(17,'auth','0012_alter_user_first_name_max_length','2024-11-24 16:12:31.107105'),(18,'menu','0001_initial','2024-11-24 16:12:31.273193'),(19,'sessions','0001_initial','2024-11-24 16:12:31.280016'),(20,'menu','0002_remove_menuitem_menu_menuit_is_avai_3a30d9_idx_and_more','2024-11-27 16:08:56.494317'),(21,'menu','0003_alter_restaurant_phone','2024-11-27 16:13:23.415751'),(22,'menu','0004_alter_menustatistics_options_and_more','2024-12-02 11:00:05.826755');
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
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_dietaryrestriction`
--

DROP TABLE IF EXISTS `menu_dietaryrestriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_dietaryrestriction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` longtext,
  `icon_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_dietaryrestriction`
--

LOCK TABLES `menu_dietaryrestriction` WRITE;
/*!40000 ALTER TABLE `menu_dietaryrestriction` DISABLE KEYS */;
INSERT INTO `menu_dietaryrestriction` VALUES (40,'Vegetarian',NULL,NULL),(41,'Vegan',NULL,NULL),(42,'Seafood',NULL,NULL),(43,'gluten',NULL,NULL),(44,'soy',NULL,NULL),(45,'dairy',NULL,NULL),(46,'shellfish',NULL,NULL),(47,'gluten-free',NULL,NULL),(48,'fish',NULL,NULL),(49,'alcohol',NULL,NULL),(50,'gluten_free',NULL,NULL),(51,'egg',NULL,NULL),(52,'nuts',NULL,NULL);
/*!40000 ALTER TABLE `menu_dietaryrestriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_menuitem`
--

DROP TABLE IF EXISTS `menu_menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_menuitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `calories` int DEFAULT NULL,
  `spice_level` smallint DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL,
  `display_order` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `section_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_menuit_section_36b4a4_idx` (`section_id`,`display_order`),
  KEY `menu_menuit_name_138666_idx` (`name`),
  KEY `menu_menuit_price_7d229e_idx` (`price`),
  FULLTEXT KEY `menu_item_search` (`name`,`description`),
  CONSTRAINT `menu_menuitem_section_id_0205fe5a_fk_menu_menusection_id` FOREIGN KEY (`section_id`) REFERENCES `menu_menusection` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_menuitem`
--

LOCK TABLES `menu_menuitem` WRITE;
/*!40000 ALTER TABLE `menu_menuitem` DISABLE KEYS */;
INSERT INTO `menu_menuitem` VALUES (329,'Cold Mezze V','Hummus, muhammara, baba ghanoush & moutabal served with pide bread',1500.00,'KES',450,1,1,1,'2024-11-27 17:41:29.766165',57),(330,'Samosa per piece','Crab, Beef, Feta Cheese V, Tuna',400.00,'KES',150,2,1,2,'2024-11-27 17:41:29.768878',57),(331,'Calamari Rings','Deep-fried Calamari with aioli',1300.00,'KES',500,1,1,3,'2024-11-27 17:41:29.770629',57),(332,'Waffle Truffle Fries V','Served with a honey aioli and topped with freshly grated Parmesan',1200.00,'KES',550,1,1,4,'2024-11-27 17:41:29.773403',57),(333,'Raw Vegetarian Spring Rolls','Spring rolls stuffed with rice noodles, mixed vegetables, mint and served with a Vietnamese dip with fish sauce',1200.00,'KES',300,1,1,5,'2024-11-27 17:41:29.774611',57),(334,'TNT Prawns','Coated battered prawns with sweet and spicy dynamite sauce',1800.00,'KES',400,3,1,6,'2024-11-27 17:41:29.780783',57),(335,'Turkey Dumplings','Steamed and seared Korean-styled dumplings served with Seoul tangy soy dipping sauce',1800.00,'KES',350,2,1,7,'2024-11-27 17:41:29.781117',57),(336,'Avocado & Ahi Tuna Korean Tartare','Brunoised leeks, crunchy capers, sesame seeds marinated with honey, soy & sesame',1800.00,'KES',200,1,1,8,'2024-11-27 17:41:29.781418',57),(337,'Seafood Soup - Zuppetta di Pesce','Sicilian-styled seafood soup, served with crostone garlic bread',1600.00,'KES',500,2,1,1,'2024-11-27 17:41:29.782057',58),(338,'Punjabi Dhal Makhani V','Traditional Indian lentil soup with chapati, burnt onion and garlic chips',1400.00,'KES',400,2,1,2,'2024-11-27 17:41:29.783924',58),(339,'Nomad Caesar’s Salad','Chicken flakes, bacon bits, anchovies, parmesan, crispy lettuce, croutons and Caesar dressing',1400.00,'KES',350,1,1,1,'2024-11-27 17:41:29.785178',59),(340,'Poke Bowl','Chunks of marinated tuna and kingfish tossed over rice and packed with avocado, pineapple, cucumber, red cabbage and carrot, topped with sesame seeds, spicy & wasabi aioli and accompanied by an umami-packed ponzu sauce',2000.00,'KES',400,2,1,2,'2024-11-27 17:41:29.785466',59),(341,'Grilled Halloumi & Quinoa Salad V','Cucumber, tomatoes, croutons and golden quinoa tossed in a lemon vinaigrette',1300.00,'KES',300,1,1,3,'2024-11-27 17:41:29.785752',59),(342,'Octopus Salad','Olives, cherry tomato, grilled zucchini, string beans, boiled potatoes, fresh parsley, tossed lemon juice and Italian EVO oil',1800.00,'KES',350,1,1,4,'2024-11-27 17:41:29.786755',59),(343,'Avocado Salad V','Avocado, tomato, red onion, coriander, lime juice',1700.00,'KES',250,1,1,5,'2024-11-27 17:41:29.787044',59),(344,'Burrata V','Locally sourced burrata cheese served with cherry tomato and basil pesto',2600.00,'KES',400,1,1,6,'2024-11-27 17:41:29.788692',59),(345,'Mediterranean Citrus Salad V','Rocket, cherry tomato, balsamic dressing with citrus segments of lemon, orange and grapefruit topped with cashew nuts and crumbled feta',1500.00,'KES',300,1,1,7,'2024-11-27 17:41:29.789596',59),(346,'Chips','Crispy fried potato chips',700.00,'KES',300,1,1,1,'2024-11-27 17:41:29.790783',60),(347,'Masala Chips','Spicy coated chips',700.00,'KES',350,3,1,2,'2024-11-27 17:41:29.792796',60),(348,'Mashed Potatoes','Creamy mashed potatoes',700.00,'KES',250,1,1,3,'2024-11-27 17:41:29.794443',60),(349,'Roasted Potato','Seasoned roasted potatoes',700.00,'KES',200,1,1,4,'2024-11-27 17:41:29.795277',60),(350,'Kachumbari Salad','Fresh salad of tomatoes, onions, and chili',700.00,'KES',150,2,1,5,'2024-11-27 17:41:29.796641',60),(351,'Spinach','Sauteed with coconut cream',700.00,'KES',200,1,1,6,'2024-11-27 17:41:29.799255',60),(352,'Rice','White or with coconut cream',700.00,'KES',200,1,1,7,'2024-11-27 17:41:29.800182',60),(353,'Basted Wings','Slow roasted chicken wings with honey and soy sauce.',9.00,'EUR',600,1,1,1,'2024-11-28 08:58:19.589312',61),(354,'Grilled Potatoes with Spicy Sauce (A.K.A. Patatas Bravas)','Baked potato wedges with Canarian style spicy sauce.',8.00,'EUR',450,3,1,2,'2024-11-28 08:58:19.601138',61),(355,'Russian Salad with “Regñas”','A traditional sweet potato recipe, which gives a small candy touch.',8.00,'EUR',350,0,1,3,'2024-11-28 08:58:19.602982',61),(356,'Braised Ham & Cheddar Cheese Quesadilla','Grilled wheat quesadilla with spicy mayo & pico de gallo.',10.00,'EUR',700,2,1,4,'2024-11-28 08:58:19.604786',61),(357,'Prawn Gyozas with Sweet and Sour Vegetables (5 units)','Steamed Chinese pie based on sweet chilli and Korean soybean.',10.00,'EUR',300,2,1,5,'2024-11-28 08:58:19.607069',61),(358,'Confit Leek Salad','With tomato pesto, grapes and seeds.',11.00,'EUR',250,0,1,6,'2024-11-28 08:58:19.609652',61),(359,'Pulled Pork Tacos','With pico de gallo & jalapeño.',12.00,'EUR',600,3,1,7,'2024-11-28 08:58:19.611813',61),(360,'Onion & Beer Meatballs','Mix of meats cooked in pepper, onions and the best local beer.',12.00,'EUR',550,2,1,8,'2024-11-28 08:58:19.613157',61),(361,'Ricotta Ravioli','With a soft cream of spinach & crispy caramel touch.',11.50,'EUR',800,0,1,9,'2024-11-28 08:58:19.615341',61),(362,'Minicachopos (2 units)','Breaded veal steaks stuffed with ham and cheese. Finished with Iberian veal.',13.00,'EUR',850,1,1,10,'2024-11-28 08:58:19.617229',61),(363,'Salmon Tiradito','With aji, passion fruit and pumpkin spaghetti.',14.00,'EUR',350,2,1,11,'2024-11-28 08:58:19.618876',61),(364,'Brownie with Vanilla Ice Cream','Rich chocolate brownie served with creamy vanilla ice cream.',6.00,'EUR',500,0,1,1,'2024-11-28 08:58:19.620572',62),(365,'Cheesecake','Creamy cheesecake with a buttery biscuit base.',6.00,'EUR',400,0,1,2,'2024-11-28 08:58:19.621885',62),(366,'Soft Drinks','Coca-Cola, Sprite, Fanta, mineral water & sparkling water.',3.50,'EUR',150,0,1,1,'2024-11-28 08:58:19.623625',63),(367,'Homemade Lemonade','Freshly made lemonade.',4.00,'EUR',120,0,1,2,'2024-11-28 08:58:19.624160',63),(368,'Juices','Choice of pineapple, peach or orange.',3.30,'EUR',100,0,1,3,'2024-11-28 08:58:19.624632',63),(369,'Tomato Juice','Freshly squeezed tomato juice.',3.50,'EUR',70,0,1,4,'2024-11-28 08:58:19.625106',63),(370,'Double Draft Beer','Cold, refreshing draught beer.',3.50,'EUR',180,0,1,5,'2024-11-28 08:58:19.625559',63),(371,'33cl. Mahou’s Beer Bottle','Popular local bottled beer.',3.75,'EUR',150,0,1,6,'2024-11-28 08:58:19.626630',63),(372,'33cl. Coronita','Bottled beer with a light, crisp taste.',4.00,'EUR',130,0,1,7,'2024-11-28 08:58:19.627823',63),(373,'Tercio La Chouffe 8°','Pale Ale Rubia Belga.',5.00,'EUR',210,0,1,8,'2024-11-28 08:58:19.628846',63),(374,'Tercio Duvel 8.5°','Ale Fuerte Dorada Belga.',5.00,'EUR',240,0,1,9,'2024-11-28 08:58:19.629671',63),(375,'Tinto de Verano','Refreshing drink similar to sangria.',4.00,'EUR',100,0,1,10,'2024-11-28 08:58:19.630510',63),(376,'Local Vermouth','Aromatic fortified wine.',3.00,'EUR',170,0,1,11,'2024-11-28 08:58:19.631446',63),(377,'Protos Red Wine','Ribera del Duero.',3.40,'EUR',125,0,1,12,'2024-11-28 08:58:19.632314',63),(378,'Biberio Red Wine','Ribera del Duero.',3.30,'EUR',125,0,1,13,'2024-11-28 08:58:19.633166',63),(379,'Ramón Bilbao Red Wine','Rioja.',3.50,'EUR',125,0,1,14,'2024-11-28 08:58:19.633994',63),(380,'Carro Blanco with Wine','Verdejo.',3.50,'EUR',80,0,1,15,'2024-11-28 08:58:19.634802',63),(381,'Camiño do Rei with Wine','Rías Baixas.',3.50,'EUR',80,0,1,16,'2024-11-28 08:58:19.635614',63),(382,'Beef Eater Gin','Classic gin.',9.00,'EUR',70,0,1,17,'2024-11-28 08:58:19.636413',63),(383,'Premium Gin','Martin Miller\'s, Hendrix, Bombay Sapphire, Nordés & Brockman’s.',12.00,'EUR',70,0,1,18,'2024-11-28 08:58:19.637222',63),(384,'Ron','Brugal, Barcelo & Santa Teresa.',9.00,'EUR',90,0,1,19,'2024-11-28 08:58:19.638023',63),(385,'Ron Premium','Legendario & Havana 7.',10.00,'EUR',90,0,1,20,'2024-11-28 08:58:19.638813',63),(386,'Whisky','Johnnie Walker, DYC (8 years) & White Label.',9.00,'EUR',105,0,1,21,'2024-11-28 08:58:19.639595',63),(387,'Bourbon','Jack Daniel’s.',10.00,'EUR',110,0,1,22,'2024-11-28 08:58:19.640387',63),(388,'Vodka','Absolut & Stolichnaya.',9.00,'EUR',70,0,1,23,'2024-11-28 08:58:19.641200',63),(389,'Shots','Various shots available.',3.50,'EUR',50,0,1,24,'2024-11-28 08:58:19.641992',63),(390,'Non-Alcoholic Mojito','Refreshing mint and lime drink without alcohol.',6.00,'EUR',90,0,1,25,'2024-11-28 08:58:19.642792',63),(391,'Mojito','Classic cocktail with rum, mint, and lime.',10.00,'EUR',200,0,1,26,'2024-11-28 08:58:19.643271',63),(392,'Caipirinha','Brazil\'s national cocktail, made with cachaça, sugar, and lime.',10.00,'EUR',200,0,1,27,'2024-11-28 08:58:19.644075',63),(393,'Caipiroska','A twist on the Caipirinha with vodka instead of cachaça.',10.00,'EUR',200,0,1,28,'2024-11-28 08:58:19.644888',63),(394,'Bloody Mary','Classic cocktail of vodka, tomato juice, and spices.',10.00,'EUR',150,0,1,29,'2024-11-28 08:58:19.645693',63),(395,'Baileys','Creamy, chocolatey liqueur.',5.00,'EUR',150,0,1,30,'2024-11-28 08:58:19.646514',63),(396,'Martini Rosso & Bianco','Classic Italian vermouth.',4.00,'EUR',75,0,1,31,'2024-11-28 08:58:19.647304',63),(397,'Herbs Liqueur','Traditional herbal liqueur.',4.00,'EUR',100,0,1,32,'2024-11-28 08:58:19.648170',63),(398,'Patxarán','Basque sloe-flavored liqueur.',4.00,'EUR',110,0,1,33,'2024-11-28 08:58:19.649181',63),(399,'Pane all\'Aglio','Garlic Bread',2.80,'EUR',200,0,1,1,'2024-11-28 09:01:44.861734',64),(400,'Focaccia','Tuscany Pizza Bread',2.80,'EUR',250,0,1,2,'2024-11-28 09:01:44.867602',64),(401,'Pane all\'Aglio con Mozzarella','Garlic Bread with Mozzarella',3.80,'EUR',300,0,1,3,'2024-11-28 09:01:44.875447',64),(402,'Bruschetta Fiorentina','Garlic Bread with Basil, Onion, Tomato and Oregano',3.80,'EUR',280,0,1,4,'2024-11-28 09:01:44.880417',64),(403,'Carpaccio di Salmone','Lightly sliced Salmon with Toasts',9.80,'EUR',320,0,1,1,'2024-11-28 09:01:44.886246',65),(404,'Carpaccio di Manzo','Fillet Carpaccio',9.80,'EUR',340,0,1,2,'2024-11-28 09:01:44.892609',65),(405,'Bresala, Rucola e Grana Padano','Smoked Veal, Rocket and Parmeggian Slices',9.00,'EUR',280,0,1,3,'2024-11-28 09:01:44.898086',65),(406,'Cocktail di Gamberetti','Prawn Cocktail',9.00,'EUR',250,0,1,4,'2024-11-28 09:01:44.901929',65),(407,'Misto di Salumeria','Smoked Veal, Smoked Ham and Coppa',9.00,'EUR',360,0,1,5,'2024-11-28 09:01:44.906663',65),(408,'Funghetti all\'Gorgonzola','Mushrooms with Gorgonzola Sauce',8.50,'EUR',320,0,1,6,'2024-11-28 09:01:44.910423',65),(409,'Verdure Grigliate','Fresh Grilled Vegetables',9.00,'EUR',220,0,1,7,'2024-11-28 09:01:44.915062',65),(410,'Minestrone','Italian Vegetable Soup',6.50,'EUR',180,0,1,1,'2024-11-28 09:01:44.921152',66),(411,'Crema alla Aragosta','Lobster Bisque',9.00,'EUR',250,0,1,2,'2024-11-28 09:01:44.925359',66),(412,'Insalata Caprese','Tomato, Mozzarella and Basil',8.50,'EUR',320,0,1,1,'2024-11-28 09:01:44.929366',67),(413,'Insalata Mista','Mixed Salad',5.80,'EUR',150,0,1,2,'2024-11-28 09:01:44.935226',67),(414,'Insalata Frutti di Mare','Mixed Seafood Salad',13.50,'EUR',420,0,1,3,'2024-11-28 09:01:44.946885',67),(415,'Insalata Niçoise','Mixed Salad, Tuna, Green Beans, Egg, Anchovies, Olives, Artichokes and Yogurt Sauce',13.50,'EUR',400,0,1,4,'2024-11-28 09:01:44.950973',67),(416,'Spaghetti all Ragù','Spaghetti with Bolognese',9.50,'EUR',450,0,1,1,'2024-11-28 09:01:44.957262',68),(417,'Farfalle di Salmone e Zucchini','Salmon and Zucchini with Tomato Sauce',14.00,'EUR',500,0,1,2,'2024-11-28 09:01:44.960148',68),(418,'Tagliolini Bianco alla Busara','Tomato, Langoustine, Prawns and Chilli',19.00,'EUR',600,2,1,3,'2024-11-28 09:01:44.966875',68),(419,'Penne Matriciana','Pancetta (Italian Bacon), Onions and Tomato Sauce',9.50,'EUR',420,1,1,4,'2024-11-28 09:01:44.974551',68),(420,'Tagliolini al Pesto Genovese','With Pesto Sauce',9.90,'EUR',380,0,1,5,'2024-11-28 09:01:44.975581',68),(421,'Tagliolini Nero con Gamberone alla Salsa Mediterranea','King Prawn with Black Tagliolini in Mediterranean Sauce',27.00,'EUR',620,1,1,6,'2024-11-28 09:01:44.977348',68),(422,'Tortelini Ricota Spinaci','Ricotta and Spinach Tortelini',12.50,'EUR',350,0,1,1,'2024-11-28 09:01:44.979823',69),(423,'Ravioli Funghi Porcini','Ravioli with Porcini Mushrooms',16.00,'EUR',400,0,1,2,'2024-11-28 09:01:44.981505',69),(424,'Torteloni con Salmone e Aneto','Pasta stuffed with Salmon and Fennel with Pesto Rosso Sauce',16.00,'EUR',450,0,1,3,'2024-11-28 09:01:44.983129',69),(425,'Lasagna Clássica','Bolognese Lasagna with Bechamel Sauce',12.50,'EUR',550,0,1,1,'2024-11-28 09:01:44.984938',70),(426,'Risotto con Funghi Porcini','Porcini Mushrooms Risotto',21.00,'EUR',480,0,1,1,'2024-11-28 09:01:44.987749',71),(427,'Risotto con Capesante','Scallops Risotto with Safron',26.00,'EUR',520,0,1,2,'2024-11-28 09:01:44.993726',71),(428,'Risotto alla Pescatora','Seafood Risotto',22.00,'EUR',560,0,1,3,'2024-11-28 09:01:44.997862',71),(429,'Risotto al Tartufo Nero','Black Truffle Risotto',25.00,'EUR',490,0,1,4,'2024-11-28 09:01:45.002852',71),(430,'Gamberi Tigre con Risotto Coriandolo','Tiger Prawns with Coriander Risotto',38.00,'EUR',680,0,1,1,'2024-11-28 09:01:45.008071',72),(431,'Salmone all\'Limo','Salmon with Lemon Sauce served with Mashed Potatoes',16.00,'EUR',580,0,1,2,'2024-11-28 09:01:45.012602',72),(432,'Sogliola Graticola','Plaice Fillet with Olives, Capers and Fiorentina Style Tomatoes Gratined with Mozzarella served with Boiled Potatoes and Vegetables',18.00,'EUR',620,0,1,3,'2024-11-28 09:01:45.016683',72),(433,'Pollo Martini','Chicken Breast with Martini Sauce',14.50,'EUR',500,0,1,1,'2024-11-28 09:01:45.023302',73),(434,'Filetto alla Griglia','Grilled Prime Fillet Steak',24.00,'EUR',700,0,1,2,'2024-11-28 09:01:45.025522',73),(435,'Filetto all Gorgonzola','Grilled Prime Fillet Steak with Gorgonzola Sauce',26.00,'EUR',720,0,1,3,'2024-11-28 09:01:45.027465',73),(436,'Carré di Agnello','Lamb Crown with Pistachio Mustard Crust served with Mashed Potatoes',28.00,'EUR',780,0,1,4,'2024-11-28 09:01:45.030689',73),(437,'Petto d’Anatra Arrosto','Roasted Duck Breast Belmondo Style served with Mashed Potatoes',22.00,'EUR',640,0,1,5,'2024-11-28 09:01:45.033377',73),(438,'Filetto all Peppe Verde','Grilled Prime Fillet Steak with Green Pepper Sauce',26.00,'EUR',710,1,1,6,'2024-11-28 09:01:45.036143',73),(439,'Filetto con Funghi Porcini','Grilled Prime Fillet Steak with Porcini Mushroom Sauce',28.00,'EUR',750,0,1,7,'2024-11-28 09:01:45.038891',73),(440,'Scallopine di Vitello alla Milanesa','Breaded Veal Fillet served with spaghetti Aglio e Olio',18.00,'EUR',680,0,1,8,'2024-11-28 09:01:45.041643',73),(441,'Saltimbocca alla Romana','Veal Fillet with Parma Smoked Ham and Sage',22.00,'EUR',620,0,1,9,'2024-11-28 09:01:45.046525',73),(442,'Aguacate con tartar de atún','Avocado with tuna tartar',51.00,'EUR',0,0,1,1,'2024-11-28 09:14:19.821230',74),(443,'Ensalada de tomate de raza, espárrago verde salteado y queso viejo','Salad of heirloom tomatoes, sautéed green asparagus, and aged cheese',51.00,'EUR',0,0,1,2,'2024-11-28 09:14:19.823708',74),(444,'Tortilla de patata gallega con cebolla y huevo de corral','Galician potato omelet with onion and free-range egg',51.00,'EUR',0,0,1,3,'2024-11-28 09:14:19.826506',74),(445,'Croquetas de jamón ibérico muy cremosas','Very creamy Iberian ham croquettes',51.00,'EUR',0,0,1,4,'2024-11-28 09:14:19.829452',74),(446,'Mini hamburguesa de picaña curada en pan de brioche al curry','Mini burger of cured picanha on curry brioche bun',51.00,'EUR',0,0,1,5,'2024-11-28 09:14:19.831937',74),(447,'Tarta de queso cremosa','Creamy cheesecake',51.00,'EUR',0,0,1,6,'2024-11-28 09:14:19.834092',74),(457,'Pan de cristal','Cristal bread with tomato seasoning and premium olive oil',4.25,'EUR',0,0,1,1,'2024-11-28 19:32:02.914296',76),(458,'Tablita de jamón de bellota 100% con pan de cristal','Ham board with cristal bread',25.00,'EUR',0,0,1,2,'2024-11-28 19:32:02.922887',76),(459,'Croquetas de Jamón Ibérico y boletus','Iberian ham and boletus croquettes',14.00,'EUR',0,0,1,3,'2024-11-28 19:32:02.926591',76),(460,'Tataki de Wagyu con pimientos del padrón','Wagyu tataki with padrón peppers',23.50,'EUR',0,0,1,4,'2024-11-28 19:32:02.930313',76),(461,'Mini Steak tartar con huevo de codorniz','Steak tartar with quail egg',4.90,'EUR',0,0,1,5,'2024-11-28 19:32:02.933168',76),(462,'Burrata de apulia con tomates secos y pan carasaú','Burrata with dry tomatoes and pane carasau',15.00,'EUR',0,0,1,6,'2024-11-28 19:32:02.936978',76),(463,'Empanada argentina','Argentine empanada',6.50,'EUR',0,0,1,7,'2024-11-28 19:32:02.939245',76),(464,'Alcachofas confitadas con criadilla de cecina','Candi artichokes with crispy cow meat',16.50,'EUR',0,0,1,8,'2024-11-28 19:32:02.942589',76),(465,'Steak Tartar de Wagyu acompañado de pan de cristal','Wagyu Steak Tartar served with glass bread.',26.50,'EUR',0,0,1,9,'2024-11-28 19:32:02.946171',76),(466,'Mini hamburguesas Angus 100%','100% Angus mini burgers',5.20,'EUR',0,0,1,1,'2024-11-28 19:32:02.950733',77),(467,'Mollagas de ternera estilo raza','Beef sweetbread style raza',16.50,'EUR',0,0,1,2,'2024-11-28 19:32:02.954658',77),(468,'Matrimonio de chorizo criollo y morcilla','Creole sausage and blood sausage',11.20,'EUR',0,0,1,3,'2024-11-28 19:32:02.957407',77),(469,'Zamburiñas a la brasa','Grilled scallops',17.90,'EUR',0,0,1,4,'2024-11-28 19:32:02.961232',77),(470,'Pulpo a las brasas con puré de patatas y ajada','Grilled octopus with mashed potatoes and garlic salad',26.00,'EUR',0,0,1,5,'2024-11-28 19:32:02.963501',77),(471,'Bonito asado con toque teriyaki','Roasted seed potato with teriyaki',7.00,'EUR',0,0,1,6,'2024-11-28 19:32:02.966546',77),(472,'Puerro asado con demi glace','Roasted leek with demi glace',7.50,'EUR',0,0,1,7,'2024-11-28 19:32:02.969231',77),(473,'Berenjenas japonesas a la brasa','Japanese eggplant',8.50,'EUR',0,0,1,8,'2024-11-28 19:32:02.971444',77),(474,'Vegetales a la parrilla','Grilled vegetables',13.50,'EUR',0,0,1,9,'2024-11-28 19:32:02.973430',77),(475,'Lechuga viva con tomate rosa y nuestro aliño','Fresh lettuce with rose tomato and our seasoning',13.00,'EUR',0,0,1,1,'2024-11-28 19:32:02.975736',78),(476,'Aguacate a la parrilla con ensalada fresca templada','Grilled avocado with warm green salad',13.50,'EUR',0,0,1,2,'2024-11-28 19:32:02.978298',78),(477,'Ensalada de tempura','Season salad',14.00,'EUR',0,0,1,3,'2024-11-28 19:32:02.979692',78),(478,'Pasta ‘Ala Norma’','Traditional Italian pasta',13.50,'EUR',0,0,1,1,'2024-11-28 19:32:02.981758',79),(479,'Pasta Alpina','Alpine style pasta',14.00,'EUR',0,0,1,2,'2024-11-28 19:32:02.983143',79),(480,'Spaghetti con ajo en gambones, alijos y guindilla','Spaghetti with shrimps, garlic, and chili',14.50,'EUR',0,0,1,3,'2024-11-28 19:32:02.986078',79),(481,'Lomo Alto 300grs. | Ojo de bife','Rib Eye Steak 300grs. | Ojo de bife [Argentina]',27.50,'EUR',0,0,1,1,'2024-11-28 19:32:02.988209',80),(482,'Lomo Bajo 300grs. | Bife Chorizo','Sirloin 300grs. | Bife de Chorizo [Argentina]',25.50,'EUR',0,0,1,2,'2024-11-28 19:32:02.990423',80),(483,'Entráda 300grs. | Black Angus','Skirt Steak 300grs. | Black Angus [Argentina]',22.00,'EUR',0,0,1,3,'2024-11-28 19:32:02.996551',80),(484,'Lomo Alto 350grs. | Retina','Rib Eye Steak 350g. | Retina [Cádiz]',26.50,'EUR',0,0,1,4,'2024-11-28 19:32:02.999381',80),(485,'Cube Roll, Centro de Lomo Alto de Simmental 409g.','Cube Roll, Simmental High Loin Center, 400g.',41.90,'EUR',0,0,1,5,'2024-11-28 19:32:03.001232',80),(486,'Chuleta de Vaca Raxa Asturiana de los Valles 500grs.','Asturian Valleys Raxa Cow Ribeye Steak, 500g.',43.75,'EUR',0,0,1,6,'2024-11-28 19:32:03.002713',80),(487,'Lomo Bajo 350grs. | Vaca Rubia Gallega','Sirloin Bife 350grs. | Rubia Gallega Cow [Pontevedra]',28.50,'EUR',0,0,1,7,'2024-11-28 19:32:03.004916',80),(488,'Lomo Alto 700grs. | Vaca Ayrshire Sashi','Rib Eye Steak 700grs. | Ayrshire Sashi Cow [Finland] - 2 pax',57.60,'EUR',0,0,1,8,'2024-11-28 19:32:03.006870',80),(489,'Solomillo de Vaca 200grs.','Beef Sirloin Steak 200grs. | 1 to 6 years [Holland]',25.00,'EUR',0,0,1,9,'2024-11-28 19:32:03.009437',80),(490,'T-Bone Simmental 1kg.','Simmental T-Bone 1kg. (Sirloin Bife & Beef Sirloin Steak)',62.50,'EUR',0,0,1,10,'2024-11-28 19:32:03.011937',80),(491,'Solomillo con su costilla y tuétano asado','Fillet with rib and roasted marrow.',28.50,'EUR',0,0,1,11,'2024-11-28 19:32:03.014285',80),(492,'Milanesa de lomo con huevo escalfado y trufa rallada','Loin milanesa with poached egg and grated truffle',21.50,'EUR',0,0,1,1,'2024-11-28 19:32:03.016438',81),(493,'Pollo de corral braseado al chimichurri','Braised free-range chicken with chimichurri',18.00,'EUR',0,0,1,2,'2024-11-28 19:32:03.018047',81),(494,'Hamburguesa Raza','Raza B Burger | black garlic mayonnaise, boletus edulis, foie gras, and grated black truffle.',26.50,'EUR',0,0,1,3,'2024-11-28 19:32:03.019680',81),(495,'Patatas fritas, especiadas o a la brasa','French fries, grilled or spiced',5.00,'EUR',0,0,1,1,'2024-11-28 19:32:03.025732',82),(496,'Puré de patata estilo potubchón','Pouchón style mashed potatoes',6.00,'EUR',0,0,1,2,'2024-11-28 19:32:03.028996',82),(497,'Tártaro asado','Roasted tartare',8.00,'EUR',0,0,1,3,'2024-11-28 19:32:03.030522',82),(498,'Champiñones a la crema','Mushrooms in cream sauce',7.50,'EUR',0,0,1,4,'2024-11-28 19:32:03.033308',82),(499,'Ensalada templada de pimientos asados','Roasted peppers warm salad',6.00,'EUR',0,0,1,5,'2024-11-28 19:32:03.036866',82),(500,'Basted Wings','Slow roasted chicken wings with honey and soy sauce.',9.00,'€',650,2,1,1,'2024-11-28 20:08:00.794624',83),(501,'Grilled Potatoes with Spicy Sauce (A.K.A. Patatas Bravas)','Baked potato wedges with Canarian style spicy sauce.',8.00,'€',400,3,1,2,'2024-11-28 20:08:00.802667',83),(502,'Russian Salad with “Regañás”','A traditional sweet potato recipe, which gives a small candy touch.',8.00,'€',300,0,1,3,'2024-11-28 20:08:00.805187',83),(503,'Braised Ham & Cheddar Cheese Quesadilla','Grilled wheat quesadilla with spicy mayo & pico de gallo.',10.00,'€',650,2,1,4,'2024-11-28 20:08:00.811376',83),(504,'Prawn Gyozas with Sweet and Sour Vegetables (5 Units)','Steamed Chinese pie based on sweet chilli and Korean soybean.',10.00,'€',500,3,1,5,'2024-11-28 20:08:00.821855',83),(505,'Confit Leek Salad','With tomato pesto, grapes and seeds.',11.00,'€',350,0,1,6,'2024-11-28 20:08:00.831399',83),(506,'Pulled Pork Tacos','With pico de gallo & jalapeño.',12.00,'€',700,2,1,1,'2024-11-28 20:08:00.837449',84),(507,'Onion & Beer Meatballs','Mix of meats cooked in pepper, onions and the best local beer.',12.00,'€',800,1,1,2,'2024-11-28 20:08:00.841025',84),(508,'Ricotta Ravioli','With a soft cream of spinach & crispy caramel touch.',11.50,'€',900,0,1,3,'2024-11-28 20:08:00.846255',84),(509,'MiniCachopos (2 Units)','Breaded veal steaks stuffed with ham and cheese. Finished with Iberian veil.',13.00,'€',850,1,1,4,'2024-11-28 20:08:00.852434',84),(510,'Salmon Tiradito','With aji, passion fruit and pumpkin spaghetti.',14.00,'€',500,2,1,5,'2024-11-28 20:08:00.862054',84),(511,'Brownie with Vanilla Ice Cream','',6.00,'€',450,0,1,1,'2024-11-28 20:08:00.866742',85),(512,'Cheesecake','',6.00,'€',400,0,1,2,'2024-11-28 20:08:00.875982',85),(513,'Soft Drinks','Coca-Cola, Sprite, Fanta, mineral water & sparkling water.',3.50,'€',150,0,1,1,'2024-11-28 20:08:00.888846',86),(514,'Homemade Lemonade','',4.00,'€',120,0,1,2,'2024-11-28 20:08:00.890928',86),(515,'Juices','Pineapple, peach or orange',3.30,'€',100,0,1,3,'2024-11-28 20:08:00.892279',86),(516,'Tomato Juice','',3.50,'€',50,0,1,4,'2024-11-28 20:08:00.893549',86),(517,'Double Draft Beer','',3.50,'€',180,0,1,1,'2024-11-28 20:08:00.897918',87),(518,'33cl. Mahou\'s Beer Bottle','',3.75,'€',150,0,1,2,'2024-11-28 20:08:00.901726',87),(519,'33cl. Coronita','',4.00,'€',150,0,1,3,'2024-11-28 20:08:00.913869',87),(520,'33cl. Alhambra\'s Beer Bottle (Special)','',4.00,'€',200,0,1,4,'2024-11-28 20:08:00.918081',87),(521,'33cl. Alhambra\'s Beer Bottle (Red)','',4.50,'€',200,0,1,5,'2024-11-28 20:08:00.921632',87),(522,'Tercio La Chouffe 8°','Pale Ale Rubia Belga.',5.00,'€',220,0,1,6,'2024-11-28 20:08:00.923223',87),(523,'Tercio Duvel 8.5°','Ale Fuerte Dorada Belga.',5.00,'€',220,0,1,7,'2024-11-28 20:08:00.924623',87),(524,'Tinto de Verano','Good friends of sangria.',4.00,'€',180,0,1,8,'2024-11-28 20:08:00.926151',87),(525,'Local Vermouth','',3.00,'€',150,0,1,9,'2024-11-28 20:08:00.927170',87),(526,'Protos','Ribera del Duero.',3.40,'€',120,0,1,10,'2024-11-28 20:08:00.929816',87),(527,'Biberis','Ribera del Duero.',3.30,'€',120,0,1,11,'2024-11-28 20:08:00.931416',87),(528,'Ramón Bilbao','Rioja.',3.50,'€',120,0,1,12,'2024-11-28 20:08:00.932806',87),(529,'Carro Blanco','Verdejo.',3.50,'€',120,0,1,13,'2024-11-28 20:08:00.936053',87),(530,'Camiño do Rei','Rías Baixas.',3.50,'€',120,0,1,14,'2024-11-28 20:08:00.937778',87),(531,'Beefeater, Tanqueray, Seagram\'s','',9.00,'€',64,0,1,15,'2024-11-28 20:08:00.940086',87),(532,'Martin Miller\'s, Hendrix y Bombay Saphire, Nordés & Brockman\'s','',12.00,'€',64,0,1,16,'2024-11-28 20:08:00.941650',87),(533,'Brugal, Barceló & Santa Teresa','',9.00,'€',70,0,1,17,'2024-11-28 20:08:00.947471',87),(534,'Legendario & Havana 7','',10.00,'€',70,0,1,18,'2024-11-28 20:08:00.948806',87),(535,'Johnnie Walker, DYC (8 Years) & White Label','',9.00,'€',80,0,1,19,'2024-11-28 20:08:00.949879',87),(536,'Jack Daniel\'s','',10.00,'€',80,0,1,20,'2024-11-28 20:08:00.950926',87),(537,'Absolut & Stolichnaya','',9.00,'€',64,0,1,21,'2024-11-28 20:08:00.951730',87),(538,'Shots','',3.50,'€',80,0,1,22,'2024-11-28 20:08:00.952512',87),(539,'Non-Alcoholic Mojito','',6.00,'€',100,0,1,1,'2024-11-28 20:08:00.953593',88),(540,'Mojito','',10.00,'€',160,0,1,2,'2024-11-28 20:08:00.954580',88),(541,'Caipirinha, Caipiroska & Bloody Mary','',10.00,'€',180,0,1,3,'2024-11-28 20:08:00.955592',88),(542,'Aguacate con tartar de atún','Avocado with tuna tartare',0.00,'EUR',0,0,1,1,'2024-12-02 11:35:29.099446',89),(543,'Ensalada de tomate de raza, espárrago verde salteado y queso viejo','Heirloom tomato salad with sautéed green asparagus and aged cheese',0.00,'EUR',0,0,1,2,'2024-12-02 11:35:29.106301',89),(544,'Tortilla de patata gallega con cebolla y huevo de corral','Galician potato omelette with onion and free-range eggs',0.00,'EUR',0,0,1,3,'2024-12-02 11:35:29.108049',89),(545,'Croquetas de jamón ibérico muy cremosas','Very creamy Iberian ham croquettes',0.00,'EUR',0,0,1,4,'2024-12-02 11:35:29.111295',89),(546,'Mini hamburguesa de picaña curada en pan de brioche al curry','Mini burger of cured picanha in curry brioche bun',0.00,'EUR',0,0,1,5,'2024-12-02 11:35:29.115565',89),(547,'Tarta de queso cremosa','Creamy cheesecake',0.00,'EUR',0,0,1,6,'2024-12-02 11:35:29.117090',89),(548,'Aguacate con tartar de atún','Fresh avocado served with tuna tartar.',51.00,'EUR',500,2,1,1,'2024-12-02 11:37:17.234659',90),(549,'Ensalada de tomate de raza, espárrago verde salteado y queso viejo','Heirloom tomato salad with sautéed green asparagus and aged cheese.',51.00,'EUR',350,0,1,2,'2024-12-02 11:37:17.242588',90),(550,'Tortilla de patata gallega con cebolla y huevo de corral','Galician potato omelette with onion and free-range egg.',51.00,'EUR',600,0,1,3,'2024-12-02 11:37:17.248244',90),(551,'Croquetas de jamón ibérico muy cremosas','Very creamy Iberian ham croquettes.',51.00,'EUR',450,0,1,4,'2024-12-02 11:37:17.252492',90),(552,'Mini hamburguesa de picaña curada en pan de brioche al curry','Mini burger of cured picanha in curry brioche bun.',51.00,'EUR',500,1,1,5,'2024-12-02 11:37:17.257400',90),(553,'Tarta de queso cremosa','Creamy cheesecake dessert.',51.00,'EUR',400,0,1,6,'2024-12-02 11:37:17.262090',90),(554,'Basted Wings','Slow roasted chicken wings with honey and soy sauce.',9.00,'€',0,0,1,1,'2024-12-04 13:30:52.018697',91),(555,'Grilled Potatoes with Spicy Sauce (A.K.A. Patatas Bravas)','Baked potato wedges with Canarian style spicy sauce.',8.00,'€',0,0,1,2,'2024-12-04 13:30:52.027895',91),(556,'Russian Salad with “Reganás”','A traditional sweet potato recipe, which gives a small candy touch.',8.00,'€',0,0,1,3,'2024-12-04 13:30:52.029975',91),(557,'Braised Ham & Cheddar Cheese Quesadilla','Grilled wheat quesadilla with spicy mayo & pico de gallo.',10.00,'€',0,0,1,4,'2024-12-04 13:30:52.031804',91),(558,'Prawn Gyozas with Sweet and Sour Vegetables (5 units)','Steamed Chinese pie based on sweet chilli and Korean soybean.',10.00,'€',0,0,1,5,'2024-12-04 13:30:52.033726',91),(559,'Confit Leek Salad','With tomato pesto, grapes and seeds.',11.00,'€',0,0,1,6,'2024-12-04 13:30:52.036227',91),(560,'Pulled Pork Tacos','With pico de gallo & jalapeño.',12.00,'€',0,0,1,1,'2024-12-04 13:30:52.038409',92),(561,'Onion & Beer Meatballs','Mix of meats cooked in pepper, onions and the best local beer.',12.00,'€',0,0,1,2,'2024-12-04 13:30:52.040204',92),(562,'Ricotta Ravioli','With a soft cream of spinach & crispy caramel touch.',11.50,'€',0,0,1,3,'2024-12-04 13:30:52.041985',92),(563,'“Minicachopos” (2 units)','Breaded veal steaks stuffed with ham and cheese. Finished with Iberian veil.',13.00,'€',0,0,1,4,'2024-12-04 13:30:52.044880',92),(564,'Salmon Tiradito','With aji, passion fruit and pumpkin spaghetti.',14.00,'€',0,0,1,5,'2024-12-04 13:30:52.046419',92),(565,'Brownie with Vanilla Ice Cream','',6.00,'€',0,0,1,1,'2024-12-04 13:30:52.048410',93),(566,'Cheesecake','',6.00,'€',0,0,1,2,'2024-12-04 13:30:52.050272',93),(567,'Soft Drinks','Coca-Cola, Sprite, Fanta, mineral water & sparkling water.',3.50,'€',0,0,1,1,'2024-12-04 13:30:52.053295',94),(568,'Homemade Lemonade','',4.00,'€',0,0,1,2,'2024-12-04 13:30:52.054797',94),(569,'Juices','Pineapple, peach or orange',3.30,'€',0,0,1,3,'2024-12-04 13:30:52.056147',94),(570,'Tomato Juice','',3.50,'€',0,0,1,4,'2024-12-04 13:30:52.057842',94),(571,'Double Draft Beer','',3.50,'€',0,0,1,1,'2024-12-04 13:30:52.061308',95),(572,'33cl. Mahou\'s Beer Bottle','',3.75,'€',0,0,1,2,'2024-12-04 13:30:52.062973',95),(573,'33cl. Coronita','',4.00,'€',0,0,1,3,'2024-12-04 13:30:52.064411',95),(574,'33cl. Alhambra\'s Beer Bottle (Special)','',4.00,'€',0,0,1,4,'2024-12-04 13:30:52.066295',95),(575,'33cl. Alhambra\'s Beer Bottle (Red)','',4.50,'€',0,0,1,5,'2024-12-04 13:30:52.069316',95),(576,'Tercio La Chouffe 8°','Pale Ale Rubia Belga.',5.00,'€',0,0,1,6,'2024-12-04 13:30:52.071297',95),(577,'Tercio Duvel 8.5°','Ale Fuerte Dorada Belga.',5.00,'€',0,0,1,7,'2024-12-04 13:30:52.072708',95),(578,'Protos','Ribera del Duero.',3.40,'€',0,0,1,1,'2024-12-04 13:30:52.077515',96),(579,'Biberio','Ribera del Duero.',3.30,'€',0,0,1,2,'2024-12-04 13:30:52.079376',96),(580,'Ramón Bilbao','Rioja.',3.50,'€',0,0,1,3,'2024-12-04 13:30:52.080836',96),(581,'Carro Blanco. Verdejo','',3.50,'€',0,0,1,4,'2024-12-04 13:30:52.082717',96),(582,'Camiño Do Rei. Rías Baixas','',3.50,'€',0,0,1,5,'2024-12-04 13:30:52.085211',96),(583,'Beefeater, Tanqueray, Seagram\'s','',9.00,'€',0,0,1,1,'2024-12-04 13:30:52.088497',97),(584,'Martin Miller\'s','Premium Gin',12.00,'€',0,0,1,2,'2024-12-04 13:30:52.090240',97),(585,'Hendrix','Premium Gin',12.00,'€',0,0,1,3,'2024-12-04 13:30:52.092403',97),(586,'Bombay Sapphire','Premium Gin',12.00,'€',0,0,1,4,'2024-12-04 13:30:52.095138',97),(587,'Nordés & Brockman’s','Premium Gin',12.00,'€',0,0,1,5,'2024-12-04 13:30:52.096812',97),(588,'Brugal, Barceló & Santa Teresa','',9.00,'€',0,0,1,1,'2024-12-04 13:30:52.099199',98),(589,'Legendario & Havana 7','Premium Ron',10.00,'€',0,0,1,2,'2024-12-04 13:30:52.099994',98),(590,'Johnnie Walker, DYC (8 years) & White Label','',9.00,'€',0,0,1,1,'2024-12-04 13:30:52.101438',99),(591,'Jack Daniel’s','',10.00,'€',0,0,1,1,'2024-12-04 13:30:52.103171',100),(592,'Absolut & Stolichnaya','',9.00,'€',0,0,1,1,'2024-12-04 13:30:52.104589',101),(593,'Standard Shots','',3.50,'€',0,0,1,1,'2024-12-04 13:30:52.105792',102),(594,'Non-Alcoholic Mojito','',6.00,'€',0,0,1,1,'2024-12-04 13:30:52.107543',103),(595,'Mojito','',10.00,'€',0,0,1,2,'2024-12-04 13:30:52.110106',103),(596,'Caipirinha, Caipiroska & Bloody Mary','',10.00,'€',0,0,1,3,'2024-12-04 13:30:52.112307',103),(597,'Baileys','',5.00,'€',0,0,1,1,'2024-12-04 13:30:52.114842',104),(598,'Martini Rosso & Bianco','',4.00,'€',0,0,1,2,'2024-12-04 13:30:52.116928',104),(599,'Herbs Liqueur','',4.00,'€',0,0,1,3,'2024-12-04 13:30:52.118765',104),(600,'Patxarán','',4.00,'€',0,0,1,4,'2024-12-04 13:30:52.119677',104);
/*!40000 ALTER TABLE `menu_menuitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restaurant_full_details_item_insert` AFTER INSERT ON `menu_menuitem` FOR EACH ROW BEGIN
    INSERT INTO restaurant_full_details_table (
        restaurant_id,
        menu_version_id,
        menu_version_number,
        effective_date,
        source_type,
        source_url,
        is_current,
        menu_created_at,
        section_id,
        section_name,
        section_description,
        section_order,
        section_created_at,
        item_id,
        item_name,
        item_description,
        price,
        currency,
        calories,
        spice_level,
        is_available,
        item_order,
        item_created_at
    )
    SELECT 
        mv.restaurant_id,
        mv.id,
        mv.version_number,
        mv.effective_date,
        mv.source_type,
        mv.source_url,
        mv.is_current,
        mv.created_at,
        ms.id,
        ms.name,
        ms.description,
        ms.display_order,
        ms.created_at,
        NEW.id,
        NEW.name,
        NEW.description,
        NEW.price,
        NEW.currency,
        NEW.calories,
        NEW.spice_level,
        NEW.is_available,
        NEW.display_order,
        NEW.created_at
    FROM menu_menusection ms
    JOIN menu_menuversion mv ON mv.id = ms.version_id
    WHERE ms.id = NEW.section_id
    AND mv.is_current = 1
    ON DUPLICATE KEY UPDATE
        item_id = NEW.id,
        item_name = NEW.name,
        item_description = NEW.description,
        price = NEW.price,
        currency = NEW.currency,
        calories = NEW.calories,
        spice_level = NEW.spice_level,
        is_available = NEW.is_available,
        item_order = NEW.display_order,
        item_created_at = NEW.created_at;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_menu_statistics_insert` AFTER INSERT ON `menu_menuitem` FOR EACH ROW BEGIN
    INSERT INTO menu_menustatistics (
        restaurant_id, 
        total_items,
        avg_price,
        last_updated
    )
    SELECT * FROM v_menu_statistics 
    WHERE restaurant_id = (
        SELECT mv.restaurant_id
        FROM menu_menuversion mv
        JOIN menu_menusection ms ON ms.version_id = mv.id
        WHERE ms.id = NEW.section_id
    )
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_menu_statistics_update` AFTER UPDATE ON `menu_menuitem` FOR EACH ROW BEGIN
    INSERT INTO menu_menustatistics (
        restaurant_id, 
        total_items,
        avg_price,
        last_updated
    )
    SELECT * FROM v_menu_statistics 
    WHERE restaurant_id = (
        SELECT mv.restaurant_id
        FROM menu_menuversion mv
        JOIN menu_menusection ms ON ms.version_id = mv.id
        WHERE ms.id = NEW.section_id
    )
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_menu_statistics_delete` AFTER DELETE ON `menu_menuitem` FOR EACH ROW BEGIN
    INSERT INTO menu_menustatistics (
        restaurant_id, 
        total_items,
        avg_price,
        last_updated
    )
    SELECT * FROM v_menu_statistics 
    WHERE restaurant_id = (
        SELECT mv.restaurant_id
        FROM menu_menuversion mv
        JOIN menu_menusection ms ON ms.version_id = mv.id
        WHERE ms.id = OLD.section_id
    )
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `menu_menuitem_dietary_restrictions`
--

DROP TABLE IF EXISTS `menu_menuitem_dietary_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_menuitem_dietary_restrictions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `menuitem_id` bigint NOT NULL,
  `dietaryrestriction_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_menuitem_dietary_re_menuitem_id_dietaryrestr_dc81c776_uniq` (`menuitem_id`,`dietaryrestriction_id`),
  KEY `menu_menuitem_dietar_dietaryrestriction_i_6dbf3f6e_fk_menu_diet` (`dietaryrestriction_id`),
  CONSTRAINT `menu_menuitem_dietar_dietaryrestriction_i_6dbf3f6e_fk_menu_diet` FOREIGN KEY (`dietaryrestriction_id`) REFERENCES `menu_dietaryrestriction` (`id`),
  CONSTRAINT `menu_menuitem_dietar_menuitem_id_77b12b1f_fk_menu_menu` FOREIGN KEY (`menuitem_id`) REFERENCES `menu_menuitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_menuitem_dietary_restrictions`
--

LOCK TABLES `menu_menuitem_dietary_restrictions` WRITE;
/*!40000 ALTER TABLE `menu_menuitem_dietary_restrictions` DISABLE KEYS */;
INSERT INTO `menu_menuitem_dietary_restrictions` VALUES (149,329,40),(150,329,41),(151,332,40),(152,333,40),(153,337,42),(154,338,40),(155,341,40),(156,343,40),(157,343,41),(158,344,40),(159,345,40),(160,346,40),(161,346,41),(162,347,40),(163,347,41),(164,348,40),(165,349,40),(166,349,41),(167,350,40),(168,350,41),(169,351,40),(170,352,40),(171,352,41),(172,353,43),(173,353,44),(174,354,41),(175,355,40),(176,356,43),(177,356,45),(179,357,44),(178,357,46),(180,358,40),(181,358,47),(182,359,43),(183,360,43),(185,361,40),(184,361,45),(186,362,43),(187,362,45),(188,363,48),(189,364,43),(190,364,45),(191,365,43),(192,365,45),(193,370,49),(194,371,49),(195,372,49),(196,373,49),(197,374,49),(198,375,49),(199,376,49),(200,377,49),(201,378,49),(202,379,49),(203,380,49),(204,381,49),(205,382,49),(206,383,49),(207,384,49),(208,385,49),(209,386,49),(210,387,49),(211,388,49),(212,389,49),(213,391,49),(214,392,49),(215,393,49),(216,394,49),(217,395,49),(218,396,49),(219,397,49),(220,398,49),(221,400,40),(222,401,40),(223,402,40),(224,403,50),(225,404,50),(226,405,50),(227,406,46),(228,407,50),(229,408,40),(230,409,41),(231,410,41),(232,411,46),(233,412,40),(234,413,41),(235,414,46),(236,415,51),(237,418,46),(238,420,40),(239,421,46),(240,422,40),(241,423,40),(242,424,48),(243,426,40),(244,427,46),(245,428,46),(246,429,40),(247,430,46),(248,431,48),(249,432,48),(252,500,43),(253,502,52),(255,503,43),(254,503,45),(257,504,44),(256,504,46),(258,505,52),(259,506,43),(260,507,43),(262,508,43),(261,508,45),(264,509,43),(263,509,45),(265,510,48),(267,511,43),(266,511,45),(269,512,43),(268,512,45);
/*!40000 ALTER TABLE `menu_menuitem_dietary_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_menusection`
--

DROP TABLE IF EXISTS `menu_menusection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_menusection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `display_order` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `version_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_menuse_version_47bc51_idx` (`version_id`,`display_order`),
  CONSTRAINT `menu_menusection_version_id_bdc44ace_fk_menu_menuversion_id` FOREIGN KEY (`version_id`) REFERENCES `menu_menuversion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_menusection`
--

LOCK TABLES `menu_menusection` WRITE;
/*!40000 ALTER TABLE `menu_menusection` DISABLE KEYS */;
INSERT INTO `menu_menusection` VALUES (57,'Starter','Appetizers to begin your meal.',1,'2024-11-27 17:41:29.765836',16),(58,'Soup','Warm and comforting soups.',2,'2024-11-27 17:41:29.781686',16),(59,'Salads','Fresh and healthy salad options.',3,'2024-11-27 17:41:29.784907',16),(60,'Sides','Perfect accompaniments for your meal.',4,'2024-11-27 17:41:29.790530',16),(61,'The Food','A selection of appetizers and main courses for sharing.',1,'2024-11-28 08:58:19.585050',17),(62,'Dessert','A selection of sweet treats to end your meal.',2,'2024-11-28 08:58:19.620297',17),(63,'Drinks','A selection of beverages including soft drinks, cocktails, and spirits.',3,'2024-11-28 08:58:19.623367',17),(64,'Panini','Italian sandwiches and breads',1,'2024-11-28 09:01:44.860211',18),(65,'Antipasti (Starters)','Italian starters to begin your meal',2,'2024-11-28 09:01:44.885240',18),(66,'Zuppa (Soups)','Delicious Italian soups',3,'2024-11-28 09:01:44.918844',18),(67,'Insalati','Fresh Italian salads',4,'2024-11-28 09:01:44.928706',18),(68,'Pasta','Traditional Italian pasta dishes',5,'2024-11-28 09:01:44.956354',18),(69,'Pasta Ripiena','Stuffed pastas with delicious fillings',6,'2024-11-28 09:01:44.979361',18),(70,'Pasta al Forno','Oven-baked pasta dishes',7,'2024-11-28 09:01:44.984512',18),(71,'Risotti','Creamy Italian risottos',8,'2024-11-28 09:01:44.985799',18),(72,'Pesce (Fish)','Delicious fish dishes',9,'2024-11-28 09:01:45.006323',18),(73,'Carne','Hearty meat dishes',10,'2024-11-28 09:01:45.022271',18),(74,'MENÚ A COMPARTIR','A sharing menu with various appetizers and a dessert.',1,'2024-11-28 09:14:19.818161',19),(76,'Entrantes | Starters','Appetizers to start your meal',1,'2024-11-28 19:32:02.912960',21),(77,'A la Brasa | Para compartir','Grilled specialties to share',2,'2024-11-28 19:32:02.949181',21),(78,'De la Huerta | From the green orchard','Fresh vegetable dishes',3,'2024-11-28 19:32:02.975021',21),(79,'Pastas','Delicious pasta dishes',4,'2024-11-28 19:32:02.981089',21),(80,'Carnes | Raza selección, los mejores cortes de carne vacuno','Raza selection: the best beef cuts',5,'2024-11-28 19:32:02.987642',21),(81,'Otras Especialidades | Other Specialities','Special dishes and selections',6,'2024-11-28 19:32:03.015790',21),(82,'Guarniciones | Side dishes','Accompaniments for your main dish',7,'2024-11-28 19:32:03.024086',21),(83,'Starters','',1,'2024-11-28 20:08:00.792194',22),(84,'Main Dishes','',2,'2024-11-28 20:08:00.836700',22),(85,'Dessert','',3,'2024-11-28 20:08:00.865957',22),(86,'Beverages','',4,'2024-11-28 20:08:00.887912',22),(87,'Alcoholic Beverages','',5,'2024-11-28 20:08:00.894466',22),(88,'Cocktails','',6,'2024-11-28 20:08:00.953262',22),(89,'Menú a Compartir','A shared dining experience with a variety of dishes.',1,'2024-12-02 11:35:29.098770',23),(90,'MENÚ A COMPARTIR','Todo a compartir',1,'2024-12-02 11:37:17.231975',24),(91,'Starters','',1,'2024-12-04 13:30:52.016641',25),(92,'Main Courses','',2,'2024-12-04 13:30:52.037813',25),(93,'Desserts','',3,'2024-12-04 13:30:52.047706',25),(94,'Drinks','Soft drinks and other beverages',4,'2024-12-04 13:30:52.052627',25),(95,'Beers','',5,'2024-12-04 13:30:52.060472',25),(96,'Wines','',6,'2024-12-04 13:30:52.075778',25),(97,'Gin','',7,'2024-12-04 13:30:52.087836',25),(98,'Ron','',8,'2024-12-04 13:30:52.098711',25),(99,'Whisky','',9,'2024-12-04 13:30:52.100862',25),(100,'Bourbon','',10,'2024-12-04 13:30:52.102684',25),(101,'Vodka','',11,'2024-12-04 13:30:52.104115',25),(102,'Shots','',12,'2024-12-04 13:30:52.105409',25),(103,'Cocktails','',13,'2024-12-04 13:30:52.106407',25),(104,'Spirits','',14,'2024-12-04 13:30:52.114130',25);
/*!40000 ALTER TABLE `menu_menusection` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restaurant_full_details_section_insert` AFTER INSERT ON `menu_menusection` FOR EACH ROW BEGIN
    INSERT INTO restaurant_full_details_table (
        restaurant_id,
        menu_version_id,
        menu_version_number,
        effective_date,
        source_type,
        source_url,
        is_current,
        menu_created_at,
        section_id,
        section_name,
        section_description,
        section_order,
        section_created_at
    )
    SELECT 
        mv.restaurant_id,
        mv.id,
        mv.version_number,
        mv.effective_date,
        mv.source_type,
        mv.source_url,
        mv.is_current,
        mv.created_at,
        NEW.id,
        NEW.name,
        NEW.description,
        NEW.display_order,
        NEW.created_at
    FROM menu_menuversion mv
    WHERE mv.id = NEW.version_id
    AND mv.is_current = 1
    ON DUPLICATE KEY UPDATE
        section_id = NEW.id,
        section_name = NEW.name,
        section_description = NEW.description,
        section_order = NEW.display_order,
        section_created_at = NEW.created_at;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `menu_menustatistics`
--

DROP TABLE IF EXISTS `menu_menustatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_menustatistics` (
  `restaurant_id` bigint NOT NULL,
  `total_items` int DEFAULT '0',
  `avg_price` decimal(10,2) DEFAULT '0.00',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`restaurant_id`),
  CONSTRAINT `menu_menustatistics_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `menu_restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_menustatistics`
--

LOCK TABLES `menu_menustatistics` WRITE;
/*!40000 ALTER TABLE `menu_menustatistics` DISABLE KEYS */;
INSERT INTO `menu_menustatistics` VALUES (17,24,1300.00,'2024-11-27 22:22:14'),(18,47,7.28,'2024-12-04 13:30:52'),(19,43,15.22,'2024-11-28 09:01:45'),(20,6,51.00,'2024-12-02 11:37:17'),(22,43,19.06,'2024-11-28 19:32:03');
/*!40000 ALTER TABLE `menu_menustatistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_menuversion`
--

DROP TABLE IF EXISTS `menu_menuversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_menuversion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version_number` int NOT NULL,
  `effective_date` date NOT NULL,
  `source_type` varchar(10) NOT NULL,
  `source_url` longtext,
  `is_current` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `restaurant_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_menuversion_restaurant_id_version_number_18e9fb47_uniq` (`restaurant_id`,`version_number`),
  KEY `menu_menuve_effecti_abebb1_idx` (`effective_date`),
  CONSTRAINT `menu_menuversion_restaurant_id_415b653e_fk_menu_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `menu_restaurant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_menuversion`
--

LOCK TABLES `menu_menuversion` WRITE;
/*!40000 ALTER TABLE `menu_menuversion` DISABLE KEYS */;
INSERT INTO `menu_menuversion` VALUES (16,1,'2023-10-01','manual','http://nomadrestaurant.co.ke/menu',1,'2024-11-27 17:41:29.765141',17),(17,1,'2023-10-31','manual','http://www.thehatmadrid.com',0,'2024-11-28 08:58:19.574167',18),(18,1,'2023-10-01','manual','www.ristorantebelmondo.com',1,'2024-11-28 09:01:44.857553',19),(19,1,'2023-10-01','manual','No specific URL provided',0,'2024-11-28 09:14:19.816031',20),(21,1,'2023-10-12','manual','N/A',1,'2024-11-28 19:32:02.909508',22),(22,2,'2023-10-30','manual','www.thehatmadrid.com',0,'2024-11-28 20:08:00.788527',18),(23,2,'2023-10-01','manual','http://www.perrachica.com/menu',0,'2024-12-02 11:35:29.090563',20),(24,3,'2023-10-01','manual','https://www.example.com/perrachica',1,'2024-12-02 11:37:17.225960',20),(25,3,'2023-10-01','manual','http://www.thehatmadrid.com',1,'2024-12-04 13:30:52.000348',18);
/*!40000 ALTER TABLE `menu_menuversion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restaurant_full_details_menuversion_insert` AFTER INSERT ON `menu_menuversion` FOR EACH ROW BEGIN
    IF NEW.is_current = 1 THEN
        -- Clear old current menu data
        UPDATE restaurant_full_details_table
        SET menu_version_id = NULL,
            menu_version_number = NULL,
            effective_date = NULL,
            source_type = NULL,
            source_url = NULL,
            is_current = NULL,
            menu_created_at = NULL,
            section_id = NULL,
            section_name = NULL,
            section_description = NULL,
            section_order = NULL,
            section_created_at = NULL,
            item_id = NULL,
            item_name = NULL,
            item_description = NULL,
            price = NULL,
            currency = NULL,
            calories = NULL,
            spice_level = NULL,
            is_available = NULL,
            item_order = NULL,
            item_created_at = NULL
        WHERE restaurant_id = NEW.restaurant_id;
        
        -- Set new version
        UPDATE restaurant_full_details_table
        SET menu_version_id = NEW.id,
            menu_version_number = NEW.version_number,
            effective_date = NEW.effective_date,
            source_type = NEW.source_type,
            source_url = NEW.source_url,
            is_current = NEW.is_current,
            menu_created_at = NEW.created_at
        WHERE restaurant_id = NEW.restaurant_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `menu_processinglog`
--

DROP TABLE IF EXISTS `menu_processinglog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_processinglog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `process_type` varchar(20) NOT NULL,
  `status` varchar(10) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `error_message` longtext,
  `metadata` json DEFAULT NULL,
  `version_id` bigint NOT NULL,
  `celery_task_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_proces_version_102fdf_idx` (`version_id`,`status`),
  KEY `menu_proces_start_t_745635_idx` (`start_time`),
  CONSTRAINT `menu_processinglog_version_id_4dde009b_fk_menu_menuversion_id` FOREIGN KEY (`version_id`) REFERENCES `menu_menuversion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_processinglog`
--

LOCK TABLES `menu_processinglog` WRITE;
/*!40000 ALTER TABLE `menu_processinglog` DISABLE KEYS */;
INSERT INTO `menu_processinglog` VALUES (14,'upload','completed','2024-11-27 17:41:29.765362','2024-11-27 17:41:29.801633',NULL,NULL,16,NULL),(15,'upload','completed','2024-11-28 08:58:19.579624','2024-11-28 08:58:19.649970',NULL,NULL,17,NULL),(16,'upload','completed','2024-11-28 09:01:44.859417','2024-11-28 09:01:45.049471',NULL,NULL,18,NULL),(17,'upload','completed','2024-11-28 09:14:19.817252','2024-11-28 09:14:19.842250',NULL,NULL,19,NULL),(19,'upload','completed','2024-11-28 19:32:02.911280','2024-11-28 19:32:03.038405',NULL,NULL,21,NULL),(20,'upload','completed','2024-11-28 20:08:00.790756','2024-11-28 20:08:00.956371',NULL,NULL,22,NULL),(21,'upload','completed','2024-12-02 11:35:29.098081','2024-12-02 11:35:29.117802',NULL,NULL,23,NULL),(22,'upload','completed','2024-12-02 11:37:17.229894','2024-12-02 11:37:17.264820',NULL,NULL,24,NULL),(23,'upload','completed','2024-12-04 13:30:52.012836','2024-12-04 13:30:52.120604',NULL,NULL,25,NULL);
/*!40000 ALTER TABLE `menu_processinglog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_restaurant`
--

DROP TABLE IF EXISTS `menu_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_restaurant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` longtext,
  `phone` varchar(50) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `cuisine_type` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_restau_name_28c9c9_idx` (`name`),
  KEY `menu_restau_cuisine_58694a_idx` (`cuisine_type`),
  FULLTEXT KEY `restaurant_search` (`name`,`address`,`cuisine_type`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_restaurant`
--

LOCK TABLES `menu_restaurant` WRITE;
/*!40000 ALTER TABLE `menu_restaurant` DISABLE KEYS */;
INSERT INTO `menu_restaurant` VALUES (17,'Nomad Beach Bar & Restaurant','Diani Beach, Kenya','+254 123 456789','http://nomadrestaurant.co.ke','International','2024-11-27 17:41:29.763389','2024-11-27 17:41:29.763421',1),(18,'The Hat','Calle Imperial, 9, 28012 Madrid, Spain','+34 917 72 85 72','http://www.thehatmadrid.com','International','2024-11-28 08:58:19.551678','2024-11-28 08:58:19.551794',1),(19,'Belmondo Ristorante - Pizzeria','Senhora da Rocha – Porches','+351 282 313 132, +351 963 907 416','www.ristorantebelmondo.com','Italian Gourmet','2024-11-28 09:01:44.853656','2024-11-28 09:01:44.853725',1),(20,'PERRACHICA','No specific address provided','No phone number provided','No website provided','Spanish','2024-11-28 09:14:19.811024','2024-11-28 09:14:19.811094',1),(22,'Raza Madrid','Unknown','Unknown','Unknown','Spanish','2024-11-28 19:32:02.902098','2024-11-28 19:32:02.902203',1);
/*!40000 ALTER TABLE `menu_restaurant` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restaurant_full_details_restaurant_insert` AFTER INSERT ON `menu_restaurant` FOR EACH ROW BEGIN
    INSERT INTO restaurant_full_details_table (
        restaurant_id, restaurant_name, address, phone, website,
        cuisine_type, created_at, updated_at, is_active
    ) VALUES (
        NEW.id, NEW.name, NEW.address, NEW.phone, NEW.website,
        NEW.cuisine_type, NEW.created_at, NEW.updated_at, NEW.is_active
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restaurant_full_details_restaurant_update` AFTER UPDATE ON `menu_restaurant` FOR EACH ROW BEGIN
    UPDATE restaurant_full_details_table
    SET restaurant_name = NEW.name,
        address = NEW.address,
        phone = NEW.phone,
        website = NEW.website,
        cuisine_type = NEW.cuisine_type,
        updated_at = NEW.updated_at,
        is_active = NEW.is_active
    WHERE restaurant_id = NEW.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_restaurant_stats` AFTER DELETE ON `menu_restaurant` FOR EACH ROW BEGIN
    DELETE FROM menu_menustatistics 
    WHERE restaurant_id = OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `menu_searchindex`
--

DROP TABLE IF EXISTS `menu_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_searchindex` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(20) NOT NULL,
  `entity_id` int unsigned NOT NULL,
  `content` longtext NOT NULL,
  `last_updated` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_searchindex_entity_type_entity_id_ca8993a8_uniq` (`entity_type`,`entity_id`),
  KEY `menu_search_last_up_8fc5e7_idx` (`last_updated`),
  CONSTRAINT `menu_searchindex_chk_1` CHECK ((`entity_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_searchindex`
--

LOCK TABLES `menu_searchindex` WRITE;
/*!40000 ALTER TABLE `menu_searchindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `restaurant_full_details`
--

DROP TABLE IF EXISTS `restaurant_full_details`;
/*!50001 DROP VIEW IF EXISTS `restaurant_full_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `restaurant_full_details` AS SELECT 
 1 AS `restaurant_id`,
 1 AS `restaurant_name`,
 1 AS `address`,
 1 AS `phone`,
 1 AS `website`,
 1 AS `cuisine_type`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `is_active`,
 1 AS `menu_version_id`,
 1 AS `menu_version_number`,
 1 AS `effective_date`,
 1 AS `source_type`,
 1 AS `source_url`,
 1 AS `is_current`,
 1 AS `menu_created_at`,
 1 AS `section_id`,
 1 AS `section_name`,
 1 AS `section_description`,
 1 AS `section_order`,
 1 AS `section_created_at`,
 1 AS `item_id`,
 1 AS `item_name`,
 1 AS `item_description`,
 1 AS `price`,
 1 AS `currency`,
 1 AS `calories`,
 1 AS `spice_level`,
 1 AS `is_available`,
 1 AS `item_order`,
 1 AS `item_created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `restaurant_full_details_table`
--

DROP TABLE IF EXISTS `restaurant_full_details_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_full_details_table` (
  `restaurant_id` int NOT NULL,
  `restaurant_name` varchar(255) DEFAULT NULL,
  `address` text,
  `phone` varchar(50) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `cuisine_type` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `menu_version_id` int DEFAULT NULL,
  `menu_version_number` int DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `source_type` varchar(10) DEFAULT NULL,
  `source_url` text,
  `is_current` tinyint(1) DEFAULT NULL,
  `menu_created_at` timestamp NULL DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  `section_name` varchar(255) DEFAULT NULL,
  `section_description` text,
  `section_order` int DEFAULT NULL,
  `section_created_at` timestamp NULL DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `item_description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `calories` int DEFAULT NULL,
  `spice_level` smallint DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT NULL,
  `item_order` int DEFAULT NULL,
  `item_created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  KEY `idx_restaurant` (`restaurant_id`),
  KEY `idx_menu_version` (`menu_version_id`),
  KEY `idx_section` (`section_id`),
  KEY `idx_item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_full_details_table`
--

LOCK TABLES `restaurant_full_details_table` WRITE;
/*!40000 ALTER TABLE `restaurant_full_details_table` DISABLE KEYS */;
INSERT INTO `restaurant_full_details_table` VALUES (17,'Nomad Beach Bar & Restaurant','Diani Beach, Kenya','+254 123 456789','http://nomadrestaurant.co.ke','International','2024-11-27 16:41:30','2024-11-27 16:41:30',1,16,1,'2023-10-01','manual','http://nomadrestaurant.co.ke/menu',1,'2024-11-27 16:41:30',57,'Starter','Appetizers to begin your meal.',1,'2024-11-27 16:41:30',329,'Cold Mezze V','Hummus, muhammara, baba ghanoush & moutabal served with pide bread',1500.00,'KES',450,1,1,1,'2024-11-27 16:41:30'),(18,'The Hat','Calle Imperial, 9, 28012 Madrid, Spain','+34 917 72 85 72','http://www.thehatmadrid.com','International','2024-11-28 07:58:20','2024-11-28 07:58:20',1,25,3,'2023-10-01','manual','http://www.thehatmadrid.com',1,'2024-12-04 12:30:52',104,'Spirits','',14,'2024-12-04 12:30:52',600,'Patxarán','',4.00,'€',0,0,1,4,'2024-12-04 12:30:52'),(19,'Belmondo Ristorante - Pizzeria','Senhora da Rocha – Porches','+351 282 313 132, +351 963 907 416','www.ristorantebelmondo.com','Italian Gourmet','2024-11-28 08:01:45','2024-11-28 08:01:45',1,18,1,'2023-10-01','manual','www.ristorantebelmondo.com',1,'2024-11-28 08:01:45',73,'Carne','Hearty meat dishes',10,'2024-11-28 08:01:45',441,'Saltimbocca alla Romana','Veal Fillet with Parma Smoked Ham and Sage',22.00,'EUR',620,0,1,9,'2024-11-28 08:01:45'),(20,'PERRACHICA','No specific address provided','No phone number provided','No website provided','Spanish','2024-11-28 08:14:20','2024-11-28 08:14:20',1,24,3,'2023-10-01','manual','https://www.example.com/perrachica',1,'2024-12-02 10:37:17',90,'MENÚ A COMPARTIR','Todo a compartir',1,'2024-12-02 10:37:17',553,'Tarta de queso cremosa','Creamy cheesecake dessert.',51.00,'EUR',400,0,1,6,'2024-12-02 10:37:17'),(21,'Raza','Madrid, Spain','N/A','https://www.raza-madrid.com','Spanish','2024-11-28 18:00:23','2024-11-28 18:00:23',1,20,1,'2023-10-01','manual','https://www.raza-madrid.com/menu',1,'2024-11-28 18:00:23',75,'Entrantes / Starters','Delicious starters to begin with',1,'2024-11-28 18:00:23',456,'Steak Tartar de Wagyu con pan de cristal','Wagyu Steak Tartare served with glass bread',26.50,'EUR',400,0,1,9,'2024-11-28 18:00:23'),(22,'Raza Madrid','Unknown','Unknown','Unknown','Spanish','2024-11-28 18:32:03','2024-11-28 18:32:03',1,21,1,'2023-10-12','manual','N/A',1,'2024-11-28 18:32:03',82,'Guarniciones | Side dishes','Accompaniments for your main dish',7,'2024-11-28 18:32:03',499,'Ensalada templada de pimientos asados','Roasted peppers warm salad',6.00,'EUR',0,0,1,5,'2024-11-28 18:32:03');
/*!40000 ALTER TABLE `restaurant_full_details_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_menu_statistics`
--

DROP TABLE IF EXISTS `v_menu_statistics`;
/*!50001 DROP VIEW IF EXISTS `v_menu_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_menu_statistics` AS SELECT 
 1 AS `restaurant_id`,
 1 AS `total_items`,
 1 AS `avg_price`,
 1 AS `last_updated`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'restaurantdb'
--

--
-- Final view structure for view `restaurant_full_details`
--

/*!50001 DROP VIEW IF EXISTS `restaurant_full_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `restaurant_full_details` AS select `restaurant_full_details_table`.`restaurant_id` AS `restaurant_id`,`restaurant_full_details_table`.`restaurant_name` AS `restaurant_name`,`restaurant_full_details_table`.`address` AS `address`,`restaurant_full_details_table`.`phone` AS `phone`,`restaurant_full_details_table`.`website` AS `website`,`restaurant_full_details_table`.`cuisine_type` AS `cuisine_type`,`restaurant_full_details_table`.`created_at` AS `created_at`,`restaurant_full_details_table`.`updated_at` AS `updated_at`,`restaurant_full_details_table`.`is_active` AS `is_active`,`restaurant_full_details_table`.`menu_version_id` AS `menu_version_id`,`restaurant_full_details_table`.`menu_version_number` AS `menu_version_number`,`restaurant_full_details_table`.`effective_date` AS `effective_date`,`restaurant_full_details_table`.`source_type` AS `source_type`,`restaurant_full_details_table`.`source_url` AS `source_url`,`restaurant_full_details_table`.`is_current` AS `is_current`,`restaurant_full_details_table`.`menu_created_at` AS `menu_created_at`,`restaurant_full_details_table`.`section_id` AS `section_id`,`restaurant_full_details_table`.`section_name` AS `section_name`,`restaurant_full_details_table`.`section_description` AS `section_description`,`restaurant_full_details_table`.`section_order` AS `section_order`,`restaurant_full_details_table`.`section_created_at` AS `section_created_at`,`restaurant_full_details_table`.`item_id` AS `item_id`,`restaurant_full_details_table`.`item_name` AS `item_name`,`restaurant_full_details_table`.`item_description` AS `item_description`,`restaurant_full_details_table`.`price` AS `price`,`restaurant_full_details_table`.`currency` AS `currency`,`restaurant_full_details_table`.`calories` AS `calories`,`restaurant_full_details_table`.`spice_level` AS `spice_level`,`restaurant_full_details_table`.`is_available` AS `is_available`,`restaurant_full_details_table`.`item_order` AS `item_order`,`restaurant_full_details_table`.`item_created_at` AS `item_created_at` from `restaurant_full_details_table` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_menu_statistics`
--

/*!50001 DROP VIEW IF EXISTS `v_menu_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_menu_statistics` AS select `r`.`id` AS `restaurant_id`,count(distinct `mi`.`id`) AS `total_items`,coalesce(avg(`mi`.`price`),0) AS `avg_price`,now() AS `last_updated` from (((`menu_restaurant` `r` left join `menu_menuversion` `mv` on(((`mv`.`restaurant_id` = `r`.`id`) and (`mv`.`is_current` = true)))) left join `menu_menusection` `ms` on((`ms`.`version_id` = `mv`.`id`))) left join `menu_menuitem` `mi` on((`mi`.`section_id` = `ms`.`id`))) group by `r`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-04 14:57:37
