<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="related-links sj xd xs">
    
    <xsl:param name="ditamap"/>
    <!-- It seems this conflicts with a variable which has the same name in the Oxygen webhelp plugin. -->
    <!--<xsl:param name="debugging.mode" as="xs:string"/>-->
    
    <xsl:output method="xml" encoding="UTF-8" indent="true"/>
    
    <!-- Edges -->
    <!-- NOTE: Color codes are NOT suffixed with a semicolon. Write '#96c3ff', not '#96c3ff;'. -->
    <xsl:param name="term.semantic-net.edges.color" as="xs:string" select="'#5a6e82'"/>
    <xsl:param name="term.semantic-net.edges.width" as="xs:string" select="'1'"/>
    
    <!-- Layout -->
    <xsl:param name="term.semantic-net.layout.improvedLayout" as="xs:string" select="'true'"/>
    
    <!-- Physics -->
    <xsl:param name="term.semantic-net.physics.forceAtlas2Based.gravitationalConstant" as="xs:string" select="'-50'"/>
    <xsl:param name="term.semantic-net.physics.forceAtlas2Based.centralGravity" as="xs:string" select="'0.01'"/>
    <xsl:param name="term.semantic-net.physics.forceAtlas2Based.springLength" as="xs:string" select="'100'"/>
    <xsl:param name="term.semantic-net.physics.forceAtlas2Based.springConstant" as="xs:string" select="'0.08'"/>
    <xsl:param name="term.semantic-net.physics.stabilization.enabled" as="xs:string" select="'true'"/>
    <xsl:param name="term.semantic-net.physics.stabilization.iterations" as="xs:string" select="'1000'"/>
    <xsl:param name="term.semantic-net.physics.stabilization.updateInterval" as="xs:string" select="'50'"/>

    <!-- Term -->
    <!-- NOTE: Color codes are NOT suffixed with a semicolon. Write '#96c3ff', not '#96c3ff;'. -->
    <xsl:param name="term.semantic-net.term.border.color" as="xs:string" select="'#96c3ff'"/>
    <xsl:param name="term.semantic-net.term.border.width" as="xs:string" select="'1'"/>
    <xsl:param name="term.semantic-net.term.border.width.selected" as="xs:string" select="'2'"/>
    <xsl:param name="term.semantic-net.term.background" as="xs:string" select="'#96c3ff'"/>
    <xsl:param name="term.semantic-net.term.font.color" as="xs:string" select="'#323c46'"/>
    <xsl:param name="term.semantic-net.term.font.size" as="xs:string" select="'9'"/>
    <xsl:param name="term.semantic-net.term.font.face" as="xs:string" select="'Arial, sans-serif'"/>
    <xsl:param name="term.semantic-net.term.hover.border" as="xs:string" select="'2'"/>
    <xsl:param name="term.semantic-net.term.hover.background" as="xs:string" select="'#96c3ff'"/>
    <xsl:param name="term.semantic-net.term.hover.fontColor" as="xs:string" select="'#323c46'"/>
    <xsl:param name="term.semantic-net.term.highlight.border" as="xs:string" select="'#1471bb'"/>
    <xsl:param name="term.semantic-net.term.highlight.background" as="xs:string" select="'#96c3ff'"/>
    <xsl:param name="term.semantic-net.term.highlight.fontColor" as="xs:string" select="'#5a6e82'"/>
    
    
    <xsl:template match="*[contains(@class, ' semanticnet-d/net ')]">
        <div id="search">
            <div class="form">
                <div class="form-group row">
                    <label for="search-input" class="col-form-label">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Term Notation')"/>
                    </label>
                    <input id="search-input" class="form-control autocomplete" type="text"><!-- --></input>
                    <button type="button" class="btn btn-default semantic-search-button" onclick="termFocus(document.getElementById('search-input').value.toLowerCase());">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Search')"/>
                    </button>
                </div>
            </div>
        </div>
        
        <!-- New search function -->
        <!--<div id="new-search">
            <div id="project-label">Select a project (type &quot;j&quot; for a start):</div>
            <img id="project-icon" class="ui-state-default"/>
            <input id="project"/>
            <input type="hidden" id="project-id"/>
            <p id="project-description"></p>
        </div>-->
        
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
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Term')"/>
                    </td>
                    <td class="legend_col2">
                        <div id="t_term">
                            <a id="term-link"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="legend_col1">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Definition')"/>
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
                    width: <xsl:value-of select="$term.semantic-net.edges.width"/>,
                    arrows: 'to',
                    color: '<xsl:value-of select="$term.semantic-net.edges.color"/>'
                },
                layout: {
                    improvedLayout: <xsl:value-of select="$term.semantic-net.layout.improvedLayout"/>
                },
                physics: {
                    forceAtlas2Based: {
                        gravitationalConstant: <xsl:value-of select="$term.semantic-net.physics.forceAtlas2Based.gravitationalConstant"/>,
                        centralGravity: <xsl:value-of select="$term.semantic-net.physics.forceAtlas2Based.centralGravity"/>,
                        springLength: <xsl:value-of select="$term.semantic-net.physics.forceAtlas2Based.springLength"/>,
                        springConstant: <xsl:value-of select="$term.semantic-net.physics.forceAtlas2Based.springConstant"/>
                    },
                    maxVelocity: 50,
                    solver: 'forceAtlas2Based',
                    timestep: 0.35,
                    stabilization: {
                        enabled: <xsl:value-of select="$term.semantic-net.physics.stabilization.enabled"/>,
                        iterations: <xsl:value-of select="$term.semantic-net.physics.stabilization.iterations"/>,
                        updateInterval: <xsl:value-of select="$term.semantic-net.physics.stabilization.updateInterval"/>
                    }
                },
                groups: {
                    term: {
                        borderWidth: '<xsl:value-of select="$term.semantic-net.term.border.width"/>',
                        borderWidthSelected: '<xsl:value-of select="$term.semantic-net.term.border.width.selected"/>',
                        radius: 1500,
                        color: {
                            border: '<xsl:value-of select="$term.semantic-net.term.border.color"/>',
                            background: '<xsl:value-of select="$term.semantic-net.term.background"/>',
                            hover: {
                                border: '<xsl:value-of select="$term.semantic-net.term.hover.border"/>',
                                background: '<xsl:value-of select="$term.semantic-net.term.hover.background"/>',
                            },
                            highlight: {
                                border: '<xsl:value-of select="$term.semantic-net.term.highlight.border"/>',
                                background: '<xsl:value-of select="$term.semantic-net.term.highlight.background"/>',
                            }
                        },
                        font: {
                            color: '<xsl:value-of select="$term.semantic-net.term.font.color"/>',
                            size: <xsl:value-of select="$term.semantic-net.term.font.size"/>,
                            face: '<xsl:value-of select="$term.semantic-net.term.font.face"/>'
                        },
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
                document.getElementById('text').innerHTML = Math.round(widthFactor * 100) + '%';
            });
             
            network.once("stabilizationIterationsDone", function() {
                document.getElementById('text').innerHTML = '100%';
                document.getElementById('bar').style.width = '496px';
                document.getElementById('loadingBar').style.opacity = 0;
                setTimeout(function() {
                    document.getElementById('loadingBar').style.display = 'none';
                }, 500);
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
            
            /* Found on https://stackoverflow.com/a/2970667 */
            function camelize(str) {
                return str.replace(/(?:^\w|[A-Z]|\b\w)/g, function(word, index) {
                    return index === 0 ? word.toLowerCase() : word.toUpperCase();
                }).replace(/\s+/g, '');
            }
            
            function termFocus(term) {
                console.log("termFocus");
                var t = "TRM_" + camelize(term);
                network.fit();
                var focusOptions = {
                    scale: 0.7,
                    locked: 'false',
                    animation: {
                        duration: 10,
                        easingFunction: 'easeInQuad'
                    }
                };
                network.focus(t, focusOptions);
                network.selectNodes([t])
            }

        </script>
        
        <!-- New search function -->
        <!--<script>
            $( function() {
            var projects = [<xsl:apply-templates select="document($ditamap)" mode="new-semantic-net-search"/>];
            
            $( "#project" ).autocomplete({
                minLength: 0,
                source: projects,
                focus: function( event, ui ) {
                $( "#project" ).val( ui.item.label );
                    return false;
                },
                select: function( event, ui ) {
                    $( "#project" ).val( ui.item.label );
                    $( "#project-id" ).val( ui.item.value );
                    $( "#project-description" ).html( ui.item.desc );
                    $( "#project-icon" ).attr( "src", "images/" + ui.item.icon );
                    
                    return false;
                }
            })
            .autocomplete( "instance" )._renderItem = function( ul, item ) {
            return $( "&lt;li>" )
                .append( "<div>" + item.label + "<br/>" + item.desc + "</div>" )
                .appendTo( ul );
                };
                } );
        </script>-->
    </xsl:template>
    
    <!-- Generate data set for autocomplete search box -->
    <!--
        TODO: Populate also the @keys (which are used as term node IDs) to the search function, otherwise the search does not work.
        See how to do that here: https://jqueryui.com/autocomplete/#custom-data
    -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="semantic-net-search">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename"/>
        <xsl:variable name="label" select="sj:jsonEscape(document($filepath)/termentry/title[1]/text()[1])"/>
        <xsl:variable name="delim" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ',' else ''" as="xs:string"/>
        <xsl:value-of select="'''' || $label || '''' || $delim || ' '"/>
    </xsl:template>
    
    <!--<xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="new-semantic-net-search">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename"/>
        <xsl:variable name="value" select="sj:termId(@keys)" as="xs:string"/>
        <xsl:variable name="label" select="sj:jsonEscape(document($filepath)/termentry/title[1]/text()[1])" as="xs:string"/>
        <xsl:variable name="desc" select="sj:jsonEscape(document($filepath)/termentry/definition[1]/definitionText[1]/text()[1])" as="xs:string"/>
        <xsl:variable name="delim" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ',' else ''" as="xs:string"/>
        <!-\-
            {
                value: "jquery",
                label: "jQuery",
                desc: "the write less, do more, JavaScript library",
                icon: "jquery_32x32.png"
            },
        -\->
        
        <xsl:value-of select="'{value: ''' || $value || ''', label: ''' || $label || ''', desc: ' || $desc || ''', icon: '''}' || $delim"/>
    </xsl:template>-->
    
    <!-- Generate nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="semantic-net-nodes">
        <xsl:variable name="termId" select="sj:termId(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename"/>
        <xsl:variable name="label" select="sj:jsonEscape(document($filepath)/termentry/title[1]/text()[1])"/>
        <xsl:variable name="delim" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ', ' else ' '" as="xs:string"/>
        <xsl:value-of select="'{id: ''' || $termId || ''', group: ''term'', label: ''' || $label || '''}' || $delim"/>
    </xsl:template>
    
    <!-- Generate edges between nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="semantic-net-edges">
        <xsl:variable name="targetTermId" select="sj:termId(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename" as="xs:string"/>
        
        <xsl:if test="document($filepath)/descendant::*[contains(@class, ' termentry/termRelation ')]">
            <xsl:for-each select="document($filepath)/descendant::*[
                contains(@class, 'termentry/antonym') 
                or contains(@class, 'termentry/superordinateConcept')
                or contains(@class, 'termentry/subordinateConcept')
                or contains(@class, 'termentry/instaceOf')
                or contains(@class, 'termentry/partOf')
                or contains(@class, 'termentry/relatedTerm')]">
                <!--<xsl:variable name="relationString" select="
                    if (contains(@class, 'antonym')) then 'IsAntonymOf'
                    else if (contains(@class, 'superordinateConcept')) then 'IsHypernymOf'
                    else if (contains(@class, 'hyponym')) then 'IsHyponymOf'
                    else if (contains(@class, 'instanceOf')) then 'IsInstanceOf'
                    else if (contains(@class, 'partOf')) then 'IsPartOf'
                    else if (contains(@class, 'relatedTerm')) then 'IsRelatedTo'
                    else 'IsRelatedTo'
                    "/>-->
                <xsl:variable name="labelString" select="
                    if (contains(@class, 'antonym')) then 'Is Antonym Of'
                    else if (contains(@class, 'superordinateConcept')) then 'Is Superordinate Concept Of'
                    else if (contains(@class, 'subordinateConcept')) then 'Is Subordinate Concept Of'
                    else if (contains(@class, 'instanceOf')) then 'Is Instance Of'
                    else if (contains(@class, 'partOf')) then 'Is Part Of'
                    else if (contains(@class, 'relatedTerm')) then 'Is Related To'
                    else 'Is Related To'
                    "/>
                <xsl:variable name="sourceTermId" select="lower-case(@keyref)" as="xs:string"/>
                <xsl:if test="$sourceTermId != '' and $targetTermId != ''">
                    <xsl:value-of select="'{id: ''' || $sourceTermId || $targetTermId || ''', from: ''' || $sourceTermId || ''', to : ''' || $targetTermId || ''', arrows: ''to'', label: ''' || sj:getTermbrowserString($language, $labelString) || '''}, '"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <!-- Load term metadata for the legend box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="semantic-net-legend">
        <xsl:variable name="key" select="sj:termId(@keys)"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/' || $filename" as="xs:string"/>
        <xsl:variable name="label" select="sj:jsonEscape(document($filepath)/termentry/title[1]/text()[1])"/>
        
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
        <xsl:variable name="apos" select="'&apos;&apos;'" as="xs:string"/>
        <xsl:variable name="apos-escaped" select="'\\' || $apos" as="xs:string"/>
        <xsl:variable name="out" select="normalize-space(replace(replace($s, $quot, $quot-escaped), $apos, $apos-escaped))"/>
        <xsl:if test="$debugging.mode = 'true' and $s != $out">
            <xsl:message select="'[DEBUG]: sj:jsonEscape(): Escaped literals in string'"/>
            <xsl:message select="'[DEBUG]      INPUT:  ' || $s"/>
            <xsl:message select="'[DEBUG]      OUTPUT: ' || $out"/>
        </xsl:if>
        <xsl:sequence select="$out"/>
    </xsl:function>
    
    <xsl:function name="sj:termId" as="xs:string" visibility="private">
        <xsl:param name="str" as="xs:string"/>
        <xsl:sequence select="lower-case($str)"/>
    </xsl:function>
    
</xsl:stylesheet>