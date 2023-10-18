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
    <!-- PARAMETERS -->
    <!-- ================================================== -->
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string" required="true"/>
    
    <!-- By default (if it is not set), the string is empty. -->
    <xsl:param name="target.language" as="xs:string" required="false" select="''"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>
    

    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">
            <xsl:attribute name="href">https://raw.githubusercontent.com/LTAC-Global/TBX-Min_dialect/master/DCT/TBX-Min_DCT.sch</xsl:attribute>
            <xsl:attribute name="type">application/xml</xsl:attribute>
            <xsl:attribute name="schematypens">http://purl.oclc.org/dsdl/schematron</xsl:attribute>
        </xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model">
            <xsl:attribute name="href">https://raw.githubusercontent.com/LTAC-Global/TBX-Min_dialect/master/DCT/TBX-Min.nvdl</xsl:attribute>
            <xsl:attribute name="type">application/xml</xsl:attribute>
            <xsl:attribute name="schematypens">http://purl.oclc.org/dsdl/nvdl/ns/structure/1.0</xsl:attribute>
        </xsl:processing-instruction>
        
        <tbx dialect="TBX-Min">
            <header>
                <id>Terminology</id>
                <xsl:element name="languages">
                    <xsl:attribute name="source">
                        <xsl:value-of select="$source.language"/>
                    </xsl:attribute>
                    <xsl:if test="$target.language != ''">
                        <xsl:attribute name="target">
                            <xsl:value-of select="$target.language"/>
                        </xsl:attribute>
                    </xsl:if>
                </xsl:element>
            </header>
            <body>
                <xsl:apply-templates mode="termref"/>
            </body>
        </tbx>
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
        <conceptEntry id="{generate-id()}">
      
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

</xsl:stylesheet>
