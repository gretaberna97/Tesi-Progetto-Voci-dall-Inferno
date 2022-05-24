<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
 	xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:js="http://saxonica.com/ns/globalJS"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="h ixsl js saxon xs">

<xsl:output method="html" html-version="5" encoding="utf-8" indent="no"/>

    <xsl:template name="main" match="/">
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
            <img id="home" src="home.png" alt="Icona home"/>
            <a href="#informazione" id="info">Informazioni</a><br/>
			<a href="#riassunto" id="rias">Riassunto</a><br/>
			<a href="#trascrizione" id="tras">Trascrizione</a><br/> 
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:listPerson" />
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
            <p>Edizione digitale delle testimonianze di</p><span>Arminio Wachsberger</span>
            <p>Realizzata da Greta Bernardoni per il progetto Voci dall'Inferno</p>
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:img[@id='home']" >
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
            <button id="TestOne" onclick="testOne()">4 Febbraio 1998</button>
            <button id="TestTwo" onclick="testTwo()">18 Febbraio 1987</button>
            <button>Persone citate</button> 
            <button>Luoghi citati</button>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:listPerson">
            <h1>
                <xsl:value-of select="tei:head" />
            </h1>
        <table id="informazione">
            <xsl:for-each select="//tei:person">
            <tr>
                <th><xsl:value-of select="./tei:persName" /></th> <td></td>
            </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="//tei:text" >
    <br/>   
        <button onclick="more(this)"> legenda </button>
        
        <div class="legenda" style="display:none">
            <xsl:if test='//tei:text//tei:u'><br/>
            <p><xsl:text>Le frecce possono essere cliccate e mostrano/nascondono fenomeni comunicativi</xsl:text></p>
            <p><xsl:text>I tre puntini (...) indicano le pause negli enunciati</xsl:text></p>
            <p><xsl:text>Il carattere asterisco (*) indica parole di difficile interpretazione e, dunque, non certe</xsl:text></p>
            <p><xsl:text>Il simbolo &#10008; indica le lacune</xsl:text></p>
            <xsl:if test='//tei:gloss'>
                <p><xsl:text>Le parole in grassetto sono le glosse dei termini del Lager utilizzati: cliccandoci vediamo il termine associato</xsl:text></p>
            </xsl:if>
            </xsl:if>
            <xsl:if test='//tei:emph|//tei:shift'>
                <p><xsl:text>Le parole in maiuscoletto indicano porzioni di testo enfatizzate</xsl:text></p>
            </xsl:if>
            <xsl:if test='//tei:distinct'>
                <p><xsl:text>Le parole in corsivo indicano porzioni di testo linguisticamente distinte</xsl:text></p>
            </xsl:if>
        </div>
        <h2>Trascrizione</h2>
        <div id="trascrizione">
            <xsl:apply-templates />
        </div>
        <button onclick="download()"> download </button>
    </xsl:template>

    <xsl:template match="//tei:div[@type='testo']">
        <b><xsl:text>Inizio registrazione</xsl:text></b><br /><xsl:apply-templates />
    </xsl:template>


</xsl:stylesheet>