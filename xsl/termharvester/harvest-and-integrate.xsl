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
    
    <xsl:variable name="root" select="/"/>
    
    <!-- Collect all terms from TMX files -->
    <xsl:variable name="tmx-terms" as="element()*" expand-text="yes">
        
        <!-- Iterate over all TMX files. -->
        <xsl:for-each select="collection($tmx-xliff.dir || '/?select=*.tmx')//tuv[@xml:lang = $source.language][seg/text() = $main.term]">
            
            <!-- Iterate over all <tuv> elements. -->
            <xsl:for-each select="following-sibling::tuv">
                <xsl:variable name="term" select="seg/text()"/>
                <xsl:variable name="lang" select="@xml:lang"/>
                <xsl:variable name="file" select="replace(tokenize(base-uri(.), '/')[last()], '%20', ' ')"/>
                <xsl:message select="'*** Found: ''' || $term || ''' (' || $lang || ') in ''' || $file || ''' ***'"/>
                
                <!-- Check it the <termentry> topic does not contain the found term. -->
                <xsl:if test="not($root//fullForm[@language = $lang]/termVariant/text() = $term)">
                    
                    <!-- Add a new <fullForm> element for the harvested term. -->
                    <fullForm usage="preferred" language="{$lang}">
                        <termVariant xml:lang="{$lang}">{$term}</termVariant>
                        <termSource>
                            <sourceName>{$file} ({format-date(current-date(), '[Y0001]-[M01]-[D01]')})</sourceName>
                        </termSource>
                    </fullForm>
                </xsl:if>
                
            </xsl:for-each>
            
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="termBody">
        <termBody>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:sequence select="$tmx-terms"/>
        </termBody>
    </xsl:template>
    
</xsl:stylesheet>