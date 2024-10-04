<xsl:stylesheet version="3.0"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:import href="find-string.xsl"/>
    <xsl:import href="xliff-target.xsl"/>
    
    <xsl:output method="text" encoding="UTF-16"/>
    
    <xsl:mode name="tmx-csv" on-no-match="shallow-skip"/>
    <xsl:mode name="tmx-termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="tmx-txt" on-no-match="shallow-skip"/>
    <xsl:mode name="xliff-csv" on-no-match="shallow-skip"/>
    <xsl:mode name="xliff-termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="xliff-txt" on-no-match="shallow-skip"/>
    
    <!-- Define the string you are searching for -->
    <xsl:param name="term" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    <xsl:param name="tmx.xliff.dir" as="xs:string"/>
    <xsl:param name="output.type" as="xs:string"/>
    <xsl:param name="debugging.mode" as="xs:string"/>
    
    <!--<xsl:variable name="root" as="node()" select="/"/>-->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>
    
    <!-- Template to process the collection of files -->
    <xsl:template match="/">
        
        <!-- Get the base URI of the current document -->
        <xsl:variable name="baseURI" select="base-uri(/)"/>
        
        <xsl:variable name="baseURINoFile" select="substring-before($baseURI, 'dummy-input.xml')"/>
        
        <!-- Resolve the relative path against the base URI -->
        <!--<xsl:variable name="absolutePath" select="resolve-uri($tmx.xliff.dir, $baseURI)"/>-->
        
        <!-- Define the collection URI (use file:///path/to/files/* to select all files in a directory) -->
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'[DEBUG] baseURI = ''' || $baseURI || ''''"/>
            <xsl:message select="'[DEBUG] baseURINoFile = ''' || $baseURINoFile || ''''"/>
            <xsl:message select="'[DEBUG] xliff-directory = ''' || $tmx.xliff.dir || ''''"/>
            <xsl:message select="'[DEBUG] search-string = ''' || $term || ''''"/>
            <xsl:message select="'[DEBUG] output.type = ''' || $output.type || ''''"/>
            <!--<xsl:message select="'[DEBUG] absolutePath = ''' || $absolutePath || ''''"/>-->
        </xsl:if>
        
        <!-- Add the term in the source language -->
        <xsl:sequence select="$source.language || ' = ' || $term || '&#xa;'"/>

        <!-- Iterate over all .xlf files -->
        <xsl:variable name="xlf-collection" select="collection($baseURINoFile || '?select=*.xlf')"/>
        <xsl:for-each select="$xlf-collection">
            
            <xsl:variable name="filename" select="'[DEBUG] FILENAME: ' || tokenize(base-uri(.), '/')[last()]"/>
            <xsl:if test="$debugging.mode = 'true'">
                <xsl:message select="'[DEBUG] filename = ' || $filename"/>
            </xsl:if>
            
            <xsl:variable name="result" select="sj:xliff-target(., $term, $source.language)"/>
            <xsl:if test="$result != ''">
                <xsl:if test="$debugging.mode = 'true'">
                    <xsl:message select="array:get($result, 1) || '=' || array:get($result, 2)"/>
                </xsl:if>
                <xsl:sequence select="array:get($result, 1) || '=' || array:get($result, 2) || $newline"/>
            </xsl:if>
        </xsl:for-each>

        <!-- Iterate over all .xliff files -->
        <xsl:variable name="xliff-collection" select="collection($baseURINoFile || '?select=*.xliff')"/>
        <xsl:for-each select="$xliff-collection">
            <xsl:variable name="result" select="sj:xliff-target(., $term, $source.language)"/>
            <xsl:if test="$result != ''">
                <xsl:if test="$debugging.mode = 'true'">
                    <xsl:message select="array:get($result, 1) || '=' || array:get($result, 2)"/>
                </xsl:if>
                <xsl:sequence select="array:get($result, 1) || '=' || array:get($result, 2) || $newline"/>
            </xsl:if>
        </xsl:for-each>
        
        <!-- Iterate over all .tmx files -->
        <xsl:variable name="tmx-collection" select="collection($baseURINoFile || '?select=*.tmx')"/>
        <xsl:for-each select="$tmx-collection">
            <xsl:choose>
                <xsl:when test="$output.type = 'all' or $output.type = 'txt'">
                    <xsl:call-template name="tmx-txt">
                        <xsl:with-param name="tmx" select="." as="document-node()"/>
                        <xsl:with-param name="term" select="$term"/>
                        <xsl:with-param name="source.language" select="$source.language"/>
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- TMX txt -->
    <xsl:template name="tmx-txt">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="term"/>
        <xsl:param name="source.language"/>
        <xsl:apply-templates mode="tmx-txt">
            <xsl:with-param name="tmx" select="$tmx"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="tmx-txt">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || '&#xa;'"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- TMX csv -->
    <xsl:template name="tmx-csv">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="term"/>
        <xsl:param name="source.language"/>
        <xsl:apply-templates mode="tmx-csv">
            <xsl:with-param name="tmx" select="$tmx"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="tmx-csv">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || '&#xa;'"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- TMX termentry -->
    <xsl:template name="tmx-termentry">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:param name="term"/>
        <xsl:param name="source.language"/>
        <xsl:apply-templates mode="tmx-termentry">
            <xsl:with-param name="tmx" select="$tmx"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="tmx-termentry">
        <xsl:param name="tmx" as="document-node()"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || '&#xa;'"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <!-- XLIFF txt -->
    <xsl:template name="xliff-txt">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="term"/>
        <xsl:param name="source.language"/>
        <xsl:apply-templates mode="xliff-txt">
            <xsl:with-param name="tmx" select="$xliff"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="xliff-txt">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:variable name="result" select="sj:xliff-target(., $term, $source.language)"/>
        <xsl:if test="$result != ''">
            <xsl:if test="$debugging.mode = 'true'">
                <xsl:message select="array:get($result, 1) || '=' || array:get($result, 2)"/>
            </xsl:if>
            <xsl:sequence select="array:get($result, 1) || '=' || array:get($result, 2) || $newline"/>
        </xsl:if>
    </xsl:template>
    
    
    <!-- XLIFF csv -->
    <xsl:template name="xliff-csv">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="term"/>
        <xsl:param name="source.language"/>
        <xsl:apply-templates mode="xliff-csv">
            <xsl:with-param name="xliff" select="$xliff"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="xliff-csv">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || '&#xa;'"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- TMX termentry -->
    <xsl:template name="xliff-termentry">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:param name="term"/>
        <xsl:param name="source.language"/>
        <xsl:apply-templates mode="xliff-termentry">
            <xsl:with-param name="xliff" select="$xliff"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="seg[normalize-space(.) = normalize-space($term)]" mode="xliff-termentry">
        <xsl:param name="xliff" as="document-node()"/>
        <xsl:variable name="tu" select="ancestor::tu[1]" as="node()"/>
        <xsl:for-each select="$tu[1]/tuv">
            <xsl:if test="./@xml:lang != $source.language">
                <xsl:value-of select="./@xml:lang || ' = ' || ./seg/text() || '&#xa;'"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    

</xsl:stylesheet>
