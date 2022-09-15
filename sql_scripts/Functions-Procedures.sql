DELIMITER ;;
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `artifact_accessible_revision`(userId INT, documentId INT, headRevision INT, workflowId INT, publishedRevision INT, requestedRevision INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `artifact_path`(obj_id INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `artifact_visible_revision`(userId INT, documentId INT, revision INT, workflowId INT, publishedRevision INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `assigned_to_value`(tid INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `check_bits`(mask INT, bits INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `clear_bits`(mask INT, bits INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `getChoiceLabel`(p_task_id INT, p_field_id INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `getFieldChoiceLabelHist`(p_task_id INT, p_label_id INT, p_field_id INT, p_timestamp DATETIME(3)) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `getTrackerFieldChoiceLabel`(p_task_id INT, p_label_id INT, p_field_id INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `getTrackerItemResolution`(bits INT) RETURNS varchar(30) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `getTrackerItemStatus`(bits INT) RETURNS varchar(30) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `get_tracker_field`(p_tracker_id INT, p_field_id INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `has_tracker_permission`(tracker_id INT, owner_id INT, uid INT, rid INT, bits INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `is_reference_field`(p_task_id INT, p_field_id INT, p_ref_type INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `json_field_value`(json TEXT BINARY, field VARCHAR(80)) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `next_template_tracker_id`(tid INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `numeric_json_field_value`(json TEXT BINARY, field VARCHAR(80)) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `set_bits`(mask INT, bits INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_choice_field_value`(tid INT, fid INT) RETURNS varchar(512) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_choice_sort_value`(tid INT, fid INT, cid INT) RETURNS varchar(28) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_custom_field_value`(tid INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_field_value_at`(tid INT, fid INT, rev INT, dflt MEDIUMTEXT) RETURNS mediumtext CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_numeric_field_value`(tid INT, fid INT) RETURNS decimal(20,3)
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_numeric_field_value_at`(tid INT, fid INT, rev INT, dflt INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_ref_field_value`(tid INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_ref_field_value_hist`(tid INT, trev INT, fid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `task_ref_field_value_to`(tid INT, fid INT, toid INT) RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `type_choice_option_flags`(tid INT, fid INT, cid INT) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `type_choice_option_name`(tid INT, fid INT, cid INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
CREATE DEFINER=`cbroot`@`localhost` FUNCTION `wiki_link_id`(wiki_link VARCHAR(255)) RETURNS int
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
CREATE DEFINER=`cbroot`@`localhost` PROCEDURE `insert_perftest_clobs`(p_length INT, p_count INT)
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
CREATE DEFINER=`cbroot`@`localhost` PROCEDURE `read_perftest_clobs`()
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