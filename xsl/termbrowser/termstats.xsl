<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="related-links sj xd xs">
    
    <xd:doc>
        <xd:desc>
            This template matches the &lt;stats> element, which is used in a 
            &lt;termstats> topic and should be replaced by the terminology statistics.
        </xd:desc>
    </xd:doc>
    <xsl:template match="*[contains(@class, 'termstats-d/stats')]">
        <xsl:variable name="termstats.uri" select="'file:///' || encode-for-uri(replace($temp.dir, '\\', '/')) || '/termstats_merged.xml'"/>
        <xsl:apply-templates select="document($termstats.uri, /)" mode="termstats"/>
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>
            This template matches the termconflicts element,
            which is created if a specific term is a recommended 
            term in a &lt;termentry> topic and not recommended in another one.
        </xd:desc>
    </xd:doc>
    <xsl:template match="termconflicts" mode="termstats">
        <div class="termstats-div termconflicts">
            <h2><xsl:value-of select="sj:getTermbrowserString($language, 'Term Conflicts')"/></h2>
            <xsl:choose>
                <xsl:when test="termconflict">
                    <table class="termconflicts-table">
                        <thead class="termconflicts-thead">
                            <tr>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="sj:getTermbrowserString($language, 'Term Notation')"/>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="sj:getTermbrowserString($language, 'Is Preferred In')"/>
                                </th>
                                <th class="termconflicts-th">
                                    <xsl:value-of select="sj:getTermbrowserString($language, 'Is Not Recommended In')"/>
                                </th>
                            </tr>
                        </thead>
                        <xsl:apply-templates mode="termstats"/>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:value-of select="sj:getTermbrowserString($language, 'No Termconflicts Found')"/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="termNotationsPerLanguage" mode="termstats">
        <div class="termstats-div termNotationsPerLanguageList">
            <h2><xsl:value-of select="sj:getTermbrowserString($language, 'Number of Terms')"/></h2>
            <ul>
                <xsl:for-each select="language">
                    <li>
                        <xsl:call-template name="getFlag">
                            <xsl:with-param name="language" select="@lang"/>
                            <xsl:with-param name="languageCode" select="true()"/>
                        </xsl:call-template>
                        <xsl:value-of select="': ' || . ||' ' || sj:getTermbrowserString($language, 'Term Notations')"/>
                    </li>
                </xsl:for-each>
            </ul>
            <div class="termNotationsPerLanguage" style="width:500px; height:500px;">
                <div class="termNotations">
                    <xsl:value-of select="$newline"/>
                    <xsl:value-of select="$newline"/>
                    <canvas id="termNotationsPerLanguage" width="400" height="400"/>
                </div>
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
                        var myPieChart = new Chart(termNotationsPerLanguageCanvas,{
                            type: 'pie',
                            data: termNotationsPerLanguageData,
                            options: {}
                        });
                    }
                    
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
                    <xsl:value-of select="$preferredTermFile"/>
                </a>
            </td>
            <td class="termconflicts-td" href="{replace($notRecommendedTermFile, 'dita', 'html')}" target="_self">
                <a>
                    <xsl:value-of select="$notRecommendedTermFile"/>
                </a>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="chronologicalStatistics" mode="termstats">
        <div class="termstats-div termNotations" style="width:900px; height:900px;">
            <h2><xsl:value-of select="sj:getTermbrowserString($language, 'Chronological Sequence')"/></h2>
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
                            label: "<xsl:value-of select="sj:getTermbrowserString($language, 'Preferred Term Notations')"/>",
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
                            label: "<xsl:value-of select="sj:getTermbrowserString($language, 'Admitted Term Notations')"/>",
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
                            label: "<xsl:value-of select="sj:getTermbrowserString($language, 'Not Recommended Term Notations')"/>",
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
                            label: "<xsl:value-of select="sj:getTermbrowserString($language, 'Obsolete Term Notations')"/>",
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
                        var myLineChart = new Chart(termNotationsChart, {
                            type: 'line',
                            data: data,
                            steppedLine: 'before',
                            options: {
                                title: {
                                    display: true,
                                    text: '<xsl:value-of select="sj:getTermbrowserString($language, 'Term Notations')"/>'
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

    
    <xd:doc>
        <xd:desc>Fall Through Template</xd:desc>
    </xd:doc>
    <xsl:template match="languages" mode="termstats"/>
    
    <xd:doc>
        <xd:desc>Function to get color code from a list by index.</xd:desc>
        <xd:param name="index">Index of the color code array</xd:param>
        <xd:return>Returns the color code</xd:return>
    </xd:doc>
    <xsl:function name="sj:getColorCode" visibility="private">
        <xsl:param name="index"/>
        <xsl:value-of select="('#d50000', '#304ffe', '#00bfa5', '#ffab00', '#c51162', '#aa00ff', '#6200ea', '#2962ff', '#0091ea', '#00b8d4', '#00c853', '#64dd17', '#aeea00', '#ffd600', '#ff6d00', '#dd2c00', '#3e2723', '#212121', '#263238')[$index]"/>
    </xsl:function>

    <xd:doc>
        <xd:desc>Function to get hover color code from a list by index.</xd:desc>
        <xd:param name="index">Index of the hover color code array</xd:param>
        <xd:return>Returns the hover color code</xd:return>
    </xd:doc>
    <xsl:function name="sj:getHoverColorCode" visibility="private">
        <xsl:param name="index"/>
        <xsl:value-of select="('#ff5252', '#536dfe', '#64ffda', '#ffd740', '#ff4081', '#e040fb', '#7c4dff', '#448aff', '#40c4ff', '#18ffff', '#69f0ae', '#b2ff59', '#eeff41', '#ffff00', '#ffab40', '#ff6e40', '#5d4037', '#616161', '#455a64')[$index]"/>
    </xsl:function>
</xsl:stylesheet>