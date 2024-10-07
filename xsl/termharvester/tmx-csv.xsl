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
    
    <xsl:template match="seg[lower-case(normalize-space(.)) = lower-case(normalize-space($term))]" mode="tmx-csv">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="file" as="xs:string"/>
        <xsl:variable name="filename" select="sj:remove-entity-from-filename($file)"/>
        
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                
                <xsl:variable name="trgLang" select="./@xml:lang" as="xs:string"/>
                <xsl:variable name="target" as="xs:string" select="
                    (: Nouns are capitalized only in German :)
                    if (contains($trgLang, 'de'))
                    then ./seg/text()
                    else lower-case(./seg/text())
                    "/>
                
                <xsl:sequence select="$trgLang || $tab || $target || $tab || $filename || $LF"/>
                <xsl:message select="'[tmx-csv] ' || $trgLang || ' = ' || $target || ' (' || $filename || ')'"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>