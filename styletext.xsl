<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
 	xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:js="http://saxonica.com/ns/globalJS"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="h ixsl js saxon xs">

    <xsl:output method="text" encoding="UTF-8" indent="yes" />

    <xsl:template name="main" match="/">
        <xsl:result-document href="#trascrizione" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:text"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:text">
        <xsl:apply-templates />
    </xsl:template>

      
    <xsl:template match="//tei:sic"/>
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del" />

    <xsl:template match="//tei:shift|//tei:emph" name="enf">
        <span class="emph"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//tei:distinct"><!--devo invididuare i tipi-->
		<span class="distinte"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:term|//tei:gloss">non si vede il termine
		<xsl:choose>
        <xsl:when test="@xml:id">
			<span class="bold"><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute><xsl:apply-templates/></span>
		</xsl:when>
        <xsl:when test="@ref|@target">
			<a class="bold" style="color:orange"><xsl:attribute name="href"><xsl:value-of select="@ref|@target"/></xsl:attribute><xsl:apply-templates/></a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <xsl:template match="//tei:div[@type='testo']">
        <h3><xsl:text>Inizio registrazione</xsl:text></h3><br /><xsl:apply-templates />
    </xsl:template>

    <xsl:template match="//tei:u">
                <xsl:choose>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who]">
                        <b><xsl:text>(SOVRAPPOSIZIONE): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#MA'">
                        <b><xsl:text>Maurina Alazraki: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#LPF'">
                        <b><xsl:text>Liliana Picciotto Fargion: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#PF'">
                        <b><xsl:text>Paolo Favaro: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='Maria'">
                        <b><xsl:text>Maria: </xsl:text></b><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:otherwise>
                        <b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:otherwise>
                </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:desc"/><!--sistemare:sovrapposizioni vuote-->
    <xsl:template match="//tei:vocal"/>

    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>
        
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