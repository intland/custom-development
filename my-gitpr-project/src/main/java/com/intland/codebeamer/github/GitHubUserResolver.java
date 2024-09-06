package com.intland.codebeamer.github;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.commons.collections4.CollectionUtils;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.ApiException;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.model.TextFieldValue;
import com.intland.swagger.client.model.TrackerItem;
import com.intland.swagger.client.model.TrackerItemSearchRequest;
import com.intland.swagger.client.model.TrackerItemSearchResult;

public class GitHubUserResolver {

	private TrackerItemApi trackerItemApi;
	
	private int projectId;
	
	private int trackerId;

	private int fieldId;

	public GitHubUserResolver(ApiClient apiClient, int projectId, int trackerId, int fieldId) {
		this.projectId = projectId;
		this.trackerId = trackerId;
		this.fieldId = fieldId;
		this.trackerItemApi = new TrackerItemApi(apiClient);
	}

	public Map<User, Integer> resolve(List<PullRequestReviewState> prs) throws ApiException {
		if (CollectionUtils.isEmpty(prs)) {
			return Collections.emptyMap();
		}
		
		List<TrackerItem> trackerItems = getAllTrackerItems(prs);
		
		if (CollectionUtils.isEmpty(trackerItems)) {
			return Collections.emptyMap();
		}

		return trackerItems.stream()
				.collect(Collectors.toMap(i -> getUser(i), TrackerItem::getId));
	}

	private List<TrackerItem> getAllTrackerItems(List<PullRequestReviewState> prs) throws ApiException {
		String userIds = getUserIds(prs);
		
		TrackerItemSearchResult userQueryResult = fetchTrackerItems(userIds, 1);

		List<TrackerItem> trackerItems = new LinkedList<TrackerItem>();
		trackerItems.addAll(userQueryResult.getItems());
		
		int pages = divideAndRoundUp(userQueryResult.getTotal(), userQueryResult.getPageSize());
		for (int i = 2; i <= pages; i++) {
			userQueryResult = fetchTrackerItems(userIds, i);
			trackerItems.addAll(userQueryResult.getItems());
		}

		return trackerItems;
	}

	private int divideAndRoundUp(int a, int b) {
        if (b == 0) {
            throw new IllegalArgumentException("Cannot divide by zero.");
        }

        double result = (double) a / b;
        return (int) Math.ceil(result);
    }
	
	private TrackerItemSearchResult fetchTrackerItems(String userIds, int page) throws ApiException {
		return trackerItemApi.findTrackerItemsByCbQL(new TrackerItemSearchRequest()
				.queryString(getQueryString(userIds))
				.pageSize(50)
				.page(page));
	}

	private User getUser(TrackerItem i) {
		return i.getCustomFields().stream()
				.filter(f -> f.getFieldId().equals(fieldId))
				.filter(TextFieldValue.class::isInstance)
				.map(TextFieldValue.class::cast)
				.map(TextFieldValue::getValue)
				.map(User::new)
				.findAny()
				.orElseThrow();
	}

	private String getUserIds(List<PullRequestReviewState> prs) {
		List<User> reviewers = prs.stream()
			.map(PullRequestReviewState::states)
			.map(Map::keySet)
			.flatMap(Set::stream).toList();
		
		List<User> owners = prs.stream()
				.map(PullRequestReviewState::owner)
				.toList();
		
		List<User> users = new ArrayList<User>();
		users.addAll(reviewers);
		users.addAll(owners);
		
		return users.stream()
			.map(User::id)
			.distinct()
			.map(s -> "'%s'".formatted(s)).collect(Collectors.joining(","));
	}

	private String getQueryString(String userIds) {
		return "project.id IN (%s) AND tracker.id IN (%s) AND '%s.customField[%s]' IN (%s)"
				.formatted(this.projectId, this.trackerId, this.trackerId, this.fieldId - 10000, userIds);
	}

}
