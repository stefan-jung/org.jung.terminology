<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="sj xs xd">
    
    <!-- ****************************************************************************** -->
    <!--                                   FUNCTIONS                                    -->
    <!-- ****************************************************************************** -->
    
    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getString" as="xs:string" visibility="public">
        <xsl:param name="language"/>
        <xsl:param name="string"/>
        <xsl:variable name="file" select="concat(concat('termbrowser-strings-', $language), '.xml')"/>
        <xsl:sequence select="document($file)/descendant::str[@name = $string][1]"/>
    </xsl:function>
    
</xsl:stylesheet>