package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.Configuration;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import com.intland.swagger.client.model.AbstractReference;
import com.intland.swagger.client.model.ReferenceSearchResult;
import com.intland.swagger.client.model.TrackerItem;
import com.intland.swagger.client.model.TrackerItemField;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Example4 {
    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        ApiClient apiClient = Configuration.getDefaultApiClient();
        apiClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) apiClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");

        TrackerItemApi trackerItemApi = new TrackerItemApi(apiClient);

        try {
        TrackerItem trackerItem = trackerItemApi.getTrackerItem(1730,null, null);

        //Just for checking the field id
        //TrackerItemField trackerItemField = trackerItemApi.getTrackerItemFields(trackerItem.getId());
        ReferenceSearchResult priorityOptions = trackerItemApi.getChoiceOptions(trackerItem.getId(),2, 1, 25);
        AbstractReference neededPriority = priorityOptions.getReferences().get(1);
        trackerItem.setPriority(neededPriority);
        trackerItem.setEstimatedMillis(43200000L);
        trackerItemApi.updateTrackerItem(trackerItem.getId(),trackerItem,null,null);
        }
        catch (Exception e) {
            logger.info(e.getMessage());
        }
    }
}
