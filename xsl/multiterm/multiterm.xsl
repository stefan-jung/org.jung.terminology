<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs">

    <!-- ================================================== -->
    <!-- OUTPUT -->
    <!-- ================================================== -->
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="true"/>
    
    <!-- ================================================== -->
    <!-- PARAMETERS                                         -->
    <!-- ================================================== -->
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string" required="true"/>
    
    <!-- By default (if it is not set), the string is empty. -->
    <xsl:param name="target.language" as="xs:string" required="false" select="''"/>
    
    <!-- License info to be added to the header -->
    <xsl:param name="license" as="xs:string" required="false" select="''"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>


    <!-- ================================================== -->
    <!-- MODES                                              -->
    <!-- ================================================== -->
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="termNotation" on-no-match="shallow-skip"/>
    <xsl:mode name="termVariant" on-no-match="shallow-skip"/>
    <xsl:mode name="definition" on-no-match="shallow-skip"/>
    
    
    <!-- ================================================== -->
    <!-- TEMPLATES                                          -->
    <!-- ================================================== -->

    <xsl:template match="/">
        <Schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
            <mtf>
                <xsl:apply-templates mode="termref"/>
            </mtf>
        </Schema>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termgroup ')]" mode="termref">
        <xsl:apply-templates mode="termref"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href][@keys]" mode="termref">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)" as="xs:anyURI"/>
        <xsl:apply-templates select="document($t)" mode="termentry"/>
    </xsl:template>
    
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termentry">
        <xsl:variable name="termentry-root" select="." as="node()"/>
        <conceptEntry xmlns="urn:iso:std:iso:30042:ed-2" id="{generate-id()}">
            
            <xsl:variable name="languages">
                <xsl:for-each select="distinct-values(//@language)">
                    <xsl:value-of select="distinct-values(.) || ','"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:for-each select="tokenize($languages, ',')">
                <xsl:variable name="language" select="normalize-space(.)"/>
                <xsl:if test="$language != ''">
                    <langSec xml:lang="{$language}">
                        <xsl:if test="$language = $source.language">
                            <xsl:apply-templates select="$termentry-root//*[contains(@class, '  termentry/definition ')]" mode="definition"/>
                        </xsl:if>
                        <xsl:apply-templates select="$termentry-root//*[contains(@class, ' termentry/termNotation ')][@language = $language]" mode="termNotation"/>
                    </langSec>
                </xsl:if>
            </xsl:for-each>
        </conceptEntry>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]" mode="termNotation">
        <termSec xmlns="urn:iso:std:iso:30042:ed-2">
            <xsl:apply-templates mode="termVariant"/>
        </termSec>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termVariant ')]" mode="termVariant">
        <term xmlns="urn:iso:std:iso:30042:ed-2"><xsl:value-of select="."/></term>
    </xsl:template>
    
</xsl:stylesheet>
