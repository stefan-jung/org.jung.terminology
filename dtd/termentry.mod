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

<!ENTITY % abbreviation          "abbreviation"                                         >
<!ENTITY % acronym               "acronym"                                              >
<!ENTITY % agreedWith            "agreedWith"                                           >
<!ENTITY % acronym               "acronym"                                              >
<!ENTITY % annotation            "annotation"                                           >
<!ENTITY % antonym               "antonym"                                              >
<!ENTITY % termContext           "termContext"                                          >
<!ENTITY % termContextText       "termContextText"                                      >
<!ENTITY % termContextSource     "termContextSource"                                    >
<!ENTITY % definition            "definition"                                           >
<!ENTITY % definitionText        "definitionText"                                       >
<!ENTITY % definitionSource      "definitionSource"                                     >
<!ENTITY % sourceName            "sourceName"                                           >
<!ENTITY % sourceReference       "sourceReference"                                      >
<!ENTITY % domain                "domain"                                               >
<!ENTITY % fullForm              "fullForm"                                             >
<!ENTITY % hypernym              "hypernym"                                             >
<!ENTITY % hyponym               "hyponym"                                              >
<!ENTITY % isPartOf              "isPartOf"                                             >
<!ENTITY % partOfSpeech          "partOfSpeech"                                         >
<!ENTITY % relatedTerm           "relatedTerm"                                          >
<!ENTITY % relatedTerms          "relatedTerms"                                         >
<!ENTITY % termSource            "termSource"                                           >
<!ENTITY % termBody              "termBody"                                             >
<!ENTITY % termVariant           "termVariant"                                          >
<!ENTITY % termentry             "termentry"                                            >
<!ENTITY % termCommitteeMember   "termCommitteeMember"                                  >



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
                                        (allowed | deprecated)
                                           #REQUIRED
                                     domain
                                        CDATA
                                           #IMPLIED   
                                    ">

<!--                                 Language of term                                 -->
<!ENTITY % languageSelection-atts   "language
                                        (af | 
                                         ar-ae | 
                                         ar-bh | 
                                         ar-dz | 
                                         ar-eg | 
                                         ar-iq | 
                                         ar-jo | 
                                         ar-kw | 
                                         ar-lb | 
                                         ar-ly | 
                                         ar-ma | 
                                         ar-om | 
                                         ar-qa | 
                                         ar-sa | 
                                         ar-sy | 
                                         ar-tn | 
                                         ar-ye | 
                                         be | 
                                         bg | 
                                         ca | 
                                         cs | 
                                         da | 
                                         de | 
                                         de-at | 
                                         de-ch | 
                                         de-li | 
                                         de-lu | 
                                         el | 
                                         en | 
                                         en-au | 
                                         en-bz | 
                                         en-ca | 
                                         en-gb | 
                                         en-ie | 
                                         en-jm | 
                                         en-nz | 
                                         en-tt | 
                                         en-us | 
                                         en-za | 
                                         es | 
                                         es-ar | 
                                         es-bo | 
                                         es-cl | 
                                         es-co | 
                                         es-cr | 
                                         es-do | 
                                         es-ec | 
                                         es-gt | 
                                         es-hn | 
                                         es-mx | 
                                         es-ni | 
                                         es-pa | 
                                         es-pe | 
                                         es-pr | 
                                         es-py | 
                                         es-sv | 
                                         es-uy | 
                                         es-ve | 
                                         et | 
                                         eu | 
                                         fa | 
                                         fi | 
                                         fo | 
                                         fr | 
                                         fr-be | 
                                         fr-ca | 
                                         fr-ch | 
                                         fr-lu | 
                                         ga | 
                                         gd | 
                                         he | 
                                         hi | 
                                         hr | 
                                         hu | 
                                         id | 
                                         is | 
                                         it | 
                                         it-ch | 
                                         ja | 
                                         ji | 
                                         ko | 
                                         lt | 
                                         lv | 
                                         mk | 
                                         ms | 
                                         mt | 
                                         nl | 
                                         nl-be | 
                                         no | 
                                         pl | 
                                         pt | 
                                         pt-br | 
                                         rm | 
                                         ro | 
                                         ro-mo | 
                                         ru | 
                                         ru-mo | 
                                         sb | 
                                         sk | 
                                         sl | 
                                         sq | 
                                         sr | 
                                         sv | 
                                         sv-fi | 
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
                                         zh-cn | 
                                         zh-hk | 
                                         zh-sg | 
                                         zh-tw | 
                                         zu)
                                           #REQUIRED   
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
                                           #IMPLIED   
                                    ">
                                    
