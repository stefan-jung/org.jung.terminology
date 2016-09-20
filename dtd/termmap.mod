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
<!ELEMENT termmap                    %map.content;>
<!ATTLIST termmap                    %map.attributes;
                                     %arch-atts;
                                     domains
                                        CDATA
                                           "&included-domains;">


<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->
<!ATTLIST termmap               %global-atts;   class CDATA "- map/map termmap/termmap ">

<!-- ================================= End of file ================================== -->
