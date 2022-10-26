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

package com.intland.codebeamer.wiki.plugins;

import com.ecyrd.jspwiki.WikiContext;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.choice.TestRun;
import com.intland.codebeamer.manager.TestCaseManager;
import com.intland.codebeamer.manager.TestRunManager;
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.manager.TrackerManager;
import com.intland.codebeamer.manager.testmanagement.TestCase;
import com.intland.codebeamer.persistence.dto.ReadOnlyTrackerItemDto;
import com.intland.codebeamer.persistence.dto.TrackerDto;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;
import com.intland.codebeamer.remoting.TestManagementRemotingSupport;
import com.intland.codebeamer.wiki.CodeBeamerWikiContext;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;
import com.intland.codebeamer.wiki.plugins.googlemaps.Wiki2HTMLConverter;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ChecklistPluginINIT extends AbstractCodeBeamerWikiPlugin {

    private final static Logger log = Logger.getLogger(TestManagementRemotingSupport.class);

    public String execute(WikiContext wikicontext, Map params) {

        Integer testCaseId = Integer.parseInt((String)params.get("testCaseId"));

        ReadOnlyTrackerItemDto subject = (ReadOnlyTrackerItemDto) ((CodeBeamerWikiContext) wikicontext).getOwner();

        TrackerItemDto testCase = TrackerItemManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(),testCaseId);

        List<TrackerItemDto> testCaseList =new ArrayList<>();
        testCaseList.add(testCase);

        TrackerDto testRunTracker = TrackerManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(),3866);

        TrackerItemDto testRunTemplate = new TrackerItemDto();
        testRunTemplate.setTracker(testRunTracker);
        TestManagementRemotingSupport testManagementRemotingSupport = getApplicationContext(wikicontext).getBean(TestManagementRemotingSupport.class);
        TrackerItemDto testRun = new TrackerItemDto();
        try{
           testRun  = testManagementRemotingSupport.createTestSetRun(testRunTemplate,testCaseList,false,((CodeBeamerWikiContext) wikicontext).getUser(), wikicontext.getHttpRequest());
        } catch(Exception e) {
            log.error(e.getMessage());
        }

        Integer testRunId = testRun.getId();

        TrackerItemDto originalTrackerItem = subject.clone();
        originalTrackerItem.setDescription("[{ChecklistPlugin testRunId = " + testRunId + "}]");

        try {
            TrackerItemManager.getInstance().update(((CodeBeamerWikiContext) wikicontext).getUser(), originalTrackerItem, null);
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        String tableMarkup = "[{ChecklistPlugin testRunId = " + testCaseId + "}]";

        String html = Wiki2HTMLConverter.wiki2HTML(wikicontext, tableMarkup);

        return html;
    }
}