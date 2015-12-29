<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    exclude-result-prefixes="xs"
    version="2.0">

    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>

    <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"
        omit-xml-declaration="no"
    />
    
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>    

    <xsl:template match="/">
        <xsl:element name="schema" namespace="http://purl.oclc.org/dsdl/schematron">
            <xsl:attribute name="queryBinding">xslt</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <sch:pattern>
            <sch:rule context="text()">
                <xsl:for-each select="termBody/termFullForm[@usage='deprecated']">
                    <xsl:variable name="deprecatedTerm" select="normalize-space(.)"/>
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test"><xsl:text>contains(., '</xsl:text><xsl:value-of select="$deprecatedTerm"/><xsl:text>')</xsl:text></xsl:attribute>
                        <xsl:attribute name="sqf:fix">changeWord</xsl:attribute>
                        <xsl:text>The term '</xsl:text><xsl:value-of select="$deprecatedTerm"/><xsl:text>' is not allowed.</xsl:text>
                    </xsl:element>
                    <xsl:element name="sqf:fix">
                        <xsl:attribute name="id">changeWord</xsl:attribute>
                        <xsl:element name="sqf:description">
                            <xsl:element name="sqf:title">Replace with an allowed term</xsl:element>
                        </xsl:element>
                        <xsl:for-each select="../termFullForm[@usage='allowed']">
                            <xsl:variable name="allowedTerm" select="normalize-space(.)"/>
                            <xsl:element name="sqf:stringReplace">
                                <xsl:attribute name="regex"><xsl:value-of select="$deprecatedTerm"/></xsl:attribute>
                                <xsl:value-of select="$allowedTerm"/>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:for-each>
            </sch:rule>
        </sch:pattern>
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