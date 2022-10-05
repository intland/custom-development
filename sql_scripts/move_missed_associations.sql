delimiter //
DROP PROCEDURE IF EXISTS correct_wrong_association;
CREATE PROCEDURE correct_wrong_association(projectId INT)
BEGIN
SELECT CONCAT('** START correct_wrong_association') AS '** DEBUG:';

CREATE TEMPORARY TABLE temp_object_table SELECT ac.id, ac.proj_id FROM object_reference ref JOIN object o ON ref.from_id = o.id AND ref.from_type_id NOT IN (1,2,9) AND o.proj_id = projectId JOIN object ac ON ref.assoc_id = ac.id WHERE ac.proj_id != o.proj_id AND ac.proj_id IS NOT NULL;
UPDATE object SET proj_id = newProjectId WHERE id IN (SELECT assoc_id FROM temp_object_table);
UPDATE object_revision SET proj_id = newProjectId WHERE object_id IN (SELECT assoc_id FROM temp_object_table);
DROP TEMPORARY TABLE temp_object_table;

CREATE TEMPORARY TABLE temp_task_table SELECT ac.id, ac.proj_id FROM object_reference ref JOIN task t ON ref.from_id = t.id AND ref.from_type_id = 9 JOIN object ac ON ref.assoc_id = ac.id JOIN object tr ON t.type_id = tr.id AND tr.type_id = 16 AND tr.proj_id = projectId WHERE ac.proj_id != tr.proj_id AND ac.proj_id IS NOT NULL;
UPDATE object SET proj_id = newProjectId WHERE id IN (SELECT assoc_id FROM temp_task_table);
UPDATE object_revision SET proj_id = newProjectId WHERE object_id IN (SELECT assoc_id FROM temp_task_table);
DROP TEMPORARY TABLE temp_task_table;

SELECT Concat('** END correct_wrong_association') AS '** DEBUG:';
END//
delimiter ;