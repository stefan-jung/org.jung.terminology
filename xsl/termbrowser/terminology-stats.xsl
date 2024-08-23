<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="sj xd xs">
    
    <!--
        This stylesheet is not part of the normal DITA-OT processing.
        It iterates over all temporary DITA files and outputs an XML
        file containing numbers of the terminology topics 
        (e.g. number of terms by status).
        
        The XML file is (optionally) merged with previous statistics
        by the terminology-stats-merge-xml.xsl stylesheet.
    -->
    <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="temp.dir"/>
    <xsl:param name="termMap"/>
    <xsl:param name="language"/>
    <xsl:param name="temp.dir.abs"/>
    <xsl:param name="ditamap.filename"/>

    <xsl:variable name="newline" select="'&#xd;'" as="xs:string"/>
    
    <xsl:template match="/" priority="1">
        <xsl:variable name="termCollection" select="collection($temp.dir.abs || '/?select=*.dita;recurse=yes')"/>
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
    <!--<xsl:template match="*[contains(@class, ' map/topicref ') and (contains(@type, 'termstats') or contains(@type, 'semanticnet'))]" mode="termconflict"/>
    <xsl:template match="*[contains(@class, ' subjectScheme/subjectHead ')]" mode="termconflict"/>
    <xsl:template match="*[contains(@class, ' subjectScheme/hasInstance ')]" mode="termconflict"/>-->
    <xsl:template match="*" mode="termconflict"/>

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
