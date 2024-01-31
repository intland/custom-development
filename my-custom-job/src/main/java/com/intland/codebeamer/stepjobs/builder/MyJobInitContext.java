package com.intland.codebeamer.stepjobs.builder;

import java.util.UUID;

import org.quartz.JobKey;

import com.intland.codebeamer.background.BackgroundInitSchedulerJobContext;

public class MyJobInitContext extends BackgroundInitSchedulerJobContext<MyJobBackgroundJobType> {

    private static final long serialVersionUID = 1L;

	public MyJobInitContext(Integer userId) {
		super(userId);
	}

	@Override
    public JobKey createJobKey() {
        return new JobKey(String.format("%s-%d-%s", MyJobInitContext.class.getName(), getUserId(), UUID.randomUUID().toString()));
    }

    @Override
    public MyJobBackgroundJobType getJobType() {
        return MyJobBackgroundJobType.getInstance();
    }

    @Override
    public String initMessageKey() {
        return "background.job.pure.create.message";
    }

    @Override
    public String errorMessageKey() {
        return "background.job.pure.error.message";
    }

}
