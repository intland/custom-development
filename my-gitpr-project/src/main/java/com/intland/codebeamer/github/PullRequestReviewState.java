package com.intland.codebeamer.github;

import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.kohsuke.github.GHPullRequestReviewState;

record PullRequestReviewState(int number, PullRequestState state, String name, User owner, Date createdAt, Date updatedAt,
		List<TrackerItemId> trackerIds, Map<User, GHPullRequestReviewState> states) {

	public List<User> changesRequestedBy() {
		return filteredByState(GHPullRequestReviewState.CHANGES_REQUESTED);
	}

	public List<User> commentedBy() {
		return filteredByState(GHPullRequestReviewState.COMMENTED);
	}

	public List<User> approvedBy() {
		return filteredByState(GHPullRequestReviewState.APPROVED);
	}

	public List<User> dismissedBy() {
		return filteredByState(GHPullRequestReviewState.DISMISSED);
	}

	public List<User> pendingBy() {
		return filteredByState(GHPullRequestReviewState.PENDING);
	}
	
	private List<User> filteredByState(GHPullRequestReviewState state) {
		return states.entrySet().stream()
				.filter(e -> e.getValue().equals(state))
				.map(e -> e.getKey())
				.distinct()
				.sorted(Comparator.comparing(User::id))
				.toList();
	}
}