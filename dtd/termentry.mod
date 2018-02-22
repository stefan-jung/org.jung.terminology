<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//DOCTALES//ELEMENTS DITA DOCTALES Termentry//EN"
      Delivered as file "termentry.mod"  -->
<!-- ================================================================================ -->

<!-- ================================================================================ -->
<!--                       SPECIALIZATION OF DECLARED ELEMENTS                        -->
<!-- ================================================================================ -->

<!ENTITY % termentry-info-types  "no-topic-nesting"                                     >



<!-- ================================================================================ -->
<!--                              ELEMENT NAME ENTITIES                               -->
<!-- ================================================================================ -->

<!ENTITY % termentry             "termentry"                                            >
<!ENTITY % abbreviation          "abbreviation"                                         >
<!ENTITY % acronym               "acronym"                                              >
<!ENTITY % agreedWith            "agreedWith"                                           >
<!ENTITY % altDefinition         "altDefinition"                                        >
<!ENTITY % altDefinitionText     "altDefinitionText"                                    >
<!ENTITY % annotation            "annotation"                                           >
<!ENTITY % antonym               "antonym"                                              >
<!ENTITY % antonyms              "antonyms"                                             >
<!ENTITY % partsOf               "partsOf"                                              >
<!ENTITY % definition            "definition"                                           >
<!ENTITY % definitionText        "definitionText"                                       >
<!ENTITY % definitionSource      "definitionSource"                                     >
<!ENTITY % domains               "domains"                                              >
<!ENTITY % domain                "domain"                                               >
<!ENTITY % fullForm              "fullForm"                                             >
<!ENTITY % hypernym              "hypernym"                                             >
<!ENTITY % hypernyms             "hypernyms"                                            >
<!ENTITY % hyponym               "hyponym"                                              >
<!ENTITY % hyponyms              "hyponyms"                                             >
<!ENTITY % instanceOf            "instanceOf"                                           >
<!ENTITY % instancesOf           "instancesOf"                                          >
<!ENTITY % partOf                "partOf"                                               >
<!ENTITY % partOfSpeech          "partOfSpeech"                                         >
<!ENTITY % relations             "relations"                                            >
<!ENTITY % relatedTerm           "relatedTerm"                                          >
<!ENTITY % relatedTerms          "relatedTerms"                                         >
<!ENTITY % sourceName            "sourceName"                                           >
<!ENTITY % sourceReference       "sourceReference"                                      >
<!ENTITY % termBody              "termBody"                                             >
<!ENTITY % termContext           "termContext"                                          >
<!ENTITY % termContextText       "termContextText"                                      >
<!ENTITY % termContextSource     "termContextSource"                                    >
<!ENTITY % termSource            "termSource"                                           >
<!ENTITY % termVariant           "termVariant"                                          >
<!ENTITY % termCommitteeMember   "termCommitteeMember"                                  >
<!ENTITY % verb                  "verb"                                                 >



<!-- ================================================================================ -->
<!--                              COMMON ATTLIST SETS                                 -->
<!-- ================================================================================ -->

<!--                                 Generic term attributes for all term elements    -->
<!ENTITY % term-atts                "%id-atts;
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED
                                     usage
                                       (admitted | 
                                        notRecommended |
                                        obsolete |
                                        preferred)
                                           'preferred'
                                     termdomain
                                        CDATA
                                           #IMPLIED   
                                    ">

