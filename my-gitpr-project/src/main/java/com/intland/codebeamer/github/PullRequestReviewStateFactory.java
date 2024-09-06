package com.intland.codebeamer.github;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.kohsuke.github.GHIssueState;
import org.kohsuke.github.GHPullRequest;
import org.kohsuke.github.GHPullRequestReview;
import org.kohsuke.github.GHPullRequestReviewState;

public class PullRequestReviewStateFactory {
	
	PullRequestReviewState create(GHPullRequest pr) {
		try {
			
	    	Set<String> commitIds = getCommitIds(pr);
	    	Set<User> reviewers = getReviewers(pr);
	    	            	
	    	Map<User, GHPullRequestReviewState> lastStateForUser = new HashMap<>();
	
	    	List<GHPullRequestReview> reviews = pr.listReviews().toList().stream()
	    			.filter(r -> commitIds.contains(r.getCommitId()))
	    			.toList();
	    			
	    	for (GHPullRequestReview review : reviews) {
	    		lastStateForUser.computeIfAbsent(new User(review.getUser().getLogin()), u -> review.getState());
			}
	    	    	
	    	for (User reviewer : reviewers) {
	    		lastStateForUser.computeIfAbsent(reviewer, r -> GHPullRequestReviewState.PENDING);
			}
	    	
	    	lastStateForUser.remove(new User(pr.getUser().getLogin()));
	    				
	    	return new PullRequestReviewState(
	    			pr.getNumber(),
	    			getPullRequestState(pr),
	    			pr.getTitle(),
	    			new User(pr.getUser().getLogin()),
	    			pr.getCreatedAt(),
	    			pr.getUpdatedAt(),
	    			getTrackerIds(pr.getTitle()), 
	    			lastStateForUser);
		} catch (Exception e) {
			throw new IllegalStateException(e.getMessage(), e);
		}
	}

	private PullRequestState getPullRequestState(GHPullRequest pr) throws IOException {
		if (pr.isDraft()) {
			return PullRequestState.DRAFT;
		}
		
		if (pr.getState() == GHIssueState.OPEN) {
			return PullRequestState.OPEN;
		}
		
		if (pr.getState() == GHIssueState.CLOSED) {
			return PullRequestState.CLOSED;
		}
		
		throw new IllegalStateException("State cannot be resolved");
	}

	private List<TrackerItemId> getTrackerIds(String text) {
		Matcher matcher = Pattern.compile("#(\\d+)").matcher(text);

		return Stream.iterate(0, i -> matcher.find(), i -> i + 1)
	        .map(i -> matcher.group(1))
	        .map(Integer::parseInt)
	        .map(TrackerItemId::new)
	        .toList();
	}
	
	private Set<User> getReviewers(GHPullRequest pr) throws IOException {
		return pr.getRequestedReviewers().stream()
    			.map(u -> u.getLogin())
    			.map(User::new)
    			.collect(Collectors.toSet());
	}

	private Set<String> getCommitIds(GHPullRequest pr) throws IOException {
		return pr.listCommits()
    			.toList().stream()
    			.map(c -> c.getSha())
    			.collect(Collectors.toSet());
	}
	
}
