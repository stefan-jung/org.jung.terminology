<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs">
    
    <xsl:output encoding="UTF-8" method="text" indent="false"/>

    <xsl:param name="dita.temp.dir.url" as="xs:anyURI"/>
    <xsl:param name="output.dir.url" as="xs:anyURI"/>
    <xsl:param name="source.language" as="xs:string"/>
    
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="preferred-term" on-no-match="shallow-skip"/>
    <xsl:mode name="admitted-term" on-no-match="shallow-skip"/>
    
    <xsl:variable name="termentry-topics" select="collection($dita.temp.dir.url || '?select=*.dita;recurse=yes')"/>
    <xsl:variable name="languages">
        <xsl:for-each select="distinct-values($termentry-topics//@language)">
            <xsl:value-of select="distinct-values(.) || ', '"/>
        </xsl:for-each>
    </xsl:variable>
    
    <!-- Match on the input terminology DITA Map. -->
    
    <!--{
        "Anlage": "system",
        "Techniker": "technician",
        "Dokumentation": "documentation",
        "Anhang": "appendix",
        "Steuerung": "control unit",
        "Bediener": "operator"
    }-->
    <xsl:template match="/">
        <xsl:variable name="root" select="." as="node()"/>
        <xsl:for-each select="tokenize($languages, ',')">
            <xsl:if test="contains(., '-')">
                <xsl:variable name="language" select="normalize-space(.)"/>
                <xsl:result-document href="{$output.dir.url || '/terminology_' || $language || '.json'}">
                    <xsl:text>{&#10;</xsl:text>
                    <xsl:apply-templates select="$root" mode="termref">
                        <xsl:with-param name="language" select="$language"/>
                    </xsl:apply-templates>
                    <xsl:text>}</xsl:text>
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
    
    <xsl:template match="termentry" mode="termentry" expand-text="yes">
        <xsl:param name="language" as="xs:string"/>
        <xsl:variable name="root" as="node()" select="."/>
        <xsl:variable name="term.source" select="
            normalize-space(
                $root//*
                [contains(@class, ' termentry/termNotation ')]
                [@usage = 'preferred']
                [@language = $source.language][1]
            )
            "/>
        <xsl:variable name="term.target" select="
            normalize-space(
                $root//*
                [contains(@class, ' termentry/termNotation ')]
                [@usage = 'preferred']
                [@language = $language][1]
            )
            "/>
        <xsl:if test="$term.source != '' and $term.target !=''">
            <xsl:sequence select="'&quot;' || $term.source || '&quot;: &quot;' || $term.target || '&quot;,&#10;'"/>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
