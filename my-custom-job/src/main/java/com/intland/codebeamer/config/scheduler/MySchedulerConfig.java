/*
 * Copyright by Intland Software
 *
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Intland Software. ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with Intland.
 */

package com.intland.codebeamer.config.scheduler;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import com.intland.codebeamer.stepjobs.quartz.MyBackgroundJob;
import com.intland.codebeamer.utils.scheduler.ExtendedScheduler;
import com.intland.codebeamer.utils.scheduler.ScheduleStarter;
import com.intland.codebeamer.utils.scheduler.factory.ClusterAwareSchedulerPropertiesFactory;
import com.intland.codebeamer.utils.scheduler.factory.SchedulerFactory;
import com.my.codebeamer.jobs.MyJob;
import com.my.codebeamer.jobs.MyJobStarter;

@Configuration
@DependsOn({ "applicationContextHolder" })
public class MySchedulerConfig {

	@Bean
	public MyJobStarter myJobStarter(ScheduleStarter scheduleStarter) {
		return new MyJobStarter(scheduleStarter);
	}
	
	@Bean
	public ExtendedScheduler myScheduler(ApplicationContext applicationContext) {
		ClusterAwareSchedulerPropertiesFactory factory = new ClusterAwareSchedulerPropertiesFactory()
				.threadCount("CB_SCHEDULER_FACTORY_THREAD_COUNT_MY_GROUP", 10);
		
		return new SchedulerFactory(applicationContext, "MyJobScheduler", factory)
				.getScheduler(MyJob.class, "MY_GROUP");
	}
	
	@Bean
	public ExtendedScheduler myBackgroundScheduler(ApplicationContext applicationContext) {
		ClusterAwareSchedulerPropertiesFactory factory = new ClusterAwareSchedulerPropertiesFactory()
				.threadCount("CB_SCHEDULER_FACTORY_THREAD_COUNT_MY_BACKGROUND_GROUP", 10);
		
		return new SchedulerFactory(applicationContext, "MyBackgroundJobScheduler", factory)
				.getScheduler(MyBackgroundJob.class, "MY_BACKGROUND_GROUP");
	}
	
}
