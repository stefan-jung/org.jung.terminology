<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:param name="debugging.mode" as="xs:string"/>
    <xsl:param name="file" as="xs:string" select="''"/>
    <xsl:param name="source.language" as="xs:string"/>
    <xsl:param name="term" as="xs:string"/>
    
    <!-- XLIFF txt -->
    <xsl:template name="xliff-txt">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:param name="term" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:apply-templates mode="xliff-txt">
            <xsl:with-param name="xliff" select="$xliff"/>
            <xsl:with-param name="file" select="$file"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="xliff:source[lower-case(normalize-space(.)) = lower-case(normalize-space($term))]" mode="xliff-txt">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        
        <xsl:variable name="filename" select="sj:remove-entity-from-filename($file)"/>
        <xsl:variable name="target" select="normalize-space(following-sibling::xliff:target[1])" as="xs:string"/>
        <xsl:variable name="trgLang" select="/*[1]/@trgLang"/>
        
        <xsl:message select="'[xliff-txt] ' || $trgLang || ' = ' || $target || ' (' || $filename || ')'"/>
        <xsl:sequence select="$trgLang || ' = ' || $target || ' (' || $filename || ')&#13;'"/>
    </xsl:template>
    
</xsl:stylesheet>