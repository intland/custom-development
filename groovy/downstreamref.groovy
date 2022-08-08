import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.persistence.dto.base.*;
import com.intland.codebeamer.persistence.dao.*;
import com.intland.codebeamer.manager.*;
import com.intland.codebeamer.controller.importexport.*;
import org.apache.commons.lang3.*;

if (!beforeEvent) {
    return;
}

def downstreamRefFieldId = 10;

logger.info("Start downstream reference collector script");

trackerItemDao = applicationContext.getBean(TrackerItemDao.class);

downstreamRefs = trackerItemDao.getDownstreamTrackerItems(user, subject,null,null,TimeFilter.TF_NOFILTER,null,null,null,null);

if(downstreamRefs == []) {
subject.setCustomField(downstreamRefFieldId,'No downstream references found');
}
else {
downstreamRefsWiki = "";
downstreamRefsList = downstreamRefs.getList();
downstreamRefsList.eachWithIndex { item, index ->
  var = downstreamRefsList[index].toString().split("-");
  itemId = var[1].take(4);
  downstreamRefsWiki += "[ISSUE:" + itemId + "] ";
}

subject.setCustomField(downstreamRefFieldId,downstreamRefsWiki);
}