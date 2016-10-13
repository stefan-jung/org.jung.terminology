<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:pattern id="validate-language-codes">
        <sch:let name="codes" value="document('../../codes.xml')" />
        <sch:rule context="*[contains(@class, ' termentry/termNotation ')]">
            <sch:let name="this" value="normalize-space(@language)" />
            <sch:assert test="$codes//code[normalize-space(.) = $this]" >
                The country element should contain a valid country/region code, e.g. 'en-GB'.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>