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

<xsl:output method="html" html-version="5" encoding="utf-8" indent="no"/> <!-- Definizione del formato del documento di output -->

    <xsl:template name="main" match="/"><!-- Creazione del modello denominato "main" che vale per tutto il documento grazie al valore dell'attributo match che è un'espressione XPath. Le regole di trasformazione di seguito definite sono le prime che vengono attivate da SaxonJS.transform() -->
        <xsl:result-document href="#Header" method="ixsl:replace-content"> <!-- Elemento che indirizza la destinazione secondaria della trasformazione: un elemento con id "Header", il quale contenuto viene sostituito tramite l'attributo method (indica la modalità di elaborazione), il quale valore è una funzione estesa realizzata a tal scopo. Quando l'utente clicca il bottone "Fonti di ausilio" il contenuto dell'elemento header viene modificato -->
            <p>Der Dolmetscher</p>
            <p id="secondo">L'interprete</p>
        </xsl:result-document>
       <xsl:result-document href="#Menu" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Menu" quando l'utente clicca il bottone "Fonti di ausilio" nella Home Page: il menù passa da essere vuoto a contenere altri elementi HTML di seguito elencati -->
       <img id="menuimg" src="menu.png" alt="Icona menu" onclick="openNav()"/> <!-- Immagine che permette che il menù si apra -->
            <div id="mySidenav" class="sidenav">
                <img id="home" src="home.png" alt="Icona home"/><!-- Immagine che permette di tornare alla Home Page -->
                <!-- Collegamenti ipertestuali del menù (lista delle fonti): ognungo se cliccato chiude il menù e dirige l'utente a una sezione della pagina web, tranne "X" che chiude solo il menù -->
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <xsl:for-each select="//tei:sourceDesc/tei:bibl">
                <a onclick="closeNav()"><xsl:attribute name="href"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute><xsl:value-of select="./tei:title[1]"/></a><br/>
                </xsl:for-each>
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">  <!-- Sostituzione del contenuto dell'elemento HTML con id "Info" con il risultato di <xsl:apply-templates> che applica un modello solo agli elementi figli che corrispondono al valore dell'attributo "select": quindi, solo agli elementi figli dell'elemento XML sourceDesc -->
            <xsl:apply-templates select="//tei:sourceDesc" />
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "footer" con gli elementi HTML che seguono --><br/>
            <p>© Edizione digitale delle testimonianze di <span>Arminio Wachsberger</span> realizzata all'interno del progetto <span>Voci dall'Inferno</span></p>
            <p>Progetto di Laurea in Informatica Umanistica a.a 2021/2022</p> <p><span>Greta Bernardoni</span> - mat.564826</p><br/>
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "up" con una immagine HTML -->
            <img id="upimg" src="up.png" alt="Icona up"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:img[@id='home']" > <!-- Modello che si attiva solo quando l'utente clicca sull'immagine con id "home" definita dall'attributo match che indica l'elemento su cui applicare il modello: quando questo elemento viene cliccato la pagina web cambia per riportare l'utente alla Home Page. In poche parole, vengono meno le regole di elaborazione del template "main" -->
        <xsl:result-document href="#Header" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Header" -->
            <p>Der Dolmetscher</p>
            <p id="secondo">L'interprete: Arminio Wachsberger</p>
        </xsl:result-document>
        <xsl:result-document href="#Menu" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "Menu" -->
            <button id="TestOne" onclick="testOne()">4 Febbraio 1998</button>
            <button id="TestTwo" onclick="testTwo()">18 Febbraio 1987</button>
            <button id="PeopleBut" onclick="peopleB()">Lista persone</button> 
            <button id="PlaceBut" onclick="placeB()">Fonti di ausilio</button>
            <button id="FontiBut" onclick="fontiB()">Fonti di ausilio</button>
        </xsl:result-document>
        <!-- Azzeramento del contenuto degli elementi HTML con id "Info", "footer" e "up": nella Home inizialmente non erano infatti visibili -->
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
        </xsl:result-document>
    </xsl:template>

    <!-- GESTIONE DELLA TABELLA CON LE INFORMAZIONI SULLE FONTI -->

    <xsl:template match="//tei:sourceDesc">
            <h1>
                <xsl:text>Fonti di ausilio</xsl:text>
            </h1>
            <h2>
                <xsl:text>Fonti utilizzate per identificare luoghi e nomi</xsl:text>
            </h2>
            <xsl:for-each select="tei:bibl">
            <table><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                <tr><th><xsl:text>Titolo primario:</xsl:text></th><td><xsl:value-of select="./tei:title[1]"/></td></tr>
                <tr><th><xsl:text>Titolo secondario:</xsl:text></th><td><xsl:value-of select="./tei:title[2]"/></td></tr>
                <tr><th><xsl:text>Autore:</xsl:text></th><td><xsl:value-of select="./tei:author"/></td></tr>
                <tr><th><xsl:text>Versione:</xsl:text></th><td><xsl:value-of select="./@type"/></td></tr>
                <tr><th><xsl:text>Curatore:</xsl:text></th><td><xsl:value-of select="./tei:editor"/></td></tr>
                <tr><th><xsl:text>Luogo di pubblicazione:</xsl:text></th><td><xsl:value-of select="./tei:pubPlace"/></td></tr>
                <tr><th><xsl:text>Editore:</xsl:text></th><td><xsl:value-of select="./tei:publisher"/></td></tr>
                <tr><th><xsl:text>Data pubblicazione:</xsl:text></th><td><xsl:value-of select="./tei:date"/></td></tr>
            </table><br/>
            </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>