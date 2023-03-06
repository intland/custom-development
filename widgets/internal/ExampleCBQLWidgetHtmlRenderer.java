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
import java.util.Map;

import org.apache.velocity.VelocityContext;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.dashboard.component.common.RenderingContext;
import com.intland.codebeamer.dashboard.component.exception.WidgetRenderingException;
import com.intland.codebeamer.dashboard.component.exception.WidgetRenderingFailure;
import com.intland.codebeamer.dashboard.component.widgets.common.AbstractDefaultWidgetHtmlRenderer;
import com.intland.codebeamer.dashboard.component.widgets.common.PinnedWidgetModelPopulator;
import com.intland.codebeamer.dashboard.component.widgets.common.WidgetAttributeWrapper;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.WidgetAttribute;
import com.intland.codebeamer.dashboard.component.widgets.common.editor.shared.WrongFieldValueExceptionHandler;
import com.intland.codebeamer.dashboard.component.widgets.provider.WidgetAttributeValueProvider;
import com.intland.codebeamer.search.query.antlr.impl.exception.TooManyGroupingExpressionForAggregateOrderException;
import com.intland.codebeamer.search.query.antlr.impl.exception.WrongFieldValueException;
import com.intland.codebeamer.utils.LocalizedTextRetriever;
import com.intland.codebeamer.wiki.plugins.CBQLQueryPlugin;

/**
 * @author <a href="mailto:soma.gyore@intland.com">Soma Györe</a>
 *
 */
@Component
@Qualifier("exampleCBQLWidgetHtmlRenderer")
public class ExampleCBQLWidgetHtmlRenderer extends AbstractDefaultWidgetHtmlRenderer<ExampleCBQLWidget, CBQLQueryPlugin> {

	@Autowired
	@Qualifier("cBQLStringValueProvider")
	private WidgetAttributeValueProvider cBQLStringValueProvider;

	@Autowired
	private WrongFieldValueExceptionHandler wrongFieldValueExceptionHandler;

	@Autowired
	public ExampleCBQLWidgetHtmlRenderer(ObjectFactory<CBQLQueryPlugin> objectFactory, @Qualifier("defaultLocalizedTextRetriever") LocalizedTextRetriever localizedTextRetriever,
			PinnedWidgetModelPopulator<VelocityContext> pinnedWidgetModelPopulator) {
		super(objectFactory, localizedTextRetriever, pinnedWidgetModelPopulator);
	}


	/* (non-Javadoc)
	 * @see com.intland.codebeamer.dashboard.component.widgets.common.DefaultWidgetHtmlRenderer#render(com.intland.codebeamer.dashboard.component.common.RenderingContext, com.intland.codebeamer.dashboard.component.common.interfaces.Widget)
	 */
	@Override
	public String render(final RenderingContext renderingContext, final ExampleCBQLWidget widget) {
		try {
			return super.render(renderingContext, widget);
		} catch(final TooManyGroupingExpressionForAggregateOrderException exception) {
			throw new WidgetRenderingFailure(renderingContext.getLocalizedTextRetriever().getText(renderingContext.getRequest().getLocale(),
					"dashboard.query.widget.grouping.error", "This Report has multiple groups and does not support ordering by an aggregated column."));
		} catch(final WrongFieldValueException exception) {
			final WidgetRenderingException wrapperException = wrongFieldValueExceptionHandler.createException(renderingContext, widget, exception);
			throw wrapperException;
		}
	}

	@Override
	protected WidgetAttributeWrapper[] getWidgetAttributes() {
		return ExampleCBQLWidget.Attribute.values();
	}

	@Override
	protected Map<WidgetAttributeWrapper, WidgetAttributeValueProvider> getValueProviders() {
		Map<WidgetAttributeWrapper, WidgetAttributeValueProvider> valueProviders =
				new HashMap<WidgetAttributeWrapper, WidgetAttributeValueProvider>();
		valueProviders.put(ExampleCBQLWidget.Attribute.CBQL, cBQLStringValueProvider);
		return valueProviders;
	}

	@Override
	protected void createAdditionalParameters(final Map<String, WidgetAttribute> attributes, final Map<String, String> parameters) {
		final WidgetAttribute widgetAttribute = attributes.get("CBQL");

		if (widgetAttribute != null && widgetAttribute.getValue() != null) {
			parameters.put("cbQL", String.valueOf(widgetAttribute.getValue()));
		}
	}
}
