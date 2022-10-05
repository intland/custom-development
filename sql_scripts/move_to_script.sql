delimiter //
DROP PROCEDURE IF EXISTS move_to_identical_tracker;
CREATE PROCEDURE move_to_identical_tracker(oldTrackerId INT, newTrackerId INT )
BEGIN
SELECT CONCAT('** START move to identical tracker') AS '** DEBUG:';

CREATE TEMPORARY TABLE temp_task_table SELECT id AS 'Task Id' FROM task WHERE type_id = oldTrackerId;
CREATE TEMPORARY TABLE temp_assoc_table SELECT assoc_id AS 'Assoc Id' FROM object_reference WHERE from_id IN (SELECT id FROM task WHERE type_id = oldTrackerId) AND assoc_id IS NOT NULL;
CREATE TEMPORARY TABLE temp_attachment_table SELECT to_id AS 'Attachment Id' FROM object_reference WHERE from_id IN (SELECT id FROM task WHERE type_id = oldTrackerId) AND field_id = 88 ;

Update task_revision SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task_search_history SET type_id = newTrackerId WHERE type_id = oldTrackerId;
-- the delete will trigger the recalculation of the outline.
DELETE FROM tracker_outline WHERE tracker_id IN (newTrackerId, oldTrackerId);

SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

Update object SET proj_id = @new_project_id WHERE id IN (SELECT assoc_id FROM temp_assoc_table);
Update object_revision SET proj_id = @new_project_id WHERE object_id IN (SELECT assoc_id FROM temp_assoc_table);

Update object SET proj_id = @new_project_id WHERE id IN (SELECT id FROM temp_attachment_table);
Update object_revision SET proj_id = @new_project_id WHERE object_id IN (SELECT id FROM temp_attachment_table);

CALL move_views(oldTrackerId, newTrackerId);

SELECT Concat('** END move to identical tracker') AS '** DEBUG:';
END//

DROP PROCEDURE IF EXISTS move_views;
CREATE PROCEDURE move_views(oldTrackerId INT, newTrackerId INT) 
BEGIN
-- move views to new tracker
SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

Update object_revision SET description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.\'])(', @old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@new_project_id,'$3'),1,0,'c') WHERE type_id IN (47);
Update object_revision SET description =  REGEXP_REPLACE(description,  CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId,')([\,\)\.\\]\}])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE type_id IN (47);
Update object_revision SET proj_id = @new_project_id, parent_id = newTrackerId WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);
Update object SET proj_id = @new_project_id, parent_id = newTrackerId WHERE parent_id = oldTrackerId AND proj_id = @old_project_id AND type_id IN (47);
END//
delimiter ;
/*
-- To Do check how comments and attachments from task are able to move.
DROP IF EXISTS move_comments_and_attachments;
CREATE PROCEDURE move_comments_and_attachments(oldTrackerId INT, newTrackerId INT) 
BEGIN

--SELECT * FROM object WHERE proj_id = 10887 AND type_id IN (13,15)
--13 files
--15 attachments or comments
--31 Project Dashboard


--object_reference table type_id
--1 User Account kann vernachlässigt werden
--5 Artifact
--9 Tracker item
--21 File_Link_Artifact
--field_id 88 => comments and attachments


SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;
UPDATE object SET proj_id = <<new project id>> WHERE proj_id = <<old project id>> AND type_id IN (15);
UPDATE object_revision SET proj_id = <<new project id>> WHERE proj_id = <<old project id>> AND type_id IN (15);
END//


-- To Do check how associations from task.
DROP IF EXISTS move_associations;
CREATE PROCEDURE move_associations(oldTrackerId INT, newTrackerId INT) 
BEGIN
SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;
UPDATE object assoc JOIN object_reference obj_ref ON assoc.id = obj_ref.assoc_id JOIN object obj ON obj.id = obj_ref.from_id SET assoc.proj_id = <<new project Id>> WHERE obj.proj_id IN (<<old project id>>) AND assoc.proj_id = <<old project id>>;
UPDATE object_revision assoc_rev JOIN object_reference obj_ref ON assoc_rev.object_id = obj_ref.assoc_id JOIN object obj ON obj.id = obj_ref.from_id SET assoc_rev.proj_id = <<new project id>> WHERE obj.proj_id IN (<<old project id>>) AND assoc_rev.proj_id = <<old project id>>;
END//
*/

