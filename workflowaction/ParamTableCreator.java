package com.intland.codebeamer.actions;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.manager.workflow.ActionParam;
import com.intland.codebeamer.controller.QueriesResult;
import com.intland.codebeamer.event.BaseEvent;
import com.intland.codebeamer.manager.CbQLManager;
import com.intland.codebeamer.manager.util.ActionData;
import com.intland.codebeamer.manager.workflow.ActionCall;
import com.intland.codebeamer.manager.workflow.WorkflowAction;
import com.intland.codebeamer.manager.workflow.WorkflowPhase;
import com.intland.codebeamer.persistence.dto.ArtifactDto;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;

@Component("demoAction")
@WorkflowAction(value="demoAction", iconUrl="/images/Snapshot.png", helpUrl="https://codebeamer.com/cb/wiki/816624")

public class ParamTableCreator {

    @Autowired
    private CbQLManager cbQLManager;

    @ActionCall(WorkflowPhase.Before)
    public void testMethode(BaseEvent<ArtifactDto,TrackerItemDto,ActionData> event,  @ActionParam(value="Parameter Tracker (ID)", required=true) int paramterTrackerId,  @ActionParam(value="Variants Field (ID)", required=true) int variantsFieldId, @ActionParam(value="Result Table Field (ID)", required=true) int tableFieldId) {
        String  searchItemIds = "";

        TrackerItemDto subject = event.getSecondarySource();

        // get items from description
        String description = subject.getDescription();

        Pattern pattern = Pattern.compile("(\\[ITEM:)([\\d]*)(\\])", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(description);

        ArrayList<String> str = new ArrayList<String>();

        while(matcher.find()) {
            str.add(matcher.group(2));
        }

        searchItemIds = str.toString();
        searchItemIds = searchItemIds.substring(1, searchItemIds.length() -1);
        searchItemIds = searchItemIds.replaceAll("\\s+","");

        String cbQL = "tracker.id IN (" + paramterTrackerId + ") AND item.id IN (" + searchItemIds + ")";

        // Get current request
        HttpServletRequest request = event.getRequest();

        if(request == null) {
            request = new org.springframework.mock.web.MockHttpServletRequest();
        }

        // Run query lookup
        QueriesResult trackerItemQueryResult = cbQLManager.runQuery(request, cbQL, new CbQLManager.PagingParams(500, false));

        @SuppressWarnings("unchecked")
        List<Object> trackerItems = trackerItemQueryResult.getTrackerItems().getList();

        // get variants
        @SuppressWarnings("unchecked")
        ArrayList<TrackerItemDto>variants = (ArrayList<TrackerItemDto>) subject.getChoiceList(variantsFieldId);

        ArrayList<String>variantNames = new ArrayList<>();

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

        for(int l = 0; l < trackerItems.size(); l++) {
            TrackerItemDto trackerItem = (TrackerItemDto)trackerItems.get(l);
            tableMarkup += "| [ISSUE: " + trackerItem.getId() + "]" + "\n";
            for (int i = 0; i < variantNames.size(); i++) {
                boolean foundMatch = false;
                String matchValue = "";
                for(int j = 0; j < trackerItem.getTableRowCount(0); j++) {
                    if(variantNames.get(i).equals(trackerItem.getTableReferenceCell(0,j,0).get(0).getName())){
                        foundMatch = true;
                        matchValue = "|" + trackerItem.getTableCell(0,j,1) + "\n";
                    }
                }
                if(foundMatch) {
                    tableMarkup += matchValue;
                }
                else {
                    tableMarkup += "|" + "\n";
                }
            }
            if(l < trackerItems.size() - 1) {
                tableMarkup += "\n";
            }
        }
        tableMarkup += "}]";

        subject.setCustomField(tableFieldId, tableMarkup);
    }
}