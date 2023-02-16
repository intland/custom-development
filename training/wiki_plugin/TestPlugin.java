package com.intland.codebeamer.wiki.plugins;

import java.util.Map;
import com.ecyrd.jspwiki.WikiContext;
import com.intland.codebeamer.wiki.plugins.base.AbstractCodeBeamerWikiPlugin;
import com.intland.codebeamer.wiki.plugins.googlemaps.Wiki2HTMLConverter;


public class TestPlugin extends AbstractCodeBeamerWikiPlugin {

    public String execute(WikiContext wikicontext, Map params) {

        Integer numberToPrint = Integer.parseInt((String)params.get("numberToPrint"));

        return "Our number to print: " + numberToPrint;
    }
}