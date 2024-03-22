<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="related-links sj xd xs">
    
    <!-- Definition -->
    <xsl:template match="*[contains(@class, ' termentry/definition ')]">
        <div class="card definition">
            <div class="card-body">
                <h5 class="card-title">
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Definition')"/>
                </h5>
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <!-- Definition Text -->
    <xsl:template match="*[contains(@class, ' termentry/definitionText ')]">
        <p class="card-text shortdesc definitionText">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Definition Source -->
    <xsl:template match="*[contains(@class, ' termentry/definitionSource ')]">
        <blockquote class="blockquote">
            <xsl:value-of select="sj:getTermbrowserString($language, 'Definition Source') || sj:getTermbrowserString($language, 'Delimiter String')"/>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    
    <!-- Alternative Definition -->
    <xsl:template match="*[contains(@class, ' termentry/altDefinition ')]">
        <div class="card definition">
            <div class="card-body">
                <h5 class="card-title">
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Alternative Definition')"/>
                </h5>
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <!-- Alternative Definition Text -->
    <xsl:template match="*[contains(@class, ' termentry/altDefinitionText ')]">
        <p class="card-text altDefinitionText">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Annotation -->
    <xsl:template match="*[contains(@class, ' termentry/annotation ')][ancestor::*[contains(@class, ' termentry/termBody ')]]">
        <div class="panel panel-default annotation">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Annotation')"/>
                </h3>
            </div>
            <div class="panel-body">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]">
        <!-- Check if the <termBody> has <fullForm> children -->
        <xsl:if test="*[contains(@class, ' termentry/termNotation ')]">
            <table class="termTable table table-striped table-bordered table-hover table-condensed">
                <thead class="thead-light">
                    <tr>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Type')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Language')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Usage')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Domain')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Source')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Context')"/>
                        </th>
                        <th class="termTable" scope="col">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Term Annotations')"/>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates/>
                </tbody>
            </table>
        </xsl:if>
    </xsl:template>
       
    <xsl:template match="*[contains(@class, ' termentry/termNotation ')]">
        <tr>
            <!-- Term -->
            <td class="termTable">
                <xsl:value-of select="*[contains(@class, ' termentry/termVariant ')]"/>
            </td>
            <!-- Type -->
            <td class="termTable">
                <xsl:choose>
                    <xsl:when test="contains(@class, ' termentry/fullForm ')">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Full Form')"/>
                    </xsl:when>
                    <xsl:when test="contains(@class, ' termentry/abbreviation ')">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Abbreviation')"/>
                    </xsl:when>
                    <xsl:when test="contains(@class, ' termentry/acronym ')">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Acronym')"/>
                    </xsl:when>
                    <xsl:when test="contains(@class, ' termentry/verb ')">
                        <xsl:value-of select="sj:getTermbrowserString($language, 'Verb')"/>
                    </xsl:when>
                </xsl:choose>
            </td>
            <!-- Language -->
            <td class="termTable">
                <xsl:call-template name="getFlag">
                    <xsl:with-param name="language" select="@language"/>
                    <xsl:with-param name="languageCode" select="true()"/>
                </xsl:call-template>
            </td>
            <!-- Usage -->
            <td class="termTable">
                <xsl:choose>
                    <xsl:when test="contains(@usage, 'preferred')">
                        <div class="alert alert-success">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Usage Preferred')"/>
                        </div>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'notRecommended')">
                        <div class="alert alert-danger">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Usage Deprecated')"/>
                        </div>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'admitted')">
                        <div class="alert alert-warning">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Usage Admitted')"/>
                        </div>
                    </xsl:when>
                    <xsl:when test="contains(@usage, 'obsolete')">
                        <div class="alert alert-info">
                            <xsl:value-of select="sj:getTermbrowserString($language, 'Usage Obsolete')"/>
                        </div>
                    </xsl:when>
                </xsl:choose>
            </td>
            <!-- Domain -->
            <td class="termTable">
                <xsl:value-of select="@termdomain"/>
            </td>
            <!-- Source -->
            <td class="termTable">
                <xsl:apply-templates select="*[contains(@class, ' termentry/termSource ')]"/>
            </td>
            <!-- Context -->
            <td class="termTable">
                <xsl:apply-templates select="*[contains(@class, ' termentry/termContext ')]"/>
            </td>
            <!-- Annotation -->
            <td class="termTable">
                <xsl:apply-templates select="*[contains(@class, ' termentry/annotation ')]"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/sourceName ')]">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- Agreed With -->
    <xsl:template match="*[contains(@class, ' termentry/agreedWith ')]">
        <div class="panel panel-default agreedWith">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Agreed With')"/>
                </h3>
            </div>
            <div class="panel-body">
                <ul class="list-unstyled">
                    <xsl:apply-templates/>    
                </ul>
            </div>
        </div>
    </xsl:template>
    
    <!-- Figure -->
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/fig ')]" name="topic.fig">
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <div class="panel panel-default">
            <div class="panel-heading">
                <xsl:call-template name="place-fig-lbl"/>
            </div>
            <div class="panel-body">
            <figure>
                <xsl:call-template name="commonattributes"/>
                <xsl:call-template name="setscale"/>
                <xsl:call-template name="setidaname"/>
                <xsl:apply-templates select="node() except *[contains(@class, ' topic/title ') or contains(@class, ' topic/desc ')]"/>
            </figure>
            </div>
        </div>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    </xsl:template>
    
    <!-- Note -->
    <xsl:template match="*[contains(@class, ' termentry/termBody ')]/*[contains(@class, ' topic/note ')]">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Annotation')"/>
                </h3>
            </div>
            <div class="panel-body">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' termentry/termCommitteeMember ')]">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <!-- Superordinate Concepts have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/superordinateConcept ')]" mode="related-links:get-group"
                  name="related-links:group.superordinateConcepts"
                  as="xs:string">
         <xsl:text>superordinateConcept</xsl:text>
    </xsl:template>
    
    <!-- Subordinate Concepts have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/subordinateConcept ')]" mode="related-links:get-group"
                  name="related-links:group.subordinateConcepts"
                  as="xs:string">
         <xsl:text>subordinateConcept</xsl:text>
    </xsl:template>
    
    <!-- Related Terms have their own group. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:get-group"
                  name="related-links:group.relatedTerms"
                  as="xs:string">
         <xsl:text>relatedTerm</xsl:text>
    </xsl:template>
    
    <!-- Priority of superordinateConcept group. -->
    <xsl:template match="*[contains(@class, ' termentry/superordinateConcept ')]" mode="related-links:get-group-priority"
                  name="related-links:group-priority.superordinateConcepts"
                  as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of subordinateConcept group. -->
    <xsl:template match="*[contains(@class, ' termentry/subordinateConcept ')]" mode="related-links:get-group-priority"
                  name="related-links:group-priority.subordinateConcepts"
                  as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <!-- Priority of related terms group. -->
    <xsl:template match="*[contains(@class, ' termentry/relatedTerm ')]" mode="related-links:get-group-priority"
                  name="related-links:group-priority.relatedTerms"
                  as="xs:integer">
        <xsl:sequence select="3"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/antonyms ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Antonyms')"/>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/superordinateConcepts ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Superordinate Concepts')"/>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/subordinateConcepts ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Subordinate Concepts')"/>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/instancesOf ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Instances Of')"/>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/partsOf ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Parts Of')"/>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' termentry/relatedTerms ')]">
        <div class="linklist linklist relinfo">
            <div class="relatedTermsHeader">
                <strong>
                    <xsl:value-of select="sj:getTermbrowserString($language, 'Related Terms')"/>
                </strong>
            </div>
            <div class="linklist">
                <xsl:apply-templates select="." mode="processlinklist"/>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>