<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    This XSLT stylesheet creates the skeleton of an OpenDocument Spreadsheet.
-->

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:template match="/">
        <office:document-content xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
            xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
            xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
            xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
            xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
            xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
            xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
            xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
            xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" office:version="1.3">
            <office:font-face-decls>
                <style:font-face style:name="Calibri" svg:font-family="Calibri"/>
            </office:font-face-decls>
            <office:automatic-styles>
                <style:style style:name="ce1" style:family="table-cell" style:parent-style-name="Default"
                    style:data-style-name="N0"/>
                <style:style style:name="co1" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.38125cm"
                        style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co2" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto"
                        style:column-width="3.04270833333333cm" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co3" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto"
                        style:column-width="2.27541666666667cm" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co4" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="3.4925cm"
                        style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co5" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.143125cm"
                        style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co6" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto"
                        style:column-width="1.45520833333333cm" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co7" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.06375cm"
                        style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co8" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto"
                        style:column-width="2.64583333333333cm" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co9" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.8575cm"
                        style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co10" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto"
                        style:column-width="4.07458333333333cm" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="co11" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto"
                        style:column-width="1.69333333333333cm"/>
                </style:style>
                <style:style style:name="ro1" style:family="table-row">
                    <style:table-row-properties style:row-height="15pt" style:use-optimal-row-height="true"
                        fo:break-before="auto"/>
                </style:style>
                <style:style style:name="ta1" style:family="table" style:master-page-name="mp1">
                    <style:table-properties table:display="true" style:writing-mode="lr-tb"/>
                </style:style>
            </office:automatic-styles>
            <office:body>
                <office:spreadsheet>
                    <table:calculation-settings table:case-sensitive="false"
                        table:search-criteria-must-apply-to-whole-cell="true" table:use-wildcards="true"
                        table:use-regular-expressions="false" table:automatic-find-labels="false"/>
                    <table:table table:name="Sheet1" table:style-name="ta1">
                        <table:table-column table:style-name="co1" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co2" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co3" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co4" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co5" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co6" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co7" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co8" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co9" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co10" table:default-cell-style-name="ce1"/>
                        <table:table-column table:style-name="co11" table:number-columns-repeated="16374"
                            table:default-cell-style-name="ce1"/>
                        <table:table-row table:style-name="ro1">
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Concept ID</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Concept Name</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Definition</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Definition Source</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Language</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Term</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Usage</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Term Source</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Term Context</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>Term Context Source</text:p>
                            </table:table-cell>
                            <table:table-cell table:number-columns-repeated="16374"/>
                        </table:table-row>
                        <table:table-row table:style-name="ro1">
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>TRM_MyTerm</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my term</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my definition</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my definition source</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>en-US</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my term</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>preferred</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my term source</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my term context</text:p>
                            </table:table-cell>
                            <table:table-cell office:value-type="string" table:style-name="ce1">
                                <text:p>my term context source</text:p>
                            </table:table-cell>
                            <table:table-cell table:number-columns-repeated="16374"/>
                        </table:table-row>
                        <table:table-row table:number-rows-repeated="1048574" table:style-name="ro1">
                            <table:table-cell table:number-columns-repeated="16384"/>
                        </table:table-row>
                        <xsl:apply-templates/>
                    </table:table>
                    <table:database-ranges>
                        <table:database-range table:target-range-address="Sheet1.A1:Sheet1.J2"
                            table:name="Table1" table:display-filter-buttons="true"/>
                    </table:database-ranges>
                </office:spreadsheet>
            </office:body>
        </office:document-content>
        
    </xsl:template>
    
</xsl:stylesheet>