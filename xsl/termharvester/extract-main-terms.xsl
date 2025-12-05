<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:output method="text" indent="no"/>
    
    <xsl:mode on-no-match="shallow-skip"/>
    
    <xsl:param name="language" as="xs:string"/>

    <xsl:template match="/">
        <xsl:variable name="terms">
            <xsl:for-each select="//termref">
                <xsl:variable name="doc" select="document(@href)" as="document-node()"/>
                <xsl:value-of select="string-join($doc//fullForm[@usage = 'preferred'][@language = $language][1]/termVariant[1]/text()) || ','"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="'terms=' || $terms"/>
    </xsl:template>

</xsl:stylesheet>