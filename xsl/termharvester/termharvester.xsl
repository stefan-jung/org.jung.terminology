<xsl:stylesheet version="3.0"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:import href="camel-case.xsl"/>
    <xsl:import href="capitalize-first.xsl"/>
    <xsl:import href="remove-entity-from-filename.xsl"/>
    <xsl:import href="concept-id.xsl"/>
    <xsl:import href="find-string.xsl"/>
    
    <xsl:import href="tmx-termentry.xsl"/>
    <xsl:import href="tmx-csv.xsl"/>
    <xsl:import href="tmx-txt.xsl"/>
    
    <xsl:import href="xliff-termentry.xsl"/>
    <xsl:import href="xliff-csv.xsl"/>
    <xsl:import href="xliff-txt.xsl"/>
    
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
    <xsl:variable name="LF" select="'&#xa;'" as="xs:string"/>
    
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
        
        <xsl:if test="$output.type = 'all' or $output.type = 'txt'">
            <xsl:result-document encoding="UTF-16" href="{$baseURINoFile || '/' || $term || '.txt'}" method="text" indent="no">

                <!-- Add the term in the source language -->
                <xsl:sequence select="$source.language || ' = ' || $term || '&#xa;'"/>
               
                <!-- Iterate over all .xlf files -->
                <xsl:variable name="xlf-collection" select="collection($baseURINoFile || '?select=*.xlf')"/>
                <xsl:for-each select="$xlf-collection">
                    <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                    <xsl:if test="$debugging.mode = 'true'">
                        <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                    </xsl:if>
                    <xsl:if test="$file = ''">
                        <xsl:message select="'FILE IS EMPTY???'" terminate="yes"/>
                    </xsl:if>
                    
                    <xsl:call-template name="xliff-txt">
                        <xsl:with-param name="xliff" select="." as="document-node()"/>
                        <xsl:with-param name="file" select="$file" as="xs:string"/>
                        <xsl:with-param name="term" select="$term" as="xs:string"/>
                        <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                    </xsl:call-template>
                </xsl:for-each>
                
                <!-- Iterate over all .xliff files -->
                <xsl:variable name="xliff-collection" select="collection($baseURINoFile || '?select=*.xliff')"/>
                <xsl:for-each select="$xliff-collection">
                    <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                    <xsl:if test="$file = ''">
                        <xsl:message select="'FILE IS EMPTY???'" terminate="yes"/>
                    </xsl:if>
                    <xsl:if test="$debugging.mode = 'true'">
                        <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                    </xsl:if>
                    <xsl:call-template name="xliff-txt">
                        <xsl:with-param name="xliff" select="." as="document-node()"/>
                        <xsl:with-param name="file" select="$file" as="xs:string"/>
                        <xsl:with-param name="term" select="$term" as="xs:string"/>
                        <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                    </xsl:call-template>
                </xsl:for-each>
                
                <!-- Iterate over all .tmx files -->
                <xsl:variable name="tmx-collection" select="collection($baseURINoFile || '?select=*.tmx')"/>
                <xsl:for-each select="$tmx-collection">
                    <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                    <xsl:if test="$debugging.mode = 'true'">
                        <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                    </xsl:if>
                    <xsl:call-template name="tmx-txt">
                        <xsl:with-param name="tmx" select="." as="document-node()"/>
                        <xsl:with-param name="file" select="$file" as="xs:string"/>
                        <xsl:with-param name="term" select="$term" as="xs:string"/>
                        <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                    </xsl:call-template>
                </xsl:for-each>
                
            </xsl:result-document> 
        </xsl:if>
        
        <xsl:if test="$output.type = 'all' or $output.type = 'csv'">
            <xsl:result-document encoding="UTF-8" href="{$baseURINoFile || '/' || $term || '.csv'}" method="text">
                
                <!-- Add the term in the source language -->
                <xsl:sequence select="$source.language || '&#x9;' || $term || '&#x9;' || '---' ||'&#xa;'"/>
                
                <!-- Iterate over all .xlf files -->
                <xsl:variable name="xlf-collection" select="collection($baseURINoFile || '?select=*.xlf')"/>
                <xsl:for-each select="$xlf-collection">
                    <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                    <xsl:if test="$debugging.mode = 'true'">
                        <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                    </xsl:if>
                    <xsl:call-template name="xliff-csv">
                        <xsl:with-param name="xliff" select="." as="document-node()"/>
                        <xsl:with-param name="file" select="$file" as="xs:string"/>
                        <xsl:with-param name="term" select="$term" as="xs:string"/>
                        <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                    </xsl:call-template>
                </xsl:for-each>
                
                <!-- Iterate over all .xliff files -->
                <xsl:variable name="xliff-collection" select="collection($baseURINoFile || '?select=*.xliff')"/>
                <xsl:for-each select="$xliff-collection">
                    <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                    <xsl:if test="$debugging.mode = 'true'">
                        <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                    </xsl:if>
                    <xsl:call-template name="xliff-csv">
                        <xsl:with-param name="xliff" select="." as="document-node()"/>
                        <xsl:with-param name="file" select="$file" as="xs:string"/>
                        <xsl:with-param name="term" select="$term" as="xs:string"/>
                        <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                    </xsl:call-template>
                </xsl:for-each>
                
                <!-- Iterate over all .tmx files -->
                <xsl:variable name="tmx-collection" select="collection($baseURINoFile || '?select=*.tmx')"/>
                <xsl:for-each select="$tmx-collection">
                    <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                    <xsl:if test="$debugging.mode = 'true'">
                        <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                    </xsl:if>
                    <xsl:call-template name="tmx-csv">
                        <xsl:with-param name="tmx" select="." as="document-node()"/>
                        <xsl:with-param name="file" select="$file" as="xs:string"/>
                        <xsl:with-param name="term" select="$term" as="xs:string"/>
                        <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                    </xsl:call-template>
                </xsl:for-each>
                
            </xsl:result-document> 
        </xsl:if>
        
        <xsl:if test="$output.type = 'all' or $output.type = 'termentry'">
            <xsl:result-document encoding="UTF-8" href="{$baseURINoFile || '/' || sj:concept-id($term) || '.dita'}" method="xml" indent="yes" exclude-result-prefixes="#all">
                
                <xsl:processing-instruction name="xml-model">
                    <xsl:text>href="urn:jung:dita:rng:termentry.rng" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
                </xsl:processing-instruction>
                <xsl:processing-instruction name="xml-model">
                    <xsl:text>href="urn:jung:dita:rng:termentry.rng" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
                </xsl:processing-instruction>
                <termentry id="{sj:concept-id($term)}">
                    <title><xsl:value-of select="sj:capitalize-first($term)"/></title>
                    <definition>
                        <definitionText/>
                        <definitionSource/>
                    </definition>
                    <termBody>
                        <partOfSpeech value="noun"/>
                        <fullForm language="{$source.language}" usage="preferred">
                            <termVariant xml:lang="{$source.language}"><xsl:value-of select="$term"/></termVariant>
                        </fullForm>
                        
                        <!-- Iterate over all .xlf files -->
                        <xsl:variable name="xlf-collection" select="collection($baseURINoFile || '?select=*.xlf')"/>
                        <xsl:for-each select="$xlf-collection">
                            <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                            <xsl:if test="$debugging.mode = 'true'">
                                <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                            </xsl:if>
                            <xsl:call-template name="xliff-termentry">
                                <xsl:with-param name="xliff" select="." as="document-node()"/>
                                <xsl:with-param name="file" select="$file" as="xs:string"/>
                                <xsl:with-param name="term" select="$term" as="xs:string"/>
                                <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                            </xsl:call-template>
                        </xsl:for-each>
                        
                        <!-- Iterate over all .xliff files -->
                        <xsl:variable name="xliff-collection" select="collection($baseURINoFile || '?select=*.xliff')"/>
                        <xsl:for-each select="$xliff-collection">
                            <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                            <xsl:if test="$debugging.mode = 'true'">
                                <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                            </xsl:if>
                            <xsl:call-template name="xliff-termentry">
                                <xsl:with-param name="xliff" select="." as="document-node()"/>
                                <xsl:with-param name="file" select="$file" as="xs:string"/>
                                <xsl:with-param name="term" select="$term" as="xs:string"/>
                                <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                            </xsl:call-template>
                        </xsl:for-each>
                        
                        <!-- Iterate over all .tmx files -->
                        <xsl:variable name="tmx-collection" select="collection($baseURINoFile || '?select=*.tmx')"/>
                        <xsl:for-each select="$tmx-collection">
                            <xsl:variable name="file" select="tokenize(base-uri(.), '/')[last()]"/>
                            <xsl:if test="$debugging.mode = 'true'">
                                <xsl:message select="'[DEBUG] --- ' || sj:remove-entity-from-filename($file) || ' ---'"/>
                            </xsl:if>
                            <xsl:call-template name="tmx-termentry">
                                <xsl:with-param name="tmx" select="." as="document-node()"/>
                                <xsl:with-param name="file" select="$file" as="xs:string"/>
                                <xsl:with-param name="term" select="$term" as="xs:string"/>
                                <xsl:with-param name="source.language" select="$source.language" as="xs:string"/>
                            </xsl:call-template>
                        </xsl:for-each>
                        
                    </termBody>
                </termentry>
                
            </xsl:result-document> 
        </xsl:if>
        
    </xsl:template>
    
</xsl:stylesheet>
