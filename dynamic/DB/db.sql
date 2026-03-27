-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: student_db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `dropdown_options`
--

DROP TABLE IF EXISTS `dropdown_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropdown_options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) DEFAULT NULL,
  `option_value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  CONSTRAINT `dropdown_options_ibfk_1` FOREIGN KEY (`field_name`) REFERENCES `form_configuration` (`field_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dropdown_options`
--

LOCK TABLES `dropdown_options` WRITE;
/*!40000 ALTER TABLE `dropdown_options` DISABLE KEYS */;
INSERT INTO `dropdown_options` VALUES (1,'college_name','Pune University'),(2,'college_name','Mumbai University'),(3,'college_name','Delhi University'),(4,'stream','Science'),(5,'stream','Arts'),(6,'stream','Commerce'),(7,'year','2025-2026');
/*!40000 ALTER TABLE `dropdown_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_configuration`
--

DROP TABLE IF EXISTS `form_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_configuration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) NOT NULL,
  `field_label` varchar(100) NOT NULL,
  `field_type` varchar(20) NOT NULL,
  `is_required` tinyint(1) DEFAULT '0',
  `display_order` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_name` (`field_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_configuration`
--

LOCK TABLES `form_configuration` WRITE;
/*!40000 ALTER TABLE `form_configuration` DISABLE KEYS */;
INSERT INTO `form_configuration` VALUES (1,'first_name','First Name','text',1,1,1),(2,'email','Email Address','email',1,2,1),(3,'college_name','College','select',1,6,1),(4,'stream','Stream','select',1,5,1),(5,'address','Address','text',1,4,1),(6,'year','Passing Year','select',1,8,1);
/*!40000 ALTER TABLE `form_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_information`
--

DROP TABLE IF EXISTS `student_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_information` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `college_name` varchar(100) DEFAULT NULL,
  `stream` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `year` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_information`
--

LOCK TABLES `student_information` WRITE;
/*!40000 ALTER TABLE `student_information` DISABLE KEYS */;
INSERT INTO `student_information` VALUES (1,'Shubham','shubhamdhangekar2014@gmail.com','string:Pune University','string:Science',NULL,NULL),(3,'Rohit ','rohit@gmail.com','string:Mumbai University',NULL,'sHIRSUPHAL',NULL),(4,NULL,NULL,NULL,NULL,NULL,NULL),(5,'abc','abc@gmail.com','string:Pune University',NULL,NULL,'string:2025-2026'),(6,'abc','abc@gmail.com','string:Pune University',NULL,NULL,'string:2025-2026'),(7,'abc123','abc@gmail.com','string:Pune University','string:Science','Plot 45, Industrial Area','string:2025-2026'),(8,'abc1234','abc@gmail.com','string:Pune University','string:Arts','Plot 45, Industrial Area','string:2025-2026'),(9,'abc12345','abc@gmail.com','Mumbai University','Science','Plot 45, Industrial Area','2025-2026');
/*!40000 ALTER TABLE `student_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'student_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-27 14:41:25
