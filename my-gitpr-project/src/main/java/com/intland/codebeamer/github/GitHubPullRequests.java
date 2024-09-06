/*
 * Copyright by Intland Software
 *
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Intland Software. ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with Intland.
 */

package com.intland.codebeamer.github;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.kohsuke.github.GHIssueState;
import org.kohsuke.github.GHPullRequest;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;

import com.intland.swagger.client.ApiClient;
import com.intland.swagger.client.ApiException;
import com.intland.swagger.client.api.TrackerApi;
import com.intland.swagger.client.api.TrackerItemApi;
import com.intland.swagger.client.model.AbstractFieldValue;
import com.intland.swagger.client.model.AbstractReference;
import com.intland.swagger.client.model.ChoiceFieldValue;
import com.intland.swagger.client.model.ChoiceOptionReference;
import com.intland.swagger.client.model.DateFieldValue;
import com.intland.swagger.client.model.FieldReference;
import com.intland.swagger.client.model.IntegerFieldValue;
import com.intland.swagger.client.model.OptionChoiceField;
import com.intland.swagger.client.model.TrackerItem;
import com.intland.swagger.client.model.TrackerItem.DescriptionFormatEnum;
import com.intland.swagger.client.model.TrackerItemReference;
import com.intland.swagger.client.model.UpdateTrackerItemFieldWithItemId;

public class GitHubPullRequests {
	
	private static final Logger logger = LogManager.getLogger(GitHubPullRequests.class);

    public static void main(String[] args) throws Exception {
        String token = "a";
        String repository = "intland/cbdev-git";

        int developmentProjectId = 254;
        int gitHubPrTrackerId = 50094724;
        int scmTrackerId = 24904610;

    	ApiClient apiClient = new CodebeamerApiClientFactory().getApiClient("https://codebeamer.com/cb", "a", "b");		
    	TrackerApi trackerApi = new TrackerApi(apiClient);
    	TrackerItemApi trackerItemApi = new TrackerItemApi(apiClient);
    	
		Map<String, Integer> gitHubPullRequestTrackerFields = getFieldCache(trackerApi, gitHubPrTrackerId);
    	Map<String, Integer> scmTrackerFields = getFieldCache(trackerApi, scmTrackerId);
    	        	
    	Integer statusFieldId = gitHubPullRequestTrackerFields.get("Status");
		OptionChoiceField statusField = Optional.ofNullable(trackerApi.getTrackerField(gitHubPrTrackerId, statusFieldId))
				.filter(OptionChoiceField.class::isInstance)
				.map(OptionChoiceField.class::cast)
				.orElseThrow();
    	
    	List<PullRequestReviewState> pullRequests = getPullRequests(GitHub.connectUsingOAuth(token)
        		.getRepository(repository));

		Map<User, Integer> scmUserCache = new GitHubUserResolver(apiClient, developmentProjectId, scmTrackerId,
				scmTrackerFields.get("Login name")).resolve(pullRequests);

		Map<Integer, Integer> gitHubPullRequestCache = new GitHubPullRequestResolver(apiClient, developmentProjectId, gitHubPrTrackerId,
				gitHubPullRequestTrackerFields.get("Pull Request ID")).resolve(pullRequests);
		
		for (PullRequestReviewState pullRequestReviewState : pullRequests) {
			logger.info("Processing {}", pullRequestReviewState.name());
			if (gitHubPullRequestCache.containsKey(pullRequestReviewState.number())) {
				updateTrackerItem(gitHubPullRequestTrackerFields, statusField, scmUserCache,
						gitHubPullRequestCache, trackerItemApi, pullRequestReviewState);
			} else {
				createTrackerItem(gitHubPrTrackerId, gitHubPullRequestTrackerFields, statusField, scmUserCache,
						trackerItemApi, pullRequestReviewState);
			}
		}
			
    }

	private static void updateTrackerItem(Map<String, Integer> gitHubPullRequestTrackerFields,
			OptionChoiceField statusField, Map<User, Integer> scmUserCache,
			Map<Integer, Integer> gitHubPullRequestCache, TrackerItemApi trackerItemApi,
			PullRequestReviewState pullRequestReviewState) throws ApiException {
		
		Integer trackerItemId = gitHubPullRequestCache.get(pullRequestReviewState.number());
		List<AbstractFieldValue> fields = buildFields(scmUserCache, gitHubPullRequestTrackerFields, pullRequestReviewState);

		AbstractFieldValue status = new ChoiceFieldValue()
				.values(List.of(new ChoiceOptionReference().id(getStatusId(statusField, pullRequestReviewState.state()))))
				.fieldId(statusField.getId());
		
		trackerItemApi.bulkUpdateTrackerItemFields(List.of(new UpdateTrackerItemFieldWithItemId()
				.itemId(trackerItemId)
				.fieldValues(new ArrayList<>(fields))
				.addFieldValuesItem(status)), true);
	}

