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
    
    <xsl:param name="debugging.mode" as="xs:string"/>
    
    <!-- Languge code of the main terms. -->
    <xsl:param name="main.language" as="xs:string" select="'en-US'"/>
    
    <!-- Language code of the terms to be exported. Unless set, all languages are exported. -->
    <xsl:param name="term.language" as="xs:string" select="'all'"/>
    
    <!-- Terms to be exported. Possible values are: "existing", "missing", "both" -->
    <xsl:param name="export" as="xs:string" select="'both'"/>
    
    <xsl:template match="*[(self::termref) and @href]">
        <xsl:variable name="docPath" select="resolve-uri(@href, base-uri())"/>
        <xsl:variable name="doc" select="document($docPath)"/>
        <xsl:if test="$doc">
            <xsl:apply-templates select="$doc/*"/>
        </xsl:if>
    </xsl:template>
    
    <!--
        If the we don't have any terms in the target language and export = "all" or export = "missing",
        then create a table row and fill the cells with concept-level data.
    -->
    <xsl:template match="termBody" expand-text="yes">
        <xsl:variable name="mainTerm" as="xs:string" select="ancestor::termentry/title/text()"/>
        <xsl:variable name="termsInLanguage" as="xs:integer" select="count(//fullForm[@language = $term.language])"/>
        
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'+ [DEBUG] ********************************************************************************'"/>
            <xsl:message select="'+ [DEBUG] mainTerm = ' || $mainTerm"/>
            <xsl:message select="'+ [DEBUG] termsInLanguage = ' || $termsInLanguage"/>
        </xsl:if>
        
        <xsl:if test="$termsInLanguage = 0 and ($export = 'both' or $export = 'missing')">
            <table:table-row table:style-name="ro1">
                
                <!-- Concept ID -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/@id}</text:p>
                </table:table-cell>
                
                <!-- Main Term -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{$mainTerm}</text:p>
                </table:table-cell>
                
                <!-- Definition Text -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/definition/definitionText/text()}</text:p>
                </table:table-cell>
                
                <!-- Definition Source -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/definition/definitionSource/text()}</text:p>
                </table:table-cell>
                
                <!-- Language Code -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{$term.language}</text:p>
                </table:table-cell>
                
                <!-- Term -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p></text:p>
                </table:table-cell>
                
                <!-- Usage -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>preferred</text:p>
                </table:table-cell>
                
                <!-- Source of Term -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p></text:p>
                </table:table-cell>
                
                <!-- Context -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p></text:p>
                </table:table-cell>
                
                <!-- Source of Context -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p></text:p>
                </table:table-cell>
                
                <table:table-cell table:number-columns-repeated="16374"/>
            </table:table-row> 
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="fullForm[@language]" expand-text="yes">
        <xsl:variable name="mainTerm" as="xs:string" select="ancestor::termentry/title/text()"/>
        <xsl:variable name="processTerm" as="xs:boolean" select="
            if (@language = $term.language and ($export = 'both' or $export = 'existing')) then true()
            else false()
            "/>
        
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'+ [DEBUG] ********************************************************************************'"/>
            <xsl:message select="'+ [DEBUG] mainTerm = ' || $mainTerm"/>
            <xsl:message select="'+ [DEBUG] processTerm = ' || $processTerm"/>
        </xsl:if>
        
        <xsl:if test="$processTerm">
            <table:table-row table:style-name="ro1">
                
                <!-- Concept ID -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/@id}</text:p>
                </table:table-cell>
                
                <!-- Main Term -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{$mainTerm}</text:p>
                </table:table-cell>
                
                <!-- Definition Text -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/definition/definitionText/text()}</text:p>
                </table:table-cell>
                
                <!-- Definition Source -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{ancestor::termentry/definition/definitionSource/text()}</text:p>
                </table:table-cell>
                
                <!-- Language Code -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{if (($export = 'both' or $export = 'missing') and @language != $term.language)
                        then $term.language
                        else @language}</text:p>
                </table:table-cell>
                
                <!-- Term -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termVariant/text()}</text:p>
                </table:table-cell>
                
                <!-- Usage -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{@usage}</text:p>
                </table:table-cell>
                
                <!-- Source of Term -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termSource/sourceName/text()}</text:p>
                </table:table-cell>
                
                <!-- Context -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termContext/termContextText/text()}</text:p>
                </table:table-cell>
                
                <!-- Source of Context -->
                <table:table-cell office:value-type="string" table:style-name="ce1">
                    <text:p>{termContext/termContextSource/sourceName/text()}</text:p>
                </table:table-cell>
                
                <table:table-cell table:number-columns-repeated="16374"/>
            </table:table-row> 
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>