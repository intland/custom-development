package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.Configuration;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import com.intland.swagger.client.model.TrackerItemSearchResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Example7 {
    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        ApiClient apiClient = Configuration.getDefaultApiClient();
        apiClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) apiClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");

        TrackerItemApi trackeritemApi = new TrackerItemApi(apiClient);

        try {
            String cbql = "project.id IN (3) AND tracker.id IN (3857) AND summary LIKE '%Radio%'";
            TrackerItemSearchResult result = trackeritemApi.findTrackerItems(cbql, null, 1, 25);
            logger.info(result.toString());
        }
        catch (Exception e) {
            logger.info(e.getMessage());
        }
    }
}
