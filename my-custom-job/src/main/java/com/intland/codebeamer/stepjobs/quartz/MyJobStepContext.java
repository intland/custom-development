package com.intland.codebeamer.stepjobs.quartz;

import java.util.LinkedList;

import com.intland.codebeamer.background.job.step.BackgroundStepContext;

public class MyJobStepContext extends BackgroundStepContext {

	private static final long serialVersionUID = 1L;

	private LinkedList<String> logs = new LinkedList<>();

	public void add(String logEntry) {
		this.logs.add(logEntry);
	}
	
	public LinkedList<String> getLogs() {
		return logs;
	}

	public void setLogs(LinkedList<String> logs) {
		this.logs = logs;
	}

}
