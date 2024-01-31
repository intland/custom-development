package com.intland.codebeamer.stepjobs.steps.first;

import java.util.concurrent.TimeUnit;

import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobStep;
import com.intland.codebeamer.stepjobs.steps.MyAbstractStep;

public class MyFirstStep extends MyAbstractStep<MyFirstStepData> {

	public MyFirstStep(Integer jobId) {
		super(MyFirstStepData.class, jobId, MyJobBackgroundJobStep.FIRST_STEP);
	}

	@Override
	protected MyFirstStepData getStepData(Integer jobId) {
		return new MyFirstStepData(jobId, TimeUnit.SECONDS.toSeconds(20));
	}

}
