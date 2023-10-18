<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xd xs">
    
    <xsl:output indent="true" encoding="UTF-8"/>
    <xsl:param name="dita.temp.dir.url" as="xs:anyURI"/>
    <xsl:param name="output.dir.url" as="xs:anyURI"/>
    
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="deprecated-term" on-no-match="shallow-skip"/>
    
    <xsl:variable name="termentry-topics" select="collection($dita.temp.dir.url || '?select=*.dita;recurse=yes')"/>
    <xsl:variable name="languages">
        <xsl:for-each select="distinct-values($termentry-topics//@language)">
            <xsl:value-of select="distinct-values(.) || ', '"/>
        </xsl:for-each>
    </xsl:variable>
    
    <!-- Match on the input terminology DITA Map. -->
    <xsl:template match="/">
        <xsl:variable name="root" select="." as="node()"/>
        <xsl:for-each select="tokenize($languages, ',')">
            <xsl:if test="contains(., '-')">
                <xsl:variable name="language" select="normalize-space(.)"/>
                <xsl:result-document href="{$output.dir.url || '/termchecker_' || $language || '.xml'}">
                    <incorrect-terms lang="{$language}">
                        <xsl:apply-templates select="$root" mode="termref">
                            <xsl:with-param name="language" select="$language"/>
                        </xsl:apply-templates>
                    </incorrect-terms>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!-- Fall through -->
    <xsl:template match="topicref" mode="termref"/>
    <xsl:template match="semanticnetref" mode="termref"/>
    <xsl:template match="termstatsref" mode="termref"/>
    
    <xsl:template match="termref[@href][@keys]" mode="termref">
        <xsl:param name="language" as="xs:string"/>
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)" as="xs:anyURI"/>
        <xsl:apply-templates select="document($t)" mode="termentry">
            <xsl:with-param name="language" select="$language"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="termentry" mode="termentry">
        <xsl:param name="language" as="xs:string"/>
        <xsl:variable name="root" as="node()" select="."/>
        <xsl:apply-templates mode="deprecated-term">
            <xsl:with-param name="root" select="$root"/>
            <xsl:with-param name="language" select="$language"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended']" mode="deprecated-term">
        <xsl:param name="root" as="node()"/>
        <xsl:param name="language" as="xs:string"/>
        <xsl:if test="@language = $language">
            <incorrect-term ignorecase="true">
                <match type="whole-word"><xsl:value-of select="./termVariant/text()"/></match>
                <xsl:for-each select="$root//*[contains(@class, ' termentry/termNotation ')][contains(@language, $language)][contains(@usage, 'preferred') or contains(@usage, 'admitted')]">
                    <suggestion format="text"><xsl:value-of select="normalize-space(./termVariant/text())"/></suggestion>
                </xsl:for-each>
                <message><xsl:value-of select="'Definition: ' || normalize-space(preceding::definitionText[1]/text())"/></message>
                <!--<link>https://www.example.com</link>-->
            </incorrect-term>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>
