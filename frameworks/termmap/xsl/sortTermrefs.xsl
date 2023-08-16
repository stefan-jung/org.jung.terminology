<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs xd">
  
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <xsl:template match="@class"/>
  
  <xd:doc>
    <xd:desc>Identity template.</xd:desc>
  </xd:doc>
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xd:doc>
    <xd:desc>This template sorts <xd:b>&lt;termref></xd:b> elements by their <xd:b>@keys</xd:b> attribute.</xd:desc>
  </xd:doc>
  <xsl:template match="*[contains(@class, ' termmap/termmap ')]">
    <xsl:copy>
      <xsl:apply-templates select="*[contains(@class, ' termmap/termref ')]">
        <xsl:sort select="@keys"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>