<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:sj="https://stefan-jung.org"
    exclude-result-prefixes="xs">
    
    <xsl:param name="language" as="xs:string"/>
    
    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <!--<xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>-->
    
    <!-- Import the generic termchecker templates -->
    <xsl:import href="../common/termchecker.xsl"/>
    
    <!-- Import the sj:getString function -->
    <xsl:import href="../common/get-string.xsl"/>
    
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <xsl:variable name="termentryId" select="@id"/>
        <xsl:variable name="languageCode" select="sj:getLanguageCodeFromLanguageRegionCode($language)"/>
        <xsl:variable name="definition" select="
            if (*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]) 
            then *[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]
            else ''
            "/>
        <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended'][@language = $languageCode or @language = $language]">

            <!-- The context text() matches the text content of all nodes. -->
            <xsl:variable name="termLanguageRegionCode" select="normalize-space(@language)"/>
            <xsl:variable name="notRecommendedTerm" select="normalize-space(termVariant)"/>
            <xsl:variable name="sqfGroupName" select="sj:generateId($notRecommendedTerm, $termentryId, $termLanguageRegionCode)"/>
            
            <!-- 
                Create a report that will be reported if the tested topic: 
                - contains a notRecommended term
                - the xml:lang attribute of the tested topic has the same value as the language attribute of the notRecommended term
            -->
            <sch:report 
                test="{sj:getTest($termLanguageRegionCode, $notRecommendedTerm)}" 
                role="warning"
                sqf:fix="{$sqfGroupName}">
                <xsl:value-of select="sj:getString($language, 'The term') || ' &amp;apos;' || sj:getString($language, 'IsNotAllowed') || '. ' || sj:getString($language, 'ReplaceWithAllowedTerm') || ': '"/>
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:value-of select="'&amp;apos;' || *[contains(@class, 'termentry/termVariant')] || '&amp;apos;'"/>
                            <xsl:choose>
                                <xsl:when test="following-sibling::*[(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')]">
                                    <xsl:text>, </xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </sch:report>

            <!-- Create a Schematron Quick Fix group that contains quick fixes for all allowed term variants -->
            <xsl:element name="sqf:group">
                <xsl:attribute name="id" select="$sqfGroupName"/>
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:message use-when="system-property('debug_on') = 'yes'">Generate SQF for term notation '<xsl:value-of select="$notRecommendedTerm"/>'</xsl:message>
                            <xsl:if test="not(*[contains(@class, 'termentry/termVariant')]) or *[contains(@class, 'termentry/termVariant')] = ''">
                                <xsl:message terminate="yes">ERROR: Could not create SQF for not recommended term '<xsl:value-of select="$notRecommendedTerm"/>', because the preferred term is empty.</xsl:message>
                  $          </xsl:if>
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
    
    <xsl:function name="sj:getTest" as="xs:string">
        <xsl:param name="termLanguageRegionCode" as="xs:string"/>
        <xsl:param name="notRecommendedTerm" as="xs:string"/>
        <xsl:sequence select="'contains(/*/@xml:lang, &amp;apos;' || $termLanguageRegionCode || '&amp;apos;) and matches(., &amp;apos;((\W|^)' || $notRecommendedTerm || '(\W|$))&amp;apos;, &amp;apos;i&amp;apos;)'"/>
    </xsl:function>
    
    <!-- Empty fall-through template for non-termentry topics -->
    <xsl:template match="*[contains(@class, ' topic/topic ')][not(contains(@class, ' termentry/termentry '))]"/>
    
</xsl:stylesheet>
