<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:param name="debugging.mode" as="xs:string"/>
    <xsl:param name="file" as="xs:string"/>
    <xsl:param name="tmx" as="xs:string"/>
    <xsl:param name="term" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    
    <!-- TMX termentry -->
    <xsl:template name="tmx-termentry">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:param name="term" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:apply-templates mode="tmx-termentry">
            <xsl:with-param name="tmx" select="$tmx"/>
            <xsl:with-param name="file" select="$file"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="tmx-termentry" expand-text="yes">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        
        <xsl:variable name="results">
            <xsl:for-each select="$tu[1]/tuv">
                <xsl:if test="./@xml:lang != $source.language">
                    <fullForm language="{./@xml:lang}" usage="preferred">
                        <termVariant xml:lang="{./@xml:lang}"><xsl:value-of select="./seg/text()"/></termVariant>
                        <termSource>
                            <sourceName><xsl:value-of select="sj:remove-entity-from-filename($file)"/></sourceName>
                        </termSource>
                    </fullForm>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'[DEBUG] ' || $results"/>
        </xsl:if>
        
        <xsl:sequence select="$results"/>
        
    </xsl:template>
    
</xsl:stylesheet>