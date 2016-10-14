<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://doctales.github.io" prefix="doctales"/>
    <sch:extends href="terminology.sch"/>
    
    <sch:title>Style Guide for Termentry Topics</sch:title>
    
    <sch:pattern id="validate-language-codes">
        <sch:let name="codes" value="document('../../codes.xml')" />
        <sch:rule context="*[contains(@class, ' termentry/termNotation ')]" role="warning">
            <sch:let name="this" value="normalize-space(@language)" />
            <sch:assert test="$codes//code[normalize-space(.) = $this]" 
                diagnostics="validate-language-codes-en validate-language-codes-de">
                The @language attribute must contain a valid country/region code, e.g. 'en-GB'.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="validate-language-codes-en" xml:lang="en">
            The @language attribute must contain a valid country/region code, e.g. 'en-GB'.
        </sch:diagnostic>
        <sch:diagnostic id="validate-language-codes-de" xml:lang="de">
            Das @language Attribut muss einen gültigen Länder-/Regionscode enthalten, z.B. 'en-GB'.
        </sch:diagnostic>
    </sch:diagnostics>

    <sch:pattern id="termentry-topic-id">
        <sch:rule context="*[contains(@class, 'termentry/termentry')]">
            <sch:let name="new-id" value="doctales:getIdFromPath(base-uri())"/>
            <sch:assert test="@id eq $new-id" sqf:fix="fix-id" role="warning"
                diagnostics="termentry-topic-id-en termentry-topic-id-de">
                The ID of the termentry topic must be equal to its filename without file extension.
            </sch:assert>
            <sqf:fix id="fix-id">
                <sqf:description>
                    <sqf:title>Rename ID to '<sch:value-of select="$new-id"/>'</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="id"><sch:value-of select="$new-id"/></sqf:add>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="termentry-topic-id-en" xml:lang="en">
            The ID of the termentry topic must be equal to its filename without file extension.
        </sch:diagnostic>
        <sch:diagnostic id="termentry-topic-id-de" xml:lang="de">
            Die ID des termentry Topics muss dem Dateinamen ohne Dateiendung entsprechen.
        </sch:diagnostic>
    </sch:diagnostics>
</sch:schema>