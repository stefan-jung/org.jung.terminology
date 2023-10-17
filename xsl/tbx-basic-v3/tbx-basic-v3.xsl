<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns="urn:iso:std:iso:30042:ed-2"
    xmlns:basic="http://www.tbxinfo.net/ns/basic"
    xmlns:min="http://www.tbxinfo.net/ns/min"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="urn:iso:std:iso:30042:ed-2"
    exclude-result-prefixes="xs">

    <xsl:output method="xml" indent="true"/>
    
    <!-- One language is always the main language, which is used for the main definition, and so forth. -->
    <xsl:param name="main.language" as="xs:string"/>
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    
    <xsl:mode name="termNotation" on-no-match="shallow-skip"/>
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>
    <xsl:mode name="definition" on-no-match="shallow-skip"/>
    <xsl:mode name="annotation" on-no-match="shallow-skip"/>
    <xsl:mode name="termContextText" on-no-match="shallow-skip"/>
    <xsl:mode name="part-of-speech" on-no-match="shallow-skip"/>
    
    <xsl:variable name="xml-model1" select="'&lt;?xml-model href=&quot;https://raw.githubusercontent.com/LTAC-Global/TBX-Basic_dialect/master/DCT/TBX-Basic_DCT.sch&quot; type=&quot;application/xml&quot; schematypens=&quot;http://purl.oclc.org/dsdl/schematron&quot;?>'"/>
    <xsl:variable name="xml-model2" select="'&lt;?xml-model href=&quot;https://raw.githubusercontent.com/LTAC-Global/TBX-Basic_dialect/master/DCT/TBX-Basic.nvdl&quot; type=&quot;application/xml&quot; schematypens=&quot;http://purl.oclc.org/dsdl/nvdl/ns/structure/1.0&quot;?>'"/>

    <!-- Match the root node of the DITA Map and create a Schematron root node -->
    <xsl:template match="/">
        <xsl:value-of select="'&#xD;' || $xml-model1 || '&#xD;' || $xml-model2 || '&#xD;'" disable-output-escaping="true"/>
        <tbx style="dct" type="TBX-Basic" xml:lang="en" xmlns="urn:iso:std:iso:30042:ed-2" xmlns:min="http://www.tbxinfo.net/ns/min" xmlns:basic="http://www.tbxinfo.net/ns/basic">
            <tbxHeader>
                <fileDesc>
                    <sourceDesc>
                        <p>Has been generated using the DITA Jung Terminology plugin.</p>
                    </sourceDesc>
                </fileDesc>
            </tbxHeader>
            <text>
                <body>
                    <xsl:apply-templates mode="termref"/>
                </body>
            </text>
        </tbx>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termgroup ')]" mode="termref">
        <xsl:apply-templates mode="termref"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href][@keys]" mode="termref">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)" as="xs:anyURI"/>
        <xsl:apply-templates select="document($t)" mode="termentry"/>
    </xsl:template>
  
    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termentry">
        <xsl:variable name="termentry-root" select="." as="node()"/>
        <conceptEntry id="{generate-id()}">
            <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]"/>
            <xsl:variable name="definitionText" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]"/>
            <xsl:variable name="definitionSourceName" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionSource ')]/*[contains(@class, ' termentry/sourceName ')]"/>
            <xsl:variable name="definitionSourceReference" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionSource ')]/*[contains(@class, ' termentry/sourceReference ')]/@href"/>
            <xsl:variable name="partOfSpeech" select="*[contains(@class, ' termentry/partOfSpeech ')]/@value"/>
            <xsl:variable name="domain" select="*[contains(@class, ' termentry/domains ')]/*[contains(@class, ' termentry/domain ')]/@value[1]"/>
            <xsl:variable name="annotation" select="*[contains(@class, ' termentry/annotation ')]"/>
            <!-- Use only images with @scope='external', otherwise they would not be available. -->
            <xsl:variable name="figure" select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/image ')][@scope = 'external']/@href"/>
            
            <xsl:variable name="languages">
                <xsl:for-each select="distinct-values(//@language)">
                    <xsl:value-of select="distinct-values(.) || ','"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:for-each select="tokenize($languages, ',')">
                <xsl:variable name="language" select="normalize-space(.)"/>
                <xsl:if test="$language != ''">
                    <langSec xml:lang="{$language}">
                        <xsl:if test="$language = $main.language">
                            <xsl:apply-templates select="$termentry-root//*[contains(@class, '  termentry/definition ')]" mode="definition"/>
                        </xsl:if>
                        <xsl:apply-templates select="$termentry-root//*[contains(@class, ' termentry/termNotation ')][@language = $language]" mode="termNotation"/>
                    </langSec>
                </xsl:if>
            </xsl:for-each>
        </conceptEntry>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, '  termentry/definition ')]" mode="definition">
        <descripGrp>
            <basic:definition>Occurs when two colors of light stimulate the
                same patch of retina. In commercial color printing, the halftone dots
                and the overlaps between them together comprise only six colors, plus
                black. The sensation of full color on a page results from additive
                mixture of these six colors. See
                &lt;A=c175:c175-en-t1&gt;secondary
                color&lt;/A&gt;.</basic:definition>
        </descripGrp>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]" mode="termNotation">
        <termSec>
            <term><xsl:value-of select="normalize-space(*[contains(@class, ' termentry/termVariant ')]/text())"/></term>
            <xsl:apply-templates mode="part-of-speech"/>
            <xsl:apply-templates select="*[contains(@class, ' termentry/termContext ')]" mode="#current"/>
            <xsl:apply-templates mode="annotation"/>
            <xsl:choose>
                <xsl:when test="@usage = 'preferred'">
                    <min:administrativeStatus>preferredTerm-admn-sts</min:administrativeStatus>
                </xsl:when>
                <xsl:when test="@usage = 'admitted'">
                    <min:administrativeStatus>admittedTerm-admn-sts</min:administrativeStatus>
                </xsl:when>
                <xsl:when test="@usage = 'deprecated' or @usage = 'notRecommended'">
                    <min:administrativeStatus>deprecatedTerm-admn-sts</min:administrativeStatus>
                </xsl:when>
            </xsl:choose>
        </termSec>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termContext ')]" mode="#all">
        <descrip type="context">
            <xsl:apply-templates mode="termContextText"/>
        </descrip>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termContextText ')]" mode="termContextText">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/partOfSpeech ')]">
        <termNote type="partOfSpeech"><xsl:value-of select="@value"/></termNote>
    </xsl:template>
        
                        
                        <!--<xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred']">
                            <xsl:variable name="termLanguage" select="@language"/>
                            <xsl:variable name="termUsage" select="
                                if (contains(@usage, 'admitted')) then 'admittedTerm-admn-sts'
                                else if (contains(@usage, 'notRecommended')) then 'deprecatedTerm-admn-sts'
                                else if (contains(@usage, 'obsolete')) then 'supersededTerm-admn-sts'
                                else if (contains(@usage, 'preferred')) then 'preferredTerm-admn-sts'
                                else 'preferred'
                                "/>
                            <xsl:variable name="termType" select="
                                if (contains(@class, 'fullForm')) then 'fullForm'
                                else if (contains(@class, 'abbreviation')) then 'abbreviation'
                                else if (contains(@class, 'acronym')) then 'acronym'
                                else if (contains(@class, 'verb')) then 'verb'
                                else 'fullForm'
                                "/>
                            <xsl:variable name="termGender" select="@gender"/>
                            <xsl:variable name="termContext" select="*[contains(@class, ' termentry/termContext ')]"/>
                            <xsl:variable name="termContextText" select="*[contains(@class, ' termentry/termContext ')]/*[contains(@class, ' termentry/termContextText ')]"/>
                            <xsl:variable name="termContextSource" select="*[contains(@class, ' termentry/termContext ')]/*[contains(@class, ' termentry/termContextSource ')]"/>
                            <!-\-<langSet xml:lang="{$termLanguage}">-\->
                                <tig>
                                    <term>
                                        <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')][@case = 'nominative'][@number = 'singular'][1]"/>
                                    </term>
                                    <xsl:if test="$partOfSpeech">
                                        <termNote type="partOfSpeech">
                                            <xsl:value-of select="$partOfSpeech"/>
                                        </termNote>
                                    </xsl:if>
                                    <termNote type="termType">
                                        <xsl:value-of select="$termType"/>
                                    </termNote>
                                    <xsl:if test="$termGender">
                                        <termNote type="grammaticalGender">
                                            <xsl:value-of select="$termGender"/>
                                        </termNote>
                                    </xsl:if>
                                    <termNote type="administrativeStatus">
                                        <xsl:value-of select="$termLanguage"/>
                                    </termNote>
                                    <xsl:if test="$termContext">
                                        <descripGrp>
                                            <xsl:if test="$termContextText">
                                                <descrip type="context">
                                                    <xsl:value-of select="$termContextText"/>
                                                </descrip>            <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred']">
                                                    <xsl:variable name="termLanguage" select="@language"/>
                                                    <xsl:variable name="termUsage" select="
                                                        if (contains(@usage, 'admitted')) then 'admittedTerm-admn-sts'
                                                        else if (contains(@usage, 'notRecommended')) then 'deprecatedTerm-admn-sts'
                                                        else if (contains(@usage, 'obsolete')) then 'supersededTerm-admn-sts'
                                                        else if (contains(@usage, 'preferred')) then 'preferredTerm-admn-sts'
                                                        else 'preferred'
                                                        "/>
                                                    <xsl:variable name="termType" select="
                                                        if (contains(@class, 'fullForm')) then 'fullForm'
                                                        else if (contains(@class, 'abbreviation')) then 'abbreviation'
                                                        else if (contains(@class, 'acronym')) then 'acronym'
                                                        else if (contains(@class, 'verb')) then 'verb'
                                                        else 'fullForm'
                                                        "/>
                                                    <xsl:variable name="termGender" select="@gender"/>
                                                    <xsl:variable name="termContext" select="*[contains(@class, ' termentry/termContext ')]"/>
                                                    <xsl:variable name="termContextText" select="*[contains(@class, ' termentry/termContext ')]/*[contains(@class, ' termentry/termContextText ')]"/>
                                                    <xsl:variable name="termContextSource" select="*[contains(@class, ' termentry/termContext ')]/*[contains(@class, ' termentry/termContextSource ')]"/>
                                                    <langSet xml:lang="{$termLanguage}">
                                                        <tig>
                                                            <term>
                                                                <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')][@case = 'nominative'][@number = 'singular'][1]"/>
                                                            </term>
                                                            <xsl:if test="$partOfSpeech">
                                                                <termNote type="partOfSpeech">
                                                                    <xsl:value-of select="$partOfSpeech"/>
                                                                </termNote>
                                                            </xsl:if>
                                                            <termNote type="termType">
                                                                <xsl:value-of select="$termType"/>
                                                            </termNote>
                                                            <xsl:if test="$termGender">
                                                                <termNote type="grammaticalGender">
                                                                    <xsl:value-of select="$termGender"/>
                                                                </termNote>
                                                            </xsl:if>
                                                            <termNote type="administrativeStatus">
                                                                <xsl:value-of select="$termLanguage"/>
                                                            </termNote>
                                                            <xsl:if test="$termContext">
                                                                <descripGrp>
                                                                    <xsl:if test="$termContextText">
                                                                        <descrip type="context">
                                                                            <xsl:value-of select="$termContextText"/>
                                                                        </descrip>
                                                                    </xsl:if>
                                                                    <xsl:if test="$termContextSource">
                                                                        <admin type="source">
                                                                            <xsl:value-of select="$termContextSource"/>
                                                                        </admin>
                                                                    </xsl:if>
                                                                </descripGrp>
                                                            </xsl:if>
                                                        </tig>
                                                    </langSet>
                                                </xsl:for-each>
                                                
                                            </xsl:if>
                                            <xsl:if test="$termContextSource">
                                                <admin type="source">
                                                    <xsl:value-of select="$termContextSource"/>
                                                </admin>
                                            </xsl:if>
                                        </descripGrp>
                                    </xsl:if>
                                </tig>
                            <!-\-</langSet>-\->
                        </xsl:for-each>-->            
                <!--    </langSec>
                </xsl:if>
            </xsl:for-each>
            
            <xsl:if test="$domain">
                <descrip type="subjectField">
                    <xsl:value-of select="$domain"/>
                </descrip>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$definition">
                    <descripGrp>
                        <xsl:if test="$definitionText">
                            <descrip type="definition">
                                <xsl:value-of select="$definitionText"/>
                            </descrip>
                        </xsl:if>
                        <xsl:if test="$definitionSourceName">
                            <admin type="source">
                                <xsl:value-of select="$definitionSourceName"/>
                            </admin>
                        </xsl:if>
                    </descripGrp>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="$annotation">
                <note><xsl:value-of select="$annotation"/></note>
            </xsl:if>
            <xsl:if test="$definitionSourceReference">
                <xref type="externalCrossReference" target="{normalize-space($definitionSourceReference)}"/>
            </xsl:if>
            <xsl:if test="$figure">
                <xref type="xGraphic" target="{$figure}"/>
            </xsl:if>
            
        </conceptEntry>
    </xsl:template>
