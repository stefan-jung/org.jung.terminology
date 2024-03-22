<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="https://stefan-jung.org" prefix="sj"/>
    <sch:extends href="terminology.sch"/>
    
    <sch:title>Style Guide for Termentry Topics</sch:title>
    
    <sch:pattern id="validate-language-codes">
        <sch:let name="codes" value="document('../resources/codes.xml')" />
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
            <sch:let name="new-id" value="sj:getIdFromPath(base-uri())"/>
            <sch:assert test="@id eq $new-id" sqf:fix="fix-id" role="warning"
                diagnostics="termentry-topic-id-en termentry-topic-id-de">
                The ID of the termentry topic must be equal to its filename without file extension.
            </sch:assert>
            <sqf:fix id="fix-id">
                <sqf:description>
                    <sqf:title ref="rename-to-en rename-to-de" xml:lang="en">
                        Rename ID to '<sch:value-of select="$new-id"/>'
                    </sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="id"><sch:value-of select="$new-id"/></sqf:add>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="rename-to-en" xml:lang="en">
            Rename ID to '<sch:value-of select="$new-id"/>'
        </sch:diagnostic>
        <sch:diagnostic id="rename-to-de" xml:lang="de">
            Ändere ID zu '<sch:value-of select="$new-id"/>'
        </sch:diagnostic>
    </sch:diagnostics>
    <sch:diagnostics>
        <sch:diagnostic id="termentry-topic-id-en" xml:lang="en">
            The ID of the termentry topic must be equal to its filename without file extension.
        </sch:diagnostic>
        <sch:diagnostic id="termentry-topic-id-de" xml:lang="de">
            Die ID des termentry Topics muss dem Dateinamen ohne Dateiendung entsprechen.
        </sch:diagnostic>
    </sch:diagnostics>
    
    <!--<sch:pattern id="duplicate-termrelation">
        <sch:rule context="*[contains(@class, ' termentry/termRelation ')]">
            <sch:let name="new-id" value="sj:getIdFromPath(base-uri())"/>
            <sch:assert test="(@keyref eq preceding-sibling::*[contains(@class, ' termentry/termRelation ')]/@keyref)
                or (@keyref eq following-sibling::*[contains(@class, ' termentry/termRelation ')]/@keyref)" role="error"
                diagnostics="termentry-topic-id-en termentry-topic-id-de">
                Duplicate term relation
            </sch:assert>
        </sch:rule>
    </sch:pattern>-->
    
    <sch:pattern id="xref-missing-format-html">
        <sch:rule context="*[contains(@class, ' topic/xref ')][contains(@href, 'http')]" role="info">
            <sch:assert test="@format='html'" diagnostics="xref-missing-format-html-en xref-missing-format-html-de" sqf:fix="set-format">
                Attribute @format should be set to 'html'
            </sch:assert>
            <sqf:fix id="set-format">
                <sqf:description>
                    <sqf:title ref="xref-missing-format-html-description-title_en xref-missing-format-html-description-title_de"
                        xml:lang="en">Set @format=&quot;html&quot;</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="format" select="'html'"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="xref-missing-format-html-description-title-en">
            Set @format=&quot;html&quot;
        </sch:diagnostic>
        <sch:diagnostic id="xref-missing-format-html-description-title-de">
            Setze @format=&quot;html&quot;
        </sch:diagnostic>
        <sch:diagnostic id="xref-missing-format-html-en" xml:lang="en">
            Attribute @format should be set to 'html'
        </sch:diagnostic>
        <sch:diagnostic id="xref-missing-format-html-de" xml:lang="de">
            Attribut @format sollte den Wert 'html' haben
        </sch:diagnostic>
    </sch:diagnostics>
    
    <sch:pattern id="xref-missing-scope-external">
        <sch:rule context="*[contains(@class, ' topic/xref ')][contains(@href, 'http')]" role="info">
            <sch:assert test="@scope='external'" diagnostics="xref-missing-scope-external-en xref-missing-scope-external-de" sqf:fix="set-format">
                Attribute @scope should be set to 'external'
            </sch:assert>
            <sqf:fix id="set-format">
                <sqf:description>
                    <sqf:title ref="xref-missing-scope-external-description-title_en xref-missing-scope-external-description-title_de"
                        xml:lang="en">Set @scope=&quot;external&quot;</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="scope" select="'external'"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="xref-missing-scope-external-description-title-en">
            Set @scope=&quot;external&quot;
        </sch:diagnostic>
        <sch:diagnostic id="xref-missing-scope-external-description-title-de">
            Setze @scope=&quot;external&quot;
        </sch:diagnostic>
        <sch:diagnostic id="xref-missing-scope-external-en" xml:lang="en">
            Attribute @scope should be set to 'external'
        </sch:diagnostic>
        <sch:diagnostic id="xref-missing-scope-external-de" xml:lang="de">
            Attribut @scope sollte den Wert 'external' haben
        </sch:diagnostic>
    </sch:diagnostics>
    
    <xsl:key name="superordinateConcepts" match="//*[contains(@class, ' termentry/superordinateConcept ')][@keyref]" use="@keyref"/>
    <xsl:key name="subordinateConcepts" match="//*[contains(@class, ' termentry/subordinateConcept ')][@keyref]" use="@keyref"/>
    <xsl:key name="relatedterms" match="//*[contains(@class, ' termentry/relatedTerm ')][@keyref]" use="@keyref"/>
    <xsl:key name="antonyms" match="//*[contains(@class, ' termentry/antonym ')][@keyref]" use="@keyref"/>
    <xsl:key name="instancesOf" match="//*[contains(@class, 'termentry/instanceOf ')][@keyref]" use="@keyref"/>
    <xsl:key name="partsOf" match="//*[contains(@class, 'termentry/partOf ')][@keyref]" use="@keyref"/>
    
    <sch:pattern id="duplicate-termrelation">
        <sch:rule context="*[contains(@class, ' termentry/termRelation ')]">
            <sch:let name="keyref" value="@keyref"/>
            <sch:let name="countSuperordinateConceptsKeys" value="count(key('superordinateConcepts', $keyref))"/>
            <sch:report test="$countSuperordinateConceptsKeys > 1" diagnostics="duplicate-superordinateConcepts-en duplicate-superordinateConcepts-de">
                Duplicate &lt;superordinateConcept&gt; key references: @<sch:value-of select="@keyref"/>
            </sch:report>
            <sch:let name="countSubordinateKeys" value="count(key('subordinateConcepts', $keyref))"/>
            <sch:report test="$countSubordinateKeys > 1" diagnostics="duplicate-subordinateConcepts-en duplicate-subordinateConcepts-de">
                Duplicate &lt;subordinateConcept&gt; key references: @<sch:value-of select="@keyref"/>
            </sch:report>
            <sch:let name="countrelatedtermkeys" value="count(key('relatedterms', $keyref))"/>
            <sch:report test="$countrelatedtermkeys > 1" diagnostics="duplicate-relatedterms-en duplicate-relatedterms-de">
                Duplicate &lt;relatedTerm&gt; key references: @<sch:value-of select="@keyref"/>
            </sch:report>
            <sch:let name="countantonymkeys" value="count(key('antonyms', $keyref))"/>
            <sch:report test="$countantonymkeys > 1" diagnostics="duplicate-antonyms-en duplicate-antonyms-de">
                Duplicate &lt;antonym&gt; key references: @<sch:value-of select="@keyref"/>
            </sch:report>
            <sch:let name="countinstancesofkeys" value="count(key('instancesOf', $keyref))"/>
            <sch:report test="$countinstancesofkeys > 1" diagnostics="duplicate-instancesof-en duplicate-instancesof-de">
                Duplicate &lt;instanceOf&gt; key references: @<sch:value-of select="@keyref"/>
            </sch:report>
            <sch:let name="countpartofkeys" value="count(key('partsOf', $keyref))"/>
            <sch:report test="$countpartofkeys > 1" diagnostics="duplicate-partsof-en duplicate-partsof-de">
                Duplicate &lt;partOf&gt; key references: @<sch:value-of select="@keyref"/>
            </sch:report>
        </sch:rule>
    </sch:pattern>
    <!-- superordinateConcepts -->
    <sch:diagnostics>
        <sch:diagnostic id="duplicate-superordinateConcepts-en" xml:lang="en">
            Duplicate superordinate concepts termrelation
        </sch:diagnostic>
        <sch:diagnostic id="duplicate-superordinateConcepts-de" xml:lang="de">
            Doppelte übergeordneter Begriff-Termbeziehung
        </sch:diagnostic>
    </sch:diagnostics>
    <!-- subordinateConcepts -->
    <sch:diagnostics>
        <sch:diagnostic id="duplicate-subordinateConcepts-en" xml:lang="en">
            Duplicate subordinateConcepts termrelation
        </sch:diagnostic>
        <sch:diagnostic id="duplicate-subordinateConcepts-de" xml:lang="de">
            Doppelte untergeordneter Begriff-Termbeziehung
        </sch:diagnostic>
    </sch:diagnostics>
    <!-- relatedTerms -->
    <sch:diagnostics>
        <sch:diagnostic id="duplicate-relatedterms-en" xml:lang="en">
            Duplicate relatedTerm termrelation
        </sch:diagnostic>
        <sch:diagnostic id="duplicate-relatedterms-de" xml:lang="de">
            Doppelte relatedTerm-Termbeziehung
        </sch:diagnostic>
    </sch:diagnostics>
    <!-- antonyms -->
    <sch:diagnostics>
        <sch:diagnostic id="duplicate-antonyms-en" xml:lang="en">
            Duplicate antonym termrelation
        </sch:diagnostic>
        <sch:diagnostic id="duplicate-antonyms-de" xml:lang="de">
            Doppelte Antonym-Termbeziehung
        </sch:diagnostic>
    </sch:diagnostics>
    <!-- instanceOf -->
    <sch:diagnostics>
        <sch:diagnostic id="duplicate-instancesof-en" xml:lang="en">
            Duplicate instanceOf termrelation
        </sch:diagnostic>
        <sch:diagnostic id="duplicate-instancesof-de" xml:lang="de">
            Doppelte Instanz-Von-Termbeziehung
        </sch:diagnostic>
    </sch:diagnostics>
    <!-- partOf -->
    <sch:diagnostics>
        <sch:diagnostic id="duplicate-partsof-en" xml:lang="en">
            Duplicate partOf termrelation
        </sch:diagnostic>
        <sch:diagnostic id="duplicate-partsof-de" xml:lang="de">
            Doppelte Teil-Von-Termbeziehung
        </sch:diagnostic>
    </sch:diagnostics>
    
</sch:schema>