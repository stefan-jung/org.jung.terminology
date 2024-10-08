<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="sj xs">
    
    <xsl:param name="file" as="xs:string"/>
    <xsl:param name="term" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    
    <!-- XLIFF termentry -->
    <xsl:template name="xliff-termentry">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:param name="term" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:apply-templates mode="xliff-termentry">
            <xsl:with-param name="xliff" select="$xliff"/>
            <xsl:with-param name="file" select="$file"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="xliff:source[lower-case(normalize-space(.)) = lower-case(normalize-space($term))]" mode="xliff-termentry">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        
        <xsl:variable name="filename" select="sj:remove-entity-from-filename($file)"/>
        <xsl:variable name="trgLang" select="/*[1]/@trgLang"/>
        <xsl:variable name="target" as="xs:string" select="
            if (contains($trgLang, 'de'))
            then normalize-space(following-sibling::xliff:target[1])
            else lower-case(normalize-space(following-sibling::xliff:target[1]))
            "/>
        
        <xsl:message select="'[xliff-termentry] ' || $trgLang || ' = ' || $target || ' (' || $filename || ')'"/>
        
        <fullForm language="{$trgLang}" usage="preferred">
            <termVariant xml:lang="{$trgLang}"><xsl:value-of select="$target"/></termVariant>
            <termSource>
                <sourceName><xsl:value-of select="$filename"/></sourceName>
            </termSource>
        </fullForm>
        
    </xsl:template>
    
</xsl:stylesheet>