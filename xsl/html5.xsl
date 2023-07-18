<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="related-links sj xd xs">
    
    <xsl:include href="flagicon.xsl"/>
    <xsl:include href="get-string.xsl"/>
    
    <xsl:param name="temp.dir"/>
    <xsl:param name="language" select="'en-GB'"/>
    <xsl:param name="dita.temp.dir" as="xs:string"/>
    <xsl:param name="file.separator" as="xs:string"/>
    
    <xsl:variable name="debugging.mode" select="'true'" as="xs:string"/>
    <xsl:variable name="newline" select="'&#xd;'" as="xs:string"/>
    
    <!-- chart.js -->
    <xsl:variable name="moment.js" as="xs:string"
        select="'https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js'"
    />
    <xsl:variable name="chart.js" as="xs:string"
        select="'https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.umd.js'"
    />
    <xsl:variable name="chartjs-adapter-moment.js" as="xs:string"
        select="'https://cdnjs.cloudflare.com/ajax/libs/chartjs-adapter-moment/1.0.1/chartjs-adapter-moment.esm.js'"
    />
    
    <!-- vis.js -->
    <xsl:variable name="vis.js" as="xs:string" 
        select="'https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js'"
    />
    
    <!-- Definition -->
    <xsl:template match="*[contains(@class, ' termentry/definition ')]">
        <div class="panel panel-default definition">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Definition'"/>
                    </xsl:call-template>
                </h3>
            </div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Definition Text -->
    <xsl:template match="*[contains(@class, ' termentry/definitionText ')]">
        <div class="panel-body shortdesc definitionText">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Definition Source -->
    <xsl:template match="*[contains(@class, ' termentry/definitionSource ')]">
        <div class="panel-footer">
            <b>
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Definition Source'"/>
                </xsl:call-template>
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Delimiter String'"/>
                </xsl:call-template>
            </b>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Alternative Definition -->
    <xsl:template match="*[contains(@class, ' termentry/altDefinition ')]">
        <div class="panel panel-default altDefinition">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Alternative Definition'"/>
                    </xsl:call-template>
                </h3>
            </div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Alternative Definition Text -->
    <xsl:template match="*[contains(@class, ' termentry/altDefinitionText ')]">
        <div class="panel-body altDefinitionText">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Annotation -->
    <xsl:template match="*[contains(@class, ' termentry/annotation ')][ancestor::*[contains(@class, ' termentry/termBody ')]]">
        <div class="panel panel-default annotation">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Annotation'"/>
                    </xsl:call-template>
                </h3>
            </div>
            <div class="panel-body">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]">
        <!-- Check if the <termBody> has <fullForm> children -->
        <xsl:if test="*[contains(@class, ' termentry/termNotation ')]">
            <table class="termTable table table-striped table-bordered table-hover table-condensed">
                <tr>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Type'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Language'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Usage'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Domain'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Source'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Context'"/>
                        </xsl:call-template>
                    </th>
                    <th class="termTable">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Annotations'"/>
                        </xsl:call-template>
                    </th>
                </tr>
                <xsl:apply-templates/>
            </table>
        </xsl:if>
    </xsl:template>
       
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]">
        <tr>
            <!-- Term -->
            <td class="termTable">
                <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')]"/>
            </td>
            <!-- Type -->
            <td class="termTable">
                <xsl:choose>
                    <xsl:when test="contains(@class, ' termentry/fullForm ')">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Full Form'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="contains(@class, ' termentry/abbreviation ')">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Abbreviation'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="contains(@class, ' termentry/acronym ')">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Acronym'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="contains(@class, ' termentry/verb ')">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Verb'"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </td>
            <!-- Language -->
            <td class="termTable">
                <xsl:call-template name="getFlag">
                    <xsl:with-param name="language" select="@language"/>
                    <xsl:with-param name="languageCode" select="true()"/>
                </xsl:call-template>
            </td>
            <!-- Usage -->
            <td class="termTable">
                <xsl:choose>
                    <xsl:when test="contains(@usage, 'preferred')">
                        <div class="alert alert-success">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Allowed'"/>
                            </xsl:call-template>
                        </div>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'notRecommended')">
                        <div class="alert alert-danger">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Deprecated'"/>
                            </xsl:call-template>
                        </div>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'admitted')">
                        <div class="alert alert-warning">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Admitted'"/>
                            </xsl:call-template>
                        </div>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'obsolete')">
                        <div class="alert alert-info">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Obsolete'"/>
                            </xsl:call-template>
                        </div>
                    </xsl:when>
                </xsl:choose>
            </td>
            <!-- Domain -->
            <td class="termTable">
                <xsl:value-of select="@termdomain"/>
            </td>
            <!-- Source -->
            <td class="termTable">
                <xsl:apply-templates select="*[contains(@class, ' termentry/termSource ')]"/>
            </td>
            <!-- Context -->
            <td class="termTable">
                <xsl:apply-templates select="*[contains(@class, ' termentry/termContext ')]"/>
            </td>
            <!-- Annotation -->
            <td class="termTable">
                <xsl:apply-templates select="*[contains(@class, ' termentry/annotation ')]"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/sourceName ')]">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- Agreed With -->
    <xsl:template match="*[contains(@class, ' termentry/agreedWith ')]">
        <div class="panel panel-default agreedWith">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Agreed With'"/>
                    </xsl:call-template>
                </h3>
            </div>
            <div class="panel-body">
                <ul class="list-unstyled">
                    <xsl:apply-templates/>    
                </ul>
            </div>
        </div>
    </xsl:template>
    
    <!-- Figure -->
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/fig ')]" name="topic.fig">
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <div class="panel panel-default">
            <div class="panel-heading">
                <xsl:call-template name="place-fig-lbl"/>
            </div>
            <div class="panel-body">
            <figure>
                <xsl:call-template name="commonattributes"/>
                <xsl:call-template name="setscale"/>
                <xsl:call-template name="setidaname"/>
                <xsl:apply-templates select="node() except *[contains(@class, ' topic/title ') or contains(@class, ' topic/desc ')]"/>
            </figure>
            </div>
        </div>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    </xsl:template>
    
    <!-- Note -->
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/note ')]">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Annotation'"/>
                    </xsl:call-template>
                </h3>
            </div>
            <div class="panel-body">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' termentry/termCommitteeMember ')]">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <!-- Hypernyms have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/hypernym ')]" mode="related-links:get-group"
                  name="related-links:group.hypernyms"
                  as="xs:string">
         <xsl:text>hypernym</xsl:text>
    </xsl:template>
    
    <!-- Hyponyms have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/hyponym ')]" mode="related-links:get-group"
                  name="related-links:group.hyponyms"
                  as="xs:string">
         <xsl:text>hyponym</xsl:text>
    </xsl:template>
    
    <!-- Related Terms have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:get-group"
                  name="related-links:group.relatedTerms"
                  as="xs:string">
         <xsl:text>relatedTerm</xsl:text>
    </xsl:template>
    
    <!-- Priority of hypernym group. -->
    <xsl:template match="*[contains(@class, ' termentry/hypernym ')]" mode="related-links:get-group-priority"
                  name="related-links:group-priority.hypernyms"
                  as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of hyponym group. -->
    <xsl:template match="*[contains(@class, ' termentry/hyponym ')]" mode="related-links:get-group-priority"
                  name="related-links:group-priority.hyponyms"
                  as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of related terms group. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:get-group-priority"
                  name="related-links:group-priority.relatedTerms"
                  as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/antonyms ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Antonyms'"/>
                    </xsl:call-template>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/hypernyms ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Hypernyms'"/>
                    </xsl:call-template>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/hyponyms ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Hyponyms'"/>
                    </xsl:call-template>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/instancesOf ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Instances Of'"/>
                    </xsl:call-template>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/partsOf ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Parts Of'"/>
                    </xsl:call-template>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/relatedTerms ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Related Terms'"/>
                    </xsl:call-template>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    
    <!-- SEMANTIC NET - START -->
    
    <!-- Generate a placeholder that is replaced with the semantic net later -->
    <xsl:template match="*[contains(@class, ' semanticnet-d/net ')]">
        <!--<div class="semanticnet"/>-->
        
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
                    <td class="legend_col2"><div id="t_term"><a id=""/></div></td>
                </tr>
                <tr>
                    <td class="legend_col1">
                        <xsl:value-of select="sj:getString($language, 'Definition')"/>
                    </td>
                    <td class="legend_col2"><div id="t_definition"/></td>
                </tr>
            </table>
        </div>
        
        <script type="text/javascript">
            
            
            require(['<xsl:value-of select="$vis.js"/>'], function(vis.Network) {
            
            // network = new vis.Network(container, data, options);
            
            var nodes = null;
            var edges = null;
            var network = null;
            
            function draw() {
                nodes = [<xsl:apply-templates mode="semantic-net-nodes"/>];
                edges = [<xsl:apply-templates select="/" mode="semantic-net-edges"/>];
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
            }
                var network = new vis.Network(container, data, options);
                
            });
            
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
            
            var terms = [<xsl:apply-templates mode="semantic-net-legend"/>];
            
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
                draw();
                var data = [<xsl:apply-templates mode="semantic-net-search"/>];
                $( "#search-input" ).autocomplete({source: data});
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
    </xsl:template>
    
    <!-- Generate data set for autocomplete search box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="semantic-net-search">
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="delim" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ',' else ''" as="xs:string"/>
        <xsl:value-of select="'{value:''' || $key || ''', label: ''' || descendant::*[contains(@class, ' topic/navtitle ')][1] || '''}' || $delim || $newline"/>
    </xsl:template>
    
    <!-- Generate nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')]" mode="semantic-net-nodes">
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="delim" as="xs:string" select="if (following-sibling::*[contains(@class, ' termmap/termref ')]) then ',' else ''"/>
        <!--<xsl:value-of select="'{id: ''' || @keys || ''', label: ''' || descendant::*[contains(@class, ' topic/navtitle ')][1] || ''', shape: ''box'', group: ''term''}' || $delim || $newline"/>-->
        <xsl:value-of select="'{id: ''' || $key || ''', label: ''' || descendant::*[contains(@class, ' topic/navtitle ')][1] || '''}' || $delim || $newline"/>
        
        <xsl:message>  termmap/termref semantic-net-nodes<xsl:value-of select="@keys"/></xsl:message>
        
    </xsl:template>
    
    <!-- Generate edges between nodes -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="semantic-net-edges">
        <xsl:variable name="key" select="lower-case(@keys)" as="xs:string"/>
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="filepath" select="$dita.temp.dir || $file.separator || $filename" as="xs:string"/>
        
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'[DEBUG] : Generate edges for file: ' || $filepath"/>
        </xsl:if>
        
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
                    <xsl:value-of select="'{from: ''' || $keyref || ''', to : ''' || $key || ''', label: ''' || sj:getString($language, $labelString) || '''},' || $newline"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <!-- Load term metadata for the legend box -->
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href]" mode="semantic-net-legend">
        <xsl:variable name="key" select="@keys"/>
        <xsl:variable name="term" select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]"/>
        <xsl:variable name="filename" select="@href"/>
        <xsl:variable name="filepath" select="$dita.temp.dir || $file.separator || $filename"/>
        <xsl:variable name="quot">"</xsl:variable>
        
        <xsl:value-of select="
            '{key: ' || $quot || $key || $quot || ', term: ' || $quot || $term || $quot ||
            ', definition: ' || $quot || sj:cleanDefinition(document($filepath)/descendant::*[contains(@class, ' termentry/definitionText ')]) || $quot || 
            ', href: ' || $quot || replace(normalize-unicode($filename), '.dita', '.html') || $quot || '},' || $newline"/>
    </xsl:template>
    
    <!-- Fall Through Templates -->
    <xsl:template match="*[contains(@class, ' topic/title ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    <xsl:template match="*[contains(@class, ' bookmap/mainbooktitle ')]" mode="semantic-net-nodes semantic-net-edges semantic-net-legend semantic-net-search"/>
    
    <!-- Escape or remove conflicting characters -->
    <xsl:function name="sj:cleanDefinition" as="xs:string">
        <xsl:param name="definition" as="xs:string"/>
        <xsl:sequence select="replace($definition, '&quot;', '')"/>
    </xsl:function>
    
    <!-- SEMANTIC NET - END -->
    
    
    <xsl:template match="*[contains(@class, 'termstats-d/stats')]">
        <!--<xsl:variable name="temp.dir.uri" select="concat('file:///', encode-for-uri(replace($temp.dir, '\\', '/')))"/>-->
        <xsl:variable name="termstats.uri" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/termstats_merged.xml'"/>
        <xsl:apply-templates select="document($termstats.uri, /)" mode="termstats"/>
    </xsl:template>
    
    <xsl:template match="termconflicts" mode="termstats">
        <div class="termstats-div termconflicts">
            <h2><xsl:value-of select="sj:getString($language, 'Term Conflicts')"/></h2>
            <xsl:choose>
                <xsl:when test="termconflict">
                    <table class="termconflicts-table">
                        <thead class="termconflicts-thead">
                            <tr>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="sj:getString($language, 'Term Notation')"/>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="sj:getString($language, 'Is Preferred In')"/>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="sj:getString($language, 'Is Not Recommended In')"/>
                                </th>
                            </tr>
                        </thead>
                        <xsl:apply-templates mode="termstats"/>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:value-of select="sj:getString($language, 'No Termconflicts Found')"/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="termNotationsPerLanguage" mode="termstats">
        <div class="termstats-div termNotationsPerLanguageList">
            <h2><xsl:value-of select="sj:getString($language, 'Number of Terms')"/></h2>
            <ul>
                <xsl:for-each select="language">
                    <li>
                        <xsl:call-template name="getFlag">
                            <xsl:with-param name="language" select="@lang"/>
                            <xsl:with-param name="languageCode" select="true()"/>
                        </xsl:call-template>
                        <xsl:value-of select="': ' || . ||' ' || sj:getString($language, 'Term Notations')"/>
                    </li>
                </xsl:for-each>
            </ul>
            <div class="termNotationsPerLanguage" style="width:500px; height:500px;">
                <div class="termNotations">
                    <xsl:value-of select="$newline"/>
                    <script>
                        function displayTermNotationsPerLanguageCharts() {
                            var termNotationsPerLanguageData = {
                            labels: [
                            <xsl:for-each select="language">
                                <xsl:value-of select="'&quot;' || @lang || '&quot;'"/> 
                                <xsl:if test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            ],
                            datasets: [{
                            data: [
                            <xsl:for-each select="language">
                                <xsl:value-of select="."/> 
                                <xsl:if test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            ],
                            backgroundColor: [
                            <xsl:for-each select="language">
                                <xsl:value-of select="'&quot;' || sj:getColorCode(position()) || '&quot;'"/>
                                <xsl:if test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            ],
                            hoverBackgroundColor: [
                            <xsl:for-each select="language">
                                <xsl:value-of select="'&quot;' || sj:getHoverColorCode(position()) || '&quot;'"/>
                                <xsl:if test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            ]
                            }]
                            };
                            var termNotationsPerLanguageCanvas = document.getElementById("termNotationsPerLanguage");
                            require(['<xsl:value-of select="$chart.js"/>'], function(Chart) {
                                var myPieChart = new Chart(termNotationsPerLanguageCanvas,{
                                    type: 'pie',
                                    data: termNotationsPerLanguageData,
                                    options: {}
                                });
                            });
                        
                        }
                    </script>
                    <xsl:value-of select="$newline"/>
                    <canvas id="termNotationsPerLanguage" width="400" height="400"/>
                </div>
                <script>
                    $(document).ready(function() {
                        displayTermNotationsPerLanguageCharts();
                    });
                </script>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="termconflict" mode="termstats">
        <xsl:variable name="preferredTermFile" select="preferredTermFile/text()" as="xs:string"/>
        <xsl:variable name="notRecommendedTermFile" select="notRecommendedTermFile/text()" as="xs:string"/>
        <tr class="termconflicts-tr">
            <td class="termconflicts-td"><xsl:value-of select="termnotation"/></td>
            <td class="termconflicts-td">
                <a href="{replace($preferredTermFile, 'dita', 'html')}" target="_self">
                    <!--<xsl:attribute name="href"><xsl:value-of select="replace($preferredTermFile, 'dita', 'html')"/></xsl:attribute>
                    <xsl:attribute name="target">_self</xsl:attribute>-->
                    <xsl:value-of select="$preferredTermFile"/>
                </a>
            </td>
            <td class="termconflicts-td" href="{replace($notRecommendedTermFile, 'dita', 'html')}" target="_self">
                <a>
                    <!--<xsl:attribute name="href"><xsl:value-of select="replace($notRecommendedTermFile, 'dita', 'html')"/></xsl:attribute>
                    <xsl:attribute name="target">_self</xsl:attribute>-->
                    <xsl:value-of select="$notRecommendedTermFile"/>
                </a>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="chronologicalStatistics" mode="termstats">
        <div class="termstats-div termNotations" style="width:900px; height:900px;">
            <h2><xsl:value-of select="sj:getString($language, 'Chronological Sequence')"/></h2>
            <xsl:value-of select="$newline"/>
            <script>
                function displayLineCharts() {
                    var data = {
                        labels: [
                            <xsl:for-each select="report">
                                <xsl:value-of select="'&quot;' || @date || '&quot;'"/>
                                <xsl:if test="following-sibling::report">
                                    <xsl:text>,</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        ],
                        datasets: [{
                            label: "<xsl:value-of select="sj:getString($language, 'Preferred Term Notations')"/>",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(90,130,80,0.9)",
                            borderColor: "rgba(90,130,80,1)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "rgba(90,130,80,1)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(90,130,80,1)",
                            pointHoverBorderColor: "rgba(90,130,80,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: [
                                <xsl:for-each select="report">
                                    <xsl:value-of select="numberOfPreferredTermNotations"/>
                                    <xsl:if test="following-sibling::report">
                                        <xsl:text>,</xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            ],
                            spanGaps: false,
                        }, 
                        {
                            label: "<xsl:value-of select="sj:getString($language, 'Admitted Term Notations')"/>",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(75,192,192,0.1)",
                            borderColor: "rgba(75,192,192,1)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "rgba(75,192,192,1)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(75,192,192,1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: [
                                <xsl:for-each select="report">
                                    <xsl:value-of select="numberOfAdmittedTermNotations"/>
                                    <xsl:if test="following-sibling::report">
                                        <xsl:text>,</xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            ],
                            spanGaps: false,
                        }, 
                        {
                            label: "<xsl:value-of select="sj:getString($language, 'Not Recommended Term Notations')"/>",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(255,163,98,1.0)",
                            borderColor: "rgba(255,163,98,1.0)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "rgba(255,163,98,1.0)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(255,163,98,1.0)",
                            pointHoverBorderColor: "rgba(255,163,98,1.0)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: [
                                <xsl:for-each select="report">
                                    <xsl:value-of select="numberOfNotRecommendedTermNotations"/>
                                    <xsl:if test="following-sibling::report">
                                        <xsl:text>,</xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            ],
                            spanGaps: false,
                        }, 
                        {
                            label: "<xsl:value-of select="sj:getString($language, 'Obsolete Term Notations')"/>",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(232, 204, 78, 1)",
                            borderColor: "rgba(232, 204, 78, 1)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "rgba(232, 204, 78, 1)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(232, 204, 78, 1)",
                            pointHoverBorderColor: "rgba(232, 204, 78, 1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: [
                                <xsl:for-each select="report">
                                    <xsl:value-of select="numberOfObsoleteTermNotations"/>
                                    <xsl:if test="following-sibling::report">
                                        <xsl:text>,</xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            ],
                            spanGaps: false,
                        }]
                        };
                        var termNotationsChart = document.getElementById("termNotations");
                        require(['<xsl:value-of select="$chart.js"/>'], function(Chart) {
                            require(['<xsl:value-of select="$moment.js"/>'], function() {
                                require(['<xsl:value-of select="$chartjs-adapter-moment.js"/>'], function() {
                                    var myLineChart = new Chart(termNotationsChart, {
                                        type: 'line',
                                        data: data,
                                        steppedLine: 'before',
                                        options: {
                                            title: {
                                                display: true,
                                                text: '<xsl:value-of select="sj:getString($language, 'Term Notations')"/>'
                                            },
                                            scales: {
                                                xAxes: [{
                                                    type: 'time',
                                                    time: {
                                                        unit: 'month',
                                                        unitStepSize: 1,
                                                        displayFormats: {
                                                            'day': 'MMM DD'
                                                        }
                                                    }
                                                }]
                                            },
                                            responsive: true
                                        }
                                    });
                                });
                            });
                        });
                    }
            </script>
            <xsl:value-of select="$newline"/>
            <canvas id="termNotations"/>
        </div>
        <script>
            $(document).ready(function() {
                displayLineCharts();
            });
        </script>
    </xsl:template>

    <!-- Fall Through Templates -->
    <xsl:template match="languages" mode="termstats"/>
    
    <xd:doc>
        <xd:desc>Function to get color code from a list by index.</xd:desc>
        <xd:param name="index">Index of the color code array</xd:param>
        <xd:return>Returns the color code</xd:return>
    </xd:doc>
    <xsl:function name="sj:getColorCode">
        <xsl:param name="index"/>
        <xsl:value-of select="('#d50000', '#304ffe', '#00bfa5', '#ffab00', '#c51162', '#aa00ff', '#6200ea', '#2962ff', '#0091ea', '#00b8d4', '#00c853', '#64dd17', '#aeea00', '#ffd600', '#ff6d00', '#dd2c00', '#3e2723', '#212121', '#263238')[$index]"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Function to get hover color code from a list by index.</xd:desc>
        <xd:param name="index">Index of the hover color code array</xd:param>
        <xd:return>Returns the hover color code</xd:return>
    </xd:doc>
    <xsl:function name="sj:getHoverColorCode">
        <xsl:param name="index"/>
        <xsl:value-of select="('#ff5252', '#536dfe', '#64ffda', '#ffd740', '#ff4081', '#e040fb', '#7c4dff', '#448aff', '#40c4ff', '#18ffff', '#69f0ae', '#b2ff59', '#eeff41', '#ffff00', '#ffab40', '#ff6e40', '#5d4037', '#616161', '#455a64')[$index]"/>
    </xsl:function>
    
</xsl:stylesheet>
