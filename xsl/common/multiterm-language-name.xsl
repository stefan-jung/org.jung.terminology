<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs">
    
    <!-- Calculate MultiTerm language name from language code -->
    <xsl:function name="sj:language-name" as="xs:string">
        <xsl:param name="language-code" as="xs:string"/>
        <xsl:sequence select="
            if      ($language-code = 'ar-AE') then 'Arabic (UAE)'
            else if ($language-code = 'ar-EG') then 'Arabic (Egypt)'
            else if ($language-code = 'bg-BG') then 'Bulgarian (Bulgaria)'
            else if ($language-code = 'cs-CZ') then 'Czech (Czech Republic)'
            else if ($language-code = 'da-DK') then 'Danish (Denmark)'
            else if ($language-code = 'de-DE') then 'German (Germany)'
            else if ($language-code = 'el-GR') then 'Greek (Greece)'
            else if ($language-code = 'en-AU') then 'English (Australia)'
            else if ($language-code = 'en-GB') then 'English (Great Britain)'
            else if ($language-code = 'en-US') then 'English (United States)'
            else if ($language-code = 'es-ES') then 'Spanish (Spain)'
            else if ($language-code = 'es-MX') then 'Spanish (Mexico)'
            else if ($language-code = 'et-EE') then 'Estonian (Estonia)'
            else if ($language-code = 'fi-FI') then 'Finnish (Finland)'
            else if ($language-code = 'fr-CA') then 'French (Canada)'
            else if ($language-code = 'fr-FR') then 'French (France)'
            else if ($language-code = 'he-IL') then 'Hebrew (Israel)'
            else if ($language-code = 'hr-HR') then 'Croatian (Croatia)'
            else if ($language-code = 'hu-HU') then 'Hungarian (Hungary)'
            else if ($language-code = 'id-ID') then 'Indonesian (Indonesia)'
            else if ($language-code = 'is-IS') then 'Icelandic (Iceland)'
            else if ($language-code = 'it-IT') then 'Italian (Italy)'
            else if ($language-code = 'ja-JP') then 'Japanese (Japan)'
            else if ($language-code = 'ka-GE') then 'Georgian (Georgia)'
            else if ($language-code = 'ko-KR') then 'Korean (Korea)'
            else if ($language-code = 'lt-LT') then 'Lithuanian (Lithuania)'
            else if ($language-code = 'lv-LV') then 'Latvian (Latvia)'
            else if ($language-code = 'mk-MK') then 'Macedonian (Macedonia)'
            else if ($language-code = 'ms-MY') then 'Malay (Malaysia)'
            else if ($language-code = 'nb-NO') then 'Norwegian (Bokmal, Norway)'
            else if ($language-code = 'nl-NL') then 'Dutch (Netherlands)'
            else if ($language-code = 'pl-PL') then 'Polish (Poland)'
            else if ($language-code = 'pt-BR') then 'Portuguese (Brazil)'
            else if ($language-code = 'pt-PT') then 'Portuguese (Portugal)'
            else if ($language-code = 'ro-RO') then 'Romanian (Romania)'
            else if ($language-code = 'ru-RU') then 'Russian (Russia)'
            else if ($language-code = 'sk-SK') then 'Slovak (Slovakia)'
            else if ($language-code = 'sl-SI') then 'Slovenian (Slovenia)'
            else if ($language-code = 'sr-RS') then 'Serbian (Latin)'
            else if ($language-code = 'sv-SE') then 'Swedish (Sweden)'
            else if ($language-code = 'th-TH') then 'Thai (Thailand)'
            else if ($language-code = 'tr-TR') then 'Turkish (Turkey)'
            else if ($language-code = 'uk-UA') then 'Ukrainian (Ukraine)'
            else if ($language-code = 'vi-VN') then 'Vietnamese (Vietnam)'
            else if ($language-code = 'zh-CN') then 'Chinese (Simplified, China)'
            else if ($language-code = 'zh-TW') then 'Chinese (Traditional, Taiwan)'
            else 'UNDEFINED'
            "/>
    </xsl:function>
    
</xsl:stylesheet>