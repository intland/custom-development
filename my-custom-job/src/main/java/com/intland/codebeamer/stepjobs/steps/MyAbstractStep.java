package com.intland.codebeamer.stepjobs.steps;

import java.util.Optional;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.intland.codebeamer.background.job.CreateBackgroundStepDto;
import com.intland.codebeamer.background.job.step.BackgroundCreateStep;
import com.intland.codebeamer.background.job.step.BackgroundJobStepDataDto;
import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobStep;

public abstract class MyAbstractStep<T extends BackgroundJobStepDataDto> implements BackgroundCreateStep<MyJobBackgroundJobStep, T> {

	private static final ObjectMapper jsonMapper = new ObjectMapper();

	private Class<T> dataClass;
	
	private MyJobBackgroundJobStep step;

	private boolean finished = false;

	private Integer jobId;
	
	public MyAbstractStep(Class<T> dataClass, Integer jobId, MyJobBackgroundJobStep step) {
		super();
		this.dataClass = dataClass;
		this.jobId = jobId;
		this.step = step;
	}

	@Override
	public MyJobBackgroundJobStep getStep() {
		return step;
	}

	@Override
	public Optional<CreateBackgroundStepDto> getNextStep() {
		this.finished = true;
		return Optional.of(createBackgroundStep());
	}
	
	protected CreateBackgroundStepDto createBackgroundStep() {
		try {
			
			CreateBackgroundStepDto result = new CreateBackgroundStepDto();
			result.setStepProcessorId(getStep());
			result.setStepName(dataClass.getName());
			result.setStepData(jsonMapper.writeValueAsString(getStepData(this.jobId)));
						
			return result;
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public boolean isFinished() {
		return this.finished;
	}
	
	protected abstract T getStepData(Integer jobId);

}
