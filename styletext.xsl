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

    <xsl:template match="//tei:choice">
		<select>
			<xsl:element name="option">
				<xsl:attribute name="value">
					<xsl:apply-templates select="tei:abbr|tei:sic|tei:orig"/>
				</xsl:attribute>
				<xsl:apply-templates select="tei:abbr|tei:sic|tei:orig"/>
			</xsl:element>
			<xsl:element name="option">
				<xsl:attribute name="value">
					<xsl:apply-templates select="tei:expan|tei:corr|tei:reg"/>
				</xsl:attribute>
				<xsl:apply-templates select="tei:expan|tei:corr|tei:reg"/>
			</xsl:element>
		</select>
	</xsl:template>
      
    <xsl:template match="//tei:abbr">
        <xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="//tei:expan">
        <xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="//tei:sic">
        <xsl:text> &#10060; </xsl:text><xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="//tei:corr">
        <xsl:text> &#128994; </xsl:text><xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="//tei:orig">
        <xsl:text> &#191; </xsl:text><xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="//tei:reg">
        <xsl:text> &#128994; </xsl:text><xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="//tei:surplus">
        <span class="sup"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:supplied[@reason='omitted']">
        <span class="agg"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="//tei:supplied[@reason='integration']"/>
    
    <xsl:template match="//tei:del"/>
    
    <xsl:template match="//*[@xml:lang='de']">
        <span class="bold"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//*[@xml:lang='ji']">
        <span class="yi"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//*[@xml:lang='fr']">
        <span class="fr"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//*[@xml:lang='en']">
        <span class="en"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//*[@xml:lang='rus']">
        <span class="rus"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//*[@xml:lang='lat']">
        <span class="lat"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="//tei:distinct[@type='informal']">
		<span class="informali"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='political']">
		<span class="politiche"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='military']">
		<span class="military"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='altered']">
		<span class="altered"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='common_saying']">
		<span class="mdd"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='technical']">
		<span class="tec"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='figure_of_speech']">
		<span class="fos"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='infrequent']">
		<span class="infre"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='vulgar']">
		<span class="volgari"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='archaic']">
		<span class="arc"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='slang']">
		<span class="slang"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:distinct[@type='dialectal']">
		<span class="dia"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:soCalled">
		<span class="soC"><xsl:apply-templates/></span>
	</xsl:template>

    <xsl:template match="//tei:mentioned">
		<span class="men"><xsl:apply-templates/></span>
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

    <xsl:template match="//tei:vocal"/>
    <xsl:template match="//tei:desc"/>

    <!--vocal, del desc presenti solo in sovrapposizione-->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:vocal">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]/tei:del">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]//tei:desc" >
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:q">
        <xsl:choose>
        <xsl:when test="@xml:lang='de'">
		<span class="bold"><xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text></span>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
        </xsl:otherwise>
        </xsl:choose>
	</xsl:template>

    <xsl:template match="//tei:span[@corresp]">
        <xsl:text>&#10077;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#10078;</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:gap" >
        <b><xsl:choose>
        <xsl:when test="following-sibling::tei:u">  <xsl:text>*lacuna*</xsl:text><br /></xsl:when>
        <xsl:when test="@reason='blanked'">  <xsl:text>*parte oscurata*</xsl:text><br /></xsl:when>
        <xsl:otherwise><xsl:text>*lacuna*</xsl:text></xsl:otherwise>
        </xsl:choose></b>
    </xsl:template>

    <xsl:template match="//tei:unclear" >
        <span class="unc"><xsl:apply-templates /></span>
    </xsl:template>
    
</xsl:stylesheet> 