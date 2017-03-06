<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"
        doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:param name="temp.dir"/>
    <xsl:param name="ditamap"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:template match="/" priority="1">
        <termstats>
            <termconflicts><xsl:apply-templates mode="termconflict"/></termconflicts>
            <reports><xsl:call-template name="report"/></reports>
        </termstats>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="termconflict">
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="preferredTermFile" select="@href" as="xs:string"/>
        <xsl:for-each select="document($preferredTermFile,.)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'preferred')]">
            <xsl:variable name="preferredTerm" select="normalize-space(.)"/>
            <xsl:for-each select="document($ditamap,.)/descendant::*[contains(@class, 'termmap/termref')]">
                <xsl:variable name="notRecommendedTermFile" select="@href" as="xs:string"/>
                <xsl:for-each select="document($notRecommendedTermFile,.)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'notRecommended')]">
                    <xsl:variable name="notRecommendedTerm" select="normalize-space(.)"/>
                    <xsl:if test="$preferredTermFile != $notRecommendedTermFile">
                        <xsl:if test="not($preferredTerm != $notRecommendedTerm)">
                            <xsl:element name="termconflict">
                                <xsl:element name="termnotation"><xsl:value-of select="$preferredTerm"/></xsl:element>
                                <xsl:element name="preferredTermFile"><xsl:value-of select="$preferredTermFile"/></xsl:element>
                                <xsl:element name="notRecommendedTermFile"><xsl:value-of select="$notRecommendedTermFile"/></xsl:element>
                            </xsl:element>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="report">
        <xsl:element name="report">
            <xsl:attribute name="date" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
            <xsl:variable name="termCollection" select="concat($temp.dir, '/?select=*.dita')"/>
            <xsl:element name="numberOfTermTopics">
                <xsl:value-of select="count(collection($termCollection)//*[contains(@class, 'termentry/termentry')])"/>
            </xsl:element>
            <xsl:element name="numberOfLanguages">
                <xsl:value-of select="count(distinct-values(collection($termCollection)//*[contains(@class, 'termentry/termNotation')][@language]/@language))"/>
            </xsl:element>
            <xsl:element name="numberOfPreferredTermNotations">
                <xsl:value-of select="count(collection($termCollection)//*[contains(@class, 'termentry/termNotation')][@usage='preferred'])"/>
            </xsl:element>
            <xsl:element name="numberOfAdmittedTermNotations">
                <xsl:value-of select="count(collection($termCollection)//*[contains(@class, 'termentry/termNotation')][@usage='admitted'])"/>
            </xsl:element>
            <xsl:element name="numberOfNotRecommendedTermNotations">
                <xsl:value-of select="count(collection($termCollection)//*[contains(@class, 'termentry/termNotation')][@usage='notRecommended'])"/>
            </xsl:element>
            <xsl:element name="numberOfObsoleteTermNotations">
                <xsl:value-of select="count(collection($termCollection)//*[contains(@class, 'termentry/termNotation')][@usage='obsolete'])"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- Fall Through Templates -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]"/>
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]"/>
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]"/>
    <xsl:template match="*[contains(@class, ' bookmap/mainbooktitle ')]"/>

</xsl:stylesheet>
