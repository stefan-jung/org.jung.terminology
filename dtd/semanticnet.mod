<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//DOCTALES//ELEMENTS DITA DOCTALES SemanticNet//EN"
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
                                      (%conbody;)?,
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



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST semanticnet           %global-atts;   class CDATA "- topic/topic concept/concept semanticnet/semanticnet ">

<!-- ================================= End of file ================================== -->