<!--                                 Language of term                                 -->
<!ENTITY % languageSelection-atts   "language
                                        (af | 
                                         ar-AE | 
                                         ar-BH | 
                                         ar-DZ | 
                                         ar-EG | 
                                         ar-IQ | 
                                         ar-JO | 
                                         ar-KW | 
                                         ar-LB | 
                                         ar-LY | 
                                         ar-MA | 
                                         ar-OM | 
                                         ar-QA | 
                                         ar-SA | 
                                         ar-SY | 
                                         ar-TN | 
                                         ar-YE | 
                                         be | 
                                         bg | 
                                         ca | 
                                         cs | 
                                         cs-CZ | 
                                         da | 
                                         da-DK | 
                                         de | 
                                         de-AT | 
                                         de-CH |
                                         de-DE |
                                         de-LI | 
                                         de-LU | 
                                         el | 
                                         en | 
                                         en-AU | 
                                         en-BZ | 
                                         en-CA | 
                                         en-GB | 
                                         en-IE | 
                                         en-JM | 
                                         en-NZ | 
                                         en-TT | 
                                         en-US | 
                                         en-ZA | 
                                         es | 
                                         es-AR | 
                                         es-BO | 
                                         es-CL | 
                                         es-CO | 
                                         es-CR | 
                                         es-DO | 
                                         es-EC | 
                                         es-ES | 
                                         es-GT | 
                                         es-HN | 
                                         es-MX | 
                                         es-NI | 
                                         es-PA | 
                                         es-PE | 
                                         es-PR | 
                                         es-PY | 
                                         es-SV | 
                                         es-UY | 
                                         es-VE | 
                                         et | 
                                         eu | 
                                         fa | 
                                         fi | 
                                         fo | 
                                         fr | 
                                         fr-BE | 
                                         fr-CA | 
                                         fr-CH | 
                                         fr-FR | 
                                         fr-LU | 
                                         ga | 
                                         gd | 
                                         he | 
                                         hi | 
                                         hr | 
                                         hu | 
                                         id | 
                                         is | 
                                         it | 
                                         it-CH | 
                                         it-IT | 
                                         ja | 
                                         ji | 
                                         ko | 
                                         lt | 
                                         lv | 
                                         mk | 
                                         ms | 
                                         mt | 
                                         nl | 
                                         nl-BE | 
                                         no | 
                                         pl | 
                                         pl-PL | 
                                         pt | 
                                         pt-BR | 
                                         rm | 
                                         ro | 
                                         ro-MO | 
                                         ru | 
                                         ru-MO | 
                                         sb | 
                                         sk | 
                                         sl | 
                                         sq | 
                                         sr | 
                                         sv | 
                                         sv-FI | 
                                         sx | 
                                         sz | 
                                         th | 
                                         tn | 
                                         tr | 
                                         ts | 
                                         uk | 
                                         ur | 
                                         ve | 
                                         vi | 
                                         xh | 
                                         zh-CN | 
                                         zh-HK | 
                                         zh-SG | 
                                         zh-TW | 
                                         zu)
                                           'en-GB'
                                    ">

<!--                                 Gender of term                                   -->
<!ENTITY % genderSelection-atts     "gender
                                        (neuter |
                                         masculine |
                                         feminine)
                                            #IMPLIED
                                    ">
                                    
<!--                                 Case of term                                     -->
<!ENTITY % caseSelection-atts       "case
                                        (nominative |
                                         accusative |
                                         dative |
                                         genitive)
                                           'nominative'
                                    ">
                                    
<!--                                 Number of term                                   -->
<!ENTITY % numberSelection-atts     "number
                                        (singular |
                                         plural)
                                           'singular'
                                    ">

<!--                                 Word types                                       -->
<!ENTITY % partOfSpeech-atts        "value
                                        (noun |
                                         pronoun |
                                         adjective |
                                         verb |
                                         adverb |
                                         preposition |
                                         conjunction |
                                         interjection |
                                         article |
                                         other)
                                           'noun'
                                    ">



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains         ""                                                  >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Term Entry                            -->

<!ENTITY % termentry.content        "((%title;),
                                      (%definition;)?,
                                      (%termBody;)?,
                                      (%relations;)?,
                                      (%termentry-info-types;)*)
                                    ">
<!ENTITY % termentry.attributes     "%id-atts;
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED
                                    ">
<!--doc:The <termentry> element is the root element of a termentry topic. A term entry represents a terminology concept and includes one or multiple term words and defines their usage.
Category: Termentry elements-->
<!ELEMENT termentry                  %termentry.content;>
<!ATTLIST termentry                  %termentry.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">

<!--                                 LONG NAME: Definition                            -->
<!ENTITY % definition.content       "((%definitionText;),
                                      (%definitionSource;)?)
                                    ">
<!ENTITY % definition.attributes    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED
                                    ">
<!--doc:The <definition> element contains the definition of a term.
Category: Termentry elements-->
<!ELEMENT definition    %definition.content;>
<!ATTLIST definition    %definition.attributes;>

