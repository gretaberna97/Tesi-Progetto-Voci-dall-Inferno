<?xml version="1.0" encoding="utf-8"?>
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

<xsl:output method="html" html-version="5" encoding="utf-8" indent="no"/>

    <xsl:template name="main" match="/">
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
        <img id="menuimg" src="menu.png" alt="Icona menu" onclick="openNav()"/>
            <div id="mySidenav" class="sidenav">
                <img id="home" src="home.png" alt="Icona home"/><br/>
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <a href="#h2inf" id="info">Informazioni</a><br/>
                <a href="#h2rias" id="rias">Riassunto</a><br/>
                <a href="#h2tra" id="tras">Trascrizione</a><br/> 
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:fileDesc" />
            <xsl:apply-templates select="//tei:profileDesc" />
        </xsl:result-document>
        <xsl:result-document href="#Testo" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:text" />
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content"><br/>
            <p>Edizione digitale delle testimonianze di</p><span>Arminio Wachsberger</span>
            <p>Realizzata da Greta Bernardoni per il progetto <span>Voci dall'Inferno</span></p><br/>
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
            Torna Su
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:img[@id='home']" >
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
            <button id="TestOne" onclick="testOne()">4 Febbraio 1998</button>
            <button id="TestTwo" onclick="testTwo()">18 Febbraio 1987</button>
            <button id="PeopleBut" onclick="peopleB()">Persone citate</button> 
            <button id="PlaceBut" onclick="placeB()">Luoghi citati</button>
            <button id="FontiBut" onclick="fontiB()">Fonti di ausilio</button>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#Testo" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:apply-templates select="h:div[@id='Info']|h:div[@id='Testo']|h:header[@id='Header']|h:footer[@id='footer']"/><!--non funziona(sotto)-->
    </xsl:template>

    <!--non funziona:serve per rimandare indietro il margine + header non torna indietro-->
    <xsl:template match="h:div[@id='Info']|h:div[@id='Testo']|h:header[@id='Header']|h:footer[@id='footer']">
        <xsl:if test="ixsl:style(.)?margin-left = '20%'">
            <ixsl:set-style name="marginLeft" select="'0%'"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:fileDesc">
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
            <tr>
                <th><xsl:text> Data:</xsl:text></th> <td> <xsl:value-of select="//tei:recordingStmt/tei:recording[1]/tei:date" /> </td>
            </tr>
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
                    <xsl:when test="contains(.,'H')">
                        <xsl:value-of select="substring-before(substring-after(.,'PT'), 'H')"/><xsl:text> ora </xsl:text>
                        <xsl:value-of select="substring-before(substring-after(.,'H'), 'M')"/><xsl:text> minuti e </xsl:text>
                        <xsl:value-of select="substring-before(substring-after(.,'M'), 'S')"/><xsl:text> secondi</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
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
                <xsl:if test="not(normalize-space(tei:p)='')">
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
                    <xsl:if test="count(//tei:idno)!=0">
                        <li>
                            <xsl:text> Identificatore: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:series/tei:idno" />
                        </li>
                    </xsl:if>
                    <li><xsl:text> Fonti:</xsl:text>
                        <xsl:for-each select="//tei:broadcast">
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

    <xsl:template match="//tei:profileDesc">
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
        <h2 id="h2rias">Riassunto</h2>
        <table id="riassunto">
        
        <xsl:for-each select="//tei:timeline[contains(@xml:id,'TL1')]">
        <tr><th><xsl:text>File </xsl:text><xsl:value-of select="position()"/></th></tr>
        <td><xsl:for-each select="./tei:when">
        <xsl:variable name="xmlWhen" select="@xml:id"/>
        <xsl:variable name="When" select="."/>
            <xsl:for-each select="//tei:item">
                <xsl:variable name="pos" select="position()"/>
                <xsl:if test="substring-after(./@synch,'#') = $xmlWhen">
                <b><xsl:text>Minuto </xsl:text>
                <xsl:value-of select="$When/@absolute"/>
                </b><br/>
                <xsl:choose>
                    <xsl:when test=".[contains(@synch,'a')]">
                        <xsl:apply-templates/><i><xsl:text>[Continua nel file successivo]</xsl:text></i><br/><br/>
                    </xsl:when> 
                    <xsl:when test=".[contains(@synch,'b')]">
                        <i><xsl:text>[Continuo del file precedente]</xsl:text></i><xsl:apply-templates/><br/><br/>
                    </xsl:when> 
                    <xsl:otherwise><xsl:apply-templates/><br/><br/></xsl:otherwise>
                </xsl:choose>
                </xsl:if> 
            </xsl:for-each>
        </xsl:for-each></td>
        </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="//tei:text" >
    <br/>  
        <h2 id="h2tra">Trascrizione</h2>
        <button id="indaga" onclick="closeNav2()"> lessico </button>
        <button id="vocal" onclick="closeNav3()"> fenomeni vocali </button>
        <button id="minuti" onclick="closeNav4()"> mostra minuti </button>
        <div id="legenda"></div>
        <div id="trascrizione">
            <xsl:for-each select="//tei:div[@type='testo']">
            <h3><xsl:text>File </xsl:text><xsl:value-of select="position()"/></h3>
                <xsl:apply-templates/>
            </xsl:for-each>
        </div>
        <button onclick="download()"> download </button>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:button[@id='indaga']">
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
            <h3><xsl:text>Legenda</xsl:text></h3>
                <!--<span class="bold"><xsl:text>Le parole in arancio sono le glosse e i relativi termini tedeschi del Lager utilizzati</xsl:text></p>-->
                <span class="agg"><xsl:text>Parole aggiunte</xsl:text></span><br/>
                <span class="sup"><xsl:text>Parole non necessarie</xsl:text></span><br/>
                <span class="bold"><xsl:text>Parole in lingua tedesca</xsl:text></span><br/>
                <span class="yi"><xsl:text>Parole in lingua yiddish</xsl:text></span><br/>
                <span class="fr"><xsl:text>Parole in lingua francese</xsl:text></span><br/>
                <span class="en"><xsl:text>Parole in lingua inglese</xsl:text></span><br/>
                <span class="rus"><xsl:text>Parole in lingua russa</xsl:text></span><br/>
                <span class="lat"><xsl:text>Parole in lingua latina</xsl:text></span><br/>
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
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#indaga" method="ixsl:replace-content">
                <img id="home" src="home.png" alt="Icona home"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:button[@id='vocal']">
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
            <h3><xsl:text>Legenda</xsl:text></h3>
                <span class="del"><xsl:text>Ripensamenti</xsl:text></span><br/>
                <span class="emph"><xsl:text>Porzioni enfatizzate</xsl:text></span><br/>
                <span class="vocals"><xsl:text>Fenomeni vocali</xsl:text></span><br/>
                <span class="gesti"><xsl:text>Descrizione dei gesti</xsl:text></span><br/>
                <span class="rum"><xsl:text>Rumori accidentali</xsl:text></span><br/>
                <b><span><xsl:text>I tre puntini indicano le pause</xsl:text></span></b><br/>
        </xsl:result-document>
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#vocal" method="ixsl:replace-content">
                <img id="home" src="home.png" alt="Icona home"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:button[@id='minuti']">
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#minuti" method="ixsl:replace-content">
                <img id="home" src="home.png" alt="Icona home"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:u">
                <xsl:choose>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who]">
                        <b><xsl:text>(SOVRAPPOSIZIONE): </xsl:text></b><xsl:apply-templates /><br />
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
                    <xsl:otherwise>
                        <b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:otherwise>
                </xsl:choose>
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
  
    <xsl:template match="//tei:sic"/>
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />
    
    <xsl:template match="//tei:del" />

</xsl:stylesheet>