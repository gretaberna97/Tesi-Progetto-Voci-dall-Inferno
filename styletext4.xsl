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

    <xsl:template match="//tei:sic" />
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del"/>

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
                    <xsl:when test="(./@xml:id='MA81' and ./@synch='#TS163') or (./@xml:id='MA158' and ./@synch='#TS320') or (./@xml:id='MA56' and ./@synch='#TS113') or (./@xml:id='MA77' and ./@synch='#TS155') or (./@xml:id='MA159' and ./@synch='#TS322')">
                        <p><b><xsl:text>Maurina Alazraki: </xsl:text></b><xsl:text>-</xsl:text></p>
                    </xsl:when>
                    <xsl:when test="(./@xml:id='PF3' and ./@synch='#TS193') or (./@xml:id='PF4' and ./@synch='#TS195')">
                        <p><b><xsl:text>Paolo Favaro: </xsl:text></b><xsl:text>-</xsl:text></p>
                    </xsl:when>
                    <xsl:when test="(./@xml:id='LPF436' and ./@synch='#TS871') or (./@xml:id='LPF387' and ./@synch='#TS773')">
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

    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>

    <xsl:template match="//tei:span[@corresp]">
        <xsl:text>&#10077;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#10078;</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:desc"/>
    <xsl:template match="//tei:vocal"/>

    <xsl:template match="//tei:u[not(@xml:id)]/tei:vocal">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]//tei:desc" >
        <xsl:text>-</xsl:text>
    </xsl:template>
    
    <xsl:template match="//tei:gap" >
        <xsl:if test="..[not(@xml:id)] and normalize-space(..)=''">
            <xsl:text>-</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:orgName" >
        <span class="org"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:persName" >
        <span class="pers">
        <a class="people1"><xsl:attribute name="href"><xsl:value-of select="substring-after(@ref,'xml')"/></xsl:attribute><xsl:apply-templates/></a></span>
    </xsl:template>

    <xsl:template match="//tei:rs[contains(@ref,'Person')]" >
        <span class="rif"><a class="people1"><xsl:attribute name="href"><xsl:value-of select="substring-after(@ref,'xml')"/></xsl:attribute><xsl:apply-templates/></a></span>
    </xsl:template>

    <xsl:template match="//tei:rs[contains(@ref,'Place')]" >
        <span class="rif"><a class="place1"><xsl:attribute name="href"><xsl:value-of select="substring-after(@ref,'xml')"/></xsl:attribute><xsl:apply-templates/></a></span>
    </xsl:template>

    <xsl:template match="//tei:placeName" >
        <span class="place"><a  class="place1"><xsl:attribute name="href"><xsl:value-of select="substring-after(@ref,'xml')"/></xsl:attribute><xsl:apply-templates/></a></span>
    </xsl:template>

    <xsl:template match="//tei:place" >
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:measure" >
        <span class="mes"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:date">
        <span class="date"><xsl:apply-templates/>
        <xsl:choose>
        <xsl:when test="@notBefore and not(@notAfter)">
            <xsl:text> [dal </xsl:text><xsl:apply-templates select="@notBefore"/><xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:when test="@notAfter and not(@notBefore)">
            <xsl:text> [prima del </xsl:text><xsl:apply-templates select="@notAfter"/><xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:when test="@notBefore and @notAfter">
            <xsl:text> [</xsl:text><xsl:apply-templates select="@notBefore"/><xsl:text> - </xsl:text><xsl:apply-templates select="@notAfter"/><xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:when test="@from and @to">
            <xsl:text> [dal </xsl:text><xsl:apply-templates select="@from"/><xsl:text> al </xsl:text><xsl:apply-templates select="@to"/><xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:when test="not(@dur)">
            <xsl:text> [</xsl:text><xsl:apply-templates select="@when"/><xsl:apply-templates select="@from"/><xsl:apply-templates select="@to"/><xsl:text>]</xsl:text>
        </xsl:when>
        </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="//tei:time" >
        <span class="time"><xsl:apply-templates/>
        <xsl:choose>
        <xsl:when test="@notBefore and not(@notAfter)">
            <xsl:text> [dalle ore </xsl:text><xsl:apply-templates select="@notBefore"/><xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:when test="not(@dur)">
        <xsl:text> [ore </xsl:text><xsl:apply-templates select="@when"/><xsl:text>]</xsl:text>
        </xsl:when>
        </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="//tei:supplied[@reason='integration']">
        <xsl:text> </xsl:text><span class="agg2"><xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text></span>
    </xsl:template>
    
</xsl:stylesheet> 