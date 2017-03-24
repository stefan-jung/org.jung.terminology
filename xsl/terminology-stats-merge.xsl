<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="old.termstats"/>
    <xsl:param name="new.termstats"/>

    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <xsl:template match="/">
        <termstats>
            <xsl:value-of select="$newline"/>
            <xsl:comment>new termconflicts</xsl:comment>
            <xsl:value-of select="$newline"/>
            <xsl:copy>
                <xsl:copy-of select="document($new.termstats)/termstats/termconflicts"/>
            </xsl:copy>
            <reports>
                <xsl:value-of select="$newline"/>
                <xsl:comment>old reports</xsl:comment>
                <xsl:value-of select="$newline"/>
                <xsl:for-each select="document($old.termstats)/termstats/reports/report">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
                <xsl:comment>new report</xsl:comment>
                <xsl:value-of select="$newline"/>
                <xsl:copy-of select="document($new.termstats)/termstats/reports/report"/>
            </reports>
        </termstats>
    </xsl:template>

</xsl:stylesheet>
