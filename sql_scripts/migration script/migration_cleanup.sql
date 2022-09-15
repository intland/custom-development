DELIMITER ;

-- clean up
DROP FUNCTION get_tracker_field_by_name;
DROP PROCEDURE find_trackers_for_migration;
DROP PROCEDURE find_items_for_migration;

DROP TABLE trackers_migration;
DROP TABLE items_migration;
DROP TABLE items_migration_invalid;
DROP TABLE items_migration_user;
DROP TABLE items_migration_date;