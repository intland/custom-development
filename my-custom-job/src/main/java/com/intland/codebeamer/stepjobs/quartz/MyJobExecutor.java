package com.intland.codebeamer.stepjobs.quartz;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.background.job.CreateBackgroundJobDto;
import com.intland.codebeamer.background.job.scheduler.BackgroundJobContext;
import com.intland.codebeamer.background.job.scheduler.BackgroundJobExecutor;
import com.intland.codebeamer.background.job.scheduler.BackgroundSchedulerJob;
import com.intland.codebeamer.background.job.step.BackgroundJobStepEnum;
import com.intland.codebeamer.background.job.step.BackgroundStepContext;
import com.intland.codebeamer.persistence.dto.background.BackgroundJobStepDto;
import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobStep;
import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobType;

@Component
public class MyJobExecutor extends BackgroundJobExecutor<MyJobBackgroundJobType> {

    private static final Logger logger = LogManager.getLogger();
    
	@Override
	public BackgroundJobContext getJobContext(Integer jobId, CreateBackgroundJobDto backgroundJob) {
		return new MyJobContext(jobId, backgroundJob.getUserId());
	}

	@Override
	protected Logger getLogger() {
		return logger;
	}

	@Override
	public Class<? extends BackgroundSchedulerJob> getSchedulerJob() {
		return MyBackgroundJob.class;
	}

	@Override
	protected Class<? extends BackgroundStepContext> getStepContextClass() {
		return MyJobStepContext.class;
	}

	@Override
	protected BackgroundJobStepEnum getStepProcessorId(BackgroundJobStepDto jobStep) {
		return MyJobBackgroundJobStep.valueOf(jobStep.getStepProcessorId());
	}

	@Override
	public MyJobBackgroundJobType getType() {
		return MyJobBackgroundJobType.getInstance();
	}

}
