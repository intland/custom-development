/*
 * Copyright by PTC
 *
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of PTC. ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with PTC.
 */

package com.intland.codebeamer.event.impl;

import com.intland.codebeamer.event.BaseEvent;
import com.intland.codebeamer.event.TrackerItemListener;
import com.intland.codebeamer.event.util.VetoException;
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.manager.util.ActionData;
import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.persistence.dto.base.DescribeableDto;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.util.*;
import java.util.stream.Collectors;

/*
 * This listener is triggered when a Test Set is updated.
 * If a Test Case is added to a Test Set, then this listener is responsible for adding the Test Set to
 * the Test Case's 'Verifies' choice field. If a Test Case is removed from a Test Set, it will remove the Test Set
 * from the Test Case's 'Verifies' choice field. It is a workaround for the Test Sets coverage problem when
 * the results are visualized as 'NO RESULT YET' independently of the Test Set was executed or not.
 */

@Component("testSetAndTestCaseConnector")
public class TestSetAndTestCaseConnector implements TrackerItemListener {

    @Autowired
    TrackerItemManager trackerItemManager;

    protected static final Logger log = Logger.getLogger(com.intland.codebeamer.event.impl.TestSetAndTestCaseConnector.class);

    @Override
    public void trackerItemUpdated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        if(event.getSource().getTracker().isA(TrackerTypeDto.TESTSET)) {
            TrackerItemDto newTestSet = event.getSource().clone();
            TrackerItemDto oldTestSet = event.getSecondarySource().clone();

            if(newTestSet == null || oldTestSet == null) {
                return;
            }

            List<TrackerItemReferenceWrapperDto> oldTestCases = getTestCasesByDto(oldTestSet);
            List<TrackerItemReferenceWrapperDto> newTestCases = getTestCasesByDto(newTestSet);

            if(oldTestCases.toString().equals(newTestCases.toString())){
                return;
            }

            List<TrackerItemReferenceWrapperDto> addedTestCases = new ArrayList<>(newTestCases);
            removeItemsFromList(oldTestCases, addedTestCases);
            List<TrackerItemReferenceWrapperDto> removedTestCases = new ArrayList<>(oldTestCases);
            removeItemsFromList(newTestCases, removedTestCases);

            if(!addedTestCases.isEmpty())
                addedTestCases.forEach(testCase -> addTestSetToTestCase(newTestSet,testCase.getOriginalTrackerItem().clone(),event));

            if(!removedTestCases.isEmpty())
                removedTestCases.forEach(testCase -> removeTestSetFromTestCase(newTestSet, testCase.getId(),event));
        } else if(event.getSource().getTracker().isA(TrackerTypeDto.TESTCASE)) {
            Boolean fromListener;
            if(event.getRequest() != null && event.getRequest().getAttribute("fromListener") != null && event.getRequest().getAttribute("fromListener") instanceof Boolean) {
                fromListener = (Boolean) event.getRequest().getAttribute("fromListener");
            } else {
                fromListener = Boolean.FALSE;
            }
            if(fromListener) {
                return;
            }

            TrackerItemDto newTestCase = event.getSource().clone();
            TrackerItemDto oldTestCase = event.getSecondarySource().clone();

            if(newTestCase == null || oldTestCase == null) {
                return;
            }

            List<TrackerItemDto> oldTestSets = (List<TrackerItemDto>) oldTestCase.getSubjects();
            List<TrackerItemDto> newTestSets = (List<TrackerItemDto>) newTestCase.getSubjects();
            if(oldTestSets==null)
                oldTestSets = new ArrayList<>();
            if(newTestSets==null)
                newTestSets = new ArrayList<>();

            if(oldTestSets.toString().equals(newTestSets.toString())) {
                return;
            }
            List<TrackerItemDto> addedTestSets = new ArrayList<>(newTestSets);
            removeItemsFromList(oldTestSets, addedTestSets);
            List<TrackerItemDto> removedTestSets = new ArrayList<>(oldTestSets);
            removeItemsFromList(newTestSets, removedTestSets);



            if(!removedTestSets.isEmpty()) {
                removedTestSets.forEach(testSet -> removeTestCaseFromTestSet(newTestCase, testSet, event));
            }
            if(!addedTestSets.isEmpty()) {
                addedTestSets.forEach(testSet -> addTestCaseToTestSet(newTestCase, testSet.getId(), event));
            }
        }
    }

    private void removeTestCaseFromTestSet(TrackerItemDto testCaseToRemove, TrackerItemDto testSet, BaseEvent event) {
        if (!event.isPreEvent()) {
            return;
        }
        List<TrackerItemReferenceWrapperDto> testCases = getTestCasesByDao(testSet);
        if(testCases.removeIf(testCase -> testCase.getOriginalTrackerItem().getId().equals(testCaseToRemove.getId()))) {
            setUpdatedTestCasesInTestSet(testSet,testCases);
        }
    }


    private void addTestCaseToTestSet(TrackerItemDto testCase, Integer testSetId, BaseEvent event) {
        if (!event.isPostEvent()) {
            return;
        }
        TrackerItemDto testSet = trackerItemManager.getTrackerItemDao().findById(testSetId).clone();
        List<TrackerItemReferenceWrapperDto> testCases = getTestCasesByDao(testSet);
        if(!testCases.contains(testCase)){
            testCases.add(TrackerItemReferenceWrapperDto.wrap(testCase));
            setUpdatedTestCasesInTestSet(testSet,testCases);
        }
    }

    private void setUpdatedTestCasesInTestSet(TrackerItemDto testSet, List<TrackerItemReferenceWrapperDto> testCases) {
        testSet.setTableColumn(0,0, new ArrayList<>());
        for(int i = 0; i < testCases.size(); i++) {
            testSet.setTableReferenceCell(0,i,0, new TrackerItemReferenceWrapperDto(testCases.get(i)));
        }
        try {
            trackerItemManager.getTrackerItemDao().update(testSet);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private List<TrackerItemReferenceWrapperDto> getTestCasesByDao(TrackerItemDto testSet) {
        List<List<TrackerItemReferenceWrapperDto>> listOfTestCaseLists = new ArrayList<>();

        TrackerItemDto newTestSet = trackerItemManager.getTrackerItemDao().findById(testSet.getId());

        for(int i = 0; i < newTestSet.getTableRowCount(0); i++) {
            listOfTestCaseLists.add(newTestSet.getTableReferenceCell(0,i,0));
        }

        List<TrackerItemReferenceWrapperDto> flatTestCases =
                listOfTestCaseLists.stream()
                        .flatMap(List::stream)
                        .collect(Collectors.toList());

        return flatTestCases;
    }

    private List<TrackerItemReferenceWrapperDto> getTestCasesByDto(TrackerItemDto testSet) {
        List<List<TrackerItemReferenceWrapperDto>> listOfTestCaseLists = new ArrayList<>();

        for(int i = 0; i < testSet.getTableRowCount(0); i++) {
            listOfTestCaseLists.add(testSet.getTableReferenceCell(0,i,0));
        }

        List<TrackerItemReferenceWrapperDto> flatTestCases =
                listOfTestCaseLists.stream()
                        .flatMap(List::stream)
                        .collect(Collectors.toList());

        return flatTestCases;
    }

    private void addTestSetToTestCase(TrackerItemDto testSet, TrackerItemDto testCase, BaseEvent event) {
        if (!event.isPostEvent()) {
            return;
        }
        List<TrackerItemDto> originalTestSets = new ArrayList<>();
        if(testCase.getSubjects() != null) {
            originalTestSets = (List<TrackerItemDto>) testCase.getSubjects();
        }
        if(!originalTestSets.contains(testSet)) {
            originalTestSets.add(testSet);
            testCase.setSubjects(originalTestSets);
            try {
                trackerItemManager.update(event.getUser(), testCase, null);
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    private void removeTestSetFromTestCase(TrackerItemDto testSet, Integer testCaseId, BaseEvent event) {
        if (!event.isPreEvent()) {
            return;
        }
        TrackerItemDto testCase = trackerItemManager.getTrackerItemDao().findById(event.getUser(), testCaseId).clone();
        List<TrackerItemDto> originalTestSets;
        if(testCase.getSubjects() != null) {
            originalTestSets = (List<TrackerItemDto>) testCase.getSubjects();
            originalTestSets.removeIf(item -> item.getId().equals(testSet.getId()));
            testCase.setSubjects(originalTestSets);
            try {
                ActionData actionData = new ActionData(event.getRequest());
                actionData.getRequest().setAttribute("fromListener", Boolean.TRUE);
                trackerItemManager.update(event.getUser(), testCase, actionData);
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    private void removeItemsFromList(List<? extends DescribeableDto> listToRemove, List<? extends DescribeableDto> originalList) {
        if(listToRemove != null) {
            listToRemove.forEach(toRemove -> {
                originalList.removeIf(item -> item.getId().equals(toRemove.getId()));
            });
        }
    }
}
