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
        <xsl:result-document href="#Header" method="ixsl:replace-content"> <!-- Elemento che indirizza la destinazione secondaria della trasformazione: un elemento con id "Header", il quale contenuto viene sostituito tramite l'attributo method (indica la modalità di elaborazione), il quale valore è una funzione estesa realizzata a tal scopo. Quando l'utente clicca il bottone "Lista luoghi" il contenuto dell'elemento header viene modificato -->
            <p>Der Dolmetscher</p>
            <p id="secondo">L'interprete</p>
        </xsl:result-document>
       <xsl:result-document href="#Menu" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "Menu" quando l'utente clicca il bottone "Lista luoghi" nella Home Page: il menù passa da essere vuoto a contenere altri elementi HTML di seguito elencati -->
       <img id="menuimg" src="menu.png" alt="Icona menu" onclick="openNav()"/> <!-- Immagine che permette che il menù si apra -->
            <div id="mySidenav" class="sidenav">
                <img id="home" src="home.png" alt="Icona home"/><!-- Immagine che permette di tornare alla Home Page -->
                <!-- Collegamenti ipertestuali del menù (lista di luoghi): ognungo se cliccato chiude il menù e dirige l'utente a una sezione della pagina web, tranne "X" che chiude solo il menù -->
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <xsl:for-each select="//tei:listPlace/tei:place">
                    <a onclick="closeNav()" style="display:inline" class="place1"><xsl:attribute name="href"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute><xsl:value-of select="./tei:placeName"/></a><xsl:text>&#32;</xsl:text>
                </xsl:for-each>
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "Info" con il risultato di <xsl:apply-templates> che applica un modello solo agli elementi figli che corrispondono al valore dell'attributo "select": quindi, solo agli elementi figli dell'elemento XML listPlace -->
            <xsl:apply-templates select="//tei:listPlace" />
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "footer" con gli elementi HTML che seguono --><br/>
            <p>© Edizione digitale delle testimonianze di <span>Arminio Wachsberger</span> realizzata all'interno del progetto <span>Voci dall'Inferno</span></p>
            <p>Progetto di Laurea in Informatica Umanistica a.a 2021/2022</p> <p><span>Greta Bernardoni</span> - mat.564826</p><br/>
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">  <!-- Sostituzione del contenuto dell'elemento HTML con id "up" con una immagine HTML -->
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
            <button id="PlaceBut" onclick="placeB()">Lista luoghi</button>
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

    <xsl:template match="//tei:listPlace">  <!-- Template che agli elementi XML figli di listPlace applica delle regole di trasformazione: questo modello viene applicato RICORSIVAMENTE quando trova corrispondenza con il pattern dell'attributo "select" di <xsl:apply-templates> -->
            <h1>
                <xsl:value-of select="tei:head" />
            </h1>
            <h2><xsl:text>Luoghi citati all'interno delle testimonianze</xsl:text></h2>
            <!-- Gestione del bottone che rimanda a una pagina Google Maps con i luoghi e i percorsi di Arminio -->
            <a id="linkm" class="luoghi" href="https://www.google.com/maps/d/u/0/viewer?mid=1-3FZB_vW5iEmxq2r8d5liTzZS63K1A4&amp;ll=18.143803593704973%2C-0.5140074999999911&amp;z=2">Mappe estese</a><br/><br/><br/>
            <img class="mappa" id="prima" src="mappa.png"/>
            <img class="mappa" src="mappa2.png"/>
            <br/><br/>

        <!-- GESTIONE DELLA TABELLA CON LE INFORMAZIONI SUI LUOGHI -->

        <table id="places">
            <xsl:for-each select="//tei:place">
            <tr>
                <th><xsl:value-of select="position()"/></th><td><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:for-each select="tei:placeName">
						<xsl:value-of select="."/>
					</xsl:for-each>
                    <xsl:if test="tei:district">
                    <xsl:text> nel </xsl:text>
                    <xsl:for-each select="tei:district">
                        <xsl:value-of select="."/>
                    </xsl:for-each>     
                    </xsl:if>
                    <xsl:if test="tei:placeName!=tei:country">
                    <xsl:text>&#32;(</xsl:text><xsl:for-each select="tei:country">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() != last()">
                                 <xsl:text>, </xsl:text>
                        </xsl:if>
					</xsl:for-each><xsl:text>)</xsl:text>
                    </xsl:if>
                    <xsl:if test="tei:note">
                    <b><xsl:text>: </xsl:text>
                        <xsl:value-of select="tei:note"/></b>
                    </xsl:if>
                    </td> 
                    <td>
                    <b><xsl:text>Extra: </xsl:text></b>
                    <xsl:choose> <!-- Gestione dei link relativi ai luoghi elencati -->
								<xsl:when test="contains(tei:placeName/@ref,' ')">
									<a>
										<xsl:attribute name="href"><xsl:value-of select="substring-before(tei:placeName/@ref, ' ')"/></xsl:attribute>
										<xsl:text>Link 1</xsl:text>
									</a><xsl:text> e </xsl:text>
                                    <a>
										<xsl:attribute name="href"><xsl:value-of select="substring-after(tei:placeName/@ref, ' ')"/></xsl:attribute>
										<xsl:text>Link 2</xsl:text>
									</a>
								</xsl:when>
								<xsl:otherwise>
                                    <a>
										<xsl:attribute name="href"><xsl:value-of select="tei:placeName/@ref"/></xsl:attribute>
										<xsl:text>Link</xsl:text>
									</a>
								</xsl:otherwise>
							</xsl:choose>
                    </td> 
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

</xsl:stylesheet>