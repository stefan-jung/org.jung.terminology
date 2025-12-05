<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:param name="debugging" as="xs:string"/>
    <xsl:param name="termharvested.file" as="xs:string"/>
    
    <xsl:variable name="harvested-file" select="document($termharvested.file)"/>    
    <!-- Change this to match your directory of termentry topics -->
    <!--<xsl:variable name="all-entries" select="collection('file:///path/to/termentry/topics?select=*.dita')"/>-->
    
    <xsl:template match="termentry">
        <xsl:value-of select="$termharvested.file"/>
        <!--<xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
            
            <!-\- Gather all fullForm values from all topics -\->
            <xsl:variable name="all-fullForms"
                select="$all-entries/termentry/fullForm"/>
            
            <!-\- Gather fullForm values in current topic -\->
            <xsl:variable name="current-fullForms"
                select="fullForm"/>
            
            <!-\- Add missing fullForm elements -\->
            <xsl:for-each select="$all-fullForms">
                <xsl:variable name="thisForm" select="normalize-space(.)"/>
                <xsl:if test="not($current-fullForms[normalize-space(.) = $thisForm])">
                    <xsl:copy-of select="."/>
                </xsl:if>
            </xsl:for-each>
        </xsl:copy>-->
    </xsl:template>
    
</xsl:stylesheet>
