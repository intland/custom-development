import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.persistence.dto.base.*;
import com.intland.codebeamer.persistence.dao.*;
import com.intland.codebeamer.manager.*;
import com.intland.codebeamer.controller.importexport.*;
import org.apache.commons.lang3.*;

if (!beforeEvent) {
    return;
}

def paramterTrackerId = 12113;
def searchItemIds = "";


logger.info("Start zf_paramater_table");

trackerDao = applicationContext.getBean(TrackerDao.class);
trackerItemManager = applicationContext.getBean(TrackerItemManager.class);
artifactManager = applicationContext.getBean(ArtifactManager.class);
cbQLManager = applicationContext.getBean(CbQLManager.class);


// get the description 
description = subject.getDescription();
def matcher = description =~ /(\[ITEM:)([\d]*)(\])/;
if(matcher.size()>0) {
        def str = [];
        for(int i = 0; i < matcher.size(); i++) {
                str.add(matcher[i][2]);
        }
        //subject.setCustomField(3, str.join(','));
        searchItemIds = str.join(',');
}

/// define a cbQL to query the items 
def cbQL = "tracker.id IN (" + paramterTrackerId + ") AND item.id IN (" + searchItemIds + ")";

request=event.getRequest();

if(request == null) {
    request = new org.springframework.mock.web.MockHttpServletRequest();
}

// Run query lookup 
trackerItemQueryResult = cbQLManager.runQuery(request, cbQL, new CbQLManager.PagingParams(500, false));
trackerItems = trackerItemQueryResult.getTrackerItems().getList();

variants = subject.getChoiceList(3);

variantNames= [];

variants.eachWithIndex { item, index ->
  vars = variants[index].toString().split("-");
  variantNames.add(vars[2].replaceAll("\\s",""));
}

subject.setChoiceList(4, trackerItems);
def tableMarkup = "[{Table" + "\n\n" + "|" + "\n";

variants.eachWithIndex { item, index ->
  var = variants[index].toString().split("-");
  varId = var[1].take(4);
  tableMarkup += "| [ISSUE:" + varId + "]" + "\n";
}

tableMarkup += "\n\n";

trackerItems.eachWithIndex { trackerItem, index ->
        tableMarkup += "| [ISSUE: " + trackerItem.getId() + "]" + "\n";
        for (i = 0; i < variantNames.size(); i++) {
                foundMatch = false;
                matchValue = "";
                for(j = 0; j < trackerItem.getTableRowCount(0); j++) {
                        if(variantNames[i].equals(trackerItem.getTableReferenceCell(0,j,0)[0].getName())){
                                foundMatch = true;
                                matchValue = "|" + trackerItem.getTableCell(0,j,1) + "\n";
                        }
                }
                if(foundMatch) {
                        tableMarkup += matchValue;
                }
                else {
                        tableMarkup += "|" + "\n"
                }
        }
        if(index < trackerItems.size() - 1) {
                tableMarkup += "\n";
        }
}
tableMarkup += "}]";
subject.setCustomField(1,tableMarkup);