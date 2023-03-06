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
package com.intland.codebeamer.dashboard.component.widgets.training;

import org.springframework.stereotype.Component;

import com.intland.codebeamer.dashboard.component.common.interfaces.Widget;
import com.intland.codebeamer.dashboard.component.common.interfaces.WidgetFactory;
import com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation;
import com.intland.codebeamer.dashboard.component.widgets.common.WidgetCategory;

/**
 * @author <a href="mailto:soma.gyore@intland.com">Soma Györe</a>
 *
 */
@Component
public class ExampleCBQLWidgetInformation implements WidgetInformation {

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getType()
	 */
	@Override
	public String getType() {
		return ExampleCBQLWidget.class.getCanonicalName();
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getCategory()
	 */
	@Override
	public String getCategory() {
		return WidgetCategory.CHART.getName();
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getImagePreviewUrl()
	 */
	@Override
	public String getImagePreviewUrl() {
		return "/images/newskin/dashboard/thumbnails/icon_query.png";
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getKnowledgeBaseUrl()
	 */
	@Override
	public String getKnowledgeBaseUrl() {
		return "";
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getVendor()
	 */
	@Override
	public String getVendor() {
		return "Intland";
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getName()
	 */
	@Override
	public String getName() {
		return "My Example Widget";
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getShortDescription()
	 */
	@Override
	public String getShortDescription() {
		return "My own custom widget";
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.common.interfaces.WidgetInformation#getFactory()
	 */
	@Override
	public <T extends Widget> WidgetFactory<T> getFactory() {
		return null;
	}

}
