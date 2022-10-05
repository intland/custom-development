
/************************************************
* @name: set_broken_refrences_to_last_valid_data
* @auth: JHENSSL
* @date: 2021.10.23
* @desc: use list of existing data to relink 
*        broken links to the last valid data
************************************************/
CREATE OR REPLACE Procedure set_broken_refrences_to_last_valid_data
   ( list_of_existing_data IN varchar2 )
IS
   non_existing_data number;
   cursor list_of_not_existing_data IS SELECT object_id FROM object_revision WHERE object_id NOT IN (list_of_existing_data) AND type_id = 44;
BEGIN

   OPEN list_of_not_existing_data;
   FETCH list_of_not_existing_data INTO non_existing_data;
	-- SELECT ('** START set_broken_refrences_to_last_valid_data') AS '** DEBUG:';
	LOOP
	EXIT WHEN list_of_not_existing_data%notfound;
	-- SELECT CONCAT('**Start loop ') AS '** DEBUG:';
	-- SELECT the id of the valid data reference. 
	SELECT MAX(to_id) INTO @latest_data FROM object_reference WHERE from_id IN (SELECT from_id FROM object_reference WHERE to_id = non_existing_data) AND to_id IN (list_of_existing_data);
	--SELECT CONCAT('** Get latest data ', @latest_data, ' Non existing Data id: ', non_existing_data) AS '** DEBUG:';
	-- set all occurence of broken reference to the valid reference
	UPDATE object_reference SET to_id = @latest_data WHERE to_id = non_existing_data;

	END LOOP;

   CLOSE list_of_not_existing_data;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;