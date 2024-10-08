<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="sj xs">
    
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
    
    <xsl:template match="seg[lower-case(normalize-space(.)) = lower-case(normalize-space($term))]" mode="tmx-termentry" expand-text="yes">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:variable name="filename" select="sj:remove-entity-from-filename($file)"/>
        
        <xsl:variable name="results">
            <xsl:for-each select="$tu[1]/tuv">
                <xsl:variable name="trgLang" select="./@xml:lang" as="xs:string"/>
                <xsl:variable name="target" as="xs:string" select="
                    (: Nouns are capitalized only in German :)
                    if (contains($trgLang, 'de'))
                    then ./seg/text()
                    else lower-case(./seg/text())
                    "/>
                <xsl:if test="$trgLang != $source.language">
                    <fullForm language="{$trgLang}" usage="preferred">
                        <termVariant xml:lang="{$trgLang}"><xsl:value-of select="$target"/></termVariant>
                        <termSource>
                            <sourceName><xsl:value-of select="$filename"/></sourceName>
                        </termSource>
                    </fullForm>
                    <xsl:message select="'[tmx-termentry] ' || $trgLang || ' = ' || $target || ' (' || $filename || ')'"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:sequence select="$results"/>
        
    </xsl:template>
    
</xsl:stylesheet>