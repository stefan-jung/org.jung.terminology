<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="related-links xs">

    <!-- Hypernyms have their own group. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/hypernym ')]" mode="related-links:get-group"
        name="related-links:group.hypernym"
        as="xs:string">
        <xsl:text>hypernym</xsl:text>
    </xsl:template>
    
    <!-- Hyponyms have their own group. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/hyponym ')]" mode="related-links:get-group"
        name="related-links:group.hyponym"
        as="xs:string">
        <xsl:text>hyponym</xsl:text>
    </xsl:template>
    
    <!-- Related Terms have their own group. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/relatedTerm ')]" mode="related-links:get-group"
        name="related-links:group.relatedTerm"
        as="xs:string">
        <xsl:text>relatedTerm</xsl:text>
    </xsl:template>
    
    <!-- Priority of hypernym group. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/hypernym ')]" mode="related-links:get-group-priority"
        name="related-links:group-priority.hypernym"
        as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of hyponym group. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/hyponym ')]" mode="related-links:get-group-priority"
        name="related-links:group-priority.hyponym"
        as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of related terms group. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/relatedTerm ')]" mode="related-links:get-group-priority"
        name="related-links:group-priority.relatedTerm"
        as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Wrapper for hypernym group: "Related hypernyms" in a <div>. -->
    <xsl:template match="*[contains(@class, ' topic/link termentry/hypernym ')]" mode="related-links:result-group"
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
    <xsl:template match="*[contains(@class, ' topic/link termentry/hyponym ')]" mode="related-links:result-group"
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
    <xsl:template match="*[contains(@class, ' topic/link termentry/relatedTerm ')]" mode="related-links:result-group"
        name="related-links:result.relatedTerm" as="element(linklist)">
        <xsl:param name="links" as="node()*"/>
        <xsl:if test="normalize-space(string-join($links, ''))">
            <linklist class="- topic/linklist " outputclass="relinfo relrelatedTerm">
                <title class="- topic/title ">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Related terms'"/>
                    </xsl:call-template>
                </title>
                <xsl:copy-of select="$links"/>
            </linklist>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
