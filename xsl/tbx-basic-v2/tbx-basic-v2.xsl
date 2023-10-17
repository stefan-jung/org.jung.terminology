<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs">

    <xsl:output encoding="UTF-8" indent="yes"/>
    
    <xsl:param name="dita.temp.dir.url" as="xs:string"/>
    
    <xsl:mode name="termref" on-no-match="shallow-skip"/>
    <xsl:mode name="termentry" on-no-match="shallow-skip"/>

    <xsl:template match="/">
        <martif type="TBX-Basic" xml:lang="en-GB">
            <martifHeader>
                <fileDesc>
                    <sourceDesc>
                        <p>Has been generated using the DITA Jung Terminology plugin.</p>
                    </sourceDesc>
                </fileDesc>
            </martifHeader>
            <text>
                <body>
                    <xsl:apply-templates mode="termref"/>
                </body>
            </text>
        </martif>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termgroup ')]" mode="termref">
        <xsl:apply-templates mode="termref"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termmap/termref ')][@href][@keys]" mode="termref">
        <xsl:variable name="filename" select="@href" as="xs:string"/>
        <xsl:variable name="t" select="xs:anyURI($dita.temp.dir.url || $filename)" as="xs:anyURI"/>
        <xsl:apply-templates select="document($t)" mode="termentry"/>
    </xsl:template>
  
    <xsl:template name="add-doctype">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE martif SYSTEM "TBXBasiccoreStructV02.dtd"&gt;</xsl:text>
    </xsl:template>

    <!-- Create rules for all termentry topics -->
    <xsl:template match="*[contains(@class, ' termentry/termentry ')]" mode="termentry">
        <termEntry id="{generate-id()}">
            <xsl:variable name="definition" select="*[contains(@class, ' termentry/definition ')]"/>
            <xsl:variable name="definitionText" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionText ')]"/>
            <xsl:variable name="definitionSourceName" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionSource ')]/*[contains(@class, ' termentry/sourceName ')]"/>
            <xsl:variable name="definitionSourceReference" select="*[contains(@class, ' termentry/definition ')]/*[contains(@class, ' termentry/definitionSource ')]/*[contains(@class, ' termentry/sourceReference ')]/@href"/>
            <xsl:variable name="partOfSpeech" select="*[contains(@class, ' termentry/partOfSpeech ')]/@value"/>
            <xsl:variable name="domain" select="*[contains(@class, ' termentry/domains ')]/*[contains(@class, ' termentry/domain ')]/@value[1]"/>
            <xsl:variable name="annotation" select="*[contains(@class, ' termentry/annotation ')]"/>
            <!-- Use only images with @scope='external', otherwise they would not be available. -->
            <xsl:variable name="figure" select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/image ')][@scope = 'external']/@href"/>
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
            <xsl:for-each select="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' termentry/termNotation ')][@usage = 'admitted' or 'preferred']">
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
        </termEntry>
    </xsl:template>

</xsl:stylesheet>
