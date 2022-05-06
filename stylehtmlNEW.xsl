<?xml version="1.0" encoding="UTF-8"?><!--nuovo-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"><!--versione 3-->

    <xsl:output method="html" indent="yes"/><!--nuovo ma da togliere-->

    <xsl:template name="main" match="/">
        <html>
        <head>
        <link href="styleNEW.css" rel="stylesheet" type="text/css" media="screen"/><!--nuovo ma da togliere-->
        <script src="App.js"></script><!--nuovo ma da togliere-->
        </head>
        <body>
        <!--<xsl:result-document href="#Info">-->
            <xsl:apply-templates select="//tei:fileDesc" />
            <xsl:apply-templates select="//tei:encodingDesc" />
            <xsl:apply-templates select="//tei:profileDesc" />
        <!--</xsl:result-document>
        <xsl:result-document href="#Testo">-->
            <xsl:apply-templates select="//tei:text" />
        <!--</xsl:result-document>-->
        </body>
        </html>
    </xsl:template>

    <xsl:template match="//tei:fileDesc">
            <h1>
                <xsl:value-of select="tei:titleStmt/tei:title" />
            </h1>
        <table> 
            <xsl:if test="tei:titleStmt/tei:respStmt">
                <xsl:for-each select="tei:titleStmt/tei:respStmt">
                <tr>
                    <th><xsl:value-of select="./tei:resp" /> : </th>                
                    <td><xsl:value-of select="./tei:name" /> </td>
                </tr>
                </xsl:for-each>
            </xsl:if>
            <tr>
                <th><xsl:text>Edition:</xsl:text></th> <td><xsl:value-of select="//tei:edition" /></td>
            </tr>
            <tr>
                <th><xsl:value-of select="tei:editionStmt/tei:respStmt/tei:resp" /> :</th> <td> <xsl:value-of select="tei:editionStmt/tei:respStmt/tei:name" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Publisher:</xsl:text></th> <td> <xsl:value-of select="tei:publicationStmt" /> </td>
            </tr>
            
                <xsl:apply-templates select="//tei:msIdentifier" />
                <xsl:apply-templates select="//tei:supportDesc" />
                <xsl:apply-templates select="//tei:handDesc" />
                <xsl:apply-templates select="//tei:additional" />
                <xsl:apply-templates select="//tei:sourceDesc" />
        </table>
    </xsl:template>

    <xsl:template match="//tei:msIdentifier">
            <tr>
                <th><xsl:text> Repository:</xsl:text></th> <td> <xsl:value-of select="tei:repository" /> </td>
            </tr>
             <tr>
                <th><xsl:text> Collection:</xsl:text></th> <td> <xsl:value-of select="tei:collection" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Identifier:</xsl:text></th> <td> <xsl:value-of select="tei:idno" /> </td>
            </tr>
    </xsl:template>   

    <xsl:template match="//tei:supportDesc">
            <tr>
                <th><xsl:text> Support:</xsl:text></th> <td> <xsl:value-of select="tei:support/tei:objectType" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Measure:</xsl:text></th> <td> <xsl:value-of select="tei:extent/tei:measure" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Condition:</xsl:text></th> <td> <xsl:value-of select="tei:condition" /> </td>
            </tr>
    </xsl:template>

    <xsl:template match="//tei:handDesc">
            <tr>
                <th><xsl:text> Note:</xsl:text></th>
                <td>
                <xsl:for-each select="tei:handNote">
                    <xsl:value-of select="." /> <br />
                </xsl:for-each>
                </td>
            </tr>  
    </xsl:template>

    <xsl:template match="//tei:additional" >
            <tr>
                <th><xsl:text> Licenza:</xsl:text></th> <td> <xsl:value-of select="." /> </td>
            </tr>
    </xsl:template>

    <xsl:template match="//tei:sourceDesc">
        <xsl:for-each select="tei:listPerson/tei:person">
            <tr>
                <th><xsl:text> Person:</xsl:text></th> <td> <xsl:value-of select="tei:persName" /> </td>
                <th><xsl:text> Sex:</xsl:text></th> <td> <xsl:value-of select="tei:sex" /> </td>
                <th><xsl:text> Birth:</xsl:text></th> <td> <xsl:value-of select="tei:birth" /> </td>
            </tr>
                 
            <tr>
                <th><xsl:text> Event:</xsl:text></th>
                <xsl:for-each select="tei:event | tei:listEvent/tei:event"> 
                <td><xsl:value-of select="./@from | ./@when" /> <xsl:value-of select="./@to" /> <br /> <xsl:value-of select="tei:label" /> (<xsl:value-of select="tei:desc" />) <br /> </td>
                </xsl:for-each>
            </tr>
            </xsl:for-each>
            <br /> <br /> <br /> <br />
            <xsl:for-each select="tei:listPlace/tei:place">
            <tr>
                <th><xsl:text> Place:</xsl:text></th> <td> <xsl:value-of select="tei:placeName" /> (<xsl:value-of select="tei:desc" />) </td>
                <th><xsl:text> Location:</xsl:text></th> <td> <xsl:value-of select="tei:location" /> </td>
            </tr>
        </xsl:for-each>

        <xsl:for-each select="tei:recordingStmt">
            <tr>
                <th><xsl:text> Date:</xsl:text></th> <td> <xsl:value-of select="//tei:date" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Type of record : </xsl:text></th><td><xsl:value-of select="//@type" /></td>
            </tr>
            <xsl:for-each select="./tei:recording[1]/tei:respStmt">
                <tr>
                    <th><xsl:value-of select="./tei:resp" />:</th> <td> <xsl:value-of select="./tei:name" /> </td>
                </tr>
            </xsl:for-each>
            <tr>
                <th><xsl:text> Number of records: </xsl:text></th> <td><xsl:value-of select="count(./tei:recording)" /><xsl:text> della durata di: </xsl:text>
                <xsl:for-each select="./tei:recording/@dur">
                    <xsl:value-of select="."/><!--da sistemare per il formato-->
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
                <th><xsl:text> Note: </xsl:text></th><td><xsl:value-of select="//tei:note" /></td>
            </tr>
            <tr>
                <th><xsl:text> Broadcast : </xsl:text></th>
                <td><ul>
                    <li><xsl:text> Author: </xsl:text><xsl:value-of select="//tei:author" /></li>
                    <xsl:if test="not(normalize-space(//tei:bibl/tei:date)='')">
                        <li><xsl:text> Date: </xsl:text><xsl:value-of select="//tei:bibl/tei:date" /></li>
                    </xsl:if>
                    <li>
                        <xsl:choose>
                            <xsl:when test="count(//tei:broadcast//tei:title)=1">
                                <xsl:text> Title: </xsl:text><xsl:value-of select="//tei:bibl/tei:title" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> Title: </xsl:text><xsl:value-of select="//tei:series/tei:title" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    <xsl:if test="count(//tei:idno)!=0">
                        <li>
                            <xsl:text> Identifier: </xsl:text><xsl:value-of select="//tei:series/tei:idno" />
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
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="//tei:profileDesc">
        <br />
        <table>
        <xsl:for-each select="//tei:profileDesc//tei:listPerson/tei:person">
            <tr>
            <xsl:if test="not(normalize-space(.//tei:forename|.//tei:surname)='')">
                <th><xsl:text> Person:</xsl:text></th> <td> <xsl:value-of select="tei:persName" /> </td>
            </xsl:if>
            </tr>
        </xsl:for-each>
        </table>

        <table>
            <br />
            <xsl:if test="count(tei:creation)=1">
                <tr>
                    <th><xsl:text> Creation:</xsl:text></th> <td> <xsl:value-of select="tei:creation" /> </td>
                </tr>
            </xsl:if>   
            <tr>
                <th><xsl:text> Language:</xsl:text></th>
                <td>
                <xsl:for-each select="tei:langUsage/tei:language">
                    <xsl:value-of select="." /> 
                    <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//tei:text" >

            <button onclick="more(this)"> legenda </button>
            <div class="legenda" style="display:none">
            <xsl:if test='//tei:text//tei:u'><br/>
            <p><xsl:text>Le frecce possono essere cliccate e indicano i fenomeni comunicativi</xsl:text></p>
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
            <button onclick="send()"> send </button>
            </td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>