DROP IF EXISTS adjust_reports;
CREATE PROCEDURE adjust_reports(oldTrackerId INT, newTrackerId INT) 
BEGIN
-- adjust reports to new project_id and new tracker id
SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

-- need more work to decide if it should replace project ids.
Update object_revision SET description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.\'])(',@old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@old_project_id,',', @new_project_id,'$3'),1,0,'c') WHERE  REGEXP_LIKE(description, CONCAT('([\\[\,\(\.\'])(', @old_project_id, ')([\,\)\.\\]])')) AND REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId, ')([\,\)\.\\]\}])')) AND type_id IN (29);
Update object_revision SET description = REGEXP_REPLACE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(',oldTrackerId,')([\,\)\.\\]\}])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId, ')([\,\)\.\\]\}])')) AND type_id IN (29);
END//



/* Preset needs more work because it needed to be decided where it should be available... 
Select Query welche Fälle


DROP IF EXISTS adjust_presets;
CREATE PROCEDURE adjust_presets(oldTrackerId INT, newTrackerId INT) 
BEGIN
-- adjust presets to new project_id and new tracker id
SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;

Update object_revision SET description = REGEXP_REPLACE(description,  CONCAT('([\\[\,\(\.\'])(',@old_project_id,')([\,\)\.\\]])'), CONCAT('$1',@new_project_id,'$3'),1,0,'c') WHERE  REGEXP_LIKE(description, CONCAT('([\\[\,\(\.\'])(', @old_project_id, ')([\,\)\.\\]])')) AND REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId, ')([\,\)\.\\]\}])')) AND type_id IN (46);
Update object_revision SET description = REGEXP_REPLACE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(',oldTrackerId,')([\,\)\.\\]\}])'), CONCAT('$1',newTrackerId,'$3'),1,0,'c') WHERE REGEXP_LIKE(description, CONCAT('(Tracker\\\\":|TrackerIds\\\\":|[\\[\,\(\.\'])(', oldTrackerId, ')([\,\)\.\\]\}])')) AND type_id IN (46);
Update object_revision SET proj_id = @new_project_id WHERE proj_id = @old_project_id AND type_id IN (46);
Update object SET proj_id = @new_project_id WHERE proj_id = @old_project_id AND type_id IN (46);
END//
*/

-- Only a node of a wiki should be moved to a new location.
DROP PROCEDURE IF EXISTS move_to_node_wiki;
CREATE PROCEDURE move_to_node_wiki(oldprojectId INT, newprojectId INT, node INT)
BEGIN
SELECT CONCAT('** START move to node wiki') AS '** DEBUG:';
SELECT MAX(reference_id) = @temp_reference_id FROM object WHERE proj_id = oldprojectId AND type_id IN (6);
Update object SET proj_id = newprojectId, reference_id = @temp_reference_id WHERE proj_id = oldprojectId AND type_id IN (6);
Update object SET proj_id = newprojectId WHERE proj_id = oldprojectId AND type_id IN (11,31);
Update object_revision SET proj_id = newprojectId WHERE proj_id = oldprojectId AND type_id IN (6, 11 ,31);
SELECT Concat('** END move to node wiki') AS '** DEBUG:';
END//


/*
-- To Do check how associations from task.
DROP IF EXISTS update_object;
CREATE PROCEDURE update_object(itemId INT, oldTrackerId INT, newTrackerId INT) 
BEGIN
SELECT proj_id INTO @new_project_id FROM object WHERE id = newTrackerId;
SELECT proj_id INTO @old_project_id FROM object WHERE id = oldTrackerId;
UPDATE object assoc JOIN object_reference obj_ref ON assoc.id = obj_ref.assoc_id JOIN object obj ON obj.id = obj_ref.from_id SET assoc.proj_id = <<new project Id>> WHERE obj.proj_id IN (<<old project id>>) AND assoc.proj_id = <<old project id>>;
UPDATE object_revision assoc_rev JOIN object_reference obj_ref ON assoc_rev.object_id = obj_ref.assoc_id JOIN object obj ON obj.id = obj_ref.from_id SET assoc_rev.proj_id = <<new project id>> WHERE obj.proj_id IN (<<old project id>>) AND assoc_rev.proj_id = <<old project id>>;
END//
*/
delimiter ;