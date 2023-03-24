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

package com.intland.codebeamer.controller.rest.v2;

import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.manager.UserManager;
import com.intland.codebeamer.persistence.dto.TrackerItemDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(AbstractRestController.API_URI_V3)
public class ReviewHubChecklistController {

    private static String CHECKBOX_PREFIX = "checkbox";

    @Autowired
    TrackerItemManager trackerItemManager;

    @Autowired
    UserManager userManager;

    @PostMapping(value = "saveChecklist")
    @ResponseStatus(value = HttpStatus.OK)
    public void saveChecklist(
            @RequestHeader String referer,
            HttpServletResponse response,
            @RequestParam() Map<String,String> paramMap,
            @RequestParam() Integer configItemId,
            @RequestParam() Integer tableId
    ) {
        TrackerItemDto trackerItemDto = trackerItemManager.findById(configItemId);

        List<Integer> trueCheckboxIds = new ArrayList<>();

        paramMap.entrySet().forEach(entry -> {
            if(entry.getKey().contains(CHECKBOX_PREFIX)) {
                trueCheckboxIds.add(Integer.parseInt(entry.getKey().replace(CHECKBOX_PREFIX, "")));
            }
        });

        List<Map<Integer, String>> table = trackerItemDto.getTable(tableId);

        for(int i = 0; i < table.size(); i++) {
            if(trueCheckboxIds.contains(i)) {
                table.get(i).put(1,"true");
            } else {
                table.get(i).put(1,"false");
            }
        }

        trackerItemDto.setTable(tableId, table);

        try {
            trackerItemManager.getTrackerItemDao().update(trackerItemDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        try {
            response.sendRedirect(referer);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
