<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//DOCTALES//ELEMENTS DITA DOCTALES Term//EN"
      Delivered as file "term.mod"  -->
<!-- ================================================================================ -->

<!-- ================================================================================ -->
<!--                       SPECIALIZATION OF DECLARED ELEMENTS                        -->
<!-- ================================================================================ -->

<!ENTITY % term-info-types
                        "%info-types;">

<!-- ================================================================================ -->
<!--                              ELEMENT NAME ENTITIES                               -->
<!-- ================================================================================ -->

<!ENTITY % term         "term">

<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains
                        "">

<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: term                                  -->

<!ENTITY % term.content "((%title;),
                          (%titlealts;)?,
                          (%shortdesc;)?,
                          (%prolog;)?,
                          (%body;)?,
                          (%related-links;)?)">
<!ENTITY % term.attributes
                        "id ID #REQUIRED
                         %conref-atts;
                         %select-atts;
                         %localization-atts;
                         outputclass CDATA #IMPLIED
                        ">
<!ELEMENT term %term.content;>
<!ATTLIST term 
    %term.attributes;
    %arch-atts;
    domains CDATA "&included-domains;">


<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST term %global-atts; class CDATA "- topic/topic concept/concept term/term ">
<!ATTLIST definition    %global-atts;  class CDATA "- topic/abstract concept/abstract term/definition ">
<!ATTLIST termBody   %global-atts;  class CDATA "- topic/body concept/conbody term/glossBody ">

<!-- synonyms, antonyms, related, hyponym (Unterbegriff), hypernym (Oberbegriff), definition, definition source, agreed with, annotation, domain, part of speech, language, usage, context, source of context, annotations, source of term-->

<!-- ================================= End of file ================================== -->
