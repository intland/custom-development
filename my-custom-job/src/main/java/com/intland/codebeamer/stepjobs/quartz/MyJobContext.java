package com.intland.codebeamer.stepjobs.quartz;

import com.intland.codebeamer.background.job.scheduler.BackgroundJobContext;

public class MyJobContext extends BackgroundJobContext {

	private static final long serialVersionUID = 1L;
	
	public MyJobContext(Integer jobId, Integer userId) {
		super(jobId, userId);
	}
	
	@Override
	public String getErrorMessageKey() {
		return "background.job.myjob.error.message";
	}

	@Override
	public String getFinishMessageKey() {
		return "background.job.myjob.finish.message";
	}

	@Override
	public String getStartMessageKey() {
		return "background.job.myjob.start.message";
	}

}
