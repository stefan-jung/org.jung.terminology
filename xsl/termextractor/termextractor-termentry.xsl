<xsl:stylesheet version="3.0"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:2.0">
    
    <xsl:import href="find-string.xsl"/>
    <xsl:import href="return-string.xsl"/>
    <xsl:import href="collection-url.xsl"/>
    <xsl:import href="concept-id.xsl"/>
    <xsl:import href="camel-case.xsl"/>
    <xsl:import href="concept-filename.xsl"/>
    <xsl:import href="path-to-url.xsl"/>
    <xsl:import href="capitalize-first.xsl"/>
    <xsl:output method="text"/>
    
    <!-- Define the string you are searching for -->
    <xsl:param name="search-string" as="xs:string"/>
    <xsl:param name="source.language" as="xs:string"/>
    <xsl:param name="directory" as="xs:string"/>
    <xsl:param name="output.type" as="xs:string"/>
    <xsl:param name="debugging.mode" as="xs:string"/>
    <xsl:param name="output.directory" as="xs:string"/>
    
    <!--<xsl:variable name="root" as="node()" select="/"/>-->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>
    <xsl:variable name="root" select="/" as="node()"/>
    
    <!-- Template to process the collection of files -->
    <xsl:template match="/" expand-text="yes">
        <xsl:variable name="collection-url" select="sj:termextractor-collection-url('xliff', $directory, $root)"/>
        <!--<xsl:variable name="collection" select="collection('file:/C:/Users/eike/workspace/termextractor/xliffs/?select=*.xlf')"/>-->
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'collection-url = ''' || $directory || '?select=*.xlf'''"/>
            <xsl:message select="'collection contains ''' || count($collection-url) || ''' items.'"/>
        </xsl:if>
        
        <xsl:variable name="result-document" select="sj:path-to-url($output.directory || '\' || sj:concept-filename($search-string))"/>
        <xsl:if test="$debugging.mode = 'true'">
            <xsl:message select="'result-document = ''' || $result-document || ''''"/>
        </xsl:if>
        <xsl:result-document href="{$result-document}" method="xml" encoding="UTF-8" indent="yes">
            <xsl:processing-instruction name="xml-model">
                <xsl:text>href="urn:jung:dita:rng:termentry.rng" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            </xsl:processing-instruction>
            <xsl:processing-instruction name="xml-model">
                <xsl:text>href="urn:jung:dita:rng:termentry.rng" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
            </xsl:processing-instruction>
            <termentry id="{sj:concept-id($search-string)}">
                <title>{sj:capitalize-first($search-string)}</title>
                <definition>
                    <definitionText/>
                    <definitionSource/>
                </definition>
                <termBody>
                    <partOfSpeech value="noun"/>
                    <fullForm language="{$source.language}" usage="preferred">
                        <termVariant>{$search-string}</termVariant>
                    </fullForm>
                    <xsl:for-each select="$collection-url">
                        <xsl:message select="'Collection item: ' || ."/>
                        <xsl:variable name="result" select="sj:return-string(., $search-string, $source.language)"/>
                        <xsl:if test="$result != ''">
                            <fullForm language="{array:get($result, 1)}" usage="preferred">
                                <termVariant>{array:get($result, 2)}</termVariant>
                            </fullForm>
                        </xsl:if>
                    </xsl:for-each>
                </termBody>
            </termentry>
        </xsl:result-document>        
    </xsl:template>
    
</xsl:stylesheet>
