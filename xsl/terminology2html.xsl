<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="related-links xs">
    
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]">
        <!-- Does the <termBody> has <fullForm> children -->
        <xsl:if test="*[contains(@class, ' termentry/termNotation ')]">
            <xsl:element name="table">
                <xsl:attribute name="class">termTable</xsl:attribute>
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
                <xsl:value-of select="@language"/>
            </xsl:element>
            <!-- Usage -->
            <xsl:element name="td">
                <xsl:attribute name="class">termTable</xsl:attribute>
                <xsl:choose>
                    <xsl:when test="contains(@usage, 'preferred')">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Usage Allowed'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'notRecommended')">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Usage Deprecated'"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
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
    
    <xsl:template match="*[contains(@class, ' termentry/agreedWith ')]">
        <xsl:element name="div">
            <xsl:attribute name="class">termentryDiv</xsl:attribute>
            <xsl:element name="strong">
                <xsl:attribute name="class">termentryLabel</xsl:attribute>
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Agreed With'"/>
                </xsl:call-template>
            </xsl:element>
            <xsl:element name="br"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termCommitteeMember ')]">
        <xsl:element name="li">
            <xsl:attribute name="class">termCommitteeMember</xsl:attribute>
            <xsl:element name="strong">
                <xsl:attribute name="class">termentryLabel</xsl:attribute>
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Term Committee Member'"/>
                </xsl:call-template>
            </xsl:element>
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
    
    <xsl:template match="*[contains(@class, ' termentry/arePartOf ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Are Part Of'"/>
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
