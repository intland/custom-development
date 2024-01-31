package com.intland.codebeamer.stepjobs.steps;

import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.intland.codebeamer.background.job.exception.AbstractBackgroundJobException;
import com.intland.codebeamer.background.job.step.BackgroundJobStepDataDto;
import com.intland.codebeamer.background.job.step.BackgroundStepProcessor;
import com.intland.codebeamer.persistence.dao.BackgroundJobDao;
import com.intland.codebeamer.persistence.dto.background.BackgroundJobStepDto;
import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobStep;
import com.intland.codebeamer.stepjobs.exception.MyBackgroundJobException;
import com.intland.codebeamer.stepjobs.quartz.MyJobStepContext;
import com.intland.codebeamer.transaction.TransactionSupport;

public abstract class MyAbstractStepProcessor<T extends BackgroundJobStepDataDto>
		implements BackgroundStepProcessor<MyJobBackgroundJobStep, T, MyJobStepContext> {

	@Autowired
	private ObjectMapper jsonMapper;

	@Autowired
	private BackgroundJobDao backgroundJobDao;

	@Autowired
	private TransactionSupport transactionSupport;

	private Class<T> dataClass;

	private MyJobBackgroundJobStep step;

	public MyAbstractStepProcessor(Class<T> dataClass, MyJobBackgroundJobStep step) {
		super();
		this.dataClass = dataClass;
		this.step = step;
	}

	@Override
	public MyJobBackgroundJobStep getStep() {
		return this.step;
	}

	@Override
	public boolean isExecuteInTransaction() {
		return true;
	}

	public void update(Integer jobId, MyJobStepContext myJobStepContext) {
		transactionSupport.doInRequiresNewTransaction(() -> backgroundJobDao.updateStepContext(jobId, jsonMapper.writeValueAsString(myJobStepContext)));
	}
	
	@Override
	public T parseStepData(BackgroundJobStepDto data) throws AbstractBackgroundJobException {
		try {
			return jsonMapper.readValue(data.getStepData(), this.dataClass);
		} catch (JsonProcessingException e) {
			throw new MyBackgroundJobException();
		}
	}

}
