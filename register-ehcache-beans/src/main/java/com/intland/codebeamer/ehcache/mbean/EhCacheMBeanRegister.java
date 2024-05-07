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

package com.intland.codebeamer.ehcache.mbean;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import java.util.List;

import java.lang.management.ManagementFactory;
import javax.management.MBeanServer;

import net.sf.ehcache.management.ManagementService;
import net.sf.ehcache.CacheManager;

@Lazy(false)
@Service("ehCacheMBeanRegister")
public class EhCacheMBeanRegister {

	private static final Logger logger = LogManager.getLogger(EhCacheMBeanRegister.class);

	@Autowired
	public EhCacheMBeanRegister(List<CacheManager> cacheManagers) {
		logger.info("EhCacheMBeanRegister");

		MBeanServer mBeanServer = ManagementFactory.getPlatformMBeanServer();
		for (CacheManager cacheManager : cacheManagers) {
			logger.info("Cache statistic is registered for {}", cacheManager.getName());
			ManagementService.registerMBeans(cacheManager, mBeanServer, false, false, false, true);
		}
	}

}