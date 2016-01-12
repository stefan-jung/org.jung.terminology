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
<!ENTITY % definition            "definition"                                           >
<!ENTITY % definitionSource      "definitionSource"                                     >
<!ENTITY % domain                "domain"                                               >
<!ENTITY % fullForm              "fullForm"                                             >
<!ENTITY % hypernym              "hypernym"                                             >
<!ENTITY % hyponym               "hyponym"                                              >
<!ENTITY % partOfSpeech          "partOfSpeech"                                         >
<!ENTITY % relatedTerm           "relatedTerm"                                          >
<!ENTITY % synoynm               "synoynm"                                              >
<!ENTITY % termBody              "termBody"                                             >
<!ENTITY % termVariant           "termVariant"                                          >
<!ENTITY % termentry             "termentry"                                            >



<!-- ================================================================================ -->
<!--                              COMMON ATTLIST SETS                                 -->
<!-- ================================================================================ -->

<!--                                 Generic term attributes for all term elements    -->
<!ENTITY % term-atts                "
                                     %id-atts;
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
<!ENTITY % languageSelection-atts   "
                                     language
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
                                    

<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains     ""                                                      >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Term Entry                            -->

<!ENTITY % termentry.content        "((%title;),
                                      (%definition;)?,
                                      (%definitionSource;)?,
                                      (%termBody;)?,
                                      (%termentry-info-types;)*)">
<!ENTITY % termentry.attributes
                                    "%id-atts;
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED"
>
<!--doc:The <termentry> element is the root element of a termentry topic. A term entry represents a terminology concept and includes one or multiple term words and defines their usage.
Category: Termentry elements-->
<!ELEMENT termentry                  %termentry.content;>
<!ATTLIST termentry                  %termentry.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">

<!--                                 LONG NAME: Term Definition                       -->
<!ENTITY % definition.content
                       "(%abstract.cnt;)*"
>
<!ENTITY % definition.attributes
             "%univ-atts;
              outputclass 
                        CDATA 
                                  #IMPLIED"
>
<!--doc:The <definition> element contains the definition of a term.
Category: Termentry elements-->
<!ELEMENT definition    %definition.content;>
<!ATTLIST definition    %definition.attributes;>



<!--                                 LONG NAME: Term Body                             -->
<!ENTITY % termBody.content
                       "((%definitionSource;)?,
                         ((%fullForm;) |
                          (%abbreviation;) |
                          (%acronym;) |
                          (%synoynm;) |
                          (%antonym;) |
                          (%hypernym;) |
                          (%hyponym;) |
                          (%relatedTerm;))*)"
>
<!ENTITY % termBody.attributes
             "%id-atts;
              %localization-atts;
              base 
                        CDATA 
                                  #IMPLIED
              %base-attribute-extensions;
              outputclass 
                        CDATA 
                                  #IMPLIED"
>
<!--doc:The <termBody> element contains the body of a term.
Category: Termentry elements-->
<!ELEMENT termBody    %termBody.content;>
<!ATTLIST termBody    %termBody.attributes;>


<!--                    LONG NAME: Term Definition Source                             -->
<!ENTITY % definitionSource.content
                       "EMPTY">
<!ENTITY % definitionSource.attributes
             "%data-element-atts;"
>
<!--doc:The <definitionSource> element refers to the source of a definition, e.g. a link to Wikipedia.
Category: Termentry elements-->
<!ELEMENT definitionSource    %definitionSource.content;>
<!ATTLIST definitionSource    %definitionSource.attributes;>



<!--                    LONG NAME: Term Variant                                       -->
<!ENTITY % termVariant.content
                       "(#PCDATA |
                         %keyword; |
                         %term; |
                         %tm;)*"
>
<!ENTITY % termVariant.attributes
             "%id-atts;
              %localization-atts;
              base 
                        CDATA 
                                  #IMPLIED
              %base-attribute-extensions;
              outputclass
                        CDATA 
                                  #IMPLIED"
>
<!--doc:The <termVariant> element contains the written form of a term.
Category: Termentry elements-->
<!ELEMENT termVariant    %termVariant.content;>
<!ATTLIST termVariant    %termVariant.attributes;>

