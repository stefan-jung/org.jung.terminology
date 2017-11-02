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
    
    <xsl:param name="checkElements" required="yes"/>
    
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <xsl:variable name="termentryId" select="@id"/>
        <xsl:variable name="languageCode" select="doctales:getLanguageCodeFromLanguageRegionCode($language)"/>
        <xsl:variable name="definition">
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]">
                    <xsl:value-of select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]"/>
                </xsl:when>
                <xsl:otherwise><xsl:text/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended'][@language = $languageCode or @language = $language]">
            
            <xsl:variable name="termLanguageRegionCode" select="normalize-space(@language)"/>
            <xsl:variable name="notRecommendedTerm" select="normalize-space(termVariant)"/>
            <xsl:variable name="sqfGroupName" select="doctales:generateId()"/>
            <xsl:variable name="parent">
                <xsl:choose>
                    <xsl:when test="$checkElements = 'source'"><xsl:text>ancestor-or-self::*[name() = 'source']</xsl:text></xsl:when>
                    <xsl:when test="$checkElements = 'target'"><xsl:text>ancestor-or-self::*[name() = 'target']</xsl:text></xsl:when>
                    <xsl:when test="$checkElements = 'both'"><xsl:text>ancestor-or-self::*[name() = 'target' or 'source']</xsl:text></xsl:when>
                </xsl:choose>
            </xsl:variable>

            <!-- 
                Create a report that will be reported if the tested topic: 
                - contains a notRecommended term
                - the xml:lang attribute of the tested topic has the same value as the language attribute of the notRecommended term
            -->
            <xsl:element name="sch:report">
                <xsl:attribute name="test">
                    <xsl:choose>
                        <xsl:when test="$checkElements = 'source'">
                            <xsl:text>contains(ancestor::*/@source-language, '</xsl:text><xsl:value-of select="$termLanguageRegionCode"/><xsl:text>') </xsl:text>
                        </xsl:when>
                        <xsl:when test="$checkElements = 'target'">
                            <xsl:text>contains(ancestor::*/@target-language, '</xsl:text><xsl:value-of select="$termLanguageRegionCode"/><xsl:text>') </xsl:text>
                        </xsl:when>
                        <xsl:when test="$checkElements = 'both'">
                            <xsl:text>(contains(ancestor::*/@source-language, '</xsl:text><xsl:value-of select="$termLanguageRegionCode"/><xsl:text>') or contains(ancestor::*/@target-language, '</xsl:text><xsl:value-of select="$termLanguageRegionCode"/><xsl:text>')) </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:text>and matches(., '(((\W|^))</xsl:text>
                    <xsl:value-of select="$notRecommendedTerm"/>
                    <xsl:text>((\W|$)))', 'i') and </xsl:text>
                    <xsl:value-of select="$parent"/>
                </xsl:attribute>
                <xsl:attribute name="role">warning</xsl:attribute>
                <xsl:attribute name="sqf:fix" select="$sqfGroupName"/>
                <xsl:value-of select="doctales:getString($language, 'TheTerm')"/>
                <xsl:text> '</xsl:text>
                <xsl:value-of select="$notRecommendedTerm"/>
                <xsl:text>' </xsl:text>
                <xsl:value-of select="doctales:getString($language, 'IsNotAllowed')"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="doctales:getString($language, 'ReplaceWithAllowedTerm')"/>
                <xsl:text>: </xsl:text>
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:text>'</xsl:text>
                            <xsl:value-of select="*[contains(@class, 'termentry/termVariant')]"/>
                            <xsl:text>'</xsl:text>
                            <xsl:choose>
                                <xsl:when test="following-sibling::*[(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')]">
                                    <xsl:text>, </xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
            
            <!-- Create a Schematron Quick Fix group that contains quick fixes for all allowed term variants -->
            <xsl:element name="sqf:group">
                <xsl:attribute name="id" select="$sqfGroupName"/>
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:message>Generate SQF for term notation '<xsl:value-of select="$notRecommendedTerm"/>'</xsl:message>
                            <xsl:if test="not(*[contains(@class, 'termentry/termVariant')]) or *[contains(@class, 'termentry/termVariant')] = ''">
                                <xsl:message terminate="yes">ERROR: Could not create SQF for not recommended term '<xsl:value-of select="$notRecommendedTerm"/>', because the preferred term is empty.</xsl:message>
                            </xsl:if>
                            <xsl:call-template name="createSqfFix">
                                <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTerm"/>
                                <xsl:with-param name="preferredTerm" select="*[contains(@class, 'termentry/termVariant')]"/>
                                <xsl:with-param name="termLanguage" select="$termLanguageRegionCode"/>
                                <xsl:with-param name="definition" select="$definition"/>
                            </xsl:call-template>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
            
        </xsl:for-each>
    </xsl:template>
    
    <!-- Empty fall-through template for non-termentry topics -->
    <xsl:template match="*[contains(@class, ' topic/topic ')][not(contains(@class, ' termentry/termentry '))]"/>
    
</xsl:stylesheet>
