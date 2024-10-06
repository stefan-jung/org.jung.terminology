<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs">
    
    <!-- Calculate MultiTerm language code from language code -->
    <xsl:function name="sj:language-code" as="xs:string">
        <xsl:param name="language-code" as="xs:string"/>
        <xsl:sequence select="
            if      ($language-code = 'ar-AE') then 'AR-AE'
            else if ($language-code = 'ar-EG') then 'AR-EG'
            else if ($language-code = 'bg-BG') then 'BG-BG'
            else if ($language-code = 'cs-CZ') then 'CS-CZ'
            else if ($language-code = 'da-DK') then 'DA-DK'
            else if ($language-code = 'de-DE') then 'DE-DE'
            else if ($language-code = 'el-GR') then 'EL-GR'
            else if ($language-code = 'en-AU') then 'EN-AU'
            else if ($language-code = 'en-GB') then 'EN-GB'
            else if ($language-code = 'en-US') then 'EN-US'
            else if ($language-code = 'es-ES') then 'ES-ES'
            else if ($language-code = 'es-MX') then 'ES-MX'
            else if ($language-code = 'et-EE') then 'ET-EE'
            else if ($language-code = 'fi-FI') then 'FI-FI'
            else if ($language-code = 'fr-CA') then 'FR-CA'
            else if ($language-code = 'fr-FR') then 'FR-FR'
            else if ($language-code = 'he-IL') then 'IW-IL' (: Deviation :)
            else if ($language-code = 'hr-HR') then 'SH-HR' (: Deviation :)
            else if ($language-code = 'hu-HU') then 'HU-HU'
            else if ($language-code = 'id-ID') then 'ID-ID'
            else if ($language-code = 'is-IS') then 'IS-IS'
            else if ($language-code = 'it-IT') then 'IT-IT'
            else if ($language-code = 'ja-JP') then 'JA-JP'
            else if ($language-code = 'ka-GE') then 'KA-GE'
            else if ($language-code = 'ko-KR') then 'KO-KR'
            else if ($language-code = 'lt-LT') then 'LT-LT'
            else if ($language-code = 'lv-LV') then 'LV-LV'
            else if ($language-code = 'mk-MK') then 'MK-MK'
            else if ($language-code = 'ms-MY') then 'MS-MY'
            else if ($language-code = 'nb-NO') then 'NO-NO' (: Deviation :)
            else if ($language-code = 'nl-NL') then 'NL-NL'
            else if ($language-code = 'pl-PL') then 'PL-PL'
            else if ($language-code = 'pt-BR') then 'PT-BR'
            else if ($language-code = 'pt-PT') then 'PT-PT'
            else if ($language-code = 'ro-RO') then 'RO-RO'
            else if ($language-code = 'ru-RU') then 'RU-RU'
            else if ($language-code = 'sk-SK') then 'SK-SK'
            else if ($language-code = 'sl-SI') then 'SL-SI'
            else if ($language-code = 'sr-RS') then 'SH-SR' (: Deviation :)
            else if ($language-code = 'sv-SE') then 'SV-SE'
            else if ($language-code = 'th-TH') then 'TH-TH'
            else if ($language-code = 'tr-TR') then 'TR-TR'
            else if ($language-code = 'uk-UA') then 'UK-UA'
            else if ($language-code = 'vi-VN') then 'VI-VN'
            else if ($language-code = 'zh-CN') then 'ZH-CN'
            else if ($language-code = 'zh-TW') then 'ZH-TW'
            else 'UNDEFINED'
            "/>
    </xsl:function>
    
</xsl:stylesheet>