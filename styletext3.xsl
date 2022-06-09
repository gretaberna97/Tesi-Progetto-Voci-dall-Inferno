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
                <h3><xsl:text>File 1</xsl:text></h3>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3I' or @xml:id='TL2I']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/>
                </xsl:apply-templates>
                <h3><xsl:text>File 2</xsl:text></h3>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3II' or @xml:id='TL2II']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/>
                </xsl:apply-templates>
                <xsl:if test="//tei:timeline[@xml:id='TL3III']">
                <h3><xsl:text>File 3</xsl:text></h3>
                </xsl:if>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3III' or @xml:id='TL2III']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/>
                </xsl:apply-templates>
                <xsl:if test="//tei:timeline[@xml:id='TL3IV']">
                <h3><xsl:text>File 4</xsl:text></h3>
                </xsl:if>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3IV' or @xml:id='TL2IV']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/>
                </xsl:apply-templates>
                <xsl:if test="//tei:timeline[@xml:id='TL3V']">
                <h3><xsl:text>File 5</xsl:text></h3>
                </xsl:if>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3V' or @xml:id='TL2V']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/>
                </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:timeline[contains(@xml:id,'TL3') or contains(@xml:id,'TL2')]/tei:when">
        <xsl:call-template name="utterance">
            <xsl:with-param name="xmlWhen" select="@xml:id"/>
            <xsl:with-param name="When" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="utterance">
        <xsl:param name="xmlWhen" select="@xml:id"/>
        <xsl:param name="When" select="."/>
        <xsl:for-each select="//tei:u">
                <xsl:if test="substring-after(./@synch|.[not(@xml:id)]/tei:anchor[1]/@synch,'#') = $xmlWhen">
                        <p><b style="color:red">
                        <xsl:value-of select="$When/@absolute"/>
                        </b><xsl:text> </xsl:text>
                    <xsl:choose>
                    <xsl:when test="./@who='#MA' and self::node()[@xml:id]">
                        <b><xsl:text>Maurina Alazraki: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#LPF' and self::node()[@xml:id]">
                        <b><xsl:text>Liliana Picciotto Fargion: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#PF' and self::node()[@xml:id]">
                        <b><xsl:text>Paolo Favaro: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='Maria' and self::node()[@xml:id]">
                        <b><xsl:text>Maria: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#AW' and self::node()[@xml:id]">
                        <b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#AW' and self::node()[not(@xml:id)]">
                        <b><xsl:text>(Arminio W. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#LPF' and self::node()[not(@xml:id)]">
                        <b><xsl:text>(Liliana P.F. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="./@who='#MA' and self::node()[not(@xml:id)]">
                        <b><xsl:text>(Maurina A. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:otherwise><xsl:apply-templates />
                    </xsl:otherwise>
                </xsl:choose></p>
                </xsl:if>
                    </xsl:for-each>
    </xsl:template>
      
    <xsl:template match="//tei:sic"/>
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del" />

    <xsl:template match="//tei:supplied[@reason='integration']" />

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
    
    <xsl:template match="//tei:gap" >
        <xsl:if test="..[not(@xml:id)] and normalize-space(..)=''">
            <xsl:text>-</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:vocal" />
    <xsl:template match="//tei:desc" />

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
    
</xsl:stylesheet> 