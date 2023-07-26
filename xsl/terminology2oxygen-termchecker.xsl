<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xd xs">
    
    <xsl:output indent="true" encoding="UTF-8"/>
    <xsl:param name="dita.temp.dir.url" as="xs:anyURI"/>
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    
    <!--<?xml version="1.0" encoding="UTF-8"?>
    <incorrect-terms>
        <incorrect-term ignorecase="true">
            <match type="whole-word">match this</match>
            <suggestion format="text">replace with this</suggestion>
            <message>present as tooltip message</message>
            <link>https://www.example.com</link>
        </incorrect-term>
    </incorrect-terms>-->
    
    <xsl:template match="/">
        <incorrect-terms>
            <xsl:apply-templates mode="termref"/>
        </incorrect-terms>
    </xsl:template>
    
    <xsl:template match="termref[@href][@keys]" mode="termref">
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)" as="xs:anyURI"/>
        <xsl:apply-templates select="document($t)" mode="termentry"/>
    </xsl:template>
    
    <xsl:template match="termentry" mode="termentry">
        <incorrect-term>HELLO</incorrect-term>
    </xsl:template>
    
    
</xsl:stylesheet>
