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
    
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <html>
            <head>
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.16.0/vis.min.js"></script>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.16.0/vis.min.css" rel="stylesheet" type="text/css" />
                
                <style type="text/css">
                    #mynetwork {
                    width: 600px;
                    height: 400px;
                    border: 1px solid lightgray;
                    }
                </style>
            </head>
            <body>
                <div id="mynetwork"></div>
                
                <script type="text/javascript">
                    // create an array with nodes
                    var nodes = new vis.DataSet([
                    {id: 1, label: 'Node 1'},
                    {id: 2, label: 'Node 2'},
                    {id: 3, label: 'Node 3'},
                    {id: 4, label: 'Node 4'},
                    {id: 5, label: 'Node 5'}
                    ]);
                    
                    // create an array with edges
                    var edges = new vis.DataSet([
                    {from: 1, to: 3},
                    {from: 1, to: 2},
                    {from: 2, to: 4},
                    {from: 2, to: 5}
                    ]);
                    
                    // create a network
                    var container = document.getElementById('mynetwork');
                    
                    // provide the data in the vis format
                    var data = {
                    nodes: nodes,
                    edges: edges
                    };
                    var options = {};
                    
                    // initialize your network!
                    var network = new vis.Network(container, data, options);
                </script>
            </body>
        </html>
    </xsl:template>

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
