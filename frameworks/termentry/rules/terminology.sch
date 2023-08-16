<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://doctales.github.io" prefix="doctales"/>
    
    <sch:title>Utility functions for termentry topics and maps</sch:title>
    
    <xsl:function name="doctales:getFileNameFromPath">
        <xsl:param name="path"/>
        <xsl:value-of select="subsequence(reverse(tokenize($path, '/')), 1, 1)"/>
    </xsl:function>
    <xsl:function name="doctales:getIdFromPath">
        <xsl:param name="path"/>
        <xsl:value-of select="substring-before(doctales:getFileNameFromPath($path), '.dita')"/>
    </xsl:function>
</sch:schema>