<!--                                 LONG NAME: Definition Text                       -->
<!ENTITY % definitionText.attributes "%univ-atts;
                                      outputclass
                                         CDATA
                                            #IMPLIED">
<!--doc:The <definitionText> element contains the textual content of the definition.
Category: Termentry elements-->
<!ELEMENT definitionText    %shortdesc.content;>
<!ATTLIST definitionText    %definitionText.attributes;>

<!--                                 LONG NAME: Agreed With                           -->
<!ENTITY % agreedWith.content       "(%termCommitteeMember;)+">
<!ENTITY % agreedWith.attributes    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <agreedWith> element contains multiple Terminology Committee Members who accepted a term.
Category: Termentry elements-->
<!ELEMENT agreedWith    %agreedWith.content;>
<!ATTLIST agreedWith    %agreedWith.attributes;>

<!--                                 LONG NAME: Terminology Committee Member          -->
<!ENTITY % termCommitteeMember.content
                                    "(#PCDATA)*">
<!ENTITY % termCommitteeMember.attributes
                                    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <termCommitteeMember> element contains the name of a person who has voted for a term.
Category: Termentry elements-->
<!ELEMENT termCommitteeMember   %termCommitteeMember.content;>
<!ATTLIST termCommitteeMember   %termCommitteeMember.attributes;>

<!--                                 LONG NAME: Domains                               -->
<!ENTITY % domains.content          "((%domain;)+)">
<!ENTITY % domains.attributes       "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <domains> element contains at least one domain of the term.
Category: Termentry elements-->
<!ELEMENT domains   %domains.content;>
<!ATTLIST domains   %domains.attributes;>

<!--                                 LONG NAME: Domain                                -->
<!ENTITY % domain.content           "EMPTY">
<!ENTITY % domain.attributes        "%univ-atts;
                                     value
                                        CDATA
                                           #REQUIRED
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <domain> element contains the domain of the term.
Category: Termentry elements-->
<!ELEMENT domain   %domain.content;>
<!ATTLIST domain   %domain.attributes;>

<!--                                 LONG NAME: Part of Speech                        -->
<!ENTITY % partOfSpeech.content     "EMPTY">
<!ENTITY % partOfSpeech.attributes  "%univ-atts;
                                     %partOfSpeech-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <partOfSpeech> element contains the part of speech of the term.
Category: Termentry elements-->
<!ELEMENT partOfSpeech   %partOfSpeech.content;>
<!ATTLIST partOfSpeech   %partOfSpeech.attributes;>

<!--                                 LONG NAME: Alternative Definition                -->
<!ENTITY % altDefinition.content    "((%altDefinitionText;),
                                      (%definitionSource;)?)
                                    ">
<!ENTITY % altDefinition.attributes "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <altDefinition> element contains an alternative definition.
Category: Termentry elements-->
<!ELEMENT altDefinition   %altDefinition.content;>
<!ATTLIST altDefinition   %altDefinition.attributes;>

<!--                                 LONG NAME: Alternative Definition Text           -->
<!ENTITY % altDefinitionText.attributes
                                    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <altDefinitionText> element contains the textual content of the alternative definition.
Category: Termentry elements-->
<!ELEMENT altDefinitionText    %div.content;>
<!ATTLIST altDefinitionText    %altDefinitionText.attributes;>

<!--                                 LONG NAME: Annotation                            -->
<!ENTITY % annotation.attributes    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <annotation> element contains annotations of the term.
Category: Termentry elements-->
<!ELEMENT annotation   %div.content;>
<!ATTLIST annotation   %annotation.attributes;>

<!--                                 LONG NAME: Term Body                             -->
<!ENTITY % termBody.content         "((((%fig;) | 
                                       (%note;) |
                                       (%domains;) |
                                       (%altDefinition;) |
                                       (%annotation;))*),
                                       (%agreedWith;)?,
                                       (%partOfSpeech;),
                                      ((%fullForm;) |
                                       (%abbreviation;) |
                                       (%acronym;) |
                                       (%verb;))*)">
<!ENTITY % termBody.attributes      "%id-atts;
                                     %localization-atts;
                                     base
                                        CDATA
                                           #IMPLIED
                                     %base-attribute-extensions;
                                        outputclass
                                           CDATA
                                              #IMPLIED">
