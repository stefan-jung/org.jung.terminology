<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="2.0">
    
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <xsl:template match="@class"/>
  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' termmap/termmap ')]">
    <xsl:copy>
      <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]">
        <xsl:sort select="@id"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>