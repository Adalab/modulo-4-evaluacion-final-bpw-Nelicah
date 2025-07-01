CREATE DATABASE  IF NOT EXISTS `simpsons` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `simpsons`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: simpsons
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `capitulos`
--

DROP TABLE IF EXISTS `capitulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(1000) NOT NULL,
  `numero_episodio` tinyint NOT NULL,
  `temporada` tinyint NOT NULL,
  `fecha_emision` date DEFAULT NULL,
  `sinopsis` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos`
--

LOCK TABLES `capitulos` WRITE;
/*!40000 ALTER TABLE `capitulos` DISABLE KEYS */;
INSERT INTO `capitulos` VALUES (1,'Bart el Genio',2,1,'1990-01-14','Bart hace trampa en una prueba y termina en una escuela para niños superdotados.'),(2,'Quién mató al Sr. Burns (Parte 1)',25,6,'1995-05-21','El Sr. Burns es herido misteriosamente, y todos son sospechosos.');
/*!40000 ALTER TABLE `capitulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capitulos_has_personajes`
--

DROP TABLE IF EXISTS `capitulos_has_personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos_has_personajes` (
  `fk_capitulos` int NOT NULL,
  `fk_personajes` int NOT NULL,
  PRIMARY KEY (`fk_capitulos`,`fk_personajes`),
  KEY `fk_capitulos_has_personajes_personajes1_idx` (`fk_personajes`),
  KEY `fk_capitulos_has_personajes_capitulos1_idx` (`fk_capitulos`),
  CONSTRAINT `fk_capitulos_has_personajes_capitulos1` FOREIGN KEY (`fk_capitulos`) REFERENCES `capitulos` (`id`),
  CONSTRAINT `fk_capitulos_has_personajes_personajes1` FOREIGN KEY (`fk_personajes`) REFERENCES `personajes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos_has_personajes`
--

LOCK TABLES `capitulos_has_personajes` WRITE;
/*!40000 ALTER TABLE `capitulos_has_personajes` DISABLE KEYS */;
INSERT INTO `capitulos_has_personajes` VALUES (1,1),(1,2),(2,2),(2,3);
/*!40000 ALTER TABLE `capitulos_has_personajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frases`
--

DROP TABLE IF EXISTS `frases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `texto` varchar(100) NOT NULL,
  `marca_tiempo` time DEFAULT NULL,
  `descripcion` longtext,
  `fk_personajes` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_frases_personajes_idx` (`fk_personajes`),
  CONSTRAINT `fk_frases_personajes` FOREIGN KEY (`fk_personajes`) REFERENCES `personajes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frases`
--

LOCK TABLES `frases` WRITE;
/*!40000 ALTER TABLE `frases` DISABLE KEYS */;
INSERT INTO `frases` VALUES (1,'¡D\'oh!','00:01:15','Frase característica de Homer al cometer errores.',1),(2,'¡Ay caramba!','00:02:30','Exclamación habitual de Bart.',2),(3,'¡Yo no fui!',NULL,'Una de las frases más repetidas por Bart cuando se mete en problemas.',2),(4,'Excelente...','00:04:42','Frase siniestra del Sr. Burns cuando algo sale según su plan.',3);
/*!40000 ALTER TABLE `frases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes`
--

DROP TABLE IF EXISTS `personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `ocupacion` varchar(100) NOT NULL,
  `descripcion` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes`
--

LOCK TABLES `personajes` WRITE;
/*!40000 ALTER TABLE `personajes` DISABLE KEYS */;
INSERT INTO `personajes` VALUES (1,'Homer','Simpson','Inspector de seguridad en la planta nuclear','Ama la cerveza, los donuts y dormir en el trabajo.'),(2,'Bart','Simpson','Estudiante','Rebelde, bromista y fan del skate.'),(3,'Sr.','Burns','Dueño de la planta nuclear','Multimillonario y malvado jefe de Homer.');
/*!40000 ALTER TABLE `personajes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01 10:33:48
