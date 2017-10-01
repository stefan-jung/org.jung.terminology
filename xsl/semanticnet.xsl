<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
    
    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <xsl:import href="termbrowser-utility.xsl"/>
    
    <xsl:output method="html"
        encoding="UTF-8"
        indent="no"
        doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:param name="language"/>
    
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:function name="doctales:normalize">
        <xsl:param name="string"/>
        <xsl:variable name="dq">"</xsl:variable>
        <xsl:variable name="sq">'</xsl:variable>
        <xsl:variable name="return" select="normalize-space(replace(replace($string, $dq, ''), $sq, ''))"/>
        <xsl:sequence select="$return"/>
    </xsl:function>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"><!----></meta>
                <title>Terminology Net</title>
                <xsl:value-of select="$newline"/>
                <style type="text/css">
                    body {
                        font: 10pt arial;
                    }
                    #mynetwork {
                        width: 960px;
                        height: 540px;
                        border: 1px solid lightgray;
                    }
                    #loadingBar {
                        position: absolute;
                        top: 0px;
                        left: 0px;
                        width: 960px;
                        height: 540px;
                        background-color: rgba(200,200,200,0.8);
                        -webkit-transition: all 0.5s ease;
                        -moz-transition: all 0.5s ease;
                        -ms-transition: all 0.5s ease;
                        -o-transition: all 0.5s ease;
                        transition: all 0.5s ease;
                        opacity: 1;
                    }
                    #wrapper {
                        position: relative;
                        width: 960px;
                        height: 540px;
                    }
                    #text {
                        position: absolute;
                        top: 8px;
                        left: 530px;
                        width: 30px;
                        height: 50px;
                        margin: auto auto auto auto;
                        font-size: 22px;
                        color: #000000;
                    }
                    div.outerBorder {
                        position: relative;
                        top: 400px;
                        width: 600px;
                        height: 44px;
                        margin: auto auto auto auto;
                        border: 8px solid rgba(0,0,0,0.1);
                        background: rgb(252,252,252); /* Old browsers */
                        background: -moz-linear-gradient(top,  rgba(252,252,252,1) 0%, rgba(237,237,237,1) 100%); /* FF3.6+ */
                        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(252,252,252,1)), color-stop(100%,rgba(237,237,237,1))); /* Chrome,Safari4+ */
                        background: -webkit-linear-gradient(top,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* Chrome10+,Safari5.1+ */
                        background: -o-linear-gradient(top,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* Opera 11.10+ */
                        background: -ms-linear-gradient(top,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* IE10+ */
                        background: linear-gradient(to bottom,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* W3C */
                        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fcfcfc', endColorstr='#ededed',GradientType=0 ); /* IE6-9 */
                        border-radius: 72px;
                        box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
                    }
                    #border {
                        position: absolute;
                        top: 10px;
                        left: 10px;
                        width: 500px;
                        height: 23px;
                        margin: auto auto auto auto;
                        box-shadow: 0px 0px 4px rgba(0,0,0,0.2);
                        border-radius: 10px;
                    }
                    #bar {
                        position: absolute;
                        top: 0px;
                        left: 0px;
                        width: 20px;
                        height: 20px;
                        margin: auto auto auto auto;
                        border-radius: 11px;
                        border: 2px solid rgba(30,30,30,0.05);
                        background: rgb(0, 173, 246); /* Old browsers */
                        box-shadow: 2px 0px 4px rgba(0,0,0,0.4);
                    }
                    #legend {
                        margin-top: 1.2em;
                    }
                </style>
                <xsl:value-of select="$newline"/>
                
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.17.0/vis.min.js"><!-- --></script>
                <xsl:value-of select="$newline"/>
                <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.17.0/vis.min.css"><!-- --></link>
                
                <script type="text/javascript">
                    var nodes = null;
                    var edges = null;
                    var network = null;
                    function draw() {
                        nodes = [<xsl:apply-templates mode="nodes"/>];
                        edges = [<xsl:apply-templates mode="edges"/>];
                        var mainId = 5;
                        var container = document.getElementById('mynetwork');
                        var data = {
                            nodes: nodes,
                            edges: edges
                        };
                        var options = {
                            interaction: {
                                hover: true
                            },
                            edges: {
                                width: 2,
                                arrows: 'to',
                                color: 'gray'
                            },
                            layout: {
                                improvedLayout: false
                            },
                            physics: {
                                forceAtlas2Based: {
                                    gravitationalConstant: -26,
                                    centralGravity: 0.005,
                                    springLength: 230,
                                    springConstant: 0.18
                                },
                                maxVelocity: 146,
                                solver: 'forceAtlas2Based',
                                timestep: 0.35,
                                stabilization: {
                                    enabled: true,
                                    iterations: 2000,
                                    updateInterval: 25
                                }
                            },
                            groups: {
                                term: {
                                    radius: 1500,
                                    color: {
                                        border: '#004455',
                                        background: '#5fbcd3',
                                        fontColor: '#ffffff',
                                        hover: {
                                            border: '#004455',
                                            background: '#beebee',
                                            fontColor: '#ffffff'
                                        },
                                        highlight: {
                                            border: '#a5ecfd',
                                            background: '#beeec0',
                                            fontColor: '#ffffff'
                                        }
                                    },
                                    fontSize: 18,
                                    fontFace: 'arial',
                                    shape: 'box',
                                }
                            }
                        };
                        network = new vis.Network(container, data, options);
                        network.on("stabilizationProgress", function(params) {
                            var maxWidth = 496;
                            var minWidth = 20;
                            var widthFactor = params.iterations/params.total;
                            var width = Math.max(minWidth,maxWidth * widthFactor);
                            document.getElementById('bar').style.width = width + 'px';
                            document.getElementById('text').innerHTML = Math.round(widthFactor*100) + '%';
                        });
                        network.once("stabilizationIterationsDone", function() {
                            document.getElementById('text').innerHTML = '100%';
                            document.getElementById('bar').style.width = '496px';
                            document.getElementById('loadingBar').style.opacity = 0;
                            setTimeout(function () {document.getElementById('loadingBar').style.display = 'none';}, 500);
                        });
                        network.on( 'click', function(params) {
                            if (!(params.nodes == 0)) {
                                loadTerm(params.nodes);
                            }
                        });
                    }
                    
                    var terms = [<xsl:apply-templates mode="termmeta"/>];
                        function loadTerm(key) {
                        var result = terms.filter(function(obj) {
                        return obj.key == key;
                    });
                    
                    var node = document.createElement("a");
                    var textnode = document.createTextNode(result[0].term);
                    node['href'] = result[0].href;
                    node['target'] = '_self';
                    node.appendChild(textnode);
                    
                    var termContainer = document.getElementById("t_term");
                    while (termContainer.firstChild) {
                        termContainer.removeChild(termContainer.firstChild);
                    }
                    termContainer.appendChild(node);
                        document.getElementById("t_definition").textContent = result[0].definition;
                    }
                </script>
            <!--<script type="text/javascript">
                if (document.addEventListener) { // IE >= 9; other browsers
                document.addEventListener('contextmenu', function(e) {
                alert("You've tried to open context menu"); //here you draw your own menu
                e.preventDefault();
                }, false);
                } else { // IE < 9
                     document.attachEvent('oncontextmenu', function() {
                         alert("You've tried to open context menu");
                         window.event.returnValue = false;
                     });
                 }
               </script>-->
            </head>
            <body>
                <div id="search">
                    <div class="form">
                        <div class="form-group row">
                            <label for="search-input" class="col-form-label">
                                <xsl:value-of select="doctales:getString($language, 'Term Notation')"/>
                            </label>
                            <input id="search-input" class="form-control autocomplete" type="text"><!----></input>
                            <button type="button" class="btn btn-default semantic-search-button" onclick="termFocus($('.autocomplete').val());">
                                <xsl:value-of select="doctales:getString($language, 'Search')"/>
                            </button>
                        </div>
                    </div>
                </div>
                <div id="wrapper">
                    <div id="mynetwork">
                        <div class="vis network-frame" style="position: relative; overflow: hidden; user-select: none; touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); width: 100%; height: 100%;">
                            <canvas width="960" height="540" style="position: relative; user-select: none; touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); width: 100%; height: 100%;"/>
                        </div>
                    </div>
                    <div id="loadingBar">
                        <div class="outerBorder">
                            <div id="text">0%</div>
                            <div id="border">
                                <div id="bar"/>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    $(function() {
                        draw();
                    });
                </script>
                <script>
                    $(document).ready(function() {
                        var data = [<xsl:apply-templates mode="search"/>];
                        $(".autocomplete").autocomplete({
                            source: data
                        });
                    });
                    
                    function termFocus(term) {
                        network.fit();
                        var focusOptions = {
                            scale: 0.7,
                            locked: 'false',
                            animation: {
                                duration: 10,
                                easingFunction: 'easeInQuad'
                            }
                        };
                        network.focus(term, focusOptions);
                        network.selectNodes([term])
                    }
                </script>
                <div id="legend">
                    <table class="table table-striped table-bordered table-hover table-condensed">
                        <tr>
                            <td class="legend_col1">
                                <xsl:value-of select="doctales:getString($language, 'Term')"/>
                            </td>
                            <td class="legend_col2"><div id="t_term"><a id=""/></div></td>
                        </tr>
                        <tr>
                            <td class="legend_col1">
                                <xsl:value-of select="doctales:getString($language, 'Definition')"/>
                            </td>
                            <td class="legend_col2"><div id="t_definition"/></td>
                        </tr>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Generate data set for autocomplete search box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="search">
        <xsl:text>{value:'</xsl:text><xsl:value-of select="@keys"/><xsl:text>',</xsl:text>
        <xsl:text>label:'</xsl:text><xsl:value-of select="descendant::*[contains(@class, ' topic/navtitle ')][1]"/><xsl:text>'}</xsl:text>
        <xsl:choose>
            <xsl:when test="following-sibling::*[contains(@class, ' termmap/termref ')]">
                <xsl:text>,</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Generate nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="nodes">
        <xsl:text>{id: '</xsl:text>
        <xsl:value-of select="@keys"/>
        <xsl:text>', label: '</xsl:text>
        <xsl:value-of select="descendant::*[contains(@class, ' topic/navtitle ')][1]"/>
        <xsl:text>', shape: 'box', group: 'term'}</xsl:text>
        <xsl:choose>
            <xsl:when test="following-sibling::*[contains(@class, ' termmap/termref ')]">
                <xsl:text>,</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Generate edges between nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="edges">
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="filename" select="@href"/>
        <xsl:if test="document(./$filename)/descendant::*[contains(@class, ' termentry/termRelation ')]">
            <!-- antonym -->
            <xsl:for-each select="document(./$filename)/descendant::*[contains(@class, ' termentry/antonym ')]">
                <xsl:text>{id: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>2</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', from: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', to: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', arrows: 'to', label: '</xsl:text>
                <xsl:value-of select="doctales:getString($language, 'Is Antonym Of')"/>
                <xsl:text>'},</xsl:text>
            </xsl:for-each>
            <!-- hypernym -->
            <xsl:for-each select="document(./$filename)/descendant::*[contains(@class, ' termentry/hypernym ')]">
                <xsl:text>{id: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>2</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', from: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', to: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', arrows: 'to', label: '</xsl:text>
                <xsl:value-of select="doctales:getString($language, 'Is Hypernym Of')"/>
                <xsl:text>'},</xsl:text>
            </xsl:for-each>
            <!-- hyponym -->
            <xsl:for-each select="document(./$filename)/descendant::*[contains(@class, ' termentry/hyponym ')]">
                <xsl:text>{id: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>2</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', from: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', to: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', arrows: 'to', label: '</xsl:text>
                <xsl:value-of select="doctales:getString($language, 'Is Hyponym Of')"/>
                <xsl:text>'},</xsl:text>
            </xsl:for-each>
            <!-- instanceOf -->
            <xsl:for-each select="document(./$filename)/descendant::*[contains(@class, ' termentry/instanceOf ')]">
                <xsl:text>{id: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>2</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', from: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', to: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', arrows: 'to', label: '</xsl:text>
                <xsl:value-of select="doctales:getString($language, 'Is Instance Of')"/>
                <xsl:text>'},</xsl:text>
            </xsl:for-each>
            <!-- partOf -->
            <xsl:for-each select="document(./$filename)/descendant::*[contains(@class, ' termentry/partOf ')]">
                <xsl:text>{id: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>2</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', from: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', to: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', arrows: 'to', label: '</xsl:text>
                <xsl:value-of select="doctales:getString($language, 'Is Part Of')"/>
                <xsl:text>'},</xsl:text>
            </xsl:for-each>
            <!-- relatedTerm -->
            <xsl:for-each select="document(./$filename)/descendant::*[contains(@class, ' termentry/relatedTerm ')]">
                <xsl:text>{id: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>2</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', from: '</xsl:text>
                <xsl:value-of select="@keyref"/>
                <xsl:text>', to: '</xsl:text>
                <xsl:value-of select="$key"/>
                <xsl:text>', arrows: 'to', label: '</xsl:text>
                <xsl:value-of select="doctales:getString($language, 'Is Related To')"/>
                <xsl:text>'},</xsl:text>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <!-- Load term metadata for the legend box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="termmeta">
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="term" select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]"/>
        <xsl:variable name="href" select="@href"/>
        <xsl:text>{key: '</xsl:text>
        <xsl:value-of select="$key"/>
        <xsl:text>', term: '</xsl:text>
        <xsl:value-of select="$term"/>
        <xsl:text>', definition: '</xsl:text>
        <xsl:variable name="definitionText">
            <xsl:value-of select="doctales:normalize(document(./$href)/descendant::*[contains(@class, ' termentry/definitionText ')])"/>
        </xsl:variable>
        <xsl:value-of select="normalize-unicode($definitionText)"/>
        <xsl:text>', href: '</xsl:text>
        <xsl:value-of select="replace(normalize-unicode($href), '.dita', '.html')"/>
        <xsl:text>'},</xsl:text>
    </xsl:template>
    
    <!-- Fall Through Templates -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]" mode="nodes edges termmeta search"/>
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]" mode="nodes edges termmeta search"/>
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]" mode="nodes edges termmeta search"/>
    <xsl:template match="*[contains(@class, ' bookmap/mainbooktitle ')]" mode="nodes edges termmeta search"/>

</xsl:stylesheet>
