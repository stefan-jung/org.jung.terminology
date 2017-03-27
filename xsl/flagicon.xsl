<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
    
    <xsl:template name="getFlag">
        <xsl:param name="language" as="xs:string"/>
        <xsl:param name="languageCode" as="xs:boolean"/>
        <xsl:element name="span">
            <xsl:attribute name="class">label label-default</xsl:attribute>
            <xsl:choose>
                <xsl:when test="$language = 'af'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-af</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ar'
                                or $language = 'ar-AE'
                                or $language = 'ar-BH'
                                or $language = 'ar-DZ'
                                or $language = 'ar-EG'
                                or $language = 'ar-IQ'
                                or $language = 'ar-JO'
                                or $language = 'ar-KW'
                                or $language = 'ar-LB'
                                or $language = 'ar-LY'
                                or $language = 'ar-MA'
                                or $language = 'ar-OM'
                                or $language = 'ar-QA'
                                or $language = 'ar-SA'
                                or $language = 'ar-SY'
                                or $language = 'ar-TN'
                                or $language = 'ar-YE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ar</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'be'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-be</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'bg'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-bg</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ca'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ca</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'cs'
                                or $language = 'cs-CZ'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cz</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'da'
                                or $language = 'da-DK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-dk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
              <xsl:when test="$language = 'de-AT'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-at</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de'
                                or $language = 'de-DE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-de</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'de-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ch</xsl:attribute>
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
                <xsl:when test="$language = 'el'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-el</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'en'
                                or $language = 'en-GB'">
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
                <xsl:when test="$language = 'es'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-es</xsl:attribute>
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
                <xsl:when test="$language = 'es-VE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ve</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'et'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'et'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'et'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fa'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ir</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fi'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fi</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fo'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fo</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr'
                                or $language = 'fr-FR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-fr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-BE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-be</xsl:attribute>
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
                <xsl:when test="$language = 'fr-LU'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'fr-GA'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ga</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ga'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ga</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'gd'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-gd</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'he'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-il</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hi'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hr'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ir</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'hu'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-hu</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'id'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-id</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'is'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-is</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'it'
                                or $language = 'it-CH'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-it</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ja'
                                or $language = 'ja'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ja</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ko'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-kr</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'lt'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'lv'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-lv</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mk'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ms'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-my</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'mt'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-mt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'nl'
                                or $language = 'nl-BE'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-nl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'no'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-no</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pl'
                                or $language = 'pl-PL'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pt'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-pt</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'pt-BR'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-br</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ro'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ro</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ru'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ru</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'ru'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ru</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sk'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sk</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sl'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-sl</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sq'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-al</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sr'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-rs</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv'
                                or $language = 'sv-FI'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'sv'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'th'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-th</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'uk'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-ua</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'vi'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-vn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh'
                                or $language = 'zh-CN'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-cn</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$language = 'zh-HK'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">flag-icon flag-icon-hk</xsl:attribute>
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