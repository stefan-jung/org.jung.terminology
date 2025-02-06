<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    exclude-result-prefixes="ditaarch xs math table text">
    
    <xsl:output method="xml" indent="yes" exclude-result-prefixes="#all"/>
    <xsl:mode on-no-match="shallow-copy" exclude-result-prefixes="#all" />
    
    <xsl:template match="/termentry" expand-text="yes">
        <xsl:processing-instruction name="xml-model">href="urn:jung:dita:rng:termentry.rng" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model">href="urn:jung:dita:rng:termentry.rng" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
        <termentry id="{@id}">
            <xsl:apply-templates/>
        </termentry>
    </xsl:template>
    
    <xsl:template match="termBody">
        <xsl:copy>
            <!-- This matches all termNotation elements but also concept-domain, and so forth. When they do not have a language attribute, they are not sorted, but this is expected. -->
            <xsl:apply-templates select="*">
                <xsl:sort select="@language"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <!-- Ignore unwanted processing-instructions and attributes -->
    <xsl:template match="processing-instruction() | @class | @xtrf | @xtrc | @ditaarch:DITAArchVersion | @domains | @specializations | @dita-ot | @ditaarch:*" exclude-result-prefixes="#all"/>
    
</xsl:stylesheet>