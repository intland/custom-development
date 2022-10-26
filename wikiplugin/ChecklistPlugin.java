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
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;
import com.intland.codebeamer.wiki.CodeBeamerWikiContext;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;
import com.intland.codebeamer.wiki.plugins.googlemaps.Wiki2HTMLConverter;

import java.util.List;
import java.util.Map;

public class ChecklistPlugin extends AbstractCodeBeamerWikiPlugin {

    public String execute(WikiContext wikicontext, Map params) {

        Integer testRunId = Integer.parseInt((String)params.get("testRunId"));

        TrackerItemManager.getInstance();

        TrackerItemDto testRun = TrackerItemManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(),testRunId);

        List<TrackerItemDto> children = testRun.getChildren();

        String tableMarkup = "";

        for(int i = 0; i < children.size(); i++) {
            tableMarkup = "[{Table" + "\n\n" + "| "+ children.get(i).getName() + "\n" +"|" + "\n\n";

            for(int j = 0; j < children.get(i).getTableRowCount(1); j++) {
                tableMarkup +="| " + children.get(i).getTableCell(1, j ,0) + "\n" + "| " + children.get(i).getTableCell(1, j ,4) + "\n\n";
            }
            tableMarkup+= "}]";
        }

        String html = Wiki2HTMLConverter.wiki2HTML(wikicontext, tableMarkup);

        return html;
    }
}