<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="xs doctales" version="2.0">
   <!-- <xsl:output method="xml"
        encoding="UTF-8"
        indent="yes"/>-->
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
        <xsl:apply-templates mode="head"/>
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
    
    <xsl:template match="termconflict" mode="body">
        <tr class="termconflicts-tr">
            <td class="termconflicts-td"><xsl:value-of select="termnotation"/></td>
            <td class="termconflicts-td"><xsl:value-of select="preferredTermFile"/></td>
            <td class="termconflicts-td"><xsl:value-of select="notRecommendedTermFile"/></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="reports" mode="body">
        <div class="termNotations">
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
                        var ctx = document.getElementById("termNotations");
                        var myLineChart = new Chart(ctx, {
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
            <canvas id="termNotations" width="400" height="400"/>
        </div>
        <script>
            $( document ).ready(function() {
                displayLineCharts();
            });
        </script>
    </xsl:template>

</xsl:stylesheet>
