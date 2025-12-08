<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    This script determines the main term of a <termentry> topic and provides it as
    a property file. A main term is the first preferred term in the source language.
-->
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:param name="source.language"/>
    
    <xsl:mode on-no-match="shallow-skip"/>
    
    <xsl:output method="text" indent="no"/>
    
    <xsl:template match="/*[1]">
        <xsl:sequence select="'main.term=' || //fullForm[@language = 'en-US'][@usage = 'preferred'][1]/termVariant[1]/text()"/>
    </xsl:template>
    
</xsl:stylesheet>