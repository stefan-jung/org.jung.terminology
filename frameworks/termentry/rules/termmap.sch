<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://doctales.github.io" prefix="doctales"/>
    <sch:extends href="terminology.sch"/>
    
    <sch:title>Style Guide for Termentry Maps</sch:title>
    
    <sch:pattern id="validate-topicref">
        <sch:rule context="*[contains(@class, ' termmap/termref ')]">
            <sch:let name="key" value="doctales:getIdFromPath(@href)"/>
            <sch:assert test="contains(@keys, $key)" sqf:fix="fix-id" role="warning"
                diagnostics="validate-topicref-en validate-topicref-de">
                The key of a topicref should contain the filename of the termentry topic without file extension.
            </sch:assert>
            <sch:let name="new-keys" value="concat(concat(@keys, ' '), $key)"/>
            <sqf:fix id="fix-id">
                <sqf:description>
                    <sqf:title>Rename keys to '<sch:value-of select="$new-keys"/>'</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="keys"><sch:value-of select="$new-keys"/></sqf:add>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="validate-topicref-en" xml:lang="en">
            The key of a topicref should contain the filename of the termentry topic without file extension.
        </sch:diagnostic>
        <sch:diagnostic id="validate-topicref-de" xml:lang="de">
            Der Schlüssel der Topic-Referenz sollte den Dateinamen des Termentry-Topics ohne Dateiendung enthalten.
        </sch:diagnostic>
    </sch:diagnostics>
</sch:schema>