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
            <xsl:call-template name="testo"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="testo" match="//div[@type='testo']">
        <xsl:for-each select="//tei:div[@type='testo']">
            <h3><xsl:text>File </xsl:text><xsl:value-of select="position()"/></h3>
            <xsl:apply-templates/>
            </xsl:for-each>
    </xsl:template>

    <xsl:template match="//tei:sic"/>
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />

    <xsl:template match="//tei:supplied[@reason='integration']" />
    
    <xsl:template match="//tei:del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:emph">
        <span class="emph"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//tei:shift">
        <span class="tono"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//tei:u">
                <xsl:choose>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#AW']">
                        <p><b><xsl:text>(Arminio W. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#LPF']">
                        <p><b><xsl:text>(Liliana P.F. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#MA']">
                        <p><b><xsl:text>(Maurina A. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="(./@xml:id='MA81' and ./@synch='#TS163') or (./@xml:id='MA158' and ./@synch='#TS320') or (./@xml:id='MA56' and ./@synch='#TS113')">
                        <p><b><xsl:text>Maurina Alazraki: </xsl:text></b><xsl:text>-</xsl:text></p>
                    </xsl:when>
                    <xsl:when test="(./@xml:id='PF3' and ./@synch='#TS193') or (./@xml:id='PF4' and ./@synch='#TS195')">
                        <p><b><xsl:text>Paolo Favaro: </xsl:text></b><xsl:text>-</xsl:text></p>
                    </xsl:when>
                    <xsl:when test="./@xml:id='LPF436' and ./@synch='#TS871'">
                        <p><b><xsl:text>Liliana Picciotto Fargion: </xsl:text></b><xsl:text>-</xsl:text></p>
                    </xsl:when>
                    <xsl:when test="(./@xml:id='AW96' and ./@synch='#TS194') or (./@xml:id='AW227' and ./@synch='#TS456')">
                        <p><b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:text>-</xsl:text></p>
                    </xsl:when>
                    <xsl:when test="./@who='#MA'">
                        <p><b><xsl:text>Maurina Alazraki: </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="./@who='#LPF'">
                        <p><b><xsl:text>Liliana Picciotto Fargion: </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="./@who='#PF'">
                        <p><b><xsl:text>Paolo Favaro: </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="./@who='Maria'">
                        <p><b><xsl:text>Maria: </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:otherwise>
                        <p><b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:otherwise>
                </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:anchor">
        <span class="sovrap">
        <xsl:variable name="odd" select="number(substring-after(@synch,'#TT'))"/>
        <xsl:choose>
        <xsl:when test="($odd mod 2) = 0">
            <xsl:text>&#8250;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>&#8249;</xsl:text>
        </xsl:otherwise>
        </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>

    <xsl:template match="//tei:span[@corresp]">
        <xsl:text>(</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:kinesic/tei:desc">
        <xsl:choose>
            <xsl:when test="../@who"> 
                <span class="gesti"> (<xsl:text>l'altro </xsl:text><xsl:apply-templates />) </span>
            </xsl:when>
            <xsl:when test="../following-sibling::tei:u"> 
                <span class="gesti"> (<xsl:apply-templates />)</span>
               <br />
            </xsl:when>
            <xsl:otherwise>
                <span class="gesti"> (<xsl:apply-templates />) </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:incident/tei:desc">
        <xsl:choose>
            <xsl:when test="../@who"> 
                <span class="rum"> (<xsl:text>l'altro </xsl:text><xsl:apply-templates />) </span>
            </xsl:when>
            <xsl:when test="../following-sibling::tei:u"> 
                <span class="rum"> (<xsl:apply-templates />)</span>
               <br />
            </xsl:when>
            <xsl:otherwise>
                <span class="rum"> (<xsl:apply-templates />) </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

        <!--vocal, del desc presenti solo in sovrapposizione-->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:del">
        <xsl:text>-</xsl:text>
    </xsl:template>


    <xsl:template match="//tei:vocal">
        <xsl:choose>
        <xsl:when test="./tei:desc">
                <span class="vocals"> (<xsl:apply-templates />) </span>
        </xsl:when>
        <xsl:otherwise>
                <span class="vocals"><xsl:apply-templates /> </span>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:pause">
        <xsl:choose>
        <xsl:when test="following-sibling::tei:u"> <img class="imgp" src="pausa.png"/><br /></xsl:when>
        <xsl:otherwise><img class="imgp" src="pausa.png"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//tei:u//tei:gap" >
        <xsl:if test="..[not(@xml:id)]">
            <xsl:text>-</xsl:text>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet> 