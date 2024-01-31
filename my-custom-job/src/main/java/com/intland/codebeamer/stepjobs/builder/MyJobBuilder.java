package com.intland.codebeamer.stepjobs.builder;

import java.util.Collection;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.intland.codebeamer.background.job.AbstractBackgroundJobBuilder;
import com.intland.codebeamer.background.job.CreateBackgroundJobDto;
import com.intland.codebeamer.background.job.exception.AbstractBackgroundJobException;
import com.intland.codebeamer.background.job.step.BackgroundCreateStep;
import com.intland.codebeamer.background.job.step.BackgroundJobStepDataDto;
import com.intland.codebeamer.background.job.step.BackgroundJobStepEnum;
import com.intland.codebeamer.persistence.dto.background.BackgroundJobMetadataDto;
import com.intland.codebeamer.stepjobs.steps.first.MyFirstStep;
import com.intland.codebeamer.stepjobs.steps.second.MySecondStep;

public class MyJobBuilder extends AbstractBackgroundJobBuilder {

	public static final String MY_JOB_BUILDER_ID_META_KEY = "MY_JOB_BUILDER_ID";

	private static final Logger logger = LogManager.getLogger();

	private MyJobInitContext initContext;

	public MyJobBuilder(MyJobInitContext initContext) {
		this.initContext = initContext;
	}

	@Override
	public CreateBackgroundJobDto createJob() {
		return new CreateBackgroundJobDto(initContext.getJobType(), initContext.getUserId());
	}

	@Override
	public Collection<BackgroundJobMetadataDto> createJobMetadata() {
		return List.of(new BackgroundJobMetadataDto(MY_JOB_BUILDER_ID_META_KEY, "myValue"));
	}

	@Override
    protected List<? extends BackgroundCreateStep<? extends BackgroundJobStepEnum, ? extends BackgroundJobStepDataDto>> getSteps() throws AbstractBackgroundJobException {
    	logger.info("MyFirstStep and MySecondStep will be used");
    	return List.of(new MyFirstStep(getJobId()), new MySecondStep(getJobId()));
    }

	@Override
	public String errorMessageKey() {
		return "background.job.myjob.error.message";
	}

}
