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
<!ENTITY % definition            "definition"                                           >
<!ENTITY % termMeta              "termMeta"                                             >
<!ENTITY % definitionSource      "definitionSource"                                     >
<!ENTITY % termBody              "termBody"                                             >



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
<!ENTITY % definition.content
                       "(%abstract.cnt;)*"
>
<!ENTITY % definition.attributes
             "%univ-atts;
              outputclass 
                        CDATA 
                                  #IMPLIED"
>
<!ELEMENT definition    %definition.content;>
<!ATTLIST definition    %definition.attributes;>

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
                       "EMPTY"
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

<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST termentry  %global-atts; class CDATA "- topic/topic concept/concept termentry/termentry ">
<!ATTLIST definition %global-atts;  class CDATA "- topic/abstract concept/abstract termentry/definition ">
<!ATTLIST termMeta  %global-atts;  class CDATA "- topic/prolog termentry/termMeta ">
<!ATTLIST termBody   %global-atts;  class CDATA "- topic/body concept/conbody termentry/termBody ">

<!-- synonyms, antonyms, related, hyponym (Unterbegriff), hypernym (Oberbegriff), definition, definition source, agreed with, annotation, domain, part of speech, language, usage, context, source of context, annotations, source of term-->

<!-- ================================= End of file ================================== -->
