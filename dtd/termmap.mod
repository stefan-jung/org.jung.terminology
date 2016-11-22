<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//DOCTALES//ELEMENTS DITA DOCTALES Termmap//EN"
      Delivered as file "termmap.mod"  -->
<!-- ================================================================================ -->

<!-- ================================================================================ -->
<!--                       SPECIALIZATION OF DECLARED ELEMENTS                        -->
<!-- ================================================================================ -->

<!ENTITY % termmap-info-types  "no-topic-nesting"                                     >



<!-- ================================================================================ -->
<!--                              ELEMENT NAME ENTITIES                               -->
<!-- ================================================================================ -->

<!ENTITY % termmap               "termmap"                                              >
<!ENTITY % termref               "termref"                                              >



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains         ""                                                  >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Term Map                              -->

<!--doc:The <termmap> element is the root element of a terminology map. A term map connects the termentry elements and forms a terminology database.
Category: Termmap elements-->
<!ENTITY % termmap.content
                                    "((%title;)?,
                                      (%topicmeta;)?,
                                      (%anchor; |
                                       %data.elements.incl; |
                                       %navref; |
                                       %reltable; |
                                       %topicref; |
                                       %termref;)*)
                                    ">
<!ELEMENT termmap                    %termmap.content;>
<!ATTLIST termmap                    %map.attributes;
                                     %arch-atts;
                                     domains
                                        CDATA
                                           "&included-domains;">


<!--                                 LONG NAME: Term Reference                        -->

<!--doc:The <termref> element is a reference to a term topic.
Category: Termmap elements-->
<!ELEMENT  termref %topicref.content;>
<!ATTLIST  termref %topicref.attributes;>



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->
<!ATTLIST termmap          %global-atts;   class CDATA "- map/map termmap/termmap ">
<!ATTLIST termref          %global-atts;   class CDATA "- map/topicref termmap/termref ">

<!-- ================================= End of file ================================== -->
