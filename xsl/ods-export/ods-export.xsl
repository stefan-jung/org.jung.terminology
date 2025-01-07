<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    This stylesheet iterates over all <termentry> topics and generates an Excel .xlsx file from them.
    The Excel .xlsx file contains either all all terms in all languages or all terms of a specific language.
    
    The file can be validated with https://odfvalidator.org/
-->
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    exclude-result-prefixes="xs math">
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-skip"/>
    
    <xsl:import href="ods-root.xsl"/>
    
    <!-- Language to be exported. Unless set, all languages are exported. -->
    <xsl:param name="language" as="xs:string" select="'de-DE'"/>
    
    <xsl:template match="*[(self::termref) and @href]">
        <xsl:variable name="docPath" select="resolve-uri(@href, base-uri())"/>
        <xsl:variable name="doc" select="document($docPath)"/>
        <xsl:if test="$doc">
            <xsl:apply-templates select="$doc/*"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="fullForm[@language]" expand-text="yes">
        <xsl:variable name="processTerm" as="xs:boolean" select="
            if ($language = 'all') then true()
            else if ($language = @language) then true()
            else false()
            "/>
        <xsl:if test="$processTerm">
            <!--<term language="{@language}">{termVariant/text()}</term>-->
            <table:table-row table:style-name="ro1">
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/@id}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/title/text()}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/definition/defintionText/text()}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/definition/defintionSource/text()}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{@language}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termVariant/text()}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{@usage}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termSource/sourceName/text()}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termContext/termContextText/text()}</text:p>
                </table:table-cell>
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termContext/termContextSource/sourceName/text()}</text:p>
                </table:table-cell>
                <table:table-cell table:number-columns-repeated="16374"/>
            </table:table-row>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>