delimiter //
DROP PROCEDURE IF EXISTS move_to_identical_tracker;
CREATE PROCEDURE move_to_identical_tracker(oldTrackerId INT, newTrackerId INT )
BEGIN
DECLARE oldOutline LONGTEXT;
DECLARE newOutline LONGTEXT;
SELECT CONCAT('** START move to identical tracker') AS '** DEBUG:';
Update task_revision SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task SET type_id = newTrackerId WHERE type_id = oldTrackerId;
Update task_search_history SET type_id = newTrackerId WHERE type_id = oldTrackerId;

-- the delete will trigger the recalculation of the outline.
DELETE FROM tracker_outline WHERE tracker_id IN (newTrackerId, oldTrackerId);

/*
IF (SELECT * FROM tracker_outline WHERE tracker_id = oldTrackerId) IS NOT NULL THEN 
	SELECT CONCAT(LEFT(outline, LOCATE(':',outline)), newTrackerId ,RIGHT(outline, LENGTH(outline) - LOCATE(',', outline)+1)) INTO newOutline FROM tracker_outline WHERE tracker_id = oldTrackerId;
	SELECT CONCAT('** START old outline ', oldOutline) AS '** DEBUG:';
	Update tracker_outline SET outline = oldOutline WHERE tracker_id = oldTrackerId;
END IF;

IF (SELECT * FROM tracker_outline WHERE tracker_id = newTrackerId) IS NOT NULL THEN 
	SELECT CONCAT(LEFT(outline, LOCATE(':',outline)), oldTrackerId ,RIGHT(outline, LENGTH(outline) - LOCATE(',', outline)+1)) INTO oldOutline FROM tracker_outline WHERE tracker_id = newTrackerId;
	SELECT CONCAT('** START new outline ', newOutline) AS '** DEBUG:';
	Update tracker_outline SET outline = newOutline WHERE tracker_id = newTrackerId;
END IF;
*/

SELECT Concat('** END move to identical tracker') AS '** DEBUG:';
END//
delimiter ;


SELECT * FROM tracker_outline WHERE tracker_id = 2480