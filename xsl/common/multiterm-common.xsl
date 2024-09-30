<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="sj xs">
    
    <!-- This template is used by multiterm and multiterm-custom -->
    
    <!-- ================================================== -->
    <!-- IMPORTS                                            -->
    <!-- ================================================== -->
    <xsl:import href="multiterm-language-name.xsl"/>
    <xsl:import href="multiterm-language-code.xsl"/>
    <xsl:import href="multiterm-usage.xsl"/>
    <xsl:import href="hash.xsl"/>
    
    
    <!-- ================================================== -->
    <!-- PARAMETERS                                         -->
    <!-- ================================================== -->
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    
    <!-- License info to be added to the header -->
    <xsl:param name="license" as="xs:string" required="false" select="''"/>
    
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>
    
    <xsl:variable name="dateTimePattern" select="'[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01]'" as="xs:string"/>
    
    
    <!-- ================================================== -->
    <!-- MODES                                              -->
    <!-- ================================================== -->
    <xsl:mode name="definition" on-no-match="shallow-skip"/>
    <xsl:mode name="definitionSource" on-no-match="shallow-skip"/>
    <xsl:mode name="definitionText" on-no-match="shallow-skip"/>
    <xsl:mode name="termVariant" on-no-match="shallow-skip"/>
    <xsl:mode name="termcontext" on-no-match="shallow-skip"/>
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="termnotation" on-no-match="shallow-skip"/>
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    
    
    <!-- ================================================== -->
    <!-- TEMPLATES                                          -->
    <!-- ================================================== -->
    <xsl:template match="*[contains(@class, ' termmap/termgroup ')]" mode="termref">
        <xsl:apply-templates mode="termref"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href][@keys]" mode="termref">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)" as="xs:anyURI"/>
        <xsl:variable name="conceptNumber" select="count(preceding-sibling::*[contains(@class, ' termmap/termref ')]) + 1" as="xs:integer"/>
        <xsl:apply-templates select="document($t)" mode="termentry"/>
    </xsl:template>
    
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termentry" expand-text="yes">
        <xsl:variable name="termentry-root" select="." as="node()"/>
        <conceptGrp>
            <concept>{sj:hash-string(./@id)}</concept>
            <system type="entryClass">Unspecified</system>
            <transacGrp>
                <transac type="origination">ST</transac>
                <date>{format-dateTime(current-dateTime(), $dateTimePattern)}</date>
            </transacGrp>
            <xsl:apply-templates mode="definition"/>
            <xsl:apply-templates mode="termnotation">
                <xsl:with-param name="part-of-speech" select="//*[contains(@class, ' termentry/partOfSpeech ')]/@value"/>
            </xsl:apply-templates>
        </conceptGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definition ')]" mode="definition">
        <descripGrp>
            <xsl:apply-templates mode="definitionText"/>
            <xsl:apply-templates mode="definitionSource"/>
        </descripGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definitionText ')]" mode="definitionText" expand-text="yes">
        <descrip type="Definition">{normalize-space(.)}</descrip>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definitionSource ')]" mode="definitionSource" expand-text="yes">
        <descripGrp>
            <descrip type="Source">{normalize-space(.)}</descrip>
        </descripGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]" mode="termnotation" expand-text="yes">
        <xsl:param name="part-of-speech" select="'noun'"/>
        <languageGrp>
            <language type="{sj:language-name(@language)}" lang="{sj:language-code(@language)}"/>
            <termGrp>
                <term>{*[contains(@class, ' termentry/termVariant ')]}</term>
                <transacGrp>
                    <transac type="origination">ST</transac>
                    <date>{format-dateTime(current-dateTime(), $dateTimePattern)}</date>
                </transacGrp>
                <descripGrp>
                    <descrip type="Usage">{sj:usage(@usage)}</descrip>
                </descripGrp>
                <descripGrp>
                    <descrip type="Part of Speech">{$part-of-speech}</descrip>
                </descripGrp>
                <xsl:apply-templates mode="termcontext"/>
            </termGrp>
        </languageGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termContext ')]" mode="termcontext" expand-text="yes">
        <descripGrp>
            <descrip type="Context">{*[contains(@class, ' termentry/termContextText ')]/text()}</descrip>
            <descripGrp>
                <descrip type="Source">{*[contains(@class, ' termentry/termContextSource ')]/text()}</descrip>
            </descripGrp>
        </descripGrp>
    </xsl:template>
    
</xsl:stylesheet>