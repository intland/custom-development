/************************************************************************************************
* Projectname:      Intelligent Test Set
* Application:      codebeamer
* Purpose:          Automatically identifies and add test cases or remove test cases to test set
* Type:             Custom codeBeamer script action
* Filename:         intelligent_test_set.groovy
*
* Precondition:		Additional custom Wiki/Url field which is used to address a report.
*
* Calling:          Action is called within cB workflow of target tracker issue
* Environment:      Intland codeBeamer 21.09 or higher
* User:             Action runs within current user session - user context
* Run Env:          codeBeamer docker container
* Runtime loc:      codebeamer:/home/appuser/codebeamer/tomcat/webapps/ROOT/config/scripts/workflow
* Fileowner:        appuser (runuser of codeBeamer application)
* Deployment:       File is hot deployed from git to environemts using corresponding branches
*
* Created at:       24.01.2021
* Created by:       Jan Henßler Intland GmbH
************************************************************************************************/

import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.persistence.dto.base.*;
import com.intland.codebeamer.persistence.dao.*;
import com.intland.codebeamer.manager.*;
import com.intland.codebeamer.controller.importexport.*;
import org.apache.commons.lang3.*;

if (!beforeEvent) {
    return;  
}

logger.info("Start intelligent_test_set");

trackerDao = applicationContext.getBean(TrackerDao.class);
trackerItemManager = applicationContext.getBean(TrackerItemManager.class);
cbQLManager = applicationContext.getBean(CbQLManager.class);

// get the report Url
reportString = subject.getCustomField(8);

trackerItems = null;

cbQL = "";

def matcher = reportString =~ /(\[QUERY:)([\d]*)(\])/   
if(matcher.size()>0) {
 reportDto = cbQLManager.findById(user, matcher[0][2] as Integer);
 cbQL = reportDto.getQuery();
}

if(request == null) {
    request = new org.springframework.mock.web.MockHttpServletRequest()
}

// Run query lookup 
trackerItemQueryResult = cbQLManager.runQuery(request, cbQL, new CbQLManager.PagingParams(100, false));
trackerItemsPage = trackerItemQueryResult.getTrackerItems();
trackerItems = trackerItemsPage.getList();

subject.setChoiceList(2, trackerItems);

subject.setTableColumn(0,0, []);

index = 0;
for(testCase in trackerItems) {
	subject.setTableReferenceCell(0, index ,0, new TrackerItemReferenceWrapperDto(testCase));
	index++;
}