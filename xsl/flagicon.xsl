<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd">
    
    <xd:doc>
        <xd:p>Return the corresponding flag</xd:p>
        <xd:p>
            Usually this should be: <xd:i>ISO-639-1 Language Code</xd:i> + "-" + <xd:i>ISO-3166 Country Code</xd:i>,
            as explained in https://tools.ietf.org/html/bcp47
        </xd:p>
        <xd:p>Good resources are:</xd:p>
        <xd:ul>
            <xd:li><xd:a>https://msdn.microsoft.com/de-de/library/ee825488(v=cs.20).aspx</xd:a></xd:li>
            <xd:li><xd:a>https://www.andiamo.co.uk/resources/iso-language-codes</xd:a></xd:li>
            <xd:li><xd:a>https://datahub.io/core/language-codes</xd:a>, section <xd:i>ietf-language-tags</xd:i></xd:li>
            <xd:li><xd:a>https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html</xd:a></xd:li>
        </xd:ul>
        <xd:p>A good resource for language names is <xd:a>http://id.loc.gov/vocabulary/iso639-1.html</xd:a>.</xd:p>
        <xd:param name="language">
            <xd:p>Boolean</xd:p>
        </xd:param>
        <xd:param name="languageCode">
            <xd:p>Language Code</xd:p>
        </xd:param>
        <xd:param type="string">The string to be processed.</xd:param>
    </xd:doc>
    <xsl:template name="getFlag">
        <xsl:param name="language" as="xs:string"/>
        <xsl:param name="languageCode" as="xs:boolean"/>
        <span class="label label-default fi fi-{lower-case(substring($language, string-length($language) - 1))}">
            <xsl:if test="$languageCode">
                <xsl:value-of select="' ' || $language"/>
            </xsl:if>
        </span>
    </xsl:template>

</xsl:stylesheet>