<!-\-                        <xsl:element name="langSet">
<!-\\-                            <xsl:attribute name="xml:lang" select="$termLanguage"/>
                            <xsl:element name="tig">
                                <xsl:choose>
                                    <xsl:when test="$partOfSpeech">
                                        <xsl:element name="termNote">
                                            <xsl:attribute name="type">partOfSpeech</xsl:attribute>
                                            <xsl:value-of select="$partOfSpeech"/>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>-\\->
                                <!-\\-<xsl:element name="termNote">
                                    <xsl:attribute name="type">termType</xsl:attribute>
                                    <xsl:value-of select="$termType"/>
                                </xsl:element>-\\->
                                <!-\\-<xsl:choose>
                                    <xsl:when test="$termGender">
                                        <xsl:element name="termNote">
                                            <xsl:attribute name="type">grammaticalGender</xsl:attribute>
                                            <xsl:value-of select="$termGender"/>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>-\\->
                                <xsl:element name="termNote">
                                    <xsl:attribute name="type">administrativeStatus</xsl:attribute>
                                    <xsl:value-of select="$termUsage"/>
                                </xsl:element>
                                <xsl:choose>
                                    <xsl:when test="$termContext">
                                        <xsl:element name="descripGrp">
                                            <xsl:choose>
                                                <xsl:when test="$termContextText">
                                                    <xsl:element name="descrip">
                                                        <xsl:attribute name="type">context</xsl:attribute>
                                                        <xsl:value-of select="$termContextText"/>
                                                    </xsl:element>
                                                </xsl:when>
                                            </xsl:choose>
                                            <xsl:choose>
                                                <xsl:when test="$termContextSource">
                                                    <xsl:element name="admin">
                                                        <xsl:attribute name="type">source</xsl:attribute>
                                                        <xsl:value-of select="$termContextSource"/>
                                                    </xsl:element>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>-\->
    
    <!-\- Empty fall-through template for non-termentry topics -\->-->

</xsl:stylesheet>
