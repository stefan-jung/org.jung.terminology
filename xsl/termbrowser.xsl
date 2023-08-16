<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="related-links sj xd xs">
    
    <xsl:include href="flagicon.xsl"/>
    <xsl:include href="termbrowser-utility.xsl"/>
    <xsl:include href="termentry.xsl"/>
    <xsl:include href="semantic-net.xsl"/>
    <xsl:include href="termstats.xsl"/>
    
    <xsl:param name="temp.dir"/>
    <xsl:param name="language" select="'en-GB'"/>
    <xsl:param name="dita.temp.dir" as="xs:string"/>
    <xsl:param name="file.separator" select="'/'" as="xs:string"/>
    
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>
    
</xsl:stylesheet>
