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

    <xsl:template name="main" match="//tei:text">
        <xsl:result-document href="#trascrizione" method="ixsl:replace-content">
            <h3><xsl:text>Termini e glosse nella testimonianza</xsl:text></h3>
            <xsl:call-template name="gloss"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:sic"/>
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del" />

    <xsl:template match="//tei:vocal" />
    
    <xsl:template match="//tei:desc" />

    <xsl:template name="gloss" match="//tei:term[@xml:id]">
        <ol><xsl:for-each select="//tei:term[@xml:id]">
            <li>
            <b onclick="copy(this.id)"><xsl:attribute name="id"><xsl:value-of select="./@xml:id"/></xsl:attribute><img src="play.png" class="play"/><xsl:apply-templates/></b>
            <xsl:variable name="id" select="./@xml:id"/>
            <xsl:if test="@xml:lang='de'">
                <xsl:text> dal tedesco </xsl:text>
            </xsl:if>
            <xsl:if test="@xml:lang='ji'">
                <xsl:text> dall'yiddish </xsl:text>
            </xsl:if>
            <xsl:text> = </xsl:text>
            <xsl:for-each select="//tei:gloss">
                <xsl:if test="substring-after(./@target,'#') = $id">
                    <i><xsl:apply-templates/></i>
                </xsl:if>
            </xsl:for-each>
            </li>
        </xsl:for-each></ol>
    </xsl:template>
    
</xsl:stylesheet> 