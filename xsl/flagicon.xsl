<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd doctales"
    version="2.0">
    
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
                        <xsl:attribute name="class">flag-icon flag-icon-za</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-AE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ae</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-BH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-bh</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-DZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-dz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-EG'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-eg</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-IQ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-iq</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-JO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-jo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-KW'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-kw</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-LB'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lb</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-LY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ly</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-MA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ma</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-OM'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-om</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-QA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-qa</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-SA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sa</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-SY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sy</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-TN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-tn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar-YE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ye</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'cs-CZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'da-DK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-dk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-AT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-at</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ch</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-DE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-de</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-LI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-li</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-LU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'div-MV'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'el-GR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-gr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-AU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-au</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-BZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-bz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-CA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ca</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-CB'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cb</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-GB'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-gb</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-IE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ie</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-JM'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-jm</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-NZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-nz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-PH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ph</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-TT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-tt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-US'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-um</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-ZA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-za</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en-ZW'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-zw</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-AR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ar</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-BO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-bo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-CL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-CO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-co</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-CR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-DO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-do</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-EC'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ec</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-GT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-gt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-HN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-hn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-MX'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mx</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-NI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ni</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pa</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pe</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-PY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-py</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-SV'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-UY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-uy</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'es-VE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ve</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'et-EE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'eu-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fa-IR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ir</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fi-FI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fi</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fo-FO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-BE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-be</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-CA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ca</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ch</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-FR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-LU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-MC'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mc</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'gl-ES'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-es</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'gu-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'he-IL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-il</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hi-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hr-HR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-hr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hu-HU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-hu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hy-AM'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-am</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'id-ID'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-id</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'is-IS'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-is</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'it-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ch</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'it-IT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-it</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ja-JP'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ja</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ka-GE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ge</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'kk-KZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-kz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'kn-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ko-KR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-kr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'kok-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ky-KZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-kz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'lt-LT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Lt-az-AZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-az</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Lt-sr-SP'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sp</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'Lt-uz-UZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-uz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'lv-LV'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mk-MK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mn-MN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mr-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ms-BN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-bn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ms-MY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-my</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nb-NO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-no</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nl-BE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-nl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nl-NL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-nl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nn-NO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-no</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pa-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pl-PL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pt-BR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-br</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pt-PT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ro-MO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ro-RO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ro</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ru-MO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ru-RU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ru</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sa-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sk-SK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sl-SI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-si</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sq-AL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-al</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv-FI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fi</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv-SE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sw-KE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ke</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'syr-SY'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sy</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ta-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'te-IN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'th-TH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-th</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'tr-TR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-tr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'tt-RU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ru</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'uk-UA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ua</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ur-PK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'vi-VN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-vn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-CHS'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-CHT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-CN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-HK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-hk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-MO'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-SG'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sg</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-TW'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-tw</xsl:attribute>
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