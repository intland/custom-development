-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!50606 SET @OLD_INNODB_STATS_AUTO_RECALC=@@INNODB_STATS_AUTO_RECALC */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=OFF */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `codebeamer`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `codebeamer` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `codebeamer`;

--
-- Dumping routines for database 'codebeamer'
--

--
-- Current Database: `gtd_starc_int`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gtd_starc_int` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `gtd_starc_int`;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BLOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR` longblob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ENTRY_ID` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FIRED_TIME` bigint NOT NULL,
  `SCHED_TIME` bigint NOT NULL,
  `PRIORITY` int NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IS_NONCONCURRENT` tinyint(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IS_DURABLE` tinyint(1) NOT NULL,
  `IS_NONCONCURRENT` tinyint(1) NOT NULL,
  `IS_UPDATE_DATA` tinyint(1) NOT NULL,
  `REQUESTS_RECOVERY` tinyint(1) NOT NULL,
  `JOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint NOT NULL,
  `CHECKIN_INTERVAL` bigint NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REPEAT_COUNT` bigint NOT NULL,
  `REPEAT_INTERVAL` bigint NOT NULL,
  `TIMES_TRIGGERED` bigint NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `INT_PROP_1` int DEFAULT NULL,
  `INT_PROP_2` int DEFAULT NULL,
  `LONG_PROP_1` bigint DEFAULT NULL,
  `LONG_PROP_2` bigint DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` tinyint(1) DEFAULT NULL,
  `BOOL_PROP_2` tinyint(1) DEFAULT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint DEFAULT NULL,
  `PREV_FIRE_TIME` bigint DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `START_TIME` bigint NOT NULL,
  `END_TIME` bigint DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint DEFAULT NULL,
  `JOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_role`
--

DROP TABLE IF EXISTS `acl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ak_role_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_configuration`
--

DROP TABLE IF EXISTS `application_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_configuration` (
  `version_id` int NOT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `creation_date` datetime(3) NOT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`version_id`),
  KEY `app_con_creator_idx` (`created_by`),
  CONSTRAINT `app_con_creator_fk` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `artifact_uuid_registry`
--

DROP TABLE IF EXISTS `artifact_uuid_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artifact_uuid_registry` (
  `object_id` int NOT NULL,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `original_uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `artifact_uuid_u` (`uuid`),
  KEY `artifact_uuid_idx` (`uuid`,`object_id`),
  KEY `artifact_uuid_orig_idx` (`original_uuid`),
  CONSTRAINT `artifact_uuid_o_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_trail_logs`
--

DROP TABLE IF EXISTS `audit_trail_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_trail_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int DEFAULT NULL,
  `object_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `event_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `details` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `audit_trail_logs_u_idx` (`user_id`),
  KEY `audit_trail_logs_obj_idx` (`type_id`,`object_id`,`created_at`),
  KEY `audit_trail_logs_c_idx` (`created_at`,`event_type`),
  CONSTRAINT `audit_trail_logs_ufk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7672053 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_trail_logs_metadata`
--

DROP TABLE IF EXISTS `audit_trail_logs_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_trail_logs_metadata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audit_trail_logs_id` int NOT NULL,
  `key_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `key_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_trail_logs_m_u_idx` (`audit_trail_logs_id`),
  KEY `audit_trail_logs_m_obj_idx` (`key_name`,`key_value`),
  CONSTRAINT `audit_trail_logs_metadata_ufk` FOREIGN KEY (`audit_trail_logs_id`) REFERENCES `audit_trail_logs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22133423 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `background_job`
--

DROP TABLE IF EXISTS `background_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `submitted_by` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `background_job_type_st_idx` (`job_type`,`job_status`),
  KEY `background_job_submitted_by_fk_idx` (`submitted_by`),
  CONSTRAINT `background_job_submitted_by_fk` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `background_job_meta`
--

DROP TABLE IF EXISTS `background_job_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_job_meta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `background_meta_job_fk_idx` (`job_id`),
  CONSTRAINT `background_meta_job_fk` FOREIGN KEY (`job_id`) REFERENCES `background_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `background_step`
--

DROP TABLE IF EXISTS `background_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_step` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `step_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `step_processor_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `step_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `step_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `background_step_job_fk_idx` (`job_id`),
  CONSTRAINT `background_step_job_fk` FOREIGN KEY (`job_id`) REFERENCES `background_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `background_step_context`
--

DROP TABLE IF EXISTS `background_step_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_step_context` (
  `job_id` int NOT NULL,
  `context_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`job_id`),
  CONSTRAINT `background_context_job_fk` FOREIGN KEY (`job_id`) REFERENCES `background_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `background_step_result`
--

DROP TABLE IF EXISTS `background_step_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_step_result` (
  `step_id` int NOT NULL,
  `step_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `step_result_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`step_id`),
  CONSTRAINT `background_step_fk` FOREIGN KEY (`step_id`) REFERENCES `background_step` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_ops_mapping`
--

