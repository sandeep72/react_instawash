-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: localhost    Database: instawash
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `members` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,'[8, 4]'),(2,'[4, 10]'),(3,'[4, 11]'),(4,'[4, undefined]'),(5,'[4, 16]'),(6,'[19, 4]');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  `doj` date DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` char(14) DEFAULT NULL,
  `mobile_no` bigint DEFAULT NULL,
  `gender` char(6) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (8,'John','2021-11-16','user@gmail.com','test1234',1234567890,'Male','customer','Meadow Run','https://sxy5732.uta.cloud/WDM//uploads/717559-favicon.ico'),(10,'sandy','7686-09-08','sandy@gmail.com','iw@sandy',1234567812,'Male','visitor','Meadow Run Apt 410','https://sxy5732.uta.cloud/WDM//uploads/402687-logo512.png'),(11,'test','7876-06-07','test@gmail.com','iw@test',2147483647,'Male','visitor','hgasdjg','https://sxy5732.uta.cloud/WDM//uploads/446731-address.png'),(16,'Kunal','2021-11-29','kunal@gmail.com','test1234',9999999999,'Male','customer','Timber','https://png.pngtree.com/png-vector/20190704/ourlarge/pngtree-businessman-user-avatar-free-vector-png-image_1538405.jpg'),(17,'sandeep yadav','2021-12-05','sandeepyadav@gmail.com','test1234',9877256514,'Male','customer','413 Meadow run',NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipments`
--

DROP TABLE IF EXISTS `equipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `model_no` varchar(50) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  `price` varchar(5) DEFAULT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipments`
--

