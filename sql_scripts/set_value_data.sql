delimiter //
/************************************************
* @name: set_broken_refrences_to_last_valid_data
* @auth: JHENSSL
* @date: 2021.10.23
* @desc: use list of existing data to relink 
*        broken links to the last valid data
************************************************/
DROP PROCEDURE IF EXISTS set_broken_refrences_to_last_valid_data;
CREATE PROCEDURE set_broken_refrences_to_last_valid_data(IN list_of_existing_data VARCHAR(21845))
BEGIN 
	DECLARE isFinished BOOLEAN DEFAULT FALSE;
	DECLARE non_existing_data INT;
	DECLARE comma_pos SMALLINT;
	
	DECLARE list_of_not_existing_data CURSOR FOR SELECT object_id FROM object_revision WHERE !FIND_IN_SET(object_id, list_of_existing_data) AND type_id = 44;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET isFinished = TRUE;
	
	-- SELECT ('** START set_broken_refrences_to_last_valid_data') AS '** DEBUG:';
	OPEN list_of_not_existing_data;
	
	read_loop: LOOP
	FETCH list_of_not_existing_data INTO non_existing_data;
	IF isFinished THEN
	  LEAVE read_loop;
	END IF THEN
		-- SELECT CONCAT('**Start loop ') AS '** DEBUG:';
		-- SELECT the id of the valid data reference. 
		SELECT MAX(to_id) INTO @latest_data FROM object_reference WHERE from_id IN (SELECT from_id FROM object_reference WHERE to_id = non_existing_data) AND FIND_IN_SET(to_id, list_of_existing_data);
		--SELECT CONCAT('** Get latest data ', @latest_data, ' Non existing Data id: ', non_existing_data) AS '** DEBUG:';
		-- set all occurence of broken reference to the valid reference
		IF latest_data IS NOT NULL
			UPDATE object_reference SET to_id = @latest_data WHERE to_id = non_existing_data;
			SELECT CONCAT('** latest data id: ', @latest_data, ' replace non existing Data id: ', non_existing_data) AS '** DEBUG:';
		END IF;
	END LOOP;
	CLOSE list_of_not_existing_data;	
	-- SELECT CONCAT('** END set_broken_refrences_to_last_valid_data') AS '** DEBUG:';
END//
delimiter ;
