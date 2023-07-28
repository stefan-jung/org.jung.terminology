<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="fn xd xs">
    
    <!--
        The purpose of this script is to transform a TBX Basic file into a set of <termentry> topics.
    -->
    
    <xsl:output method="xml" indent="true"/>
    
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="termref"  on-no-match="shallow-skip"/>
    <xsl:mode name="title" on-no-match="shallow-skip"/>
    
    <xsl:template match="/">
        <termmap>
            aha
            <xsl:apply-templates select="*" mode="title"/>
            <xsl:apply-templates select="*" mode="termref"/>
            <xsl:apply-templates select="*" mode="termentry"/>
        </termmap>
    </xsl:template>
    
    <xsl:template match="fn:text" mode="termref">
        text
        <xsl:apply-templates mode="termref"/>
    </xsl:template>
    
    <xsl:template match="body" mode="termref">
        body
        <xsl:apply-templates mode="termref"/>
    </xsl:template>
    
    <xsl:template match="/tbx/tbxHeader[1]/fileDesc[1]/titleStmt[1]/title[1]" mode="title">
        <title><xsl:value-of select="."/></title>
        
    </xsl:template>
    
    <xsl:template match="conceptEntry" mode="termref">
        <termref href="{ @id || '.dita' }" keys="{ @id }"/>
    </xsl:template>
    
    <xsl:template match="conceptEntry" mode="termentry">
        <xsl:result-document href="{ @id || '.dita' }">
            <foo/>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>