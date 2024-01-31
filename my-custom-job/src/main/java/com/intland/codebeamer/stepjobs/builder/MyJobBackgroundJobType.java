package com.intland.codebeamer.stepjobs.builder;

import com.intland.codebeamer.persistence.dto.background.type.BackgroundJobType;

public class MyJobBackgroundJobType implements BackgroundJobType {

	private MyJobBackgroundJobType() {
		super();
	}

	public static MyJobBackgroundJobType getInstance() {
		return new MyJobBackgroundJobType();
	}
	
	@Override
	public String getName() {
		return "MY_BACKGROUND_JOB";
	}

}
