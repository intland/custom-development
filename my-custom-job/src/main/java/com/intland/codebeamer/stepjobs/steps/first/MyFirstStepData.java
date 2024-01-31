package com.intland.codebeamer.stepjobs.steps.first;

import java.util.Objects;

import com.intland.codebeamer.background.job.step.BackgroundJobStepDataDto;

public class MyFirstStepData implements BackgroundJobStepDataDto {

	private static final long serialVersionUID = 1L;

	private Long executionTime;

	private Integer jobId;

	public MyFirstStepData() {
		super();
	}

	public MyFirstStepData(Integer jobId, Long executionTime) {
		super();
		this.jobId = jobId;
		this.executionTime = executionTime;
	}

	public Integer getJobId() {
		return jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}

	public Long getData() {
		return executionTime;
	}

	public void setData(Long executionTime) {
		this.executionTime = executionTime;
	}

	@Override
	public int hashCode() {
		return Objects.hash(jobId, executionTime);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MyFirstStepData other = (MyFirstStepData) obj;
		return Objects.equals(jobId, other.jobId) && Objects.equals(executionTime, other.executionTime);
	}

}
