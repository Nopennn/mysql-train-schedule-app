-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: new_trains_db
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_num` int NOT NULL,
  `car_number` int NOT NULL,
  `car_type` varchar(63) NOT NULL,
  `refund_allowed` varchar(63) NOT NULL,
  `pets_allowed` varchar(63) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `train_num` (`train_num`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`train_num`) REFERENCES `trip` (`train_number`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (1,126,1,'CL1','NO','YES'),(2,126,2,'CL1','NO','YES'),(3,126,3,'CL2','YES','NO'),(4,126,4,'CL2','YES','NO'),(5,126,5,'CL2','YES','YES'),(6,126,6,'CL2','YES','YES'),(7,126,7,'CL3','YES','NO'),(8,126,8,'CL3','YES','NO'),(9,126,9,'CL3','YES','NO'),(10,126,10,'CL3','YES','NO'),(11,126,11,'CL2','NO','NO'),(12,126,12,'CL2','YES','YES'),(13,36,1,'CL2','YES','NO'),(14,36,2,'CL2','YES','NO'),(15,36,3,'CL2','YES','NO'),(16,36,4,'CL3','YES','YES'),(17,36,5,'CL3','YES','YES'),(18,36,6,'CL3','YES','YES'),(19,36,7,'CL3','YES','NO'),(20,36,8,'CL3','YES','YES'),(21,36,9,'CL2','YES','YES');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_num` int NOT NULL,
  `trip_id` int NOT NULL,
  `station_name` varchar(255) NOT NULL,
  `arrival_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `train_num` (`train_num`),
  KEY `trip_id` (`trip_id`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`train_num`) REFERENCES `trip` (`train_number`),
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,126,1,'Moscow','2022-12-15 01:20:00'),(2,126,1,'Voronezh','2022-12-15 16:55:00'),(3,126,1,'Rostov','2022-12-15 23:20:00'),(4,126,1,'Kanaevskaya','2022-12-16 02:30:00'),(5,126,1,'Novorossiysk','2022-12-16 06:50:00'),(11,36,2,'Moscow','2022-12-16 00:45:00'),(12,36,2,'Ryazan','2022-12-16 03:39:00'),(13,36,2,'Usman','2022-12-17 09:50:00'),(14,36,2,'Voronezh','2022-12-17 11:14:00');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_number` int NOT NULL,
  `number_of_cars` int NOT NULL,
  `arrival_station` varchar(255) NOT NULL,
  `departure_station` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `train_number_idx` (`train_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,126,12,'Rostov','Moscow','2022-12-15'),(2,36,9,'Voronezh','Moscow','2022-12-16'),(3,126,12,'Kazan','Moscow','2022-12-18');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-29 10:06:46
