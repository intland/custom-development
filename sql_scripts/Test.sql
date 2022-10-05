-- object (id, proj_id, revision, type_id) ==> letzte Revision 
-- object_reference (object_id, proj_id, revision, type_id, name, description) 
-- com.intland.codebeamer.remoting.ArtifactType ===> type_id => 49 = Workingset,  16 = Tracker
SELECT * FROM object obj JOIN object_revision obj_rev ON obj.id = obj_rev.object_id AND obj.revision = obj_rev.revision AND obj.type_id = 49 WHERE obj.proj_id IN (<<my project>>);

SELECT * FROM object obj JOIN object_revision obj_rev ON obj.id = obj_rev.object_id AND obj.revision = obj_rev.revision AND obj.type_id = 16 WHERE obj.proj_id IN (<<my project>>);

-- object_refrence (from_id, to_id)
-- type_id ==> 9 = Tracker item, 5 = ArtifactType, 21
-- com.intland.codebeamer.remoting.GroupType 
SELECT * FROM object_reference 


-- SELECT WHAT YOU WANT SEE
SELECT tracker.id 'Tracker Id', tracker_rev.name 'Tracker Name', workingset_rev.name 'Workingset Name', workingset_rev.object_id 'Workingset Id' 
FROM object_reference obj_ref 

JOIN object workingset ON obj_ref.from_id = workingset.id 
JOIN object_revision workingset_rev ON workingset.id = workingset_rev.object_id AND workingset.revision = workingset_rev.revision AND workingset.type_id = 49

JOIN object tracker ON obj_ref.to_id = tracker.id 
JOIN object_revision tracker_rev ON tracker.id = tracker_rev.object_id AND tracker.revision = tracker_rev.revision AND tracker.type_id = 16
WHERE tracker.proj_id IN (<<project_id>>);
