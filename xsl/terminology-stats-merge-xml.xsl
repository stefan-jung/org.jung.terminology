<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xd xs">
    
    <xd:doc>
        <xd:desc>
            This stylesheet is not part of the normal DITA-OT processing.
            It merges terminology statistics, which have originally been
            rendered with the terminology-stats.xsl stylesheet.
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="old.termstats" as="xs:anyURI"/>
    <xsl:param name="new.termstats" as="xs:anyURI"/>

    <xsl:variable name="newline" select="'&#xa;'"/>

    <xsl:template match="/">
        <termstats>
            <xsl:copy>
                <xsl:copy-of select="document($new.termstats)/termstats/currentStatistics"/>
            </xsl:copy>
            <chronologicalStatistics>
                <xsl:value-of select="$newline"/>
                <xsl:for-each select="document($old.termstats)/termstats/chronologicalStatistics/report">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
                <xsl:copy-of select="document($new.termstats)/termstats/chronologicalStatistics/report"/>
            </chronologicalStatistics>
        </termstats>
    </xsl:template>

</xsl:stylesheet>