LOCK TABLES `equipments` WRITE;
/*!40000 ALTER TABLE `equipments` DISABLE KEYS */;
INSERT INTO `equipments` VALUES (5,'Iron','LG','12345','Out of Service','3000','2021-11-15'),(7,'Dryer','SIEMENS T','1234','In Use','400','2021-11-15'),(8,'Dryer','testing','62374','In Use','3423','2021-11-11'),(9,'Iron','Siemens','4444','In Use','1000','2021-11-29'),(10,'Washing Machine','ifb','1001','In Use','1001','2021-12-03'),(11,'Dryer','ifb','1002','In Use','201','2021-12-03');
/*!40000 ALTER TABLE `equipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `personnel_id` int NOT NULL,
  `order_id` int NOT NULL,
  `status` varchar(15) NOT NULL,
  `description` varchar(250) NOT NULL,
  `solution` varchar(250) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents`
--

LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO `incidents` VALUES (13,8,0,1234,'resolved','ASBSNSA','','2021-11-20'),(15,8,0,12345,'unresolved','test12345','','2021-11-20'),(16,8,0,12345,'unresolved','dirty clothes','','2021-11-20'),(17,8,0,116,'unresolved','test','','2021-12-05'),(19,10,0,117,'unresolved','stain on clothes','','2021-12-05'),(20,8,0,13,'resolved','stain','','2021-12-05');
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversationId` int DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `isFile` varchar(10) DEFAULT NULL,
  `author` int DEFAULT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,'Hello Sandeep, I have an issue.','false',8,'1638171445595'),(2,1,'My clothes are found torned in past order.','false',8,'1638171761619'),(3,1,'This is new message','false',8,'1638171773609'),(4,1,'Okay  whats the issue?','false',4,'1638172344079'),(5,1,'new message','false',4,'1638172426365'),(6,1,'new message.....','false',4,'1638172478364'),(7,1,'another message...','false',4,'1638172608556'),(8,1,'1','false',4,'1638172612074'),(9,1,'hi','false',4,'1638172992766'),(10,1,'hi hello','false',4,'1638173026869'),(11,1,'hello','false',4,'1638173092390'),(12,1,'hello','false',4,'1638173127353'),(13,1,'eh','false',4,'1638173229611'),(14,1,'heyyy','false',4,'1638173280095'),(15,1,'new','false',4,'1638173316531'),(16,1,'agaion new ','false',4,'1638173373513'),(17,3,'hello','false',4,'1638173822761'),(18,1,'','false',4,'1638176096360'),(19,1,'Hello','false',4,'1638179487769'),(20,1,'undefined','true',4,'1638179601234'),(21,1,'undefined','true',4,'1638179667440'),(22,1,'https://sxy5732.uta.cloud/WDM//uploads/88436-camera.png','true',4,'1638181555894'),(23,1,'https://sxy5732.uta.cloud/WDM//uploads/630845-q1-graph.png','true',4,'1638182667568'),(24,1,'Hello','false',4,'1638183042804'),(25,1,'New messgae','false',4,'1638183108958'),(26,1,'this is new message','false',4,'1638183145823'),(27,1,'again enw ','false',4,'1638183156317'),(28,1,'another new message','false',4,'1638183231577'),(29,1,'hello','false',8,'1638183258074'),(30,1,'hi','false',4,'1638183293430'),(31,1,'hello','false',8,'1638183516632'),(32,1,'new msg','false',8,'1638183660908'),(33,1,'ashdkhasjkd','false',8,'1638184168494'),(34,1,'asdasd','false',4,'1638184203621'),(35,1,'abc','false',4,'1638184279036'),(36,1,'new message','false',8,'1638184388931'),(37,1,'hi','false',8,'1638184447044'),(38,1,'hey','false',8,'1638184524577'),(39,1,'new ','false',8,'1638184535701'),(40,1,'h','false',8,'1638184785140'),(41,1,'Hello','false',8,'1638594649238'),(42,1,'Hello','false',4,'1638594668901'),(43,1,'https://sxy5732.uta.cloud/WDM//uploads/315083-logo512.png','true',8,'1638676829616'),(44,1,'https://sxy5732.uta.cloud/WDM//uploads/457352-logo512.png','true',8,'1638676908297'),(45,1,'https://sxy5732.uta.cloud/WDM//uploads/380643-logo192.png','true',8,'1638677014227'),(46,1,'https://sxy5732.uta.cloud/WDM//uploads/815605-favicon.ico','true',8,'1638738496735'),(47,1,'https://sxy5732.uta.cloud/WDM//uploads/959881-logo512.png','true',8,'1638738562310'),(48,1,'https://sxy5732.uta.cloud/WDM//uploads/718508-logo512.png','true',8,'1638738584319'),(49,1,'https://sxy5732.uta.cloud/WDM//uploads/393605-ban2.jpeg','true',4,'1638738612027'),(50,1,'hello','false',4,'1638739225121'),(51,1,'hello , I have some issues...','false',8,'1638741328639'),(52,1,'Yes please, I am here to help.','false',4,'1638741356407');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `service_type` varchar(50) NOT NULL,
  `date` date DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `pickup_address` varchar(100) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `tax` float DEFAULT NULL,
  `penalty` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `payment_type` varchar(20) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `order_type` varchar(50) DEFAULT NULL,
  `pickup_time` time DEFAULT NULL,
  `delivery_time` time DEFAULT NULL,
  `customer_pickup_time` time DEFAULT NULL,
  `delayed_pickup` varchar(200) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_servicetype` (`service_type`),
  CONSTRAINT `orders_servicetype` FOREIGN KEY (`service_type`) REFERENCES `service_types` (`service_type`)
) ENGINE=InnoDB AUTO_INCREMENT=120 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (10,8,'Iron','2021-11-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(11,8,'Wash/Dry','2021-11-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(12,8,'Wash/Dry','2021-11-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(13,8,'Iron','2021-11-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(14,8,'Dry','2021-11-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(16,8,'Iron','2021-11-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(17,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(18,8,'Iron','2021-01-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(19,8,'Wash/Dry','2021-01-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(20,8,'Wash/Dry','2021-01-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(21,8,'Iron','2021-01-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(22,8,'Dry','2021-01-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(23,8,'Iron','2021-01-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(24,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(25,8,'Iron','2021-01-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(26,8,'Wash/Dry','2021-01-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(27,8,'Wash/Dry','2021-01-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(28,8,'Iron','2021-01-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(29,8,'Dry','2021-01-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(30,8,'Iron','2021-01-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(31,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(32,8,'Iron','2021-01-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(33,8,'Wash/Dry','2021-01-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(34,8,'Wash/Dry','2021-01-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(35,8,'Iron','2021-01-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(36,8,'Dry','2021-01-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(37,8,'Iron','2021-01-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(38,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(39,8,'Iron','2021-01-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(40,8,'Wash/Dry','2021-01-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(41,8,'Wash/Dry','2021-01-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(42,8,'Iron','2021-01-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(43,8,'Dry','2021-01-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(44,8,'Iron','2021-01-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(45,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(46,8,'Iron','2021-04-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(47,8,'Wash/Dry','2021-04-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(48,8,'Wash/Dry','2021-04-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(49,8,'Iron','2021-04-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(50,8,'Dry','2021-04-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(51,8,'Iron','2021-04-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(52,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(53,8,'Iron','2021-05-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(54,8,'Wash/Dry','2021-05-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(55,8,'Wash/Dry','2021-05-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(56,8,'Iron','2021-05-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(57,8,'Dry','2021-05-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(58,8,'Iron','2021-05-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(59,16,'Wash/Dry/Iron','2021-05-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(60,8,'Iron','2021-05-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(61,8,'Wash/Dry','2021-05-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(62,8,'Wash/Dry','2021-05-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(63,8,'Iron','2021-05-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(64,8,'Dry','2021-05-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(65,8,'Iron','2021-05-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(66,16,'Wash/Dry/Iron','2021-05-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(67,8,'Iron','2021-07-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(68,8,'Wash/Dry','2021-07-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(69,8,'Wash/Dry','2021-08-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(70,8,'Iron','2021-08-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(71,8,'Dry','2021-08-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(72,8,'Iron','2021-08-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(73,16,'Wash/Dry/Iron','2021-08-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(74,8,'Iron','2021-08-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(75,8,'Wash/Dry','2021-08-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(76,8,'Wash/Dry','2021-08-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(77,8,'Iron','2021-08-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(78,8,'Dry','2021-08-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(79,8,'Iron','2021-08-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(80,16,'Wash/Dry/Iron','2021-08-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(81,8,'Iron','2021-08-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(82,8,'Wash/Dry','2021-08-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(83,8,'Wash/Dry','2021-08-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(84,8,'Iron','2021-08-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(85,8,'Dry','2021-08-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(86,8,'Iron','2021-08-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(87,16,'Wash/Dry/Iron','2021-08-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(88,8,'Iron','2021-04-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(89,8,'Wash/Dry','2021-04-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(90,8,'Wash/Dry','2021-04-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(91,8,'Iron','2021-04-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(92,8,'Dry','2021-04-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(93,8,'Iron','2021-04-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(94,16,'Wash/Dry/Iron','2021-11-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(95,8,'Iron','2021-08-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(96,8,'Wash/Dry','2021-08-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(97,8,'Wash/Dry','2021-08-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(98,8,'Iron','2021-08-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(99,8,'Dry','2021-08-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(100,8,'Iron','2021-08-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(101,16,'Wash/Dry/Iron','2021-08-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(102,8,'Iron','2021-08-22',5,'timber brook',10,0.1,0,11,'Cash','completed','Online','07:20:00','10:20:00','00:00:00','','Accept'),(103,8,'Wash/Dry','2021-08-22',4,'Meadow',8,0.1,0,8.8,'Cash','completed','Online','10:12:00','12:12:00','00:00:00','','Reject'),(104,8,'Wash/Dry','2021-08-27',30,'Arli',60,0.1,0,66,'Cash','pending','Online','18:23:00','10:20:00','00:00:00','','Accept'),(105,8,'Iron','2021-08-29',12,'qwert',20,5,0,100,'Online',NULL,'Online','16:34:00','19:34:00','00:00:00','','Accept'),(106,8,'Dry','2021-08-29',4,'Meadow',20,5,0,100,'Cash',NULL,'Online','17:35:00','20:35:00','00:00:00','','NEW'),(107,8,'Iron','2021-08-30',50,'aaaaa',20,5,0,100,'Cash',NULL,'Online','17:37:00','20:37:00','00:00:00','','NEW'),(108,16,'Wash/Dry/Iron','2021-08-30',15,'Meadow',20,5,0,100,'Cash',NULL,'Online','02:26:00','05:26:00','00:00:00','','NEW'),(109,8,'Wash/Dry','2021-12-05',10,'Timber',20,5,0,100,'Cash',NULL,'Online','00:00:00','21:00:00','00:00:00','','NEW'),(110,8,'Wash/Dry/Iron','2021-12-05',50,'T',20,5,0,100,'Cash',NULL,'Online','00:00:00','21:00:00','00:00:00','','NEW'),(111,8,'Wash/Dry/Iron','2021-12-05',6,'tfhjgfhfhfg',12,0.75,0,12.75,'Cash',NULL,'Online','00:00:00','21:00:00','00:00:00','','NEW'),(112,11,'Wash/Dry','2021-12-05',4,'',8,0.5,0,8.5,'Cash',NULL,'Online','00:00:00','21:00:00','00:00:00','','NEW'),(113,11,'Wash/Dry/Iron','2021-12-06',4,'',8,0.5,0,8.5,'Cash',NULL,'Online','00:00:00','21:00:00','00:00:00','','NEW'),(114,8,'Wash/Dry','2021-12-04',10,'hjasgdjhasd',20,1.25,0,21.25,'Cash',NULL,'Online','22:47:00','01:47:00','00:00:00','','NEW'),(115,8,'Wash/Dry/Iron','2021-12-09',21,'asd',42,2.625,0,44.625,'Cash',NULL,'Online','14:02:00','14:02:00','00:00:00','','NEW'),(116,8,'Wash/Dry/Iron','2021-12-05',10,'Meadow 413',20,1.25,0,21.25,'Cash',NULL,'Online','20:21:00','23:21:00','00:00:00','','NEW'),(117,10,'Wash/Dry','2021-12-06',30,'',60,3.75,0,63.75,'Cash',NULL,'Online','17:28:00','20:28:00','00:00:00','','NEW'),(118,8,'Wash/Dry','2021-12-05',10,'Meadow',20,1.25,0,21.25,'Cash',NULL,'Online','15:50:00','18:50:00','00:00:00','','NEW'),(119,8,'Wash/Dry','2021-12-05',12,'Meadow 413',24,1.5,0,25.5,'Cash',NULL,'Online','16:52:00','19:52:00','00:00:00','','Accept');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penaltyrate`
--

DROP TABLE IF EXISTS `penaltyrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penaltyrate` (
  `Unit_In_Hour` int NOT NULL,
  `Amount` float NOT NULL,
  UNIQUE KEY `Unit_In_Hour` (`Unit_In_Hour`)
) ENGINE=InnoDB ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penaltyrate`
--

LOCK TABLES `penaltyrate` WRITE;
/*!40000 ALTER TABLE `penaltyrate` DISABLE KEYS */;
/*!40000 ALTER TABLE `penaltyrate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnels`
--

DROP TABLE IF EXISTS `personnels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `doj` date DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(14) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `ssn` varchar(9) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `mobile_no` int DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ssn` (`ssn`)
) ENGINE=InnoDB AUTO_INCREMENT=9 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personnels`
--

LOCK TABLES `personnels` WRITE;
/*!40000 ALTER TABLE `personnels` DISABLE KEYS */;
INSERT INTO `personnels` VALUES (1,'Admin','2021-01-01','admin@iw.com','test1234','admin','111111234','male','test',1234567890,'https://sxy5732.uta.cloud/WDM//uploads/121978-screen-shot-2021-11-17-at-10.02.49-pm.png'),(4,'sandeep','2021-11-21','sandeep@iw.com','test1234','manager','1234','Male','Meadow Run',1234567890,'https://sxy5732.uta.cloud/WDM//uploads/696464-download.jpeg'),(6,'Kunal','2021-11-21','kunal@gmail.com','1234567890','Cashier','5124','Male','Timber',1234567890,NULL),(8,'Kunal','2021-11-22','kunal1@gmail.com','test1234','LaundryMan','1212','Male','fghjkl',1234567890,'https://sxy5732.uta.cloud/WDM/admin/default.png');
/*!40000 ALTER TABLE `personnels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_types`
--

DROP TABLE IF EXISTS `service_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_type` varchar(50) NOT NULL,
  `rate_per_pound` int DEFAULT NULL,
  PRIMARY KEY (`id`,`service_type`),
  UNIQUE KEY `title` (`service_type`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_types`
--

LOCK TABLES `service_types` WRITE;
/*!40000 ALTER TABLE `service_types` DISABLE KEYS */;
INSERT INTO `service_types` VALUES (1,'Wash/Dry/Iron',2),(2,'Wash/Dry',2),(3,'Iron',2),(4,'Dry',2);
/*!40000 ALTER TABLE `service_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-20 20:09:51
