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
import com.intland.codebeamer.persistence.dto.TrackerItemDto;
import com.intland.codebeamer.persistence.dto.TrackerItemReferenceWrapperDto;
import com.intland.codebeamer.persistence.dto.TrackerTypeDto;
import com.intland.codebeamer.persistence.dto.UserDto;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component("testSetToVerifiesListener")
public class TestSetToVerifiesListener implements TrackerItemListener {

    @Autowired
    TrackerItemManager trackerItemManager;

    protected static final Logger log = Logger.getLogger(ReviewHubArtifactListener.class);
    @Override
    public void trackerItemUpdated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        if(event.getSource().getTracker().isA(TrackerTypeDto.TESTSET)) {

            TrackerItemDto newTestRun = event.getSource().clone();
            TrackerItemDto oldTestRun = event.getSecondarySource().clone();

            if(newTestRun == null || oldTestRun == null) {
                return;
            }

            List<List<TrackerItemReferenceWrapperDto>> newTestCases = new ArrayList<>();
            List<List<TrackerItemReferenceWrapperDto>> oldTestCases = new ArrayList<>();

            for(int i = 0; i < newTestRun.getTableRowCount(0); i++) {
                newTestCases.add(newTestRun.getTableReferenceCell(0,i,0));
            }

            for(int i = 0; i < oldTestRun.getTableRowCount(0); i++) {
                oldTestCases.add(oldTestRun.getTableReferenceCell(0,i,0));
            }

            List<TrackerItemReferenceWrapperDto> flatOldTestCases =
                    oldTestCases.stream()
                            .flatMap(List::stream)
                            .collect(Collectors.toList());
            List<TrackerItemReferenceWrapperDto> flatNewTestCases =
                    newTestCases.stream()
                            .flatMap(List::stream)
                            .collect(Collectors.toList());

            if(flatOldTestCases.toString().equals(flatNewTestCases.toString())){
                return;
            }

            List<TrackerItemReferenceWrapperDto> addedTestCases = new ArrayList<>(flatNewTestCases);
            removeItemsFromList(flatOldTestCases, addedTestCases);
            List<TrackerItemReferenceWrapperDto> removedTestCases = new ArrayList<>(flatOldTestCases);
            removeItemsFromList(flatNewTestCases, removedTestCases);

            if(!addedTestCases.isEmpty())
            addedTestCases.forEach(testCase -> addTestRunToTestCase(newTestRun,testCase.getOriginalTrackerItem().clone(),event.getUser()));

            if(!removedTestCases.isEmpty())
            removedTestCases.forEach(testCase -> removeTestRunFromTestCase(newTestRun, testCase.getOriginalTrackerItem().getId(), event.getUser()));
        }
    }

    private void addTestRunToTestCase(TrackerItemDto testRun, TrackerItemDto testCase, UserDto user) {
        List<TrackerItemDto> originalTestRuns = new ArrayList<>();
        if(testCase.getSubjects() != null) {
            originalTestRuns = (List<TrackerItemDto>) testCase.getSubjects();
        }
        originalTestRuns.add(testRun);
        testCase.setSubjects(originalTestRuns);
        try {
            trackerItemManager.update(user, testCase, null);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    private void removeTestRunFromTestCase(TrackerItemDto testRun, Integer testCaseId, UserDto user) {
        TrackerItemDto testCase = trackerItemManager.findById(user, testCaseId).clone();
        List<TrackerItemDto> originalTestRuns;
        if(testCase.getSubjects() != null) {
            originalTestRuns = (List<TrackerItemDto>) testCase.getSubjects();
            originalTestRuns.removeIf(item -> item.getId().equals(testRun.getId()));
            testCase.setSubjects(originalTestRuns);
            try {
                trackerItemManager.update(user, testCase, null);
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    private void removeItemsFromList(List<TrackerItemReferenceWrapperDto> listToRemove, List<TrackerItemReferenceWrapperDto> originalList) {
        listToRemove.forEach(toRemove -> {
            originalList.removeIf(item -> item.getId().equals(toRemove.getId()));
        });
    }
}