DROP TABLE IF EXISTS `chat_ops_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_ops_mapping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `channel_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_ops_mapping_id_idx` (`channel_id`),
  KEY `chat_ops_mapping_ext_idx` (`external_id`),
  CONSTRAINT `chat_ops_mapping_fk` FOREIGN KEY (`channel_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_ops_thread`
--

DROP TABLE IF EXISTS `chat_ops_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_ops_thread` (
  `item_id` int NOT NULL,
  `thread_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `chat_ops_thread_u_idx` (`user_id`),
  CONSTRAINT `chat_ops_thread_i_fk` FOREIGN KEY (`item_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `chat_ops_thread_u_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `color_field_temp_table`
--

DROP TABLE IF EXISTS `color_field_temp_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color_field_temp_table` (
  `data_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tracker_id` int NOT NULL,
  `field_id` int NOT NULL,
  PRIMARY KEY (`data_key`,`tracker_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comp_field_ref_temp_table`
--

DROP TABLE IF EXISTS `comp_field_ref_temp_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comp_field_ref_temp_table` (
  `data_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `item_id` int NOT NULL,
  `computed_tracker` int NOT NULL,
  `computed_field` int NOT NULL,
  PRIMARY KEY (`data_key`,`item_id`,`computed_tracker`,`computed_field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `computed_field_lookup`
--

DROP TABLE IF EXISTS `computed_field_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `computed_field_lookup` (
  `source_tracker_id` int NOT NULL,
  `computed_field_id` int NOT NULL,
  `referred_tracker_id` int NOT NULL,
  `referred_field_id` int NOT NULL,
  `referred_field_tracker_id` int NOT NULL,
  KEY `comp_s_tracker_fk_idx` (`source_tracker_id`),
  KEY `comp_r_tracker_fk_idx` (`referred_tracker_id`),
  KEY `comp_rf_tracker_fk_idx` (`referred_field_tracker_id`),
  CONSTRAINT `comp_r_tracker_fk` FOREIGN KEY (`referred_tracker_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comp_rf_tracker_fk` FOREIGN KEY (`referred_field_tracker_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comp_s_tracker_fk` FOREIGN KEY (`source_tracker_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `computed_update_job`
--

DROP TABLE IF EXISTS `computed_update_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `computed_update_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `computed_update_job_k_u` (`job_key`),
  KEY `comp_upd_job_u_fk_idx` (`user_id`),
  CONSTRAINT `comp_u_job_u_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `computed_update_job_item`
--

DROP TABLE IF EXISTS `computed_update_job_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `computed_update_job_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_tracker_id` int NOT NULL,
  `item_id` int NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `error_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comp_upd_job_i_job_key_tr_u` (`job_tracker_id`,`item_id`),
  KEY `comp_upd_job_i_tr_fk_idx` (`job_tracker_id`),
  KEY `comp_upd_job_i_fk_idx` (`item_id`),
  CONSTRAINT `comp_upd_job_i_fk` FOREIGN KEY (`item_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comp_upd_job_i_tr_fk` FOREIGN KEY (`job_tracker_id`) REFERENCES `computed_update_job_tracker` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `computed_update_job_tracker`
--

DROP TABLE IF EXISTS `computed_update_job_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `computed_update_job_tracker` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `tracker_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comp_upd_job_tr_job_key_tr_u` (`job_id`,`tracker_id`),
  KEY `comp_upd_job_tr_fk_idx` (`tracker_id`),
  KEY `comp_upd_job_tr_j_fk_idx` (`job_id`),
  CONSTRAINT `comp_upd_job_tr_fk` FOREIGN KEY (`tracker_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comp_upd_job_tr_j_fk` FOREIGN KEY (`job_id`) REFERENCES `computed_update_job` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_proj_stat`
--

DROP TABLE IF EXISTS `daily_proj_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_proj_stat` (
  `proj_id` int NOT NULL,
  `datum` date NOT NULL,
  `users` int DEFAULT NULL,
  `downloads` int DEFAULT NULL,
  `documents` int DEFAULT NULL,
  `document_new` int DEFAULT NULL,
  `document_edits` int DEFAULT NULL,
  `wikipages` int DEFAULT NULL,
  PRIMARY KEY (`proj_id`,`datum`),
  KEY `daily_pr_stat_dt` (`datum`),
  CONSTRAINT `daily_proj_stat_fk` FOREIGN KEY (`proj_id`) REFERENCES `existing` (`proj_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_tracker_stat`
--

DROP TABLE IF EXISTS `daily_tracker_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_tracker_stat` (
  `type_id` int NOT NULL,
  `datum` date NOT NULL,
  `open_count` int NOT NULL,
  `total_count` int NOT NULL,
  `submitted_count` int NOT NULL,
  `edited_count` int NOT NULL,
  `closed_count` int NOT NULL,
  `open_estimated_ms` bigint DEFAULT NULL,
  `open_spent_ms` bigint DEFAULT NULL,
  `closed_estimated_ms` bigint DEFAULT NULL,
  `closed_spent_ms` bigint DEFAULT NULL,
  PRIMARY KEY (`type_id`,`datum`),
  KEY `daily_tracker_dt` (`datum`),
  CONSTRAINT `daily_tracker_stat_fk` FOREIGN KEY (`type_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_cache`
--

DROP TABLE IF EXISTS `document_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_cache` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_id` int NOT NULL,
  `version` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `document_cache_document_id_idx` (`document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5433 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_cache_data`
--

DROP TABLE IF EXISTS `document_cache_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_cache_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_cache_id` int NOT NULL,
  `field_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `boost` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_stored` int NOT NULL,
  `is_analyzed` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `document_cache_id_idx` (`document_cache_id`),
  CONSTRAINT `document_cache_id_fk` FOREIGN KEY (`document_cache_id`) REFERENCES `document_cache` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6091 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_cache_data_blobs`
--

DROP TABLE IF EXISTS `document_cache_data_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_cache_data_blobs` (
  `id` int NOT NULL,
  `blob_data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `document_cache_data_blobs_fk` FOREIGN KEY (`id`) REFERENCES `document_cache_data` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `excel_import_settings`
--

DROP TABLE IF EXISTS `excel_import_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `excel_import_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `tracker_id` int NOT NULL,
  `json` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `excel_import_settings_user_id` (`user_id`),
  KEY `excel_import_settings_tracker_id` (`tracker_id`),
  CONSTRAINT `excel_import_settings_tracker_fk` FOREIGN KEY (`tracker_id`) REFERENCES `object` (`id`) ON DELETE CASCADE,
  CONSTRAINT `excel_import_settings_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `existing`
--

DROP TABLE IF EXISTS `existing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `existing` (
  `proj_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `key_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `propagation` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `mount_point` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `last_sync_at` datetime(3) DEFAULT NULL,
  `wiki_homepage_id` int DEFAULT NULL,
  `tracker_homepage_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`proj_id`),
  UNIQUE KEY `proj_name_ak` (`name`),
  UNIQUE KEY `existing_wiki_homepage_id` (`wiki_homepage_id`),
  UNIQUE KEY `existing_tracker_homepage_id` (`tracker_homepage_id`),
  UNIQUE KEY `existing_key_name` (`key_name`),
  KEY `existing_category_idx` (`category_id`),
  CONSTRAINT `existing_category_fk` FOREIGN KEY (`category_id`) REFERENCES `object` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `existing_trackers_homepage_fk` FOREIGN KEY (`tracker_homepage_id`) REFERENCES `object` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `existing_wiki_homepage_fk` FOREIGN KEY (`wiki_homepage_id`) REFERENCES `object` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `existing_object_map`
--

DROP TABLE IF EXISTS `existing_object_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `existing_object_map` (
  `proj_id` int NOT NULL,
  `object_id` int NOT NULL,
  PRIMARY KEY (`proj_id`),
  UNIQUE KEY `existing_object_map_unique_idx` (`proj_id`,`object_id`),
  UNIQUE KEY `existing_object_map_object_id_unique_idx` (`object_id`),
  CONSTRAINT `existing_object_map_object_id` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `existing_object_map_proj_id` FOREIGN KEY (`proj_id`) REFERENCES `existing` (`proj_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `export_content_blobs`
--

DROP TABLE IF EXISTS `export_content_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_content_blobs` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `export_content_blobs_fk` FOREIGN KEY (`id`) REFERENCES `export_job_report` (`export_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `export_job_report`
--

DROP TABLE IF EXISTS `export_job_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_job_report` (
  `export_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL,
  `state` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` datetime(3) DEFAULT NULL,
  `end_date` datetime(3) DEFAULT NULL,
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `temp_file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `request_json` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_convert_pdf` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_zip` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`export_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `export_template_blobs`
--

DROP TABLE IF EXISTS `export_template_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_template_blobs` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `export_template_blobs_fk` FOREIGN KEY (`id`) REFERENCES `export_job_report` (`export_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_recent_value`
--

DROP TABLE IF EXISTS `field_recent_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_recent_value` (
  `user_id` int NOT NULL,
  `tracker_id` int NOT NULL,
  `field_id` int NOT NULL,
  `recent_values` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`tracker_id`,`field_id`),
  KEY `recent_tracker_fk_idx` (`tracker_id`),
  KEY `recent_user_fk_idx` (`user_id`),
  CONSTRAINT `recent_tracker_fk` FOREIGN KEY (`tracker_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `recent_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_value_search_history`
--

DROP TABLE IF EXISTS `field_value_search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_value_search_history` (
  `task_id` int NOT NULL,
  `revision` int NOT NULL,
  `label_id` int NOT NULL,
  `choice_id` int DEFAULT NULL,
  KEY `field_value_search_r_fk_idx` (`task_id`,`revision`),
  CONSTRAINT `field_value_search_rev_fk` FOREIGN KEY (`task_id`, `revision`) REFERENCES `task_search_history` (`id`, `revision`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `group_member`
--

DROP TABLE IF EXISTS `group_member`;
/*!50001 DROP VIEW IF EXISTS `group_member`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `group_member` AS SELECT 
 1 AS `group_id`,
 1 AS `group_name`,
 1 AS `permissions`,
 1 AS `user_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `history_search_update`
--

DROP TABLE IF EXISTS `history_search_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_search_update` (
  `item_id` int DEFAULT NULL,
  KEY `history_search_update_item_idx` (`item_id`),
  CONSTRAINT `task_upg_hist_fk` FOREIGN KEY (`item_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `id_filter_temp_table`
--

DROP TABLE IF EXISTS `id_filter_temp_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `id_filter_temp_table` (
  `data_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `object_id` int NOT NULL,
  PRIMARY KEY (`data_key`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_permission_ref`
--

DROP TABLE IF EXISTS `item_permission_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_permission_ref` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `perm_object_id` int NOT NULL,
  `field_id` int NOT NULL,
  `type_id` int NOT NULL,
  `project_id` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_permission_ref_ak` (`item_id`,`perm_object_id`,`field_id`,`type_id`,`project_id`),
  KEY `item_permission_ref_item_fk_idx` (`item_id`),
  CONSTRAINT `item_permission_ref_item_fk` FOREIGN KEY (`item_id`) REFERENCES `task` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2774279 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `label`
--

DROP TABLE IF EXISTS `label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `label` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `private` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `hidden` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label_ak` (`private`,`created_by`,`name`),
  KEY `label_created_by` (`created_by`),
  CONSTRAINT `label_creator_fk` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=508 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locks`
--

DROP TABLE IF EXISTS `locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locks` (
  `lock_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `node_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `thread_id` bigint NOT NULL,
  UNIQUE KEY `lock_key_un` (`lock_key`),
  KEY `lock_id_lock_key_node_id_idx` (`lock_key`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `member_group`
--

DROP TABLE IF EXISTS `member_group`;
/*!50001 DROP VIEW IF EXISTS `member_group`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `member_group` AS SELECT 
 1 AS `user_id`,
 1 AS `group_id`,
 1 AS `group_name`,
 1 AS `permissions`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `member_project`
--

DROP TABLE IF EXISTS `member_project`;
/*!50001 DROP VIEW IF EXISTS `member_project`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `member_project` AS SELECT 
 1 AS `member_type`,
 1 AS `member_id`,
 1 AS `proj_id`,
 1 AS `role_id`,
 1 AS `permissions`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `monitoring_log`
--

DROP TABLE IF EXISTS `monitoring_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitoring_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NOT NULL,
  `node_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `details` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `monitoring_log_type_idx` (`log_type`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1679524 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_history`
--

DROP TABLE IF EXISTS `navigation_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_history` (
  `user_id` int NOT NULL,
  `proj_id` int DEFAULT NULL,
  `object_type_id` int NOT NULL,
  `object_id` int NOT NULL,
  `object_version` int DEFAULT NULL,
  `datum` datetime(3) NOT NULL,
  KEY `nav_history_proj_id` (`proj_id`),
  KEY `nav_hist_user_proj_id` (`user_id`,`proj_id`),
  KEY `nav_hist_obj_type_id` (`object_type_id`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `owner_id` int NOT NULL,
  `revision` int NOT NULL DEFAULT '1',
  `proj_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `reference_id` int DEFAULT NULL,
  `deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `obj_type` (`type_id`,`parent_id`),
  KEY `obj_created` (`owner_id`,`created_at`),
  KEY `object_ref_par_idx` (`type_id`,`reference_id`,`parent_id`),
  KEY `obj_proj_par_idx` (`proj_id`,`parent_id`),
  KEY `object_del_idx` (`id`,`deleted`),
  KEY `object_ref_id_idx` (`reference_id`,`type_id`,`deleted`),
  KEY `obj_parent_id` (`parent_id`,`type_id`,`reference_id`),
  KEY `obj_proj_type_idx` (`proj_id`,`type_id`,`reference_id`),
  CONSTRAINT `object_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `object` (`id`) ON DELETE CASCADE,
  CONSTRAINT `object_project_fk` FOREIGN KEY (`proj_id`) REFERENCES `existing` (`proj_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14329656 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_access_log`
--

DROP TABLE IF EXISTS `object_access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_access_log` (
  `object_id` int NOT NULL,
  `revision` int NOT NULL,
  `user_id` int NOT NULL,
  `access_at` datetime(3) NOT NULL,
  PRIMARY KEY (`object_id`,`revision`,`user_id`,`access_at`),
  KEY `object_access_user` (`user_id`,`access_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_access_permission`
--

DROP TABLE IF EXISTS `object_access_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_access_permission` (
  `object_id` int NOT NULL,
  `task_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `access_perms` int NOT NULL DEFAULT '0',
  `bit_mask` int DEFAULT NULL,
  `proj_id` int DEFAULT NULL,
  KEY `access_perm_object_id` (`object_id`),
  KEY `access_perm_role_id` (`role_id`),
  KEY `access_perm_proj_id` (`proj_id`),
  KEY `access_perm_task_o` (`task_id`,`object_id`),
  KEY `access_perm_task_id` (`task_id`),
  KEY `role_in_proj_idx` (`role_id`,`object_id`,`proj_id`,`access_perms`),
  CONSTRAINT `object_access_perm_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `object_access_proj_fk` FOREIGN KEY (`proj_id`) REFERENCES `existing` (`proj_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `object_access_role_fk` FOREIGN KEY (`role_id`) REFERENCES `acl_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `object_access_task_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_additional_info`
--

DROP TABLE IF EXISTS `object_additional_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_additional_info` (
  `object_id` int NOT NULL,
  `content_frozen` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `locked_by_user_id` int DEFAULT NULL,
  `approval_workflow_id` int DEFAULT NULL,
  `published_revision` int DEFAULT NULL,
  `kept_history_entries` int DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  KEY `object_approval_workflow_id` (`approval_workflow_id`),
  CONSTRAINT `object_additional_info_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `object_approval_workfl_fk` FOREIGN KEY (`approval_workflow_id`) REFERENCES `object_approval_workflow` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_approval_history`
--

DROP TABLE IF EXISTS `object_approval_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_approval_history` (
  `object_id` int NOT NULL,
  `revision` int NOT NULL,
  `approval_step_id` int DEFAULT NULL,
  `approval_step_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `approved_at` datetime(3) NOT NULL,
  `approver_id` int NOT NULL,
  `approved` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `approval_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  KEY `object_appr_history_date` (`approved_at`),
  KEY `object_appr_history_approved` (`approved`),
  KEY `object_appr_history_revision` (`object_id`,`revision`),
  KEY `object_approval_history_stp_id` (`approval_step_id`),
  KEY `object_approval_history_app_id` (`approver_id`),
  CONSTRAINT `obj_appr_hist_obj_fk` FOREIGN KEY (`object_id`, `revision`) REFERENCES `object_revision` (`object_id`, `revision`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `obj_appr_hist_step_fk` FOREIGN KEY (`approval_step_id`) REFERENCES `object_approval_step` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `obj_appr_hist_user_fk` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_approval_step`
--

DROP TABLE IF EXISTS `object_approval_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_approval_step` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `approval_workflow_id` int NOT NULL,
  `ordinal` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_approval_step_app_ord` (`approval_workflow_id`,`ordinal`),
  CONSTRAINT `obj_appr_step_wf_fk` FOREIGN KEY (`approval_workflow_id`) REFERENCES `object_approval_workflow` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_approval_workflow`
--

DROP TABLE IF EXISTS `object_approval_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_approval_workflow` (
  `id` int NOT NULL AUTO_INCREMENT,
  `proj_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_approval_created_by` (`created_by`),
  KEY `object_appr_wf_proj_id` (`proj_id`),
  CONSTRAINT `obj_appr_wf_crtr` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `obj_appr_wf_proj` FOREIGN KEY (`proj_id`) REFERENCES `existing` (`proj_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_approver`
--

DROP TABLE IF EXISTS `object_approver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_approver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `approval_step_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_approver_unq_user_role` (`approval_step_id`,`user_id`,`role_id`),
  KEY `object_approver_user_id` (`user_id`),
  KEY `object_approver_role_id` (`role_id`),
  CONSTRAINT `obj_appr_role_fk` FOREIGN KEY (`role_id`) REFERENCES `acl_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `obj_appr_step_fk` FOREIGN KEY (`approval_step_id`) REFERENCES `object_approval_step` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `obj_appr_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_association_type`
--

DROP TABLE IF EXISTS `object_association_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_association_type` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_job_schedule`
--

DROP TABLE IF EXISTS `object_job_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_job_schedule` (
  `object_id` int NOT NULL,
  `job_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_at` datetime(3) DEFAULT NULL,
  `next_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`object_id`,`job_name`),
  KEY `object_job_schedule_at` (`next_at`),
  CONSTRAINT `job_schedule_object_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_label`
--

DROP TABLE IF EXISTS `object_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_label` (
  `object_type_id` int NOT NULL,
  `object_id` int NOT NULL,
  `label_id` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  UNIQUE KEY `object_type_id` (`object_type_id`,`object_id`,`label_id`),
  KEY `object_label_label_id` (`label_id`),
  KEY `object_label_created_by` (`created_by`),
  CONSTRAINT `object_label_ibfk_1` FOREIGN KEY (`label_id`) REFERENCES `label` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `object_label_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_notification`
--

DROP TABLE IF EXISTS `object_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_notification` (
  `object_id` int NOT NULL,
  `task_id` int DEFAULT NULL,
  `event_mask` int DEFAULT NULL,
  `item_filter` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `only_members` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  KEY `notification_object_id` (`object_id`),
  KEY `notification_task_id` (`task_id`),
  KEY `notification_user_id` (`user_id`),
  KEY `notification_role_id` (`role_id`),
  CONSTRAINT `notification_object_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `notification_role_fk` FOREIGN KEY (`role_id`) REFERENCES `acl_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `notification_task_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `notification_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_quartz_schedule`
--

DROP TABLE IF EXISTS `object_quartz_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_quartz_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `object_id` int NOT NULL,
  `type_id` int NOT NULL,
  `group_id` int NOT NULL,
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `last_run` datetime(3) DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_quartz_schedule_u` (`object_id`,`created_by`),
  KEY `object_quartz_schedule_cb` (`created_by`),
  CONSTRAINT `object_quartz_schedule_cfk` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_rating`
--

DROP TABLE IF EXISTS `object_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_rating` (
  `entity_type_id` int NOT NULL,
  `entity_id` int NOT NULL,
  `submitter_id` int NOT NULL,
  `rate` int NOT NULL,
  `submitted_at` datetime(3) NOT NULL,
  PRIMARY KEY (`entity_type_id`,`entity_id`,`submitter_id`),
  KEY `object_rating_submitted_at` (`submitted_at`),
  KEY `object_rating_submitter_id` (`submitter_id`),
  CONSTRAINT `object_rating_submitter_fk` FOREIGN KEY (`submitter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_reference`
--

DROP TABLE IF EXISTS `object_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_reference` (
  `from_type_id` int NOT NULL,
  `from_id` int NOT NULL,
  `field_id` int NOT NULL,
  `assoc_id` int DEFAULT NULL,
  `ordinal` int DEFAULT NULL,
  `to_type_id` int DEFAULT NULL,
  `to_id` int DEFAULT NULL,
  `to_rev` int DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `deleted` int NOT NULL DEFAULT '0',
  `status_id` int NOT NULL DEFAULT '0',
  KEY `object_reference_field_to` (`from_id`,`to_type_id`,`field_id`),
  KEY `association_object_id` (`assoc_id`),
  KEY `object_reference_to` (`to_id`,`to_type_id`,`assoc_id`),
  KEY `object_reference_to_from` (`to_id`,`to_type_id`,`field_id`,`from_id`,`from_type_id`,`assoc_id`),
  KEY `object_reference_from` (`from_id`,`from_type_id`,`field_id`,`assoc_id`,`to_id`,`to_type_id`),
  KEY `object_reference_from2` (`from_id`,`from_type_id`,`to_type_id`,`to_id`,`assoc_id`),
  KEY `object_reference_to_from2` (`to_id`,`to_type_id`,`from_type_id`,`from_id`,`assoc_id`),
  CONSTRAINT `association_object_fk` FOREIGN KEY (`assoc_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_reference_filter`
--

DROP TABLE IF EXISTS `object_reference_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_reference_filter` (
  `object_id` int NOT NULL,
  `type_id` int NOT NULL,
  `qualifier` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `domain_type` int DEFAULT NULL,
  `domain_id` int DEFAULT NULL,
  `filter_id` int DEFAULT NULL,
  `flags` int NOT NULL DEFAULT '0',
  KEY `reference_filter_object_id` (`object_id`),
  KEY `reference_filter_domain_id` (`domain_type`,`domain_id`),
  KEY `reference_filter_filter_id` (`filter_id`),
  CONSTRAINT `reference_filter_filter_fk` FOREIGN KEY (`filter_id`) REFERENCES `object` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `reference_filter_object_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_revision`
--

DROP TABLE IF EXISTS `object_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_revision` (
  `object_id` int NOT NULL,
  `revision` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `created_by` int NOT NULL,
  `proj_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `parent_rev` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `desc_format` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `rev_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status_id` int DEFAULT NULL,
  `deleted` int NOT NULL DEFAULT '0',
  `type_id` int NOT NULL,
  PRIMARY KEY (`object_id`,`revision`),
  KEY `object_revision_project` (`proj_id`),
  KEY `object_revision_parent` (`parent_id`,`parent_rev`),
  KEY `object_revision_name` (`name`),
  KEY `object_revision_created` (`created_by`,`created_at`),
  KEY `object_revision_baseline` (`proj_id`,`deleted`,`type_id`,`object_id`,`revision`),
  KEY `object_revision_parent_del` (`parent_id`,`deleted`,`revision`),
  KEY `obj_rev_b_parent_idx` (`parent_id`,`proj_id`,`created_at`,`deleted`),
  KEY `obj_rev_b_type_idx` (`type_id`,`proj_id`,`created_at`,`deleted`),
  KEY `obj_rev_b_create_idx` (`object_id`,`created_at`,`revision`),
  CONSTRAINT `object_revision_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_revision_blobs`
--

DROP TABLE IF EXISTS `object_revision_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_revision_blobs` (
  `id` int NOT NULL,
  `revision` int NOT NULL,
  `blob_data` longblob NOT NULL,
  PRIMARY KEY (`id`,`revision`),
  CONSTRAINT `object_revision_blobs_fk` FOREIGN KEY (`id`, `revision`) REFERENCES `object_revision` (`object_id`, `revision`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_tag`
--

DROP TABLE IF EXISTS `object_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_tag` (
  `tag_id` int NOT NULL,
  `object_id` int NOT NULL,
  `revision` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `distance` int NOT NULL,
  PRIMARY KEY (`tag_id`,`object_id`),
  KEY `object_tag_parent` (`tag_id`,`parent_id`),
  KEY `object_tag_distance` (`tag_id`,`distance`),
  KEY `object_tag_revision` (`object_id`,`revision`),
  CONSTRAINT `tag_entity_fk` FOREIGN KEY (`tag_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `object_tag_v`
--

DROP TABLE IF EXISTS `object_tag_v`;
/*!50001 DROP VIEW IF EXISTS `object_tag_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `object_tag_v` AS SELECT 
 1 AS `object_id`,
 1 AS `revision`,
 1 AS `parent_id`,
 1 AS `proj_id`,
 1 AS `type_id`,
 1 AS `tag_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `order_id_idx_temp_table`
--

DROP TABLE IF EXISTS `order_id_idx_temp_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_id_idx_temp_table` (
  `data_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id` int NOT NULL,
  `idx` int NOT NULL,
  PRIMARY KEY (`data_key`,`id`,`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_view`
--

DROP TABLE IF EXISTS `page_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_view` (
  `id` int NOT NULL AUTO_INCREMENT,
  `view_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL,
  `link_metadata` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_access` datetime(3) NOT NULL,
  `type_id` int NOT NULL,
  `creation_version` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_view_key_usr_u` (`view_key`,`user_id`),
  KEY `page_view_access_idx` (`last_access`),
  KEY `page_view_tv_idx` (`type_id`,`creation_version`),
  KEY `page_view_usr_fk_idx` (`user_id`),
  CONSTRAINT `page_view_key_usr_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2355 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest`
--

DROP TABLE IF EXISTS `perftest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest` (
  `id` int NOT NULL AUTO_INCREMENT,
  `started_at` datetime(3) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1702 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_blob`
--

DROP TABLE IF EXISTS `perftest_blob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_blob` (
  `value` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_clob`
--

DROP TABLE IF EXISTS `perftest_clob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_clob` (
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_datetime`
--

DROP TABLE IF EXISTS `perftest_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_datetime` (
  `value` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_integer`
--

DROP TABLE IF EXISTS `perftest_integer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_integer` (
  `value` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_integer_idx`
--

DROP TABLE IF EXISTS `perftest_integer_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_integer_idx` (
  `value` int DEFAULT NULL,
  KEY `perftest_integer_idx_i` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_latency`
--

DROP TABLE IF EXISTS `perftest_latency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_latency` (
  `test_data` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_step`
--

DROP TABLE IF EXISTS `perftest_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_step` (
  `perftest_id` int NOT NULL,
  `step_id` int NOT NULL,
  `query_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `query` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `started_at` datetime(3) NOT NULL,
  `elapsed` int DEFAULT NULL,
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `explain_plan` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`perftest_id`,`step_id`),
  KEY `perftest_step_query_hash` (`query_hash`),
  CONSTRAINT `perftest_step_perftest_fk` FOREIGN KEY (`perftest_id`) REFERENCES `perftest` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perftest_varchar255`
--

DROP TABLE IF EXISTS `perftest_varchar255`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perftest_varchar255` (
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perm_object_user_mapping`
--

DROP TABLE IF EXISTS `perm_object_user_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perm_object_user_mapping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `project_id` int NOT NULL DEFAULT '-1',
  `perm_object_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `perm_object_user_mapping_ak` (`type_id`,`project_id`,`perm_object_id`,`user_id`),
  KEY `perm_object_user_mapping_user_fk_idx` (`user_id`),
  KEY `perm_object_user_mapping_assoc` (`perm_object_id`,`type_id`,`project_id`,`user_id`),
  CONSTRAINT `perm_object_user_mapping_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=132823 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permanent_link`
--

DROP TABLE IF EXISTS `permanent_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permanent_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unique_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `link_metadata` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `last_access` datetime NOT NULL,
  `type_id` int NOT NULL,
  `creation_version` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `perm_link_hash_u` (`unique_hash`),
  KEY `permanent_link_access_idx` (`last_access`),
  KEY `permanent_link_tv_idx` (`type_id`,`creation_version`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_met`
--

DROP TABLE IF EXISTS `profile_met`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_met` (
  `host_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `submitted_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `project`
--

DROP TABLE IF EXISTS `project`;
/*!50001 DROP VIEW IF EXISTS `project`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `project` AS SELECT 
 1 AS `id`,
 1 AS `proj_id`,
 1 AS `name`,
 1 AS `key_name`,
 1 AS `propagation`,
 1 AS `mount_point`,
 1 AS `last_sync_at`,
 1 AS `wiki_homepage_id`,
 1 AS `tracker_homepage_id`,
 1 AS `category_id`,
 1 AS `description`,
 1 AS `desc_format`,
 1 AS `flags`,
 1 AS `created_at`,
 1 AS `created_by`,
 1 AS `revision`,
 1 AS `last_modified_at`,
 1 AS `last_modified_by`,
 1 AS `rev_comment`,
 1 AS `category_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `project_activity_log`
--

DROP TABLE IF EXISTS `project_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_activity_log` (
  `proj_id` int NOT NULL,
  `user_id` int NOT NULL,
  `event_at` datetime(3) NOT NULL,
  `event_type` int NOT NULL,
  `obj_type` int NOT NULL,
  `obj_id` int NOT NULL,
  `obj_rev` int DEFAULT NULL,
  `event_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  KEY `proj_activity_log_idx` (`proj_id`,`event_at`),
  KEY `pobj_activity_log_idx` (`obj_type`,`obj_id`),
  KEY `user_activity_log_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `project_member`
--

DROP TABLE IF EXISTS `project_member`;
/*!50001 DROP VIEW IF EXISTS `project_member`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `project_member` AS SELECT 
 1 AS `proj_id`,
 1 AS `role_id`,
 1 AS `permissions`,
 1 AS `member_type`,
 1 AS `member_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `project_role`
--

DROP TABLE IF EXISTS `project_role`;
/*!50001 DROP VIEW IF EXISTS `project_role`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `project_role` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `proj_id`,
 1 AS `role_id`,
 1 AS `permissions`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `propagate_down_mapping`
--

DROP TABLE IF EXISTS `propagate_down_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propagate_down_mapping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assoc_id` int NOT NULL,
  `dependent_assocId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prop_down_m_a_fk_idx` (`assoc_id`),
  KEY `prop_down_m_da_fk_idx` (`dependent_assocId`),
  CONSTRAINT `prop_down_aid_assoc_fk` FOREIGN KEY (`assoc_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `prop_down_daid_assoc_fk` FOREIGN KEY (`dependent_assocId`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `propagate_up_mapping`
--

DROP TABLE IF EXISTS `propagate_up_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propagate_up_mapping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assoc_id` int NOT NULL,
  `dependent_assocId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prop_up_m_a_fk_idx` (`assoc_id`),
  KEY `prop_up_m_da_fk_idx` (`dependent_assocId`),
  CONSTRAINT `prop_up_aid_assoc_fk` FOREIGN KEY (`assoc_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `prop_up_daid_assoc_fk` FOREIGN KEY (`dependent_assocId`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_search_history`
--

DROP TABLE IF EXISTS `reference_search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reference_search_history` (
  `from_type_id` int NOT NULL,
  `from_id` int NOT NULL,
  `from_revision` int DEFAULT NULL,
  `field_id` int NOT NULL,
  `assoc_id` int DEFAULT NULL,
  `assoc_revision` int DEFAULT NULL,
  `assoc_status` int DEFAULT NULL,
  `ordinal` int DEFAULT NULL,
  `to_type_id` int DEFAULT NULL,
  `to_id` int DEFAULT NULL,
  `to_rev` int DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  KEY `ref_revision_assoc_o_fk_idx` (`assoc_id`),
  KEY `ref_history_from` (`from_id`,`from_revision`,`from_type_id`,`to_type_id`,`to_id`,`assoc_id`),
  KEY `ref_history_to` (`to_id`,`to_type_id`,`from_type_id`,`from_id`,`from_revision`,`assoc_id`),
  CONSTRAINT `ref_revision_assoc_object_fk` FOREIGN KEY (`assoc_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `release_team_stats`
--

DROP TABLE IF EXISTS `release_team_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `release_team_stats` (
  `release_id` int NOT NULL,
  `team_type` int NOT NULL,
  `team_id` int NOT NULL,
  `datum` date NOT NULL,
  `item_type` int NOT NULL,
  `total_items` int NOT NULL,
  `open_items` int NOT NULL,
  `total_points` int DEFAULT NULL,
  `open_points` int DEFAULT NULL,
  `planned_ms` bigint DEFAULT NULL,
  `spent_ms` bigint DEFAULT NULL,
  `creation_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`release_id`,`team_type`,`team_id`,`datum`,`item_type`),
  KEY `team_release_stats_idx` (`team_type`,`team_id`,`release_id`),
  CONSTRAINT `release_team_stats_fk` FOREIGN KEY (`release_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revision_filter_temp_table`
--

DROP TABLE IF EXISTS `revision_filter_temp_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revision_filter_temp_table` (
  `data_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `object_id` int NOT NULL,
  `revision_id` int NOT NULL,
  PRIMARY KEY (`data_key`,`object_id`,`revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_mapping`
--

DROP TABLE IF EXISTS `role_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_mapping` (
  `old_id` int NOT NULL,
  `new_id` int NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scm_submodule`
--

DROP TABLE IF EXISTS `scm_submodule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scm_submodule` (
  `super_repo_id` int NOT NULL,
  `sub_repo_id` int NOT NULL,
  `super_repo_branch` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `super_repo_tag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `module_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `module_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `module_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `module_revision` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`super_repo_id`,`super_repo_branch`,`super_repo_tag`,`sub_repo_id`),
  KEY `scm_sub_repo_id` (`sub_repo_id`),
  CONSTRAINT `scm_sub_sub_repo_fk` FOREIGN KEY (`sub_repo_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `scm_sub_sup_repo_fk` FOREIGN KEY (`super_repo_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_information`
--

DROP TABLE IF EXISTS `server_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_information` (
  `server_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `server_mode` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_check` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session_history`
--

DROP TABLE IF EXISTS `session_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_history` (
  `user_id` int NOT NULL,
  `session_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `remote_host` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `current_users` int DEFAULT NULL,
  `login_time` datetime(3) NOT NULL,
  `logoff_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`session_id`,`login_time`),
  KEY `session_history_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session_user_licenses`
--

DROP TABLE IF EXISTS `session_user_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_user_licenses` (
  `session_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ip_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_license_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  UNIQUE KEY `session_user_licenses_pk` (`session_id`,`ip_hash`,`product_type`,`user_license_type`),
  KEY `session_id_idx` (`session_id`),
  KEY `session_ip_hash_idx` (`ip_hash`),
  CONSTRAINT `session_user_licenses_fk` FOREIGN KEY (`session_id`) REFERENCES `tomcat_session` (`session_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_request_meta_data`
--

DROP TABLE IF EXISTS `slow_request_meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slow_request_meta_data` (
  `monitor_log_id` int NOT NULL,
  `request_id` bigint NOT NULL,
  `start_date` datetime(3) NOT NULL,
  `end_date` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`monitor_log_id`),
  CONSTRAINT `slow_request_meta_data_fk` FOREIGN KEY (`monitor_log_id`) REFERENCES `monitoring_log` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `revision` int NOT NULL DEFAULT '1',
  `type_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `template_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `flags` int NOT NULL DEFAULT '0',
  `ordinal` int DEFAULT NULL,
  `submitted_at` datetime(3) NOT NULL,
  `submitted_by` int NOT NULL,
  `modified_at` datetime(3) DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `assigned_at` datetime(3) DEFAULT NULL,
  `closed_at` datetime(3) DEFAULT NULL,
  `start_date` datetime(3) DEFAULT NULL,
  `close_date` datetime(3) DEFAULT NULL,
  `points` int DEFAULT NULL,
  `estimated_ms` bigint DEFAULT NULL,
  `spent_ms` bigint DEFAULT NULL,
  `accrued_ms` bigint DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `details` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `ishtml` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_type_id` (`type_id`,`parent_id`),
  KEY `typ_task_submitted` (`type_id`,`submitted_at`,`modified_at`,`flags`),
  KEY `typ_task_priority` (`type_id`,`priority`,`submitted_at`),
  KEY `task_submitted_at` (`submitted_at`),
  KEY `task_submitted_by` (`submitted_by`,`submitted_at`),
  KEY `task_submt_tracker` (`submitted_by`,`type_id`),
  KEY `task_modified` (`modified_by`,`modified_at`),
  KEY `task_statusid` (`status_id`),
  KEY `task_parent_id` (`parent_id`),
  KEY `task_template_id` (`template_id`),
  KEY `task_indexing_idx` (`modified_at`,`type_id`,`parent_id`),
  KEY `task_modified_at` (`modified_at`),
  FULLTEXT KEY `task_details_fidx` (`details`),
  CONSTRAINT `task_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_template_fk` FOREIGN KEY (`template_id`) REFERENCES `task` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `task_type_fk` FOREIGN KEY (`type_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2781037 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `task_change_set`
--

DROP TABLE IF EXISTS `task_change_set`;
/*!50001 DROP VIEW IF EXISTS `task_change_set`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `task_change_set` AS SELECT 
 1 AS `task_id`,
 1 AS `repo_id`,
 1 AS `repo_type`,
 1 AS `change_id`,
 1 AS `submitted_at`,
 1 AS `submitted_by`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `task_escalation_schedule`
--

DROP TABLE IF EXISTS `task_escalation_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_escalation_schedule` (
  `task_id` int NOT NULL,
  `predicate_id` int NOT NULL,
  `esc_level` int NOT NULL,
  `due_at` datetime(3) NOT NULL,
  `fired` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`task_id`,`predicate_id`,`esc_level`),
  KEY `task_escal_view_id` (`predicate_id`),
  KEY `task_escalation_due_at` (`due_at`),
  CONSTRAINT `escalation_task_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_escal_view_fk` FOREIGN KEY (`predicate_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_field_history`
--

DROP TABLE IF EXISTS `task_field_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_field_history` (
  `task_id` int NOT NULL,
  `revision` int NOT NULL,
  `label_id` int NOT NULL,
  `old_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `new_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`task_id`,`revision`,`label_id`),
  KEY `task_field_history_idx` (`task_id`,`label_id`),
  KEY `field_change_history_idx` (`label_id`),
  CONSTRAINT `task_field_revision_fk` FOREIGN KEY (`task_id`, `revision`) REFERENCES `task_revision` (`task_id`, `revision`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_field_status_specific`
--

DROP TABLE IF EXISTS `task_field_status_specific`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_field_status_specific` (
  `object_id` int NOT NULL,
  `status_id` int DEFAULT NULL,
  `required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `settings` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  UNIQUE KEY `task_field_status_specific_pk` (`object_id`,`status_id`),
  CONSTRAINT `status_specific_field_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_field_value`
--

DROP TABLE IF EXISTS `task_field_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_field_value` (
  `task_id` int NOT NULL,
  `label_id` int NOT NULL,
  `choice_id` int DEFAULT NULL,
  `field_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  KEY `task_field_value_t_fk` (`task_id`),
  KEY `task_field_value_id` (`task_id`,`label_id`,`choice_id`),
  CONSTRAINT `task_field_value_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_field_value_tuple`
--

DROP TABLE IF EXISTS `task_field_value_tuple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_field_value_tuple` (
  `object_id` int NOT NULL,
  `tuple_id` int NOT NULL,
  `tuple_val` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`object_id`,`tuple_id`),
  CONSTRAINT `value_combination_field_fk` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_lock`
--

DROP TABLE IF EXISTS `task_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_lock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `user_id` int NOT NULL,
  `expiration_time` datetime(3) NOT NULL,
  `is_expire_with_session` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_lock_uinque_task_id` (`task_id`),
  KEY `task_lock_exp_idx` (`expiration_time`),
  KEY `task_lock_user_idx` (`user_id`),
  CONSTRAINT `task_lock_task_id_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_lock_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3938 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_ordinal_history`
--

DROP TABLE IF EXISTS `task_ordinal_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_ordinal_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `ordinal` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_o_h_t_fk_i` (`task_id`),
  CONSTRAINT `task_ord_hist_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4254006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_reference_tag`
--

DROP TABLE IF EXISTS `task_reference_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_reference_tag` (
  `tag_id` int NOT NULL,
  `task_id` int NOT NULL,
  `field_id` int NOT NULL,
  `referrer_id` int NOT NULL,
  KEY `task_reference_tag_idx` (`tag_id`,`task_id`,`field_id`),
  CONSTRAINT `task_reference_tag_fk` FOREIGN KEY (`tag_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `task_reference_tag_v`
--

DROP TABLE IF EXISTS `task_reference_tag_v`;
/*!50001 DROP VIEW IF EXISTS `task_reference_tag_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `task_reference_tag_v` AS SELECT 
 1 AS `task_id`,
 1 AS `field_id`,
 1 AS `referrer_id`,
 1 AS `tag_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `task_review`
--

DROP TABLE IF EXISTS `task_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_review` (
  `task_id` int NOT NULL,
  `revision` int NOT NULL,
  `user_id` int NOT NULL,
  `reviewed_at` datetime(3) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`task_id`,`revision`,`user_id`),
  KEY `user_task_review` (`user_id`,`reviewed_at`),
  CONSTRAINT `task_review_reviewer` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_review_revision` FOREIGN KEY (`task_id`, `revision`) REFERENCES `task_revision` (`task_id`, `revision`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_revision`
--

DROP TABLE IF EXISTS `task_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_revision` (
  `task_id` int NOT NULL,
  `revision` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `flags` int NOT NULL DEFAULT '0',
  `type_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `deleted` int NOT NULL,
  PRIMARY KEY (`task_id`,`revision`),
  KEY `task_revision_created` (`created_by`,`created_at`),
  KEY `task_revision_baseline` (`type_id`,`task_id`,`revision`),
  KEY `task_revision_parent` (`parent_id`,`revision`,`flags`),
  KEY `task_revision_tracker_idx` (`type_id`,`deleted`,`created_at`,`revision`,`task_id`),
  KEY `task_revision_creatrev_idx` (`created_at`,`task_id`,`revision`),
  KEY `task_revision_b_create_idx` (`task_id`,`created_at`,`revision`),
  KEY `task_revision_b_id_idx` (`task_id`,`deleted`,`created_at`,`revision`,`type_id`),
  KEY `task_revision_b_parent_idx` (`parent_id`,`deleted`,`created_at`,`revision`,`type_id`),
  CONSTRAINT `task_modifier_fk` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `task_revision_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_search_history`
--

DROP TABLE IF EXISTS `task_search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_search_history` (
  `id` int NOT NULL,
  `revision` int NOT NULL DEFAULT '1',
  `type_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `template_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `flags` int NOT NULL DEFAULT '0',
  `submitted_at` datetime(3) NOT NULL,
  `submitted_by` int NOT NULL,
  `modified_at` datetime(3) DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `assigned_at` datetime(3) DEFAULT NULL,
  `closed_at` datetime(3) DEFAULT NULL,
  `start_date` datetime(3) DEFAULT NULL,
  `close_date` datetime(3) DEFAULT NULL,
  `points` int DEFAULT NULL,
  `estimated_ms` bigint DEFAULT NULL,
  `spent_ms` bigint DEFAULT NULL,
  `accrued_ms` bigint DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`,`revision`),
  KEY `task_id_hfk_idx` (`id`),
  KEY `task_type_hfk_idx` (`type_id`),
  CONSTRAINT `task_id_hfk` FOREIGN KEY (`id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_type_hfk` FOREIGN KEY (`type_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_tag`
--

DROP TABLE IF EXISTS `task_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_tag` (
  `tag_id` int NOT NULL,
  `type_id` int NOT NULL,
  `task_id` int NOT NULL,
  `revision` int NOT NULL,
  `distance` int NOT NULL,
  PRIMARY KEY (`tag_id`,`task_id`),
  KEY `task_tag_typ_id` (`type_id`),
  KEY `task_tagged_revision` (`task_id`,`revision`),
  KEY `task_tag_distance` (`tag_id`,`distance`),
  CONSTRAINT `task_tag_fk` FOREIGN KEY (`tag_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_tag_rev_fk` FOREIGN KEY (`task_id`, `revision`) REFERENCES `task_revision` (`task_id`, `revision`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_tag_typ_fk` FOREIGN KEY (`type_id`) REFERENCES `task_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `task_tag_v`
--

DROP TABLE IF EXISTS `task_tag_v`;
/*!50001 DROP VIEW IF EXISTS `task_tag_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `task_tag_v` AS SELECT 
 1 AS `task_id`,
 1 AS `revision`,
 1 AS `flags`,
 1 AS `type_id`,
 1 AS `parent_id`,
 1 AS `tag_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `task_type`
--

DROP TABLE IF EXISTS `task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_type` (
  `id` int NOT NULL,
  `proj_id` int NOT NULL,
  `desc_id` int NOT NULL DEFAULT '1',
  `template_id` int DEFAULT NULL,
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `template` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `prefix` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `service_desk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_type_proj_id` (`proj_id`),
  KEY `task_type_desc_id` (`desc_id`),
  KEY `task_type_template_id` (`template_id`),
  KEY `task_type_desc_idx` (`id`,`desc_id`),
  KEY `task_type_id_proj` (`id`,`proj_id`),
  KEY `task_type_id_service_desk` (`id`,`service_desk`),
  CONSTRAINT `task_type_obj` FOREIGN KEY (`id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `task_type_template` FOREIGN KEY (`template_id`) REFERENCES `task_type` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_uuid_registry`
--

DROP TABLE IF EXISTS `task_uuid_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_uuid_registry` (
  `task_id` int NOT NULL,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `original_uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `task_uuid_u` (`uuid`),
  KEY `task_uuid_idx` (`uuid`,`task_id`),
  KEY `task_uuid_orig_idx` (`original_uuid`),
  CONSTRAINT `task_uuid_o_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_statistic_table`
--

DROP TABLE IF EXISTS `temp_statistic_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_statistic_table` (
  `Project ID` int DEFAULT NULL,
  `Type` varchar(264) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `Number of Attachments` varchar(21) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `Size of Attachments` varbinary(42) DEFAULT NULL,
  `Number of` varchar(19) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `Number` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tomcat_session`
--

DROP TABLE IF EXISTS `tomcat_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tomcat_session` (
  `session_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `valid_session` int NOT NULL,
  `max_inactive` int NOT NULL,
  `is_anonymous` int NOT NULL,
  `creation_time` datetime(3) NOT NULL,
  `last_access` datetime(3) NOT NULL,
  `ip_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `session_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `tomcat_user_id_idx` (`user_id`),
  CONSTRAINT `tomcat_session_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tomcat_session_blobs`
--

DROP TABLE IF EXISTS `tomcat_session_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tomcat_session_blobs` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `tomcat_session_blobs_fk` FOREIGN KEY (`id`) REFERENCES `tomcat_session` (`session_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tracker_outline`
--

DROP TABLE IF EXISTS `tracker_outline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracker_outline` (
  `tracker_id` int NOT NULL,
  `outline` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`tracker_id`),
  CONSTRAINT `outline_tracker_fk` FOREIGN KEY (`tracker_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upgrade_statements`
--

DROP TABLE IF EXISTS `upgrade_statements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upgrade_statements` (
  `statement_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`statement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!50001 DROP VIEW IF EXISTS `user_group`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_group` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `permissions`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_key`
--

DROP TABLE IF EXISTS `user_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_key` (
  `user_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `algorithm` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `format` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `encoded` mediumblob,
  KEY `user_key_idx` (`user_id`,`algorithm`,`format`),
  CONSTRAINT `key_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_pref`
--

DROP TABLE IF EXISTS `user_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_pref` (
  `user_id` int NOT NULL,
  `pref_id` int NOT NULL,
  `pref_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`user_id`,`pref_id`),
  CONSTRAINT `user_pref_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `passwd` char(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `lastname` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `zip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `language` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `geo_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `geo_region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `geo_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `geo_latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `geo_longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `source_of_interest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `scc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `team_size` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `division_size` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email_client` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `mobil` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `datetime_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `downloadlimit` int NOT NULL DEFAULT '-1',
  `workspace_id` int DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `skills` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `wiki_homepage_id` int DEFAULT NULL,
  `registrydate` datetime(3) DEFAULT NULL,
  `referrer_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `lastlogin` datetime(3) DEFAULT NULL,
  `unused0` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `unused1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `unused2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ldap_modified_at` datetime(3) DEFAULT NULL,
  `modified_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_wiki_homepage_id` (`wiki_homepage_id`),
  UNIQUE KEY `users_name_ak` (`name`),
  KEY `users_workspace_id` (`workspace_id`),
  CONSTRAINT `users_wiki_homepage_fk` FOREIGN KEY (`wiki_homepage_id`) REFERENCES `object` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9716 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_large_photo_blobs`
--

DROP TABLE IF EXISTS `users_large_photo_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_large_photo_blobs` (
  `id` int NOT NULL,
  `blob_data` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `users_large_photo_blobs_fk` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_small_photo_blobs`
--

DROP TABLE IF EXISTS `users_small_photo_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_small_photo_blobs` (
  `id` int NOT NULL,
  `blob_data` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `users_small_photo_blobs_fk` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `version` (
  `major` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `minor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  UNIQUE KEY `version_maj_min` (`major`,`minor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workingset`
--

DROP TABLE IF EXISTS `workingset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workingset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `description_format` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `selected` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workingset_owner_id` (`user_id`),
  CONSTRAINT `workingset_owner_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=855 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workingset_item`
--

DROP TABLE IF EXISTS `workingset_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workingset_item` (
  `workingset_id` int NOT NULL,
  `proj_id` int NOT NULL,
  PRIMARY KEY (`workingset_id`,`proj_id`),
  KEY `workingset_proj_id` (`proj_id`),
  CONSTRAINT `workingset_item_fk` FOREIGN KEY (`workingset_id`) REFERENCES `workingset` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `workingset_proj_fk` FOREIGN KEY (`proj_id`) REFERENCES `existing` (`proj_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'gtd_starc_int'
--
/*!50003 DROP FUNCTION IF EXISTS `artifact_accessible_revision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `artifact_accessible_revision`(userId INT, documentId INT, headRevision INT, workflowId INT, publishedRevision INT, requestedRevision INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE workflowNo INT DEFAULT workflowId;
DECLARE publicRevNo INT DEFAULT publishedRevision;
DECLARE approval_cursor CURSOR FOR
			SELECT OAS.approval_workflow_id AS workflow_id
			  FROM object_approval_history OAH
				   INNER JOIN object_approval_step OAS
				 		   ON OAS.id = OAH.approval_step_id
			 WHERE OAH.object_id = documentId
			   AND OAH.revision = requestedRevision;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET workflowNo = NULL;
IF requestedRevision IS NOT NULL AND requestedRevision < IFNULL(publishedRevision,headRevision) THEN
			OPEN approval_cursor;
FETCH approval_cursor INTO workflowNo;
CLOSE approval_cursor;
IF workflowNo IS NOT NULL THEN
				SELECT MAX(REV.revision)
				  INTO publicRevNo
				  FROM object_revision REV
				 WHERE REV.object_id = documentId
				   AND REV.revision < requestedRevision
			 	   AND NOT EXISTS (SELECT 1
			 	   					 FROM object_approval_history OAH
					   				WHERE OAH.object_id = REV.object_id
				   					  AND OAH.revision = REV.revision);
END  IF;
END  IF;
RETURN artifact_visible_revision(userId, documentId, IFNULL(requestedRevision,headRevision), workflowNo, publicRevNo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `artifact_path` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `artifact_path`(obj_id INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE done INT DEFAULT 0;
DECLARE result TEXT BINARY;
DECLARE aName VARCHAR(255) BINARY;
DECLARE aParent INT DEFAULT obj_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
REPEAT
			SELECT REV.name, OBJ.parent_id
			  INTO aName, aParent
			  FROM object OBJ
			  	   INNER JOIN object_revision REV
			  	   		   ON REV.object_id = OBJ.id
			  	   		  AND REV.revision = OBJ.revision
			 WHERE OBJ.id = aParent;
IF NOT done THEN
				IF result IS NULL THEN
					SET result = IFNULL(aName,'');
ELSE
					SET result = CONCAT(CONCAT(IFNULL(aName,''), '/'), result);
END IF;
IF aParent IS NULL THEN
					SET done = 1;
END IF;
END IF;
UNTIL done END REPEAT;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `artifact_visible_revision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `artifact_visible_revision`(userId INT, documentId INT, revision INT, workflowId INT, publishedRevision INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE dummy INT;
DECLARE result INT DEFAULT revision;
DECLARE approver_cursor CURSOR FOR
			SELECT 1
			  FROM object_revision REV
			 WHERE REV.object_id = documentId
			   AND REV.revision = (publishedRevision + 1)
			   AND (REV.created_by = userId
			    OR EXISTS (SELECT OAR.id
						     FROM object_approval_step OAS
						          INNER JOIN object_approver OAR
						       		      ON OAR.approval_step_id = OAS.id
						       		     AND OAR.user_id = userId
						    WHERE OAS.approval_workflow_id = workflowId)
			    OR EXISTS (SELECT OAR.id
							 FROM object_approval_workflow OAW
							      INNER JOIN object_approval_step OAS
							       		  ON OAS.approval_workflow_id = OAW.id
							      INNER JOIN object_approver OAR
							       		  ON OAR.approval_step_id = OAS.id
							       		 AND OAR.role_id IS NOT NULL
							  	  INNER JOIN project_member MBR
							  	          ON MBR.proj_id = OAW.proj_id
							  	         AND MBR.role_id = OAR.role_id
							  	         AND MBR.member_type = 1
							  	         AND MBR.member_id = userId
							WHERE OAW.id = workflowId)
			    OR EXISTS (SELECT OAR.id
							 FROM object_approval_workflow OAW
							      INNER JOIN object_approval_step OAS
							       		  ON OAS.approval_workflow_id = OAW.id
							      INNER JOIN object_approver OAR
							       		  ON OAR.approval_step_id = OAS.id
							  	  INNER JOIN project_member GRP
							  	          ON GRP.proj_id = OAW.proj_id
							  	         AND GRP.role_id = OAR.role_id
							  	         AND GRP.member_type = 5
							  	  INNER JOIN group_member MBR
							  	          ON MBR.group_id = GRP.member_id
							  	         AND MBR.user_id = userId
							WHERE OAW.id = workflowId)
				);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET result = publishedRevision;
IF workflowId IS NOT NULL AND publishedRevision IS NOT NULL THEN
			OPEN approver_cursor;
FETCH approver_cursor INTO dummy;
CLOSE approver_cursor;
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `assigned_to_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `assigned_to_value`(tid INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE done INT DEFAULT 0;
DECLARE result TEXT BINARY;
DECLARE name VARCHAR(255) BINARY;
DECLARE name_cursor CURSOR FOR

			SELECT UPPER(U.name) AS name
			FROM object_reference A USE INDEX (object_reference_from)
						 INNER JOIN users U ON U.id = A.to_id
			WHERE A.from_type_id = 9
				AND A.from_id = tid
				AND A.field_id = fid
				AND A.to_type_id = 1
			UNION
			SELECT UPPER(R.name) AS name
			FROM object_reference A USE INDEX (object_reference_from)
						 INNER JOIN acl_role R ON R.id = A.to_id
			WHERE A.from_type_id = 9
				AND A.from_id = tid
				AND A.field_id = fid
				AND A.to_type_id = 13
			UNION
			SELECT UPPER(R.name) AS name
			FROM object_reference A USE INDEX (object_reference_from)
						 INNER JOIN object O ON O.id = A.to_id
						 INNER JOIN object_revision R ON R.object_id = O.id AND R.revision = O.revision
			WHERE A.from_type_id = 9
				AND A.from_id = tid
				AND A.field_id = fid
				AND A.to_type_id IN (3, 4, 5, 18)
			ORDER BY 1 ASC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN name_cursor;
REPEAT
			FETCH name_cursor INTO name;
IF NOT done THEN
				SET result = CONCAT(IFNULL(result,''),name);
END IF;
UNTIL done END REPEAT;
CLOSE name_cursor;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_bits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `check_bits`(mask INT, bits INT) RETURNS int
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	  RETURN CAST(mask & bits AS SIGNED);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `clear_bits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `clear_bits`(mask INT, bits INT) RETURNS int
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	  RETURN CAST(mask & ~bits AS SIGNED);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getChoiceLabel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `getChoiceLabel`(p_task_id INT, p_field_id INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

    DECLARE result VARCHAR(255);
DECLARE field_obj_id INT(11);
DECLARE v_tracker_id INT(11);
SELECT t.type_id INTO v_tracker_id FROM task t WHERE t.id = p_task_id;
REPEAT
    SET field_obj_id = get_tracker_field(v_tracker_id, p_field_id);
SET result = (SELECT GROUP_CONCAT(sto_rev.name)
                  FROM object sto INNER JOIN object_revision sto_rev ON sto.id = sto_rev.object_id
                  AND sto.revision = sto_rev.revision
                  AND sto.parent_id = field_obj_id
                  AND sto.deleted = 0
                  AND sto.reference_id IN (SELECT tfv.choice_id FROM task_field_value tfv WHERE tfv.task_id = p_task_id AND tfv.label_id = p_field_id));
IF result IS NULL THEN
        SELECT tt.template_id INTO v_tracker_id FROM task_type tt WHERE tt.id = v_tracker_id;
END IF;
UNTIL result IS NOT NULL OR v_tracker_id IS NULL END REPEAT;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getFieldChoiceLabelHist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `getFieldChoiceLabelHist`(p_task_id INT, p_label_id INT, p_field_id INT, p_timestamp DATETIME(3)) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE result VARCHAR(255);
DECLARE field_obj_id INT(11);
DECLARE v_tracker_id INT(11);
SELECT t.type_id INTO v_tracker_id FROM task_revision t WHERE t.task_id = p_task_id AND t.revision = (SELECT MAX(m_rev.revision) FROM task_revision m_rev WHERE m_rev.task_id = p_task_id AND m_rev.created_at <= p_timestamp);
REPEAT
    SET field_obj_id = get_tracker_field(v_tracker_id, p_field_id);
SET result = (SELECT sto_rev.name
                    FROM object sto INNER JOIN object_revision sto_rev ON sto.id = sto_rev.object_id
                     AND sto_rev.revision = (SELECT MAX(m_rev.revision) FROM object_revision m_rev WHERE m_rev.object_id = sto_rev.object_id AND m_rev.created_at <= p_timestamp)
                    AND sto.parent_id = field_obj_id
                    AND sto.reference_id = p_label_id);
IF result IS NULL THEN
      SELECT tt.template_id INTO v_tracker_id FROM task_type tt WHERE tt.id = v_tracker_id;
END IF;
UNTIL result IS NOT NULL OR v_tracker_id IS NULL END REPEAT;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getTrackerFieldChoiceLabel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `getTrackerFieldChoiceLabel`(p_task_id INT, p_label_id INT, p_field_id INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE result VARCHAR(255);
DECLARE field_obj_id INT(11);
DECLARE v_tracker_id INT(11);
SELECT t.type_id INTO v_tracker_id FROM task t WHERE t.id = p_task_id;
REPEAT
    SET field_obj_id = get_tracker_field(v_tracker_id, p_field_id);
SET result = (SELECT sto_rev.name
                    FROM object sto INNER JOIN object_revision sto_rev ON sto.id = sto_rev.object_id
                    AND sto.revision = sto_rev.revision
                    AND sto.parent_id = field_obj_id
                    AND sto.deleted = 0
                    AND sto.reference_id = p_label_id);
IF result IS NULL THEN
      SELECT tt.template_id INTO v_tracker_id FROM task_type tt WHERE tt.id = v_tracker_id;
END IF;
UNTIL result IS NOT NULL OR v_tracker_id IS NULL END REPEAT;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getTrackerItemResolution` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `getTrackerItemResolution`(bits INT) RETURNS varchar(30) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	
	DECLARE result VARCHAR(30);
IF bits = 0 THEN
		SET result = 'Unset';
ELSEIF check_bits(bits, 20) != 0 THEN
		SET result = 'Unsuccessful';
ELSEIF  check_bits(bits, 8) != 0 THEN
		SET result = 'Successful';
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getTrackerItemStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `getTrackerItemStatus`(bits INT) RETURNS varchar(30) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	
	DECLARE result VARCHAR(30);
IF bits = 0 THEN
		SET result = 'Unset';
ELSEIF check_bits(bits, 4) != 0 THEN
		SET result = 'Resolved';
ELSEIF  check_bits(bits, 16) != 0 THEN
		SET result = 'Closed';
ELSEIF  check_bits(bits, 64) != 0 THEN
		SET result = 'InProgress';
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_tracker_field` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `get_tracker_field`(p_tracker_id INT, p_field_id INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
	DECLARE v_tracker_id int(11);
DECLARE v_field_obj_id int(11);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_field_obj_id = NULL;

	IF p_field_id > 1000000 AND (((MOD(p_field_id , 1000000)) / 100) -1) >= 0 AND ((MOD(p_field_id , 100)) - 1) >= 0 THEN
		SET p_field_id = (((CAST((p_field_id / 1000000) AS UNSIGNED)) * 1000000 )	) + ((MOD(p_field_id,100)));
END IF;
SET v_tracker_id = p_tracker_id;
REPEAT
		SELECT o.id INTO v_field_obj_id FROM object o INNER JOIN object_revision r ON r.object_id = o.id AND r.revision = o.revision WHERE o.deleted = 0 AND o.type_id = 25 AND o.parent_id = v_tracker_id AND o.reference_id = p_field_id;
IF v_field_obj_id IS NULL THEN
			BEGIN
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_tracker_id = NULL;
SELECT tt.template_id INTO v_tracker_id FROM task_type tt WHERE tt.id = v_tracker_id;
END;
END IF;
UNTIL v_field_obj_id IS NOT NULL OR v_tracker_id IS NULL END REPEAT;
RETURN v_field_obj_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `has_tracker_permission` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `has_tracker_permission`(tracker_id INT, owner_id INT, uid INT, rid INT, bits INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE tid     INT DEFAULT tracker_id;
DECLARE fid     INT DEFAULT CASE WHEN owner_id = uid THEN 6 ELSE -1 END;
DECLARE toCheck INT DEFAULT bits;
DECLARE ovrload INT DEFAULT NULL;
DECLARE granted INT DEFAULT NULL;
DECLARE result  INT DEFAULT 0;
DECLARE done    INT DEFAULT 0;
DECLARE oap_cursor CURSOR FOR
		    SELECT bit_mask, access_perms
	          FROM object_access_permission
			 WHERE object_id = tid
			   AND task_id IS NULL
			   AND (role_id = rid OR field_id = fid)
	           AND (bit_mask IS NULL OR check_bits(bit_mask, toCheck) != 0);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET granted = NULL;
IF tid IS NOT NULL AND rid IS NOT NULL AND bits IS NOT NULL THEN
		    REPEAT
				OPEN oap_cursor;
REPEAT
					FETCH oap_cursor INTO ovrload, granted;
IF granted IS NOT NULL THEN
		                SET result = check_bits(granted, toCheck);
IF result != 0 OR ovrload IS NULL THEN
							SET done = 1;
ELSE
							SET toCheck = clear_bits(toCheck, ovrload);
IF toCheck = 0 THEN
								SET done = 1;
END IF;
END IF;
END IF;
UNTIL done = 1 OR granted IS NULL END REPEAT;
CLOSE oap_cursor;
IF done = 0 THEN
					SET tid = next_template_tracker_id(tid);
END IF;
UNTIL done = 1 OR tid IS NULL END REPEAT;
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_reference_field` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `is_reference_field`(p_task_id INT, p_field_id INT, p_ref_type INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
	DECLARE v_tracker_id int(11);
DECLARE is_ref_field int(1);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_ref_field = 0;

	IF p_field_id > 1000000 AND (((MOD(p_field_id , 1000000)) / 100) -1) >= 0 AND ((MOD(p_field_id , 100)) - 1) >= 0 THEN
		SET p_field_id = (((CAST((p_field_id / 1000000) AS UNSIGNED)) * 1000000 )	) + ((MOD(p_field_id,100)));
END IF;
SELECT t.type_id INTO v_tracker_id FROM task t WHERE t.id = p_task_id;
REPEAT
		SELECT 1 INTO is_ref_field FROM object o INNER JOIN object_revision r ON r.object_id = o.id AND r.revision = o.revision INNER JOIN object_reference_filter f ON f.object_id = o.id AND f.type_id = p_ref_type WHERE o.deleted = 0 AND o.parent_id = v_tracker_id AND o.reference_id = p_field_id LIMIT 1;
IF is_ref_field = 0 THEN
			BEGIN
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_tracker_id = NULL;
SELECT tt.template_id INTO v_tracker_id FROM task_type tt WHERE tt.id = v_tracker_id;
END;
END IF;
UNTIL is_ref_field = 1 OR v_tracker_id IS NULL END REPEAT;
RETURN is_ref_field;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `json_field_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `json_field_value`(json TEXT BINARY, field VARCHAR(80)) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	    DECLARE field_pos INT DEFAULT LOCATE(CONCAT('"', field, '"'), json);
DECLARE end_pos   INT DEFAULT 0;
DECLARE field_val VARCHAR(255) BINARY DEFAULT NULL;
IF field_pos > 0 THEN
			SET field_pos = LOCATE(':', json, field_pos + LENGTH(field) + 2);
IF field_pos > 0 THEN
				SET end_pos = LOCATE(',', json, field_pos + 1);
IF end_pos = 0 THEN
				   SET end_pos = LOCATE('}', json, field_pos + 1);
END IF;
IF end_pos = 0 THEN
				   SET end_pos = LENGTH(json) + 1;
END IF;
SET field_val = TRIM(BOTH '"' FROM TRIM(SUBSTR(json, field_pos + 1, end_pos - field_pos - 1)));
END IF;
END IF;
RETURN field_val;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `next_template_tracker_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `next_template_tracker_id`(tid INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE result INT DEFAULT NULL;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET result = NULL;
SELECT template_id INTO result FROM task_type WHERE id = tid;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `numeric_json_field_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `numeric_json_field_value`(json TEXT BINARY, field VARCHAR(80)) RETURNS int
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
		RETURN CAST(json_field_value(json, field) AS SIGNED INTEGER);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `set_bits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `set_bits`(mask INT, bits INT) RETURNS int
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	  RETURN CAST(mask | bits AS SIGNED);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_choice_field_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_choice_field_value`(tid INT, fid INT) RETURNS varchar(512) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE done INT DEFAULT 0;
DECLARE result VARCHAR(512) BINARY;
DECLARE choice_value VARCHAR(30) BINARY;
DECLARE choice_cursor CURSOR FOR
			SELECT task_choice_sort_value(T.type_id, V.label_id, V.choice_id) AS sort_val
			  FROM task_field_value V
				   INNER JOIN task T ON T.id = V.task_id
			 WHERE V.task_id = tid
			   AND V.label_id = fid
			 ORDER BY sort_val ASC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN choice_cursor;
REPEAT
			FETCH choice_cursor INTO choice_value;
IF NOT done THEN
				SET result = CONCAT(IFNULL(result,''), choice_value);
END IF;
UNTIL done END REPEAT;
CLOSE choice_cursor;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_choice_sort_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_choice_sort_value`(tid INT, fid INT, cid INT) RETURNS varchar(28) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE pid INT DEFAULT tid;
DECLARE result VARCHAR(28) BINARY DEFAULT NULL;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET pid = next_template_tracker_id(pid);
IF cid IS NOT NULL THEN
		    REPEAT
				SELECT CONCAT(LPAD(IFNULL(REV.status_id,9999), 4, '0'), RPAD(UPPER(SUBSTR(REV.name, 1, 20)), 20, '_')) INTO result
				  FROM object FLD
				       INNER JOIN object OPN
			                   ON OPN.parent_id = FLD.id
			                  AND OPN.type_id = 26
			                  AND OPN.reference_id = cid
			                  AND OPN.deleted = 0
			           INNER JOIN object_revision REV
			                   ON REV.object_id = OPN.id
			                  AND REV.revision = OPN.revision
	             WHERE FLD.parent_id = pid
	               AND FLD.type_id = 25
	               AND FLD.reference_id = fid
	               AND FLD.deleted = 0
	             LIMIT 1;
UNTIL result IS NOT NULL OR pid IS NULL END REPEAT;
ELSEIF fid = 7 THEN
		    SET result = '0000';
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_custom_field_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_custom_field_value`(tid INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE result TEXT BINARY;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET result = NULL;
SELECT field_value INTO result FROM task_field_value WHERE task_id = tid AND label_id = fid LIMIT 1;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_field_value_at` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_field_value_at`(tid INT, fid INT, rev INT, dflt MEDIUMTEXT) RETURNS mediumtext CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE result MEDIUMTEXT BINARY DEFAULT dflt;
DECLARE changed_rev INT DEFAULT NULL;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET changed_rev = NULL;
SELECT MAX(revision) INTO changed_rev FROM task_field_history USE INDEX (task_field_history_idx) WHERE task_id = tid AND label_id = fid AND revision <= rev;
IF changed_rev IS NOT NULL THEN
			SELECT new_value INTO result FROM task_field_history WHERE task_id = tid AND revision = changed_rev AND label_id = fid LIMIT 1;
ELSE
			SELECT MIN(revision) INTO changed_rev FROM task_field_history USE INDEX (task_field_history_idx) WHERE task_id = tid AND label_id = fid AND revision > rev;
IF changed_rev IS NOT NULL THEN
		 		SELECT old_value INTO result FROM task_field_history WHERE task_id = tid AND revision = changed_rev AND label_id = fid LIMIT 1;
END IF;
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_numeric_field_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_numeric_field_value`(tid INT, fid INT) RETURNS decimal(20,3)
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE result DECIMAL(20,3);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET result = NULL;
SELECT CAST(field_value AS DECIMAL(20,3)) INTO result FROM task_field_value WHERE task_id = tid AND label_id = fid LIMIT 1;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_numeric_field_value_at` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_numeric_field_value_at`(tid INT, fid INT, rev INT, dflt INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		RETURN wiki_link_id(task_field_value_at(tid, fid, rev, CAST(dflt AS CHAR(10))));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_ref_field_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_ref_field_value`(tid INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE done INT DEFAULT 0;
DECLARE result TEXT BINARY;
DECLARE name VARCHAR(255) BINARY;
DECLARE name_cursor CURSOR FOR
			SELECT UPPER(U.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN users U ON U.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id = 1
			 UNION
			SELECT UPPER(R.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN acl_role R ON R.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id = 13
			 UNION
			SELECT UPPER(T.summary) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN task T ON T.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.field_id IN (0, 80, 99)
			   AND A.to_type_id = 9
			 UNION
      SELECT UPPER(T.summary) AS name
        FROM object_reference A USE INDEX (object_reference_from)
             INNER JOIN task T ON T.id = A.to_id
             INNER JOIN object O ON O.id = A.assoc_id AND O.deleted = 0
       WHERE A.from_type_id = 9
         AND A.from_id = tid
         AND A.field_id = fid
         AND A.field_id NOT IN (0, 80, 99)
         AND A.to_type_id = 9
			 UNION
			SELECT UPPER(P.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN existing P ON P.proj_id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id = 2
			 UNION
			SELECT UPPER(R.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN object O ON O.id = A.to_id
			  	   INNER JOIN object_revision R ON R.object_id = O.id AND R.revision = O.revision
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id IN (3, 4, 5, 18)
			 ORDER BY 1 ASC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN name_cursor;
REPEAT
			FETCH name_cursor INTO name;
IF NOT done THEN
				SET result = CONCAT(IFNULL(result,''),name);
END IF;
UNTIL done END REPEAT;
CLOSE name_cursor;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_ref_field_value_hist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_ref_field_value_hist`(tid INT, trev INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE done INT DEFAULT 0;
DECLARE result TEXT BINARY;
DECLARE name VARCHAR(255) BINARY;
DECLARE name_cursor CURSOR FOR
			SELECT UPPER(U.name) AS name
			  FROM reference_search_history A
			  	   INNER JOIN users U ON U.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.from_revision = trev
			   AND A.field_id = fid
			   AND A.to_type_id = 1
			 UNION
			SELECT UPPER(R.name) AS name
			  FROM reference_search_history A
			  	   INNER JOIN acl_role R ON R.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.from_revision = trev
			   AND A.field_id = fid
			   AND A.to_type_id = 13
			 UNION
			SELECT UPPER(T.summary) AS name
			  FROM reference_search_history A
			  	   INNER JOIN task T ON T.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.from_revision = trev
			   AND A.field_id = fid
			   AND A.field_id IN (0, 80, 99)
			   AND A.to_type_id = 9
			 UNION
      SELECT UPPER(T.summary) AS name
        FROM reference_search_history A
             INNER JOIN task T ON T.id = A.to_id
       WHERE A.from_type_id = 9
         AND A.from_id = tid
         AND A.from_revision = trev
         AND A.field_id = fid
         AND A.field_id NOT IN (0, 80, 99)
         AND A.to_type_id = 9
			 UNION
			SELECT UPPER(P.name) AS name
			  FROM reference_search_history A
			  	   INNER JOIN existing P ON P.proj_id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.from_revision = trev
			   AND A.field_id = fid
			   AND A.to_type_id = 2
			 UNION
			SELECT UPPER(R.name) AS name
			  FROM reference_search_history A
			  	   INNER JOIN object O ON O.id = A.to_id
			  	   INNER JOIN object_revision R ON R.object_id = O.id AND R.revision = O.revision
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.from_revision = trev
			   AND A.field_id = fid
			   AND A.to_type_id IN (3, 4, 5, 18)
			 ORDER BY 1 ASC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN name_cursor;
REPEAT
			FETCH name_cursor INTO name;
IF NOT done THEN
				SET result = CONCAT(IFNULL(result,''),name);
END IF;
UNTIL done END REPEAT;
CLOSE name_cursor;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `task_ref_field_value_to` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `task_ref_field_value_to`(tid INT, fid INT, toid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
		DECLARE done INT DEFAULT 0;
DECLARE result TEXT BINARY;
DECLARE name VARCHAR(255) BINARY;
DECLARE name_cursor CURSOR FOR
			SELECT UPPER(U.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN users U ON U.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id = 1
			   AND A.to_id = toid
			 UNION
			SELECT UPPER(R.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN acl_role R ON R.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id = 13
			   AND A.to_id = toid
			 UNION
			SELECT UPPER(T.summary) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN task T ON T.id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.field_id IN (0, 80, 99)
			   AND A.to_type_id = 9
			   AND A.to_id = toid
			 UNION
      SELECT UPPER(T.summary) AS name
        FROM object_reference A USE INDEX (object_reference_from)
             INNER JOIN task T ON T.id = A.to_id
             INNER JOIN object O ON O.id = A.assoc_id AND O.deleted = 0
       WHERE A.from_type_id = 9
         AND A.from_id = tid
         AND A.field_id = fid
         AND A.field_id NOT IN (0, 80, 99)
         AND A.to_type_id = 9
         AND A.to_id = toid
			 UNION
			SELECT UPPER(P.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN existing P ON P.proj_id = A.to_id
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id = 2
			   AND A.to_id = toid
			 UNION
			SELECT UPPER(R.name) AS name
			  FROM object_reference A USE INDEX (object_reference_from)
			  	   INNER JOIN object O ON O.id = A.to_id
			  	   INNER JOIN object_revision R ON R.object_id = O.id AND R.revision = O.revision
			 WHERE A.from_type_id = 9
			   AND A.from_id = tid
			   AND A.field_id = fid
			   AND A.to_type_id IN (3, 4, 5, 18)
			   AND A.to_id = toid
			 ORDER BY 1 ASC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN name_cursor;
REPEAT
			FETCH name_cursor INTO name;
IF NOT done THEN
				SET result = CONCAT(IFNULL(result,''),name);
END IF;
UNTIL done END REPEAT;
CLOSE name_cursor;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `type_choice_option_flags` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `type_choice_option_flags`(tid INT, fid INT, cid INT) RETURNS int
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
	DECLARE pid INT DEFAULT tid;
DECLARE result INT DEFAULT NULL;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET pid = next_template_tracker_id(pid);
IF cid IS NOT NULL THEN
	    REPEAT
			SELECT numeric_json_field_value(REV.description, 'flags') INTO result
			  FROM object FLD
			       INNER JOIN object OPN
		                   ON OPN.parent_id = FLD.id
		                  AND OPN.type_id = 26
		                  AND OPN.reference_id = cid
		                  AND OPN.deleted = 0
		           INNER JOIN object_revision REV
		                   ON REV.object_id = OPN.id
		                  AND REV.revision = OPN.revision
		                  AND INSTR(REV.description, '"flags"') > 0
             WHERE FLD.parent_id = pid
               AND FLD.type_id = 25
               AND FLD.reference_id = fid
               AND FLD.deleted = 0
             LIMIT 1;
UNTIL result IS NOT NULL OR pid IS NULL END REPEAT;
END IF;
RETURN IFNULL(result, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `type_choice_option_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `type_choice_option_name`(tid INT, fid INT, cid INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
	DECLARE pid INT DEFAULT tid;
DECLARE result VARCHAR(255) DEFAULT NULL;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET pid = next_template_tracker_id(pid);
IF cid IS NOT NULL THEN
	    REPEAT
			SELECT REV.name INTO result
			  FROM object FLD
			       INNER JOIN object OPN
		                   ON OPN.parent_id = FLD.id
		                  AND OPN.type_id = 26
		                  AND OPN.reference_id = cid
		                  AND OPN.deleted = 0
		           INNER JOIN object_revision REV
		                   ON REV.object_id = OPN.id
		                  AND REV.revision = OPN.revision
             WHERE FLD.parent_id = pid
               AND FLD.type_id = 25
               AND FLD.reference_id = fid
               AND FLD.deleted = 0
             LIMIT 1;
UNTIL result IS NOT NULL OR pid IS NULL END REPEAT;
IF result IS NULL THEN
	    	SET result = cid;
END IF;
END IF;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `wiki_link_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` FUNCTION `wiki_link_id`(wiki_link VARCHAR(255)) RETURNS int
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    	DECLARE trimmed_link VARCHAR(255) DEFAULT TRIM(LEADING '[' FROM TRIM(TRAILING ']' FROM TRIM(wiki_link)));
DECLARE id_sep_pos INT DEFAULT INSTR(trimmed_link, ':');
IF id_sep_pos > 0 THEN
			SET trimmed_link = SUBSTR(trimmed_link, id_sep_pos + 1);
END IF;
RETURN CAST(trimmed_link AS SIGNED INTEGER);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adjust_reports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adjust_reports`(oldTrackerId INT, newTrackerId INT)
BEGIN

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

Update object_revision SET description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.\'])(',@old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@old_project_id,',', @new_project_id,'$3'),1,0,'c') WHERE  REGEXP_LIKE(description, CONCAT('([\\[\,\(\.\'])(', @old_project_id, ')([\,\)\.\\]])')) AND REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId, ')([\,\)\.\\]\}])')) AND type_id IN (29);
Update object_revision SET description = REGEXP_REPLACE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(',oldTrackerId,')([\,\)\.\\]\}])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId, ')([\,\)\.\\]\}])')) AND type_id IN (29);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_attachment_stat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_attachment_stat`()
BEGIN
DROP TABLE IF EXISTS temp_statistic_table;
CREATE TABLE temp_statistic_table SELECT ANY_VALUE(obj_task.proj_id) AS 'Project ID', task.type_id AS 'Tracker ID', SUM(obj_rev.file_size) AS 'Sum of the file size', COUNT(obj_rev.file_size) AS 'Number of files' FROM task JOIN object_reference obj_ref ON obj_ref.from_id = task.id JOIN object obj ON obj_ref.to_id = obj.id JOIN object_revision obj_rev ON obj.id = obj_rev.object_id AND obj.revision = obj_rev.revision JOIN object obj_task ON obj_task.id = task.type_id WHERE obj_rev.type_id IN (15) AND obj_rev.file_size IS NOT NULL GROUP BY task.type_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_project_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_project_stats`(projectId INT)
BEGIN
DROP TABLE IF EXISTS temp_statistic_table;
CREATE TABLE temp_statistic_table SELECT attachments.proj_id AS 'Project ID', '-' AS 'Type', COUNT(attachments.file_size) AS
'Number of Attachments', SUM(file_size) AS 'Size of Attachments', 'Trackers in Project' AS 'Number of', ANY_VALUE(tracker.tracker_count) AS 'Number' FROM (SELECT COUNT(obj.id) AS 'tracker_count' FROM object obj JOIN object_revision obj_rev ON obj.id = obj_rev.object_id AND obj.revision = obj_rev.revision WHERE obj.proj_id = projectId AND obj.type_id = 16) tracker,
(SELECT obj.proj_id, obj_rev.file_size AS 'file_size' FROM object obj JOIN object_revision obj_rev ON obj.id = obj_rev.object_id AND obj.revision = obj_rev.revision WHERE obj.proj_id = projectId AND obj.type_id IN (1, 13, 15, 40) AND obj_rev.file_size IS NOT NULL AND obj.deleted = 0) attachments
UNION
SELECT projectId, '-','-','-', 'Users in Project', (SELECT COUNT(DISTINCT(user_id)) FROM member_group WHERE group_id IN (SELECT member_id FROM project_member WHERE proj_id = projectId AND member_type= 5)) +(
SELECT COUNT(DISTINCT(member_id)) 'Total2' FROM project_member WHERE proj_id = projectId AND member_type = 1) AS 'Count'
UNION
SELECT ANY_VALUE(obj_rev.proj_id), CONCAT('Tracker: ', obj_rev.name), '-','-', 'Tracker item' ,(SELECT COUNT(id) FROM task WHERE type_id = obj.id) AS 'Number of Items' FROM object obj JOIN object_revision obj_rev ON obj.id = obj_rev.object_id WHERE obj.type_id = 16 AND obj.revision = obj_rev.revision AND obj.proj_id IN(projectId) AND obj.deleted = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_perftest_clobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` PROCEDURE `insert_perftest_clobs`(p_length INT, p_count INT)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 0;
DECLARE v_text TEXT;
SET v_text = REPEAT('a', p_length);
WHILE i <= p_count DO
        insert into perftest_clob(value) values(v_text);
SET i = i + 1;
END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `move_to_identical_tracker` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `move_to_identical_tracker`(oldTrackerId INT, newTrackerId INT )
BEGIN
SELECT CONCAT('** START move to identical tracker') AS '** DEBUG:';

CREATE TEMPORARY TABLE temp_task_table SELECT id FROM task WHERE type_id = oldTrackerId;

Update task_revision SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task_search_history SET type_id = newTrackerId WHERE type_id = oldTrackerId;


DELETE FROM tracker_outline WHERE tracker_id IN (newTrackerId, oldTrackerId);

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;


Update object SET proj_id = @new_project_id WHERE id IN (SELECT assoc_id AS 'Assoc Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND assoc_id IS NOT NULL);
Update object_revision SET proj_id = @new_project_id WHERE object_id IN (SELECT assoc_id AS 'Assoc Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND assoc_id IS NOT NULL);

Update object SET proj_id = @new_project_id WHERE id IN (SELECT to_id AS 'Attachment Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND field_id = 88);
Update object_revision SET proj_id = @new_project_id WHERE object_id IN (SELECT to_id AS 'Attachment Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND field_id = 88);

CALL move_views(oldTrackerId, newTrackerId);

DROP TEMPORARY TABLE temp_task_table;

SELECT Concat('** END move to identical tracker') AS '** DEBUG:';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `move_to_project_wiki` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` PROCEDURE `move_to_project_wiki`(oldprojectId INT, newprojectId INT )
BEGIN
SELECT CONCAT('** START move to project wiki') AS '** DEBUG:';
SELECT MAX(reference_id) = @temp_reference_id FROM object WHERE proj_id = oldprojectId AND type_id IN (6);
Update object SET proj_id = newprojectId, reference_id = @temp_reference_id WHERE proj_id = oldprojectId AND type_id IN (6);
Update object SET proj_id = newprojectId WHERE proj_id = oldprojectId AND type_id IN (11,31);
Update object_revision SET proj_id = newprojectId WHERE proj_id = oldprojectId AND type_id IN (6, 11 ,31);
SELECT Concat('** END move to project wiki') AS '** DEBUG:';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `move_views` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `move_views`(oldTrackerId INT, newTrackerId INT)
BEGIN

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

Update object_revision SET description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.\'])(', @old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@new_project_id,'$3'),1,0,'c') WHERE type_id IN (47);
Update object_revision SET description =  REGEXP_REPLACE(description,  CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId,')([\,\)\.\\]\}])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE type_id IN (47);
Update object_revision SET proj_id = @new_project_id, parent_id = newTrackerId WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);
Update object SET proj_id = @new_project_id, parent_id = newTrackerId WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_perftest_clobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cbroot`@`172.18.0.3` PROCEDURE `read_perftest_clobs`()
BEGIN
    DECLARE v_not_found bit(1);
DECLARE v_text_fetch TEXT;
DECLARE v_text TEXT;
DECLARE c_clob cursor for select value from perftest_clob;
declare continue handler for NOT FOUND set v_not_found = true;
SET v_not_found = false;
OPEN c_clob;
REPEAT
      FETCH c_clob INTO v_text_fetch;
IF (v_not_found is false) THEN
        SET v_text = substr(v_text_fetch, 1, LENGTH(v_text_fetch));
END IF;
UNTIL (v_not_found is true)
    END REPEAT;
CLOSE c_clob;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mysql`;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `columns_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Column_name` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `component`
--

DROP TABLE IF EXISTS `component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `component` (
  `component_id` int unsigned NOT NULL AUTO_INCREMENT,
  `component_group_id` int unsigned NOT NULL,
  `component_urn` text NOT NULL,
  PRIMARY KEY (`component_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Components';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `default_roles`
--

DROP TABLE IF EXISTS `default_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_roles` (
  `HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `USER` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `DEFAULT_ROLE_HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '%',
  `DEFAULT_ROLE_USER` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`HOST`,`USER`,`DEFAULT_ROLE_HOST`,`DEFAULT_ROLE_USER`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Default roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `engine_cost`
--

DROP TABLE IF EXISTS `engine_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `engine_cost` (
  `engine_name` varchar(64) NOT NULL,
  `device_type` int NOT NULL,
  `cost_name` varchar(64) NOT NULL,
  `cost_value` float DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(1024) DEFAULT NULL,
  `default_value` float GENERATED ALWAYS AS ((case `cost_name` when _utf8mb3'io_block_read_cost' then 1.0 when _utf8mb3'memory_block_read_cost' then 0.25 else NULL end)) VIRTUAL,
  PRIMARY KEY (`cost_name`,`engine_name`,`device_type`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `func` (
  `name` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `ret` tinyint NOT NULL DEFAULT '0',
  `dl` char(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_grants`
--

DROP TABLE IF EXISTS `global_grants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_grants` (
  `USER` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `PRIV` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `WITH_GRANT_OPTION` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`USER`,`HOST`,`PRIV`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Extended global grants';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gtid_executed`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `gtid_executed` (
  `source_uuid` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid of the source where the transaction was originally executed.',
  `interval_start` bigint NOT NULL COMMENT 'First number of interval.',
  `interval_end` bigint NOT NULL COMMENT 'Last number of interval.',
  PRIMARY KEY (`source_uuid`,`interval_start`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint unsigned DEFAULT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int unsigned NOT NULL,
  `help_keyword_id` int unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ndb_binlog_index`
--

DROP TABLE IF EXISTS `ndb_binlog_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ndb_binlog_index` (
  `Position` bigint unsigned NOT NULL,
  `File` varchar(255) NOT NULL,
  `epoch` bigint unsigned NOT NULL,
  `inserts` int unsigned NOT NULL,
  `updates` int unsigned NOT NULL,
  `deletes` int unsigned NOT NULL,
  `schemaops` int unsigned NOT NULL,
  `orig_server_id` int unsigned NOT NULL,
  `orig_epoch` bigint unsigned NOT NULL,
  `gci` int unsigned NOT NULL,
  `next_position` bigint unsigned NOT NULL,
  `next_file` varchar(255) NOT NULL,
  PRIMARY KEY (`epoch`,`orig_server_id`,`orig_epoch`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_history`
--

DROP TABLE IF EXISTS `password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_history` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Password_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `Password` text CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`Host`,`User`,`Password_timestamp` DESC)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Password history for user accounts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugin` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `dl` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='MySQL plugins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procs_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Grantor` varchar(288) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proxies_priv`
--

DROP TABLE IF EXISTS `proxies_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxies_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proxied_host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Proxied_user` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `With_grant` tinyint(1) NOT NULL DEFAULT '0',
  `Grantor` varchar(288) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`User`,`Proxied_host`,`Proxied_user`),
  KEY `Grantor` (`Grantor`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='User proxy privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_edges`
--

DROP TABLE IF EXISTS `role_edges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_edges` (
  `FROM_HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `FROM_USER` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `TO_HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `TO_USER` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `WITH_ADMIN_OPTION` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`FROM_HOST`,`FROM_USER`,`TO_HOST`,`TO_USER`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Role hierarchy and role grants';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_cost`
--

DROP TABLE IF EXISTS `server_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_cost` (
  `cost_name` varchar(64) NOT NULL,
  `cost_value` float DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(1024) DEFAULT NULL,
  `default_value` float GENERATED ALWAYS AS ((case `cost_name` when _utf8mb3'disk_temptable_create_cost' then 20.0 when _utf8mb3'disk_temptable_row_cost' then 0.5 when _utf8mb3'key_compare_cost' then 0.05 when _utf8mb3'memory_temptable_create_cost' then 1.0 when _utf8mb3'memory_temptable_row_cost' then 0.1 when _utf8mb3'row_evaluate_cost' then 0.1 else NULL end)) VIRTUAL,
  PRIMARY KEY (`cost_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(64) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int NOT NULL DEFAULT '0',
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='MySQL Foreign Servers table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slave_master_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `slave_master_info` (
  `Number_of_lines` int unsigned NOT NULL COMMENT 'Number of lines in the file.',
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the master binary log currently being read from the master.',
  `Master_log_pos` bigint unsigned NOT NULL COMMENT 'The master log position of the last read event.',
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'The host name of the master.',
  `User_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The user name used to connect to the master.',
  `User_password` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The password used to connect to the master.',
  `Port` int unsigned NOT NULL COMMENT 'The network port used to connect to the master.',
  `Connect_retry` int unsigned NOT NULL COMMENT 'The period (in seconds) that the slave will wait before trying to reconnect to the master.',
  `Enabled_ssl` tinyint(1) NOT NULL COMMENT 'Indicates whether the server supports SSL connections.',
  `Ssl_ca` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Authority (CA) certificate.',
  `Ssl_capath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path to the Certificate Authority (CA) certificates.',
  `Ssl_cert` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL certificate file.',
  `Ssl_cipher` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the cipher in use for the SSL connection.',
  `Ssl_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL key file.',
  `Ssl_verify_server_cert` tinyint(1) NOT NULL COMMENT 'Whether to verify the server certificate.',
  `Heartbeat` float NOT NULL,
  `Bind` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Displays which interface is employed when connecting to the MySQL server',
  `Ignored_server_ids` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The number of server IDs to be ignored, followed by the actual server IDs',
  `Uuid` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The master server uuid.',
  `Retry_count` bigint unsigned NOT NULL COMMENT 'Number of reconnect attempts, to the master, before giving up.',
  `Ssl_crl` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Revocation List (CRL)',
  `Ssl_crlpath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path used for Certificate Revocation List (CRL) files',
  `Enabled_auto_position` tinyint(1) NOT NULL COMMENT 'Indicates whether GTIDs will be used to retrieve events from the master.',
  `Channel_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
  `Tls_version` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Tls version',
  `Public_key_path` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file containing public key of master server.',
  `Get_public_key` tinyint(1) NOT NULL COMMENT 'Preference to get public key from master.',
  `Network_namespace` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Network namespace used for communication with the master server.',
  `Master_compression_algorithm` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Compression algorithm supported for data transfer between master and slave.',
  `Master_zstd_compression_level` int unsigned NOT NULL COMMENT 'Compression level associated with zstd compression algorithm.',
  `Tls_ciphersuites` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Ciphersuites used for TLS 1.3 communication with the master server.',
  PRIMARY KEY (`Channel_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Master Information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slave_relay_log_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `slave_relay_log_info` (
  `Number_of_lines` int unsigned NOT NULL COMMENT 'Number of lines in the file or rows in the table. Used to version table definitions.',
  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the current relay log file.',
  `Relay_log_pos` bigint unsigned DEFAULT NULL COMMENT 'The relay log position of the last executed event.',
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the master binary log file from which the events in the relay log file were read.',
  `Master_log_pos` bigint unsigned DEFAULT NULL COMMENT 'The master log position of the last executed event.',
  `Sql_delay` int DEFAULT NULL COMMENT 'The number of seconds that the slave must lag behind the master.',
  `Number_of_workers` int unsigned DEFAULT NULL,
  `Id` int unsigned DEFAULT NULL COMMENT 'Internal Id that uniquely identifies this record.',
  `Channel_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
  `Privilege_checks_username` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Username part of PRIVILEGE_CHECKS_USER.',
  `Privilege_checks_hostname` char(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'Hostname part of PRIVILEGE_CHECKS_USER.',
  `Require_row_format` tinyint(1) NOT NULL COMMENT 'Indicates whether the channel shall only accept row based events.',
  `Require_table_primary_key_check` enum('STREAM','ON','OFF') NOT NULL DEFAULT 'STREAM' COMMENT 'Indicates what is the channel policy regarding tables having primary keys on create and alter table queries',
  PRIMARY KEY (`Channel_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Relay Log Information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slave_worker_info`
--

DROP TABLE IF EXISTS `slave_worker_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slave_worker_info` (
  `Id` int unsigned NOT NULL,
  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Relay_log_pos` bigint unsigned NOT NULL,
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Master_log_pos` bigint unsigned NOT NULL,
  `Checkpoint_relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Checkpoint_relay_log_pos` bigint unsigned NOT NULL,
  `Checkpoint_master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Checkpoint_master_log_pos` bigint unsigned NOT NULL,
  `Checkpoint_seqno` int unsigned NOT NULL,
  `Checkpoint_group_size` int unsigned NOT NULL,
  `Checkpoint_group_bitmap` blob NOT NULL,
  `Channel_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
  PRIMARY KEY (`Channel_name`,`Id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Worker Information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Grantor` varchar(288) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint NOT NULL,
  `Correction` int NOT NULL,
  PRIMARY KEY (`Transition_time`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int unsigned NOT NULL,
  `Transition_time` bigint NOT NULL,
  `Transition_type_id` int unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int unsigned NOT NULL,
  `Transition_type_id` int unsigned NOT NULL,
  `Offset` int NOT NULL DEFAULT '0',
  `Is_DST` tinyint unsigned NOT NULL DEFAULT '0',
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `User` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Reload_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Shutdown_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Process_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `File_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_db_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Super_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Repl_slave_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Repl_client_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_user_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tablespace_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int unsigned NOT NULL DEFAULT '0',
  `max_updates` int unsigned NOT NULL DEFAULT '0',
  `max_connections` int unsigned NOT NULL DEFAULT '0',
  `max_user_connections` int unsigned NOT NULL DEFAULT '0',
  `plugin` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'caching_sha2_password',
  `authentication_string` text CHARACTER SET utf8 COLLATE utf8_bin,
  `password_expired` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `password_last_changed` timestamp NULL DEFAULT NULL,
  `password_lifetime` smallint unsigned DEFAULT NULL,
  `account_locked` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_role_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_role_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Password_reuse_history` smallint unsigned DEFAULT NULL,
  `Password_reuse_time` smallint unsigned DEFAULT NULL,
  `Password_require_current` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `User_attributes` json DEFAULT NULL,
  PRIMARY KEY (`Host`,`User`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mysql'
--

--
-- Table structure for table `general_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `general_log` (
  `event_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `user_host` mediumtext NOT NULL,
  `thread_id` bigint unsigned NOT NULL,
  `server_id` int unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumblob NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `slow_log` (
  `start_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `user_host` mediumtext NOT NULL,
  `query_time` time(6) NOT NULL,
  `lock_time` time(6) NOT NULL,
  `rows_sent` int NOT NULL,
  `rows_examined` int NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int NOT NULL,
  `insert_id` int NOT NULL,
  `server_id` int unsigned NOT NULL,
  `sql_text` mediumblob NOT NULL,
  `thread_id` bigint unsigned NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `codebeamer`
--

USE `codebeamer`;

--
-- Current Database: `gtd_starc_int`
--

USE `gtd_starc_int`;

--
-- Final view structure for view `group_member`
--

/*!50001 DROP VIEW IF EXISTS `group_member`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `group_member` AS select `GRP`.`id` AS `group_id`,`GRP`.`name` AS `group_name`,`GRP`.`permissions` AS `permissions`,`MBR`.`from_id` AS `user_id` from (((`user_group` `GRP` join `object_reference` `MBR` USE INDEX (`object_reference_to`) on(((`MBR`.`to_type_id` = 5) and (`MBR`.`to_id` = `GRP`.`id`) and (`MBR`.`field_id` = 2) and (`MBR`.`from_type_id` = 1)))) join `object` `GMA` on(((`GMA`.`id` = `MBR`.`assoc_id`) and (`GMA`.`deleted` = 0)))) join `object_revision` `GMS` on(((`GMS`.`object_id` = `GMA`.`id`) and (`GMS`.`revision` = `GMA`.`revision`) and (`GMS`.`status_id` = 1)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_group`
--

/*!50001 DROP VIEW IF EXISTS `member_group`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `member_group` AS select `MBR`.`from_id` AS `user_id`,`GRP`.`id` AS `group_id`,`GRP`.`name` AS `group_name`,`GRP`.`permissions` AS `permissions` from (((`object_reference` `MBR` USE INDEX (`object_reference_from`) join `user_group` `GRP` on((`GRP`.`id` = `MBR`.`to_id`))) join `object` `GMA` on(((`GMA`.`id` = `MBR`.`assoc_id`) and (`GMA`.`deleted` = 0)))) join `object_revision` `GMS` on(((`GMS`.`object_id` = `GMA`.`id`) and (`GMS`.`revision` = `GMA`.`revision`) and (`GMS`.`status_id` = 1)))) where ((`MBR`.`from_type_id` = 1) and (`MBR`.`field_id` = 2)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_project`
--

/*!50001 DROP VIEW IF EXISTS `member_project`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `member_project` AS select `MBR`.`to_type_id` AS `member_type`,`MBR`.`to_id` AS `member_id`,`PRL`.`proj_id` AS `proj_id`,`PRL`.`role_id` AS `role_id`,`PRL`.`permissions` AS `permissions` from (((`object_reference` `MBR` USE INDEX (`object_reference_to`) join `project_role` `PRL` on((`PRL`.`id` = `MBR`.`from_id`))) join `object` `PMA` on(((`PMA`.`id` = `MBR`.`assoc_id`) and (`PMA`.`type_id` = 21) and (`PMA`.`deleted` = 0)))) join `object_revision` `PMS` on(((`PMS`.`object_id` = `PMA`.`id`) and (`PMS`.`revision` = `PMA`.`revision`) and (`PMS`.`status_id` = 3)))) where ((`MBR`.`from_type_id` = 5) and (`MBR`.`field_id` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `object_tag_v`
--

/*!50001 DROP VIEW IF EXISTS `object_tag_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `object_tag_v` AS select `r`.`object_id` AS `object_id`,`r`.`revision` AS `revision`,`r`.`parent_id` AS `parent_id`,`r`.`proj_id` AS `proj_id`,`r`.`type_id` AS `type_id`,`baseline`.`id` AS `tag_id` from (`object_revision` `r` join `object` `baseline` on(((`baseline`.`type_id` in (12,34)) and (`baseline`.`created_at` >= `r`.`created_at`)))) where ((`r`.`deleted` = 0) and (`r`.`type_id` not in (3,4,12,18,19,21,34)) and (`r`.`revision` = (select max(`inr`.`revision`) from `object_revision` `inr` where ((`inr`.`object_id` = `r`.`object_id`) and (`inr`.`created_at` <= `baseline`.`created_at`))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project`
--

/*!50001 DROP VIEW IF EXISTS `project`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `project` AS select `OBJ`.`id` AS `id`,`PRJ`.`proj_id` AS `proj_id`,`PRJ`.`name` AS `name`,`PRJ`.`key_name` AS `key_name`,`PRJ`.`propagation` AS `propagation`,`PRJ`.`mount_point` AS `mount_point`,`PRJ`.`last_sync_at` AS `last_sync_at`,`PRJ`.`wiki_homepage_id` AS `wiki_homepage_id`,`PRJ`.`tracker_homepage_id` AS `tracker_homepage_id`,`PRJ`.`category_id` AS `category_id`,`REV`.`description` AS `description`,`REV`.`desc_format` AS `desc_format`,(case when (`REV`.`status_id` is null) then 0 else `REV`.`status_id` end) AS `flags`,(case when (`OBJ`.`created_at` is null) then sysdate() else `OBJ`.`created_at` end) AS `created_at`,(case when (`OBJ`.`owner_id` is null) then 1 else `OBJ`.`owner_id` end) AS `created_by`,(case when (`OBJ`.`revision` is null) then 1 else `OBJ`.`revision` end) AS `revision`,`REV`.`created_at` AS `last_modified_at`,`REV`.`created_by` AS `last_modified_by`,`REV`.`rev_comment` AS `rev_comment`,`catr`.`name` AS `category_name` from (((((`existing` `PRJ` join `existing_object_map` `EXISTING_OBJ_MAP` on((`EXISTING_OBJ_MAP`.`proj_id` = `PRJ`.`proj_id`))) join `object` `OBJ` on((`OBJ`.`id` = `EXISTING_OBJ_MAP`.`object_id`))) join `object_revision` `REV` on(((`REV`.`object_id` = `OBJ`.`id`) and (`REV`.`revision` = `OBJ`.`revision`)))) left join `object` `cat` on((`cat`.`id` = `PRJ`.`category_id`))) left join `object_revision` `catr` on(((`catr`.`object_id` = `cat`.`id`) and (`catr`.`revision` = `cat`.`revision`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project_member`
--

/*!50001 DROP VIEW IF EXISTS `project_member`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `project_member` AS select `PRL`.`proj_id` AS `proj_id`,`PRL`.`role_id` AS `role_id`,`PRL`.`permissions` AS `permissions`,`MBR`.`to_type_id` AS `member_type`,`MBR`.`to_id` AS `member_id` from (((`project_role` `PRL` join `object_reference` `MBR` USE INDEX (`object_reference_from`) on(((`MBR`.`from_type_id` = 5) and (`MBR`.`from_id` = `PRL`.`id`) and (`MBR`.`field_id` = 1)))) join `object` `PMA` on(((`PMA`.`id` = `MBR`.`assoc_id`) and (`PMA`.`type_id` = 21) and (`PMA`.`deleted` = 0)))) join `object_revision` `PMS` on(((`PMS`.`object_id` = `PMA`.`id`) and (`PMS`.`revision` = `PMA`.`revision`) and (`PMS`.`status_id` = 3)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project_role`
--

/*!50001 DROP VIEW IF EXISTS `project_role`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `project_role` AS select `PRL`.`id` AS `id`,`REV`.`name` AS `name`,`PRL`.`proj_id` AS `proj_id`,`PRL`.`reference_id` AS `role_id`,`REV`.`status_id` AS `permissions` from (`object` `PRL` join `object_revision` `REV` on(((`REV`.`object_id` = `PRL`.`id`) and (`REV`.`revision` = `PRL`.`revision`)))) where ((`PRL`.`type_id` = 19) and (`PRL`.`deleted` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `task_change_set`
--

/*!50001 DROP VIEW IF EXISTS `task_change_set`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `task_change_set` AS select `TCS`.`to_id` AS `task_id`,`REP`.`id` AS `repo_id`,`REP`.`desc_id` AS `repo_type`,`TCS`.`from_id` AS `change_id`,`SCS`.`submitted_at` AS `submitted_at`,`SCS`.`submitted_by` AS `submitted_by` from ((((`object_reference` `TCS` USE INDEX (`object_reference_to_from`) join `task` `SCS` on(((`SCS`.`id` = `TCS`.`from_id`) and (`SCS`.`priority` = 0) and (`check_bits`(`SCS`.`flags`,1) = 0)))) join `task_type` `REP` on(((`REP`.`id` = `SCS`.`type_id`) and (`REP`.`desc_id` between 900 and 920)))) join `object` `OBJ` on(((`OBJ`.`id` = `REP`.`id`) and (`OBJ`.`deleted` = 0)))) left join `object` `ASSOC` on((`ASSOC`.`id` = `TCS`.`assoc_id`))) where ((`TCS`.`to_type_id` = 9) and (`TCS`.`from_type_id` = 9) and (`TCS`.`field_id` = 17) and ((`ASSOC`.`id` is null) or (`ASSOC`.`deleted` = 0))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `task_reference_tag_v`
--

/*!50001 DROP VIEW IF EXISTS `task_reference_tag_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `task_reference_tag_v` AS select `r`.`to_id` AS `task_id`,`r`.`field_id` AS `field_id`,`r`.`from_id` AS `referrer_id`,`baseline`.`id` AS `tag_id` from ((`object_reference` `r` join `object_revision` `rev` on(((`rev`.`object_id` = `r`.`assoc_id`) and (`rev`.`deleted` = 0)))) join `object` `baseline` on(((`baseline`.`type_id` in (12,34)) and (`baseline`.`created_at` >= `rev`.`created_at`)))) where ((`r`.`from_type_id` = 9) and (`r`.`to_type_id` = 9) and (`rev`.`revision` = (select max(`inr`.`revision`) from `object_revision` `inr` where ((`inr`.`object_id` = `rev`.`object_id`) and (`inr`.`created_at` <= `baseline`.`created_at`))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `task_tag_v`
--

/*!50001 DROP VIEW IF EXISTS `task_tag_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `task_tag_v` AS select `r`.`task_id` AS `task_id`,`r`.`revision` AS `revision`,`r`.`flags` AS `flags`,`r`.`type_id` AS `type_id`,`r`.`parent_id` AS `parent_id`,`baseline`.`id` AS `tag_id` from (`task_revision` `r` join `object` `baseline` on(((`baseline`.`type_id` in (12,34)) and (`baseline`.`created_at` >= `r`.`created_at`)))) where ((`r`.`deleted` = 0) and (`r`.`revision` = (select max(`inr`.`revision`) from `task_revision` `inr` where ((`inr`.`task_id` = `r`.`task_id`) and (`inr`.`created_at` <= `baseline`.`created_at`))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_group`
--

/*!50001 DROP VIEW IF EXISTS `user_group`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cbuser`@`smtcag%dvs%.rd.corpintra.net` SQL SECURITY INVOKER */
/*!50001 VIEW `user_group` AS select `GRP`.`id` AS `id`,`REV`.`name` AS `name`,`REV`.`status_id` AS `permissions` from (`object` `GRP` join `object_revision` `REV` on(((`REV`.`object_id` = `GRP`.`id`) and (`REV`.`revision` = `GRP`.`revision`)))) where ((`GRP`.`type_id` = 18) and (`GRP`.`proj_id` is null) and (`GRP`.`deleted` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `mysql`
--

USE `mysql`;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=@OLD_INNODB_STATS_AUTO_RECALC */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-16 14:41:26
