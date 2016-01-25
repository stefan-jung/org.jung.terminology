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

    <xsl:template match="/">
        <sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
            <xsl:apply-templates/>
        </sch:schema>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' termentry/termentry ')]">
        <xsl:variable name="termentryId" select="@id"/>
        <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]"/>
        <xsl:element name="sch:pattern">
            <xsl:attribute name="id" select="@id"/>
            <sch:rule context="text()">
                <xsl:for-each
                    select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/fullForm ') or contains(@class, ' termentry/abbreviation ') or contains(@class, ' termentry/acronym ')][@usage = 'deprecated']">
                    <xsl:variable name="termLanguage" select="normalize-space(@language)"/>
                    <xsl:variable name="deprecatedTerm" select="normalize-space(termVariant)"/>
                    <xsl:variable name="replaceTerm" select="concat('replace', $deprecatedTerm)"/>
                    <xsl:element name="sch:report">
                        <xsl:attribute name="test">
                            <xsl:text>/*/@xml:lang = '</xsl:text>
                            <xsl:value-of select="$termLanguage"/>
                            <xsl:text>' and contains(., '</xsl:text>
                            <xsl:value-of select="$deprecatedTerm"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="sqf:fix" select="$replaceTerm"/>
                        <xsl:text>The term '</xsl:text>
                        <xsl:value-of select="$deprecatedTerm"/>
                        <xsl:text>' is not allowed.</xsl:text>
                    </xsl:element>

                    <xsl:message>Current element <xsl:value-of select="name()"/></xsl:message>

                    <xsl:element name="sqf:group">
                        <xsl:attribute name="id" select="$replaceTerm"/>

                        <!-- Create Schematron Quick Fix to replace deprecated term with another full form term -->
                        <xsl:for-each select=" preceding-sibling::*[contains(@class, ' termentry/fullForm ')][@usage = 'allowed'][@language = $termLanguage]">
                            <xsl:variable name="counter" select="position()"/>
                            <xsl:variable name="quickFixId" select="concat('term', $counter)"/>
                            <!-- FIXME: This uses the first termVariant but should use all and respect the flection of the deprecated term. -->
                            <xsl:variable name="allowedFullForm" select="normalize-space(.)"/>
                            <xsl:element name="sqf:fix">
                                <xsl:attribute name="id" select="$quickFixId"/>
                                <xsl:element name="sqf:description">
                                    <xsl:element name="sqf:title">
                                        <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                                        <xsl:value-of select="$allowedFullForm"/>
                                        <xsl:text>'</xsl:text>
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
                                        <xsl:value-of select="$deprecatedTerm"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$allowedFullForm"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                        
                        <xsl:for-each select="following-sibling::*[contains(@class, ' termentry/fullForm ')][@usage = 'allowed'][@language = $termLanguage]">
                            <xsl:variable name="counter" select="position()"/>
                            <xsl:variable name="quickFixId" select="concat('term', $counter)"/>
                            <!-- FIXME: This uses the first termVariant but should use all and respect the flection of the deprecated term. -->
                            <xsl:variable name="allowedFullForm" select="normalize-space(.)"/>
                            <xsl:element name="sqf:fix">
                                <xsl:attribute name="id" select="$quickFixId"/>
                                <xsl:element name="sqf:description">
                                    <xsl:element name="sqf:title">
                                        <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                                        <xsl:value-of select="$allowedFullForm"/>
                                        <xsl:text>'</xsl:text>
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
                                        <xsl:value-of select="$deprecatedTerm"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$allowedFullForm"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>

                        <!-- Create Schematron Quick Fix to replace deprecated term with an abbreviation -->
                        <xsl:for-each
                            select="preceding-sibling::*[contains(@class, ' termentry/abbreviation ')][@usage = 'allowed'][@language = $termLanguage]">
                            <xsl:variable name="counter" select="position()"/>
                            <xsl:variable name="quickFixId"
                                select="concat('abbreviation', $counter)"/>
                            <xsl:variable name="allowedAbbreviation" select="normalize-space(.)"/>
                            <xsl:element name="sqf:fix">
                                <xsl:attribute name="id" select="$quickFixId"/>
                                <xsl:element name="sqf:description">
                                    <xsl:element name="sqf:title">
                                        <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                                        <xsl:value-of select="$allowedAbbreviation"/>
                                        <xsl:text>'</xsl:text>
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
                                        <xsl:value-of select="$deprecatedTerm"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$allowedAbbreviation"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                        
                        <!-- Create Schematron Quick Fix to replace deprecated term with an abbreviation -->
                        <xsl:for-each
                            select="following-sibling::*[contains(@class, ' termentry/abbreviation ')][@usage = 'allowed'][@language = $termLanguage]">
                            <xsl:variable name="counter" select="position()"/>
                            <xsl:variable name="quickFixId"
                                select="concat('abbreviation', $counter)"/>
                            <xsl:variable name="allowedAbbreviation" select="normalize-space(.)"/>
                            <xsl:element name="sqf:fix">
                                <xsl:attribute name="id" select="$quickFixId"/>
                                <xsl:element name="sqf:description">
                                    <xsl:element name="sqf:title">
                                        <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                                        <xsl:value-of select="$allowedAbbreviation"/>
                                        <xsl:text>'</xsl:text>
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
                                        <xsl:value-of select="$deprecatedTerm"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$allowedAbbreviation"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>

                        <!-- Create Schematron Quick Fix to replace deprecated term with an acronym -->
                        <xsl:for-each select="preceding-sibling::*[contains(@class, ' termentry/acronym ')][@usage = 'allowed'][@language = $termLanguage]">
                            <xsl:variable name="counter" select="position()"/>
                            <xsl:variable name="quickFixId" select="concat('acronym', $counter)"/>
                            <xsl:variable name="allowedAcronym" select="normalize-space(.)"/>
                            <xsl:element name="sqf:fix">
                                <xsl:attribute name="id" select="$quickFixId"/>
                                <xsl:element name="sqf:description">
                                    <xsl:element name="sqf:title">
                                        <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                                        <xsl:value-of select="$allowedAcronym"/>
                                        <xsl:text>'</xsl:text>
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
                                        <xsl:value-of select="$deprecatedTerm"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$allowedAcronym"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                        
                        <!-- Create Schematron Quick Fix to replace deprecated term with an acronym -->
                        <xsl:for-each select="following-sibling::*[contains(@class, ' termentry/acronym ')][@usage = 'allowed'][@language = $termLanguage]">
                            <xsl:variable name="counter" select="position()"/>
                            <xsl:variable name="quickFixId" select="concat('acronym', $counter)"/>
                            <xsl:variable name="allowedAcronym" select="normalize-space(.)"/>
                            <xsl:element name="sqf:fix">
                                <xsl:attribute name="id" select="$quickFixId"/>
                                <xsl:element name="sqf:description">
                                    <xsl:element name="sqf:title">
                                        <xsl:text>Replace with an allowed abbreviation: '</xsl:text>
                                        <xsl:value-of select="$allowedAcronym"/>
                                        <xsl:text>'</xsl:text>
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
                                        <xsl:value-of select="$deprecatedTerm"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$allowedAcronym"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:for-each>
            </sch:rule>
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
