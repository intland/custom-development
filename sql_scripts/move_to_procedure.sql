delimiter //
DROP PROCEDURE IF EXISTS move_to_identical_tracker;
CREATE PROCEDURE move_to_identical_tracker(oldTrackerId INT, newTrackerId INT)
BEGIN
SELECT CONCAT('** START move to identical tracker') AS '** DEBUG:';

CREATE TEMPORARY TABLE temp_task_table SELECT id FROM task WHERE type_id = oldTrackerId;

Update task_revision SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task_search_history SET type_id = newTrackerId WHERE type_id = oldTrackerId;

-- the delete will trigger the recalculation of the outline.
DELETE FROM tracker_outline WHERE tracker_id IN (newTrackerId, oldTrackerId);

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

-- Set Task Association to new project
Update object SET proj_id = @new_project_id WHERE id IN (SELECT assoc_id AS 'Assoc Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND assoc_id IS NOT NULL AND from_type_id IN (9)) AND type_id = 17;
Update object_revision SET proj_id = @new_project_id WHERE object_id IN (SELECT assoc_id AS 'Assoc Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND assoc_id IS NOT NULL AND from_type_id IN (9)) AND type_id = 17;

-- Set Attachment to new project
Update object SET proj_id = @new_project_id WHERE id IN (SELECT to_id AS 'Attachment Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND field_id = 88 AND to_type_id = 5 AND from_type_id IN (9));
Update object_revision SET proj_id = @new_project_id WHERE object_id IN (SELECT to_id AS 'Attachment Id' FROM object_reference WHERE from_id IN (SELECT id FROM temp_task_table) AND field_id = 88 AND to_type_id = 5 AND from_type_id IN (9));

CALL move_views(oldTrackerId, newTrackerId);

CALL adjust_reports(oldTrackerId, newTrackerId);

DROP TEMPORARY TABLE temp_task_table;

SELECT Concat('** END move to identical tracker') AS '** DEBUG:';
END//


DROP PROCEDURE IF EXISTS move_views;
CREATE PROCEDURE move_views(oldTrackerId INT, newTrackerId INT) 
BEGIN

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

-- create prefix for renaming the views
SELECT key_name INTO @prefix_view FROM project WHERE proj_id = @old_project_id;

IF @prefix_view IS NOT NULL THEN
	Update object_revision rev JOIN object obj ON obj.id = rev.object_id AND rev.revision = obj.revision SET rev.name = CONCAT( @prefix_view, '_', rev.name) WHERE rev.type_id IN (47) AND rev.parent_id = oldTrackerId AND rev.proj_id = @old_project_id;
END IF;

-- adjust views
Update object_revision rev JOIN object obj ON obj.id = rev.object_id AND rev.revision = obj.revision SET rev.description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.\'])(', @old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@new_project_id,'$3'),1,0,'c') WHERE rev.type_id IN (47) AND rev.parent_id = oldTrackerId AND rev.proj_id = @old_project_id;
Update object_revision rev JOIN object obj ON obj.id = rev.object_id AND rev.revision = obj.revision SET rev.description =  REGEXP_REPLACE(description,  CONCAT('(Tracker\\\\":|[tT]rackerId[s]?\\\\":|[\\[\,\(\.\'"])(',oldTrackerId,')([\\D])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE rev.type_id IN (47) AND rev.parent_id = oldTrackerId AND rev.proj_id = @old_project_id;

Update object_revision SET proj_id = @new_project_id, parent_id = newTrackerId WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);

-- move folder structure
SELECT REGEXP_SUBSTR(description, '(?<="publicViewStructure":[\\s]?"\\[\\{).*(\\}\\]",[\\s]?")') INTO @public_view_folder FROM object_revision rev JOIN object o ON rev.object_id = o.id AND rev.revision = o.revision WHERE rev.object_id = oldTrackerId;
UPDATE object_revision rev JOIN object o ON rev.object_id = o.id AND rev.revision = o.revision SET rev.description = REGEXP_REPLACE(rev.description,  CONCAT('("publicViewStructure":"\\[\\{)(.*)(\\}\\]",")'), CONCAT('$1','$2', "},{", @public_view_folder),1,0,'c') WHERE rev.object_id = newTrackerId;

-- delete folder structure in old tracker (comment out) 
-- UPDATE object_revision rev JOIN object o ON rev.object_id = o.id AND rev.revision = o.revision SET rev.description = REGEXP_REPLACE(rev.description,  CONCAT('("publicViewStructure":[\\s]?"\\[\\{).*(\\}\\]",[\\s]?")'), '',1,0,'c') WHERE rev.object_id = oldTrackerId;


-- move permission of view
Update object_access_permission oap JOIN object o ON o.id = oap.object_id SET oap.proj_id = @new_project_id WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);

Update object SET proj_id = @new_project_id, parent_id = newTrackerId WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);

END//

DROP PROCEDURE IF EXISTS adjust_reports;
CREATE PROCEDURE adjust_reports(oldTrackerId INT, newTrackerId INT) 
BEGIN

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

Update object_revision rev JOIN object obj ON obj.id = rev.object_id AND rev.revision = obj.revision SET rev.description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.])(',@old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@old_project_id,',', @new_project_id,'$3'),1,0,'c') WHERE  REGEXP_LIKE(description, CONCAT('([\\[\,\(\.\'])(', @old_project_id, ')([\,\)\.\\]])')) AND REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|[tT]rackerId[s]?\\\\":|[\\[\,\(\.\'"])(',oldTrackerId,')([\\D])')) AND rev.type_id IN (29);
Update object_revision rev JOIN object obj ON obj.id = rev.object_id AND rev.revision = obj.revision SET rev.description = REGEXP_REPLACE(description,  CONCAT('([\'])(',@old_project_id,')([\.])'), CONCAT('$1', @new_project_id,'$3'),1,0,'c') WHERE  REGEXP_LIKE(description, CONCAT('([\\[\,\(\.\'])(', @old_project_id, ')([\,\)\.\\]])')) AND REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|[tT]rackerId[s]?\\\\":|[\\[\,\(\.\'"])(',oldTrackerId,')([\\D])')) AND rev.type_id IN (29);

Update object_revision rev JOIN object obj ON obj.id = rev.object_id AND rev.revision = obj.revision SET description = REGEXP_REPLACE(description, CONCAT('(Tracker\\\\":|[tT]rackerId[s]?\\\\":|[\\[\,\(\.\'"])(',oldTrackerId,')([\\D])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|[tT]rackerId[s]?\\\\":|[\\[\,\(\.\'"])(',oldTrackerId,')([\\D])')) AND rev.type_id IN (29);

END//
delimiter ;



