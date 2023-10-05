<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="sj xs xd">
    
    <xsl:param name="debugging.mode" select="'true'" as="xs:string"/>
    
    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getTermbrowserString" as="xs:string" visibility="public">
        <xsl:param name="language"/>
        <xsl:param name="string"/>
        <xsl:sequence select="sj:getString('termbrowser', $language, $string)"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getTermcheckerString" as="xs:string" visibility="public">
        <xsl:param name="language"/>
        <xsl:param name="string"/>
        <xsl:sequence select="sj:getString('termchecker', $language, $string)"/>
    </xsl:function>

    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="output"><xd:p>"termbrowser" or "termchecker"</xd:p></xd:param>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getString" as="xs:string" visibility="public">
        <xsl:param name="output" as="xs:string"/>
        <xsl:param name="language" as="xs:string"/>
        <xsl:param name="string" as="xs:string"/>
        <xsl:variable name="file" select="'../../i18n/termchecker-strings-' || $language || '.xml'"/>
        <xsl:variable name="result" select="document($file)/descendant::str[@name = $string][1]"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'[DEBUG] sj:getString(' || $language || ', ' || $string || ') returns &quot;' || $result || '&quot; Read from file: ' || $file"/>
        </xsl:if>
        <xsl:sequence select="$result"/>
    </xsl:function>
    
</xsl:stylesheet>