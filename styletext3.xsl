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

    <xsl:template name="testo">
        <xsl:for-each select="//tei:timeline[contains(@xml:id,'TL3')]">
            <h3><xsl:text>File </xsl:text><xsl:value-of select="position()"/></h3>
            <xsl:for-each select="./tei:when">
                <xsl:variable name="xmlWhen" select="@xml:id"/>
                <xsl:variable name="When" select="."/>
                    <xsl:for-each select="//tei:u">
                        <xsl:if test="substring-after(./@synch,'#') = $xmlWhen">
                        <b style="color:red">
                        <xsl:value-of select="$When/@absolute"/>
                        </b><xsl:text> </xsl:text>
                        <xsl:choose>
                            <xsl:when test="./@who='#AW'">
                                <b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:apply-templates /><br />
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
                            <xsl:otherwise><xsl:apply-templates select="self::node()[not(@xml:id)]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        </xsl:if> 
                    </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
      
    <xsl:template match="//tei:sic"/>
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del" />

    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>
    
    <xsl:template match="//tei:gap" >
        <xsl:if test="..[not(@xml:id)] and normalize-space(..)=''">
            <xsl:text>*lacuna*</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:vocal" />
    <xsl:template match="//tei:desc" />
    
    <!--vocal e desc presenti solo in sovrapposizione-->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:vocal">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]//tei:desc" >
        <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
    </xsl:template>
    
</xsl:stylesheet> 