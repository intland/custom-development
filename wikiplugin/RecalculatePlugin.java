package com.intland.codebeamer.wiki.plugins;

import java.util.Map;
import com.ecyrd.jspwiki.WikiContext;
import com.intland.codebeamer.controller.support.computedfield.ComputedFieldSupport;
import com.intland.codebeamer.manager.TrackerManager;
import com.intland.codebeamer.persistence.dto.TrackerDto;
import com.intland.codebeamer.wiki.CodeBeamerWikiContext;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;

/**
 * Enables the user to trigger the recalculation of all computed fields of items in a tracker.
 * The ID of the tracker have to be passed as parameter.
 * Whenever the plugin loads, the recalculation will start, so run it only when necessary to prevent performance issues
 * when working with giant trackers with many items and computed fields.
 */

public class RecalculatePlugin extends AbstractCodeBeamerWikiPlugin {

    public String execute(WikiContext wikicontext, Map params) {

        Integer trackerId = Integer.parseInt((String)params.get("trackerId"));

        TrackerDto trackerDto = TrackerManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(), trackerId);

        ComputedFieldSupport computedFieldSupport = getApplicationContext(wikicontext).getBean(ComputedFieldSupport.class);
        computedFieldSupport.recalculateItemComputedFieldsInTracker(trackerDto, false);

        return "Recalculated: " + new java.util.Date();
    }
}