<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="@class"/>
    <xsl:template match="processing-instruction('xml-model')"/>
    
    <!-- Identity template to copy elements -->
    <xsl:template match="termBody">
        <termBody>
            <!-- Copy annotation and partOfSpeech as-is -->
            <xsl:copy-of select="annotation"/>
            <xsl:copy-of select="concept-domains"/>
            <xsl:copy-of select="partOfSpeech"/>
            
            <!-- Sort and output fullForm elements -->
            <xsl:for-each select="fullForm">
                <xsl:sort select="@language" data-type="text" order="ascending"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </termBody>
    </xsl:template>
    
    
</xsl:stylesheet>