package com.intland.codebeamer.actions;

import com.intland.codebeamer.manager.TrackerItemManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.manager.workflow.ActionParam;
import com.intland.codebeamer.event.BaseEvent;
import com.intland.codebeamer.manager.util.ActionData;
import com.intland.codebeamer.manager.workflow.ActionCall;
import com.intland.codebeamer.manager.workflow.WorkflowAction;
import com.intland.codebeamer.manager.workflow.WorkflowPhase;
import com.intland.codebeamer.persistence.dto.ArtifactDto;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;

@Component("workflowTest")
@WorkflowAction(value="workflowTest", iconUrl="/images/Snapshot.png", helpUrl="https://codebeamer.com/cb/wiki/816624")

public class WorkflowTest {

    @Autowired
    TrackerItemManager trackerItemManager;

    @ActionCall(WorkflowPhase.Before)
    public void testMethod(BaseEvent<ArtifactDto,TrackerItemDto,ActionData> event,  @ActionParam(value="ID of Field", required=true) int fieldId) {
        TrackerItemDto subject = event.getSecondarySource();

        String valueOfCustomField = subject.getCustomField(fieldId);

        System.out.println("FIELD VALUE OF CUSTOM FIELD: " + valueOfCustomField);
    }
}