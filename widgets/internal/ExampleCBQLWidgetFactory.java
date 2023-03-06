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

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.dashboard.component.common.interfaces.Renderer;
import com.intland.codebeamer.dashboard.component.widgets.common.AbstractWidgetFactory;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.WidgetAttribute;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.WidgetAttributeMapper;

/**
 * @author <a href="mailto:soma.gyore@intland.com">Soma Györe</a>
 *
 */
@Component
public class ExampleCBQLWidgetFactory extends AbstractWidgetFactory<ExampleCBQLWidget> {

	private static final String HTML_RENDERER_NAME = "exampleCBQLWidgetHtmlRenderer";
	private static final String EDITOR_RENDERER_NAME = "exampleCBQLWidgetEditorRenderer";

	@Autowired
	public ExampleCBQLWidgetFactory(
			final @Qualifier(HTML_RENDERER_NAME) Renderer<ExampleCBQLWidget> htmlRenderer,
			final @Qualifier(EDITOR_RENDERER_NAME) Renderer<ExampleCBQLWidget> editorRenderer,
			final WidgetAttributeMapper widgetAttributeMapper) {
		super(htmlRenderer, editorRenderer, widgetAttributeMapper);
	}

	@Override
	public Class<ExampleCBQLWidget> getType() {
		return ExampleCBQLWidget.class;
	}

	@Override
	protected ExampleCBQLWidget newInstance(String id, Map<String, WidgetAttribute> descriptor,
			Renderer<ExampleCBQLWidget> widgetHtmlRenderer, Renderer<ExampleCBQLWidget> widgetEditorRenderer) {
		return new ExampleCBQLWidget(id, descriptor, widgetHtmlRenderer, widgetEditorRenderer);
	}

	@Override
	protected Map<String, WidgetAttribute> getAttributes() {
		return ExampleCBQLWidget.getDescriptor();
	}

	@Override
	protected String getHtmlRendererName() {
		return HTML_RENDERER_NAME;
	}

	@Override
	protected String getEditorRendererName() {
		return EDITOR_RENDERER_NAME;
	}

}
