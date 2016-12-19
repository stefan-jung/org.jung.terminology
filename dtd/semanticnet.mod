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
<!ENTITY % semanticBody          "semanticBody"                                         >
<!ENTITY % net                   "net"                                                  >



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains         ""                                                  >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Semantic Net                          -->

<!ENTITY % semanticnet.content      "((%title;),
                                      (%semanticBody;)?,
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
<!ENTITY % semanticBody.content     "(%net;)">
<!ENTITY % semanticBody.attributes  "%id-atts;
                                     %localization-atts;
                                     base
                                        CDATA
                                           #IMPLIED
                                     %base-attribute-extensions;
                                        outputclass
                                           CDATA
                                              #IMPLIED">
<!--doc:The <semanticBody> element contains the body of a semantic net.
Category: SemanticNet elements-->
<!ELEMENT semanticBody    %semanticBody.content;>
<!ATTLIST semanticBody    %semanticBody.attributes;>

<!--                                 LONG NAME: Net                                   -->
<!ENTITY % net.content              "EMPTY">
<!ENTITY % net.attributes           "%univ-atts;
                                     value
                                        CDATA
                                           'semanticnet'
                                     outputclass
                                        CDATA
                                           #IMPLIED">
<!--doc:The <net> element represents the position, where the semantic net is going to be rendered.
Category: SemanticNet elements-->
<!ELEMENT net   %net.content;>
<!ATTLIST net   %net.attributes;>



<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST net                   %global-atts;   class CDATA "- topic/data concept/data semanticnet/net ">
<!ATTLIST semanticBody          %global-atts;   class CDATA "- topic/body concept/conbody semanticnet/semanticBody ">
<!ATTLIST semanticnet           %global-atts;   class CDATA "- topic/topic concept/concept semanticnet/semanticnet ">

<!-- ================================= End of file ================================== -->
