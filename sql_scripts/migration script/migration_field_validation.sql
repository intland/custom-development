DELIMITER ;

-- Create helper table to identify items which will be ignored because of error
CREATE TABLE items_migration_invalid
(
    item_id    INT          NOT NULL,
    tracker_id INT          NOT NULL,
    message    VARCHAR(255) NOT NULL
);

-- Validate user references. If there are result then it means an item has multiple item references and it is not possible to update it properly.
INSERT INTO items_migration_invalid (item_id, tracker_id, message)
SELECT t.item_id, tr.tracker_id, 'multiple user reference'
FROM items_migration t
         INNER JOIN trackers_migration tr ON t.tracker_id = tr.tracker_id 
            AND tr.created_by_f_id IS NOT NULL
         LEFT OUTER JOIN object_reference ref ON ref.from_id = t.item_id
    AND ref.from_type_id = 9
    AND ref.to_type_id = 1
    AND ref.deleted = 0
WHERE ref.field_id = tr.created_by_f_id
GROUP BY t.item_id
HAVING COUNT(t.item_id) > 1;

COMMIT;


-- Validate date value. If there are result then it means an item doesn't have valid date value '2020-04-07 15:01:01'
INSERT INTO items_migration_invalid (item_id, tracker_id, message)
SELECT t.item_id, tr.tracker_id, 'invalid date format'
FROM items_migration t
         INNER JOIN trackers_migration tr ON t.tracker_id = tr.tracker_id
            AND tr.created_at_f_id IS NOT NULL
         INNER JOIN task_field_value v ON v.task_id = t.item_id
WHERE v.label_id = tr.created_at_f_id
  AND v.field_value NOT REGEXP '^([0-9]{4})-([0-1][0-9])-([0-3][0-9])(( [0-2][0-9]):([0-5][0-9]):([0-5][0-9]))$'
GROUP BY t.item_id;

COMMIT;

-- Validate date value and user values. It is necessary to set one of created by and created at
INSERT INTO items_migration_invalid (item_id, tracker_id, message)
SELECT t.item_id, tr.tracker_id, 'missing date and user value'
FROM items_migration t
         INNER JOIN trackers_migration tr ON t.tracker_id = tr.tracker_id
         LEFT OUTER JOIN task_field_value v ON v.task_id = t.item_id 
            AND tr.created_at_f_id IS NOT NULL
            AND v.label_id = tr.created_at_f_id
         LEFT OUTER JOIN object_reference ref ON ref.from_id = t.item_id
            AND ref.from_type_id = 9
            AND ref.to_type_id = 1
            AND ref.deleted = 0
            AND tr.created_by_f_id IS NOT NULL
            AND ref.field_id = tr.created_by_f_id
WHERE v.field_value IS NULL AND ref.to_id IS NULL
GROUP BY t.item_id, tr.tracker_id;

COMMIT;


CREATE INDEX inv_mig_i_idx ON items_migration_invalid(item_id);

-- Delete invalid items
DELETE items_migration
FROM items_migration
         INNER JOIN items_migration_invalid ON items_migration.item_id = items_migration_invalid.item_id;
COMMIT;

-- Which items have proper user value
CREATE TABLE items_migration_user AS
SELECT t.item_id, t.tracker_id
FROM items_migration t
         INNER JOIN trackers_migration tr ON t.tracker_id = tr.tracker_id
            AND tr.created_by_f_id IS NOT NULL
         INNER JOIN object_reference ref ON ref.from_id = t.item_id
            AND ref.from_type_id = 9
            AND ref.to_type_id = 1
            AND ref.deleted = 0
            AND ref.field_id = tr.created_by_f_id
WHERE ref.to_id IS NOT NULL;

COMMIT;

-- Which items have proper date value
CREATE TABLE items_migration_date AS
SELECT t.item_id, t.tracker_id
FROM items_migration t
         INNER JOIN trackers_migration tr ON t.tracker_id = tr.tracker_id
            AND tr.created_at_f_id IS NOT NULL
         INNER JOIN task_field_value v ON v.task_id = t.item_id 
            AND v.label_id = tr.created_at_f_id
WHERE v.field_value IS NOT NULL;

COMMIT;