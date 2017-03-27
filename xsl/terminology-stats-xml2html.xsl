<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
   <!-- <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"/>-->
    
    <xsl:import href="plugin:org.dita.html5:xsl/dita2html5.xsl"/>
    <xsl:import href="flagicon.xsl"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:param name="temp.dir"/>
    <xsl:param name="termMap"/>
    <xsl:param name="temp.dir.abs"/>
    <xsl:param name="ditamap.filename"/>
    <xsl:param name="outext"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>



    <!-- ****************************************************************************** -->
    <!--                                   FUNCTIONS                                    -->
    <!-- ****************************************************************************** -->
    
    <xsl:function name="doctales:getColorCode">
        <xsl:param name="index"/>
        <xsl:value-of select="('#d50000', '#304ffe', '#00bfa5', '#ffab00', '#c51162', '#aa00ff', '#6200ea', '#2962ff', '#0091ea', '#00b8d4', '#00c853', '#64dd17', '#aeea00', '#ffd600', '#ff6d00', '#dd2c00', '#3e2723', '#212121', '#263238')[$index]"/>
    </xsl:function>
    
    <xsl:function name="doctales:getHoverColorCode">
        <xsl:param name="index"/>
        <xsl:value-of select="('#ff5252', '#536dfe', '#64ffda', '#ffd740', '#ff4081', '#e040fb', '#7c4dff', '#448aff', '#40c4ff', '#18ffff', '#69f0ae', '#b2ff59', '#eeff41', '#ffff00', '#ffab40', '#ff6e40', '#5d4037', '#616161', '#455a64')[$index]"/>
    </xsl:function>
    
    
    
    <!-- ****************************************************************************** -->
    <!--                                   TEMPLATES                                    -->
    <!-- ****************************************************************************** -->
    
    <xsl:template match="/" priority="1">
        <html>
            <head><!----></head>
            <body>
                <xsl:call-template name="body"/>
            </body>
        </html>
    </xsl:template>
        
    <xsl:template name="body">
        <xsl:comment>BODY BEGINNING</xsl:comment>
        <xsl:apply-templates mode="body"/>
        <xsl:comment>BODY END</xsl:comment>
    </xsl:template>
    
    <xsl:template match="termconflicts" mode="body">
        <div class="termconflicts">
           <xsl:choose>
                <xsl:when test="termconflict">
                    <table class="termconflicts-table">
                        <thead class="termconflicts-thead">
                            <tr>
                                <th class="termconflicts-th">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Term Notation'"/>
                                    </xsl:call-template>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Is Preferred In'"/>
                                    </xsl:call-template>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Is Not Recommended In'"/>
                                    </xsl:call-template>
                                </th>
                            </tr>
                        </thead>
                        <xsl:apply-templates mode="body"/>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'No Termconflicts Found'"/>
                        </xsl:call-template>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="languages" mode="body">
        <ul>
            <xsl:for-each select="language">
                <li>
                    <xsl:call-template name="getFlag">
                        <xsl:with-param name="language" select="."/>
                        <xsl:with-param name="languageCode" select="true()"/>
                    </xsl:call-template>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="termNotationsPerLanguage" mode="body">
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
                                        <xsl:value-of select="doctales:getColorCode(position())"/>
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
                                        <xsl:value-of select="doctales:getHoverColorCode(position())"/>
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
    </xsl:template>
    
    <xsl:template match="termconflict" mode="body">
        <xsl:variable name="preferredTermFile" select="preferredTermFile/text()" as="xs:string"/>
        <xsl:variable name="notRecommendedTermFile" select="notRecommendedTermFile/text()" as="xs:string"/>
        <tr class="termconflicts-tr">
            <td class="termconflicts-td"><xsl:value-of select="termnotation"/></td>
            <td class="termconflicts-td">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="replace($preferredTermFile, 'dita', $outext)"/></xsl:attribute>
                    <xsl:attribute name="target">_self</xsl:attribute>
                    <xsl:value-of select="$preferredTermFile"/>
                </a>
            </td>
            <td class="termconflicts-td">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="replace($notRecommendedTermFile, 'dita', $outext)"/></xsl:attribute>
                    <xsl:attribute name="target">_self</xsl:attribute>
                    <xsl:value-of select="$notRecommendedTermFile"/>
                </a>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="chronologicalSequence" mode="body">
        <div class="termNotations" style="width:900px; height:900px;">
            <xsl:value-of select="$newline"/>
            <script>
                function displayLineCharts() {
                    var data = {
                        labels: [
                            <xsl:for-each select="report">
                                <xsl:value-of select="@date"/>
                                <xsl:choose>
                                    <xsl:when test="following-sibling::report">
                                        <xsl:text>,</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        ],
                        datasets: [{
                            label: "<xsl:call-template name="getVariable"><xsl:with-param name="id" select="'Preferred Term Notations'"/></xsl:call-template>",
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
                            label: "<xsl:call-template name="getVariable"><xsl:with-param name="id" select="'Admitted Term Notations'"/></xsl:call-template>",
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
                            label: "<xsl:call-template name="getVariable"><xsl:with-param name="id" select="'Not Recommended Term Notations'"/></xsl:call-template>",
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
                            label: "<xsl:call-template name="getVariable"><xsl:with-param name="id" select="'Obsolete Term Notations'"/></xsl:call-template>",
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
                        options: {
                            title: {
                                display: true,
                                text: '<xsl:call-template name="getVariable"><xsl:with-param name="id" select="'Term Notations'"/></xsl:call-template>'
                            },
                            scales: {
                                xAxes: [{
                                    type: 'time',
                                    time: {
                                        displayFormats: {
                                            'millisecond': 'MMM DD',
                                            'second': 'MMM DD',
                                            'minute': 'MMM DD',
                                            'hour': 'MMM DD',
                                            'day': 'MMM DD',
                                            'week': 'MMM DD',
                                            'month': 'MMM DD',
                                            'quarter': 'MMM DD',
                                            'year': 'MMM DD',
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

</xsl:stylesheet>
