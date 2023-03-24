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
import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.wiki.CodeBeamerWikiContext;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;

import java.util.Map;

public class ChecklistPluginNew extends AbstractCodeBeamerWikiPlugin {


    public String execute(WikiContext wikicontext, Map params) {
        Integer configItemId = Integer.parseInt((String)params.get("configItemId"));
        Integer tableId = Integer.parseInt((String)params.get("tableId"));

        TrackerItemDto configItem = TrackerItemManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(),configItemId);

        String html = "<form name=\"checklist\" action=\"/cb/api/v3/saveChecklist\" method=\"post\" id=\"checklist\">\n";

        html += "  <input type=\"hidden\" name=\"configItemId\" value=\""+ configItemId +"\">\n";
        html += "  <input type=\"hidden\" name=\"tableId\" value=\""+ tableId +"\">\n";

        for(int i = 0; i < configItem.getTableRowCount(tableId); i++) {
            html += "  <input type=\"checkbox\" " + isChecked(configItem.getTableCell(tableId,i,1)) + " id=\"" + i + "\"" + "name=\"checkbox" + i + "\">\n" +
                    "  <label for=\"item" + i + "\"" + "> " + configItem.getTableCell(tableId,i,0) + "</label><br>\n";
        }

        html += "</form>";

        html += "<input type=\"submit\" value=\"Save Checklist\" form=\"checklist\"></button>";

        return html;
    }

    private String isChecked(String tableValue) {
        return tableValue.contains("true") ? "checked" : "";
    }
}