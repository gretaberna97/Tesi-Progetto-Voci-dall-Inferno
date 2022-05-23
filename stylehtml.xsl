<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
 	xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="ixsl saxon">

<xsl:output method="html" html-version="5" encoding="utf-8" indent="no"/>

    <xsl:template name="main" match="/">
        <xsl:result-document href="#Info" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:fileDesc" />
            <xsl:apply-templates select="//tei:encodingDesc" />
            <xsl:apply-templates select="//tei:profileDesc" />
            <!--<xsl:apply-templates select="//tei:standOff" />-->
        </xsl:result-document>
        <xsl:result-document href="#Testo" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:text" />
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:fileDesc">
            <h1>
                <xsl:value-of select="tei:titleStmt/tei:title" />
            </h1>
        <table> 
            <tr>
                <th><xsl:text>Edition:</xsl:text></th> <td><xsl:value-of select="//tei:edition" /></td>
            </tr>
            <tr>
                <th><xsl:value-of select="tei:editionStmt/tei:respStmt/tei:resp" /> :</th> <td> <xsl:value-of select="tei:editionStmt/tei:respStmt/tei:name" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Publisher:</xsl:text></th> <td> <xsl:value-of select="tei:publicationStmt" /> </td>
            </tr>         
            <tr>
                <th><xsl:text> Date:</xsl:text></th> <td> <xsl:value-of select="//tei:recordingStmt/tei:recording[1]/tei:date" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Type of record : </xsl:text></th><td><xsl:value-of select="//tei:recordingStmt/tei:recording[1]/@type" /></td>
            </tr>
            <xsl:for-each select="//tei:recordingStmt/tei:recording[1]/tei:respStmt">
                <tr>
                    <th><xsl:value-of select="./tei:resp" />:</th> <td> <xsl:value-of select="./tei:name" /> </td>
                </tr>
            </xsl:for-each>
            <tr>
                <th><xsl:text> Number of records: </xsl:text></th> <td><xsl:value-of select="count(//tei:recordingStmt/tei:recording)" /><xsl:text> della durata di: </xsl:text>
                <xsl:for-each select="//tei:recordingStmt/tei:recording/@dur"><!--sistemo con if-->
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
                        <th><xsl:text> Record equipment number </xsl:text><xsl:value-of select="position()" /> :</th> 
                        <td><xsl:value-of select="." /></td>
                    </tr>
                </xsl:if>
            </xsl:for-each>
            <tr>
                <th><xsl:text> Note: </xsl:text></th><td><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:note" /></td>
            </tr>
            <tr>
                <th><xsl:text> Broadcast : </xsl:text></th>
                <td><ul>
                    <li><xsl:text> Author: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:author" /></li>
                    <!--<xsl:if test="not(normalize-space(//tei:bibl/tei:date)='')">
                        <li><xsl:text> Date: </xsl:text><xsl:value-of select="//tei:bibl/tei:date" /></li>
                    </xsl:if>-->
                    <li>
                        <xsl:choose>
                            <xsl:when test="count(//tei:broadcast//tei:title)=1">
                                <xsl:text> Title: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:bibl/tei:title" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> Title: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:series/tei:title" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    <xsl:if test="count(//tei:idno)!=0">
                        <li>
                            <xsl:text> Identifier: </xsl:text><xsl:value-of select="//tei:recordingStmt/tei:recording[1]//tei:series/tei:idno" />
                        </li>
                    </xsl:if>
                    <li><xsl:text> Source: </xsl:text>
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

        <br />
        <xsl:for-each select="//tei:profileDesc//tei:listPerson/tei:person">
            <tr>
                <th><xsl:text> Person:</xsl:text></th> <td> <xsl:value-of select="tei:persName" /> </td>
            </tr>
        </xsl:for-each>
        </table>

        <table>
            <br />
            <tr>
                <th><xsl:text> Language:</xsl:text></th>
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
    </xsl:template>

    <xsl:template match="//tei:abstract" />

    <!--<xsl:template match="//tei:standOff">
        <br />
        <table>
        <tr>
        <th><xsl:text> Percentage of speakers:</xsl:text></th>
        <td>
        CODICE CHE NON FUNZIONA
        <xsl:for-each select=".//tei:timeline[@xml:id='TL3I']">VORREI CALCOLARE LA PERCENTUALE DEI PARLANTI MA NON RIESCO A SOMMARE I NUMERI I VALORI (SUM NON è SUPPORTATA
            <xsl:for-each select="./tei:when/following-sibling::tei:when[contains(@synch,'#AW')]/@absolute">
                    <xsl:value-of select="substring-after(., '00:00:')"/>   
                    <xsl:value-of select="substring-after(., '00:01:')" />
                    <xsl:value-of select="substring-after(., '00:02:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:03:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:04:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:05:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:06:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:07:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:08:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:09:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:10:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:11:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:12:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:13:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:14:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:15:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:16:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:17:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:18:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:19:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:20:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:21:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:22:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:23:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:24:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:25:')" /><xsl:text> </xsl:text>
                    <xsl:value-of select="substring-after(., '00:26:')" /><xsl:text> </xsl:text>
            </xsl:for-each>
        </xsl:for-each>
        </td>
        </tr>
        </table>
    </xsl:template>-->

    <xsl:template match="//tei:text" >
    <!-- RESTITUISCE PERSONE E LUOGHI CITATI MA RIPETUTI - PROBABILMENTE NON HA SENSO METTERLO PERCHE' NON HO STILATO UNA LISTA NEL FOGLIO XML CORRENTE MA IN UNO ESTERNO -->
        <table>
            <br />
            <tr>
                <th><xsl:text> People cited:</xsl:text></th> 
                <td>
                <xsl:for-each select=".//tei:persName[1][not(@ref=../preceding-sibling::*/tei:persName/@ref)]">
                    <xsl:value-of select="." /> 
                    <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
                </td>
            </tr>
            <xsl:if test=".//tei:placeName">
            <tr>
                <th><xsl:text> Places mentioned:</xsl:text></th>
                    <td>
                    <xsl:for-each select=".//tei:placeName[1][not(@ref=../preceding-sibling::*/tei:placeName/@ref)]">
                        <xsl:value-of select="." /> 
                        <xsl:if test="position() != last()">
                        <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    </td>
            </tr>
            </xsl:if>
        </table>
        <!-- FINE CODICE NON FUNZIONANTE-->
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
        
        <table>
            <tr>
                <th><xsl:text> Trascrizione:</xsl:text></th>
            </tr>
            <td>
            <xsl:apply-templates />
            </td>
            <br /> 
            <tr> 
            <td>
            <button onclick="download()"> download </button>
            </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//tei:div[@type='testo']">
        <b><xsl:text>Inizio registrazione</xsl:text></b><br /><xsl:apply-templates />
    </xsl:template>

</xsl:stylesheet>