<!--doc:The <termBody> element contains the body of a term.
Category: Termentry elements-->
<!ELEMENT termBody    %termBody.content;>
<!ATTLIST termBody    %termBody.attributes;>

<!--                                 LONG NAME: Related Terms Container               -->
<!ENTITY % relations.content        "((%antonyms;)?,
                                      (%hypernyms;)?,
                                      (%hyponyms;)?,
                                      (%instancesOf;)?,
                                      (%partsOf;)?,
                                      (%relatedTerms;)?)">
<!--doc:The <relations> element contains groups of term relations.
Category: Termentry elements-->
<!ELEMENT  relations %relations.content;>
<!ATTLIST  relations %related-links.attributes;>

<!--                                 Generic attributes for related terms groups      -->
<!ENTITY % termLinkGroup-atts       "collection-type
                                       (choice |
                                        family |
                                        sequence |
                                        unordered |
                                        -dita-use-conref-target |
                                        tree)
                                           #IMPLIED
                                     duplicates
                                       (no |
                                        yes |
                                        -dita-use-conref-target)
                                           #IMPLIED
                                     mapkeyref
                                        CDATA
                                           #IMPLIED
                                     cascade
                                        CDATA
                                           #IMPLIED
                                     format
                                        CDATA
                                           #IMPLIED
                                     scope
                                       (external |
                                        local |
                                        peer |
                                        -dita-use-conref-target)
                                           #IMPLIED
                                     role
                                       (ancestor |
                                        child |
                                        cousin |
                                        descendant |
                                        external |
                                        friend |
                                        next |
                                        other |
                                        parent |
                                        previous |
                                        sample |
                                        sibling |
                                        -dita-use-conref-target)
                                           #IMPLIED
                                     otherrole
                                        CDATA
                                           #IMPLIED
                                     %univ-atts;
                                     spectitle
                                        CDATA
                                           #IMPLIED
                                     outputclass
                                        CDATA
                                           #IMPLIED">

<!--                                 LONG NAME: Antonyms                              -->
<!ENTITY % antonyms.content         "((%antonym;)+)">
<!ENTITY % antonyms.attributes      "%termLinkGroup-atts;">
<!--doc:The <antonyms> element contains references to <antonym> elements.
Category: Termentry elements-->
<!ELEMENT  antonyms %antonyms.content;>
<!ATTLIST  antonyms %antonyms.attributes;>

<!--                                 LONG NAME: Hypernyms                             -->
<!ENTITY % hypernyms.content        "((%hypernym;)+)">
<!ENTITY % hypernyms.attributes     "%termLinkGroup-atts;">
<!--doc:The <hypernyms> element contains references to <hypernym> elements.
Category: Termentry elements-->
<!ELEMENT  hypernyms %hypernyms.content;>
<!ATTLIST  hypernyms %hypernyms.attributes;>

<!--                                 LONG NAME: Hyponyms                              -->
<!ENTITY % hyponyms.content         "((%hyponym;)+)">
<!ENTITY % hyponyms.attributes      "%termLinkGroup-atts;">
<!--doc:The <hyponyms> element contains references to <hyponym> elements.
Category: Termentry elements-->
<!ELEMENT  hyponyms %hyponyms.content;>
<!ATTLIST  hyponyms %hyponyms.attributes;>

<!--                                 LONG NAME: Instances Of                       -->
<!ENTITY % instancesOf.content    "((%instanceOf;)+)">
<!ENTITY % instancesOf.attributes "%termLinkGroup-atts;">
<!--doc:The <instancesOf> element contains references to <instanceOf> elements.
Category: Termentry elements-->
<!ELEMENT  instancesOf %instancesOf.content;>
<!ATTLIST  instancesOf %instancesOf.attributes;>

<!--                                 LONG NAME: Parts Of                           -->
<!ENTITY % partsOf.content        "((%partOf;)+)">
<!ENTITY % partsOf.attributes     "%termLinkGroup-atts;">
<!--doc:The <partsOf> element contains references to <partOf> elements.
Category: Termentry elements-->
<!ELEMENT  partsOf %partsOf.content;>
<!ATTLIST  partsOf %partsOf.attributes;>

