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
import com.intland.codebeamer.persistence.dto.base.DescribeableDto;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/*
 * This listener is triggered when a Test Set is updated.
 * If a Test Case is added to a Test Set, then this listener is responsible for adding the Test Set to
 * the Test Case's 'Verifies' choice field. If a Test Case is removed from a Test Set, it will remove the Test Set
 * from the Test Case's 'Verifies' choice field. It is a workaround for the Test Sets coverage problem when
 * the results are visualized as 'NO RESULT YET' independently of the Test Set was executed or not.
*/

@Component("testSetToVerifiesListener")
public class TestSetToVerifiesListener implements TrackerItemListener {

    @Autowired
    TrackerItemManager trackerItemManager;

    protected static final Logger log = Logger.getLogger(ReviewHubArtifactListener.class);
    @Override
    public void trackerItemUpdated(BaseEvent<TrackerItemDto, TrackerItemDto, ActionData> event) throws VetoException {
        if(event.getSource().getTracker().isA(TrackerTypeDto.TESTSET)) {

            TrackerItemDto newTestSet = event.getSource().clone();
            TrackerItemDto oldTestSet = event.getSecondarySource().clone();

            if(newTestSet == null || oldTestSet == null) {
                return;
            }

            List<TrackerItemReferenceWrapperDto> flatOldTestCases = createFlatListTestCases(oldTestSet);
            List<TrackerItemReferenceWrapperDto> flatNewTestCases = createFlatListTestCases(newTestSet);

            if(flatOldTestCases.toString().equals(flatNewTestCases.toString())){
                return;
            }

            List<TrackerItemReferenceWrapperDto> addedTestCases = new ArrayList<>(flatNewTestCases);
            removeItemsFromList(flatOldTestCases, addedTestCases);
            List<TrackerItemReferenceWrapperDto> removedTestCases = new ArrayList<>(flatOldTestCases);
            removeItemsFromList(flatNewTestCases, removedTestCases);

            if(!addedTestCases.isEmpty())
                addedTestCases.forEach(testCase -> addTestSetToTestCase(newTestSet,testCase.getOriginalTrackerItem().clone(),event.getUser()));

            if(!removedTestCases.isEmpty())
                removedTestCases.forEach(testCase -> removeTestSetFromTestCase(newTestSet, testCase.getOriginalTrackerItem().getId(), event.getUser()));
        }
        else if(event.getSource().getTracker().isA(TrackerTypeDto.TESTCASE)) {
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



            if(removedTestSets != null) {
                log.info("removed test Sets:" + removedTestSets);
                removedTestSets.forEach(testSet -> removeTestCaseFromTestSet(newTestCase, testSet));
            }
            if(addedTestSets != null) {
                log.info("added test Sets:" + addedTestSets);
                addedTestSets.forEach(testSet -> addTestCaseToTestSet(newTestCase, testSet.clone()));
            }

        }
    }

    private void removeTestCaseFromTestSet(TrackerItemDto testCase, TrackerItemDto testSet) {
        List<TrackerItemReferenceWrapperDto> testCases = createFlatListTestCases(testSet);
        log.info("removed table test cases" + testCases.get(0) + testCases.get(1));
        List<Map<Integer, String>> table = testSet.getTable(0);
        table.forEach(row -> {
            log.info("tableRow:" + row);
        });
        table.stream().filter(row -> !row.get(0).contains(testCase.toString().substring(10,13)));
        testSet.setTable(0,table);
    }


    private void addTestCaseToTestSet(TrackerItemDto testCase, TrackerItemDto testSet) {
        List<TrackerItemReferenceWrapperDto> testCases = createFlatListTestCases(testSet);
        log.info("added table test cases" + testCases);
    }

    private List<TrackerItemReferenceWrapperDto> createFlatListTestCases(TrackerItemDto testSet) {
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

    private void addTestSetToTestCase(TrackerItemDto testSet, TrackerItemDto testCase, UserDto user) {
        List<TrackerItemDto> originalTestSets = new ArrayList<>();
        if(testCase.getSubjects() != null) {
            originalTestSets = (List<TrackerItemDto>) testCase.getSubjects();
        }
        originalTestSets.add(testSet);
        testCase.setSubjects(originalTestSets);
        try {
            trackerItemManager.update(user, testCase, null);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    private void removeTestSetFromTestCase(TrackerItemDto testSet, Integer testCaseId, UserDto user) {
        TrackerItemDto testCase = trackerItemManager.findById(user, testCaseId).clone();
        List<TrackerItemDto> originalTestSets;
        if(testCase.getSubjects() != null) {
            originalTestSets = (List<TrackerItemDto>) testCase.getSubjects();
            originalTestSets.removeIf(item -> item.getId().equals(testSet.getId()));
            testCase.setSubjects(originalTestSets);
            try {
                trackerItemManager.update(user, testCase, null);
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
