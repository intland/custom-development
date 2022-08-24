package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.Configuration;
import com.intland.swagger.client.api.TrackerItemsAttachmentApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;


public class Example3 {
    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) defaultClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");
        TrackerItemsAttachmentApi attachmentApi = new TrackerItemsAttachmentApi(defaultClient);
        File cbLogo = new File("/Users/patrikpasztor/Downloads/cb_logo.png");
        File ptcLogo = new File("/Users/patrikpasztor/Downloads/ptc_logo.png");

        try {
            attachmentApi.uploadTrackerItemAttachment(1730, cbLogo);
            attachmentApi.uploadTrackerItemAttachment(1730, ptcLogo);
        }
        catch (Exception e) {
            logger.info(e.getMessage());
        }
    }
}
