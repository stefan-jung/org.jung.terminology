<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:ai="http://www.oxygenxml.com/ai/function"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <!-- The context of this template is the entire topic, because we would like to read the term name. --> 
    
    <xsl:mode on-no-match="shallow-skip"/>
    
    <xsl:template match="definition">
        
        <!--<xsl:variable name="concept-term" select="//title[1]/text()" as="xs:string"/>-->
        <xsl:variable name="concept-term" select="
            //*[contains(@class, ' termentry/termNotation ')][1]/*[contains(@class, ' termentry/termVariant ')][1]/text()" as="xs:string"/>
        
        <xsl:value-of _disable-output-escaping="yes" select="ai:transform-content(
            'Please write a definition for ''' || $concept-term || ''' and tell me the source of definition. '
            || 'Please create an XML root element called ''definition''. '
            || 'In this element create a child element called ''definitionText''. '
            || 'Place the definition in the XML element ''definitionText''. '
            || 'Create another child element of ''definition'' called ''definitionSource''. '
            || 'Create a child element of ''definitionSource'' called ''sourceName''. '
            || 'Place the source of the definition in the ''sourceName'' element. Please return the result as pure valid XML.'
            || 'Do not use any entities.', .)"></xsl:value-of>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>