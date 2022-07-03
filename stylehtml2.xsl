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
        <xsl:result-document href="#Header" method="ixsl:replace-content"> <!-- Elemento che indirizza la destinazione secondaria della trasformazione: un elemento con id "Header", il quale contenuto viene sostituito tramite l'attributo method (indica la modalità di elaborazione), il quale valore è una funzione estesa realizzata a tal scopo. Quando l'utente clicca il bottone "Lista persone" il contenuto dell'elemento header viene modificato -->
            <p>Der Dolmetscher</p>
            <p id="secondo">L'interprete</p>
        </xsl:result-document>
       <xsl:result-document href="#Menu" method="ixsl:replace-content"><!-- Sostituzione del contenuto dell'elemento HTML con id "Menu" quando l'utente clicca il bottone "Lista persone" nella Home Page: il menù passa da essere vuoto a contenere altri elementi HTML di seguito elencati -->
        <img id="menuimg" src="menu.png" alt="Icona menu" onclick="openNav()"/> <!-- Immagine che permette che il menù si apra -->
            <div id="mySidenav" class="sidenav">
                <img id="home" src="home.png" alt="Icona home"/><!-- Immagine che permette di tornare alla Home Page -->
                <!-- Collegamenti ipertestuali del menù (lista di individui): ognungo se cliccato chiude il menù e dirige l'utente a una sezione della pagina web, tranne "X" che chiude solo il menù -->
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <xsl:for-each select="//tei:person">
                    <a class="people1" onclick="closeNav()" style="display:inline;font-size:25px"><xsl:attribute name="href"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute>
                    <xsl:if test="tei:persName/tei:forename[not(@type='religious')] and tei:persName/tei:forename[not(@type='alternative')]">
						<xsl:value-of select="tei:persName/tei:forename[not(@type='religious')]"/>
						<xsl:text>&#32;</xsl:text>
                    </xsl:if>
                    <xsl:if test="tei:persName/tei:forename[@type='unknown'] and tei:persName/tei:surname[@type='unknown']">
                        <xsl:text>Unknown: </xsl:text><xsl:value-of select="tei:persName/tei:addName"/>
                    </xsl:if>
                     <xsl:if test="tei:persName/tei:surname">
						<xsl:value-of select="tei:persName/tei:surname"/>
                    </xsl:if></a><xsl:text>&#32;</xsl:text>
                </xsl:for-each>
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Info" con il risultato di <xsl:apply-templates> che applica un modello solo agli elementi figli che corrispondono al valore dell'attributo "select": quindi, solo agli elementi figli dell'elemento XML listPerson -->
            <xsl:apply-templates select="//tei:listPerson" />
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

    <!-- GESTIONE DELLA TABELLA CON LE INFORMAZIONI SUGLI INDIVIDUI -->

    <xsl:template match="//tei:listPerson"> <!-- Template che agli elementi XML figli di listPerson applica delle regole di trasformazione: questo modello viene applicato RICORSIVAMENTE quando trova corrispondenza con il pattern dell'attributo "select" di <xsl:apply-templates> -->

            <h1>
                <xsl:value-of select="tei:head" />
            </h1>
            <h2><xsl:text>Persone citate all'interno delle testimonianze</xsl:text></h2>
        <table id="persone">
            <xsl:for-each select="//tei:person">
            <tr><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                <td class="nome">
                    <xsl:for-each select="tei:persName/tei:forename">
                    <xsl:if test=".[not(@type='religious')] and .[not(@type='alternative')]">
						<xsl:value-of select="."/>
						<xsl:text>&#32;</xsl:text>
                    </xsl:if>
                    <xsl:if test=".[@type='alternative']">
						<xsl:text>(</xsl:text><xsl:value-of select="."/><xsl:text>) </xsl:text>
                    </xsl:if>
					</xsl:for-each>
					<xsl:for-each select="tei:persName/tei:surname">
                        <xsl:choose>
                        <xsl:when test=".[@type='married']">
                            <xsl:value-of select=".[@type='birth'] | .[@type='combine']"/>
                            <xsl:text> in </xsl:text>
                            <xsl:value-of select=".[@type='married']"/>
                        </xsl:when>
                        <xsl:when test=".[@type='alternative']">
                            <xsl:text>(</xsl:text><xsl:value-of select="."/><xsl:text>) </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="."/>
						    <xsl:text>&#32;</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
					</xsl:for-each>
                    <xsl:for-each select="tei:persName">
                    <xsl:if test="tei:forename[@type='unknown'] and tei:surname[@type='unknown']">
                        <xsl:text>UNKNOWN</xsl:text>
                    </xsl:if>
                    </xsl:for-each>                    
                    <xsl:if test="not(normalize-space(tei:death/tei:date)='') or not(normalize-space(tei:death/tei:placeName/tei:settlement)='') ">
                        <xsl:text>&#8224;</xsl:text>
                    </xsl:if>
                    <br/>
                    <span class="infoperson">
                        (<xsl:value-of select="concat(tei:birth/tei:date,' ', tei:birth/tei:placeName/tei:settlement,' ',tei:birth/tei:placeName/tei:country,' ','-',' ', tei:death/tei:date,' ', tei:death/tei:placeName/tei:settlement,' ',tei:death/tei:placeName/tei:country)"/>)
                    </span>
                    </td> 
                    <td class="information">
                        <ul>
                            <li><b><xsl:text>Sesso: </xsl:text></b><xsl:value-of select="tei:sex"/></li>
                            <xsl:if test="tei:persName/@role">
                                <li><b><xsl:text>Ruolo: </xsl:text></b><xsl:value-of select="translate(tei:persName/@role,'_',' ')"/></li>
                            </xsl:if>
                                <xsl:for-each select="tei:persName">
                                    <xsl:if test="tei:forename[@type='religious']">
                                        <li><b><xsl:text>Nome religioso: </xsl:text></b><i><xsl:value-of select="tei:forename[@type='religious']"/></i></li>
                                    </xsl:if>
                                    <xsl:if test="tei:addName">
                                    <li><b><xsl:text>Soprannomi: </xsl:text></b><xsl:for-each select="tei:addName">
                                        <i><xsl:value-of select="."/>
                                        <xsl:if test="position() != last()">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if></i>
                                    </xsl:for-each></li>
                                    </xsl:if>
                                    <xsl:if test="tei:roleName">
                                    <li><b><xsl:text>Ruoli e onorificenze: </xsl:text></b><xsl:for-each select="tei:roleName">
                                        <i><xsl:value-of select="."/>
                                        <xsl:if test="position() != last()">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if></i>
                                    </xsl:for-each></li>
                                    </xsl:if>
                                </xsl:for-each>
                            <xsl:if test="tei:note | tei:birth//tei:note | tei:death//tei:note">
                                <xsl:for-each select="tei:note | tei:birth//tei:note | tei:death//tei:note">
                                    <li><xsl:value-of select="."/></li>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:choose> <!-- Gestione dei Link degli individui elencati -->
								<xsl:when test="@sameAs and contains(tei:persName/tei:ref/@target,' ')">
                                    <li><b><xsl:text>Extra: </xsl:text></b>
									<a>
										<xsl:attribute name="href"><xsl:value-of select="@sameAs"/></xsl:attribute>
										<xsl:text>Link 1</xsl:text>
									</a><xsl:text>, </xsl:text>
									<a>
										<xsl:attribute name="href"><xsl:value-of select="substring-before(tei:persName/tei:ref/@target, ' ')"/></xsl:attribute>
										<xsl:text>Link 2</xsl:text>
									</a><xsl:text> e </xsl:text>
                                    <a>
										<xsl:attribute name="href"><xsl:value-of select="substring-after(tei:persName/tei:ref/@target, ' ')"/></xsl:attribute>
										<xsl:text>Link 3</xsl:text>
									</a> 
                                    </li>
								</xsl:when>
                                <xsl:when test="not(@sameAs) and contains(tei:persName/tei:ref/@target,' ')">
                                    <li><b><xsl:text>Extra: </xsl:text></b>
                                    <xsl:if test="contains(tei:persName/tei:ref/@target,' ')">
									<a>
										<xsl:attribute name="href"><xsl:value-of select="substring-before(tei:persName/tei:ref/@target, ' ')"/></xsl:attribute>
										<xsl:text>Link 1</xsl:text>
									</a><xsl:text> e </xsl:text>
                                    <a>
										<xsl:attribute name="href"><xsl:value-of select="substring-after(tei:persName/tei:ref/@target, ' ')"/></xsl:attribute>
										<xsl:text>Link 2</xsl:text>
									</a> 
                                    </xsl:if>
                                    </li>
								</xsl:when>
                                <xsl:when test="tei:persName/tei:ref[@target='']">
								</xsl:when>
								<xsl:otherwise>
                                <li><b><xsl:text>Extra: </xsl:text></b>
									<a>
										<xsl:attribute name="href"><xsl:value-of select="tei:persName/tei:ref/@target"/></xsl:attribute>
										<xsl:text>Link</xsl:text>
									</a></li>
								</xsl:otherwise>
							</xsl:choose>
                                                        
                                <xsl:choose> <!-- Gestioni delle fonti -->
                                <xsl:when test=".[@source='#Rigano2015']">
                                    <li><b><xsl:text>Fonte: </xsl:text></b>
                                    <a class="fonti">
				                    <xsl:attribute name="href">#Rigano2015</xsl:attribute><xsl:text>Rigano, 2015</xsl:text>
			                        </a></li>
                                </xsl:when>
                                <xsl:when test=".[@source='#Katz1973']">
                                    <li><b><xsl:text>Fonte: </xsl:text></b>
                                    <a class="fonti">
				                    <xsl:attribute name="href">#Katz1973</xsl:attribute><xsl:text>Katz, 1973</xsl:text>
			                        </a></li>
                                </xsl:when>
                                <xsl:otherwise>
                                </xsl:otherwise>
                                </xsl:choose>
                        </ul>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

</xsl:stylesheet>