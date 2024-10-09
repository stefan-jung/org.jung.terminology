<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:sj="https://stefan-jung.org"
    exclude-result-prefixes="sj xs">
    
    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <!--<xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>-->
    
    <!-- Import the generic termchecker templates -->
    <xsl:import href="../common/termchecker.xsl"/>
    
    <!-- Import the sj:getString function -->
    <xsl:import href="../common/get-string.xsl"/>
    
    <!-- What elements should be checked? Only source? -->
    <xsl:param name="checkElements" as="xs:string" select="'source'"/>
    
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
            
            <xsl:variable name="termLanguageRegionCode" select="normalize-space(@language)"/>
            <xsl:variable name="notRecommendedTerm" select="normalize-space(termVariant)"/>
            <xsl:variable name="sqfGroupName" select="$termentryId || '-' || translate($notRecommendedTerm, ' ', '_') || '-' || generate-id()"/>
            <xsl:variable name="parent" select="
                if ($checkElements = 'source') then 'ancestor-or-self::*[name() = ''source'']'
                else if ($checkElements = 'target') then 'ancestor-or-self::*[name() = ''target'']'
                else 'ancestor-or-self::*[name() = ''target'' or ''source'']'
                "/>

            <!-- 
                Create a report that will be reported if the tested topic: 
                - contains a notRecommended term
                - the xml:lang attribute of the tested topic has the same value as the language attribute of the notRecommended term
            -->
            <xsl:variable name="test" select="
                if ($checkElements = 'source') 
                then 'contains(ancestor::*/@source-language, ''' || $termLanguageRegionCode || ''') and matches(., ''((\W|^)' || $notRecommendedTerm || '(\W|$))'', ''i'') and ' || $parent
                else if ($checkElements = 'target') 
                then 'contains(ancestor::*/@target-language, ''' || $termLanguageRegionCode || ''') and matches(., ''((\W|^)' || $notRecommendedTerm || '(\W|$))'', ''i'') and ' || $parent
                else if ($checkElements = 'both') 
                then '(contains(ancestor::*/@source-language, ''' ||$termLanguageRegionCode || ''') or contains(ancestor::*/@target-language, ''' || $termLanguageRegionCode ||  ''') and matches(., ''((\W|^)' || $notRecommendedTerm || '(\W|$))'', ''i'') and ' || $parent
                
                else 'contains(ancestor::*/@source-language, ''' || $termLanguageRegionCode ||  ''') and matches(., ''((\W|^)' || $notRecommendedTerm || '(\W|$))'', ''i'') and ' || $parent
                "/>
            <sch:report test="{$test}" role="warning" sqf:fix="{$sqfGroupName}">
                <xsl:value-of select="sj:getString('termchecker', $language, 'The term') || ' ''' || $notRecommendedTerm || ''' ' || sj:getString('termchecker', $language, 'Is Not Allowed') || '. ' || sj:getString('termchecker', $language, 'ReplaceWithAllowedTerm') || ': '"/>
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
            </sch:report>
            <!--<xsl:element name="sch:report">
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
                    <xsl:text>and matches(., '((\W|^)</xsl:text>
                    <xsl:value-of select="$notRecommendedTerm"/>
                    <xsl:text>(\W|$))', 'i') and </xsl:text>
                    <xsl:value-of select="$parent"/>
                </xsl:attribute>-->
                <!--<xsl:attribute name="role">warning</xsl:attribute>
                <xsl:attribute name="sqf:fix" select="$sqfGroupName"/>-->
                <!--<xsl:value-of select="sj:getString($language, 'The term')"/>
                <xsl:text> '</xsl:text>
                <xsl:value-of select="$notRecommendedTerm"/>
                <xsl:text>' </xsl:text>
                <xsl:value-of select="sj:getString($language, 'IsNotAllowed')"/>-->
                <!--<xsl:text>. </xsl:text>
                <xsl:value-of select="sj:getString($language, 'ReplaceWithAllowedTerm')"/>-->
                <!--<xsl:text>: </xsl:text>-->
                <!--<xsl:for-each select="preceding-sibling::* | following-sibling::*">
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
                </xsl:for-each>-->
            <!--</xsl:element>-->
            
            <!-- Create a Schematron Quick Fix group that contains quick fixes for all allowed term variants -->
            <sqf:group id="{$sqfGroupName}">
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:message use-when="system-property('debug_on') = 'yes'">Generate SQF for term notation '<xsl:value-of select="$notRecommendedTerm"/>'</xsl:message>
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
            </sqf:group>
            <!--<xsl:element name="sqf:group">
                <xsl:attribute name="id" select="$sqfGroupName"/>
                <xsl:for-each select="preceding-sibling::* | following-sibling::*">
                    <xsl:choose>
                        <xsl:when test="(@language = $languageCode or @language = $language) and (@usage = 'preferred' or @usage = 'admitted')">
                            <xsl:message use-when="system-property('debug_on') = 'yes'">Generate SQF for term notation '<xsl:value-of select="$notRecommendedTerm"/>'</xsl:message>
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
            </xsl:element>-->
            
        </xsl:for-each>
    </xsl:template>
    
    <!-- Empty fall-through template for non-termentry topics -->
    <xsl:template match="*[contains(@class, ' topic/topic ')][not(contains(@class, ' termentry/termentry '))]"/>
    
</xsl:stylesheet>
