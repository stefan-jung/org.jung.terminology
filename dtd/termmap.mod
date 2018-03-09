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
<!ENTITY % termgroup             "termgroup"                                            >



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
                                    "((%topicmeta;)?,
                                      (%anchor; |
                                       %data.elements.incl; |
                                       %navref; |
                                       %reltable; |
                                       %topicref; |
                                       %termgroup;+)*)
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
<!ELEMENT termref                    %topicref.content;>
<!ATTLIST termref                    %topicref.attributes;>


<!--                                 LONG NAME: Term Group                            -->

<!ENTITY % termgroup.content
                                    "((%termref;)+)
                                    ">
<!ENTITY % termgroup.attributes
                                    "outputclass
                                       CDATA
                                          #IMPLIED
                                     %topicref-atts;
                                     %univ-atts;">
<!--doc:The <termgroup> element is a wrapper for <termref> elements.
Category: Termmap elements-->
<!ELEMENT termgroup                  %termgroup.content;>
<!ATTLIST termgroup                  %termgroup.attributes;>

<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->
<!ATTLIST termmap   %global-atts; class CDATA "- map/map termmap/termmap ">
<!ATTLIST termref   %global-atts; class CDATA "- map/topicref termmap/termref ">
<!ATTLIST termgroup %global-atts; class CDATA "- map/topicref mapgroup-d/topicgroup termmap/termgroup ">

<!-- ================================= End of file ================================== -->
