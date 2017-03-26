<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
    <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="temp.dir"/>
    <xsl:param name="termMap"/>
    <xsl:param name="temp.dir.abs"/>
    <xsl:param name="ditamap.filename"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:template match="/" priority="1">
        <xsl:variable name="termCollection" select="collection(concat($temp.dir.abs, '/?select=*.dita'))"/>
        <termstats>
            <currentStatistics>
                <languages>
                    <xsl:call-template name="languages">
                        <xsl:with-param name="termCollection" select="$termCollection"/>
                    </xsl:call-template>
                </languages>
                <termNotationsPerLanguage>
                    <xsl:call-template name="termNotationsPerLanguage">
                        <xsl:with-param name="termCollection" select="$termCollection"/>
                    </xsl:call-template>
                </termNotationsPerLanguage>
                <termconflicts>
                    <xsl:apply-templates mode="termconflict"/>
                </termconflicts>
            </currentStatistics>
            <chronologicalStatistics>
                <xsl:call-template name="report">
                    <xsl:with-param name="termCollection" select="$termCollection"/>
                </xsl:call-template>
            </chronologicalStatistics>
        </termstats>
    </xsl:template>
    
    <xsl:template name="languages">
        <xsl:param name="termCollection"/>
        <xsl:for-each select="distinct-values($termCollection//*[contains(@class, 'termentry/termNotation')][@language]/@language)">
            <xsl:element name="language">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="termNotationsPerLanguage">
        <xsl:param name="termCollection"/>
        <xsl:for-each select="distinct-values($termCollection//*[contains(@class, 'termentry/termNotation')][@language]/@language)">
            <xsl:variable name="language" select="."/>
            <xsl:element name="language">
                <xsl:attribute name="lang" select="$language"/>
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@language=$language])"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="termconflict">
        <xsl:variable name="currentTermrefNode" select="."/>
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="termEntryTopic" select="@href" as="xs:string"/>
        <xsl:for-each select="document($termEntryTopic, .)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'preferred')]">
            <xsl:variable name="preferredTerm" select="normalize-space(.)"/>
            <xsl:for-each select="($currentTermrefNode/preceding-sibling::*[contains(@class, 'termmap/termref')]) | ($currentTermrefNode/following-sibling::*[contains(@class, 'termmap/termref')])">
                <xsl:variable name="comparedTermEntryTopic" select="@href" as="xs:string"/>
                <xsl:for-each select="document($comparedTermEntryTopic,.)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'notRecommended')]">
                    <xsl:variable name="notRecommendedTerm" select="normalize-space(.)"/>
                    <xsl:if test="$termEntryTopic != $comparedTermEntryTopic">
                        <xsl:if test="not($preferredTerm != $notRecommendedTerm)">
                            <xsl:element name="termconflict">
                                <xsl:element name="termnotation"><xsl:value-of select="$preferredTerm"/></xsl:element>
                                <xsl:element name="preferredTermFile"><xsl:value-of select="$termEntryTopic"/></xsl:element>
                                <xsl:element name="notRecommendedTermFile"><xsl:value-of select="$comparedTermEntryTopic"/></xsl:element>
                            </xsl:element>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <!-- Empty fall through templates -->
    <xsl:template match="*[contains(@class, ' map/topicref ') and (contains(@type, 'termstats') or contains(@type, 'semanticnet'))]" mode="termconflict"/>
    <xsl:template match="*[contains(@class, ' subjectScheme/subjectHead ')]" mode="termconflict"/>
    <xsl:template match="*[contains(@class, ' subjectScheme/hasInstance ')]" mode="termconflict"/>

    <xsl:template name="report">
        <xsl:param name="termCollection"/>
        <xsl:element name="report">
            <xsl:attribute name="date" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
            <!--<xsl:variable name="termCollection" select="collection(concat($temp.dir.abs, '/?select=*.dita'))"/>-->
            <xsl:element name="numberOfTermTopics">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termentry')])"/>
            </xsl:element>
            <xsl:element name="numberOfLanguages">
                <xsl:value-of select="count(distinct-values($termCollection//*[contains(@class, 'termentry/termNotation')][@language]/@language))"/>
            </xsl:element>
            <xsl:element name="numberOfPreferredTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='preferred'])"/>
            </xsl:element>
            <xsl:element name="numberOfAdmittedTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='admitted'])"/>
            </xsl:element>
            <xsl:element name="numberOfNotRecommendedTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='notRecommended'])"/>
            </xsl:element>
            <xsl:element name="numberOfObsoleteTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='obsolete'])"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- Fall Through Templates -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]"/>
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]"/>
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]"/>
    <xsl:template match="*[contains(@class, ' bookmap/mainbooktitle ')]"/>

</xsl:stylesheet>
