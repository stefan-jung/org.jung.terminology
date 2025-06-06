<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:ai="http://www.oxygenxml.com/ai/function"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:template match="definition">
        
        <xsl:sequence select="ai:transform-content(
            'Please write a definition for ''refrigerant'' and tell me the source of definition. '
            || 'Please create an XML root element called ''definition''. '
            || 'In this element create a child element called ''definitionText''. '
            || 'Place the definition in the XML element ''definitionText''. '
            || 'Create another child element of ''definition'' called ''definitionSource''. '
            || 'Place the source of the definition in the ''definitionSource'' element. Please return the result as pure valid XML.', .)"></xsl:sequence>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>