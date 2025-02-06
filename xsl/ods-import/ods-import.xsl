<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    exclude-result-prefixes="ditaarch dita-ot xs math table text">

    <xsl:output method="xml" indent="yes" exclude-result-prefixes="#all"/>
    <xsl:mode on-no-match="shallow-copy" exclude-result-prefixes="#all"/>
    
    <xsl:param name="debugging" as="xs:string"/>
    <xsl:param name="content.xml" as="xs:string"/>
    <xsl:param name="language" as="xs:string"/>
    <xsl:param name="import" as="xs:string"/>
    
    <xsl:variable name="doc" select="document($content.xml)" as="document-node()"/>
    <xsl:variable name="termentry-id" select="/termentry/@id" as="xs:string"/>
    <xsl:variable name="term" select="$doc//table:table-row[table:table-cell[1]/text:p[contains(text(), $termentry-id)]][table:table-cell[5]/text:p[contains(text(), $language)]]/table:table-cell[6]/text:p/text()"/>

    <xsl:template match="/termentry" expand-text="yes">
        <xsl:processing-instruction name="xml-model">href="urn:jung:dita:rng:termentry.rng" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model">href="urn:jung:dita:rng:termentry.rng" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
        <termentry id="{@id}">
            <xsl:apply-templates/>
        </termentry>
    </xsl:template>
    
    <xsl:template match="fullForm[@language = $language]">
        <xsl:choose>
            <!-- Flush away all elements in this language if import = "replace". -->
            <xsl:when test="$import = 'replace'"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="fullForm[last()]" expand-text="yes">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
        <xsl:if test="$term != ''">
            <xsl:for-each select="$doc//table:table-row[table:table-cell[1]/text:p[contains(text(), $termentry-id)]][table:table-cell[5]/text:p[contains(text(), $language)]]/table:table-cell[6]/text:p/text()">
                <xsl:if test="$debugging = 'true'">
                    <xsl:message select="'+ [DEBUG]: Import term ''' || . || ''' (' || $language || ')'"/>
                </xsl:if>
                <fullForm usage="preferred" language="{$language}">
                    <termVariant xml:lang="{$language}" case="nominative" number="singular">{normalize-space(.)}</termVariant>
                </fullForm>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <!-- Ignore unwanted processing-instructions and attributes -->
    <xsl:template match="processing-instruction() | @class | @xtrf | @xtrc | @ditaarch:DITAArchVersion | @domains | @specializations | @dita-ot | @ditaarch:*" exclude-result-prefixes="#all"/>
    
</xsl:stylesheet>