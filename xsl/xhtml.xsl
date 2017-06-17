<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:doctales="http://doctales.github.io"
    exclude-result-prefixes="related-links doctales xs">
    
    <xsl:include href="flagicon.xsl"/>
    
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

    <!-- Definition Text -->
    <xsl:template match="*[contains(@class, ' termentry/definitionText ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel-body shortdesc definitionText</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Definition Source -->
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

    <!-- Alternative Definition -->
    <xsl:template match="*[contains(@class, ' termentry/altDefinition ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel panel-default altDefinition</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">panel-heading</xsl:attribute>
                <xsl:element name="h3">
                    <xsl:attribute name="class">panel-title</xsl:attribute>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Alternative Definition'"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Alternative Definition Text -->
    <xsl:template match="*[contains(@class, ' termentry/altDefinitionText ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">panel-body altDefinitionText</xsl:attribute>
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
                <xsl:call-template name="getFlag">
                    <xsl:with-param name="language" select="@language"/>
                    <xsl:with-param name="languageCode" select="true()"/>
                </xsl:call-template>
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
    
    <!-- Generate a placeholder that is replaced with the semantic net later -->
    <xsl:template match="*[contains(@class, ' semanticnet/net ')]">
        <div class="semanticnet"/>
    </xsl:template>
    
</xsl:stylesheet>
