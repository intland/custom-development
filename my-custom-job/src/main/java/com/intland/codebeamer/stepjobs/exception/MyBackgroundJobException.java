package com.intland.codebeamer.stepjobs.exception;

import com.intland.codebeamer.background.job.exception.AbstractBackgroundJobException;

public class MyBackgroundJobException extends AbstractBackgroundJobException {

	private static final long serialVersionUID = 1L;

	@Override
	protected String getMessageKey() {
		return "background.job.myjob.error.message";
	}

	@Override
	protected Object[] getMessageParameters() {
		return new Object[0];
	}
	
}