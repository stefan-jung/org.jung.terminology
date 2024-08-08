<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" 
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs">

    <!-- ================================================== -->
    <!-- OUTPUT                                             -->
    <!-- ================================================== -->
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="true"/>


    <!-- ================================================== -->
    <!-- IMPORTS                                            -->
    <!-- ================================================== -->
    <xsl:import href="multiterm-language-name.xsl"/>
    <xsl:import href="multiterm-language-code.xsl"/>
    <xsl:import href="hash.xsl"/>
    
    
    <!-- ================================================== -->
    <!-- PARAMETERS                                         -->
    <!-- ================================================== -->
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    
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
    <xsl:mode name="definitionText" on-no-match="shallow-skip"/>
    <xsl:mode name="definitionSource" on-no-match="shallow-skip"/>


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
        <xsl:variable name="conceptNumber" select="count(preceding-sibling::*[contains(@class, ' termmap/termref ')]) + 1" as="xs:integer"/>
        <xsl:apply-templates select="document($t)" mode="termentry"/>
<!--        <xsl:apply-templates select="document($t)" mode="termentry">
            <xsl:with-param name="conceptNumber" select="$conceptNumber" as="xs:integer"/>
        </xsl:apply-templates>-->
    </xsl:template>
    
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termentry">
        <!--<xsl:param name="conceptNumber" as="xs:integer" required="true"/>-->
        <xsl:variable name="termentry-root" select="." as="node()"/>
        <conceptGrp>
            <concept><xsl:value-of select="sj:hash-string(./@id)"/></concept>
            <system type="entryClass"/>
            <transacGrp>
                <!--<transac type="origination">ST</transac>-->
                <date><xsl:value-of select="current-dateTime()"/></date>
            </transacGrp>
            <xsl:apply-templates mode="definition"/>
            
            <!--<xsl:variable name="languages">
                <xsl:for-each select="distinct-values(//@language)">
                    <xsl:value-of select="distinct-values(.) || ','"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:for-each select="tokenize($languages, ',')">
                <xsl:variable name="language" select="normalize-space(.)"/>
                <xsl:if test="$language != ''">
                    <langSec xml:lang="{$language}">
                        <xsl:apply-templates select="$termentry-root//*[contains(@class, ' termentry/termNotation ')][@language = $language]" mode="termNotation"/>
                    </langSec>
                </xsl:if>
            </xsl:for-each>-->
        </conceptGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definition ')]" mode="definition">
        <descripGrp>
            <xsl:apply-templates mode="definitionText"/>
            <xsl:apply-templates mode="definitionSource"/>
        </descripGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definitionText ')]" mode="definitionText">
        <descrip type="Definition">
            <xsl:value-of select="."/>
        </descrip>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definitionSource ')]" mode="definitionSource">
        <descripGrp>
            <descrip type="Source">
                <xsl:value-of select="."/>
            </descrip>
        </descripGrp>
    </xsl:template>
    
    
</xsl:stylesheet>
