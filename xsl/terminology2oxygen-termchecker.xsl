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
    <xsl:mode name="deprecated-term" on-no-match="shallow-skip"/>
    
    <xsl:variable name="termentry-topics" select="collection($dita.temp.dir.url || '?select=*.dita;recurse=yes')"/>
    <xsl:variable name="languages">
        <xsl:for-each select="distinct-values($termentry-topics//@language)">
            <xsl:value-of select="distinct-values(.) || ', '"/>
        </xsl:for-each>
    </xsl:variable>
    
    
    <!--<?xml version="1.0" encoding="UTF-8"?>
    <incorrect-terms>
        <incorrect-term ignorecase="true">
            <match type="whole-word">match this</match>
            <suggestion format="text">replace with this</suggestion>
            <message>present as tooltip message</message>
            <link>https://www.example.com</link>
        </incorrect-term>
    </incorrect-terms>-->
    
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
        <xsl:apply-templates mode="deprecated-term">
            <xsl:with-param name="language" select="$language"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended']" mode="deprecated-term">
        <xsl:param name="language" as="xs:string"/>
        <xsl:if test="@language = $language">
            <incorrect-term ignorecase="true">
                <match type="whole-word"><xsl:value-of select="./termVariant/text()"/></match>
                <suggestion format="text">replace with this</suggestion>
                <message><xsl:value-of select="'Definition: ' || normalize-space(preceding::definitionText[1]/text())"/></message>
                <link>https://www.example.com</link>
            </incorrect-term>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>
