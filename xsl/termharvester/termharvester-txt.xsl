<xsl:stylesheet version="3.0"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:import href="find-string.xsl"/>
    <xsl:import href="tmx-target.xsl"/>
    <xsl:import href="xliff-target.xsl"/>
    
    <xsl:output method="text"/>
    
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
        
        <!-- Resolve the relative path against the base URI -->
        <xsl:variable name="absolutePath" select="resolve-uri($tmx.xliff.dir, $baseURI)"/>
        
        <!-- Define the collection URI (use file:///path/to/files/* to select all files in a directory) -->
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'[DEBUG] baseURI = ''' || $baseURI || ''''"/>
            <xsl:message select="'[DEBUG] xliff-directory = ''' || $tmx.xliff.dir || ''''"/>
            <xsl:message select="'[DEBUG] search-string = ''' || $term || ''''"/>
            <xsl:message select="'[DEBUG] absolutePath = ''' || $absolutePath || ''''"/>
        </xsl:if>
        
        <!--<xsl:variable name="collection" select="collection('file:///C:/Users/eike/workspace/termextractor/xliffs/?select=*.xlf')"/>-->
        <xsl:variable name="xliff-collection" select="collection($tmx.xliff.dir || '?select=*.xl*f')"/>
        
        <!-- Iterate over each document in the collection -->
        <xsl:for-each select="$xliff-collection">
            <xsl:variable name="result" select="sj:xliff-target(., $term, $source.language)"/>
            <xsl:if test="$result != ''">
                <xsl:if test="$debugging.mode = 'true'">
                    <xsl:message select="array:get($result, 1) || '=' || array:get($result, 2)"/>
                </xsl:if>
                <xsl:sequence select="array:get($result, 1) || '=' || array:get($result, 2) || $newline"/>
            </xsl:if>
        </xsl:for-each>
        
        <xsl:variable name="tmx-collection" select="collection($tmx.xliff.dir || '?select=*.tmx')"/>
        <xsl:for-each select="$tmx-collection">
            <xsl:sequence select="sj:tmx-target-text(., $term, $source.language)"/>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
