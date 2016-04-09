<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:math="http://exslt.org/math" extension-element-prefixes="math"
    xmlns:dtl="http://doctales.github.io"
    exclude-result-prefixes="xs" version="2.0">

    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <sch:schema
            xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
            queryBinding="xslt2">
            <sch:title>Terminology</sch:title>
            <xsl:apply-templates/>
        </sch:schema>
    </xsl:template>
    
    <xsl:function name="dtl:generateId" as="xs:string?">
        <xsl:param name="baseString" as="xs:string?"/>
        <xsl:param name="prefixString" as="xs:string?"/>
        <xsl:variable name="idStage1" select="lower-case(replace(replace(replace(replace(replace(replace(replace(replace($baseString, 'ä', 'ae')
          , 'ö', 'oe')
          , 'ü', 'ue')
          , 'Ä', 'Ae')
          , 'Ö', 'Oe')
          , 'Ü', 'Ue')
          , 'ß', 'ss')
          , '[^0-9a-zA-Z]', ' '))"/>
        <xsl:variable name="idStage2" select="concat(upper-case(substring($idStage1,1,1)), substring($idStage1, 2),' '[not(last())])"/>                                                      
        <xsl:variable name="idStage3" select="
            replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace($idStage2, ' a', ' A'), ' b', ' B')
          , ' d', ' D')
          , ' c', ' C')
          , ' e', ' E')
          , ' f', ' F')
          , ' g', ' G')
          , ' h', ' H')
          , ' i', ' I')
          , ' j', ' J')
          , ' k', ' K')
          , ' l', ' L')
          , ' m', ' M')
          , ' n', ' N')
          , ' o', ' O')
          , ' p', ' P')
          , ' q', ' Q')
          , ' r', ' R')
          , ' s', ' S')
          , ' t', ' T')
          , ' u', ' U')
          , ' v', ' V')
          , ' w', ' W')
          , ' x', ' X')
          , ' y', ' Y')
          , ' z', ' Z')
          , '[^0-9a-zA-Z]', '')"/>
    <xsl:sequence select="concat(normalize-space($prefixString), $idStage3)"/> 
  </xsl:function>

    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <xsl:variable name="termentryId" select="@id"/>
        <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]"/>
        <xsl:element name="sch:pattern">
            <xsl:attribute name="id" select="@id"/>
            
            <!-- The context text() matches the text content of all nodes. -->
            <sch:rule context="text()">
                <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'notRecommended']">
                    <xsl:variable name="termLanguage" select="normalize-space(@language)"/>
                    <xsl:variable name="notRecommendedTerm" select="normalize-space(termVariant)"/>
                    <xsl:variable name="sqfGroupName" select="dtl:generateId($notRecommendedTerm, 'sqfGroup')"/>
                    
                    <!-- 
                        Create a report that will be reported if the tested topic: 
                        - contains a notRecommended term
                        - the xml:lang attribute of the tested topic has the same value as the language attribute of the notRecommended term
                    -->
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test">
                            <xsl:text>contains(/*/@xml:lang, '</xsl:text>
                            <xsl:value-of select="$termLanguage"/>
                            <xsl:text>') and contains(., '</xsl:text>
                            <xsl:value-of select="$notRecommendedTerm"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="sqf:fix" select="$sqfGroupName"/>
                        <xsl:text>The term '</xsl:text>
                        <xsl:value-of select="$notRecommendedTerm"/>
                        <xsl:text>' is not allowed.</xsl:text>
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
                                        <xsl:with-param name="termLanguage" select="$termLanguage"/>
                                        <xsl:with-param name="definition" select="$definition"/>
                                    </xsl:call-template>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:for-each>
            </sch:rule>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="createSqfFix">
        <xsl:param name="notRecommendedTerm"/>
        <xsl:param name="termLanguage"/>
        <xsl:param name="definition"/>
        <xsl:variable name="allowedTerm" select="termVariant[1]"/>
        <xsl:variable name="sqfTitle">
            <xsl:choose>
                <xsl:when test="self::*[contains(@class, ' termentry/fullForm ')]">
                    <xsl:text>Replace with an allowed term: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/abbreviation ')]">
                    <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/acronym ')]">
                    <xsl:text>Replace with an allowed acronym: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="counter" select="position()"/>
        <xsl:variable name="quickFixId" select="concat(dtl:generateId($notRecommendedTerm, 'term'), $counter)"/>
        
        <!-- FIXME: This uses the first termVariant but should use all and respect the flection of the notRecommended term. -->
        <xsl:variable name="allowedFullForm" select="normalize-space(.)"/>
        <xsl:element name="sqf:fix">
            <xsl:attribute name="id" select="$quickFixId"/>
            <xsl:element name="sqf:description">
                <xsl:element name="sqf:title">
                    <xsl:value-of select="normalize-space($sqfTitle)"/>
                </xsl:element>
                <xsl:choose>
                    <xsl:when test="$definition != ''">
                        <xsl:element name="sqf:p">
                            <xsl:text>Definition: </xsl:text>
                            <xsl:value-of select="$definition"/>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:element>
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:value-of select="$notRecommendedTerm"/>
                </xsl:attribute>
                <xsl:value-of select="$allowedTerm"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- Remove HTML clutter -->
    <xsl:template name="chapter-setup">
        <xsl:call-template name="chapterBody"/>
    </xsl:template>
    
    <xsl:template name="chapterBody">
        <xsl:apply-templates select="." mode="chapterBody"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*" mode="chapterBody"/>

</xsl:stylesheet>
