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
        <xsl:element name="span">
            <xsl:attribute name="class">label label-default</xsl:attribute>
            <xsl:choose>
                <xsl:when test="$language = 'af-ZA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-za</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-AE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ae</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-BH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-bh</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-DZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-dz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-EG'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-eg</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-IQ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-iq</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-JO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-jo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-KW'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-kw</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-LB'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-lb</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-LY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ly</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-MA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ma</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-OM'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-om</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-QA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-qa</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-SA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sa</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-SY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sy</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-TN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-tn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-YE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ye</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'be-BY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-by</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'bg-BG'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-bg</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ca-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'cs-CZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Cy-az-AZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-az</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Cy-sr-SP'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Cy-uz-UZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-uz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'da-DK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-dk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-AT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-at</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ch</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-DE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-de</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-LI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-li</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-LU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-lu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'div-MV'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'el-GR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-gr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-AU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-au</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-BZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-bz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-CA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ca</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-CB'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cb</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-GB'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-gb</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-IE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ie</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-JM'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-jm</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-NZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-nz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-PH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ph</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-TT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-tt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-US'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-um</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-ZA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-za</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-ZW'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-zw</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-AR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ar</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-BO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-bo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-CL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-CO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-co</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-CR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-DO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-do</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-EC'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ec</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-GT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-gt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-HN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-hn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-MX'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mx</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-NI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ni</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-pa</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-pe</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-pr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-py</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-SV'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-UY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-uy</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-VE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ve</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'et-EE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ee</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'eu-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fa-IR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ir</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fi-FI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-fi</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fo-FO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-fo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-BE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-be</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-CA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ca</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ch</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-FR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-fr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-LU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-lu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-MC'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mc</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'gl-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'gu-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'he-IL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-il</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hi-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hr-HR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-hr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hu-HU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-hu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hy-AM'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-am</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'id-ID'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-id</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'is-IS'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-is</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'it-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ch</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'it-IT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-it</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ja-JP'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-jp</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ka-GE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ge</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'kk-KZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-kz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'kn-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ko-KR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-kr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'kok-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ky-KZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-kz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'lt-LT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-lt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Lt-az-AZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-az</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Lt-sr-SP'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Lt-uz-UZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-uz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'lv-LV'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-lv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mk-MK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mn-MN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mr-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ms-BN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-bn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ms-MY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-my</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nb-NO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-no</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nl-BE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-nl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nl-NL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-nl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nn-NO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-no</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pa-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pl-PL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-pl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pt-BR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-br</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pt-PT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-pt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ro-MO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ro-RO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ro</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ru-MO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ru-RU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ru</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sa-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sk-SK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sl-SI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-si</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sq-AL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-al</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv-FI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-fi</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv-SE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-se</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sw-KE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ke</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'syr-SY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sy</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ta-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'te-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'th-TH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-th</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'tr-TR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-tr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'tt-RU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ru</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'uk-UA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-ua</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ur-PK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-pk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'vi-VN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-vn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-CHS'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-CHT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-CN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-HK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-hk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-MO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-mo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-SG'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-sg</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-TW'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">fi fi-tw</xsl:attribute>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="$languageCode">
                <xsl:text> </xsl:text>
                <xsl:value-of select="$language"/>
            </xsl:if>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>