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
<!ENTITY % termDefinition        "termDefinition"                                       >
<!ENTITY % termMeta              "termMeta"                                             >
<!ENTITY % termDefinitionSource  "termDefinitionSource"                                 >
<!ENTITY % termBody              "termBody"                                             >
<!ENTITY % termFullForm          "termFullForm"                                         >
<!ENTITY % termVariant           "termVariant"                                          >



<!-- ================================================================================ -->
<!--                              COMMON ATTLIST SETS                                 -->
<!-- ================================================================================ -->

<!ENTITY % usage-atts 
                                 'usage
                                     (deprecated |
                                      allowed)
                                         #IMPLIED'>



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains     ""                                                      >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Term Entry                            -->

<!ENTITY % termentry.content        "((%title;),
                                      (%termDefinition;)?,
                                      (%termMeta;)?,
                                      (%termBody;)?,
                                      (%termentry-info-types;)*)">
<!ENTITY % termentry.attributes
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
<!--doc:The <termentry> element is the root element of a termentry topic. A term entry represents a terminology concept and includes one or multiple term words and defines their usage.
Category: Termentry elements-->
<!ELEMENT termentry                  %termentry.content;>
<!ATTLIST termentry                  %termentry.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">

<!--                                 LONG NAME: Term Definition                       -->
<!ENTITY % termDefinition.content
                       "(%abstract.cnt;)*"
>
<!ENTITY % termDefinition.attributes
             "%univ-atts;
              outputclass 
                        CDATA 
                                  #IMPLIED"
>
<!ELEMENT termDefinition    %termDefinition.content;>
<!ATTLIST termDefinition    %termDefinition.attributes;>

<!--                                 LONG NAME: Term Meta                             -->
<!ENTITY % termMeta.content
                       "((%author;)*, 
                         (%source;)?, 
                         (%publisher;)?,
                         (%copyright;)*, 
                         (%critdates;)?,
                         (%permissions;)?, 
                         (%metadata;)*, 
                         (%resourceid;)*,
                         (%data.elements.incl; | 
                          %foreign.unknown.incl;)*)"
>
<!ENTITY % termMeta.attributes
             "%univ-atts;"
>
<!ELEMENT termMeta    %termMeta.content;>
<!ATTLIST termMeta    %termMeta.attributes;>




<!--                                 LONG NAME: Term Body                             -->
<!ENTITY % termBody.content
                       "((%termDefinitionSource;)?,
                         (%termFullForm;)*)"
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
<!ELEMENT termBody    %termBody.content;>
<!ATTLIST termBody    %termBody.attributes;>


<!--                    LONG NAME: Term Definition Source                             -->
<!ENTITY % termDefinitionSource.content
                       "EMPTY
">
<!ENTITY % termDefinitionSource.attributes
             "%data-element-atts;"
>
<!ELEMENT termDefinitionSource    %termDefinitionSource.content;>
<!ATTLIST termDefinitionSource    %termDefinitionSource.attributes;>

<!--                    LONG NAME: Term Full Form                                     -->
<!ENTITY % termFullForm.content
                       "((%termVariant;))
">
<!ENTITY % termFullForm.attributes
             "%univ-atts;
              %localization-atts;
              %usage-atts;
              domain 
                        CDATA
                                  #IMPLIED
              outputclass 
                        CDATA 
                                  #IMPLIED"
>
<!ELEMENT termFullForm    %termFullForm.content;>
<!ATTLIST termFullForm    %termFullForm.attributes;>

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
<!ELEMENT termVariant    %termVariant.content;>
<!ATTLIST termVariant    %termVariant.attributes;>



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST termentry  %global-atts; class CDATA "- topic/topic concept/concept termentry/termentry ">
<!ATTLIST termDefinition %global-atts;  class CDATA "- topic/abstract concept/abstract termentry/termDefinition ">
<!ATTLIST termMeta  %global-atts;  class CDATA "- topic/prolog termentry/termMeta ">
<!ATTLIST termBody   %global-atts;  class CDATA "- topic/body concept/conbody termentry/termBody ">
<!ATTLIST termDefinitionSource   %global-atts;  class CDATA "- topic/data concept/data termentry/termDefinitionSource ">
<!ATTLIST termFullForm    %global-atts;  class CDATA "- topic/section concept/section termentry/termFullForm ">
<!ATTLIST termVariant    %global-atts;  class CDATA "- topic/data concept/data termEntry/termVariant ">


<!-- synonyms, antonyms, related, hyponym (Unterbegriff), hypernym (Oberbegriff), definition, definition source, agreed with, annotation, domain, part of speech, language, usage, context, source of context, annotations, source of term-->

<!-- ================================= End of file ================================== -->
