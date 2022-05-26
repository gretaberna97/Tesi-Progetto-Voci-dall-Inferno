<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
 	xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:js="http://saxonica.com/ns/globalJS"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="h ixsl js saxon xs">

    <xsl:output method="text" encoding="UTF-8" indent="yes" />

    <xsl:template match="//tei:teiHeader"/>
    <xsl:template match="//tei:standOff" />

    <xsl:template match="//tei:text">
        <xsl:apply-templates />
    </xsl:template>
        
    <xsl:template match="//tei:sic" />
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del" />
    <!--
    <xsl:template match="//tei:gap" >
        <xsl:choose>
        <xsl:when test="following-sibling::tei:u">  <xsl:text>&#10008;</xsl:text><br /></xsl:when>
        <xsl:otherwise><xsl:text>&#10008;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:unclear" >
        <xsl:text>*</xsl:text><xsl:apply-templates /><xsl:text>*</xsl:text>
    </xsl:template>

    

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
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#9657; </xsl:text></span>
                <span class="desc" style="display:none"><xsl:text>L'altro </xsl:text><xsl:apply-templates /> </span>
            </xsl:when>
            <xsl:when test="../following-sibling::tei:u"> 
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#9657; </xsl:text></span>
                <span class="desc" style="display:none"><xsl:apply-templates /> </span>
               <br />
            </xsl:when>
            <xsl:otherwise>
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#9657; </xsl:text></span>
                <span class="desc" style="display:none"><xsl:apply-templates /> </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:vocal">
        <xsl:choose>
        <xsl:when test="./tei:desc">
                <xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
                <span onclick="more(this)" style="cursor: pointer"><xsl:text> &#9657; </xsl:text></span>
                <span class="desc" style="display:none"><xsl:apply-templates /> </span>
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

	<xsl:template match="//tei:term|//tei:gloss">
		<xsl:choose>
        <xsl:when test="@xml:id">
			<span><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute><xsl:apply-templates/></span>
		</xsl:when>
        <xsl:when test="@ref|@target">
			<a><xsl:attribute name="href"><xsl:value-of select="@ref|@target"/></xsl:attribute><xsl:apply-templates/></a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:span[@corresp]">
        <xsl:text> &#8219;</xsl:text><xsl:apply-templates /><xsl:text> &#8217;</xsl:text>
	</xsl:template>


	<xsl:template match="//tei:distinct">
		<i><xsl:apply-templates/></i>
	</xsl:template>-->
   
    
</xsl:stylesheet> 