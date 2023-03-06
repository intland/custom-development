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

import java.util.LinkedHashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JacksonInject;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.intland.codebeamer.dashboard.component.common.interfaces.Renderer;
import com.intland.codebeamer.dashboard.component.widgets.common.AbstractRenderedWidget;
import com.intland.codebeamer.dashboard.component.widgets.common.WidgetAttributeLabel;
import com.intland.codebeamer.dashboard.component.widgets.common.WidgetAttributeWrapper;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.StringAttribute;
import com.intland.codebeamer.dashboard.component.widgets.common.attribute.WidgetAttribute;

/**
 * @author <a href="mailto:soma.gyore@intland.com">Soma Györe</a>
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonPropertyOrder(alphabetic=true)
public class ExampleCBQLWidget extends AbstractRenderedWidget<ExampleCBQLWidget> {

	private static final String VERSION = "1.0.0";

	public enum Attribute implements WidgetAttributeWrapper, WidgetAttributeLabel {

		CBQL("cbQL", "CBQL", new StringAttribute("", true, false));

		private String key;
		private WidgetAttribute<?> defaultValue;
		private String label;

		Attribute(String key, String label, WidgetAttribute<?> defaultValue) {
			this.key = key;
			this.label = label;
			this.defaultValue = defaultValue;
		}

		@Override
		public String getKey() {
			return key;
		}

		@Override
		public String getLabel() {
			return label;
		}

		@Override
		public WidgetAttribute<?> getDefaultValue() {
			return defaultValue;
		}
	}

	public ExampleCBQLWidget(@JsonProperty("id") final String id, @JsonProperty("attributes") final Map<String, WidgetAttribute> attributes,
			@JacksonInject("exampleCBQLWidgetHtmlRenderer") final Renderer<ExampleCBQLWidget> htmlRenderer,
			@JacksonInject("exampleCBQLWidgetEditorRenderer") final Renderer<ExampleCBQLWidget> editorRenderer) {
		super(id, attributes, htmlRenderer, editorRenderer);
	}

	public static Map<String, WidgetAttribute> getDescriptor() {
		final Map<String, WidgetAttribute> result = new LinkedHashMap<>();

		for (Attribute attribute : Attribute.values()) {
			result.put(attribute.getLabel(), attribute.getDefaultValue());
		}

		return result;
	}

	@Override
	protected ExampleCBQLWidget getInstance() {
		return this;
	}

	@Override
	public String getDefaultTitleKey() {
		return "My Example Widget";
	}

	@Override
	public String getVersion() {
		return VERSION;
	}
}
