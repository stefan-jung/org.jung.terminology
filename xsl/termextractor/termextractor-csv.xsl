<xsl:stylesheet version="3.0"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:import href="find-string.xsl"/>
    <xsl:import href="return-string.xsl"/>
    
    <xsl:output method="text"/>
    
    <!-- Define the string you are searching for -->
    <xsl:param name="search-string" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    <xsl:param name="xliff-directory" as="xs:string"/>
    <xsl:param name="output.type" as="xs:string"/>
    <xsl:param name="debugging.mode" as="xs:string"/>
    
    <!--<xsl:variable name="root" as="node()" select="/"/>-->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>
    
    <!-- Template to process the collection of files -->
    <xsl:template match="/">
        <xsl:sequence select="'--------------------------------------------------------------------------------' || $newline"/>
        <xsl:sequence select="$source.language || '=' || $search-string || $newline"/>
        <!-- Define the collection URI (use file:///path/to/files/* to select all files in a directory) -->
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'xliff-directory = ''' || $xliff-directory || ''''"/>
            <xsl:message select="'search-string = ''' || $search-string || ''''"/>
        </xsl:if>
        <!-- Get the base URI of the current document -->
        <xsl:variable name="baseURI" select="base-uri(/)"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'baseURI = ''' || $baseURI || ''''"/>
        </xsl:if>
        
        <!-- Resolve the relative path against the base URI -->
        <xsl:variable name="absolutePath" select="resolve-uri($xliff-directory, $baseURI)"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'absolutePath = ''' || $absolutePath || ''''"/>
        </xsl:if>
        
        <!--<xsl:variable name="collection" select="collection('file:///C:/Users/eike/workspace/termextractor/xliffs/?select=*.xlf')"/>-->
        <xsl:variable name="collection" select="collection($xliff-directory || '?select=*.xlf')"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'collection = ''' || $xliff-directory || '?select=*.xlf'''"/>
        </xsl:if>
        
        <!-- Iterate over each document in the collection -->
        <xsl:for-each select="$collection">
            <xsl:variable name="result" select="sj:return-string(., $search-string, $source.language)"/>
            <xsl:if test="$result != ''">
                <xsl:if test="$debugging.mode = 'true'">
                    <xsl:message select="array:get($result, 1) || '=' || array:get($result, 2) || $newline"/>
                </xsl:if>
                <xsl:sequence select="array:get($result, 1) || '=' || array:get($result, 2) || $newline"/>
            </xsl:if>
        </xsl:for-each>
        
    </xsl:template>

</xsl:stylesheet>
