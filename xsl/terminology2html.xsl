<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="related-links xs">
    
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]">
        <!-- Does the <termBody> has <fullForm> children -->
        <xsl:if test="*[contains(@class, ' termentry/termNotation ')]">
            <xsl:element name="table">
                <xsl:element name="tr">
                    <xsl:element name="th">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Type'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Language'"/>
                        </xsl:call-template>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Term Usage'"/>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:element>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
       
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]">
        <xsl:element name="tr">
            <xsl:element name="td">
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:element name="td">
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
                </xsl:choose>
            </xsl:element>
            <xsl:element name="td">
                <xsl:value-of select="@language"/>
            </xsl:element>
            <xsl:element name="td">
                <xsl:value-of select="@usage"/>
            </xsl:element>
        </xsl:element>
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
        name="related-links:group.hypernym"
        as="xs:string">
        <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Hypernym'"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Hyponyms have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/hyponym ')]" mode="related-links:get-group"
        name="related-links:group.hyponym"
        as="xs:string">
        <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Hyponym'"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Related Terms have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:get-group"
        name="related-links:group.relatedTerm"
        as="xs:string">
        <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Related Term'"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Priority of hypernym group. -->
    <xsl:template match="*[contains(@class, ' termentry/hypernym ')]" mode="related-links:get-group-priority"
        name="related-links:group-priority.hypernym"
        as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of hyponym group. -->
    <xsl:template match="*[contains(@class, ' termentry/hyponym ')]" mode="related-links:get-group-priority"
        name="related-links:group-priority.hyponym"
        as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of related terms group. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:get-group-priority"
        name="related-links:group-priority.relatedTerm"
        as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Wrapper for hypernym group: "Related hypernyms" in a <div>. -->
    <xsl:template match="*[contains(@class, ' termentry/hypernym ')]" mode="related-links:result-group"
        name="related-links:result.hypernym" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relhypernyms">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Related hypernyms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>
    
    <!-- Wrapper for hyponym group: "Related hyponyms" in a <div>. -->
    <xsl:template match="*[contains(@class, ' termentry/hyponym ')]" mode="related-links:result-group"
        name="related-links:result.hyponym" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relhyponyms">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Related hyponyms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>

    <!-- Wrapper for relatedTerm group: "Related relatedTerms" in a <div>. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:result-group"
        name="related-links:result.relatedTerm" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relrelatedTerm">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Related Terms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