<!--                    LONG NAME: Generic Term                                       -->
<!ENTITY % genericTerm.content          "
                                         (%termVariant;)
                                        ">
<!ENTITY % genericTerm.attributes       "
                                         %term-atts;
                                         %languageSelection-atts;
                                        ">

<!--doc:The <fullForm> element contains the full written form of a term.
Category: Termentry elements-->
<!ELEMENT fullForm        %genericTerm.content;>
<!ATTLIST fullForm        %genericTerm.attributes;>

<!--doc:The <abbreviation> element contains the abbreviated form of a term.
Category: Termentry elements-->
<!ELEMENT abbreviation    %genericTerm.content;>
<!ATTLIST abbreviation    %genericTerm.attributes;>

<!--doc:The <acronym> element contains the acronym of a term.
Category: Termentry elements-->
<!ELEMENT acronym         %genericTerm.content;>
<!ATTLIST acronym         %genericTerm.attributes;>

<!--doc:The <synoynm> element contains the synoynm of a term.
Category: Termentry elements-->
<!ELEMENT synoynm         %genericTerm.content;>
<!ATTLIST synoynm         %genericTerm.attributes;>

<!--doc:The <antonym> element refers to the antonym of a term.
Category: Termentry elements-->
<!ELEMENT antonym         %xref.content;>
<!ATTLIST antonym         %xref.attributes;>

<!--doc:The <hypernym> element refers to the hypernym of a term.
Category: Termentry elements-->
<!ELEMENT hypernym        %xref.content;>
<!ATTLIST hypernym        %xref.attributes;>

<!--doc:The <hyponym> element refers to the hyponym of a term.
Category: Termentry elements-->
<!ELEMENT hyponym         %xref.content;>
<!ATTLIST hyponym         %xref.attributes;>

<!--doc:The <relatedTerm> element refers to a related term.
Category: Termentry elements-->
<!ELEMENT relatedTerm     %xref.content;>
<!ATTLIST relatedTerm     %xref.attributes;>



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST abbreviation     %global-atts;   class CDATA "- topic/section concept/section termentry/abbreviation ">
<!ATTLIST acronym          %global-atts;   class CDATA "- topic/section concept/section termentry/acronym ">
<!ATTLIST agreedWith       %global-atts;   class CDATA "- topic/data concept/data termEntry/agreedWith ">
<!ATTLIST annotation       %global-atts;   class CDATA "- topic/data concept/data termEntry/annotation ">
<!ATTLIST antonym          %global-atts;   class CDATA "- topic/xref concept/xref termentry/antonym ">
<!ATTLIST definition       %global-atts;   class CDATA "- topic/abstract concept/abstract termentry/definition ">
<!ATTLIST definitionSource %global-atts;   class CDATA "- topic/xref concept/xref termentry/definitionSource ">
<!ATTLIST domain           %global-atts;   class CDATA "- topic/data concept/data termEntry/domain ">
<!ATTLIST fullForm         %global-atts;   class CDATA "- topic/section concept/section termentry/fullForm ">
<!ATTLIST hypernym         %global-atts;   class CDATA "- topic/xref concept/xref termentry/hypernym ">
<!ATTLIST hyponym          %global-atts;   class CDATA "- topic/xref concept/xref termentry/hyponym ">
<!ATTLIST partOfSpeech     %global-atts;   class CDATA "- topic/data concept/data termEntry/partOfSpeech ">
<!ATTLIST relatedTerm      %global-atts;   class CDATA "- topic/xref concept/xref termentry/relatedTerm ">
<!ATTLIST synoynm          %global-atts;   class CDATA "- topic/section concept/section termentry/synoynm ">
<!ATTLIST termBody         %global-atts;   class CDATA "- topic/body concept/conbody termentry/termBody ">
<!ATTLIST termVariant      %global-atts;   class CDATA "- topic/data concept/data termEntry/termVariant ">
<!ATTLIST termentry        %global-atts;   class CDATA "- topic/topic concept/concept termentry/termentry ">

<!-- ================================= End of file ================================== -->