<!--                                 LONG NAME: Related Terms                         -->
<!ENTITY % relatedTerms.content     "((%relatedTerm;)+)">
<!ENTITY % relatedTerms.attributes  "%termLinkGroup-atts;">
<!--doc:The <relatedTerms> element contains references to <relatedTerm> elements.
Category: Termentry elements-->
<!ELEMENT  relatedTerms %relatedTerms.content;>
<!ATTLIST  relatedTerms %relatedTerms.attributes;>

<!--                                 LONG NAME: Definition Source                     -->
<!ENTITY % definitionSource.content "(((%sourceName;)?),
                                      ((%sourceReference;)?))">
<!ENTITY % definitionSource.attributes
                                    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <definitionSource> element refers to the source of a definition, e.g. a link to Wikipedia.
Category: Termentry elements-->
<!ELEMENT definitionSource    %definitionSource.content;>
<!ATTLIST definitionSource    %definitionSource.attributes;>

<!--                                 LONG NAME: Source Reference                      -->
<!--doc:The <sourceReference> refers to the source of a definition, e.g. to a file or website.
Category: Termentry elements-->
<!ELEMENT sourceReference    %xref.content;>
<!ATTLIST sourceReference    %xref.attributes;>

<!--                                 LONG NAME: Source Name                           -->
<!ENTITY % sourceName.content     "(#PCDATA)*">
<!ENTITY % sourceName.attributes  "%data-element-atts;">
<!--doc:The <sourceName> refers to a document and contains its name.
Category: Termentry elements-->
<!ELEMENT sourceName    %sourceName.content;>
<!ATTLIST sourceName    %sourceName.attributes;>

<!--                                 LONG NAME: Term Variant                          -->
<!ENTITY % termVariant.content      "(#PCDATA | 
                                      %keyword; | 
                                      %term; | 
                                      %tm;)*">
<!ENTITY % termVariant.attributes   "%id-atts;
                                     %localization-atts;
                                     base
                                        CDATA
                                           #IMPLIED
                                     %base-attribute-extensions;
                                     %caseSelection-atts;
                                     %numberSelection-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <termVariant> element contains the written form of a term.
Category: Termentry elements-->
<!ELEMENT termVariant    %termVariant.content;>
<!ATTLIST termVariant    %termVariant.attributes;>

<!--                                 LONG NAME: Term Context                          -->
<!ENTITY % termContext.content      "((%termContextText;),
                                      (%termContextSource;)?)">
<!ENTITY % termContext.attributes "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <termContext> element contain a context example of the term.
Category: Termentry elements-->
<!ELEMENT termContext   %termContext.content;>
<!ATTLIST termContext   %termContext.attributes;>

<!--                                 LONG NAME: Term Context Text                     -->
<!ENTITY % termContextText.content  "(#PCDATA)*">
<!ENTITY % termContextText.attributes
                                    "%univ-atts;
                                     outputclass 
                                        CDATA 
                                           #IMPLIED">
<!--doc:The <termContextText> element contain a context example of the term.
Category: Termentry elements-->
<!ELEMENT termContextText   %termContextText.content;>
<!ATTLIST termContextText   %termContextText.attributes;>

<!--                                 LONG NAME: Term Context Source                   -->
<!ENTITY % termContextSource.content "(((%sourceName;)?),
                                       ((%sourceReference;)?))">
<!ENTITY % termContextSource.attributes
                                    "%univ-atts;
                                     outputclass 
                                        CDATA 
                                           #IMPLIED">
<!--doc:The <termContextSource> element contains the source of the context example.
Category: Termentry elements-->
<!ELEMENT termContextSource   %termContextSource.content;>
<!ATTLIST termContextSource   %termContextSource.attributes;>

<!--                                 LONG NAME: Term Source                           -->
<!ENTITY % termSource.content       "(((%sourceName;)?),
                                      ((%sourceReference;)?))">
<!ENTITY % termSource.attributes  "%univ-atts;
                                     outputclass 
                                        CDATA 
                                           #IMPLIED">
<!--doc:The <termSource> element contains the source of the term.
Category: Termentry elements-->
<!ELEMENT termSource   %termSource.content;>
<!ATTLIST termSource   %termSource.attributes;>

<!--                                 LONG NAME: Generic Term                          -->
<!ENTITY % genericTerm.content      "(((%termVariant;)+),
                                      ((%annotation;)?),
                                      ((%termContext;)?),
                                      ((%termSource;)?))">
