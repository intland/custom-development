package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.Configuration;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import com.intland.swagger.client.model.TrackerItemSearchResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Example6 {
    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) defaultClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");

        TrackerItemApi trackeritemApi = new TrackerItemApi(defaultClient);

        try {
            String cbql = "project.id IN (3) AND tracker.id IN (8361) AND workItemStatus IN ('InProgress')";
            TrackerItemSearchResult result = trackeritemApi.findTrackerItems(cbql, null, 1, 25);
            logger.info(result.toString());
        }
        catch (Exception e) {
            logger.info(e.getMessage());
        }
    }
}
