<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
    
    <xsl:import href="termbrowser-utility.xsl"/>
    <xsl:import href="plugin:org.dita.html5:xsl/dita2html5.xsl"/>
    <xsl:import href="flagicon.xsl"/>
    
    <xsl:strip-space elements="*"/>
    
    <!-- FIXME: replace with outext fails on Travis CI -->
    <xsl:param name="outext">html</xsl:param>
    <xsl:param name="language"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    
    
    <!-- ****************************************************************************** -->
    <!--                                   TEMPLATES                                    -->
    <!-- ****************************************************************************** -->
    
    <xsl:template match="/" priority="1">
        <html>
            <head>
                <xsl:comment>HEAD BEGINNING</xsl:comment>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.min.js" integrity="sha256-Gn7MUQono8LUxTfRA0WZzJgTua52Udm1Ifrk5421zkA=" crossorigin="anonymous"><!----></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js" integrity="sha256-GcknncGKzlKm69d+sp+k3A2NyQE+jnu43aBl6rrDN2I=" crossorigin="anonymous"><!----></script>
                <xsl:comment>HEAD END</xsl:comment>
            </head>
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
        <div class="termstats-div termconflicts">
            <h2><xsl:value-of select="doctales:getString($language, 'Term Conflicts')"/></h2>
            <xsl:choose>
                <xsl:when test="termconflict">
                    <table class="termconflicts-table">
                        <thead class="termconflicts-thead">
                            <tr>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="doctales:getString($language, 'Term Notation')"/>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="doctales:getString($language, 'Is Preferred In')"/>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="doctales:getString($language, 'Is Not Recommended In')"/>
                                </th>
                            </tr>
                        </thead>
                        <xsl:apply-templates mode="body"/>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:value-of select="doctales:getString($language, 'No Termconflicts Found')"/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="termNotationsPerLanguage" mode="body">
        <div class="termstats-div termNotationsPerLanguageList">
            <h2><xsl:value-of select="doctales:getString($language, 'Number of Terms')"/></h2>
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
                        <xsl:value-of select="doctales:getString($language, 'Term Notations')"/>
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
        </div>
    </xsl:template>
    
    <xsl:template match="termconflict" mode="body">
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
    
    <xsl:template match="chronologicalStatistics" mode="body">
        <div class="termstats-div termNotations" style="width:900px; height:900px;">
            <h2><xsl:value-of select="doctales:getString($language, 'Chronological Sequence')"/></h2>
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
                            label: "<xsl:value-of select="doctales:getString($language, 'Preferred Term Notations')"/>",
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
                            label: "<xsl:value-of select="doctales:getString($language, 'Admitted Term Notations')"/>",
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
                            label: "<xsl:value-of select="doctales:getString($language, 'Not Recommended Term Notations')"/>",
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
                            label: "<xsl:value-of select="doctales:getString($language, 'Obsolete Term Notations')"/>",
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
                                text: '<xsl:value-of select="doctales:getString($language, 'Term Notations')"/>'
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

    <!-- Fall Through Templates -->
    <xsl:template match="languages" mode="body"/>

</xsl:stylesheet>