<!ENTITY % genericTerm.attributes   "%term-atts;
                                     %languageSelection-atts;
                                     %genderSelection-atts;">

<!--                                 Generic link attributes for term relation links  -->
<!ENTITY % termLink-atts            "href
                                        CDATA
                                           #IMPLIED
                                     keyref
                                        CDATA
                                           #IMPLIED
                                     type
                                        CDATA
                                           'termentry'
                                     query
                                        CDATA
                                           #IMPLIED
                                     cascade
                                        CDATA
                                           #IMPLIED
                                     format
                                        CDATA
                                           #IMPLIED
                                     scope
                                       (external |
                                        local |
                                        peer |
                                        -dita-use-conref-target)
                                           #IMPLIED
                                     role
                                       (ancestor |
                                        child |
                                        cousin |
                                        descendant |
                                        external |
                                        friend |
                                        next |
                                        other |
                                        parent |
                                        previous |
                                        sample |
                                        sibling |
                                        -dita-use-conref-target)
                                           #IMPLIED
                                     otherrole
                                        CDATA
                                           #IMPLIED
                                     %univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">

<!--                                 LONG NAME: Full Form                             -->
<!--doc:The <fullForm> element contains the full written form of a term.
Category: Termentry elements-->
<!ELEMENT fullForm        %genericTerm.content;>
<!ATTLIST fullForm        %genericTerm.attributes;>

<!--                                 LONG NAME: Abbreviation                          -->
<!--doc:The <abbreviation> element contains the abbreviated form of a term.
Category: Termentry elements-->
<!ELEMENT abbreviation    %genericTerm.content;>
<!ATTLIST abbreviation    %genericTerm.attributes;>

<!--                                 LONG NAME: Acronym                               -->
<!--doc:The <acronym> element contains the acronym of a term.
Category: Termentry elements-->
<!ELEMENT acronym         %genericTerm.content;>
<!ATTLIST acronym         %genericTerm.attributes;>

<!--                                 LONG NAME: Verb                                  -->
<!--doc:The <verb> element contains a verb.
Category: Termentry elements-->
<!ELEMENT verb            %genericTerm.content;>
<!ATTLIST verb            %genericTerm.attributes;>

<!--                                 LONG NAME: Antonym                               -->
<!ENTITY % antonym.attributes       "%termLink-atts;
                                     type
                                        CDATA
                                           'termentry'">
<!--doc:The <antonym> element refers to the antonym of a term.
Category: Termentry elements-->
<!ELEMENT antonym         %link.content;>
<!ATTLIST antonym         %antonym.attributes;>

<!--                                 LONG NAME: Hypernym                              -->
<!ENTITY % hypernym.attributes      "%termLink-atts;
                                     type
                                        CDATA
                                           'termentry'">
<!--doc:The <hypernym> element refers to the hypernym of a term.
Category: Termentry elements-->
<!ELEMENT hypernym        %link.content;>
<!ATTLIST hypernym        %hypernym.attributes;>

<!--                                 LONG NAME: Hyponym                               -->
<!ENTITY % hyponym.attributes       "%termLink-atts;
                                     type
                                        CDATA
                                           'termentry'">
<!--doc:The <hyponym> element refers to the hyponym of a term.
Category: Termentry elements-->
<!ELEMENT hyponym         %link.content;>
<!ATTLIST hyponym         %hyponym.attributes;>

<!--                                 LONG NAME: Instance Of                           -->
<!ENTITY % instanceOf.attributes  "%termLink-atts;
                                   type
                                      CDATA
                                         'termentry'">
<!--doc:The <instanceOf> element indicates, that the current term is an instance ot the referenced term.
Category: Termentry elements-->
<!ELEMENT instanceOf    %link.content;>
<!ATTLIST instanceOf    %instanceOf.attributes;>

<!--                                 LONG NAME: Part Of                               -->
<!ENTITY % partOf.attributes      "%termLink-atts;
                                   type
                                      CDATA
                                         'termentry'">
<!--doc:The <partOf> element indicates, that the current term is part ot the referenced term.
Category: Termentry elements-->
<!ELEMENT partOf        %link.content;>
<!ATTLIST partOf        %partOf.attributes;>

