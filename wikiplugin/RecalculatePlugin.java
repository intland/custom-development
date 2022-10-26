package com.intland.codebeamer.wiki.plugins;

import java.util.Map;
import com.ecyrd.jspwiki.WikiContext;
import com.intland.codebeamer.controller.support.computedfield.ComputedFieldSupport;
import com.intland.codebeamer.manager.TrackerManager;
import com.intland.codebeamer.persistence.dto.ReadOnlyTrackerItemDto;
import com.intland.codebeamer.persistence.dto.TrackerDto;
import com.intland.codebeamer.wiki.CodeBeamerWikiContext;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;

public class RecalculatePlugin extends AbstractCodeBeamerWikiPlugin {

    public String execute(WikiContext wikicontext, Map params) {

        ReadOnlyTrackerItemDto subject = (ReadOnlyTrackerItemDto) ((CodeBeamerWikiContext) wikicontext).getOwner();

        TrackerDto trackerDto = TrackerManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(), subject.getTracker().getId());

        ComputedFieldSupport computedFieldSupport = getApplicationContext(wikicontext).getBean(ComputedFieldSupport.class);
        computedFieldSupport.recalculateItemComputedFieldsInTracker(trackerDto, false);

        return "recalculated";
    }
}