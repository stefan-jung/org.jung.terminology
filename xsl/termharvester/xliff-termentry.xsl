<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
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
    
    <xsl:template match="xliff:source[normalize-space(.) = normalize-space($term)]" mode="xliff-termentry">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        
        <xsl:variable name="target" select="normalize-space(following-sibling::xliff:target[1])" as="xs:string"/>
        <xsl:variable name="trgLang" select="/*[1]/@trgLang"/>
        <xsl:variable name="result" select="$trgLang || ' = ' || $target"/>
        
        <fullForm language="{$trgLang}" usage="preferred">
            <termVariant xml:lang="{$trgLang}"><xsl:value-of select="$target"/></termVariant>
            <termSource>
                <sourceName><xsl:value-of select="sj:remove-entity-from-filename($file)"/></sourceName>
            </termSource>
        </fullForm>
        
    </xsl:template>
    
</xsl:stylesheet>