<!--                                 LONG NAME: Related Term                          -->
<!ENTITY % relatedTerm.attributes   "%termLink-atts;
                                     type
                                        CDATA
                                           'termentry'">
<!--doc:The <relatedTerm> element refers to a related term.
Category: Termentry elements-->
<!ELEMENT relatedTerm     %link.content;>
<!ATTLIST relatedTerm     %relatedTerm.attributes;>



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST abbreviation          %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/abbreviation ">
<!ATTLIST acronym               %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/acronym ">
<!ATTLIST agreedWith            %global-atts;   class CDATA "- topic/ul termentry/agreedWith ">
<!ATTLIST altDefinition         %global-atts;   class CDATA "- topic/div termentry/altDefinition ">
<!ATTLIST altDefinitionText     %global-atts;   class CDATA "- topic/div termentry/altDefinitionText ">
<!ATTLIST annotation            %global-atts;   class CDATA "- topic/div termentry/annotation ">
<!ATTLIST antonym               %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/antonym ">
<!ATTLIST antonyms              %global-atts;   class CDATA "- topic/linklist termentry/relations-linklist termentry/antonyms ">
<!ATTLIST definition            %global-atts;   class CDATA "- topic/abstract termentry/definition ">
<!ATTLIST definitionSource      %global-atts;   class CDATA "- topic/div termentry/definitionSource ">
<!ATTLIST definitionText        %global-atts;   class CDATA "- topic/shortdesc termentry/definitionText ">
<!ATTLIST domain                %global-atts;   class CDATA "- topic/data concept/data termentry/domain ">
<!ATTLIST domains               %global-atts;   class CDATA "- topic/div termentry/domains ">
<!ATTLIST fullForm              %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/fullForm ">
<!ATTLIST hypernym              %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/hypernym ">
<!ATTLIST hypernyms             %global-atts;   class CDATA "- topic/linklist termentry/relations-linklist termentry/hypernyms ">
<!ATTLIST hyponym               %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/hyponym ">
<!ATTLIST hyponyms              %global-atts;   class CDATA "- topic/linklist termentry/relations-linklist termentry/hyponyms ">
<!ATTLIST instanceOf            %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/instanceOf ">
<!ATTLIST instancesOf           %global-atts;   class CDATA "- topic/linklist termentry/relations-linklist termentry/instancesOf ">
<!ATTLIST partOf                %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/partOf ">
<!ATTLIST partsOf               %global-atts;   class CDATA "- topic/linklist termentry/relations-linklist termentry/partsOf ">
<!ATTLIST partOfSpeech          %global-atts;   class CDATA "- topic/data concept/data termentry/partOfSpeech ">
<!ATTLIST relatedTerm           %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/relatedTerm ">
<!ATTLIST relatedTerms          %global-atts;   class CDATA "- topic/linklist termentry/relations-linklist termentry/relatedTerms ">
<!ATTLIST relations             %global-atts;   class CDATA "- topic/related-links termentry/relations ">
<!ATTLIST sourceName            %global-atts;   class CDATA "- topic/text termentry/sourceName ">
<!ATTLIST sourceReference       %global-atts;   class CDATA "- topic/xref concept/xref termentry/sourceReference ">
<!ATTLIST termBody              %global-atts;   class CDATA "- topic/body concept/conbody termentry/termBody ">
<!ATTLIST termCommitteeMember   %global-atts;   class CDATA "- topic/li termentry/termCommitteeMember ">
<!ATTLIST termContext           %global-atts;   class CDATA "- topic/div termentry/termContext ">
<!ATTLIST termContextSource     %global-atts;   class CDATA "- topic/div termentry/termContextSource ">
<!ATTLIST termContextText       %global-atts;   class CDATA "- topic/text termentry/termContextText ">
<!ATTLIST termSource            %global-atts;   class CDATA "- topic/text termentry/termSource ">
<!ATTLIST termVariant           %global-atts;   class CDATA "- topic/text termentry/termVariant ">
<!ATTLIST termentry             %global-atts;   class CDATA "- topic/topic concept/concept termentry/termentry ">
<!ATTLIST verb                  %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/verb ">

<!-- ================================= End of file ================================== -->
