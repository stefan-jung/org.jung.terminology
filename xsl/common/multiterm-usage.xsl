<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs">
    
    <!-- 
        This function maps the org.jung.terminology usage values
        to the MultiTerm usage values.
    -->
    <xsl:function name="sj:usage" as="xs:string">
        <xsl:param name="usage" as="xs:string"/>
        <xsl:sequence select="
            if ($usage = 'admitted') then 'allowed'
            else if ($usage = 'notRecommended') then 'not recommended'
            else if ($usage = 'obsolete') then 'obsolete'
            else if ($usage = 'preferred') then 'recommended'
            else if ($usage = 'toBeDiscussed') then 'to be discussed'
            else $usage || ' UNDEFINED'
            "/>
    </xsl:function>
    
</xsl:stylesheet>