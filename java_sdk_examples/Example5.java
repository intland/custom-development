package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.Configuration;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import com.intland.swagger.client.model.AbstractReference;
import com.intland.swagger.client.model.ReferenceSearchResult;
import com.intland.swagger.client.model.TrackerItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Example5 {
    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) defaultClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");

        TrackerItemApi trackerItemApi = new TrackerItemApi(defaultClient);

        try {
            TrackerItem trackerItem = trackerItemApi.getTrackerItem(1731, null, null);
            ReferenceSearchResult statusOptions = trackerItemApi.getChoiceOptions(trackerItem.getId(),7, 1, 25);
            AbstractReference neededStatus = statusOptions.getReferences().get(3);
            trackerItem.setStatus(neededStatus);
            trackerItemApi.updateTrackerItem(trackerItem.getId(), trackerItem, null ,null);
        }
        catch (Exception e) {
            logger.info(e.getMessage());
        }
    }
}
