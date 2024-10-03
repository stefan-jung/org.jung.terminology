<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:function name="sj:termextractor-collection-url">
        <xsl:param name="type" as="xs:string"/>
        <xsl:param name="directory" as="xs:string"/>
        <xsl:param name="root" as="node()"/>
        
        <xsl:if test="not($type = 'xliff' or $type = 'tbx')">
            <xsl:message terminate="yes" select="'[ERROR]: sj:termextractor-collection: Invalid value of parameter ''type'' (' || $type || ') permitted values are ''tbx'' or ''xliff''.'"/>
        </xsl:if>
        
        <!-- Define the collection URI (use file:///path/to/files/* to select all files in a directory) -->
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'directory = ''' || $directory || ''''"/>
            <xsl:message select="'search-string = ''' || $search-string || ''''"/>
        </xsl:if>
        
        <!--<!-\- Regular expression to match a single slash after 'file:' followed by any drive letter or mount point -\->
        <xsl:variable name="regex" select="'^file:/([^/])'"/>
        
        <!-\- Perform the replacement to add the missing slashes -\->
        <xsl:variable name="normalized-directory" as="xs:string" select="replace($directory, $regex, 'file:///$1')"/>-->
        
        <!-- Get the base URI of the current document -->
        <!--<xsl:variable name="baseURI" select="base-uri(/)"/>-->
        <xsl:variable name="baseURI" select="base-uri($root)"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'baseURI = ''' || $baseURI || ''''"/>
        </xsl:if>
        
        <!-- Resolve the relative path against the base URI -->
        <xsl:variable name="absolutePath" select="resolve-uri($directory, $baseURI)"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'absolutePath = ''' || $absolutePath || ''''"/>
        </xsl:if>
        
        <!--<xsl:variable name="collection" select="collection('file:///C:/Users/eike/workspace/termextractor/xliffs/?select=*.xlf')"/>-->
        <xsl:variable name="ext" select="if ($type = 'xliff') then 'xlf' else 'tbx'"/>
        
        <xsl:variable name="collection-url" select="replace($directory, '^file:\/', 'file:///') || '?select=*.' || $ext"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'collection-url = ' || $collection-url"/>
        </xsl:if>
    </xsl:function>
    
</xsl:stylesheet>
