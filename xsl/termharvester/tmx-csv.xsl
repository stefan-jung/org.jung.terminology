<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:param name="debugging.mode" as="xs:string"/>
    <xsl:param name="file" as="xs:string"/>
    <xsl:param name="term" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    
    <xsl:variable name="tab" as="xs:string" select="'&#x9;'"/>
    
    <!-- TMX csv -->
    <xsl:template name="tmx-csv">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:param name="term" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:apply-templates mode="tmx-csv">
            <xsl:with-param name="tmx" select="$tmx"/>
            <xsl:with-param name="file" select="$file"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="tmx-csv">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                <xsl:value-of select="./@xml:lang || $tab || ./seg/text() || $tab || sj:remove-entity-from-filename($file) || $LF"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>