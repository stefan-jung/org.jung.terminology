<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="related-links xs">
    
    <!-- Definition -->
    <xsl:template match="*[contains(@class, ' termentry/definition ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel panel-default definition</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-heading</xsl:attribute>
                <xsl:element name="h3">
                    <xsl:attribute name="class">panel-title</xsl:attribute>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Definition'"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definitionText ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel-body shortdesc definitionText</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/definitionSource ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel-footer</xsl:attribute>
            <xsl:element name="b">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Definition Source'"/>
                </xsl:call-template>
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Delimiter String'"/>
                </xsl:call-template>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Annotation -->
    <xsl:template match="*[contains(@class, ' termentry/annotation ')][ancestor::*[contains(@class, ' termentry/termBody ')]]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel panel-default annotation</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-heading</xsl:attribute>
                <xsl:element name="h3">
                    <xsl:attribute name="class">panel-title</xsl:attribute>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Annotation'"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-body</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]">
        <!-- Does the <termBody> has <fullForm> children -->
        <xsl:if test="*[contains(@class, ' termentry/termNotation ')]">
            <xsl:element name="table">
                <xsl:attribute name="class">termTable table table-striped table-bordered table-hover table-condensed</xsl:attribute>
                <xsl:element name="tr">
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Type'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Language'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Usage'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Domain'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Source'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Context'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:attribute name="class">termTable</xsl:attribute>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Annotations'"/>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:element>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
       
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]">
        <xsl:element name="tr">
            <!-- Term -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')]"/>
            </xsl:element>
            <!-- Type -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
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
            </xsl:element>
            <!-- Language -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:element name="span">
                    <xsl:attribute name="class">label label-default</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@language = 'af'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-af</xsl:attribute>
                            </xsl:element>
                            <xsl:text>af</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ar'
                                        or @language = 'ar-AE'
                                        or @language = 'ar-BH'
                                        or @language = 'ar-DZ'
                                        or @language = 'ar-EG'
                                        or @language = 'ar-IQ'
                                        or @language = 'ar-JO'
                                        or @language = 'ar-KW'
                                        or @language = 'ar-LB'
                                        or @language = 'ar-LY'
                                        or @language = 'ar-MA'
                                        or @language = 'ar-OM'
                                        or @language = 'ar-QA'
                                        or @language = 'ar-SA'
                                        or @language = 'ar-SY'
                                        or @language = 'ar-TN'
                                        or @language = 'ar-YE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ar</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ar</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'be'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-be</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>be</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'bg'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-bg</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>bg</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ca'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ca</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ca</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'cs'
                                        or @language = 'cs-CZ'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-cz</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>cs-CZ</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'da'
                                        or @language = 'da-DK'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-dk</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>da-DK</xsl:text>
                        </xsl:when>
                      <xsl:when test="@language = 'de-AT'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-at</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>de-AT</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'de'
                                        or @language = 'de-DE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-de</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>de-DE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'de-CH'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ch</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>de-CH</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'de-LI'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-li</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>de-LI</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'de-LU'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-lu</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>de-LU</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'el'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-el</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>el</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en'
                                        or @language = 'en-GB'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-gb</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-GB</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en-IE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ie</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-IE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en-JM'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-jm</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-JM</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en-NZ'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-nz</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-NZ</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en-TT'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-tt</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-TT</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en-US'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-um</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-US</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'en-ZA'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-za</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>en-ZA</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-es</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-AR'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ar</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-AR</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-BO'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-bo</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-BO</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-CL'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-cl</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-CL</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-CO'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-co</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-CO</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-CR'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-cr</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-CR</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-DO'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-do</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-DO</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-EC'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ec</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-EC</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-GT'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-gt</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-GT</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-HN'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-hn</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-HN</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-MX'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-mx</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-MX</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-NI'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ni</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-NI</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-PA'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-pa</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-PA</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-PE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-pe</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-PE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-PR'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-pr</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-PR</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-PY'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-py</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-PY</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-SV'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-sv</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-SV</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-UY'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-uy</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-UY</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-VE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ve</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-VE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'es-VE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ve</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>es-VE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'et'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>et</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'et'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>et</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'et'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ee</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>et</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fa'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ir</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fa</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fi'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-fi</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fi</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fo'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-fo</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fo</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr'
                                        or @language = 'fr-FR'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-fr</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr-BE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-be</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr-BE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr-BE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-be</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr-BE</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr-CA'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ca</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr-CA</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr-CH'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ch</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr-CH</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr-LU'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-lu</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr-LU</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'fr-GA'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ga</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>fr-GA</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ga'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ga</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ga</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'gd'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-gd</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>gd</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'he'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-il</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>he</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'hi'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-in</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>hi</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'hr'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ir</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>hr</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'hu'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-hu</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>hu</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'id'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-id</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>id</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'is'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-is</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>is</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'it'
                                        or @language = 'it-CH'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-it</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>it</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ja'
                                        or @language = 'ja'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ja</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ja</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ko'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-kr</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ko</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'lt'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-lt</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>lt</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'lv'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-lv</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>lv</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'mk'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-mk</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>mk</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ms'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-my</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ms</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'mt'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-mt</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>mt</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'nl'
                                        or @language = 'nl-BE'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-nl</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>nl</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'no'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-no</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>no</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'pl'
                                        or @language = 'pl-PL'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-pl</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>pl</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'pt'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-pt</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>pt</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'pt-BR'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-br</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>pt-BR</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ro'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ro</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ro</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ru'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ru</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>ru</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'ru'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ru</xsl:attribute>
                            </xsl:element>
                            <xsl:text>ru</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sk'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-sk</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sk</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sl'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-sl</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sl</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sq'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-al</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sq</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sr'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-rs</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sr</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sv'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sv</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sv'
                                        or @language = 'sv-FI'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sv</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'sv'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-se</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>sv</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'th'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-th</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>th</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'uk'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-ua</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>uk</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'vi'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-vn</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>vi</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'zh'
                                        or @language = 'zh-CN'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-cn</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>zh-CN</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'zh-HK'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-hk</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>zh-HK</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'zh-SG'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-sg</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>zh-SG</xsl:text>
                        </xsl:when>
                        <xsl:when test="@language = 'zh-TW'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">flag-icon flag-icon-tw</xsl:attribute>
                            </xsl:element>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Separator'"/>
                            </xsl:call-template>
                            <xsl:text>zh-TW</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:element>
            </xsl:element>
            <!-- Usage -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:choose>
                    <xsl:when test="contains(@usage, 'preferred')">
                        <xsl:element name="div">
                            <xsl:attribute name="class">alert alert-success</xsl:attribute>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Allowed'"/>
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'notRecommended')">
                        <xsl:element name="div">
                            <xsl:attribute name="class">alert alert-danger</xsl:attribute>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Deprecated'"/>
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'admitted')">
                        <xsl:element name="div">
                            <xsl:attribute name="class">alert alert-warning</xsl:attribute>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Admitted'"/>
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'obsolete')">
                        <xsl:element name="div">
                            <xsl:attribute name="class">alert alert-info</xsl:attribute>
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Usage Obsolete'"/>
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:element>
            <!-- Domain -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:value-of select="@termdomain"/>
            </xsl:element>
            <!-- Source -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:apply-templates select="*[contains(@class, ' termentry/termSource ')]"/>
            </xsl:element>
            <!-- Context -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:apply-templates select="*[contains(@class, ' termentry/termContext ')]"/>
            </xsl:element>
            <!-- Annotation -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:apply-templates select="*[contains(@class, ' termentry/annotation ')]"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/sourceName ')]">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- Agreed With -->
    <xsl:template match="*[contains(@class, ' termentry/agreedWith ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel panel-default agreedWith</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-heading</xsl:attribute>
                <xsl:element name="h3">
                    <xsl:attribute name="class">panel-title</xsl:attribute>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Agreed With'"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-body</xsl:attribute>
                <xsl:element name="ul">
                    <xsl:attribute name="class">list-unstyled</xsl:attribute>
                    <xsl:apply-templates/>    
                </xsl:element>
            </xsl:element>
        </xsl:element>
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
        <xsl:element name="div">
            <xsl:attribute name="class">panel panel-primary</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-heading</xsl:attribute>
                <xsl:element name="h3">
                    <xsl:attribute name="class">panel-title</xsl:attribute>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Annotation'"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-body</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' termentry/termCommitteeMember ')]">
        <xsl:element name="li">
            <xsl:apply-templates/>
        </xsl:element>
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
    
    <!--<!-\- Wrapper for hypernym group: "Related hypernyms" in a <div>. -\->
    <xsl:template match="*[contains(@class, ' termentry/hypernyms ')]" mode="related-links:result-group"
                  name="related-links:result.hypernyms" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relhypernyms">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Hypernyms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>
    
    <!-\- Wrapper for hyponym group: "Related hyponyms" in a <div>. -\->
    <xsl:template match="*[contains(@class, ' termentry/hyponyms ')]" mode="related-links:result-group"
                  name="related-links:result.hyponyms" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relhyponyms">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Hyponyms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>

    <!-\- Wrapper for relatedTerm group: "Related relatedTerms" in a <div>. -\->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerms ')]" mode="related-links:result-group"
                  name="related-links:result.relatedTerms" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relrelatedTerms">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Related Terms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>-->
    
</xsl:stylesheet>
