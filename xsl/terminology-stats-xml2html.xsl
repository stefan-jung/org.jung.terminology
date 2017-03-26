<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
   <!-- <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"/>-->
    
    <xsl:import href="flagicon.xsl"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:param name="temp.dir"/>
    <xsl:param name="termMap"/>
    <xsl:param name="temp.dir.abs"/>
    <xsl:param name="ditamap.filename"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
    <xsl:template match="/" priority="1">
        <html>
            <head>
                <xsl:call-template name="head"/>
            </head>
            <body onload="displayCharts();">
                <!--<xsl:attribute name="onload">displayCharts();</xsl:attribute>-->
                <xsl:call-template name="body"/>
            </body>
        </html>
    </xsl:template>
    
    
    
    <!-- ****************************************************************************** -->
    <!--                                      HEAD                                      -->
    <!-- ****************************************************************************** -->
    
    <xsl:template name="head">
        <xsl:comment>HEAD BEGINNING</xsl:comment>
        <!--<xsl:apply-templates mode="head"/>-->
        <xsl:comment>HEAD END</xsl:comment>
    </xsl:template>
    
    <!-- Empty fall-through templates -->
    <xsl:template match="termconflicts" mode="head"/>
    <xsl:template match="termconflict" mode="head"/>
    <xsl:template match="reports" mode="head"/>
    
    
    
    <!-- ****************************************************************************** -->
    <!--                                      BODY                                      -->
    <!-- ****************************************************************************** -->
    
    <xsl:template name="body">
        <xsl:comment>BODY BEGINNING</xsl:comment>
        <!--<xsl:call-template name="termNotations"/>-->
        <xsl:apply-templates mode="body"/>
        <!--<xsl:apply-templates mode="reports"/>-->
        <xsl:comment>BODY END</xsl:comment>
    </xsl:template>
    
    <xsl:template match="termconflicts" mode="body">
        <xsl:choose>
            <xsl:when test="termconflict">
                <div class="termconflicts">
                    <table class="termconflicts-table">
                        <thead class="termconflicts-thead">
                            <tr>
                                <th class="termconflicts-th">Term Notation</th>
                                <th class="termconflicts-th">is preferred in</th>
                                <th class="termconflicts-th">is not recommended in</th>
                            </tr>
                        </thead>
                        <xsl:apply-templates mode="body"/>
                    </table>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:comment>no termconflicts found</xsl:comment>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="languages" mode="body">
        <ul>
            <xsl:for-each select="language">
                <li>
                    <xsl:call-template name="getFlag">
                        <xsl:with-param name="language" select="."/>
                    </xsl:call-template>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="."/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:function name="doctales:getColorCode">
        <xsl:param name="index"/>
        <xsl:value-of select="('#d50000', '#304ffe', '#00bfa5', '#ffab00', '#c51162', '#aa00ff', '#6200ea', '#2962ff', '#0091ea', '#00b8d4', '#00c853', '#64dd17', '#aeea00', '#ffd600', '#ff6d00', '#dd2c00', '#3e2723', '#212121', '#263238')[$index]"/>
    </xsl:function>
    
    <xsl:function name="doctales:getHoverColorCode">
        <xsl:param name="index"/>
        <xsl:value-of select="('#ff5252', '#536dfe', '#64ffda', '#ffd740', '#ff4081', '#e040fb', '#7c4dff', '#448aff', '#40c4ff', '#18ffff', '#69f0ae', '#b2ff59', '#eeff41', '#ffff00', '#ffab40', '#ff6e40', '#5d4037', '#616161', '#455a64')[$index]"/>
    </xsl:function>
    
    <xsl:template match="termNotationsPerLanguage" mode="body">
        <div class="termNotationsPerLanguage" style="width:500px; height:500px;">
            <div class="termNotations">
                <xsl:value-of select="$newline"/>
                <script>
                    function displayTermNotationsPerLanguageCharts() {
                        var termNotationsPerLanguageData = {
                        labels: [<xsl:for-each select="language"><xsl:text>"</xsl:text><xsl:value-of select="@lang"/><xsl:text>",</xsl:text></xsl:for-each>],
                            datasets: [{
                                data: [<xsl:for-each select="language"><xsl:value-of select="."/><xsl:text>,</xsl:text></xsl:for-each>],
                                backgroundColor: [<xsl:for-each select="language"><xsl:text>"</xsl:text><xsl:value-of select="doctales:getColorCode(position())"/><xsl:text>",</xsl:text></xsl:for-each>],
                                hoverBackgroundColor: [<xsl:for-each select="language"><xsl:text>"</xsl:text><xsl:value-of select="doctales:getHoverColorCode(position())"/><xsl:text>",</xsl:text></xsl:for-each>]
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
        <tr class="termconflicts-tr">
            <td class="termconflicts-td"><xsl:value-of select="termnotation"/></td>
            <td class="termconflicts-td"><xsl:value-of select="preferredTermFile"/></td>
            <td class="termconflicts-td"><xsl:value-of select="notRecommendedTermFile"/></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="chronologicalSequence" mode="body">
        <div class="termNotations" style="width:900px; height:900px;">
            <xsl:value-of select="$newline"/>
            <script>
                function displayLineCharts() {
                    var data = {
                        labels: [<xsl:for-each select="report"><xsl:text>"</xsl:text><xsl:value-of select="@date"/><xsl:text>",</xsl:text></xsl:for-each>],
                        datasets: [{
                            label: "Preferred Term Notations",
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
                            data: [<xsl:for-each select="report"><xsl:value-of select="numberOfPreferredTermNotations"/><xsl:text>,</xsl:text></xsl:for-each>],
                            spanGaps: false,
                        }, 
                        {
                            label: "Admitted Term Notations",
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
                            data: [<xsl:for-each select="report"><xsl:value-of select="numberOfAdmittedTermNotations"/><xsl:text>,</xsl:text></xsl:for-each>],
                            spanGaps: false,
                        }, 
                        {
                            label: "Not Recommended Term Notations",
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
                            data: [<xsl:for-each select="report"><xsl:value-of select="numberOfNotRecommendedTermNotations"/><xsl:text>,</xsl:text></xsl:for-each>],
                            spanGaps: false,
                        }, 
                        {
                            label: "Obsolete Term Notations",
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
                            data: [<xsl:for-each select="report"><xsl:value-of select="numberOfObsoleteTermNotations"/><xsl:text>,</xsl:text></xsl:for-each>],
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
                                text: 'Term Notations'
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
