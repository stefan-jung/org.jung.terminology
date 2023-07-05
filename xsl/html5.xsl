<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sj="http://stefan-jung.org"
    exclude-result-prefixes="related-links sj xd xs">
    
    <xsl:include href="flagicon.xsl"/>
    
    <xsl:param name="temp.dir"/>
    <xsl:param name="language" select="'en-GB'"/>
    
    <xsl:variable name="newline" select="'&#xd;'" as="xs:string"/>
    
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
        <!-- Does the <termBody> has <fullForm> children -->
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
    
    <!-- Generate a placeholder that is replaced with the semantic net later -->
    <xsl:template match="*[contains(@class, ' semanticnet/net ')]">
        <div class="semanticnet"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, 'termstats-d/stats')]">
        <xsl:variable name="temp.dir.uri" select="concat('file:///', encode-for-uri(replace($temp.dir, '\\', '/')))"/>
        <xsl:variable name="termstats.uri" select="$temp.dir.uri || '/termstats_merged.xml'"/>
        <xsl:apply-templates select="document($termstats.uri, /)" mode="termstats"/>
    </xsl:template>
    
    <!--<xsl:template match="termconflicts" mode="termstats">
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
    </xsl:template>-->
    
    
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
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="sj:getString($language, 'Term Notations')"/>
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
                            <xsl:text>"</xsl:text>
                            <xsl:value-of select="@lang"/> 
                            <xsl:text>"</xsl:text>
                            <xsl:choose>
                                <xsl:when test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        ],
                        datasets: [{
                        data: [
                        <xsl:for-each select="language">
                            <xsl:value-of select="."/> 
                            <xsl:choose>
                                <xsl:when test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        ],
                        backgroundColor: [
                        <xsl:for-each select="language">
                            <xsl:text>"</xsl:text>
                            <xsl:value-of select="sj:getColorCode(position())"/>
                            <xsl:text>"</xsl:text>
                            <xsl:choose>
                                <xsl:when test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        ],
                        hoverBackgroundColor: [
                        <xsl:for-each select="language">
                            <xsl:text>"</xsl:text>
                            <xsl:value-of select="sj:getHoverColorCode(position())"/>
                            <xsl:text>"</xsl:text>
                            <xsl:choose>
                                <xsl:when test="following-sibling::language">
                                    <xsl:text>,</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        ]
                        }]
                        };
                        var termNotationsPerLanguageCanvas = document.getElementById("termNotationsPerLanguage");
                        var myPieChart = new Chart(termNotationsPerLanguageCanvas,{
                            type: 'pie',
                            data: termNotationsPerLanguageData,
                            options: {}
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
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="replace($preferredTermFile, 'dita', 'html')"/></xsl:attribute>
                    <xsl:attribute name="target">_self</xsl:attribute>
                    <xsl:value-of select="$preferredTermFile"/>
                </a>
            </td>
            <td class="termconflicts-td">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="replace($notRecommendedTermFile, 'dita', 'html')"/></xsl:attribute>
                    <xsl:attribute name="target">_self</xsl:attribute>
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
                                <xsl:text>"</xsl:text>
                                <xsl:value-of select="@date"/>
                                <xsl:text>"</xsl:text>
                                <xsl:choose>
                                    <xsl:when test="following-sibling::report">
                                        <xsl:text>,</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
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
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::report">
                                            <xsl:text>,</xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
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
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::report">
                                            <xsl:text>,</xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
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
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::report">
                                            <xsl:text>,</xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            ],
                            spanGaps: false,
                        }, 
                        {
                            label: "<xsl:value-of select="sj:getString($language, 'Obsolete Term Notations')"/>",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(232,204,78,1)",
                            borderColor: "rgba(232,204,78,1)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "rgba(232,204,78,1)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(232,204,78,1)",
                            pointHoverBorderColor: "rgba(232,204,78,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: [
                                <xsl:for-each select="report">
                                    <xsl:value-of select="numberOfObsoleteTermNotations"/>
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::report">
                                            <xsl:text>,</xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            ],
                            spanGaps: false,
                        }]
                        };
                        var termNotationsChart = document.getElementById("termNotations");
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
    
    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getString" as="xs:string">
        <xsl:param name="language"/>
        <xsl:param name="string"/>
        <xsl:variable name="file" select="concat(concat('termbrowser-strings-', $language), '.xml')"/>
        <xsl:sequence select="document($file)/descendant::str[@name = $string][1]"/>
    </xsl:function>
    
</xsl:stylesheet>
