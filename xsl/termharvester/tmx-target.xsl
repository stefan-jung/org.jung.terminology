<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:mode name="tmx-tuv" on-no-match="shallow-skip"/>
    
    <xsl:function name="sj:tmx-target-text">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="search-string" as="xs:string"/>
        <xsl:param name="source.language" as="xs:string"/>
        <xsl:variable name="result" select="$tmx//seg[normalize-space(.) = normalize-space($search-string)]"/>
        
        <!-- Determine the <tu> of the matching result. -->
        <xsl:variable name="tu" select="$result/ancestor::tu[1]" as="node()"/>
        
        <xsl:variable name="result">
            <!--<tuv xml:lang="en">
                <seg>Next</seg>
            </tuv>-->
            <xsl:for-each select="$tu/tuv">
                <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || '&#xa;'"/>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:sequence select="$result"/>
        
    </xsl:function>
    
</xsl:stylesheet>
