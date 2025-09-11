<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs">
    
    <xsl:output method="json" encoding="UTF-8" indent="yes"/>
    
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    
    <xsl:param name="dita.temp.dir.url" as="xs:anyURI"/>
    <xsl:param name="output.dir.url" as="xs:anyURI"/>
    <xsl:param name="source.language" as="xs:string"/>
    
    <xsl:variable name="termentry-topics" select="collection($dita.temp.dir.url || '?select=*.dita;recurse=yes')"/>
    
    <xsl:variable name="languages" as="xs:string*">
        <xsl:for-each select="distinct-values($termentry-topics//@language)">
            <xsl:variable name="lang" select="normalize-space(.)"/>
            <xsl:if test="$lang != $source.language and contains($lang, '-')">
                <xsl:sequence select="$lang"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:variable name="root" select="." as="node()"/>
        <xsl:for-each select="$languages">
            <xsl:variable name="target.language" select="."/>
            <xsl:result-document href="{$output.dir.url || '/terminology_' || $target.language || '.json'}" method="json">
                <xsl:map>
                    <xsl:apply-templates select="$root" mode="termref">
                        <xsl:with-param name="target.language" select="$target.language"/>
                    </xsl:apply-templates>
                </xsl:map>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="termref[@href][@keys]" mode="termref">
        <xsl:param name="target.language" as="xs:string"/>
        <xsl:variable name="filename" select="@href"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)"/>
        <xsl:apply-templates select="document($t)" mode="termentry">
            <xsl:with-param name="target.language" select="$target.language"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="termentry" mode="termentry">
        <xsl:param name="target.language" as="xs:string"/>
        <xsl:variable name="term.source" select="
            normalize-space(.//*[contains(@class, ' termentry/termNotation ')]
            [@usage='preferred']
            [@language=$source.language][1]/*[contains(@class, ' termentry/termVariant ')][1]/text())"/>
        <xsl:variable name="term.target" select="
            normalize-space(.//*[contains(@class, ' termentry/termNotation ')]
            [@usage='preferred']
            [@language=$target.language][1]/*[contains(@class, ' termentry/termVariant ')][1]/text())"/>
        <xsl:if test="$term.source != '' and $term.target != ''">
            <xsl:map-entry key="$term.source" select="$term.target"/>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>