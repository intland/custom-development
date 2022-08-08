/*
 * Copyright by Intland Software
 *
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Intland Software. ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with Intland.
 */
package com.intland.codebeamer.event.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.intland.codebeamer.manager.TrackerManager;
import com.intland.codebeamer.persistence.dto.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.event.BaseEvent;
import com.intland.codebeamer.event.TrackerItemListener;
import com.intland.codebeamer.event.util.VetoException;
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.manager.util.ActionData;
import com.intland.codebeamer.persistence.dto.base.NamedDto;
import com.intland.codebeamer.persistence.util.TrackerItemAttachmentGroup;
import org.apache.log4j.Logger;


@Component("getTestRunCustomFields")
public class GetTestRunCustomFieldsListener implements TrackerItemListener {
    @Autowired
    private TrackerManager trackerManager;
    @Autowired
    private TrackerItemManager trackerItemManager;

    protected static final Logger log = Logger.getLogger(GetTestRunCustomFieldsListener.class);

    @Override
    public void trackerItemCreated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
    }

    @Override
    public void trackerItemUpdated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        // After Test Run is updated with an upstream reference
        if (isTestRun(event.getSource().getTracker()) && event.isPostEvent() && event.getSource().getParent() != null) {

            TrackerItemDto itemNew = event.getSource().clone();
            TrackerItemDto itemOld = event.getSecondarySource().clone();

            // If severities field is updated, copy field values of test runs to bugs
            if((itemNew != null && itemOld != null) && itemNew.getSeverities() != null ) {
                try {
                    List<? extends NamedDto> reportedBugs = itemNew.getSeverities();
                    BasicLayoutDto layoutTestRun = trackerManager.getBasicLayout(itemNew.getTracker().getId());
                    Map<String, String> fieldNameMapping = createFieldMapping();

                    for (NamedDto namedDto : reportedBugs) {
                        TrackerItemReferenceWrapperDto reportedBugWrapper = (TrackerItemReferenceWrapperDto) namedDto;
                        TrackerItemDto reportedBug = reportedBugWrapper.getOriginalTrackerItem().clone();
                        TrackerLayoutLabelDto fieldTestRun;
                        boolean isUpdated  = false;
                        for (Map.Entry<String, String> fieldNameMap : fieldNameMapping.entrySet()) {

                            BasicLayoutDto layoutReportedBug = trackerManager.getBasicLayout(reportedBug.getTracker().getId());
                            TrackerLayoutLabelDto fieldReportedBug = layoutReportedBug.getFieldByName(fieldNameMap.getValue());
                            fieldTestRun = layoutTestRun.getFieldByName(fieldNameMap.getKey());

                            if(fieldReportedBug.getTypeName() != (fieldTestRun.getTypeName())) {
                                throw new VetoException("Field types do not match!");
                            }

                            Object fieldValue = fieldTestRun.getValue(itemNew);

                            if(fieldReportedBug.getValue(reportedBug,fieldReportedBug.getId()) == null) {
                                fieldReportedBug.setValue(reportedBug, fieldValue);
                            } else {
                                isUpdated = true;
                            }
                        }
                        if (!isUpdated) {
                            reportedBug.setDescription(addAdditionalDescription(reportedBug.getDescription()));
                        }
                        trackerItemManager.update(event.getUser(), reportedBug, null);
                    }
                }  catch (Exception e) {
                    log.error(e.getStackTrace());
                }
            }
        }
    }

    //Customize here the mapping between Test Run fields and Bug fields
    private Map<String, String> createFieldMapping() {
        Map<String, String> fieldNameMapping = new HashMap<String, String>();
        fieldNameMapping.put("Test Run Custom Fieldname", "Bug Custom Fieldname");
        fieldNameMapping.put("TR", "B");
        fieldNameMapping.put("TRR", "BB");
        return fieldNameMapping;
    }

    //Customize here the additional description you would like to have in your reported Bug item
    private String addAdditionalDescription(String description) {
        String custom = "__Update on this bug:__\\__Test Data (project link, username/passwd, etc.):__\\__Steps to reproduce:__# \\__Expected result__:\\\\__Actual result__:\\\\__Video or screenshot, error logs (html)__:\\\\__Notice__:";
        return  custom + "\\\\" + description;
    }

    @Override
    public void trackerItemRemoved(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
    }

    @Override
    public void trackerItemDeleted(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
    }

    @Override
    public void trackerItemEscalated(BaseEvent<TrackerItemDto, TrackerItemEscalationScheduleDto, ActionData> event)	throws VetoException {
    }

    @Override
    public void attachmentAdded(BaseEvent<TrackerItemAttachmentGroup, List<AccessPermissionDto>, ActionData> event)	throws VetoException {
    }

    @Override
    public void attachmentUpdated(BaseEvent<TrackerItemAttachmentGroup, List<AccessPermissionDto>, ActionData> event) throws VetoException {
    }

    @Override
    public void attachmentRemoved(BaseEvent<TrackerItemDto, List<ArtifactDto>, ActionData> event) throws VetoException {
    }

    /**
     * Check if the specified tracker is the "Bugs" tracker of the "Test" project
     * @param tracker to check
     * @return true if the specified tracker is the "Bugs" tracker of the "Test" project, otherwise false
     */
    protected boolean isTestRun(TrackerDto tracker) {
        return tracker != null && "Test Runs".equals(tracker.getName());
    }

    /**
     * Check if the name of the specified tracker item status is "Reopened"
     * @param status to check
     * @return true if the name of the specified tracker item status is "Reopened", otherwise false
     */
    protected boolean isReopened(NamedDto status) {
        return status != null && "Reopened".equals(status.getName());
    }

}
