<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:dtl="http://doctales.github.io"
    exclude-result-prefixes="xs xd" version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <!-- Language of the messages -->
    <xsl:param name="language" required="yes"/>

    <xsl:function name="dtl:getString">
        <xsl:param name="language"/>
        <xsl:param name="name"/>
        <xsl:variable name="file">
            <xsl:text>termchecker-strings-</xsl:text>
            <xsl:value-of select="$language"/>
            <xsl:text>.xml</xsl:text>
        </xsl:variable>
        <xsl:sequence select="document($file)/descendant::str[@name = $name]"/>
    </xsl:function>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
            <sch:title>
                <xsl:value-of select="dtl:getString($language, 'Title')"/>
            </sch:title>
            <xsl:apply-templates/>
        </sch:schema>
    </xsl:template>

    <xsl:function name="dtl:generateId" as="xs:string?">
        <xsl:param name="baseString" as="xs:string?"/>
        <xsl:param name="prefixString" as="xs:string?"/>
        <xsl:param name="id" as="xs:string?"/>
        <xsl:variable name="idStage1"
            select="
                lower-case(replace(replace(replace(replace(replace(replace(replace(replace($baseString, 'ä', 'ae')
                , 'ö', 'oe')
                , 'ü', 'ue')
                , 'Ä', 'Ae')
                , 'Ö', 'Oe')
                , 'Ü', 'Ue')
                , 'ß', 'ss')
                , '[^0-9a-zA-Z]', ' '))"/>
        <xsl:variable name="idStage2"
            select="concat(upper-case(substring($idStage1, 1, 1)), substring($idStage1, 2), ' '[not(last())])"/>
        <xsl:variable name="idStage3"
            select="
                replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace($idStage2, ' a', ' A'), ' b', ' B')
                , ' d', ' D')
                , ' c', ' C')
                , ' e', ' E')
                , ' f', ' F')
                , ' g', ' G')
                , ' h', ' H')
                , ' i', ' I')
                , ' j', ' J')
                , ' k', ' K')
                , ' l', ' L')
                , ' m', ' M')
                , ' n', ' N')
                , ' o', ' O')
                , ' p', ' P')
                , ' q', ' Q')
                , ' r', ' R')
                , ' s', ' S')
                , ' t', ' T')
                , ' u', ' U')
                , ' v', ' V')
                , ' w', ' W')
                , ' x', ' X')
                , ' y', ' Y')
                , ' z', ' Z')
                , '[^0-9a-zA-Z]', '')"/>
        <xsl:variable name="idStage4" select="concat(normalize-space($prefixString), $idStage3)"/>
        <xsl:sequence select="concat($idStage4, $id)"/>
    </xsl:function>

    <xsl:template name="createSqfFix">
        <xsl:param name="notRecommendedTerm"/>
        <xsl:param name="termLanguage"/>
        <xsl:param name="definition"/>
        <xsl:param name="uppercase"/>
        <xsl:param name="beginning"/>
        <xsl:variable name="allowedTerm">
            <xsl:value-of select="termVariant[1]" />
        </xsl:variable>
        <xsl:variable name="allowedTermReplace">
            <xsl:choose>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'false'">
                    <xsl:value-of select="concat(upper-case(substring(termVariant[1], 1, 1)), substring(termVariant[1], 2), ' '[not(last())])"/>
                </xsl:when>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'true'">
                    <xsl:value-of select="concat('. ', concat(upper-case(substring(termVariant[1], 1, 1)), substring(termVariant[1], 2), ' '[not(last())]))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="termVariant[1]" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="notRecommendedReplace">
            <xsl:choose>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'true'">
                    <xsl:value-of select="concat('\. ', $notRecommendedTerm)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$notRecommendedTerm" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="sqfTitle">
            <xsl:choose>
                <xsl:when test="self::*[contains(@class, ' termentry/fullForm ')]">
                    <xsl:value-of select="dtl:getString($language, 'ReplaceWithAllowedTerm')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/abbreviation ')]">
                    <xsl:value-of
                        select="dtl:getString($language, 'ReplaceWithAllowedAbbreviation')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/acronym ')]">
                    <xsl:value-of select="dtl:getString($language, 'ReplaceWithAllowedAcronym')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="counter" select="position()"/>
        <xsl:variable name="quickFixId">
            <xsl:choose>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'false'">
                    <xsl:value-of select="concat(dtl:generateId($notRecommendedTerm, 'term', generate-id()), concat($counter, '_up'))"/>
                </xsl:when>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'true'">
                    <xsl:value-of select="concat(dtl:generateId($notRecommendedTerm, 'term', generate-id()), concat($counter, '_up_sentence'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(dtl:generateId($notRecommendedTerm, 'term', generate-id()), $counter)" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--<xsl:variable name="quickFixId"
            select="concat(dtl:generateId($notRecommendedTerm, 'term', generate-id()), $counter)"/>-->

        <!-- FIXME: This uses the first termVariant but should use all and respect the flection of the notRecommended term. -->
        <xsl:variable name="allowedFullForm" select="normalize-space(.)"/>
        <xsl:element name="sqf:fix">
            <xsl:attribute name="id" select="$quickFixId"/>
            <xsl:element name="sqf:description">
                <xsl:element name="sqf:title">
                    <xsl:value-of select="normalize-space($sqfTitle)"/>
                </xsl:element>
                <xsl:choose>
                    <xsl:when test="$definition != ''">
                        <xsl:element name="sqf:p">
                            <xsl:value-of select="$definition"/>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:element>
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:value-of select="$notRecommendedReplace"/>
                </xsl:attribute>
                <xsl:value-of select="$allowedTermReplace"/>
            </xsl:element>
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