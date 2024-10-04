<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:param name="debugging.mode" as="xs:string"/>
    <xsl:param name="file" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    <xsl:param name="term" as="xs:string"/>
    
    <!-- TMX txt -->
    <xsl:template name="tmx-txt">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:param name="term" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:apply-templates mode="tmx-txt">
            <xsl:with-param name="tmx" select="$tmx"/>
            <xsl:with-param name="file" select="$file"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="tmx-txt">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:variable name="results">
            <xsl:for-each select="$tu[1]/tuv">
                <xsl:if test="./@xml:lang != $source.language">
                    <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || ' (' || sj:remove-entity-from-filename($file) || ')' || '&#xa;'"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'[DEBUG] ' || $results"/>
        </xsl:if>
        <xsl:sequence select="$results"/>
    </xsl:template>
</xsl:stylesheet>