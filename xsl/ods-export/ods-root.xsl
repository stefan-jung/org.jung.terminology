<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    This XSLT stylesheet creates the skeleton of an OpenDocument Spreadsheet.
-->

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:param name="term.language" as="xs:string"/>
    
    <xsl:template match="/">
        <office:document-content xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0"
            xmlns:css3t="http://www.w3.org/TR/css3-text/" xmlns:grddl="http://www.w3.org/2003/g/data-view#"
            xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xforms="http://www.w3.org/2002/xforms"
            xmlns:dom="http://www.w3.org/2001/xml-events"
            xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
            xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
            xmlns:math="http://www.w3.org/1998/Math/MathML"
            xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
            xmlns:ooo="http://openoffice.org/2004/office"
            xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
            xmlns:ooow="http://openoffice.org/2004/writer" xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:drawooo="http://openoffice.org/2010/draw" xmlns:oooc="http://openoffice.org/2004/calc"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0"
            xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
            xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
            xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"
            xmlns:tableooo="http://openoffice.org/2009/table"
            xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
            xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
            xmlns:rpt="http://openoffice.org/2005/report"
            xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0"
            xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
            xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
            xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
            xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
            xmlns:loext="urn:org:documentfoundation:names:experimental:office:xmlns:loext:1.0"
            xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
            xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0"
            office:version="1.3">
            <office:scripts/>
            <office:font-face-decls>
                <style:font-face style:name="Liberation Sans" svg:font-family="&apos;Liberation Sans&apos;"
                    style:font-family-generic="swiss" style:font-pitch="variable"/>
                <style:font-face style:name="Noto Sans CJK SC"
                    svg:font-family="&apos;Noto Sans CJK SC&apos;" style:font-family-generic="system"
                    style:font-pitch="variable"/>
                <style:font-face style:name="Noto Sans Devanagari"
                    svg:font-family="&apos;Noto Sans Devanagari&apos;" style:font-family-generic="system"
                    style:font-pitch="variable"/>
            </office:font-face-decls>
            <office:automatic-styles>
                <style:style style:name="co1" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.258cm"/>
                </style:style>
                <style:style style:name="co2" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.323cm"/>
                </style:style>
                <style:style style:name="co3" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.432cm"/>
                </style:style>
                <style:style style:name="co4" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="3.657cm"/>
                </style:style>
                <style:style style:name="ro1" style:family="table-row">
                    <style:table-row-properties style:row-height="0.452cm" fo:break-before="auto"
                        style:use-optimal-row-height="true"/>
                </style:style>
                <style:style style:name="ta1" style:family="table" style:master-page-name="Default">
                    <style:table-properties table:display="true" style:writing-mode="lr-tb"/>
                </style:style>
            </office:automatic-styles>
            <office:body>
                <office:spreadsheet>
                    <table:calculation-settings table:automatic-find-labels="false"
                        table:use-regular-expressions="false" table:use-wildcards="true"/>
                    <table:table table:name="Tabelle1" table:style-name="ta1">
                        <!-- Hide the concept ID column -->
                        <table:table-column table:style-name="co1" table:visibility="collapse"
                            table:default-cell-style-name="Default"/>
                        <!-- Same style for the next 9 columns -->
                        <table:table-column table:style-name="co1" table:number-columns-repeated="9"
                            table:default-cell-style-name="Default"/>
                        <!-- Hide all remaining columns -->
                        <table:table-column table:style-name="co1" table:visibility="collapse"
                            table:number-columns-repeated="16374" table:default-cell-style-name="Default"/>
                        <table:table-header-rows>
                            <table:table-row table:style-name="ro1">
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Context ID</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Main Term</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Definition</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Definition Source</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Language</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Term</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Usage</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Term Source</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Term Context</text:p>
                                </table:table-cell>
                                <table:table-cell table:style-name="Header" office:value-type="string" calcext:value-type="string">
                                    <text:p>Term Context Source</text:p>
                                </table:table-cell>
                            </table:table-row>
                        </table:table-header-rows>
                        <xsl:apply-templates/>
                    </table:table>
                    <table:named-expressions/>
                    <table:database-ranges>
                        <table:database-range table:name="__Anonymous_Sheet_DB__0"
                            table:target-range-address="Tabelle1.A1:Tabelle1.J43"
                            table:display-filter-buttons="true"/>
                    </table:database-ranges>
                </office:spreadsheet>
            </office:body>
        </office:document-content>
        
    </xsl:template>
    
</xsl:stylesheet>