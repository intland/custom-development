package com.intland.codebeamer.stepjobs.quartz;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;

import com.intland.codebeamer.background.job.scheduler.BackgroundSchedulerJob;

public class MyBackgroundJob extends BackgroundSchedulerJob {

	private static final Logger logger = LogManager.getLogger();

	private MyJobContext jobContext;

	private final MyJobExecutor jobExecutor;

	@Autowired
	public MyBackgroundJob(MyJobExecutor jobExecutor) {
		this.jobExecutor = jobExecutor;
	}

	@Override
	public void doExecute(final JobExecutionContext context) throws JobExecutionException {
		jobExecutor.executeJob(jobContext);
	}

	@Override
	public Logger getLogger() {
		return logger;
	}

	public void setJobContext(final MyJobContext jobContext) {
		this.jobContext = jobContext;
	}

}
