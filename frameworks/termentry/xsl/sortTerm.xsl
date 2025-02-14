<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:preserve-space elements="*"/>
    
    <!-- Identity template to copy elements -->
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- TODO: Implement sorting -->
    
</xsl:stylesheet>
