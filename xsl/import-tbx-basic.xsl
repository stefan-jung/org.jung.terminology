<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tbx="urn:iso:std:iso:30042:ed-2"
    exclude-result-prefixes="xs tbx" version="2.0">
    
    <!-- Output settings -->
    <xsl:output encoding="UTF-16" indent="yes" method="xml"/>
    
    <!-- Parameters -->
    <xsl:param name="output.dir" as="xs:anyURI"/>
    <xsl:param name="primary-language" as="xs:string" select="'en'"/>
    
    <!-- How should the termentry topic id and file name be calculated? Use the concept-ID ('concept-id') or the name of the first term ('first-term')? -->
    <xsl:param name="term-id-pattern" as="xs:string" select="'first-term'"/>
    
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:value-of select="@type"/>
        <termmap>
            <title>Terminology</title>
            <xsl:apply-templates mode="metadata" select="descendant-or-self::tbx:tbxHeader"/>
            <termgroup><xsl:apply-templates mode="termref"/></termgroup>
        </termmap>
    </xsl:template>

    <xsl:template match="tbx:conceptEntry" mode="termref">
        <xsl:variable name="termid">
            <xsl:choose>
                <xsl:when test="$term-id-pattern eq 'fist-term'">
                    <xsl:value-of select="tbx:langSec[@xml:lang='en'][1]/tbx:termSec[1]/tbx:term[1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('term-', @id)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <termref>
            <xsl:attribute name="id" select="$termid"/>
        </termref>
        <xsl:result-document href="{$output.dir}/{$termid}.dita">
            
            <termentry>
                <xsl:attribute name="id" select="$termid"/>
                <title><xsl:value-of select="tbx:langSec[@xml:lang='en'][1]/tbx:termSec[1]/tbx:term[1]"/></title>
                <definition>
                    <definitionText/>
                    <definitionSource/>
                </definition>
                <termBody>
                    <xsl:apply-templates select="descendant-or-self::tbx:transacGrp"></xsl:apply-templates>
                    <partOfSpeech value="noun"/>
                    <fullForm language="en-GB" usage="preferred">
                        <termVariant></termVariant>
                    </fullForm>
                </termBody>
            </termentry>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tbx:tbxHeader" mode="metadata">
        <topicmeta>
            <xsl:apply-templates mode="metadata"/>
        </topicmeta>
    </xsl:template>
    
    <xsl:template match="tbx:fileDesc" mode="metadata">
        <shortdesc><xsl:value-of select="normalize-space(.)"/></shortdesc>
    </xsl:template>
    
    <xsl:template match="tbx:sourceDesc" mode="metadata">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- Fall through templates -->
    <xsl:template match="tbx:p" mode="metadata"/>
    <xsl:template match="tbx:tbxHeader" mode="termref"/>
    <xsl:template match="tbx:back" mode="termref"/>
    

</xsl:stylesheet>
