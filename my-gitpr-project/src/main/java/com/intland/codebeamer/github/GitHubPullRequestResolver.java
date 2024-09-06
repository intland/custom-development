package com.intland.codebeamer.github;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.collections4.CollectionUtils;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.ApiException;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.model.IntegerFieldValue;
import com.intland.swagger.client.model.TrackerItem;
import com.intland.swagger.client.model.TrackerItemSearchRequest;
import com.intland.swagger.client.model.TrackerItemSearchResult;

public class GitHubPullRequestResolver {

	private TrackerItemApi trackerItemApi;
	
	private int projectId;
	
	private int trackerId;

	private int fieldId;

	public GitHubPullRequestResolver(ApiClient apiClient, int projectId, int trackerId, int fieldId) {
		this.projectId = projectId;
		this.trackerId = trackerId;
		this.fieldId = fieldId;
		this.trackerItemApi = new TrackerItemApi(apiClient);
	}

	public Map<Integer, Integer> resolve(List<PullRequestReviewState> prs) throws ApiException {
		if (CollectionUtils.isEmpty(prs)) {
			return Collections.emptyMap();
		}
		
		List<TrackerItem> trackerItems = getAllTrackerItems(prs);
		
		if (CollectionUtils.isEmpty(trackerItems)) {
			return Collections.emptyMap();
		}

		return trackerItems.stream()
				.collect(Collectors.toMap(i -> getPullRequestId(i), TrackerItem::getId));
	}

	private List<TrackerItem> getAllTrackerItems(List<PullRequestReviewState> prs) throws ApiException {
		String pullRequestIds = getPullRequestIds(prs);
		
		TrackerItemSearchResult userQueryResult = fetchTrackerItems(pullRequestIds, 1);

		List<TrackerItem> trackerItems = new LinkedList<TrackerItem>();
		trackerItems.addAll(userQueryResult.getItems());
		
		int pages = divideAndRoundUp(userQueryResult.getTotal(), userQueryResult.getPageSize());
		for (int i = 2; i <= pages; i++) {
			userQueryResult = fetchTrackerItems(pullRequestIds, i);
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

	private Integer getPullRequestId(TrackerItem i) {
		return i.getCustomFields().stream()
				.filter(f -> f.getFieldId().equals(fieldId))
				.filter(IntegerFieldValue.class::isInstance)
				.map(IntegerFieldValue.class::cast)
				.map(IntegerFieldValue::getValue)
				.findAny()
				.orElseThrow();
	}

	private String getPullRequestIds(List<PullRequestReviewState> prs) {
		return prs.stream()
			.map(PullRequestReviewState::number)
			.distinct()
			.map(s -> "%s".formatted(s)).collect(Collectors.joining(","));
	}

	private String getQueryString(String pullRequestIds) {
		return "project.id IN (%s) AND tracker.id IN (%s) AND '%s.customField[%s]' IN (%s)"
				.formatted(this.projectId, this.trackerId, this.trackerId, this.fieldId - 10000, pullRequestIds);
	}

}
