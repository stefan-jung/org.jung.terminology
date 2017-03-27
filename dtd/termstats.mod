<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//DOCTALES//ELEMENTS DITA DOCTALES TermStats//EN"
      Delivered as file "termstats.mod"  -->
<!-- ================================================================================ -->

<!-- ================================================================================ -->
<!--                       SPECIALIZATION OF DECLARED ELEMENTS                        -->
<!-- ================================================================================ -->

<!ENTITY % termstats-info-types  "no-topic-nesting"                                   >



<!-- ================================================================================ -->
<!--                              ELEMENT NAME ENTITIES                               -->
<!-- ================================================================================ -->

<!ENTITY % termstats              "termstats"                                           >
<!ENTITY % termstatsbody          "termstatsbody"                                       >



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains         ""                                                  >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Terminology Statistics                -->

<!ENTITY % termstats.content        "((%title;),
                                      (%shortdesc;),
                                      (%prolog;)?,
                                      (%termstatsbody;)?,
                                      (%termstats-info-types;)*)
                                    ">
<!ENTITY % termstats.attributes     "%id-atts;
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED
                                    ">
<!--doc:The <termstats> element is the root element of a termstats topic.
Category: TermStats elements-->
<!ELEMENT termstats                  %termstats.content;>
<!ATTLIST termstats                  %termstats.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">

<!--                                 LONG NAME: Terminology Statistics Body           -->

<!ENTITY % termstatsbody.content     "((%body.cnt;)*,
                                      (%section; |
                                       %example; |
                                       %conbodydiv;)*)
                                     ">
<!ENTITY % termstatsbody.attributes  "%id-atts;
                                      %localization-atts;
                                      base   CDATA   #IMPLIED
                                      %base-attribute-extensions;
                                      outputclass   CDATA   #IMPLIED
                                     ">
<!--doc:The <termstatsbody> element is the main body-level element for term statistics. Like the <body> element of a general <topic>, <termstatsbody> allows paragraphs, lists, and other
elements as well as sections and examples. But <termstats> has a constraint that a section or an example can be followed only by other sections or examples.
Category: TermStats elements-->
<!ELEMENT termstatsbody               %termstatsbody.content;>
<!ATTLIST termstatsbody               %termstatsbody.attributes;
                                      %arch-atts;
                                      domains CDATA "&included-domains;">



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST termstats              %global-atts;   class CDATA "- topic/topic concept/concept termstats/termstats ">
<!ATTLIST termstatsbody          %global-atts;   class CDATA "- topic/body concept/conbody termstats/termstatsbody ">

<!-- ================================= End of file ================================== -->
