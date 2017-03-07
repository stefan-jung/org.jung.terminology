<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs xd" version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <!-- Language of the messages -->
    <xsl:param name="language" required="yes"/>

    <xsl:function name="doctales:getString" as="xs:string">
        <xsl:param name="language"/>
        <xsl:param name="name"/>
        <xsl:variable name="file">
            <xsl:text>termchecker-strings-</xsl:text>
            <xsl:value-of select="$language"/>
            <xsl:text>.xml</xsl:text>
        </xsl:variable>
        <xsl:sequence select="document($file)/descendant::str[@name = $name]"/>
    </xsl:function>
    
    <!-- If the language code contains both language and region code, e.g. 'en-GB', return the language code, e.g. 'en', otherwise 'null' -->
    <xsl:function name="doctales:getLanguageCodeFromLanguageRegionCode" as="xs:string">
        <xsl:param name="languageRegionCode"/>
        <xsl:variable name="languageCode">
            <xsl:choose>
                <xsl:when test="contains($languageRegionCode, '-')">
                    <xsl:value-of select="substring-before($languageRegionCode, '-')"/>
                </xsl:when>
                <xsl:otherwise>
                    null
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$languageCode"/>
    </xsl:function>
    
    <!--
        Generate language match rule. If the language parameter contains both language and region code, 
        return "@language = 'en' or @language = 'en-GB'",
        otherwise return "@language = 'en'"
    --> 
    <xsl:function name="doctales:getLanguageMatchRule" as="xs:string">
        <xsl:param name="languageRegionCode"/>
        <xsl:variable name="languageCode" select="doctales:getLanguageCodeFromLanguageRegionCode($languageRegionCode)"/>
        <xsl:variable name="languageMatchRule">
            <xsl:choose>
                <xsl:when test="contains($languageCode, 'null')">
                    <xsl:text>@language = '</xsl:text>
                    <xsl:value-of select="$languageRegionCode"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>@language = '</xsl:text>
                    <xsl:value-of select="$languageCode"/>
                    <xsl:text>' or @language = '</xsl:text>
                    <xsl:value-of select="$languageRegionCode"/>
                    <xsl:text>'</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$languageMatchRule"/>
    </xsl:function>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
            <sch:title>
                <xsl:value-of select="doctales:getString($language, 'Title')"/>
            </sch:title>
            <sch:pattern>
                <sch:rule context="*/text()"> 
                    <xsl:apply-templates/>
                </sch:rule>
            </sch:pattern>
        </sch:schema>
    </xsl:template>

    <xsl:function name="doctales:generateId" as="xs:string?">
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
            <xsl:variable name="normalizedNotRecommendedTerm">
              <xsl:value-of select="replace($notRecommendedTerm, '/', '\\/')"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'true'">
                    <xsl:value-of select="concat('\. ', $normalizedNotRecommendedTerm)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$normalizedNotRecommendedTerm" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="sqfTitle">
            <xsl:choose>
                <xsl:when test="self::*[contains(@class, ' termentry/fullForm ')]">
                    <xsl:value-of select="doctales:getString($language, 'ReplaceWithAllowedTerm')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/abbreviation ')]">
                    <xsl:value-of
                        select="doctales:getString($language, 'ReplaceWithAllowedAbbreviation')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/acronym ')]">
                    <xsl:value-of select="doctales:getString($language, 'ReplaceWithAllowedAcronym')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$allowedTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
              <xsl:when test="self::*[contains(@class, ' termentry/verb ')]">
                    <xsl:value-of select="doctales:getString($language, 'ReplaceWithAllowedVerb')"/>
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
                    <xsl:value-of select="concat(doctales:generateId($notRecommendedTerm, 'term', generate-id()), concat($counter, '_up'))"/>
                </xsl:when>
                <xsl:when test="$uppercase eq 'true' and $beginning eq 'true'">
                    <xsl:value-of select="concat(doctales:generateId($notRecommendedTerm, 'term', generate-id()), concat($counter, '_up_sentence'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(doctales:generateId($notRecommendedTerm, 'term', generate-id()), $counter)" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

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
            
            <!-- Lowercased -->
            
            <!-- <sqf:stringReplace regex="(\sfoo$)" select="' bar'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>$)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>' </xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text>'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(^foo\s)" select="'bar '"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(^</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\s)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text> '</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(^foo$)" select="'bar'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(^</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>$)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text>'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\s)" select="' bar '"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\s)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>' </xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text> '</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\.)|(^foo\.)" select="'bar.'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\.)|(^</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\.)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text>.'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\?)|(^foo\?)" select="'bar?'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\?)|(^</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\?)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text>?'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\!)|(^foo\!)" select="'bar!'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\!)|(^</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\!)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text>!'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\;)|(^foo\;)" select="'bar;'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\;)|(^</xsl:text><xsl:value-of select="$notRecommendedReplace"/><xsl:text>\;)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$allowedTermReplace"/><xsl:text>;'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            
            
            <!-- Uppercased -->
            
            <xsl:variable name="uppercasedNotRecommendedTerm" select="concat(upper-case(substring($notRecommendedReplace,1,1)), substring($notRecommendedReplace, 2), ' '[not(last())])"/>
            <xsl:variable name="uppercasedRecommendedTerm" select="concat(upper-case(substring($allowedTermReplace,1,1)), substring($allowedTermReplace, 2), ' '[not(last())])"/>
            
            <!-- <sqf:stringReplace regex="(\sfoo$)" select="' bar'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>$)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>' </xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text>'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(^foo\s)" select="'bar '"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(^</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\s)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text> '</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(^foo$)" select="'bar'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(^</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>$)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text>'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\s)" select="' bar '"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\s)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>' </xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text> '</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\.)|(^foo\.)" select="'bar.'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\.)|(^</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\.)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text>.'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\?)|(^foo\?)" select="'bar?'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\?)|(^</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\?)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text>?'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\!)|(^foo\!)" select="'bar!'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\!)|(^</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\!)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text>!'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- <sqf:stringReplace regex="(\sfoo\;)|(^foo\;)" select="'bar;'"/> -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\s</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\;)|(^</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>\;)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedRecommendedTerm"/><xsl:text>;'</xsl:text>
                </xsl:attribute>
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
    
    <!-- Check if the not recommended term is uppercased -->
    <xsl:function name="doctales:isLowercased" as="xs:boolean">
        <xsl:param name="term"/>
        <xsl:sequence select="contains('abcdefghijklmnopqrstuvwxyz', substring($term, 1, 1))"/>
    </xsl:function>

</xsl:stylesheet>