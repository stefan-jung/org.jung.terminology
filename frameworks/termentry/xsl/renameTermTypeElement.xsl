<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs">
    
    
    <!-- Name of the new element -->
    <xsl:param name="new-element" as="xs:string"/>
    
    <!-- Identity template -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@class"/>
    <xsl:template match="processing-instruction()"/>
    
    <!-- Renaming template -->
    <xsl:template match="abbreviation | acronym | fullForm | verb">
        <xsl:element name="{$new-element}">
            <xsl:apply-templates select="@* | node()" />
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>