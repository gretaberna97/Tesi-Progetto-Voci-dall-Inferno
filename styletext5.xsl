<?xml version="1.0" encoding="utf-8"?> <!-- Prologo che definisce la versione XML e la codifica dei caratteri -->
<xsl:stylesheet version="3.0"           
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
 	xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:js="http://saxonica.com/ns/globalJS"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"> <!-- Elemento radice che dichiara che il documento è un foglio di stile XSL con versione 3. Inoltre, sono stati dichiarati i vari namespace che permettono di accedere agli elementi, agli attributi e alle funzionalità sia di XSL, che di SaxonJS, etc -->

    <xsl:output method="text" encoding="UTF-8" indent="yes" /> <!-- Definizione del formato del documento di output -->

    <xsl:template name="main" match="//tei:text"> <!-- Creazione del modello denominato "main" che vale per tutto il documento grazie al valore dell'attributo match che è un'espressione XPath. Le regole di trasformazione di seguito definite sono le prime che vengono attivate da SaxonJS.transform() -->
        <xsl:result-document href="#trascrizione" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "trascrizione" quando l'utente clicca il pulsante "Termini e glosse": il contenuto viene elaborato dal template denominato "gloss" e chiamato con <xsl:call-template> -->
            <h3><xsl:text>Termini e glosse nella testimonianza</xsl:text></h3>
            <xsl:call-template name="gloss"/>
        </xsl:result-document>
    </xsl:template>

    <!-- Gestione della lista dei termini (in lingua straniera) e delle glosse -->
    <xsl:template name="gloss" match="//tei:term[@xml:id]">
        <ol><xsl:for-each select="//tei:term[@xml:id]">
            <li>
            <!-- A ogni elemento <b> viene associato un id (quello del termine) e tale id viene passato alla funzione copy() quando <b> viene cliccato dall'utente -->
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

    <!-- TEMPLATE PER GLI ALTRI ELEMENTI XML -->

    <!-- Gestione del resto degli elementi XML che vengono nascosti nella trascrizione -->
    <xsl:template match="//tei:sic"/>    
    <xsl:template match="//tei:orig" />
    <xsl:template match="//tei:abbr" />
    <xsl:template match="//tei:surplus" />
    <xsl:template match="//tei:supplied[@reason='integration']" />
    <xsl:template match="//tei:del" />
    <xsl:template match="//tei:vocal" />
    <xsl:template match="//tei:desc" />
    
</xsl:stylesheet> 