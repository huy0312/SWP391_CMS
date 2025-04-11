-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cmslvl10_db
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES (1,1,'2023-11-30 07:29:25',NULL,_binary '',7,'2023-11-16 00:35:54',7,'2023-11-16 00:35:54',1,'Assignment 1');
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `chapter`
--

LOCK TABLES `chapter` WRITE;
/*!40000 ALTER TABLE `chapter` DISABLE KEYS */;
INSERT INTO `chapter` VALUES (1,'Chapter 1. Introduction',3,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:09:15',1),(2,'Chapter 1. History',4,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:12:46',1),(3,'Chapter 1. Introduction',5,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:13:42',1),(4,'Chapter 1. Introduction',6,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:14:43',1),(5,'Chapter 1. Introduction',7,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:15:21',1),(6,'Chapter 1. Introduction',8,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:16:07',1),(7,'Chapter 1. Introduction',9,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:16:47',1),(8,'Chapter 2. Basics',3,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:10:47',2),(9,'Chapter 2. Theory',4,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:12:46',2),(10,'Chapter 2. Data Type',5,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:13:42',2),(11,'Chapter 2. History',6,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:14:43',2),(12,'Chapter 2. Loop',7,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:15:21',2),(13,'Chapter 2. Definition',8,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:16:07',2),(14,'Chapter 2. Matrix',9,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:16:47',2),(15,'Chapter 3. Advance',3,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:11:18',3),(16,'Chapter 3. Practice',4,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:12:46',3),(17,'Chapter 3. Naming Convention',5,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:13:42',3),(18,'Chapter 3. Feature',6,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:14:43',3),(19,'Chapter 3. Regression',7,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:15:21',3),(20,'Chapter 3. Theory',8,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:16:07',3),(21,'Chapter 3. Matrix Advanced',9,_binary '',NULL,'2023-10-04 15:59:36',NULL,'2023-11-16 00:16:47',3);
/*!40000 ALTER TABLE `chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'SE1742',5,3,7,_binary '',6,'2023-10-23 18:09:49',NULL,'2023-11-01 08:50:36'),(2,'SE1743',5,4,7,_binary '',6,'2023-10-23 18:10:31',NULL,'2023-11-01 08:50:36'),(3,'SE1744',5,5,6,_binary '',6,'2023-10-23 19:38:14',NULL,'2023-10-23 19:38:14'),(4,'SE1745',5,6,6,_binary '',6,'2023-10-23 19:38:14',NULL,'2023-10-23 19:38:14');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `class_student`
--

LOCK TABLES `class_student` WRITE;
/*!40000 ALTER TABLE `class_student` DISABLE KEYS */;
INSERT INTO `class_student` VALUES (1,49,_binary '',NULL,6,'2023-10-23 19:34:44',NULL,'2023-10-23 19:34:44'),(2,49,_binary '',NULL,6,'2023-10-23 19:34:44',NULL,'2023-10-23 19:34:44'),(3,49,_binary '',NULL,49,'2023-11-06 22:17:20',NULL,'2023-11-06 22:17:20');
/*!40000 ALTER TABLE `class_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dimension`
--

LOCK TABLES `dimension` WRITE;
/*!40000 ALTER TABLE `dimension` DISABLE KEYS */;
INSERT INTO `dimension` VALUES (1,'Skill','Listening',NULL,3,_binary '',NULL,'2023-10-18 07:19:36',NULL,'2023-10-18 07:19:36'),(2,'Skill','Speaking',NULL,3,_binary '',NULL,'2023-10-18 07:19:36',NULL,'2023-10-18 07:19:36'),(3,'Skill','Reading',NULL,3,_binary '',NULL,'2023-10-18 07:19:36',NULL,'2023-10-18 07:19:36'),(4,'Skill','Writing',NULL,3,_binary '',NULL,'2023-10-18 07:19:36',NULL,'2023-10-18 07:19:36'),(5,'Domain','General',NULL,3,_binary '',NULL,'2023-10-18 07:20:39',NULL,'2023-10-18 07:20:39'),(6,'Domain','IT for SE',NULL,3,_binary '',NULL,'2023-10-18 07:20:39',NULL,'2023-11-16 00:18:48'),(7,'Domain','IT for AI',NULL,3,_binary '',NULL,'2023-10-18 07:20:39',NULL,'2023-11-16 00:18:48');
/*!40000 ALTER TABLE `dimension` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `discussion`
--

LOCK TABLES `discussion` WRITE;
/*!40000 ALTER TABLE `discussion` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (2,'Grade for Quiz 1',1,10,NULL,49,2,NULL,49,'2023-11-15 22:22:41',49,'2023-11-15 23:20:43',1,2),(3,'Grade for Quiz 1',1,10,NULL,7,2,NULL,7,'2023-11-15 23:22:25',NULL,'2023-11-15 23:22:25',1,1);
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;
INSERT INTO `lesson` VALUES (1,'Lesson 1. Introduction to Java Web Application',_binary 'https://www.youtube.com/watch?v=IDDmrzzB14M&list=PLhQjrBD2T380F_inVRXMIHCqLaNUd7bN4',NULL,'',_binary '',1,6,'2023-10-05 16:33:47',6,'2023-11-16 00:22:47',NULL,1,1),(3,'Lesson 3',NULL,NULL,NULL,_binary '',3,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',2,2,1),(4,'Lesson 4',NULL,NULL,NULL,_binary '',4,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,3,1),(5,'Lesson 5',NULL,NULL,NULL,_binary '',5,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',3,2,1),(6,'Lesson 6',NULL,NULL,NULL,_binary '',6,6,'2023-10-05 16:33:47',6,'2023-11-06 09:41:34',NULL,1,1),(7,'Lesson 7',NULL,NULL,NULL,_binary '',7,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,1,1),(8,'Lesson 8',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ornare suspendisse sed nisi lacus sed viverra tellus. Lacus viverra vitae congue eu consequat ac felis. Maecenas accumsan lacus vel facilisis volutpat est velit. Curabitur vitae nunc sed velit dignissim sodales. Quis viverra nibh cras pulvinar. A iaculis at erat pellentesque adipiscing commodo elit. Ipsum a arcu cursus vitae congue. Quis viverra nibh cras pulvinar. Ut porttitor leo a diam sollicitudin. Adipiscing bibendum est ultricies integer quis auctor. At tellus at urna condimentum mattis pellentesque. Pellentesque nec nam aliquam sem et. Dapibus ultrices in iaculis nunc sed augue. Malesuada fames ac turpis egestas. Nunc vel risus commodo viverra maecenas.</p><p>Tristique senectus et netus et malesuada fames ac turpis egestas. Vitae ultricies leo integer malesuada nunc vel risus. Vel eros donec ac odio tempor orci dapibus ultrices in. Sit amet nisl suscipit adipiscing bibendum. Ornare lectus sit amet est. Convallis convallis tellus id interdum velit. Magna ac placerat vestibulum lectus mauris. Aliquet enim tortor at auctor urna nunc id. Vitae ultricies leo integer malesuada nunc vel risus commodo. Convallis tellus id interdum velit laoreet id donec ultrices. Neque vitae tempus quam pellentesque nec nam.</p>',_binary '',8,6,'2023-10-05 16:33:47',6,'2023-11-06 09:41:34',2,2,1),(9,'Lesson 9',NULL,NULL,NULL,_binary '',9,6,'2023-10-05 16:33:47',6,'2023-11-06 09:41:34',NULL,3,1),(10,'Lesson 10',NULL,NULL,NULL,_binary '',10,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,3,1),(11,'Lesson 11',NULL,NULL,NULL,_binary '',11,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,1,1),(12,'Lesson 12',NULL,NULL,NULL,_binary '',12,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',5,2,1),(13,'Lesson 13',NULL,NULL,NULL,_binary '',13,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',6,2,1),(14,'Lesson 14',NULL,NULL,NULL,_binary '',14,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,3,1),(15,'Lesson 15',NULL,NULL,NULL,_binary '',15,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,1,1),(16,'Lesson 16',NULL,NULL,NULL,_binary '',16,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,3,1),(17,'Lesson 17',NULL,NULL,NULL,_binary '',17,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',2,2,1),(18,'Lesson 18',NULL,NULL,NULL,_binary '',18,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,1,1),(19,'Lesson 19',NULL,NULL,NULL,_binary '',19,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,1,1),(20,'Lesson 20',NULL,NULL,NULL,_binary '',20,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',3,2,1),(21,'Lesson 21',NULL,NULL,NULL,_binary '',21,6,'2023-10-05 16:33:47',NULL,'2023-11-06 09:41:34',NULL,1,1),(33,'Lesson 2. Assignment 1',NULL,_binary 'D:\\Workspace\\SWP391\\cmslvl10_clone\\build\\web\\view\\assets\\lessons\\assignments\\chapter1\\061023_homework.txt','',_binary '',1,6,'2023-10-22 13:54:40',6,'2023-11-16 00:23:29',NULL,3,4),(39,'Lesson 3. Progress Test',NULL,NULL,'',_binary '\0',1,6,'2023-10-26 18:03:29',NULL,'2023-11-16 00:23:29',2,2,6),(41,'Lesson Test 3',_binary 'https://www.youtube.com/watch?v=NG3YyVNyKUk',NULL,'<p>Content demo 3</p>',_binary '',2,6,'2023-10-27 01:54:48',6,'2023-10-29 18:18:49',NULL,1,1),(48,'Lesson 4. Extra Test 1',NULL,NULL,'',_binary '\0',1,7,'2023-11-06 09:51:19',7,'2023-11-16 00:23:29',3,2,1),(53,'Lesson 1 CT8',NULL,NULL,'hi',_binary '',8,6,'2023-11-06 19:51:17',6,'2023-11-07 00:05:13',5,2,2),(54,'Lesson 2 CT8',NULL,_binary 'D:\\Workspace\\SWP391\\cmslvl10_clone\\build\\web\\view\\assets\\lessons\\assignments\\chapter8\\lab4.docx','                                                                                                                                                            \r\n                                                \r\n                                                \r\n                                                ',_binary '',8,6,'2023-11-06 20:13:52',6,'2023-11-06 20:28:11',NULL,3,3),(56,'Title demo',NULL,_binary 'D:\\Workspace\\SWP391\\cmslvl10_clone\\build\\web\\view\\assets\\lessons\\assignments\\chapter8\\Combrisi’s Hiphop Inspired Textures in Chrome + Explorative Motion Type - TYPE01.png','                                                    <p><b><u>Content demo </u></b></p>\r\n                                                ',_binary '',8,6,'2023-11-07 00:04:23',6,'2023-11-07 00:06:02',NULL,3,7);
/*!40000 ALTER TABLE `lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'Identify correct statement about a WAR file.(Choose one)',NULL,NULL,_binary '',6,'2023-10-18 07:45:48',NULL,'2023-11-16 00:27:57',1,1,1,3),(2,'A parameter is defined in a <context-param> element of the deployment descriptor for a web application. Which of the following statements is correct?',NULL,NULL,_binary '',6,'2023-10-18 07:45:48',NULL,'2023-11-16 00:27:57',1,1,1,3),(3,'Which of the following method calls can be used to retrieve an object from the session that was stored using the name \"roleName\"?',NULL,NULL,_binary '',6,'2023-10-18 07:45:48',NULL,'2023-11-16 00:27:57',1,1,1,3),(4,'Which is NOT a standard technique for a session be definitely invalidated?',NULL,NULL,_binary '',6,'2023-10-18 07:45:48',NULL,'2023-11-16 00:27:57',1,1,1,3),(5,'Which method can be invoked on a session object so that it is never invalidated by the servlet container automatically?',NULL,NULL,_binary '',6,'2023-10-18 07:45:48',NULL,'2023-11-16 00:27:57',2,1,1,3),(6,'Session death is more likely to come about through a time-out mechanism. If there is no activity on a session for a predefined length of time, the web container invalidates the session.',NULL,NULL,_binary '',6,'2023-10-18 07:45:48',NULL,'2023-11-16 00:27:57',2,1,1,3);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `question_answer`
--

LOCK TABLES `question_answer` WRITE;
/*!40000 ALTER TABLE `question_answer` DISABLE KEYS */;
INSERT INTO `question_answer` VALUES (1,'A. It is an XML document.',_binary '\0',1,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:26:03'),(2,'B. It cannot be unpackaged by the container.',_binary '\0',1,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:26:03'),(3,'C. It is used by web application developer to deliver the web application in a single unit.',_binary '\0',1,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:26:03'),(4,'D. It contains web components such as servlets as well as EJBs.',_binary '',1,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:26:03'),(5,'A. It is accessible to all the servlets of the webapp.',_binary '',2,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(6,'B. It is accessible to all the servlets of all the webapps of the container.',_binary '\0',2,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(7,'C. It is accessible only to the servlet it is defined for.',_binary '\0',2,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(8,'D. If the session time out is set to 0 using setMaxInactiveInterval() method.',_binary '\0',2,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(9,'A. getObject(\"roleName\");',_binary '\0',3,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(10,'B. getValue(\"roleName\");',_binary '\0',3,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(11,'C. get(\"roleName\");',_binary '\0',3,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(12,'D. getAttribute(\"roleName\");',_binary '',3,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(13,'A. The container is shutdown and brought up again.',_binary '',4,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(14,'B. No request comes from the client for more than \"session timeout\" period.',_binary '\0',4,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(15,'C. A servlet explicitly calls invalidate() on a session object.',_binary '\0',4,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00'),(16,'D. If the session time out is set to 0 using setMaxInactiveInterval() method.',_binary '\0',4,NULL,'2023-11-15 08:43:54',NULL,'2023-11-16 00:28:00');
/*!40000 ALTER TABLE `question_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (2,'Progress Test 1',NULL,_binary '',3,6,'2023-10-18 07:14:35',6,'2023-11-16 00:29:25',45,8),(3,'Progress Test 2',NULL,_binary '',3,6,'2023-10-18 07:14:35',NULL,'2023-11-16 00:29:25',40,8),(4,'Practical Test ',NULL,_binary '',3,6,'2023-10-18 07:14:35',NULL,'2023-11-16 00:29:25',60,8),(5,'Extra Practical Test',NULL,_binary '\0',3,6,'2023-10-18 07:14:35',NULL,'2023-11-16 00:29:25',45,8),(6,'Quiz 5',NULL,_binary '',3,6,'2023-10-18 07:14:35',NULL,'2023-10-30 17:16:02',120,8);
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `quiz_config`
--

LOCK TABLES `quiz_config` WRITE;
/*!40000 ALTER TABLE `quiz_config` DISABLE KEYS */;
INSERT INTO `quiz_config` VALUES (2,2,5,10,1,_binary '',6,'2023-10-18 07:40:21',NULL,'2023-10-18 07:40:21'),(3,3,6,10,1,_binary '',6,'2023-10-18 07:40:21',NULL,'2023-10-18 07:40:21'),(4,4,7,10,1,_binary '',6,'2023-10-18 07:40:21',NULL,'2023-10-18 07:40:21');
/*!40000 ALTER TABLE `quiz_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `quiz_question`
--

LOCK TABLES `quiz_question` WRITE;
/*!40000 ALTER TABLE `quiz_question` DISABLE KEYS */;
INSERT INTO `quiz_question` VALUES (2,2,1,6,'2023-10-18 07:47:06',NULL,'2023-10-18 07:47:06'),(3,2,2,6,'2023-10-18 07:47:06',NULL,'2023-10-18 07:47:06'),(4,2,3,6,'2023-10-18 07:47:06',NULL,'2023-10-18 07:47:06'),(5,2,4,6,'2023-10-18 07:47:06',NULL,'2023-10-18 07:47:06'),(6,3,5,6,'2023-10-18 07:47:06',NULL,'2023-10-18 07:47:06'),(7,3,6,6,'2023-10-18 07:47:06',NULL,'2023-10-18 07:47:06');
/*!40000 ALTER TABLE `quiz_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (1,'Role','Administrator','1',1,NULL,_binary '',NULL,'2023-09-18 10:28:59',NULL,'2023-09-18 10:28:59'),(2,'Role','Subject Manager','2',2,NULL,_binary '',NULL,'2023-09-18 10:29:00',NULL,'2023-09-18 10:29:00'),(3,'Role','Trainer','3',3,NULL,_binary '',NULL,'2023-09-18 10:29:00',NULL,'2023-09-18 10:29:00'),(4,'Role','Trainee','4',4,NULL,_binary '',NULL,'2023-09-18 10:29:00',NULL,'2023-09-18 10:29:00'),(5,'Semester','FA23','1',2,'',_binary '',19,'2023-09-28 08:28:10',NULL,'2023-11-15 23:58:19'),(6,'Semester','SU23','2',1,'',_binary '',19,'2023-09-28 16:13:04',NULL,'2023-11-15 23:58:12'),(7,'Quiz Type','Random','1',1,NULL,_binary '',NULL,'2023-10-30 17:05:29',NULL,'2023-10-30 17:05:29'),(8,'Quiz Type','Select','2',1,NULL,_binary '',NULL,'2023-10-30 17:05:29',NULL,'2023-10-30 17:05:29');
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (3,'SWP391','Java Web',6,_binary '',19,'2023-09-28 11:02:49',19,'2023-10-18 18:27:46',NULL),(4,'PRJ301','Java Web Basic',6,_binary '',19,'2023-09-28 11:02:49',19,'2023-10-18 18:27:46',NULL),(5,'SWT302','Sofware Testing',10,_binary '',19,'2023-09-28 11:02:49',19,'2023-10-18 18:27:46',NULL),(6,'SWR301','Software Requirements',10,_binary '',19,'2023-09-28 11:02:49',NULL,'2023-09-28 11:02:49',NULL),(7,'PRF192','	Programming Fundamentals',10,_binary '',19,'2023-09-28 11:45:39',NULL,'2023-11-16 00:31:28',NULL),(8,'LAB211','OOP with Java Lab	',6,_binary '',19,'2023-09-28 15:51:49',NULL,'2023-11-16 00:31:28',NULL),(9,'WED201c','Web Design',10,_binary '\0',19,'2023-09-28 15:52:41',19,'2023-11-16 00:31:37',NULL);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `submitted_assignment`
--

LOCK TABLES `submitted_assignment` WRITE;
/*!40000 ALTER TABLE `submitted_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `submitted_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (6,'Nguyen Van A','123','manager@gmail.com','0348514124',_binary '',_binary 'view/assets/img/profiles/avatar-6.png',NULL,'2023-09-18 10:33:43',19,'2023-11-16 00:33:23',2,''),(7,'Nguyen Van B','123','trainer@gmail.com','1234563112312',_binary '\0',_binary 'view/assets/img/profiles/052120231107.png',NULL,'2023-09-18 17:10:37',19,'2023-11-16 00:33:23',3,''),(10,'Nguyen Van C','123','huuhuy@fpt.edu.vn','0987654321',_binary '',_binary './view/assets/img/icon-user-default.png',NULL,'2023-09-22 01:23:11',19,'2023-11-16 00:32:41',2,''),(11,'Nguyen Van D','123','toantt@fpt.edu.vn','0987666666',_binary '\0',_binary './view/assets/img/icon-user-default.png',NULL,'2023-09-22 01:56:05',19,'2023-11-16 00:32:41',3,NULL),(19,'Administrator','123','cmslvl10@gmail.com','0123456788',_binary '',_binary 'view/assets/img/profiles/035320231109.png',NULL,'2023-09-25 07:58:47',19,'2023-11-08 20:53:05',1,''),(49,'Nguyen Van Huy','123','tranthetoan2003@gmail.com','01222333441',_binary '',_binary './view/assets/img/icon-user-default.png',19,'2023-10-09 13:50:15',NULL,'2023-11-16 00:32:41',4,NULL),(53,'Tran The Toan','123','tranttoan2003@fpt.vn','01231423534',_binary '',_binary './view/assets/img/icon-user-default.png',19,'2023-11-06 23:51:03',NULL,'2023-11-06 23:51:03',4,NULL),(54,'Do Van Cuong','2dVEsHnt','cuongdvhe170909@gmail.vn','0343451232',_binary '',_binary './view/assets/img/icon-user-default.png',19,'2023-11-06 23:53:10',NULL,'2023-11-06 23:53:10',4,NULL),(55,'Tran The Toan','wvTDaRjr','toantthe1231232@fpt.edu.vn','0912353234',_binary '',_binary './view/assets/img/icon-user-default.png',19,'2023-11-06 23:57:08',NULL,'2023-11-06 23:57:08',4,NULL),(56,'Nguyen Huu Huy','2JyWGBPk','huynh123@gmail.com','0334412352',_binary '',_binary './view/assets/img/icon-user-default.png',19,'2023-11-06 23:59:37',19,'2023-11-07 00:00:59',3,'Change role');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `video_progress`
--

LOCK TABLES `video_progress` WRITE;
/*!40000 ALTER TABLE `video_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_progress` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16  7:41:02
