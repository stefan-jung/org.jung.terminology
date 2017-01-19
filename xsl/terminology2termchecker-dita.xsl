<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:math="http://exslt.org/math" extension-element-prefixes="math"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs" version="2.0">
    
    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    
    <!-- Import the generic termchecker templates -->
    <xsl:import href="termchecker.xsl"/>
    
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <xsl:variable name="termentryId" select="@id"/>
        <xsl:variable name="languageCode" select="doctales:getLanguageCodeFromLanguageRegionCode($language)"/>
        <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]"/>
        <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended'][@language = $languageCode or @language = $language]">

            <!-- The context text() matches the text content of all nodes. -->
            <xsl:variable name="termLanguageRegionCode" select="normalize-space(@language)"/>
            <xsl:variable name="notRecommendedTerm" select="normalize-space(termVariant)"/>
            <xsl:variable name="isLowercased" select="doctales:isLowercased($notRecommendedTerm)"/>
            <xsl:variable name="sqfGroupName" select="doctales:generateId($notRecommendedTerm, 'sqfGroup', generate-id())"/>
            <xsl:variable name="sqfGroupName_up" select="concat($sqfGroupName, '_up')"/>
            <xsl:variable name="uppercased" select="concat(upper-case(substring($notRecommendedTerm,1,1)), substring($notRecommendedTerm, 2), ' '[not(last())])"/>
            
            <!-- 
                Create a report that will be reported if the tested topic: 
                - contains a notRecommended term
                - the xml:lang attribute of the tested topic has the same value as the language attribute of the notRecommended term
            -->
            <xsl:element name="sch:report">
                <xsl:attribute name="test">
                    <xsl:text>contains(/*/@xml:lang, '</xsl:text>
                    <xsl:value-of select="$termLanguageRegionCode"/>
                    <xsl:text>') and contains(., '</xsl:text>
                    <xsl:value-of select="$notRecommendedTerm"/>
                    <xsl:text>')</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="role">warning</xsl:attribute>
                <xsl:attribute name="sqf:fix" select="$sqfGroupName"/>
                <xsl:value-of select="doctales:getString($language, 'TheTerm')"/>
                <xsl:text> '</xsl:text>
                <xsl:value-of select="$notRecommendedTerm"/>
                <xsl:text>' </xsl:text>
                <xsl:value-of select="doctales:getString($language, 'IsNotAllowed')"/>
                <xsl:text>.</xsl:text>
            </xsl:element>

            <!-- If the not recommended term is lowercased, create a report with a capitalized initial letter -->
            <xsl:if test="doctales:isLowercased($notRecommendedTerm)">
                <xsl:element name="sch:report">
                    <xsl:attribute name="test">
                        <xsl:text>contains(/*/@xml:lang, '</xsl:text>
                        <xsl:value-of select="$termLanguageRegionCode"/>
                        <xsl:text>') and contains(., '</xsl:text>
                        <xsl:value-of select="$uppercased"/>
                        <xsl:text>')</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="role">warning</xsl:attribute>
                    <xsl:attribute name="sqf:fix" select="$sqfGroupName_up"/>
                    <xsl:value-of select="doctales:getString($language, 'TheTerm')"/>
                    <xsl:text> '</xsl:text>
                    <xsl:value-of select="$uppercased"/>
                    <xsl:text>' </xsl:text>
                    <xsl:value-of select="doctales:getString($language, 'IsNotAllowed')"/>
                    <xsl:text>.</xsl:text>
                </xsl:element>
            </xsl:if>

            <!-- Create a Schematron Quick Fix group that contains quick fixes for all allowed term variants -->
            <xsl:element name="sqf:group">
                <xsl:attribute name="id" select="$sqfGroupName"/>
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:call-template name="createSqfFix">
                                <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTerm"/>
                                <xsl:with-param name="uppercase" select="'false'"/>
                                <xsl:with-param name="beginning" select="'false'"/>
                                <xsl:with-param name="termLanguage" select="$termLanguageRegionCode"/>
                                <xsl:with-param name="definition" select="$definition"/>
                            </xsl:call-template>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
            
            <!-- Schematron Quick Fix Group for capizalized terms -->
            <xsl:if test="doctales:isLowercased($notRecommendedTerm)">
                <xsl:element name="sqf:group">
                    <xsl:attribute name="id" select="$sqfGroupName_up"/>
                    <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                        <xsl:choose>
                            <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                                <xsl:call-template name="createSqfFix">
                                    <xsl:with-param name="notRecommendedTerm" select="$uppercased"/>
                                    <xsl:with-param name="uppercase" select="'true'"/>
                                    <xsl:with-param name="beginning" select="'false'"/>
                                    <xsl:with-param name="termLanguage" select="$termLanguageRegionCode"/>
                                    <xsl:with-param name="definition" select="$definition"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Empty fall-through template for non-termentry topics -->
    <xsl:template match="*[contains(@class, ' topic/topic ')][not(contains(@class, ' termentry/termentry '))]"/>
    
</xsl:stylesheet>
