<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="sj xs xd">
    
    <!-- ****************************************************************************** -->
    <!--                                   FUNCTIONS                                    -->
    <!-- ****************************************************************************** -->
    
    <xd:doc>
        <xd:desc>Function to get color code from a list by index.</xd:desc>
        <xd:param name="index">Index of the color code array</xd:param>
        <xd:return>Returns the color code</xd:return>
    </xd:doc>
    <xsl:function name="sj:getColorCode" visibility="public">
        <xsl:param name="index"/>
        <xsl:value-of select="('#d50000', '#304ffe', '#00bfa5', '#ffab00', '#c51162', '#aa00ff', '#6200ea', '#2962ff', '#0091ea', '#00b8d4', '#00c853', '#64dd17', '#aeea00', '#ffd600', '#ff6d00', '#dd2c00', '#3e2723', '#212121', '#263238')[$index]"/>
    </xsl:function>

    <xd:doc>
        <xd:desc>Function to get hover color code from a list by index.</xd:desc>
        <xd:param name="index">Index of the hover color code array</xd:param>
        <xd:return>Returns the hover color code</xd:return>
    </xd:doc>
    <xsl:function name="sj:getHoverColorCode" visibility="public">
        <xsl:param name="index"/>
        <xsl:value-of select="('#ff5252', '#536dfe', '#64ffda', '#ffd740', '#ff4081', '#e040fb', '#7c4dff', '#448aff', '#40c4ff', '#18ffff', '#69f0ae', '#b2ff59', '#eeff41', '#ffff00', '#ffab40', '#ff6e40', '#5d4037', '#616161', '#455a64')[$index]"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getString" as="xs:string" visibility="public">
        <xsl:param name="language"/>
        <xsl:param name="string"/>
        <xsl:variable name="file" select="concat(concat('termbrowser-strings-', $language), '.xml')"/>
        <xsl:sequence select="document($file)/descendant::str[@name = $string][1]"/>
    </xsl:function>
    
</xsl:stylesheet>