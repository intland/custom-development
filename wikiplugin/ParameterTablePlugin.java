
package com.intland.codebeamer.wiki.plugins;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.ecyrd.jspwiki.WikiContext;
import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.persistence.dto.ReadOnlyTrackerItemDto;
import com.intland.codebeamer.persistence.dto.TrackerItemReferenceWrapperDto;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;
import com.intland.codebeamer.wiki.CodeBeamerWikiContext;
import com.intland.codebeamer.wiki.plugins.googlemaps.Wiki2HTMLConverter;

public class ParameterTablePlugin extends AbstractCodeBeamerWikiPlugin {

    public String execute(WikiContext wikicontext, Map params) {

        Integer parameterTrackerId = Integer.parseInt((String)params.get("parameterTrackerId"));
        Integer variantsFieldId = Integer.parseInt((String)params.get("variantsFieldId"));
        Integer usedParametersFieldId = Integer.parseInt((String)params.get("usedParametersFieldId"));

        ReadOnlyTrackerItemDto subject = (ReadOnlyTrackerItemDto) ((CodeBeamerWikiContext) wikicontext).getOwner();

        String html = "";

        // get items from description
        String description = subject.getDescription();

        Pattern pattern = Pattern.compile("(\\[ITEM:)([\\d]*)(\\])", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(description);

        ArrayList<String> searchItemIds = new ArrayList<String>();

        while(matcher.find()) {
            searchItemIds.add(matcher.group(2));
        }

        List<TrackerItemDto> trackerItems = TrackerItemManager.getInstance().findById(((CodeBeamerWikiContext) wikicontext).getUser(),searchItemIds);

        List<TrackerItemDto> parameterTrackerItems = new ArrayList<>();

        for (TrackerItemDto trackerItem : trackerItems) {
            if(trackerItem.getTracker().getId().equals(parameterTrackerId)) {
                parameterTrackerItems.add(trackerItem);
            }
        }

        // get variants
        ArrayList<TrackerItemDto> variants = (ArrayList<TrackerItemDto>) subject.getChoiceList(variantsFieldId);

        if(variants == null) {
            return html;
        }

        ArrayList<String> variantNames = new ArrayList<>();

        String[] vars;

        for(int i = 0; i <  variants.size(); i++) {
            vars = variants.get(i).toString().split("-");
            variantNames.add(vars[2].replaceAll("\\s",""));
        }

        String tableMarkup = "[{Table" + "\n\n" + "|" + "\n";

        String varId = "";
        String[] var;
        for(int i = 0; i <  variants.size(); i++) {

            var = variants.get(i).toString().split("-");
            varId = var[1];
            tableMarkup += "| [ISSUE:" + varId + "\n";
        }

        tableMarkup += "\n\n";

        for(int l = 0; l < parameterTrackerItems.size(); l++) {
            TrackerItemDto trackerItem = (TrackerItemDto)parameterTrackerItems.get(l);
            tableMarkup += "| [ISSUE: " + trackerItem.getId() + "]" + "\n";
            for (int i = 0; i < variantNames.size(); i++) {
                boolean foundMatch = false;
                String matchValue = "";
                for(int j = 0; j < trackerItem.getTableRowCount(0); j++) {
                    List<TrackerItemReferenceWrapperDto> variantColumnItems = trackerItem.getTableReferenceCell(0,j,0);
                    if(variantColumnItems != null && variantColumnItems.toString().contains(variantNames.get(i))) {
                        foundMatch = true;
                        if (trackerItem.getTableCell(0,j,1) != null) {
                            matchValue = "|" + trackerItem.getTableCell(0,j,1) + "\n";
                        }
                        else {
                            matchValue = "| \n";
                        }
                    }
                }
                if(foundMatch) {
                    tableMarkup += matchValue;
                }
                else {
                    tableMarkup += "|" + "\n";
                }
            }
            if(l < parameterTrackerItems.size() - 1) {
                tableMarkup += "\n";
            }
        }

        tableMarkup += "}]";

        TrackerItemDto originalTrackerItem = subject.clone();
        originalTrackerItem.setChoiceList(usedParametersFieldId , parameterTrackerItems);
        try {
            TrackerItemManager.getInstance().update(((CodeBeamerWikiContext) wikicontext).getUser(), originalTrackerItem, null);
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        if(!parameterTrackerItems.isEmpty()) {
            html = Wiki2HTMLConverter.wiki2HTML(wikicontext, tableMarkup);
        }

        return html;
    }
}