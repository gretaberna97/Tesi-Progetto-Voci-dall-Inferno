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
                <a href="#h2inf" id="info" onclick="closeNav()">Informazioni</a><br/>
                <a href="#h2rias" id="rias" onclick="closeNav()">Riassunto</a><br/>
                <a href="#h2tra" id="tras" onclick="closeNav()">Trascrizione</a><br/> 
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
            <p>© Edizione digitale delle testimonianze di <span>Arminio Wachsberger</span> realizzata all'interno del progetto <span>Voci dall'Inferno</span></p>
            <p>Progetto di Laurea in Informatica Umanistica a.a 2021/2022</p> <p><span>Greta Bernardoni</span> - mat.564826</p><br/>
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
            <img id="upimg" src="up.png" alt="Icona up"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:img[@id='home']" >
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
            <button id="TestOne" onclick="testOne()">4 Febbraio 1998</button>
            <button id="TestTwo" onclick="testTwo()">18 Febbraio 1987</button>
            <button id="PeopleBut" onclick="peopleB()">Lista persone</button> 
            <button id="PlaceBut" onclick="placeB()">Lista luoghi</button>
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
        <div id="bottoni">
        <button id="information" onclick="closeNav5()" class="cerca"> informatività </button>
        <button id="indaga" onclick="closeNav2()" class="cerca"> indaga il testo </button>
        <button id="vocal" onclick="closeNav3()" class="cerca"> fenomeni parlato </button>
        <button id="minuti" onclick="minuti()" class="cerca"> mostra i minuti </button>
        <button id="terms" onclick="glosse()" class="cerca"> termini e glosse </button>
        <button id="trad" onclick="trad()" class="cerca"> traduzioni </button>
        <button id="download" onclick="download()" class="cerca"> download </button>
        <button id="indietro" class="cerca" onclick="indietro()" style="display:none"> originale </button>
        <div id="leg"><h3><xsl:text>Legenda: </xsl:text></h3> 
        <xsl:text>- fenomeni non pertinenti, &#171;testo riportato&#187; e
        (traduzioni)</xsl:text><br/>
        </div><br/>
        </div>
        <div id="legenda" style="display:none"></div>
        <div id="trascrizione">
            <xsl:for-each select="//tei:div[@type='testo']">
            <h3><xsl:text>File </xsl:text><xsl:value-of select="position()"/></h3>
                <xsl:apply-templates/>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!--
    <xsl:template match="//tei:item//tei:persName|//tei:item//tei:rs[contains(@ref,'Person') and not(contains(@ref,' '))]">
        <a><xsl:attribute name="href"><xsl:value-of select="substring-after(@ref,'xml')"/></xsl:attribute><xsl:attribute name="class">people1</xsl:attribute><xsl:apply-templates/></a>
    </xsl:template>

    <xsl:template match="//tei:item//tei:placeName[@ref]|//tei:item//tei:rs[contains(@ref,'Place')]">
        <a><xsl:attribute name="href"><xsl:value-of select="substring-after(@ref,'xml')"/></xsl:attribute><xsl:attribute name="class">place1</xsl:attribute><xsl:apply-templates/></a>
    </xsl:template>-->

    <xsl:template mode="ixsl:onclick" match="h:button[@id='information']">
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
            <h3><xsl:text>Legenda</xsl:text></h3>
                <xsl:text>- fenomeni non pertinenti</xsl:text><br/>
                <xsl:text>&#171;testo riportato&#187;</xsl:text><br/>
                <xsl:text>(traduzioni)</xsl:text><br/>
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
        <ixsl:schedule-action wait="2000">
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/>
    </xsl:template>

    <xsl:template name="black">
        <ixsl:set-style name="backgroundColor" select="'rgb(179,0,0)'"/>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:button[@id='indaga']">
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
            <h3><xsl:text>Legenda</xsl:text></h3>
                <xsl:text>- fenomeni non pertinenti</xsl:text><br/>
                <xsl:text>&#171;testo riportato&#187;</xsl:text><br/>
                <xsl:text>(traduzioni)</xsl:text><br/>
                <b><xsl:text>*porzione omessa*</xsl:text></b><br/>
                <span class="unc"><xsl:text>Testo non certo</xsl:text></span><br/>
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
        <ixsl:schedule-action wait="2000">
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:button[@id='vocal']">
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
            <h3><xsl:text>Legenda</xsl:text></h3>
                <xsl:text>- fenomeni non pertinenti</xsl:text><br/>
                <xsl:text>&#171;testo riportato&#187;</xsl:text><br/>
                <xsl:text>(traduzioni)</xsl:text><br/>
                <span class="sovrap"><xsl:text>&#8249;</xsl:text></span><xsl:text>sovrapposizioni</xsl:text><span class="sovrap"><xsl:text>&#8250;</xsl:text></span><br/>
                <span class="del"><xsl:text>Ripensamenti, ripetizioni e parole troncate</xsl:text></span><br/>
                <span class="tono"><xsl:text>Cambiamenti di tono</xsl:text></span><br/>
                <span class="emph"><xsl:text>Porzioni enfatizzate</xsl:text></span><br/>
                <span class="vocals"><xsl:text>Fenomeni vocali</xsl:text></span><br/>
                <span class="gesti"><xsl:text>(Descrizione dei gesti)</xsl:text></span><br/>
                <span class="rum"><xsl:text>(Rumori accidentali)</xsl:text></span><br/>
                <b><span><xsl:text>Pausa</xsl:text> <img src="pausa.png" style="margin-bottom:-3%" class="imgp"/></span></b><br/>
        </xsl:result-document>
        <ixsl:schedule-action wait="2000">
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/>
    </xsl:template>

    <xsl:template mode="ixsl:onclick" match="h:button[@id='minuti']">
        <xsl:result-document href="#legenda" method="ixsl:replace-content">
        </xsl:result-document>
        <ixsl:schedule-action wait="2000">
            <xsl:call-template name="black"/>
        </ixsl:schedule-action>
        <ixsl:set-style name="backgroundColor" select="'black'"/>
    </xsl:template>

    <xsl:template match="//tei:u">        
                    <xsl:choose>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#AW']">
                        <b><xsl:text>(Arminio W. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#LPF']">
                        <b><xsl:text>(Liliana P.F. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="self::node()[not(@xml:id)] and self::node()[@who='#MA']">
                        <b><xsl:text>(Maurina A. sovrapposizione): </xsl:text></b><xsl:apply-templates /><br />
                    </xsl:when>
                    <xsl:when test="(./@xml:id='MA81' and ./@synch='#TS163') or (./@xml:id='MA158' and ./@synch='#TS320') or (./@xml:id='MA56' and ./@synch='#TS113')">
                        <b><xsl:text>Maurina Alazraki: </xsl:text></b><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="(./@xml:id='PF3' and ./@synch='#TS193') or (./@xml:id='PF4' and ./@synch='#TS195')">
                        <b><xsl:text>Paolo Favaro: </xsl:text></b><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="./@xml:id='LPF436' and ./@synch='#TS871'">
                        <b><xsl:text>Liliana Picciotto Fargion: </xsl:text></b><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="(./@xml:id='AW96' and ./@synch='#TS194') or (./@xml:id='AW227' and ./@synch='#TS456')">
                        <b><xsl:text>Arminio Wachsberger: </xsl:text></b><xsl:text>-</xsl:text><br />
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

    <xsl:template match="//tei:desc" />
    <xsl:template match="//tei:vocal"/>

    <!--vocal, del desc presenti solo in sovrapposizione-->
    <xsl:template match="//tei:u[not(@xml:id)]/tei:vocal">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]/tei:del">
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:u[not(@xml:id)]//tei:desc" >
        <xsl:text>-</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>

        <xsl:template match="//tei:span[@corresp]">
        <xsl:text>(</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>)</xsl:text>
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

    <xsl:template match="//tei:supplied[@reason='integration']" />

</xsl:stylesheet>