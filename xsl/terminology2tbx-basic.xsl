<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs" version="2.0">

    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <xsl:output encoding="UTF-8" indent="yes" doctype-system="TBXBasiccoreStructV02.dtd"/>

    <!-- Command Line Parameters -->
    <xsl:param name="sourceLanguage"/>
    <xsl:param name="targetLanguage"/>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <martif type="TBX-Basic" xml:lang="en-GB">
            <martifHeader>
                <fileDesc>
                    <sourceDesc>
                        <p>Has been generated using the DITA Jung Terminology plugin.</p>
                    </sourceDesc>
                </fileDesc>
            </martifHeader>
            <text>
                <body>
                    <xsl:apply-templates mode="termEntry"/>
                </body>
            </text>
        </martif>
    </xsl:template>
  
    <xsl:template name="add-doctype">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE martif SYSTEM "TBXBasiccoreStructV02.dtd"&gt;</xsl:text>
    </xsl:template>

    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termEntry">
        <xsl:choose>
            <xsl:when test="descendant::*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred'][@language = $sourceLanguage]
                and descendant::*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred'][@language = $targetLanguage]">
                <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]"/>
                <xsl:variable name="definitionText" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]"/>
                <xsl:variable name="definitionSourceName" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionSource ')]/*[contains(@class, ' termentry/sourceName ')]"/>
                <xsl:variable name="definitionSourceReference" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionSource ')]/*[contains(@class, ' termentry/sourceReference ')]/@href"/>
                <xsl:variable name="partOfSpeech" select="*[contains(@class, ' termentry/partOfSpeech ')]/@value"/>
                <xsl:variable name="domain" select="*[contains(@class, ' termentry/domains ')]/*[contains(@class, ' termentry/domain ')]/@value[1]"/>
                <xsl:variable name="annotation" select="*[contains(@class, ' termentry/annotation ')]"/>
                <!-- Use only images with @scope='external', otherwise they would not be available. -->
                <xsl:variable name="figure" select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/image ')][@scope = 'external']/@href"/>
                <xsl:element name="termEntry">
                    <xsl:attribute name="id" select="generate-id()"/>
                    <xsl:choose>
                        <xsl:when test="$domain">
                            <xsl:element name="descrip">
                                <xsl:attribute name="type">subjectField</xsl:attribute>
                                <xsl:value-of select="$domain"/>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$definition">
                            <xsl:element name="descripGrp">
                                <xsl:choose>
                                    <xsl:when test="$definitionText">
                                        <xsl:element name="descrip">
                                            <xsl:attribute name="type">definition</xsl:attribute>
                                            <xsl:value-of select="$definitionText"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:when test="$definitionSourceName">
                                        <xsl:element name="admin">
                                            <xsl:attribute name="type">source</xsl:attribute>
                                            <xsl:value-of select="$definitionSourceName"/>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$annotation">
                            <xsl:element name="note">
                                <xsl:value-of select="$annotation"/>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$definitionSourceReference">
                            <xsl:element name="xref">
                                <xsl:attribute name="type">externalCrossReference</xsl:attribute>
                                <xsl:attribute name="target"><xsl:value-of select="normalize-space($definitionSourceReference)"/></xsl:attribute>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$figure">
                            <xsl:element name="xref">
                                <xsl:attribute name="type">xGraphic</xsl:attribute>
                                <xsl:attribute name="target"><xsl:value-of select="$figure"/></xsl:attribute>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred'][@language = $sourceLanguage or @language = $targetLanguage]">
                        <xsl:variable name="termLanguage" select="@language"/>
                        <xsl:variable name="termUsage">
                            <xsl:choose>
                                <xsl:when test="contains(@usage, 'admitted')">
                                    <xsl:text>admittedTerm-admn-sts</xsl:text>
                                </xsl:when>
                                <xsl:when test="contains(@usage, 'notRecommended')">
                                    <xsl:text>deprecatedTerm-admn-sts</xsl:text>
                                </xsl:when>
                                <xsl:when test="contains(@usage, 'obsolete')">
                                    <xsl:text>supersededTerm-admn-sts</xsl:text>
                                </xsl:when>
                                <xsl:when test="contains(@usage, 'preferred')">
                                    <xsl:text>preferredTerm-admn-sts</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="termType">
                            <xsl:choose>
                                <xsl:when test="contains(@class, 'fullForm')">
                                    <xsl:text>fullForm</xsl:text>
                                </xsl:when>
                                <xsl:when test="contains(@class, 'abbreviation')">
                                    <xsl:text>abbreviation</xsl:text>
                                </xsl:when>
                                <xsl:when test="contains(@class, 'acronym')">
                                    <xsl:text>acronym</xsl:text>
                                </xsl:when>
                                <xsl:when test="contains(@class, 'verb')">
                                    <xsl:text>verb</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="termGender" select="@gender"/>
                        <xsl:variable name="termContext" select="*[contains(@class, ' termentry/termContext ')]"/>
                        <xsl:variable name="termContextText" select="*[contains(@class, ' termentry/termContext ')]/*[contains(@class, ' termentry/termContextText ')]"/>
                        <xsl:variable name="termContextSource" select="*[contains(@class, ' termentry/termContext ')]/*[contains(@class, ' termentry/termContextSource ')]"/>
                        <xsl:element name="langSet">
                            <xsl:attribute name="xml:lang" select="$termLanguage"/>
                            <xsl:element name="tig">
                                <xsl:element name="term">
                                    <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')][@case = 'nominative'][@number = 'singular'][1]"/>
                                </xsl:element>
                                <xsl:choose>
                                    <xsl:when test="$partOfSpeech">
                                        <xsl:element name="termNote">
                                            <xsl:attribute name="type">partOfSpeech</xsl:attribute>
                                            <xsl:value-of select="$partOfSpeech"/>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:element name="termNote">
                                    <xsl:attribute name="type">termType</xsl:attribute>
                                    <xsl:value-of select="$termType"/>
                                </xsl:element>
                                <xsl:choose>
                                    <xsl:when test="$termGender">
                                        <xsl:element name="termNote">
                                            <xsl:attribute name="type">grammaticalGender</xsl:attribute>
                                            <xsl:value-of select="$termGender"/>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:element name="termNote">
                                    <xsl:attribute name="type">administrativeStatus</xsl:attribute>
                                    <xsl:value-of select="$termUsage"/>
                                </xsl:element>
                                <xsl:choose>
                                    <xsl:when test="$termContext">
                                        <xsl:element name="descripGrp">
                                            <xsl:choose>
                                                <xsl:when test="$termContextText">
                                                    <xsl:element name="descrip">
                                                        <xsl:attribute name="type">context</xsl:attribute>
                                                        <xsl:value-of select="$termContextText"/>
                                                    </xsl:element>
                                                </xsl:when>
                                            </xsl:choose>
                                            <xsl:choose>
                                                <xsl:when test="$termContextSource">
                                                    <xsl:element name="admin">
                                                        <xsl:attribute name="type">source</xsl:attribute>
                                                        <xsl:value-of select="$termContextSource"/>
                                                    </xsl:element>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Empty fall-through template for non-termentry topics -->
    <xsl:template match="*[contains(@class, ' topic/topic ')][not(contains(@class, ' termentry/termentry '))]" priority="1.0" mode="termEntry"/>

</xsl:stylesheet>
