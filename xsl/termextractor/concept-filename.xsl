<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:function name="sj:concept-filename">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="'TRM_' || sj:camel-case($input) || '.dita'"/>
    </xsl:function>
    
</xsl:stylesheet>