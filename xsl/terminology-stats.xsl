<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"
        doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:param name="ditamap"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:template match="/" priority="1">
        <termstats>
            <termconflicts>
                <xsl:apply-templates mode="termconflict"/>
            </termconflicts>
        </termstats>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="termconflict">
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="preferredTermFile" select="@href" as="xs:string"/>
        <xsl:for-each select="document($preferredTermFile,.)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'preferred')]">
            <xsl:variable name="preferredTerm" select="normalize-space(.)"/>
            
            <xsl:for-each select="document($ditamap,.)/descendant::*[contains(@class, 'termmap/termref')]">
                <xsl:variable name="notRecommendedTermFile" select="@href" as="xs:string"/>
                <xsl:for-each select="document($notRecommendedTermFile,.)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'notRecommended')]">
                    <xsl:variable name="notRecommendedTerm" select="normalize-space(.)"/>
                    <xsl:if test="$preferredTermFile != $notRecommendedTermFile">
                        <xsl:if test="not($preferredTerm != $notRecommendedTerm)">
                            <xsl:element name="termconflict">
                                <xsl:element name="termnotation"><xsl:value-of select="$preferredTerm"/></xsl:element>
                                <xsl:element name="preferredTermFile"><xsl:value-of select="$preferredTermFile"/></xsl:element>
                                <xsl:element name="notRecommendedTermFile"><xsl:value-of select="$notRecommendedTermFile"/></xsl:element>
                            </xsl:element>
                            <!--<xsl:value-of select="$preferredTerm"/><xsl:text>(</xsl:text><xsl:value-of select="$preferredTermFile"/><xsl:text>) == </xsl:text><xsl:value-of select="$notRecommendedTerm"/><xsl:text>(</xsl:text><xsl:value-of select="$notRecommendedTermFile"/><xsl:text>) = </xsl:text><xsl:text>true</xsl:text><xsl:value-of select="$newline"/>-->
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
            
        </xsl:for-each>
        
    </xsl:template>

</xsl:stylesheet>
