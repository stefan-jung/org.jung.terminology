<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="related-links sj xd xs">
    
    <xsl:param name="ditamap"/>
    
    <xsl:template match="*[contains(@class, ' semanticnet-d/net ')]">
        <div id="search">
            <div class="form">
                <div class="form-group row">
                    <label for="search-input" class="col-form-label">
                        <xsl:value-of select="sj:getString($language, 'Term Notation')"/>
                    </label>
                    <input id="search-input" class="form-control autocomplete" type="text"><!-- --></input>
                    <button type="button" class="btn btn-default semantic-search-button" onclick="termFocus(document.getElementById('search-input').value.toLowerCase());">
                        <xsl:value-of select="sj:getString($language, 'Search')"/>
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
        
        <div id="legend">
            <table class="table table-striped table-bordered table-hover table-condensed">
                <tr>
                    <td class="legend_col1">
                        <xsl:value-of select="sj:getString($language, 'Term')"/>
                    </td>
                    <td class="legend_col2">
                        <div id="t_term">
                            <a id="term-link"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="legend_col1">
                        <xsl:value-of select="sj:getString($language, 'Definition')"/>
                    </td>
                    <td class="legend_col2">
                        <div id="t_definition"/>
                    </td>
                </tr>
            </table>
        </div>
        
        <script type="text/javascript">
            
            var nodes = null;
            var edges = null;
            var network = null;
            
            nodes = [<xsl:apply-templates select="document($ditamap)" mode="semantic-net-nodes"/>];
            edges = [<xsl:apply-templates select="document($ditamap)" mode="semantic-net-edges"/>];
            
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
                        shape: 'box'
                    }
                }
            };
                            
            var network = new vis.Network(container, data, options);
             
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
             
            network.on('click', function(params) {
                if (!(params.nodes == 0)) {
                    loadTerm(params.nodes);
                }
            });
                 
            var terms = [<xsl:apply-templates select="document($ditamap)" mode="semantic-net-legend"/>];
            
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
            
            document.addEventListener("DOMContentLoaded", function() {
                var data = [<xsl:apply-templates select="document($ditamap)" mode="semantic-net-search"/>];
                $( "#search-input" ).autocomplete({source: data});
            });
            
            function termFocus(term) {
                console.log("termFocus");
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
    </xsl:template>
    
    <!-- Generate data set for autocomplete search box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="semantic-net-search">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename"/>
        <xsl:variable name="label" select="sj:jsonEscape(document($filepath)/termentry/title[1]/text()[1])"/>
        <xsl:variable name="delim" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ',' else ''" as="xs:string"/>
        <xsl:value-of select="'''' || $label || '''' || $delim || ' '"/>
    </xsl:template>
    
    <!-- Generate nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="semantic-net-nodes">
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename"/>
        <xsl:variable name="label" select="sj:jsonEscape(document($filepath)/termentry/title[1]/text()[1])"/>
        <xsl:variable name="delim" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ', ' else ' '" as="xs:string"/>
        <xsl:value-of select="'{id: ''' || $key || ''', label: ''' || $label || '''}' || $delim"/>
    </xsl:template>
    
    <!-- Generate edges between nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="semantic-net-edges">
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename" as="xs:string"/>
        
        <xsl:if test="document($filepath)/descendant::*[contains(@class, ' termentry/termRelation ')]">
            <xsl:for-each select="document($filepath)/descendant::*[
                contains(@class, 'termentry/antonym') 
                or contains(@class, 'termentry/hypernym')
                or contains(@class, 'termentry/hyponym')
                or contains(@class, 'termentry/instaceOf')
                or contains(@class, 'termentry/partOf')
                or contains(@class, 'termentry/relatedTerm')]">
                <xsl:variable name="relationString" select="
                    if (contains(@class, 'antonym')) then 'IsAntonymOf'
                    else if (contains(@class, 'hypernym')) then 'IsHypernymOf'
                    else if (contains(@class, 'hyponym')) then 'IsHyponymOf'
                    else if (contains(@class, 'instanceOf')) then 'IsInstanceOf'
                    else if (contains(@class, 'partOf')) then 'IsPartOf'
                    else if (contains(@class, 'relatedTerm')) then 'IsRelatedTo'
                    else 'IsRelatedTo'
                    "/>
                <xsl:variable name="labelString" select="
                    if (contains(@class, 'antonym')) then 'Is Antonym Of'
                    else if (contains(@class, 'hypernym')) then 'Is Hypernym Of'
                    else if (contains(@class, 'hyponym')) then 'Is Hyponym Of'
                    else if (contains(@class, 'instanceOf')) then 'Is Instance Of'
                    else if (contains(@class, 'partOf')) then 'Is Part Of'
                    else if (contains(@class, 'relatedTerm')) then 'Is Related To'
                    else 'Is Related To'
                    "/>
                <xsl:variable name="keyref" select="lower-case(@keyref)" as="xs:string"/>
                <xsl:if test="$debugging.mode = 'true'">
                    <xsl:message select="'[DEBUG]: sj:getString(' || $language || ', ' || $labelString || ')'"/>
                </xsl:if>
                <xsl:if test="$key != '' and @keyref != ''">
                    <xsl:value-of select="'{id: ''' || $keyref || $key || ''', from: ''' || $keyref || ''', to : ''' || $key || ''', arrows: ''to'', label: ''' || sj:getString($language, $labelString) || '''}, '"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <!-- Load term metadata for the legend box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="semantic-net-legend">
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename" as="xs:string"/>
        <xsl:variable name="label" select="document($filepath)/termentry/title[1]/text()[1]"/>
        
        <xsl:value-of select="'{key: ''' || $key || ''', term: ' || '''' || $label || '''' || ', definition: ''' || sj:jsonEscape(document($filepath)/descendant::*[contains(@class, ' termentry/definitionText ')]) || ''', href: ''' || replace(normalize-unicode($filename), '.dita', '.html') || '''}, '"/>
    </xsl:template>
    
    <!-- Fall Through Templates -->
    <xsl:template match="*[contains(@class, ' topic/title ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' bookmap/mainbooktitle ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    
    <!-- Escape or remove conflicting characters -->
    <xsl:function name="sj:jsonEscape" as="xs:string" visibility="private">
        <xsl:param name="str" as="xs:string"/>
        <xsl:variable name="s" select="normalize-space($str)"/>
        <xsl:variable name="quot" select="'&quot;'" as="xs:string"/>
        <xsl:variable name="quot-escaped" select="'\\' || $quot"/>
        <xsl:variable name="apos" as="xs:string">'</xsl:variable>
        <xsl:variable name="apos-escaped" select="'\\' || $apos" as="xs:string"/>
        <xsl:variable name="out" select="normalize-space(replace(replace($s, $quot, $quot-escaped), $apos, $apos-escaped))"/>
        <xsl:if test="$debugging.mode = 'true' and $s != $out">
            <xsl:message> [DEBUG] sj:jsonEscape(): Escaped literals in string</xsl:message>
            <xsl:message> [DEBUG] INPUT:  <xsl:value-of select="$s"/></xsl:message>
            <xsl:message> [DEBUG] OUTPUT: <xsl:value-of select="$out"/></xsl:message>
        </xsl:if>
        <xsl:sequence select="$out"/>
    </xsl:function>
</xsl:stylesheet>