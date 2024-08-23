<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xsx">
  
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <xsl:template match="@class"/>
  
  <!-- Identity template -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- This template sorts <termref> elements by their @keys attribute. -->
  <xsl:template match="*[contains(@class, ' termmap/termmap ')]">
    <xsl:copy>
      <xsl:apply-templates select="*[contains(@class, ' termmap/termref ')]">
        <xsl:sort select="@keys"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>