<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tbx="urn:iso:std:iso:30042:ed-2"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="fn tbx xd xs">
    
    <!--
        The purpose of this script is to transform a TBX Basic file into a set of <termentry> topics.
    -->
    
    <xsl:output method="xml" indent="true"/>
    
    <!--<xsl:mode on-no-match="shallow-skip"/>-->
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="termref"  on-no-match="shallow-skip"/>
    <xsl:mode name="title" on-no-match="shallow-skip"/>
    
    <xsl:template match="/tbx:tbx">
        <termmap>
            <xsl:apply-templates mode="termref"/>
            <xsl:apply-templates mode="termentry"/>
        </termmap>
    </xsl:template>
    
    <xsl:template match="tbx:tbxHeader/tbx:fileDesc/tbx:titleStmt/tbx:title" mode="termref">
        <title><xsl:value-of select="."/></title>
    </xsl:template>
    
    <xsl:template match="tbx:conceptEntry" mode="termref">
        <termref href="{ @id || '.dita' }" keys="{ @id }"/>
    </xsl:template>
    
    <xsl:template match="tbx:conceptEntry" mode="termentry">
        <xsl:result-document href="{ @id || '.dita' }" indent="true" method="xml">
            <termentry>
                <title><xsl:value-of select="descendant::tbx:term[1]/text()"/></title>
                <termBody>
                    <xsl:apply-templates mode="termentry-term"/>
                </termBody>
            </termentry>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tbx:langSec" mode="termentry-term">
        <xsl:apply-templates mode="termentry-term">
            <xsl:with-param name="lang" select="@xml:lang"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tbx:termSec" mode="termentry-term">
        <xsl:param name="lang" as="xs:string"/>
        <fullForm language="{$lang}" usage="preferred">
            <termVariant><xsl:value-of select="./tbx:term/text()"/></termVariant>
        </fullForm>
    </xsl:template>
    
</xsl:stylesheet>