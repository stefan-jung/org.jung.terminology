<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <!-- Command Line Parameters -->
    <xsl:param name="sourceLanguage"/>
    <xsl:param name="targetLanguage"/>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
  
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">
            <xsl:attribute name="href">TBX-Min.rng</xsl:attribute>
            <xsl:attribute name="type">application/xml</xsl:attribute>
            <xsl:attribute name="schematypens">http://relaxng.org/ns/structure/1.0</xsl:attribute>
        </xsl:processing-instruction>
        <TBX dialect="TBX-Min">
            <header>
                <id></id>
                <xsl:element name="languages">
                    <xsl:attribute name="source">
                        <xsl:value-of select="$sourceLanguage"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:value-of select="$targetLanguage"/>
                    </xsl:attribute>
                </xsl:element>
            </header>
            <body>
                <xsl:apply-templates mode="termEntry"/>
            </body>
        </TBX>
    </xsl:template>

    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termEntry">
        <xsl:variable name="partOfSpeech" select="*[contains(@class, ' termentry/partOfSpeech ')]/@value"/>
        <xsl:variable name="domain" select="*[contains(@class, ' termentry/domains ')]/*[contains(@class, ' termentry/domain ')]/@value[1]"/>
        <xsl:element name="termEntry">
            <xsl:attribute name="id" select="generate-id()"/>
            <xsl:choose>
                <xsl:when test="$domain">
                    <xsl:element name="subjectField">
                        <xsl:value-of select="$domain"/>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred'][@language = $sourceLanguage or $targetLanguage]">
                <xsl:element name="langSet">
                    <xsl:attribute name="xml:lang" select="@language"/>
                    <xsl:element name="tig">
                        <xsl:element name="term">
                            <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')][@case = 'nominative'][@number = 'singular']"/>
                        </xsl:element>
                        <xsl:element name="termStatus">
                            <xsl:value-of select="@usage"/>
                        </xsl:element>
                        <xsl:choose>
                            <xsl:when test="$partOfSpeech">
                                <xsl:element name="partOfSpeech">
                                    <xsl:value-of select="$partOfSpeech"/>
                                </xsl:element>        
                            </xsl:when>
                        </xsl:choose>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
