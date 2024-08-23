<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <!--
        This function creates a "span" element representing a country flag.
        The function is using https://github.com/lipis/flag-icons
        
        Usually this should be: ISO-639-1 Language Code + "-" + ISO-3166 Country Code,
        as explained in https://tools.ietf.org/html/bcp47
        
        Good resources are:
        
        - https://msdn.microsoft.com/de-de/library/ee825488(v=cs.20).aspx
        - https://www.andiamo.co.uk/resources/iso-language-codes
        - https://datahub.io/core/language-codes, section ietf-language-tags
        - https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html
        
        A good resource for language names is http://id.loc.gov/vocabulary/iso639-1.html
        
        Parameters
        - language     Language
        - languageCode Language code
        - string       The string to be processed.
    -->
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