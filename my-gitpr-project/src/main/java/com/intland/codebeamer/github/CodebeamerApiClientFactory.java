package com.intland.codebeamer.github;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.Collections;
import java.util.TimeZone;

import org.springframework.web.util.UriComponentsBuilder;

import com.google.common.collect.Lists;
import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.ServerConfiguration;
import com.intland.swagger.client.auth.HttpBasicAuth;

import okhttp3.OkHttpClient;

public class CodebeamerApiClientFactory {
	
    private static final String API_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS";
    
    private static final String BASIC_AUTH_NAME = "BasicAuth";
    
    public ApiClient getApiClient(String basePath, String username, String password) {
        try {
        	
    		ApiClient apiClient = authenticateApiClient(setBaseUrl(new ApiClient(), basePath), username, password)
    				.setDateFormat(getApiDateFormat());

            OkHttpClient httpClient = apiClient.getHttpClient().newBuilder()
                    .readTimeout(Duration.ofSeconds(10L))
                    .build();

            apiClient.setHttpClient(httpClient);

            return apiClient;
        } catch (Exception e) {
            throw new IllegalStateException(e.getMessage(), e);
        }
    }

    private ApiClient authenticateApiClient(ApiClient apiClient, String userName, String password) {
        HttpBasicAuth basicAuth = (HttpBasicAuth) apiClient.getAuthentication(BASIC_AUTH_NAME);
        basicAuth.setUsername(userName);
        basicAuth.setPassword(password);
        
        return apiClient;
    }

	private ApiClient setBaseUrl(ApiClient apiClient, String baseUrl) {
		String basePath = UriComponentsBuilder.fromHttpUrl(baseUrl)
				.path("/api")
				.build()
				.toString();

		apiClient.setServers(Lists.newArrayList(new ServerConfiguration(basePath, "", Collections.emptyMap())));
		apiClient.setBasePath(basePath);
		
		return apiClient;
	}
	
    private DateFormat getApiDateFormat() {
        DateFormat dateFormat = new SimpleDateFormat(API_DATE_FORMAT);
        dateFormat.setTimeZone(TimeZone.getDefault());
        return dateFormat;
    }
	
}
