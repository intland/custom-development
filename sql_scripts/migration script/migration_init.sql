DELIMITER ;;


-- Create function to find fields
CREATE FUNCTION get_tracker_field_by_name(p_tracker_id INT, p_field_name varchar(255)) RETURNS INT NOT DETERMINISTIC READS SQL DATA SQL SECURITY INVOKER
BEGIN
    DECLARE v_tracker_id int(11);
    DECLARE v_field_obj_id int(11);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_field_obj_id = NULL;

    SET v_tracker_id = p_tracker_id;
    REPEAT
        SELECT o.reference_id INTO v_field_obj_id FROM object o
                                                 INNER JOIN object_revision r ON r.object_id = o.id AND r.revision = o.revision
        WHERE o.deleted = 0
          AND o.type_id = 25
          AND o.parent_id = v_tracker_id
          AND r.name = p_field_name;
        IF v_field_obj_id IS NULL THEN
            BEGIN
                DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_tracker_id = NULL;
                SELECT tt.template_id INTO v_tracker_id FROM task_type tt WHERE tt.id = v_tracker_id;
            END;
        END IF;
    UNTIL v_field_obj_id IS NOT NULL OR v_tracker_id IS NULL END REPEAT;

    RETURN v_field_obj_id;
END;;

-- Create helper table to identify tracker in which the items will be updated
CREATE TABLE trackers_migration (
                                    tracker_id INT NOT NULL PRIMARY KEY,
                                    created_by_f_id INT,
                                    created_at_f_id INT
);;

-- Create function to find trackers with the proper fields
CREATE PROCEDURE find_trackers_for_migration()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_tr_id int(11);
    DECLARE v_created_by_f_id int(11);
    DECLARE v_created_at_f_id int(11);
    DECLARE tr_curs CURSOR FOR SELECT tr.id,
                                      COALESCE(get_tracker_field_by_name(tr.id, 'Created By'), get_tracker_field_by_name(tr.id, 'Issue Created By')) as created_by_f,
                                      COALESCE(get_tracker_field_by_name(tr.id, 'Created On Date'), get_tracker_field_by_name(tr.id, 'Issue Created On Date')) as created_at_f
                               FROM object tr
                               WHERE tr.type_id = 16 /* 16 = Tracker */
                                 AND tr.deleted = 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN tr_curs;
    read_loop:
    LOOP
        FETCH tr_curs INTO v_tr_id, v_created_by_f_id, v_created_at_f_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF v_tr_id IS NOT NULL AND (v_created_by_f_id IS NOT NULL OR v_created_at_f_id IS NOT NULL) THEN
            INSERT INTO trackers_migration (tracker_id, created_by_f_id, created_at_f_id) VALUES (v_tr_id, v_created_by_f_id, v_created_at_f_id);
        END IF;
    END LOOP read_loop;
    CLOSE tr_curs;
END;;

-- Create helper table to identify items which will be migrated
CREATE TABLE items_migration (
                                 item_id INT NOT NULL PRIMARY KEY,
                                 tracker_id INT NOT NULL
);;

-- Create function to find items
CREATE PROCEDURE find_items_for_migration()
BEGIN
    DECLARE v_migration_user_id int(11);
    SELECT u.id
    INTO v_migration_user_id
    FROM users u
    WHERE u.name = 'MIGRATION_USER';

    IF v_migration_user_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Not found MIGRATION_USER user';
    END IF;

    INSERT INTO items_migration (item_id, tracker_id)
    SELECT t.id, t.type_id
    FROM trackers_migration tr
             INNER JOIN task t ON t.type_id = tr.tracker_id
        AND t.submitted_by = v_migration_user_id;

    COMMIT;
END;;

DELIMITER ;

CALL find_trackers_for_migration();
COMMIT;

CALL find_items_for_migration();
COMMIT;
