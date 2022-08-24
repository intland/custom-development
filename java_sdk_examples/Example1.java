package com.example.swagger.client;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.api.UserApi;
import com.intland.swagger.client.auth.HttpBasicAuth;
import com.intland.swagger.client.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.TimeZone;

public class Example1 {

    private static Logger logger = LoggerFactory.getLogger(Main.class);

    public static final String API_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS";

    public static void main(String[] args) {
        ApiClient defaultClient = new ApiClient();
        defaultClient.setDateFormat(getApiDateFormat());
       // defaultClient.setOffsetDateTimeFormat(getApiDateTimeFormatter());
        defaultClient.setBasePath("http://localhost:8080/cb/api");

        HttpBasicAuth basicAuth = (HttpBasicAuth) defaultClient.getAuthentication("BasicAuth");
        basicAuth.setUsername("bond");
        basicAuth.setPassword("007");

        TrackerItemApi trackerItemApi = new TrackerItemApi(defaultClient);
        UserApi userApi = new UserApi(defaultClient);
        TrackerItem trackerItem = new TrackerItem();
        trackerItem.setName("My first tracker item");
        trackerItem.setDescription("It is easy");
        trackerItem.setStoryPoints(42);
        try {
            TrackerItem trackerItemUpdated = trackerItemApi.createTrackerItem(8361, trackerItem, null, null ,null);
            ReferenceSearchResult options = trackerItemApi.getChoiceOptions(trackerItemUpdated.getId(),7, 1, 25);
            AbstractReference neededStatus = options.getReferences().get(3);
            trackerItemUpdated.setStatus(neededStatus);
            UserReferenceSearchResult userSearchResult = userApi.getUsers(1,25,null,"bond");
            List<? extends AbstractReference> neededUser = userSearchResult.getUsers();
            trackerItemUpdated.setAssignedTo((List)neededUser);
            trackerItemApi.updateTrackerItem(trackerItemUpdated.getId(),trackerItemUpdated,null,null);

            logger.info(options.toString());
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            logger.error((e.getStackTrace().toString()));
        }
    }
    public static DateFormat getApiDateFormat() {
        DateFormat dateFormat = new SimpleDateFormat(API_DATE_FORMAT);
        dateFormat.setTimeZone(TimeZone.getDefault());
        return dateFormat;
    }
}
