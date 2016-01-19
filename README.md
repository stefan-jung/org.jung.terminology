org.doctales.terminology
========================

Use DITA XML to manage your company specific terminology. A terminolgy will help you to provide consistent language for all publications and to manage your translations.

This DITA-OT plugin has (or will have) the following main features:

- Specialized DITA topics for terminology management
- Generates Schematron based terminology checker quick fixes to find and 
replace deprecated terms in your DITA files
- Generates a termbrowser for navigating in your terminology base
- Generate a TBX file to deliver your DITA terminology to your Language 
Service Provider (LSP)


## Prerequisites

- [DITA-OT 2.3](http://dita-ot.org/) (upcoming Release!) The 2.2.x Version works only with the following workaround to allow link specialization. [Follow Issue](https://github.com/dita-ot/dita-ot/pull/2199)

    1. Go to `xsl/common/related-links.xsl`. 
    2. Go to line `<xsl:template match="*[contains(@class, ' topic/link ')]" mode="related-links:link" name="related-links:link." as="element(link)">` and 
    3. change the line to `<xsl:template match="*[contains(@class, ' topic/link ')]" mode="related-links:link" name="related-links:link" as="element()*">`.
  
## Installation  

1. [Install DITA OT](http://www.dita-ot.org/2.2/getting-started/installing-client.html).
2. Download the DocTales terminology plugin: [org.doctales.terminology](https://github.com/doctales/org.doctales.terminology/archive/master.zip).
3. Drop the plugin folder in the DITA-OT Plugin folder `[DITA-OT-DIR]/plugins/]`.
4. Register new doctype `-//DOCTALES//ELEMENTS DITA DOCTALES Termentry//EN` in your xml-editor.
5. Execute DITA-OT `integrator.xml` ant build file to install the terminology plugin.
6. Open sample DITA map file in plugin folder `org.doctales.terminology/samples/terminology.ditamap`.
7. Open topics referenced in the `terminology.ditamap` to check if editor understands the new terminology topic type.

If your editor opens DITA topics and validates without errors you are done. If not, check dtd registration (step 5).

Get ready to build up your own terminology.
