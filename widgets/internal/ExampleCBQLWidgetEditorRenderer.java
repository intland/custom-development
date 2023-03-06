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

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.velocity.VelocityContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.dashboard.component.common.RenderingContext;
import com.intland.codebeamer.dashboard.component.common.RenderingContextAttribute;
import com.intland.codebeamer.dashboard.component.common.RenderingContextFactory;
import com.intland.codebeamer.dashboard.component.widgets.common.DefaultWidgetEditorRenderer;
import com.intland.codebeamer.dashboard.component.widgets.common.ModelPopulator;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.WidgetAttribute;
import com.intland.codebeamer.dashboard.component.widgets.common.editor.FormLayoutEditorFooter;
import com.intland.codebeamer.utils.TemplateRenderer;

/**
 * @author <a href="mailto:soma.gyore@intland.com">Soma Györe</a>
 *
 */
@Component
@Qualifier("exampleCBQLWidgetEditorRenderer")
public class ExampleCBQLWidgetEditorRenderer extends DefaultWidgetEditorRenderer<ExampleCBQLWidget> {

	@Autowired
	public ExampleCBQLWidgetEditorRenderer(final ModelPopulator<VelocityContext> modelPopulator, final TemplateRenderer templateRenderer,
			final FormLayoutEditorFooter formLayoutEditorFooter, final RenderingContextFactory renderingContextFactory) {
		super(modelPopulator, templateRenderer, formLayoutEditorFooter, renderingContextFactory);
	}

	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.widgets.common.DefaultWidgetEditorRenderer#render(com.intland.codebeamer.dashboard.component.common.RenderingContext, com.intland.codebeamer.dashboard.component.common.interfaces.Widget)
	 */
	@Override
	public String render(final RenderingContext renderingContext, final ExampleCBQLWidget widget) {
		final Map<RenderingContextAttribute, Object> attributes = new HashMap<RenderingContextAttribute, Object>();

		final Set<String> noMandatoryIndicatorFields = new HashSet<String>(2);
		noMandatoryIndicatorFields.add(ExampleCBQLWidget.Attribute.CBQL.getLabel());
		attributes.put(RenderingContextAttribute.NO_MANDATORY_INDICATOR, noMandatoryIndicatorFields);

		final RenderingContext expandedRenderingContext = getRenderingContextFactory().createInstance(renderingContext, attributes);

		return super.render(expandedRenderingContext, widget);
	}

	@Override
	protected Map<String, WidgetAttribute> getDescriptor() {
		return ExampleCBQLWidget.getDescriptor();
	}
}
