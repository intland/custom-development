package com.intland.codebeamer.stepjobs.steps.second;

import java.time.Duration;
import java.time.Instant;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.background.job.exception.AbstractBackgroundJobException;
import com.intland.codebeamer.background.job.step.BackgroundStepContext;
import com.intland.codebeamer.stepjobs.builder.MyJobBackgroundJobStep;
import com.intland.codebeamer.stepjobs.exception.MyBackgroundJobException;
import com.intland.codebeamer.stepjobs.quartz.MyJobStepContext;
import com.intland.codebeamer.stepjobs.steps.MyAbstractStepProcessor;

@Component
public class MySecondStepProcessor extends MyAbstractStepProcessor<MySecondStepData> {

    private static final Logger logger = LogManager.getLogger();
    
	public MySecondStepProcessor() {
		super(MySecondStepData.class, MyJobBackgroundJobStep.SECOND_STEP);
	}

	@Override
	public BackgroundStepContext process(MySecondStepData mySecondStepData, MyJobStepContext myJobStepContext)
			throws AbstractBackgroundJobException {

		try {

			Instant now = Instant.now();
			Long executionTime = mySecondStepData.getData();

			do {
				myJobStepContext.add("Sleep - %s - %s".formatted(now, this.getClass().getName()));
				logger.info("Sleep - {} - {}", now, this.getClass().getName());

				update(mySecondStepData.getJobId(), myJobStepContext);
				
				TimeUnit.SECONDS.sleep(2);
			} while (Duration.between(now, Instant.now()).getSeconds() < executionTime);

			return myJobStepContext;

		} catch (Exception e) {
			throw new MyBackgroundJobException();
		}
	}

}
