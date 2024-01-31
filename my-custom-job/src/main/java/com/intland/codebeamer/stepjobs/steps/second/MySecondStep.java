package com.intland.codebeamer.stepjobs.steps.second;

import java.util.concurrent.TimeUnit;

import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobStep;
import com.intland.codebeamer.stepjobs.steps.MyAbstractStep;

public class MySecondStep extends MyAbstractStep<MySecondStepData> {

	public MySecondStep(Integer jobId) {
		super(MySecondStepData.class, jobId, MyJobBackgroundJobStep.SECOND_STEP);
	}

	@Override
	protected MySecondStepData getStepData(Integer jobId) {
		return new MySecondStepData(jobId, TimeUnit.SECONDS.toSeconds(20));
	}

}
