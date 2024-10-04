<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:function name="sj:remove-entity-from-filename">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="replace($input, '%20', ' ')"/>
    </xsl:function>
    
</xsl:stylesheet>