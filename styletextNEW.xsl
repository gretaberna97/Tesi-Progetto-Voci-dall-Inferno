<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="text" encoding="UTF-8" indent="yes" />

    <xsl:template match="tei:teiHeader" />

    <xsl:template match="//tei:text">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="//tei:div[@type='testo']">
        <xsl:choose>
        <xsl:when test="count(.) != 1">
        <b><xsl:text>NUOVA REGISTRAZIONE</xsl:text></b><br /><xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates />
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:sic" />
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />

    <xsl:template match="//tei:gap" >
        <xsl:choose>
        <xsl:when test="following-sibling::tei:u">  <xsl:text>&#10008;</xsl:text><br /></xsl:when>
        <xsl:otherwise><xsl:text>&#10008;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:unclear" >
        <xsl:text>*</xsl:text><xsl:apply-templates /><xsl:text>*</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:del" />

    <xsl:template match="//tei:u">
                <xsl:choose>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who]">
                        <xsl:text>(SOVRAPPOSIZIONE): -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="./@who='#MA' or ./@who='#LPF' or ./@who='#INTERVISTATORE' or./@who='#AS'">
                        <xsl:text>INTERVISTATORE: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="./@who='#PF'">
                        <xsl:text>CAMERAMAN: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="./@who='Maria'">
                        <xsl:text>ESTERNO: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>TESTIMONE: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:otherwise>
                </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:desc">
        <xsl:choose>
            <xsl:when test="../@who"> 
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#10095; </xsl:text></span>
                <span class="right" style="display:none"><xsl:text>L'altro </xsl:text><xsl:apply-templates /> </span>
            </xsl:when>
            <xsl:when test="../following-sibling::tei:u"> 
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#10095; </xsl:text></span>
                <span class="right" style="display:none"><xsl:apply-templates /> </span>
               <br />
            </xsl:when>
            <xsl:otherwise>
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#10095; </xsl:text></span>
                <span class="right" style="display:none"><xsl:apply-templates /> </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:pause">
        <xsl:choose>
        <xsl:when test="following-sibling::tei:u">  <i><xsl:text>... Pausa ...</xsl:text></i><xsl:apply-templates /><br /></xsl:when>
        <xsl:otherwise><xsl:text> ...</xsl:text><xsl:apply-templates /></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

   <xsl:template match="//tei:shift|//tei:emph">
        <span class="emph"><xsl:apply-templates /></span>
    </xsl:template>

	<xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>

	<xsl:template match="//tei:term">
		<xsl:choose>
        <xsl:when test="@xml:id">
			<span><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="//tei:gloss">
		<xsl:choose>
		<xsl:when test="@target">
			<a>
				<xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
				<xsl:apply-templates/>
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="//tei:distinct">
		<i><xsl:apply-templates/></i>
	</xsl:template>

<!-- CODICE GIULIA PER LA TRASCRIZIONE
    <xsl:template match="text()[following::node()[self::text()[normalize-space() != ''] or self::tei:lb][1][self::tei:lb[@break='no']]
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
   -->
</xsl:stylesheet>