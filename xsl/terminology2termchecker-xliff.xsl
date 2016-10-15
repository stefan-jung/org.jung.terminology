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
        <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]"/>
        <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended']">
            <xsl:element name="sch:pattern">
                <xsl:attribute name="id">
                    <xsl:value-of select="$termentryId"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                
                <!-- The context text() matches the text content of all nodes. -->
                <sch:rule context="text()">
                    <xsl:variable name="termLanguage" select="normalize-space(@language)"/>
                    <xsl:variable name="notRecommendedTerm" select="normalize-space(termVariant)"/>
                    <xsl:variable name="notRecommendedTermUppercased"><xsl:value-of select="concat(upper-case(substring($notRecommendedTerm,1,1)), substring($notRecommendedTerm, 2), ' '[not(last())])"/></xsl:variable>
                    <xsl:variable name="sqfGroupName" select="doctales:generateId($notRecommendedTerm, 'sqfGroup', generate-id())"/>
                    <xsl:variable name="sqfGroupName_up" select="concat($sqfGroupName, '_up')"/>
                    <xsl:variable name="sqfGroupName_up_sentence" select="concat($sqfGroupName, '_up_sentence')"/>
                    
                    <!--
                        Create a report that will be reported if the tested topic: 
                        - contains a notRecommended term
                        - the xml:lang attribute of the tested topic has the same value as the language attribute of the notRecommended term
                    -->
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test">
                            <xsl:text>contains(., '</xsl:text>
                            <xsl:value-of select="$notRecommendedTerm"/>
                            <xsl:text>') and parent::*[name() = 'target']</xsl:text>
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
                    
                    <!-- Report for term with a capitalized initial letter at the beginning of an element -->
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test">
                            <xsl:text>contains(., '</xsl:text>
                            <xsl:value-of select="concat('. ', $notRecommendedTermUppercased)"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="role">warning</xsl:attribute>
                        <xsl:attribute name="sqf:fix" select="$sqfGroupName_up_sentence"/>
                        <xsl:value-of select="doctales:getString($language, 'TheTerm')"/>
                        <xsl:text> '</xsl:text>
                        <xsl:value-of select="$notRecommendedTermUppercased"/>
                        <xsl:text>' </xsl:text>
                        <xsl:value-of select="doctales:getString($language, 'IsNotAllowed')"/>
                        <xsl:text>.</xsl:text>
                    </xsl:element>
                    
                    <!-- Report for term with a capitalized initial letter at the beginning of a sentence -->
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test">
                            <xsl:text>starts-with(., '</xsl:text>
                            <xsl:value-of select="$notRecommendedTermUppercased"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="role">warning</xsl:attribute>
                        <xsl:attribute name="sqf:fix" select="$sqfGroupName_up"/>
                        <xsl:value-of select="doctales:getString($language, 'TheTerm')"/>
                        <xsl:text> '</xsl:text>
                        <xsl:value-of select="$notRecommendedTermUppercased"/>
                        <xsl:text>' </xsl:text>
                        <xsl:value-of select="doctales:getString($language, 'IsNotAllowed')"/>
                        <xsl:text>.</xsl:text>
                    </xsl:element>
                    
                    <!-- Create a Schematron Quick Fix group that contains quick fixes for all allowed term variants -->
                    <xsl:element name="sqf:group">
                        <xsl:attribute name="id" select="$sqfGroupName"/>
                        
                        <!-- Process all preceding-sibling term notations -->
                        <xsl:for-each select="preceding-sibling::*">
                            <xsl:choose>
                                <xsl:when test="@language = $termLanguage">
                                    <xsl:call-template name="createSqfFix">
                                        <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTerm"/>
                                        <xsl:with-param name="uppercase" select="'false'"/>
                                        <xsl:with-param name="beginning" select="'false'"/>
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        
                        <!-- Process all following-sibling term notations -->
                        <xsl:for-each select="following-sibling::*">
                            <xsl:choose>
                                <xsl:when test="@language = $termLanguage">
                                    <xsl:call-template name="createSqfFix">
                                        <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTerm"/>
                                        <xsl:with-param name="uppercase" select="'false'"/>
                                        <xsl:with-param name="beginning" select="'false'"/>
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:element>
                    
                    <!-- Schematron Quick Fix Group for terms with uppercased initial letter at the beginning of an element-->
                    <xsl:element name="sqf:group">
                        <xsl:attribute name="id" select="$sqfGroupName_up"/>
                        
                        <!-- Process all preceding-sibling term notations -->
                        <xsl:for-each select="preceding-sibling::*">
                            <xsl:choose>
                                <xsl:when test="@language = $termLanguage">
                                    <xsl:call-template name="createSqfFix">
                                        <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTermUppercased"/>
                                        <xsl:with-param name="uppercase" select="'true'"/>
                                        <xsl:with-param name="beginning" select="'false'"/>
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        
                        <!-- Process all following-sibling term notations -->
                        <xsl:for-each select="following-sibling::*">
                            <xsl:choose>
                                <xsl:when test="@language = $termLanguage">
                                    <xsl:call-template name="createSqfFix">
                                        <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTermUppercased"/>
                                        <xsl:with-param name="uppercase" select="'true'"/>
                                        <xsl:with-param name="beginning" select="'false'"/>
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:element>
                    
                    <!-- Schematron Quick Fix Group for terms with uppercased initial letter at the beginning of a sentence -->
                    <xsl:element name="sqf:group">
                        <xsl:attribute name="id" select="$sqfGroupName_up_sentence"/>
                        
                        <!-- Process all preceding-sibling term notations -->
                        <xsl:for-each select="preceding-sibling::*">
                            <xsl:choose>
                                <xsl:when test="@language = $termLanguage">
                                    <xsl:call-template name="createSqfFix">
                                        <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTermUppercased"/>
                                        <xsl:with-param name="uppercase" select="'true'"/>
                                        <xsl:with-param name="beginning" select="'true'"/>
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        
                        <!-- Process all following-sibling term notations -->
                        <xsl:for-each select="following-sibling::*">
                            <xsl:choose>
                                <xsl:when test="@language = $termLanguage">
                                    <xsl:call-template name="createSqfFix">
                                        <xsl:with-param name="notRecommendedTerm" select="$notRecommendedTermUppercased"/>
                                        <xsl:with-param name="uppercase" select="'true'"/>
                                        <xsl:with-param name="beginning" select="'true'"/>
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:element>
                </sch:rule>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
