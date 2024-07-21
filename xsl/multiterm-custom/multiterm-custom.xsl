<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs">

    <!-- ================================================== -->
    <!-- OUTPUT                                             -->
    <!-- ================================================== -->
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="true"/>


    <!-- ================================================== -->
    <!-- IMPORTS                                            -->
    <!-- ================================================== -->
    <xsl:import href="../multiterm/multiterm-common.xsl"/>
    
    
    <!-- ================================================== -->
    <!-- PARAMETERS                                         -->
    <!-- ================================================== -->
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    
    <!-- License info to be added to the header -->
    <xsl:param name="license" as="xs:string" required="false" select="''"/>

    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>


    <!-- ================================================== -->
    <!-- TEMPLATES                                          -->
    <!-- ================================================== -->

    <xsl:template match="/">
        <mtf>
            <xsl:apply-templates mode="termref"/>
        </mtf>
    </xsl:template>
    
</xsl:stylesheet>
