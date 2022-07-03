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

    <xsl:template name="main" match="/"><!-- Creazione del modello denominato "main" che vale per tutto il documento grazie al valore dell'attributo match che è un'espressione XPath. Le regole di trasformazione di seguito definite sono le prime che vengono attivate da SaxonJS.transform() -->
        <xsl:result-document href="#trascrizione" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "trascrizione" quando l'utente clicca il pulsante "minuti" -->

                <!-- Ogni file di cui si compone la testimonianza è identificato da un titolo di terzo livello, seguito da <xsl:apply-templates> che applica un modello solo agli elementi figli che corrispondono al valore dell'attributo "select": i when delle timeline in standOff relative sia alle sovrapposizioni tra i parlanti che alla produzione degli enunciati -->

                <h3><xsl:text>File 1</xsl:text></h3>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3I' or @xml:id='TL2I']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/> <!-- Elemento utilizzato per ordinare l'output del modello applicato da <xsl:apply-templates>: i when delle timeline (sopra citate) del primo file delle testimonianze sono ordinati secondo i valori dell'attributo @absolute in senso ascendente -->
                </xsl:apply-templates>
                <h3><xsl:text>File 2</xsl:text></h3>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3II' or @xml:id='TL2II']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/> <!-- Vengono ordinati i when del secondo file delle testimonianze secondo i valori dell'attributo @absolute in senso ascendente -->
                </xsl:apply-templates>
                <xsl:if test="//tei:timeline[@xml:id='TL3III']">
                    <h3><xsl:text>File 3</xsl:text></h3>
                </xsl:if>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3III' or @xml:id='TL2III']/tei:when">
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/> <!-- Vengono ordinati i when del terzo file (se presente) delle testimonianze secondo i valori dell'attributo @absolute in senso ascendente -->
                </xsl:apply-templates>
                <xsl:if test="//tei:timeline[@xml:id='TL3IV']">
                    <h3><xsl:text>File 4</xsl:text></h3>
                </xsl:if>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3IV' or @xml:id='TL2IV']/tei:when"> 
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/><!-- Vengono ordinati i when del quarto file (se presente) delle testimonianze secondo i valori dell'attributo @absolute in senso ascendente -->
                </xsl:apply-templates>
                <xsl:if test="//tei:timeline[@xml:id='TL3V']">
                    <h3><xsl:text>File 5</xsl:text></h3>
                </xsl:if>
                <xsl:apply-templates select="//tei:timeline[@xml:id='TL3V' or @xml:id='TL2V']/tei:when"> 
                     <xsl:sort select="@absolute" data-type="time" order="ascending"/><!-- Vengono ordinati i when del quinto file (se presente) delle testimonianze secondo i valori dell'attributo @absolute in senso ascendente -->
                </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>

    <!-- GESTIONE DEI MINUTI NELLE TIMELINE DELLE SOVRAPPOSIZIONI TRA I PARLANTI E DELLE PRODUZIONI DI ENUNCIATI -->

    <xsl:template match="//tei:timeline[contains(@xml:id,'TL3') or contains(@xml:id,'TL2')]/tei:when"> <!-- Template che ai when applica delle regole di trasformazione: questo modello viene applicato RICORSIVAMENTE quando trova corrispondenza con il pattern dell'attributo "select" di <xsl:apply-templates> -->
        <xsl:call-template name="utterance"> <!-- Invocazione del template denominato utterance -->
            <!-- Definizione dei valori di due parametri da passare al template utterance -->
            <xsl:with-param name="xmlWhen" select="@xml:id"/> <!-- Id degli elementi when -->
            <xsl:with-param name="When" select="."/> <!-- elemento when corrente -->
        </xsl:call-template>
    </xsl:template>

    <!-- Template denominato utterance -->
    <xsl:template name="utterance">
        <!-- Dichiarazione di due parametri, i quali valori gli sono stati passati dalla chiamata del template precedente -->
        <xsl:param name="xmlWhen" select="@xml:id"/>
        <xsl:param name="When" select="."/>
        <xsl:for-each select="//tei:u">
            <xsl:if test="substring-after(./@synch|.[not(@xml:id)]/tei:anchor[1]/@synch,'#') = $xmlWhen"> <!-- Se gli enunciati, o i primi elementi figlio anchor, hanno l'attributo @synch e ciò che segue il carattere # è uguale all'id del when corrente alora vengono mostrati i minuti in rosso a sinistra degli enunciati prodotti dai vari parlanti -->
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
                    <xsl:otherwise>
                        <xsl:apply-templates />
                    </xsl:otherwise>
                </xsl:choose></p>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
      
    <!-- TEMPLATE PER GLI ALTRI ELEMENTI XML FIGLI DEI DIV -->

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
    
    <!-- Gestione delle lacune e delle porzioni del testo oscurate -->
    <xsl:template match="//tei:gap" >
        <xsl:if test="..[not(@xml:id)] and normalize-space(..)=''">
            <xsl:text>-</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Gestione degli elementi vocal, del e desc all'interno degli enunciati che si sovrappongono -->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:vocal">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]/tei:del">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]//tei:desc" >
        <xsl:text>-</xsl:text>
    </xsl:template>
    
    <!-- Gestione del resto degli elementi XML che vengono nascosti nella trascrizione -->
    <xsl:template match="//tei:sic" />    
    <xsl:template match="//tei:orig" />
    <xsl:template match="//tei:abbr" />
    <xsl:template match="//tei:surplus" />
    <xsl:template match="//tei:del"/>
    <xsl:template match="//tei:desc"/>
    <xsl:template match="//tei:vocal"/>
    <xsl:template match="//tei:supplied[@reason='integration']" />

</xsl:stylesheet> 