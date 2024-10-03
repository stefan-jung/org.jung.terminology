<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:function name="sj:path-to-url" as="xs:string">
        <xsl:param name="filePath" as="xs:string"/>
        
        <!-- Convert backslashes to forward slashes (for Windows paths) -->
        <xsl:variable name="normalizedPath" select="replace($filePath, '\\', '/')"/>
        
        <!-- Prepend 'file:///' to the path to form a URL -->
        <xsl:sequence select="resolve-uri(concat('file:///', $normalizedPath))"/>
    </xsl:function>
    
    
</xsl:stylesheet>