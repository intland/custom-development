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

import com.intland.codebeamer.event.BaseEvent;
import com.intland.codebeamer.event.TrackerItemListener;
import com.intland.codebeamer.event.util.VetoException;
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.manager.util.ActionData;
import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.persistence.util.TrackerItemAttachmentGroup;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

//When a Task tracker item is updated, create a new Task tracker item with customized summary, description and story points.

@Component("testListenerCreateItems")
public class TestListenerCreateItems implements TrackerItemListener {

    protected static final Logger log = Logger.getLogger(TestListener.class);

    @Autowired
    TrackerItemManager trackerItemManager;

    @Override
    public void trackerItemCreated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        log.info("trackerItemCreated: " + event.getSource().toString());
    }

    @Override
    public void trackerItemUpdated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        TrackerItemDto originalItem = event.getSource().clone();
        TrackerDto tracker = originalItem.getTracker();

        if(tracker.isA(TrackerTypeDto.TASK)) {
            TrackerItemDto newItem = new TrackerItemDto();

            newItem.setTracker(tracker);
            newItem.setName("createdByListener");
            newItem.setDescription("I'm from the listener");
            newItem.setStoryPoints(50);
            try {
                trackerItemManager.create(event.getUser(),newItem,null);
            } catch (Exception e) {

            }
        }
    }

    @Override
    public void trackerItemRemoved(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        log.info("trackerItemRemoved: " + event.getSource().toString());
    }

    @Override
    public void trackerItemRestored(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        log.info("trackerItemRestored: " + event.getSource().toString());
    }

    @Override
    public void trackerItemDeleted(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        log.info("trackerItemDeleted: " + event.getSource().toString());
    }

    @Override
    public void trackerItemEscalated(BaseEvent<TrackerItemDto, TrackerItemEscalationScheduleDto, ActionData> event) throws VetoException {
        log.info("trackerItemEscalated: " + event.getSource().toString());
    }

    @Override
    public void attachmentAdded(BaseEvent<TrackerItemAttachmentGroup, List<AccessPermissionDto>, ActionData> event) throws VetoException {
        log.info("attachmentAdded: " + event.getSource().toString());
    }

    @Override
    public void attachmentUpdated(BaseEvent<TrackerItemAttachmentGroup, List<AccessPermissionDto>, ActionData> event) throws VetoException {
        log.info("attachmentUpdated: " + event.getSource().toString());
    }

    @Override
    public void attachmentRemoved(BaseEvent<TrackerItemDto, List<ArtifactDto>, ActionData> event) throws VetoException {
        log.info("attachmentRemoved: " + event.getSource().toString());
    }
}
