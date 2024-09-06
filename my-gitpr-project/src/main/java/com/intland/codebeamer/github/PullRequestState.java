package com.intland.codebeamer.github;

public enum PullRequestState {

	OPEN("Open"), 
	CLOSED("Closed"), 
	DRAFT("Draft");

	private String status;

	PullRequestState(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}

}
