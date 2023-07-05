<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//STEFAN JUNG//ELEMENTS DITA DOCTALES SemanticNet//EN"
      Delivered as file "semanticnet.mod"  -->
<!-- ================================================================================ -->

<!-- ================================================================================ -->
<!--                       SPECIALIZATION OF DECLARED ELEMENTS                        -->
<!-- ================================================================================ -->

<!ENTITY % semanticnet-info-types  "no-topic-nesting"                                   >



<!-- ================================================================================ -->
<!--                              ELEMENT NAME ENTITIES                               -->
<!-- ================================================================================ -->

<!ENTITY % semanticnet           "semanticnet"                                          >
<!ENTITY % semanticbody          "semanticbody"                                         >



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains         ""                                                  >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Semantic Net                          -->

<!ENTITY % semanticnet.content      "((%title;),
                                      (%shortdesc;),
                                      (%prolog;)?,
                                      (%semanticbody;)?,
                                      (%semanticnet-info-types;)*)
                                    ">
<!ENTITY % semanticnet.attributes   "%id-atts;
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED
                                    ">
<!--doc:The <semanticnet> element is the root element of a semanticnet topic.
Category: SemanticNet elements-->
<!ELEMENT semanticnet                %semanticnet.content;>
<!ATTLIST semanticnet                %semanticnet.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">

<!--                                 LONG NAME: Semantic Body                         -->

<!ENTITY % semanticbody.content     "((%body.cnt;)*,
                                      (%section; |
                                       %example; |
                                       %conbodydiv;)*)
                                    ">
<!ENTITY % semanticbody.attributes  "%id-atts;
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED
                                    ">
<!--doc:The <semanticbody> element is the main body-level element for a semantic net. Like the <body> element of a general <topic>, <semanticbody> allows paragraphs, lists, and other
elements as well as sections and examples. But <semanticnet> has a constraint that a section or an example can be followed only by other sections or examples.
Category: SemanticNet elements-->
<!ELEMENT semanticbody               %semanticbody.content;>
<!ATTLIST semanticbody               %semanticbody.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST semanticnet           %global-atts;   class CDATA "- topic/topic concept/concept semanticnet/semanticnet ">
<!ATTLIST semanticbody          %global-atts;   class CDATA "- topic/body concept/conbody semanticnet/semanticbody ">

<!-- ================================= End of file ================================== -->
