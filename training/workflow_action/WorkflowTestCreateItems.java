package com.intland.codebeamer.actions;

import com.intland.codebeamer.manager.AccessRightsException;
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.manager.util.ChangeVetoedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.intland.codebeamer.event.BaseEvent;
import com.intland.codebeamer.manager.util.ActionData;
import com.intland.codebeamer.manager.workflow.ActionCall;
import com.intland.codebeamer.manager.workflow.WorkflowAction;
import com.intland.codebeamer.manager.workflow.WorkflowPhase;
import com.intland.codebeamer.persistence.dto.ArtifactDto;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;

import java.util.concurrent.TimeoutException;

@Component("workflowTestCreateItems")
@WorkflowAction(value="workflowTestCreateItems", iconUrl="/images/Snapshot.png", helpUrl="https://codebeamer.com/cb/wiki/816624")

public class WorkflowTestCreateItems {

    @Autowired
    TrackerItemManager trackerItemManager;

    @ActionCall(WorkflowPhase.Before)
    public void testMethod(BaseEvent<ArtifactDto,TrackerItemDto,ActionData> event) {
        TrackerItemDto subject = event.getSecondarySource();
        TrackerItemDto newItem = new TrackerItemDto();
        newItem.setTracker(subject.getTracker());
        newItem.setName("createdByWorkflowAction");
        newItem.setDescription("I'm from the workflow action");
        try {
            trackerItemManager.create(event.getUser(),newItem,null);
        } catch (Exception e) {
        }
    }
}