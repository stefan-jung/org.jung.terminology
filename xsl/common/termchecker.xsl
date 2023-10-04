<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:math="java.lang.Math"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sj="https://stefan-jung.org"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="sj xs xd math">

    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:variable name="newline" select="'&#xa;'" as="xs:string"/>

    <!-- Language of the messages -->
    <xsl:param name="language" required="yes"/>

    <xd:doc>
        <xd:desc><xd:p>Function to get string from translation file.</xd:p></xd:desc>
        <xd:param name="language"><xd:p>Language to be used.</xd:p></xd:param>
        <xd:param name="string"><xd:p>Name of the string.</xd:p></xd:param>
        <xd:return><xd:p>Returns the string in the specified language.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getTermCheckerString" as="xs:string">
        <xsl:param name="language"/>
        <xsl:param name="string"/>
        <xsl:variable name="file" select="'../../i18n/termchecker-strings-' || $language || '.xml'"/>
        <xsl:sequence select="document($file)/descendant::str[@name = $string]"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>
            <xd:p>Function to extract the language code from a language-region code, e.g. 'en' from 'en-GB'.</xd:p>
            <xd:p>If the input string is no language region code (does not contain a '-'), return the unprocessed string.</xd:p>
        </xd:desc>
        <xd:param name="languageRegionCode"><xd:p>Language region code</xd:p></xd:param>
        <xd:return><xd:p>Language code</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getLanguageCodeFromLanguageRegionCode" as="xs:string">
        <xsl:param name="languageRegionCode"/>
        <xsl:variable name="languageCode">
            <xsl:choose>
                <xsl:when test="contains($languageRegionCode, '-')">
                    <xsl:value-of select="substring-before($languageRegionCode, '-')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$languageRegionCode"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$languageCode"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>
            <xd:p>Generate language match rule. If the language parameter contains both language and region code,
                the match rule would be e.g. "@language = 'en' or @language = 'en-GB'", otherwise "@language = 'en'"</xd:p>
        </xd:desc>
        <xd:param name="languageRegionCode"><xd:p>Language region code</xd:p></xd:param>
        <xd:return><xd:p>Return language match rule.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:getLanguageMatchRule" as="xs:string">
        <xsl:param name="languageRegionCode"/>
        <xsl:variable name="languageCode" select="sj:getLanguageCodeFromLanguageRegionCode($languageRegionCode)"/>
        <xsl:variable name="languageMatchRule">
            <xsl:choose>
                <xsl:when test="contains($languageCode, 'null')">
                    <xsl:text>@language = '</xsl:text>
                    <xsl:value-of select="$languageRegionCode"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>@language = '</xsl:text>
                    <xsl:value-of select="$languageCode"/>
                    <xsl:text>' or @language = '</xsl:text>
                    <xsl:value-of select="$languageRegionCode"/>
                    <xsl:text>'</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$languageMatchRule"/>
    </xsl:function>

    
    <xd:doc>
        <xd:desc> Match the root node of the DITA Map and create a Schematron root node </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
            <sch:title>
                <xsl:value-of select="sj:getTermCheckerString($language, 'Title')"/>
            </sch:title>
            <sch:pattern>
                <sch:rule context="*/text()"> 
                    <xsl:apply-templates/>
                </sch:rule>
            </sch:pattern>
        </sch:schema>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
        <xd:param name="notRecommendedTerm"/>
        <xd:param name="preferredTerm"/>
        <xd:param name="termLanguage"/>
        <xd:param name="definition"/>
    </xd:doc>
    <xsl:template name="createSqfFix">
        <xsl:param name="notRecommendedTerm" as="xs:string"/>
        <xsl:param name="preferredTerm" as="xs:string"/>
        <xsl:param name="termLanguage" as="xs:string"/>
        <xsl:param name="definition" as="xs:string"/>
        
        <xsl:variable name="notRecommendedTermNormalized">
            <xsl:value-of select="sj:normalizeString($notRecommendedTerm)"/>
        </xsl:variable>
        
        <xsl:variable name="sqfTitle">
            <xsl:choose>
                <xsl:when test="self::*[contains(@class, ' termentry/fullForm ')]">
                    <xsl:value-of select="sj:getTermCheckerString($language, 'ReplaceWithAllowedTerm')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$preferredTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/abbreviation ')]">
                    <xsl:value-of
                        select="sj:getTermCheckerString($language, 'ReplaceWithAllowedAbbreviation')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$preferredTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
                <xsl:when test="self::*[contains(@class, ' termentry/acronym ')]">
                    <xsl:value-of select="sj:getTermCheckerString($language, 'ReplaceWithAllowedAcronym')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$preferredTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
              <xsl:when test="self::*[contains(@class, ' termentry/verb ')]">
                    <xsl:value-of select="sj:getTermCheckerString($language, 'ReplaceWithAllowedVerb')"/>
                    <xsl:text>: '</xsl:text>
                    <xsl:value-of select="$preferredTerm"/>
                    <xsl:text>'</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="counter" select="position()"/>
        <xsl:variable name="allowedFullForm" select="normalize-space(.)"/>
        
        <xsl:element name="sqf:fix">
            <xsl:attribute name="id" select="sj:generateId($notRecommendedTermNormalized, 'id', $preferredTerm)"/>
            <xsl:element name="sqf:description">
                <xsl:element name="sqf:title">
                    <xsl:value-of select="normalize-space($sqfTitle)"/>
                </xsl:element>
                <xsl:choose>
                    <xsl:when test="$definition != ''">
                        <xsl:element name="sqf:p">
                            <xsl:value-of select="$definition"/>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:element>
            
            <!-- Lowercased -->
            <xsl:element name="sqf:stringReplace">
                <xsl:attribute name="regex">
                    <xsl:text>(\b(</xsl:text><xsl:value-of select="$notRecommendedTermNormalized"/><xsl:text>)\b)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="select">
                    <xsl:text>'</xsl:text><xsl:value-of select="$preferredTerm"/><xsl:text>'</xsl:text>
                </xsl:attribute>
            </xsl:element>
            
            <!-- Uppercased -->            
            <xsl:if test="not(sj:isUppercased($notRecommendedTerm))">
                <xsl:variable name="uppercasedNotRecommendedTerm" select="concat(upper-case(substring($notRecommendedTermNormalized,1,1)), substring($notRecommendedTermNormalized, 2), ' '[not(last())])"/>
                <xsl:variable name="uppercasedPreferredTerm" select="concat(upper-case(substring($preferredTerm,1,1)), substring($preferredTerm, 2), ' '[not(last())])"/>
                
                <xsl:element name="sqf:stringReplace">
                    <xsl:attribute name="regex">
                        <xsl:text>(\b(</xsl:text><xsl:value-of select="$uppercasedNotRecommendedTerm"/><xsl:text>)\b)</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="select">
                        <xsl:text>'</xsl:text><xsl:value-of select="$uppercasedPreferredTerm"/><xsl:text>'</xsl:text>
                    </xsl:attribute>
                </xsl:element>
            </xsl:if>
            
        </xsl:element>
    </xsl:template>

    
    <xd:doc>
        <xd:desc> Remove HTML clutter </xd:desc>
    </xd:doc>
    <xsl:template name="chapter-setup">
        <xsl:call-template name="chapterBody"/>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template name="chapterBody">
        <xsl:apply-templates select="." mode="chapterBody"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="*" mode="chapterBody"/>
    
    <xd:doc>
        <xd:desc><xd:p>Function to determine, if a string is uppercased</xd:p></xd:desc>
        <xd:param name="string"><xd:p>String to be analyzed</xd:p></xd:param>
        <xd:return><xd:p>Returns true, if the string is uppercased.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:isUppercased" as="xs:boolean">
        <xsl:param name="string"/>
        <xsl:sequence select="contains('ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝĀĂĄĆĈĊČĎĐĒĔĖĘĚĜĞĠĢĤĦĨĪĬĮİĲĴĶĹĻĽĿŁŃŅŇŊŌŎŐŒŔŖŘŚŜŞŠŢŤŦŨŪŬŮŰŲŴŶŸŹŻŽƁƂƄƆƇƉƊƋƎƏƐƑƓƔƖƗƘƜƝƟƠƢƤƦƧƩƬƮƯƱƲƳƵƷƸƼǄǇǊǍǏǑǓǕǗǙǛǞǠǢǤǦǨǪǬǮǱǴǶǷǸǺǼǾȀȂȄȆȈȊȌȎȐȒȔȖȘȚȜȞȠȢȤȦȨȪȬȮȰȲȺȻȽȾɁɃɄɅɆɈɊɌɎͰͲͶͿΆΈΉΊΌΎΏΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΪΫϏϒϓϔϘϚϜϞϠϢϤϦϨϪϬϮϴϷϹϺϽϾϿЀЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯѠѢѤѦѨѪѬѮѰѲѴѶѸѺѼѾҀҊҌҎҐҒҔҖҘҚҜҞҠҢҤҦҨҪҬҮҰҲҴҶҸҺҼҾӀӁӃӅӇӉӋӍӐӒӔӖӘӚӜӞӠӢӤӦӨӪӬӮӰӲӴӶӸӺӼӾԀԂԄԆԈԊԌԎԐԒԔԖԘԚԜԞԠԢԤԦԨԪԬԮԱԲԳԴԵԶԷԸԹԺԻԼԽԾԿՀՁՂՃՄՅՆՇՈՉՊՋՌՍՎՏՐՑՒՓՔՕՖႠႡႢႣႤႥႦႧႨႩႪႫႬႭႮႯႰႱႲႳႴႵႶႷႸႹႺႻႼႽႾႿჀჁჂჃჄჅჇჍᎠᎡᎢᎣᎤᎥᎦᎧᎨᎩᎪᎫᎬᎭᎮᎯᎰᎱᎲᎳᎴᎵᎶᎷᎸᎹᎺᎻᎼᎽᎾᎿᏀᏁᏂᏃᏄᏅᏆᏇᏈᏉᏊᏋᏌᏍᏎᏏᏐᏑᏒᏓᏔᏕᏖᏗᏘᏙᏚᏛᏜᏝᏞᏟᏠᏡᏢᏣᏤᏥᏦᏧᏨᏩᏪᏫᏬᏭᏮᏯᏰᏱᏲᏳᏴᏵḀḂḄḆḈḊḌḎḐḒḔḖḘḚḜḞḠḢḤḦḨḪḬḮḰḲḴḶḸḺḼḾṀṂṄṆṈṊṌṎṐṒṔṖṘṚṜṞṠṢṤṦṨṪṬṮṰṲṴṶṸṺṼṾẀẂẄẆẈẊẌẎẐẒẔẞẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼẾỀỂỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪỬỮỰỲỴỶỸỺỼỾἈἉἊἋἌἍἎἏἘἙἚἛἜἝἨἩἪἫἬἭἮἯἸἹἺἻἼἽἾἿὈὉὊὋὌὍὙὛὝὟὨὩὪὫὬὭὮὯᾸᾹᾺΆῈΈῊΉῘῙῚΊῨῩῪΎῬῸΌῺΏℂℇℋℌℍℐℑℒℕℙℚℛℜℝℤΩℨKÅℬℭℰℱℲℳℾℿⅅↃⰀⰁⰂⰃⰄⰅⰆⰇⰈⰉⰊⰋⰌⰍⰎⰏⰐⰑⰒⰓⰔⰕⰖⰗⰘⰙⰚⰛⰜⰝⰞⰟⰠⰡⰢⰣⰤⰥⰦⰧⰨⰩⰪⰫⰬⰭⰮⱠⱢⱣⱤⱧⱩⱫⱭⱮⱯⱰⱲⱵⱾⱿⲀⲂⲄⲆⲈⲊⲌⲎⲐⲒⲔⲖⲘⲚⲜⲞⲠⲢⲤⲦⲨⲪⲬⲮⲰⲲⲴⲶⲸⲺⲼⲾⳀⳂⳄⳆⳈⳊⳌⳎⳐⳒⳔⳖⳘⳚⳜⳞⳠⳢⳫⳭⳲꙀꙂꙄꙆꙈꙊꙌꙎꙐꙒꙔꙖꙘꙚꙜꙞꙠꙢꙤꙦꙨꙪꙬꚀꚂꚄꚆꚈꚊꚌꚎꚐꚒꚔꚖꚘꚚꜢꜤꜦꜨꜪꜬꜮꜲꜴꜶꜸꜺꜼꜾꝀꝂꝄꝆꝈꝊꝌꝎꝐꝒꝔꝖꝘꝚꝜꝞꝠꝢꝤꝦꝨꝪꝬꝮꝹꝻꝽꝾꞀꞂꞄꞆꞋꞍꞐꞒꞖꞘꞚꞜꞞꞠꞢꞤꞦꞨꞪꞫꞬꞭꞮꞰꞱꞲꞳꞴꞶＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ𐐀𐐁𐐂𐐃𐐄𐐅𐐆𐐇𐐈𐐉𐐊𐐋𐐌𐐍𐐎𐐏𐐐𐐑𐐒𐐓𐐔𐐕𐐖𐐗𐐘𐐙𐐚𐐛𐐜𐐝𐐞𐐟𐐠𐐡𐐢𐐣𐐤𐐥𐐦𐐧𐒰𐒱𐒲𐒳𐒴𐒵𐒶𐒷𐒸𐒹𐒺𐒻𐒼𐒽𐒾𐒿𐓀𐓁𐓂𐓃𐓄𐓅𐓆𐓇𐓈𐓉𐓊𐓋𐓌𐓍𐓎𐓏𐓐𐓑𐓒𐓓𐲀𐲁𐲂𐲃𐲄𐲅𐲆𐲇𐲈𐲉𐲊𐲋𐲌𐲍𐲎𐲏𐲐𐲑𐲒𐲓𐲔𐲕𐲖𐲗𐲘𐲙𐲚𐲛𐲜𐲝𐲞𐲟𐲠𐲡𐲢𐲣𐲤𐲥𐲦𐲧𐲨𐲩𐲪𐲫𐲬𐲭𐲮𐲯𐲰𐲱𐲲𑢠𑢡𑢢𑢣𑢤𑢥𑢦𑢧𑢨𑢩𑢪𑢫𑢬𑢭𑢮𑢯𑢰𑢱𑢲𑢳𑢴𑢵𑢶𑢷𑢸𑢹𑢺𑢻𑢼𑢽𑢾𑢿𝐀𝐁𝐂𝐃𝐄𝐅𝐆𝐇𝐈𝐉𝐊𝐋𝐌𝐍𝐎𝐏𝐐𝐑𝐒𝐓𝐔𝐕𝐖𝐗𝐘𝐙𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍𝑨𝑩𝑪𝑫𝑬𝑭𝑮𝑯𝑰𝑱𝑲𝑳𝑴𝑵𝑶𝑷𝑸𝑹𝑺𝑻𝑼𝑽𝑾𝑿𝒀𝒁𝒜𝒞𝒟𝒢𝒥𝒦𝒩𝒪𝒫𝒬𝒮𝒯𝒰𝒱𝒲𝒳𝒴𝒵𝓐𝓑𝓒𝓓𝓔𝓕𝓖𝓗𝓘𝓙𝓚𝓛𝓜𝓝𝓞𝓟𝓠𝓡𝓢𝓣𝓤𝓥𝓦𝓧𝓨𝓩𝔄𝔅𝔇𝔈𝔉𝔊𝔍𝔎𝔏𝔐𝔑𝔒𝔓𝔔𝔖𝔗𝔘𝔙𝔚𝔛𝔜𝔸𝔹𝔻𝔼𝔽𝔾𝕀𝕁𝕂𝕃𝕄𝕆𝕊𝕋𝕌𝕍𝕎𝕏𝕐𝕬𝕭𝕮𝕯𝕰𝕱𝕲𝕳𝕴𝕵𝕶𝕷𝕸𝕹𝕺𝕻𝕼𝕽𝕾𝕿𝖀𝖁𝖂𝖃𝖄𝖅𝖠𝖡𝖢𝖣𝖤𝖥𝖦𝖧𝖨𝖩𝖪𝖫𝖬𝖭𝖮𝖯𝖰𝖱𝖲𝖳𝖴𝖵𝖶𝖷𝖸𝖹𝗔𝗕𝗖𝗗𝗘𝗙𝗚𝗛𝗜𝗝𝗞𝗟𝗠𝗡𝗢𝗣𝗤𝗥𝗦𝗧𝗨𝗩𝗪𝗫𝗬𝗭𝘈𝘉𝘊𝘋𝘌𝘍𝘎𝘏𝘐𝘑𝘒𝘓𝘔𝘕𝘖𝘗𝘘𝘙𝘚𝘛𝘜𝘝𝘞𝘟𝘠𝘡𝘼𝘽𝘾𝘿𝙀𝙁𝙂𝙃𝙄𝙅𝙆𝙇𝙈𝙉𝙊𝙋𝙌𝙍𝙎𝙏𝙐𝙑𝙒𝙓𝙔𝙕𝙰𝙱𝙲𝙳𝙴𝙵𝙶𝙷𝙸𝙹𝙺𝙻𝙼𝙽𝙾𝙿𝚀𝚁𝚂𝚃𝚄𝚅𝚆𝚇𝚈𝚉𝚨𝚩𝚪𝚫𝚬𝚭𝚮𝚯𝚰𝚱𝚲𝚳𝚴𝚵𝚶𝚷𝚸𝚹𝚺𝚻𝚼𝚽𝚾𝚿𝛀𝛢𝛣𝛤𝛥𝛦𝛧𝛨𝛩𝛪𝛫𝛬𝛭𝛮𝛯𝛰𝛱𝛲𝛳𝛴𝛵𝛶𝛷𝛸𝛹𝛺𝜜𝜝𝜞𝜟𝜠𝜡𝜢𝜣𝜤𝜥𝜦𝜧𝜨𝜩𝜪𝜫𝜬𝜭𝜮𝜯𝜰𝜱𝜲𝜳𝜴𝝖𝝗𝝘𝝙𝝚𝝛𝝜𝝝𝝞𝝟𝝠𝝡𝝢𝝣𝝤𝝥𝝦𝝧𝝨𝝩𝝪𝝫𝝬𝝭𝝮𝞐𝞑𝞒𝞓𝞔𝞕𝞖𝞗𝞘𝞙𝞚𝞛𝞜𝞝𝞞𝞟𝞠𝞡𝞢𝞣𝞤𝞥𝞦𝞧𝞨𝟊𞤀𞤁𞤂𞤃𞤄𞤅𞤆𞤇𞤈𞤉𞤊𞤋𞤌𞤍𞤎𞤏𞤐𞤑𞤒𞤓𞤔𞤕𞤖𞤗𞤘𞤙𞤚𞤛𞤜𞤝𞤞𞤟𞤠𞤡', substring($string, 1, 1))"/>
    </xsl:function>

    <xd:doc>
        <xd:desc><xd:p>Escape conflicting characters and return a normalized term</xd:p></xd:desc>
        <xd:param name="string"><xd:p>String to be normalized</xd:p></xd:param>
        <xd:return><xd:p>Return the normalized string.</xd:p></xd:return>
    </xd:doc>
    <xsl:function name="sj:normalizeString" as="xs:string">
        <xsl:param name="string"/>
        <xsl:sequence select="replace($string, '/', '\\/')"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>
            <xd:p>Generate a ID based on two strings.</xd:p>
            <xd:p>The XSLT generate-id() does not generate a unique ID, when called on the same node.</xd:p>
        </xd:desc>
        <xd:return><xd:p>Return a unique ID.</xd:p></xd:return>
        <xd:param name="notRecommendedTerm">First string</xd:param>
        <xd:param name="id">ID of term entry</xd:param>
        <xd:param name="languageCode">Language Code</xd:param>
    </xd:doc>
    <xsl:function name="sj:generateId">
        <xsl:param name="notRecommendedTerm" as="xs:string"/>
        <xsl:param name="id" as="xs:string"/>
        <xsl:param name="languageCode" as="xs:string"/>
        <!-- The ID has to be a unique valid NMTOKEN -->
        <xsl:variable name="newID" select="replace(concat(concat($notRecommendedTerm, $id), $languageCode), '[^A-Za-z0-9,.-]','')"/>
        <xsl:sequence select="$newID"/>
    </xsl:function>

</xsl:stylesheet>