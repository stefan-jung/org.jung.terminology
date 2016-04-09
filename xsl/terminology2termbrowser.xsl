<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:math="http://exslt.org/math" extension-element-prefixes="math"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs" version="2.0">
    
    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    
    <xsl:output method="html"
        encoding="UTF-8"
        indent="yes"
        doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="doc" select="/"/>
    <xsl:variable name="termNotation" select="//*[contains (@class, ' termentry/termNotation ')]"/>
    <xsl:variable name="fullForm" select="//*[contains (@class, ' termentry/fullForm ')]"/>
    <xsl:variable name="abbreviation" select="//*[contains (@class, ' termentry/abbreviation ')]"/>
    <xsl:variable name="acronym" select="//*[contains (@class, ' termentry/acronym ')]"/>
    <xsl:variable name="verb" select="//*[contains (@class, ' termentry/verb ')]"/>
    <xsl:variable name="termLanguages" select="//*[contains (@class, ' termentry/termNotation ')]/@language"/>
    
    <!--<xsl:key name="fullForm" use="@usage" match="//*[contains(@class, ' termentry/fullForm ')][@usage]"/>-->
    <!--<xsl:key name="fullFormEnglish" use="@usage" match="//*[contains(@class, ' termentry/fullForm ')][contains(@language, 'en')][@usage]"/>-->
    
    <xsl:function name="doctales:countTermsOfLanguage">
        <xsl:param name="language" as="xs:string"/>
        <xsl:value-of select="count($doc//*[contains (@class, ' termentry/termNotation ')][@language = $language])"/>
    </xsl:function>
    
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Terminology</title>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.16/d3.js"></script>
                <script src="js/d3pie.min.js"></script>
            </head>
            <body>
                <xsl:call-template name="countTerms"/>
                <xsl:call-template name="countTermLanguages"/>
                
                <xsl:apply-templates/>    
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="countTerms">
        <div id="pieChart"></div>
        <script>
            var pie = new d3pie("pieChart", {
            "header": {
            "title": {
            "text": "Term Variants",
            "fontSize": 24,
            "font": "open sans"
            },
            "subtitle": {
            "text": "A full pie chart to show the number of term variants.",
            "color": "#999999",
            "fontSize": 12,
            "font": "open sans"
            },
            "titleSubtitlePadding": 9
            },
            "footer": {
            "color": "#999999",
            "fontSize": 10,
            "font": "open sans",
            "location": "bottom-left"
            },
            "size": {
            "canvasWidth": 590,
            "pieOuterRadius": "90%"
            },
            "data": {
            "sortOrder": "value-desc",
            "content": [
            {
            "label": "Full Form (<xsl:value-of select="count($fullForm)"/>)",
            "value": <xsl:value-of select="count($fullForm)"/>,
            "color": "#2484c1"
            },
            {
            "label": "Abbreviation (<xsl:value-of select="count($abbreviation)"/>)",
            "value": <xsl:value-of select="count($abbreviation)"/>,
            "color": "#0c6197"
            },
            {
            "label": "Acronym (<xsl:value-of select="count($acronym)"/>)",
            "value": <xsl:value-of select="count($acronym)"/>,
            "color": "#4daa4b"
            },
            {
            "label": "Verb (<xsl:value-of select="count($verb)"/>)",
            "value": <xsl:value-of select="count($verb)"/>,
            "color": "#90c469"
            }
            ]
            },
            "labels": {
            "outer": {
            "pieDistance": 32
            },
            "inner": {
            "hideWhenLessThanPercentage": 3
            },
            "mainLabel": {
            "fontSize": 11
            },
            "percentage": {
            "color": "#ffffff",
            "decimalPlaces": 0
            },
            "value": {
            "color": "#adadad",
            "fontSize": 11
            },
            "lines": {
            "enabled": true
            },
            "truncation": {
            "enabled": true
            }
            },
            "effects": {
            "pullOutSegmentOnClick": {
            "effect": "linear",
            "speed": 400,
            "size": 8
            }
            },
            "misc": {
            "gradient": {
            "enabled": true,
            "percentage": 100
            }
            }
            });
        </script>
    </xsl:template>
    
    <xsl:template name="countTermLanguages">
        <div id="pieChartTermLanguages"></div>
        <script>
            var pie = new d3pie("pieChart", {
            "header": {
            "title": {
            "text": "Term Variants",
            "fontSize": 24,
            "font": "open sans"
            },
            "subtitle": {
            "text": "A full pie chart to show the term languages.",
            "color": "#999999",
            "fontSize": 12,
            "font": "open sans"
            },
            "titleSubtitlePadding": 9
            },
            "footer": {
            "color": "#999999",
            "fontSize": 10,
            "font": "open sans",
            "location": "bottom-left"
            },
            "size": {
            "canvasWidth": 590,
            "pieOuterRadius": "90%"
            },
            "data": {
            "sortOrder": "value-desc",
            "content": [
                <xsl:variable name="languages" select="distinct-values($termLanguages)"/>
                <xsl:for-each select="$languages">
                    <xsl:variable name="vPosition" select="position()"/>
                    <xsl:variable name="currentLanguage" select="$languages[$vPosition]"/>
                    <xsl:variable name="numberOfTerms" select="doctales:countTermsOfLanguage($currentLanguage)"/>
                    {
                    "label": "<xsl:value-of select="$currentLanguage"/> (<xsl:value-of select="$numberOfTerms"/>)",
                    "value": <xsl:value-of select="$numberOfTerms"/>,
                    "color": "#90c469"
                    },
                </xsl:for-each>
            ]
            },
            "labels": {
            "outer": {
            "pieDistance": 32
            },
            "inner": {
            "hideWhenLessThanPercentage": 3
            },
            "mainLabel": {
            "fontSize": 11
            },
            "percentage": {
            "color": "#ffffff",
            "decimalPlaces": 0
            },
            "value": {
            "color": "#adadad",
            "fontSize": 11
            },
            "lines": {
            "enabled": true
            },
            "truncation": {
            "enabled": true
            }
            },
            "effects": {
            "pullOutSegmentOnClick": {
            "effect": "linear",
            "speed": 400,
            "size": 8
            }
            },
            "misc": {
            "gradient": {
            "enabled": true,
            "percentage": 100
            }
            }
            });
        </script>
    </xsl:template>
    
    <xsl:function name="doctales:generateId" as="xs:string?">
        <xsl:param name="baseString" as="xs:string?"/>
        <xsl:param name="prefixString" as="xs:string?"/>
        <xsl:variable name="idStage1" select="lower-case(replace(replace(replace(replace(replace(replace(replace(replace($baseString, 'ä', 'ae')
            , 'ö', 'oe')
            , 'ü', 'ue')
            , 'Ä', 'Ae')
            , 'Ö', 'Oe')
            , 'Ü', 'Ue')
            , 'ß', 'ss')
            , '[^0-9a-zA-Z]', ' '))"/>
        <xsl:variable name="idStage2" select="concat(upper-case(substring($idStage1,1,1)), substring($idStage1, 2),' '[not(last())])"/>                                                      
        <xsl:variable name="idStage3" select="
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
        <xsl:sequence select="concat(normalize-space($prefixString), $idStage3)"/> 
    </xsl:function>
    
    <!-- Empty template to avoid the processing of the termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]"/>

    
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
