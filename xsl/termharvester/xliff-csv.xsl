<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:param name="term" as="xs:string"/>
    <xsl:param name="file" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    
    <xsl:variable name="tab" as="xs:string" select="'&#x9;'"/>
    
    <!-- XLIFF csv -->
    <xsl:template name="xliff-csv">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:param name="term" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:apply-templates mode="xliff-csv">
            <xsl:with-param name="xliff" select="$xliff"/>
            <xsl:with-param name="file" select="$file"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="xliff:source[lower-case(normalize-space(.)) = lower-case(normalize-space($term))]" mode="xliff-csv">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        
        <xsl:variable name="trgLang" select="/*[1]/@trgLang"/>
        <xsl:variable name="target" as="xs:string" select="
            if (contains($trgLang, 'de'))
            then normalize-space(following-sibling::xliff:target[1])
            else lower-case(normalize-space(following-sibling::xliff:target[1]))
            "/>
            
        <xsl:message select="'[xliff-csv] ' || $trgLang || ' = ' || $target || ' (' || sj:remove-entity-from-filename($file) || ')'"/>
        <xsl:sequence select="$trgLang || $tab || $target || $tab || sj:remove-entity-from-filename($file) || '&#13;'"/>
    </xsl:template>
    
</xsl:stylesheet>