CREATE TABLE IF NOT EXISTS temp_req_if_assoc
(
    task_id     int(11),
    field_value mediumtext
);
TRUNCATE TABLE temp_req_if_assoc;

CREATE TABLE IF NOT EXISTS temp_req_if_assoc_tracker_id
(
    tracker_id int(11)
);
TRUNCATE TABLE temp_req_if_assoc_tracker_id;

# START OF INPUT
INSERT INTO temp_req_if_assoc_tracker_id(tracker_id) VALUES (12345);

INSERT INTO temp_req_if_assoc (task_id, field_value)
VALUES (1529, '{"id":"_c9722d97-074a-4540-a12d-4974d3115e83"}'),
       (1530, '{"id":"_78e7dc46-fe5f-48f9-93bd-6040c6cc16df"}');
# END OF INPUT

INSERT INTO task_field_value (task_id, label_id, field_value)
SELECT tr.task_id, 13001 as label_id, tr.field_value
FROM task tc
         INNER JOIN temp_req_if_assoc tr ON (tc.id = tr.task_id)
WHERE tc.id NOT IN
      (SELECT id
       FROM task
                JOIN task_field_value tfv ON task.id = tfv.task_id
       WHERE task.type_id = (SELECT tracker_id FROM temp_req_if_assoc_tracker_id)
         AND label_id = 13001)
  AND tc.type_id = (SELECT tracker_id FROM temp_req_if_assoc_tracker_id);