<!--                                 Number of term                                   -->
<!ENTITY % numberSelection-atts     "number
                                        (singular |
                                         plural)
                                           #IMPLIED   
                                    ">

<!--                                 Word types                                       -->
<!ENTITY % wordTypeSelection-atts   "wordType
                                        (noun |
                                         verb |
                                         adjective)
                                           #IMPLIED   
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
                                      (%partOfSpeech;)?,
                                      (%domain;)*,
                                      (%agreedWith;)?,
                                      (%annotation;)*,
                                      (%termBody;)?,
                                      (%relatedTerms;)?,
                                      (%termentry-info-types;)?)
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
<!ENTITY % definitionText.content   "(#PCDATA)*">
<!ENTITY % definitionText.attributes "%univ-atts;
                                      outputclass
                                         CDATA
                                            #IMPLIED">
<!--doc:The <definitionText> element contains the textual content of the definition.
Category: Termentry elements-->
<!ELEMENT definitionText    %definitionText.content;>
<!ATTLIST definitionText    %definitionText.attributes;>

<!--                                 LONG NAME: Agreed With                           -->
<!ENTITY % agreedWith.content       "(%termCommitteeMember;)*">
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
                                     value
                                        (noun |
                                         pronoun |
                                         adjective |
                                         verb |
                                         adverb |
                                         preposition |
                                         conjunction |
                                         interjection |
                                         article)
                                           'noun'
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <partOfSpeech> element contains the part of speech of the term.
Category: Termentry elements-->
<!ELEMENT partOfSpeech   %partOfSpeech.content;>
<!ATTLIST partOfSpeech   %partOfSpeech.attributes;>

<!--                                 LONG NAME: Annotation                            -->
<!ENTITY % annotation.content       "(#PCDATA)*">
<!ENTITY % annotation.attributes    "%univ-atts;
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <annotation> element contains annotations of the term.
Category: Termentry elements-->
<!ELEMENT annotation   %annotation.content;>
<!ATTLIST annotation   %annotation.attributes;>

<!--                                 LONG NAME: Term Body                             -->
<!ENTITY % termBody.content         "((((%fig;) | 
                                      (%note;))*),
                                      ((%fullForm;) |
                                       (%abbreviation;) |
                                       (%acronym;))*)">
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

<!--                                 LONG NAME: Related Terms                         -->
<!ENTITY % relatedTerms.content     "(((%antonym;) |
                                       (%hypernym;) |
                                       (%hyponym;) |
                                       (%isPartOf;) |
                                       (%link;) |
                                       (%relatedTerm;))*)">
<!--doc:The <relatedTerms> element contains references to related terms.
Category: Termentry elements-->
<!ELEMENT  relatedTerms %relatedTerms.content;>
<!ATTLIST  relatedTerms %related-links.attributes;>

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

<!--                                 LONG NAME: Document Reference                    -->
<!--doc:The <sourceReference> refers to the source of a definition, e.g. to a file or website.
Category: Termentry elements-->
<!ELEMENT sourceReference    %xref.content;>
<!ATTLIST sourceReference    %xref.attributes;>

<!--                                 LONG NAME: Document Name                         -->
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

<!--                                 LONG NAME: Term Context Text                     -->
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
                                      ((%termContext;)?),
                                      ((%annotation;)?),
                                      ((%termSource;)?))">
<!ENTITY % genericTerm.attributes   "%term-atts;
                                     %languageSelection-atts;
                                     %genderSelection-atts;
                                     %wordTypeSelection-atts;">

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

