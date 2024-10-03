<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:function name="sj:capitalize-first">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="
            if (string-length($input) > 0) 
            then upper-case(substring($input, 1, 1)) || substring($input, 2)
            else $input"/>
    </xsl:function>
    
</xsl:stylesheet>
