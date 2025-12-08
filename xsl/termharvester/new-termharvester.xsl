<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="#all">
    
    <!-- Parameter: Directory containing TMX files -->
    <xsl:param name="tmx-xliff.dir"/>

    <!-- Parameter: The main term -->
    <xsl:param name="main.term"/>
    
    <!-- Parameter: Source language -->
    <xsl:param name="source.language"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Parameter: Target language -->
    <!--<xsl:param name="trg-lang" select="'de-DE'"/>-->
    
    <!-- Collect all terms from TMX files -->
    <xsl:variable name="tmx-terms" as="element()*" expand-text="yes">
        <xsl:for-each select="collection($tmx-xliff.dir || '/?select=*.tmx')//tuv[@xml:lang = $source.language][seg/text() = $main.term]">
            
            <xsl:for-each select="following-sibling::tuv">
                <xsl:variable name="term" select="seg/text()"/>
                <xsl:variable name="lang" select="@xml:lang"/>
                <xsl:variable name="file" select="base-uri(.)"/>
                <xsl:message select="'Found: ''' || $term || ''' (' || $lang || ') in ''' || $file || ''''"/>
                <fullForm usage="preferred" language="{$lang}">
                    <termVariant xml:lang="{$lang}">{$term}</termVariant>
                </fullForm>
            </xsl:for-each>
            
            <!--<xsl:variable name="src" select="tuv[@xml:lang=$source.language]/seg"/>
            
            <xsl:if test="$src = $main.term">
                <xsl:message>-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</xsl:message>
                <xsl:message>TERM FOUND</xsl:message>
                <xsl:for-each select="tuv[@xml:lang != $src]">
                    <xsl:message select="seg"/>
                </xsl:for-each>
                <xsl:message>-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</xsl:message>
            </xsl:if>-->
            
<!--            <xsl:variable name="trg" select="tuv[@xml:lang=$trg-lang]/seg"/>
            <!-\- Only harvest if both segments are single words (no spaces, punctuation) -\->
            <xsl:if test="matches($src, '^[A-Za-z\-]+$') and matches($trg, '^[A-Za-zäöüÄÖÜß\-]+$')">
                <term src="{$src}" trg="{$trg}"/>
                <fullForm usage="preferred" language="{$trg}">
                    <termVariant xml:lang="{$trg}">isfack</termVariant>
                </fullForm>
            </xsl:if>-->
        </xsl:for-each>
    </xsl:variable>
    
    <!-- Main template: identity transform -->
    <!--<xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>-->
    
    <xsl:template match="termBody">
        <xsl:apply-templates select="@* | node()"/>
        <xsl:comment>NEW HARVESTED TERMS</xsl:comment>
        <xsl:sequence select="$tmx-terms"/>
    </xsl:template>
    
</xsl:stylesheet>