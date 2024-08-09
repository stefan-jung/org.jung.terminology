<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:sj="https://stefan-jung.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!--
        This functions hashes a string as a 32bit integer, which is required 
        for MultiTerm.
    -->
    
    <!-- Recursive function to calculate the hash -->
    <xsl:function name="sj:hash-string" as="xs:integer">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="sj:hash-string-rec($input, 0, 1)" />
    </xsl:function>
    
    <!-- Helper function for recursion -->
    <xsl:function name="sj:hash-string-rec" as="xs:integer" visibility="private">
        <xsl:param name="input" as="xs:string"/>
        <xsl:param name="hash" as="xs:integer"/>
        <xsl:param name="index" as="xs:integer"/>
        
        <xsl:variable name="length" select="string-length($input)" />
        <xsl:variable name="prime" select="31" />
        <xsl:variable name="modulus" select="2147483647" />
        
        <xsl:choose>
            <xsl:when test="$index &gt; $length">
                <xsl:sequence select="$hash"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="char" select="substring($input, $index, 1)" />
                <xsl:variable name="charCode" select="string-to-codepoints($char)" />
                <xsl:variable name="new-hash" select="(($hash * $prime) + $charCode) mod $modulus" />
                <xsl:sequence select="sj:hash-string-rec($input, $new-hash, $index + 1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    
</xsl:stylesheet>
