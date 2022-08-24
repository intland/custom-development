package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.Configuration;
import com.intland.swagger.client.api.TrackerItemsCommentApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

public class Example2 {
    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) defaultClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");
        TrackerItemsCommentApi commentApi = new TrackerItemsCommentApi(defaultClient);
        File logo = new File("/Users/patrikpasztor/Downloads/cb_logo.png");

        try {
            commentApi.commentOnTrackerItem(1730,"My first comment",logo, "PlainText");
        }
        catch (Exception e) {
            logger.info(e.getMessage());
        }
    }
}