	private static void createTrackerItem(int gitHubPrTrackerId, Map<String, Integer> gitHubPullRequestTrackerFields,
			OptionChoiceField statusField, Map<User, Integer> scmUserCache, TrackerItemApi trackerItemApi,
			PullRequestReviewState pullRequestReviewState) throws ApiException {

		TrackerItem trackerItem = createTrackerItem(statusField, scmUserCache, gitHubPullRequestTrackerFields, pullRequestReviewState);
		trackerItemApi.createTrackerItem(gitHubPrTrackerId, trackerItem, null, null, null);
	}

	private static TrackerItem createTrackerItem(OptionChoiceField statusField, Map<User, Integer> gitHubUserCache,
			Map<String, Integer> fields, PullRequestReviewState pullRequestReviewState) {
		return new TrackerItem()
				.name(pullRequestReviewState.name())
				.description(pullRequestReviewState.name())
				.descriptionFormat(DescriptionFormatEnum.HTML)
				.status(new ChoiceOptionReference().id(getStatusId(statusField, pullRequestReviewState.state())))
				.customFields(new ArrayList<AbstractFieldValue>(buildFields(gitHubUserCache, fields, pullRequestReviewState)))
				.addCustomFieldsItem(createIntegerFieldValue("Pull Request ID", fields, pullRequestReviewState));
	}

	private static Integer getStatusId(OptionChoiceField statusField, PullRequestState state) {
		return statusField.getOptions().stream()
				.filter(o -> o.getName().equalsIgnoreCase(state.getStatus()))
				.map(o -> o.getId())
				.findAny()
				.orElseThrow();
	}

	private static List<AbstractFieldValue> buildFields(Map<User, Integer> gitHubUserCache, Map<String, Integer> fields, PullRequestReviewState pullRequestReviewState) {
		return List.of(
				createTrackerItemReference("Tasks", fields, pullRequestReviewState.trackerIds()),
				createDateField("Updated At", fields, pullRequestReviewState.updatedAt()),
				createUserReference("Owner", fields, gitHubUserCache, List.of(pullRequestReviewState.owner())),
				createUserReference("Changes requested", fields, gitHubUserCache, pullRequestReviewState.changesRequestedBy()),
				createUserReference("Commented", fields, gitHubUserCache, pullRequestReviewState.commentedBy()),
				createUserReference("Approved", fields, gitHubUserCache, pullRequestReviewState.approvedBy()),
				createUserReference("Dismissed", fields, gitHubUserCache, pullRequestReviewState.dismissedBy()),
				createUserReference("Pending", fields, gitHubUserCache, pullRequestReviewState.pendingBy()));
		
	}
	
	private static AbstractFieldValue createDateField(String key, Map<String, Integer> fields, Date updatedAt) {
		return new DateFieldValue().value(updatedAt).fieldId(fields.get(key));
	}

	private static AbstractFieldValue createIntegerFieldValue(String key, Map<String, Integer> fields, PullRequestReviewState pullRequestReviewState) {
		return new IntegerFieldValue().value(pullRequestReviewState.number()).fieldId(fields.get(key));
	}

	private static AbstractFieldValue createTrackerItemReference(String field, Map<String, Integer> fields, List<TrackerItemId> trackerItems) {
		List<AbstractReference> values = trackerItems.stream()
				.map(TrackerItemId::id)
				.map(id -> new TrackerItemReference().id(id))
				.toList();
		
		return new ChoiceFieldValue()
				.values(values)
				.fieldId(fields.get(field));
	}
	
	private static AbstractFieldValue createUserReference(String field, Map<String, Integer> fields, Map<User, Integer> gitHubUserCache, List<User> users) {
		List<AbstractReference> values = users.stream()
				.map(gitHubUserCache::get)
				.filter(Objects::nonNull)
				.map(id -> new TrackerItemReference().id(id))
				.toList();
		
		return new ChoiceFieldValue()
				.values(values)
				.fieldId(fields.get(field));
	}

	private static Map<String, Integer> getFieldCache(TrackerApi trackerApi, int trackerId) throws ApiException {
		return trackerApi.getTrackerFields(trackerId).stream()
				.collect(Collectors.toMap(FieldReference::getName, FieldReference::getId));
	}

	private static List<PullRequestReviewState> getPullRequests(GHRepository repo) throws IOException {
		List<GHPullRequest> pullRequests = repo.getPullRequests(GHIssueState.OPEN);
		// List<GHPullRequest> pullRequests = List.of(repo.getPullRequest(12821));
		
		PullRequestReviewStateFactory factory = new PullRequestReviewStateFactory();
		return IntStream.range(0, pullRequests.size()).mapToObj(i -> {
			GHPullRequest pr = pullRequests.get(i);
			logger.info("{}/{} - {}", i + 1, pullRequests.size(), pr.getTitle());
			return factory.create(pr);
		}).toList();		
	}
        
}