<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="text" encoding="UTF-8" indent="yes" />

    <xsl:template match="tei:teiHeader" />

    <xsl:template match="//tei:text">
        <xsl:apply-templates />
    </xsl:template>
        
    <xsl:template match="tei:sic" />
        
    <xsl:template match="tei:orig" />
    
    <xsl:template match="tei:abbr" /> 

    <xsl:template match="tei:del" />

    <xsl:template
    match="text()[
    following::node()[
    self::text()[normalize-space() != ''] or
    self::tei:lb]
    [1]
    [self::tei:lb[@break='no']]
    ]">
    <xsl:variable name="normalized" select="normalize-space()"/>
    <xsl:if test="$normalized != ''">
        <xsl:variable name="lastNonSpace"
            select="substring($normalized, string-length($normalized))"/>
        <xsl:variable name="trimmedSuffix">
            <xsl:call-template name="substring-after-last">
                <xsl:with-param name="string" select="."/>
                <xsl:with-param name="delimiter" select="$lastNonSpace"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of
            select="substring(., 1, string-length(.) -
            string-length($trimmedSuffix))"
        />
    </xsl:if>
    </xsl:template>

    <xsl:template name="substring-after-last">
    <xsl:param name="string"/>
    <xsl:param name="delimiter"/>
    <xsl:choose>
        <xsl:when test="contains($string, $delimiter)">
            <xsl:call-template name="substring-after-last">
                <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
                <xsl:with-param name="delimiter" select="$delimiter"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
   </xsl:template>
   
    
</xsl:stylesheet> 