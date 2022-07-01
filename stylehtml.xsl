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

    <xsl:template name="main" match="/"> <!-- Creazione del modello denominato "main" che vale per tutto il documento grazie al valore dell'attributo match che è un'espressione XPath. Le regole di trasformazione di seguito definite sono le prime che vengono attivate da SaxonJS.transform() -->
        <xsl:result-document href="#Header" method="ixsl:replace-content"> <!-- Elemento che indirizza la destinazione secondaria della trasformazione: un elemento con id "Header", il quale contenuto viene sostituito tramite l'attributo method (indica la modalità di elaborazione), il quale valore è una funzione estesa realizzata a tal scopo. Quando l'utente clicca uno dei bottoni delle testimonianze nella Home Page il contenuto dell'elemento header viene modificato -->
            <p>Der Dolmetscher</p>
            <p style="margin-top:-10%">L'interprete</p>
        </xsl:result-document>
        <xsl:result-document href="#Menu" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Menu" quando l'utente clicca uno dei bottoni delle testimonianze nella Home Page: il menù passa da essere vuoto a contenere altri elementi HTML di seguito elencati -->
        <img id="menuimg" src="menu.png" alt="Icona menu" onclick="openNav()"/> <!-- Immagine che permette che il menù si apra -->
            <div id="mySidenav" class="sidenav">
                <img id="home" src="home.png" alt="Icona home"/><br/> <!-- Immagine che permette di tornare alla Home Page -->
                <!-- Collegamenti ipertestuali del menù: ognungo se cliccato chiude il menù e dirige l'utente a una sezione della pagina web, tranne "X" che chiude solo il menù -->
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <a href="#h2inf" id="info" onclick="closeNav()">Informazioni</a><br/>
                <a href="#h2rias" id="rias" onclick="closeNav()">Riassunto</a><br/>
                <a href="#h2tra" id="tras" onclick="closeNav()">Trascrizione</a><br/> 
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Info" con il risultato di <xsl:apply-templates> che applica un modello solo agli elementi figli che corrispondono al valore dell'attributo "select": quindi, solo agli elementi figli dell'elemento XML fileDesc e profileDesc -->
            <xsl:apply-templates select="//tei:fileDesc" /> 
            <xsl:apply-templates select="//tei:profileDesc" />
        </xsl:result-document>
        <xsl:result-document href="#Testo" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Testo" con il risultato di <xsl:apply-templates> che applica un modello solo agli elementi figli che corrispondono al valore dell'attributo "select": quindi, solo agli elementi figli dell'elemento XML text -->
            <xsl:apply-templates select="//tei:text" />
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "footer" con gli elementi HTML che seguono --><br/>
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
            <p style="margin-top:-10%">L'interprete: Arminio Wachsberger</p>
        </xsl:result-document>
        <xsl:result-document href="#Menu" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "Menu" -->
            <button id="TestOne" onclick="testOne()">4 Febbraio 1998</button>
            <button id="TestTwo" onclick="testTwo()">18 Febbraio 1987</button>
            <button id="PeopleBut" onclick="peopleB()">Lista persone</button> 
            <button id="PlaceBut" onclick="placeB()">Lista luoghi</button>
            <button id="FontiBut" onclick="fontiB()">Fonti di ausilio</button>
        </xsl:result-document>
        <!-- Azzeramento del contenuto degli elementi HTML con id "Info", "Testo", "footer" e "up": nella Home inizialmente non erano infatti visibili -->
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#Testo" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
        </xsl:result-document>
    </xsl:template>

    <!-- GESTIONE DELLA SEZIONE INFORMATIVA DELLE PAGINE DEDICATE ALLE TESTIMONIANZE -->

    <xsl:template match="//tei:fileDesc"> <!-- Template che agli elementi XML figli di fileDesc applica delle regole di trasformazione: questo modello viene applicato RICORSIVAMENTE quando trova corrispondenza con il pattern dell'attributo "select" di <xsl:apply-templates> -->
            <h1>
                <xsl:value-of select="tei:titleStmt/tei:title" />
            </h1>
            <h2 id="h2inf">Informazioni</h2>
        <table id="informazione">
            <tr>
                <th><xsl:text>Edizione:</xsl:text></th> <td><xsl:value-of select="//tei:edition" /></td>
            </tr>
            <tr>
                <th><xsl:text>Codificatore:</xsl:text></th> <td> <xsl:value-of select="tei:editionStmt/tei:respStmt/tei:name" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Editore:</xsl:text></th> <td> <xsl:value-of select="tei:publicationStmt" /> </td>
            </tr>         
            <xsl:if test="//tei:recordingStmt/tei:recording[1]/tei:broadcast//tei:date"><tr>
                <th><xsl:text> Data trasmissione:</xsl:text></th> <td> 
                <xsl:value-of select="//tei:recordingStmt/tei:recording[1]/tei:broadcast//tei:date" /> </td>
            </tr></xsl:if>
            <tr>
                <th><xsl:text> Tipo di registrazione:</xsl:text></th><td><xsl:value-of select="//tei:recordingStmt/tei:recording[1]/@type" /></td>
            </tr>
            <xsl:for-each select="//tei:recordingStmt/tei:recording[1]/tei:respStmt">
                <tr>
                    <th><xsl:value-of select="./tei:resp" />:</th> <td> <xsl:value-of select="./tei:name" /> </td>
                </tr>
            </xsl:for-each>
            <tr>
                <th><xsl:text> Numero registrazioni: </xsl:text></th> <td><xsl:value-of select="count(//tei:recordingStmt/tei:recording)" /><xsl:text> della durata di: </xsl:text>
                <xsl:for-each select="//tei:recordingStmt/tei:recording/@dur">
                    <xsl:choose>
                    <xsl:when test="contains(.,'H')"> <!-- Regole da applicare quando una registrazione dura almeno un'ora -->
                        <xsl:value-of select="substring-before(substring-after(.,'PT'), 'H')"/><xsl:text> ora </xsl:text>
                        <xsl:value-of select="substring-before(substring-after(.,'H'), 'M')"/><xsl:text> minuti e </xsl:text>
                        <xsl:value-of select="substring-before(substring-after(.,'M'), 'S')"/><xsl:text> secondi</xsl:text>
                    </xsl:when>
                    <xsl:otherwise> <!-- Regole da applicare quando una registrazione non dura neanche un'ora -->
                        <xsl:value-of select="substring-before(substring-after(.,'PT'), 'M')"/><xsl:text> minuti e </xsl:text>
                        <xsl:value-of select="substring-before(substring-after(.,'M'), 'S')"/><xsl:text> secondi</xsl:text>
                    </xsl:otherwise>
                    </xsl:choose>
					<xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                    </xsl:if>   
                </xsl:for-each></td>
            </tr>
            <xsl:for-each select="//tei:equipment">
                <xsl:if test="not(normalize-space(tei:p)='')"> <!-- Se ci sono informazioni sui supporti utilizzati per registrare le interviste, allora queste vengono visualizzate -->
                    <tr>
                        <th><xsl:text> Equipaggiamento file num. </xsl:text><xsl:value-of select="position()" />:</th> 
                        <td><xsl:value-of select="." /></td>
                    </tr>
                </xsl:if>
            </xsl:for-each>
            <tr>
                <th><xsl:text> Nota:</xsl:text></th>
                <td><ul>
                <xsl:for-each select="//tei:recordingStmt/tei:recording[1]//tei:note">
                    <li><xsl:value-of select="." /></li>
                </xsl:for-each>
                </ul></td>
            </tr>
            <tr>
                <th><xsl:text> Trasmissione:</xsl:text></th>
                <td><ul>
                    <li><xsl:text> Autore: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:author" /></li>
                    <li>
                        <xsl:text> Titolo: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:series/tei:title" />
                    </li>
                    <xsl:if test="count(//tei:idno)!=0"> <!-- Se è indicato l'identificatore della registrazione, allora viene restituito -->
                        <li>
                            <xsl:text> Identificatore: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:series/tei:idno" />
                        </li>
                    </xsl:if>
                    <li><xsl:text> Fonti:</xsl:text>
                        <xsl:for-each select="//tei:broadcast"> <!-- Elemento che restituisce una lista di link dai quali poter vedere e ascoltare le interviste online -->
                            <a><xsl:attribute name="href"><xsl:value-of select="./tei:bibl/@source"/></xsl:attribute>
                                <xsl:text> File </xsl:text><xsl:value-of select="position()" /></a>
                                 <xsl:if test="position() != last()">
                                 <xsl:text>, </xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </li>
                </ul></td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//tei:profileDesc"> <!-- Template che agli elementi XML figli di profileDesc applica delle regole di trasformazione: questo modello viene applicato RICORSIVAMENTE quando trova corrispondenza con il pattern dell'attributo "select" di <xsl:apply-templates> -->
    <br/>
    <table>
            <xsl:for-each select="//tei:listPerson/tei:person">
            <tr>
                <th><xsl:text> Partecipante:</xsl:text></th> <td> <xsl:value-of select="./tei:persName" /> </td>
            </tr>
            </xsl:for-each>
            
            <tr>
                <th><xsl:text> Linguaggi:</xsl:text></th>
                <td>
                <xsl:for-each select="//tei:langUsage/tei:language">
                    <xsl:value-of select="." /> 
                    <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
                </td>
            </tr>
        </table>
        <br/>

    <!-- GESTIONE DELLA SEZIONE RIASSUNTIVA DELLE PAGINE DEDICATE ALLE TESTIMONIANZE -->

        <h2 id="h2rias">Riassunto</h2>
        <table id="riassunto">
        
        <!-- Gestione di tutte le timeline relative al regesto, il quale id inizia proprio con la stringa "TL1" -->
        <xsl:for-each select="//tei:timeline[contains(@xml:id,'TL1')]">
        <tr><th><xsl:text>File </xsl:text><xsl:value-of select="position()"/></th></tr>
        <td><xsl:for-each select="./tei:when"> <!-- Di ogni when vengono memorizzate in due variabili l'elemento corrente e l'id dell'elemento corrente -->
        <xsl:variable name="xmlWhen" select="@xml:id"/>
        <xsl:variable name="When" select="."/>
            <xsl:for-each select="//tei:item"> <!-- Per ogni item viene verificato che la stringa che segue "#" nell'attributo synch è uguale all'id del when corrente -->
                <xsl:if test="substring-after(./@synch,'#') = $xmlWhen">
                <p><b><xsl:text>Minuto </xsl:text>
                <xsl:value-of select="$When/@absolute"/> <!-- Viene restituito il minuto assoluto dell'elemento when corrente -->
                </b><br/>
                <xsl:choose>
                    <!-- Se l'item è frammentato e un argomento viene trattato in due item vicini, allora viene restituito il contenuto dell'item ma viene evidenziata l'interruzione -->
                    <xsl:when test=".[contains(@synch,'a')]">
                        <xsl:apply-templates/><i><xsl:text>[Continua nel file successivo]</xsl:text></i>
                    </xsl:when> 
                    <xsl:when test=".[contains(@synch,'b')]">
                        <i><xsl:text>[Continuo del file precedente]</xsl:text></i><xsl:apply-templates/>
                    </xsl:when> 
                    <!-- Altrimenti viene restituito immediatamente il contenuto dell'item corrente -->
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                </xsl:choose>
                </p>
                </xsl:if> 
            </xsl:for-each>
        </xsl:for-each></td>
        </xsl:for-each>
        </table>
    </xsl:template>

    <!-- GESTIONE DELLA SEZIONE "TRASCRIZIONE" DELLE PAGINE DEDICATE ALLE TESTIMONIANZE -->

    <xsl:template match="//tei:text" > <!-- Template che agli elementi XML figli di text applica delle regole di trasformazione: questo modello viene applicato RICORSIVAMENTE quando trova corrispondenza con il pattern dell'attributo "select" di <xsl:apply-templates> -->
    <br/>  
        <h2 id="h2tra">Trascrizione</h2>

        <!-- BOTTONI CHE SE CLICCATI DANNO ACCESSO ALLE VARIE SEZIONI DI INDAGINE -->
        
        <div id="bottoni">
        <button id="information" onclick="infoB()" class="cerca"> informatività </button>
        <button id="indaga" onclick="searchB()" class="cerca"> indaga il testo </button>
        <button id="vocal" onclick="speechB()" class="cerca"> fenomeni del parlato </button>
        <button id="minuti" onclick="minutiB()" class="cerca"> mostra i minuti </button>
        <button id="terms" onclick="glosseB()" class="cerca"> termini e glosse </button>
        <button id="trad" onclick="tradB()" class="cerca"> traduzioni </button>
        <button id="download" onclick="download()" class="cerca"> download </button>
        <button id="indietro" class="cerca" onclick="indietro()" style="display:none"> originale </button>
        <div id="leg"><h3><xsl:text>Legenda </xsl:text></h3> <!-- Legenda iniziale -->
            <span><xsl:text>- fenomeni non pertinenti, &#171;testo riportato&#187; e
            &#10077;traduzioni&#10078;</xsl:text></span>
        </div><br/>
        </div>
        <div id="legenda" style="display:none"></div> <!-- Seconda legenda resa inizialmente invisibile -->
        <div id="trascrizione"> <!-- DIV che contiene il testo unitario della testimonianza, alla quale l'utente ha avuto accesso cliccando uno dei due riquadri a sinistra nella Home Page -->
            <xsl:for-each select="//tei:div[@type='testo']"> <!-- Le interviste si compogono di più file, quindi la sezione è divisa in più parti all'interno delle quali è presentato il testo della testimonianza presente in tale file -->
            <h3><xsl:text>File </xsl:text><xsl:value-of select="position()"/></h3>
                <xsl:apply-templates/> <!-- L'elemento <xsl:apply-templates> applica un modello all'elemento corrente text e ai suoi elementi figli -->
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- GESTIONE DELLA LEGENDA di "INFORMATIVITà", il quale contenuto viene generato quando l'utente clicca sull'elemento HTML con id "information" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='information']">
        <xsl:result-document href="#legenda" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "legenda" -->
            <h3><xsl:text>Legenda</xsl:text></h3>
                <span><xsl:text>- fenomeni non pertinenti</xsl:text></span><br/>
                <span><xsl:text>&#171;testo riportato&#187;</xsl:text></span><br/>
                <span><xsl:text>&#10077;traduzioni&#10078;</xsl:text></span><br/>
                <span class="org"><xsl:text>Istituzioni</xsl:text></span><br/>
                <span class="pers"><xsl:text>Individui</xsl:text></span><br/>
                <span class="place"><xsl:text>Luoghi</xsl:text></span><br/>
                <span class="rif"><xsl:text>Riferimenti indiretti</xsl:text></span><br/>
                <span class="agg2"><xsl:text>Integrazioni</xsl:text></span><br/>
                <span class="mes"><xsl:text>Misure</xsl:text></span><br/>
                <span class="date"><xsl:text>Date [specificazione]</xsl:text></span><br/>
                <span class="time"><xsl:text>Orari [specificazione]</xsl:text></span><br/>
                <br/><b><xsl:text>Cliccando sugli individui, sui luoghi e sui riferimenti indiretti puoi avere maggiori informazioni</xsl:text></b>
        </xsl:result-document>
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- GESTIONE DELLA LEGENDA di "INDAGA", il quale contenuto viene generato quando l'utente clicca sull'elemento HTML con id "indaga" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='indaga']"> 
        <xsl:result-document href="#legenda" method="ixsl:replace-content"> <!-- Sostituzione del contenuto dell'elemento HTML con id "legenda" -->
            <h3><xsl:text>Legenda</xsl:text></h3>
                <span><xsl:text>- fenomeni non pertinenti</xsl:text></span><br/>
                <span><xsl:text>&#171;testo riportato&#187;</xsl:text></span><br/>
                <span><xsl:text>&#10077;traduzioni&#10078;</xsl:text></span><br/>
                <b><xsl:text>*porzione mancante/omessa*</xsl:text></b><br/>
                <span class="unc"><xsl:text>Testo non certo</xsl:text></span><br/>
                <span class="soC"><xsl:text>Parole discostate</xsl:text></span><br/>
                <span class="men"><xsl:text>Menzioni</xsl:text></span><br/>
                <span class="agg"><xsl:text>Parole aggiunte</xsl:text></span><br/>
                <span class="sup"><xsl:text>Parole non necessarie</xsl:text></span><br/>
                <span class="bold"><xsl:text>Parole in tedesco</xsl:text></span><br/>
                <span class="yi"><xsl:text>Parole in yiddish</xsl:text></span><br/>
                <span class="fr"><xsl:text>Parole in francese</xsl:text></span><br/>
                <span class="en"><xsl:text>Parole in inglese</xsl:text></span><br/>
                <span class="rus"><xsl:text>Parole in russo</xsl:text></span><br/>
                <span class="lat"><xsl:text>Parole in latino</xsl:text></span><br/>
                <span class="informali"><xsl:text>Parole informali</xsl:text></span><br/>
                <span class="politiche"><xsl:text>Parole politiche</xsl:text></span><br/>
                <span class="military"><xsl:text>Parole militari</xsl:text></span><br/>
                <span class="alterate"><xsl:text>Parole alterate</xsl:text></span><br/>
                <span class="mdd"><xsl:text>Modi di dire</xsl:text></span><br/>
                <span class="tec"><xsl:text>Parole tecniche</xsl:text></span><br/>
                <span class="fos"><xsl:text>Figure retoriche</xsl:text></span><br/>
                <span class="infre"><xsl:text>Parole infrequenti</xsl:text></span><br/>
                <span class="volgari"><xsl:text>Parole non eleganti</xsl:text></span><br/>
                <span class="arc"><xsl:text>Parole arcaiche</xsl:text></span><br/>
                <span class="slang"><xsl:text>Parole gergali</xsl:text></span><br/>
                <span class="dia"><xsl:text>Parole dialettali</xsl:text></span>
                <select><option><xsl:text>Abbreviazione</xsl:text></option><option><xsl:text>Estensione</xsl:text></option></select>
                <select><option><xsl:text>&#10060; Errore</xsl:text></option><option><xsl:text>&#128994; Correzione</xsl:text></option></select>
                <select><option><xsl:text>&#191; Non standard</xsl:text></option><option><xsl:text>&#128994; Normalizzazione</xsl:text></option></select>
        </xsl:result-document>
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- GESTIONE DELLA LEGENDA di "FENOMENI DEL PARLATO", il quale contenuto viene generato quando l'utente clicca sull'elemento HTML con id "vocal" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='vocal']">
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
            <h3><xsl:text>Legenda</xsl:text></h3>
                <span><xsl:text>- fenomeni non pertinenti</xsl:text></span><br/>
                <span><xsl:text>&#171;testo riportato&#187;</xsl:text></span><br/>
                <span><xsl:text>&#10077;traduzioni&#10078;</xsl:text></span><br/>
                <span class="sovrap"><xsl:text>&#8249;</xsl:text></span><xsl:text>sovrapposizioni</xsl:text><span class="sovrap"><xsl:text>&#8250;</xsl:text></span><br/>
                <span class="del"><xsl:text>Ripensamenti, ripetizioni e parole troncate</xsl:text></span><br/>
                <span class="tono"><xsl:text>Cambiamenti di tono</xsl:text></span><br/>
                <span class="emph"><xsl:text>Porzioni enfatizzate</xsl:text></span><br/>
                <span class="vocals"><xsl:text>Fenomeni vocali</xsl:text></span><br/>
                <span class="gesti"><xsl:text>(Descrizione dei gesti)</xsl:text></span><br/>
                <span class="rum"><xsl:text>(Rumori accidentali)</xsl:text></span><br/>
                <b><span><xsl:text>Pausa</xsl:text> <img src="pausa.png" style="margin-bottom:-3%" class="imgp"/></span></b><br/>
        </xsl:result-document>
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- GESTIONE DEL BOTTONE "minuti" dopo che l'utente clicca sull'elemento HTML con id "minuti" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='minuti']">
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- GESTIONE DEL BOTTONE "terms" dopo che l'utente clicca sull'elemento HTML con id "terms" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='terms']">
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- GESTIONE DEL BOTTONE "trad" dopo che l'utente clicca sull'elemento HTML con id "trad" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='trad']">
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- GESTIONE DEL BOTTONE "download" dopo che l'utente clicca sull'elemento HTML con id "download" -->
    <xsl:template mode="ixsl:onclick" match="h:button[@id='download']">
        <ixsl:schedule-action wait="2000"> <!-- Istruzione estesa di Saxon-JS che attende un tempo specificato definito dal suo attributo wait ed effettua una chiamata asincrona al modello denominato in un'istruzione xsl:call-template. L’attributo facoltativo wait è un’espressione XPath utilizzata per specificare il ritardo in millisecondi prima che venga chiamato il template in xsl:call-template  -->
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/> <!-- Viene impostasta una proprietà di stile all'elemento HTML corrente, ovvero al bottone, che diventa nero -->
    </xsl:template>

    <!-- Template invocato con i vari <ixsl:schedule-action> -->
    <xsl:template name="black">
        <ixsl:set-style name="backgroundColor" select="'rgb(179,0,0)'"/> <!-- Il template invocato dentro ixsl:schedule-action imposta un'altra proprietà di stile del bottone che diventa di nuovo rosso -->
    </xsl:template>

    <!-- GESTIONE DEGLI ENUNCIATI PRODOTTI DAI PARLANTI -->
    <xsl:template match="//tei:u">        
                    <xsl:choose>
                    <!-- Gestione degli enunciati che si sovrappongono -->
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#AW']">
                        <p><b><xsl:text>(Arminio W. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#LPF']">
                        <p><b><xsl:text>(Liliana P.F. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#MA']">
                        <p><b><xsl:text>(Maurina A. sovrapposizione): </xsl:text></b><xsl:apply-templates /></p>
                    </xsl:when>
                    <!-- Gestione degli enunciati non sovrapposti -->
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

    <!-- TEMPLATE PER GLI ALTRI ELEMENTI XML FIGLI DI TEXT -->

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

    <!-- Gestione delle lacune o delle parti oscurate -->
    <xsl:template match="//tei:gap" >
        <xsl:if test="..[not(@xml:id)] and normalize-space(..)=''">
            <xsl:text>-</xsl:text>
        </xsl:if>
    </xsl:template>
  
    <!-- Gestione del resto degli elementi XML che vengono nascosti nella trascrizione -->
    <xsl:template match="//tei:desc" />
    <xsl:template match="//tei:vocal"/>
    <xsl:template match="//tei:sic"/>
    <xsl:template match="//tei:orig" />
    <xsl:template match="//tei:abbr" />
    <xsl:template match="//tei:surplus" />
    <xsl:template match="//tei:del" />
    <xsl:template match="//tei:supplied[@reason='integration']" />

</xsl:stylesheet>