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

    <xsl:template name="main" match="/"> <!-- Creazione del modello denominato "main" che vale per tutto il documento grazie al valore dell'attributo match che è un'espressione XPath. Le regole di trasformazione di seguito definite sono le prime che vengono attivate da SaxonJS.transform() -->
        <xsl:result-document href="#trascrizione" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "trascrizione" quando l'utente clicca il pulsante "fenomeni del parlato": il contenuto viene elaborato dal template denominato "testo" e chiamato con <xsl:call-template> -->
            <xsl:call-template name="testo"/> 
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="testo" match="//div[@type='testo']"> <!-- Modello che si attiva per ogni parte di cui consta la testimonianza: viene restituito il testo trascritto a seconda di dove appare nella testimonianza -->
        <xsl:for-each select="//tei:div[@type='testo']">
            <h3><xsl:text>File </xsl:text><xsl:value-of select="position()"/></h3>
            <xsl:apply-templates/>
            </xsl:for-each>
    </xsl:template>

    <!-- GESTIONE DEGLI ENUNCIATI PRODOTTI DAI PARLANTI -->
    <xsl:template match="//tei:u">
                <xsl:choose> <!-- Gestione degli enunciati sovrapposti -->
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#AW']">
                        <p><b><xsl:text>(Arminio W. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#LPF']">
                        <p><b><xsl:text>(Liliana P.F. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#MA']">
                        <p><b><xsl:text>(Maurina A. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when> <!-- Gestione degli enunciati non sovrapposti -->
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

    <!-- TEMPLATE PER GLI ELEMENTI XML FIGLI DEI DIV RELATIVI AI FENOMENI DEL PARLATO -->
    
    <!-- Gestione delle cancellazioni -->
    <xsl:template match="//tei:del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- Gestione delle porzioni del testo enfatizzate -->
    <xsl:template match="//tei:emph">
        <span class="emph"><xsl:apply-templates /></span>
    </xsl:template>

    <!-- Gestione dei cambiamenti paralinguistici negli enunciati -->
    <xsl:template match="//tei:shift">
        <span class="tono"><xsl:apply-templates /></span>
    </xsl:template>

    <!-- Gestione dei fenomeni comunicativi non necessariamente vocalizzati come i gesti -->
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

    <!-- Gestione dei fenomeni non necessariamente vocalizzati o comunicativi -->
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

    <!-- Gestione degli elementi del all'interno degli enunciati che si sovrappongono -->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:del">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <!-- Gestione dei fenomeni vocali non necessariamente lessicali -->
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

    <!-- Gestione delle pause -->
    <xsl:template match="//tei:pause">
        <xsl:choose>
        <xsl:when test="following-sibling::tei:u"> <img class="imgp" src="pausa.png"/><br /></xsl:when>
        <xsl:otherwise><img class="imgp" src="pausa.png"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Gestioni delle ancore che definiscono l'inizio e la fine delle sovrapposizioni tra gli enunciati -->
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

    <!-- TEMPLATE PER GLI ALTRI ELEMENTI XML FIGLI DEI DIV -->

    <!-- Gestione del resto degli elementi XML che vengono nascosti nella trascrizione -->
    <xsl:template match="//tei:sic"/>    
    <xsl:template match="//tei:orig" />
    <xsl:template match="//tei:abbr" />
    <xsl:template match="//tei:surplus" />
    <xsl:template match="//tei:supplied[@reason='integration']" />

    <!-- Gestione del testo riferito -->
    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>

    <!-- Gestione delle traduzioni -->
    <xsl:template match="//tei:span[@corresp]">
        <xsl:text>&#10077;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#10078;</xsl:text>
    </xsl:template>

    <!-- Gestione delle lacune o delle parti oscurate negli enunciati sovrapposti -->
    <xsl:template match="//tei:u//tei:gap" >
        <xsl:if test="..[not(@xml:id)]">
            <xsl:text>-</xsl:text>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet> 