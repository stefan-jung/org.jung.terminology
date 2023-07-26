<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xd xs">
    
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:param name="dita.temp.dir.url" as="xs:anyURI"/>
   
    <xsl:template match="/">
        <xsl:variable name="termentry-topics" select="collection($dita.temp.dir.url || '?select=*.dita;recurse=yes')"/>
        <xsl:for-each select="distinct-values($termentry-topics//@language)">
            <xsl:value-of select="distinct-values(.) || ', '"/>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
