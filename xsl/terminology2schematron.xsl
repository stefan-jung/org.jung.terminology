<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:math="http://exslt.org/math" extension-element-prefixes="math"
    xmlns:dtl="http://doctales.github.io"
    exclude-result-prefixes="xs" version="2.0">

    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
            <xsl:apply-templates/>
        </sch:schema>
    </xsl:template>

    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <xsl:variable name="termentryId" select="@id"/>
        <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]"/>
        <xsl:element name="sch:pattern">
            <xsl:attribute name="id" select="@id"/>
            
            <!-- The context text() matches the text content of all nodes. -->
            <sch:rule context="text()">
                <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'deprecated']">
                    <xsl:variable name="termLanguage" select="normalize-space(@language)"/>
                    <xsl:variable name="deprecatedTerm" select="normalize-space(termVariant)"/>
                    <xsl:variable name="replaceTerm" select="concat('replace', $deprecatedTerm)"/>
                    
                    <!-- 
                        Create a report that will be reported if the tested topic: 
                        - contains a deprecated term
                        - the xml:lang attribute of the tested topic has the same value as the language attribute of the deprecated term
                    -->
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test">
                            <xsl:text>/*/@xml:lang = '</xsl:text>
                            <xsl:value-of select="$termLanguage"/>
                            <xsl:text>' and contains(., '</xsl:text>
                            <xsl:value-of select="$deprecatedTerm"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="sqf:fix" select="$replaceTerm"/>
                        <xsl:text>The term '</xsl:text>
                        <xsl:value-of select="$deprecatedTerm"/>
                        <xsl:text>' is not allowed.</xsl:text>
                    </xsl:element>

                    <xsl:message>Current element <xsl:value-of select="name()"/></xsl:message>

                    <!-- Create a Schematron Quick Fix group that contains quick fixes for all allowed term variants -->
                    <xsl:element name="sqf:group">
                        <xsl:attribute name="id" select="$replaceTerm"/>

                        <!-- Process all preceding-sibling term notations -->
                        <xsl:for-each select="preceding-sibling::*">
                            <xsl:call-template name="createSqfFix">
                                <xsl:with-param name="deprecatedTerm" select="$deprecatedTerm"/>
                                <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                <xsl:with-param name="definition" select="$definition"/>
                            </xsl:call-template>
                        </xsl:for-each>
                        
                        <!-- Process all following-sibling term notations -->
                        <xsl:for-each select="following-sibling::*">
                            <xsl:call-template name="createSqfFix">
                                <xsl:with-param name="deprecatedTerm" select="$deprecatedTerm"/>
                                <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                <xsl:with-param name="definition" select="$definition"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:for-each>
            </sch:rule>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="createSqfFix">
        <xsl:param name="deprecatedTerm"/>
        <xsl:param name="termLanguage"/>
        <xsl:param name="definition"/>
        <xsl:message>deprecatedTerm: <xsl:value-of select="$deprecatedTerm"/></xsl:message>
        <xsl:message>termLanguageOfDeprecatedTerm: <xsl:value-of select="$termLanguage"/></xsl:message>
        <xsl:message>termLanguageOfAllowedTerm: <xsl:value-of select="@language"/></xsl:message>
        <xsl:message>definition: <xsl:value-of select="$definition"/></xsl:message>
        <xsl:message>name(): <xsl:value-of select="name()"/></xsl:message>
        <xsl:message>node(): <xsl:value-of select="node()"/></xsl:message>
        <xsl:message>termVariant: <xsl:value-of select="termVariant[1]"/></xsl:message>
        <xsl:message>@usage: <xsl:value-of select="@usage"/></xsl:message>
        <xsl:message>@language: <xsl:value-of select="@language"/></xsl:message>
        <xsl:message>Content: <xsl:value-of select="."/></xsl:message>
        <xsl:variable name="allowedTerm" select="termVariant[1]">
            
        </xsl:variable>
        <xsl:variable name="sqfTitle">
            <xsl:choose>
                <xsl:when test="self::*[contains(@class, ' termentry/fullForm ')]">
                    <xsl:text>Replace with an allowed term: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/abbreviation ')]">
                    <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/acronym ')]">
                    <xsl:text>Replace with an allowed acronym: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:message>variable sqfTitle: <xsl:value-of select="normalize-space($sqfTitle)"/></xsl:message>
        
        <xsl:variable name="counter" select="position()"/>
        <xsl:variable name="quickFixId" select="concat('term', $counter)"/>
        
        <!-- FIXME: This uses the first termVariant but should use all and respect the flection of the deprecated term. -->
        <xsl:variable name="allowedFullForm" select="normalize-space(.)"/>
        <xsl:element name="sqf:fix">
            <xsl:attribute name="id" select="$quickFixId"/>
            <xsl:element name="sqf:description">
                <xsl:element name="sqf:title">
                    <xsl:value-of select="normalize-space($sqfTitle)"/>
                </xsl:element>
                <xsl:choose>
                    <xsl:when test="$definition != ''">
                        <xsl:element name="sqf:p">
                            <xsl:text>Definition: </xsl:text>
                            <xsl:value-of select="$definition"/>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:element>
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:value-of select="$deprecatedTerm"/>
                </xsl:attribute>
                <xsl:value-of select="$allowedTerm"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    <!-- Remove HTML clutter -->
    <xsl:template name="chapter-setup">
        <xsl:call-template name="chapterBody"/>
    </xsl:template>
    
    <xsl:template name="chapterBody">
        <xsl:apply-templates select="." mode="chapterBody"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*" mode="chapterBody"/>

</xsl:stylesheet>
