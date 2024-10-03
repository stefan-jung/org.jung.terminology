<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:function name="sj:camel-case">
        <xsl:param name="input" as="xs:string"/>
        <!-- Split the string into words and capitalize each one -->
        <xsl:variable name="words" as="xs:string*" select="tokenize($input, '\s+')"/>
        <xsl:sequence select="string-join(for $word in $words return concat(upper-case(substring($word, 1, 1)), lower-case(substring($word, 2))), '')"/>
    </xsl:function>
    
</xsl:stylesheet>