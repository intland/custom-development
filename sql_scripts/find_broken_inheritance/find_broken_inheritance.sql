delimiter //
DROP PROCEDURE IF EXISTS start_find_all_broken_inheritance;
CREATE PROCEDURE start_find_all_broken_inheritance(debug BOOLEAN)
BEGIN 
	DECLARE isNotFound BOOLEAN DEFAULT FALSE;
	DECLARE trackerId INT;
	DECLARE field_id INT;
	DECLARE field CURSOR FOR SELECT obj.parent_id AS trackerId, obj.reference_id AS field_id FROM  object AS obj JOIN object_revision AS obj_rev ON obj.id = obj_rev.object_id WHERE obj.type_id = 25 AND obj.revision = obj_rev.revision AND obj.proj_id IN (SELECT proj_id FROM task_type WHERE template_id IS NULL GROUP BY proj_id);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET isNotFound = TRUE;
	
	SET @temp_recursion_depth = @@GLOBAL.max_sp_recursion_depth;
	
	SELECT Concat('** START start_find_all_broken_inheritance') AS '** DEBUG:';

    DROP TABLE IF EXISTS Broken_Inheritance_Temp;
    CREATE TABLE Broken_Inheritance_Temp (
    proj_id int,
    tracker_id int,
    field_id int,
    template_id int
    );
    
    OPEN field;

	read_loop: LOOP
	FETCH field INTO trackerId, field_id;
	IF isNotFound THEN
	  LEAVE read_loop;
	END IF;	
		CALL find_broken_inheritance(trackerId, field_id, debug);
        IF debug THEN
		    SELECT Concat('** Check Template of ', trackerId, ' and field id: ', field_id) AS '** DEBUG:';
        END IF;
	END LOOP;

	CLOSE field;
	SET @@SESSION.max_sp_recursion_depth = @temp_recursion_depth;
	SELECT Concat('** END start_find_all_broken_inheritance') AS '** DEBUG:';
	END//

DROP PROCEDURE IF EXISTS start_find_proj_broken_inheritance;
CREATE PROCEDURE start_find_proj_broken_inheritance(projId INT, debug BOOLEAN)
BEGIN 
	DECLARE isNotFound BOOLEAN DEFAULT FALSE;
	DECLARE trackerId INT;
	DECLARE field_id INT;
	DECLARE field CURSOR FOR SELECT obj.parent_id AS trackerId, obj.reference_id AS field_id FROM  object AS obj JOIN object_revision AS obj_rev ON obj.id = obj_rev.object_id WHERE obj.type_id = 25 AND obj.revision = obj_rev.revision AND obj.proj_id = projId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET isNotFound = TRUE;
	
	SET @temp_recursion_depth = @@GLOBAL.max_sp_recursion_depth;
	
	SELECT Concat('** START start_find_proj_broken_inheritance') AS '** DEBUG:';
	
    DROP TABLE IF EXISTS Broken_Inheritance_Temp;
    CREATE TABLE Broken_Inheritance_Temp (
    proj_id int,
    tracker_id int,
    field_id int,
    template_id int
    );
    
    OPEN field;

	read_loop: LOOP
	FETCH field INTO trackerId, field_id;
	IF isNotFound THEN
	  LEAVE read_loop;
	END IF;	
		CALL find_broken_inheritance(trackerId, field_id, debug);
        IF debug THEN
		    SELECT Concat('** Check Template of ', trackerId, ' and field id: ', field_id) AS '** DEBUG:';
        END IF;
	END LOOP;

	CLOSE field;
	SET @@SESSION.max_sp_recursion_depth = @temp_recursion_depth;
	SELECT Concat('** END start_find_proj_broken_inheritance') AS '** DEBUG:';
	END//

DROP PROCEDURE IF EXISTS find_broken_inheritance;
CREATE PROCEDURE find_broken_inheritance(trackerId INT, fieldId INT, debug BOOLEAN)
BEGIN 
	DECLARE isFinished BOOLEAN DEFAULT FALSE;
	DECLARE newTrackerId INT;
	DECLARE templateId INT;
    DECLARE projId INT;
	DECLARE statusId INT DEFAULT 1;
	DECLARE derivedTracker CURSOR FOR SELECT id, proj_id, template_id FROM task_type WHERE template_id = trackerId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET isFinished = TRUE;
	
    IF debug THEN
	    SELECT Concat('** START find_broken_inheritance: PARAM: ', trackerId, ' Field id: ', fieldId) AS '** DEBUG:';
    END IF;
	OPEN derivedTracker;
	
	SET @@SESSION.max_sp_recursion_depth = 100;
	SET @recursion_depth = IFNULL(@recursion_depth + 1, 1);

	read_loop: LOOP
	FETCH derivedTracker INTO newTrackerId, projId, templateId;

    SELECT COUNT(1) INTO @count_temp FROM object WHERE type_id = 25 AND parent_id = newTrackerId AND reference_id = fieldId LIMIT 1;
    IF @count_temp > 0 THEN
        CALL write_broken_inheritance_result(projId, newTrackerId, fieldId, templateId);
    END IF;
	IF isFinished THEN
	  LEAVE read_loop;
	END IF;

    IF debug THEN
	    SELECT Concat('** found derived tracker with tracker id: ', newTrackerId , ' of this template id: ', templateId) AS '** DEBUG:';
    END IF;
	
    Call find_broken_inheritance(projId, newTrackerId, fieldId);
	END LOOP;
	CLOSE derivedTracker;	
	SET @recursion_depth = @recursion_depth - 1;
    IF debug THEN
	    SELECT Concat('** END find_broken_inheritance') AS '** DEBUG:';
    END IF;
END//

DROP PROCEDURE IF EXISTS write_broken_inheritance_result;
CREATE PROCEDURE write_broken_inheritance_result(projId INT, trackerId INT, fieldId INT, templateId INT)
BEGIN 
    INSERT INTO Broken_Inheritance_Temp VALUES (projId, trackerId, fieldId, templateId);
END//
delimiter ;