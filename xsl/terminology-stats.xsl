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
    <xsl:param name="temp.dir"/>
    <xsl:param name="termMap"/>
    <xsl:param name="ditamap.filename"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:template match="/" priority="1">
        <termstats>
            <termconflicts><xsl:apply-templates mode="termconflict"/></termconflicts>
            <reports><xsl:apply-templates mode="reports"/></reports>
        </termstats>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="termconflict">
        <xsl:variable name="currentTermrefNode" select="."/>
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="termEntryTopic" select="@href" as="xs:string"/>
        <xsl:for-each select="document($termEntryTopic, .)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'preferred')]">
            <xsl:variable name="preferredTerm" select="normalize-space(.)"/>
            <xsl:for-each select="($currentTermrefNode/preceding-sibling::*[contains(@class, 'termmap/termref')]) | ($currentTermrefNode/following-sibling::*[contains(@class, 'termmap/termref')])">
                <xsl:variable name="comparedTermEntryTopic" select="@href" as="xs:string"/>
                <xsl:for-each select="document($comparedTermEntryTopic,.)/descendant::*[contains(@class, ' termentry/termNotation ')][contains(@usage, 'notRecommended')]">
                    <xsl:variable name="notRecommendedTerm" select="normalize-space(.)"/>
                    <xsl:if test="$termEntryTopic != $comparedTermEntryTopic">
                        <xsl:if test="not($preferredTerm != $notRecommendedTerm)">
                            <xsl:element name="termconflict">
                                <xsl:element name="termnotation"><xsl:value-of select="$preferredTerm"/></xsl:element>
                                <xsl:element name="preferredTermFile"><xsl:value-of select="$termEntryTopic"/></xsl:element>
                                <xsl:element name="notRecommendedTermFile"><xsl:value-of select="$comparedTermEntryTopic"/></xsl:element>
                            </xsl:element>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <!-- Empty fall through templates -->
    <xsl:template match="*[contains(@class, ' map/topicref ') and contains(@type, 'semanticnet')]" mode="termconflict"/>
    <xsl:template match="*[contains(@class, ' subjectScheme/subjectHead ')]" mode="termconflict"/>
    <xsl:template match="*[contains(@class, ' subjectScheme/hasInstance ')]" mode="termconflict"/>

    <xsl:template name="report">
        <xsl:element name="report">
            <xsl:attribute name="date" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
            <!--<xsl:variable name="termCollection" select="concat($temp.dir, '/?select=*.dita')"/>-->
            <xsl:variable name="termCollection" select="collection('temp/termbrowser/?select=*.dita')"/>
            <xsl:element name="numberOfTermTopics">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termentry')])"/>
            </xsl:element>
            <xsl:element name="numberOfLanguages">
                <xsl:value-of select="count(distinct-values($termCollection//*[contains(@class, 'termentry/termNotation')][@language]/@language))"/>
            </xsl:element>
            <xsl:element name="numberOfPreferredTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='preferred'])"/>
            </xsl:element>
            <xsl:element name="numberOfAdmittedTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='admitted'])"/>
            </xsl:element>
            <xsl:element name="numberOfNotRecommendedTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='notRecommended'])"/>
            </xsl:element>
            <xsl:element name="numberOfObsoleteTermNotations">
                <xsl:value-of select="count($termCollection//*[contains(@class, 'termentry/termNotation')][@usage='obsolete'])"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- Fall Through Templates -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]"/>
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]"/>
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]"/>
    <xsl:template match="*[contains(@class, ' bookmap/mainbooktitle ')]"/>
    
    <xsl:function name="doctales:getRelativePath" as="xs:string">
        <!-- Calculate relative path that gets from from source path to target path.


Given:

  [1]  Target: /A/B/C
     Source: /A/B/C/X


Return: "X"

  [2]  Target: /A/B/C
       Source: /E/F/G/X


Return: "/E/F/G/X"

  [3]  Target: /A/B/C
       Source: /A/D/E/X


Return: "../../D/E/X"

  [4]  Target: /A/B/C
       Source: /A/X


Return: "../../X"


-->
        
        <xsl:param name="source" as="xs:string"/><!-- Path to get relative path *from* -->
        <xsl:param name="target" as="xs:string"/><!-- Path to get relataive path *to* -->
        <xsl:if test="false()">
            <xsl:message> + DEBUG: doctales:getRelativePath(): Starting...</xsl:message>
            <xsl:message> + DEBUG: source="<xsl:value-of select="$source"/>"</xsl:message>
            <xsl:message> + DEBUG: target="<xsl:value-of select="$target"/>"</xsl:message>
        </xsl:if>
        <xsl:variable name="sourceTokens" select="tokenize((if (starts-with($source, '/')) then substring-after($source, '/') else $source), '/')" as="xs:string*"/>
        <xsl:variable name="targetTokens" select="tokenize((if (starts-with($target, '/')) then substring-after($target, '/') else $target), '/')" as="xs:string*"/>
        <xsl:choose>
            <xsl:when test="(count($sourceTokens) > 0 and count($targetTokens) > 0) and
                (($sourceTokens[1] != $targetTokens[1]) and
                (contains($sourceTokens[1], ':') or contains($targetTokens[1], ':')))">
                <!-- Must be absolute URLs with different schemes, cannot be relative, return
target as is. -->
                <xsl:value-of select="$target"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="resultTokens"
                    select="doctales:analyzePathTokens($sourceTokens, $targetTokens, ())" as="xs:string*"/>
                <xsl:variable name="result" select="string-join($resultTokens, '/')" as="xs:string"/>
                <xsl:value-of select="$result"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="doctales:analyzePathTokens" as="xs:string*">
        <xsl:param name="sourceTokens" as="xs:string*"/>
        <xsl:param name="targetTokens" as="xs:string*"/>
        <xsl:param name="resultTokens" as="xs:string*"/>
        <xsl:if test="false()">
            <xsl:message> + DEBUG: doctales:analyzePathTokens(): Starting...</xsl:message>
            <xsl:message> + DEBUG: sourceTokens=<xsl:value-of select="string-join($sourceTokens, ',')"/></xsl:message>
            <xsl:message> + DEBUG: targetTokens=<xsl:value-of select="string-join($targetTokens, ',')"/></xsl:message>
            <xsl:message> + DEBUG: resultTokens=<xsl:value-of select="string-join($resultTokens, ',')"/></xsl:message>
        </xsl:if>
        <xsl:sequence
            select="if (count($sourceTokens) = 0 and count($targetTokens) = 0)
            then $resultTokens
            else if (count($sourceTokens) = 0)
            then trace(($resultTokens, $targetTokens), ' + DEBUG: count(sourceTokens) = 0')
            else if (string($sourceTokens[1]) != string($targetTokens[1]))
            then doctales:analyzePathTokens($sourceTokens[position() > 1], $targetTokens, ($resultTokens, '..'))
            else doctales:analyzePathTokens($sourceTokens[position() > 1], $targetTokens[position() > 1], $resultTokens)"/>
    </xsl:function>

</xsl:stylesheet>
