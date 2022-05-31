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
                        <b><xsl:text>(Arminio W. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#LPF']">
                        <b><xsl:text>(Liliana P.F. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#MA']">
                        <b><xsl:text>(Maurina A. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
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
                        <b><xsl:text>Maria: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:otherwise>
                        <b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:otherwise>
                </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>

    <xsl:template match="//tei:desc"/>
    <xsl:template match="//tei:vocal"/>

    <!--vocal e desc presenti solo in sovrapposizione-->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:vocal" >
            <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]//tei:desc" ><!--span classe-->
        <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
    </xsl:template>
    
    <xsl:template match="//tei:gap" >
        <xsl:if test="..[not(@xml:id)] and normalize-space(..)=''">
            <xsl:text>*lacuna*</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:orgName" >
        <span class="org"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:persName" >
        <span class="pers"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:rs" >
        <span class="rif"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:placeName" >
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:place" >
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:measure" >
        <span class="mes"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:date" >
        <span class="date"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:time" >
        <span class="time"><xsl:apply-templates/></span>
    </xsl:template>
<!--
    <xsl:template match="//tei:unclear" >
        <xsl:text>*</xsl:text><xsl:apply-templates /><xsl:text>*</xsl:text>
    </xsl:template>

	<xsl:template match="tei:span[@corresp]">
        <xsl:text> &#8219;</xsl:text><xsl:apply-templates /><xsl:text> &#8217;</xsl:text>
	</xsl:template>
-->  
    
</xsl:stylesheet> 