<!--                                 LONG NAME: Antonym                               -->
<!--doc:The <antonym> element refers to the antonym of a term.
Category: Termentry elements-->
<!ELEMENT antonym         %xref.content;>
<!ATTLIST antonym         %xref.attributes;>

<!--                                 LONG NAME: Hypernym                              -->
<!--doc:The <hypernym> element refers to the hypernym of a term.
Category: Termentry elements-->
<!ELEMENT hypernym        %xref.content;>
<!ATTLIST hypernym        %xref.attributes;>

<!--                                 LONG NAME: Hyponym                               -->
<!--doc:The <hyponym> element refers to the hyponym of a term.
Category: Termentry elements-->
<!ELEMENT hyponym         %xref.content;>
<!ATTLIST hyponym         %xref.attributes;>

<!--                                 LONG NAME: Is Part Of                            -->
<!--doc:The <isPartOf> element indicates, that the current term is part ot the referenced term.
Category: Termentry elements-->
<!ELEMENT isPartOf        %xref.content;>
<!ATTLIST isPartOf        %xref.attributes;>

<!--                                 LONG NAME: Related Term                          -->
<!--doc:The <relatedTerm> element refers to a related term.
Category: Termentry elements-->
<!ELEMENT relatedTerm     %xref.content;>
<!ATTLIST relatedTerm     %xref.attributes;>



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST abbreviation          %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/abbreviation ">
<!ATTLIST acronym               %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/acronym ">
<!ATTLIST agreedWith            %global-atts;   class CDATA "- topic/data concept/data termEntry/agreedWith ">
<!ATTLIST annotation            %global-atts;   class CDATA "- topic/data concept/data termEntry/annotation ">
<!ATTLIST antonym               %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/antonym ">
<!ATTLIST definition            %global-atts;   class CDATA "- topic/abstract termentry/definition ">
<!ATTLIST definitionSource      %global-atts;   class CDATA "- topic/data concept/data termEntry/definitionSource ">
<!ATTLIST definitionText        %global-atts;   class CDATA "- topic/shortdesc termentry/definitionText ">
<!ATTLIST sourceName            %global-atts;   class CDATA "- topic/data concept/data termEntry/sourceName ">
<!ATTLIST sourceReference       %global-atts;   class CDATA "- topic/xref concept/xref termentry/sourceReference ">
<!ATTLIST domain                %global-atts;   class CDATA "- topic/data concept/data termEntry/domain ">
<!ATTLIST fullForm              %global-atts;   class CDATA "- topic/section concept/section termentry/termNotation termentry/fullForm ">
<!ATTLIST hypernym              %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/hypernym ">
<!ATTLIST hyponym               %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/hyponym ">
<!ATTLIST isPartOf              %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/isPartOf ">
<!ATTLIST partOfSpeech          %global-atts;   class CDATA "- topic/data concept/data termEntry/partOfSpeech ">
<!ATTLIST relatedTerm           %global-atts;   class CDATA "- topic/link termentry/termRelation termentry/relatedTerm ">
<!ATTLIST relatedTerms          %global-atts;   class CDATA "- topic/related-links termEntry/relatedTerms ">
<!ATTLIST termContext           %global-atts;   class CDATA "- topic/data concept/data termEntry/termContext ">
<!ATTLIST termContextSource     %global-atts;   class CDATA "- topic/data concept/data termEntry/termContextSource ">
<!ATTLIST termContextText       %global-atts;   class CDATA "- topic/data concept/data termEntry/termContextText ">
<!ATTLIST termSource            %global-atts;   class CDATA "- topic/data concept/data termEntry/termSource ">
<!ATTLIST termBody              %global-atts;   class CDATA "- topic/body concept/conbody termentry/termBody ">
<!ATTLIST termVariant           %global-atts;   class CDATA "- topic/data concept/data termEntry/termVariant ">
<!ATTLIST termentry             %global-atts;   class CDATA "- topic/topic concept/concept termentry/termentry ">
<!ATTLIST termCommitteeMember   %global-atts;   class CDATA "- topic/data concept/data termEntry/termCommitteeMember ">

<!-- ================================= End of file ================================== -->
