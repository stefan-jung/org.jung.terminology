<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">

    <xsl:function name="sj:find-string">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="search-string" as="xs:string"/>
        <xsl:variable name="result" select="$xliff//xliff:source[normalize-space(.) = normalize-space($search-string)]"/>
        <xsl:sequence select="
            if ($result[. = $search-string])
            then array{$result/ancestor::xliff:xliff/@trgLang, $result/ancestor::xliff:file/@original, $result/ancestor::xliff:unit/@id}
            else ()
            "/>
    </xsl:function>
    
</xsl:stylesheet>
