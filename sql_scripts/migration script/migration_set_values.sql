DELIMITER ;

-- START MIGRATION
-- START USER MIGRATION

-- Set submitted_by in task table
UPDATE items_migration_user u
    INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
    INNER JOIN task t ON u.item_id = t.id
    INNER JOIN object_reference r ON r.from_id = t.id
        AND r.from_type_id = 9
        AND r.to_type_id = 1
        AND r.deleted = 0
SET t.submitted_by = r.to_id
WHERE r.field_id = tr.created_by_f_id;

COMMIT;

-- Set submitted_by in search history table
UPDATE items_migration_user u
    INNER JOIN task t ON u.item_id = t.id
    INNER JOIN task_search_history th ON th.id = t.id
SET th.submitted_by = t.submitted_by
WHERE u.item_id > 0;

COMMIT;

-- DELETE user reference
DELETE r
FROM items_migration_user u
         INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
         INNER JOIN object_reference r ON r.from_id = u.item_id
    AND r.from_type_id = 9
    AND r.to_type_id = 1
    AND r.deleted = 0
WHERE r.field_id = tr.created_by_f_id;

COMMIT;

-- DELETE user reference from history
DELETE r
FROM items_migration_user u
         INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
         INNER JOIN reference_search_history r ON r.from_id = u.item_id
    AND r.from_type_id = 9
    AND r.to_type_id = 1
WHERE r.field_id = tr.created_by_f_id;

COMMIT;

-- DELETE delta history
DELETE vh
FROM items_migration_user u
         INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
         INNER JOIN task_field_history vh ON vh.task_id = u.item_id
WHERE vh.label_id = tr.created_by_f_id;

COMMIT;

-- Update revision history
UPDATE items_migration_user u
    INNER JOIN task t ON t.id = u.item_id
    INNER JOIN task_revision tr ON tr.task_id = t.id
SET tr.created_by = t.submitted_by
WHERE tr.revision = 1;
-- END USER MIGRATION

COMMIT;

-- START DATE MIGRATION

-- Set submitted_at in task
UPDATE items_migration_date u
    INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
    INNER JOIN task t ON u.item_id = t.id
    INNER JOIN task_field_value v ON v.task_id = t.id
SET t.submitted_at = STR_TO_DATE(v.field_value, '%Y-%m-%d %H:%i:%s')
WHERE v.label_id = tr.created_at_f_id;

COMMIT;

-- Set submitted_at in search history table
UPDATE items_migration_date u
    INNER JOIN task t ON u.item_id = t.id
    INNER JOIN task_search_history th ON th.id = t.id
SET th.submitted_at = t.submitted_at
WHERE u.item_id > 0;

COMMIT;

-- DELETE date value from value table
DELETE v
FROM items_migration_date u
         INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
         INNER JOIN task_field_value v ON v.task_id = u.item_id
WHERE v.label_id = tr.created_at_f_id;

COMMIT;

-- DELETE delta history
DELETE vh
FROM items_migration_date u
         INNER JOIN trackers_migration tr ON tr.tracker_id = u.tracker_id
         INNER JOIN task_field_history vh ON vh.task_id = u.item_id
WHERE vh.label_id = tr.created_at_f_id;

COMMIT;

-- Update revision history
UPDATE items_migration_date u
    INNER JOIN task t ON t.id = u.item_id
    INNER JOIN task_revision tr ON tr.task_id = t.id
SET tr.created_at = t.submitted_at
WHERE u.item_id > 0
  AND tr.revision = 1;
-- END DATE MIGRATION

COMMIT;

-- END MIGRATION