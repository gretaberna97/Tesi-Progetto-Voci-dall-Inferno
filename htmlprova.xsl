<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"><!--versione 3-->

    <xsl:template name="main" match="/">
        <html>
        <head>
        <link href="style.css" rel="stylesheet" type="text/css" media="screen"/><!--nuovo-->
        </head>
        <body> 
        
        <!--<xsl:result-document href="#Info">-->
            <xsl:apply-templates select="//tei:fileDesc" />
            <xsl:apply-templates select="//tei:encodingDesc" />
            <xsl:apply-templates select="//tei:profileDesc" />
        <!--</xsl:result-document>
        <xsl:result-document href="#Testo">-->
            <br /> <br />
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
                <tr>
                    <th><xsl:value-of select="tei:titleStmt/tei:respStmt[1]/tei:resp" /> : </th>                
                    <td><xsl:value-of select="tei:titleStmt/tei:respStmt[1]/tei:name" /> </td>
                </tr>
                <tr>
                    <th><xsl:value-of select="//tei:respStmt[2]/tei:resp" /> : </th> 
                    <td><xsl:value-of select="//tei:respStmt[2]/tei:name" /> </td>
                </tr>
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

            <br /> <br /> <br /> <br />
            
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
					<xsl:text>, </xsl:text>   
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
                            <xsl:text>, </xsl:text>   
                        </xsl:for-each>
                    </li>
                </ul></td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="//tei:profileDesc">
        <br /> <br /> <br /> <br />
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
            <br /> <br /> <br /> <br />
            <xsl:if test="count(tei:creation)=1">
                <tr>
                    <th><xsl:text> Creation:</xsl:text></th> <td> <xsl:value-of select="tei:creation" /> </td>
                </tr>
            </xsl:if>   
            <tr>
                <th><xsl:text> Language:</xsl:text></th>
                <td>
                <xsl:for-each select="tei:langUsage/tei:language">
                    <xsl:value-of select="." /> <br /> 
                </xsl:for-each>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//tei:text" >
        <table>
            <tr>
                <th><xsl:text> Trascrizione:</xsl:text></th>
            </tr>
            <td>
            <xsl:apply-templates />
            </td>
            <br /> <br /> <br />
            <tr> 
            <td>
            <button onclick="send()"> send </button>
            </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//tei:div">
        <br /><xsl:apply-templates />
    </xsl:template>

    <xsl:template match="//tei:sic" />
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:surplus" />

    <xsl:template match="//tei:gap" >
        <xsl:text>LACUNA</xsl:text>
    </xsl:template>

    <xsl:template match="//tei:del[@type!='reformulation']" />

    <xsl:template match="//tei:u">
                <xsl:choose>
                    <xsl:when test="./@who='#MA' or ./@who='#LPF' or ./@who='#INTERVISTATORE' or./@who='#AS'">
                        <xsl:text>INTERVISTATORE: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="./@who='#PF'">
                        <xsl:text>CAMERAMAN: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:when test="./@who='Maria'">
                        <xsl:text>ESTERNO: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>TESTIMONE: -</xsl:text><xsl:apply-templates /><xsl:text>-</xsl:text><br />
                    </xsl:otherwise>
                </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:desc">
        <xsl:choose>
        <xsl:when test="../@who"> <i><xsl:text> (Arminio </xsl:text><xsl:apply-templates /></i><xsl:text>) </xsl:text></xsl:when>
        <xsl:when test="../following-sibling::tei:u"> <xsl:text> (</xsl:text><i><xsl:apply-templates /></i><xsl:text>) </xsl:text><br /></xsl:when>
        <xsl:otherwise><xsl:text> (</xsl:text><i><xsl:apply-templates /></i><xsl:text>) </xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:pause">
        <xsl:choose>
        <xsl:when test="following-sibling::tei:u">  <i><xsl:text>... pausa</xsl:text></i><xsl:apply-templates /><br /></xsl:when>
        <xsl:otherwise><xsl:text> ...</xsl:text><xsl:apply-templates /></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

   <!--<xsl:template match="//tei:shift|//tei:emph">
        <b><xsl:apply-templates /></b>
    </xsl:template>-->

	<xsl:template match="//tei:q">
		<xsl:text>&#171;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#187;</xsl:text>
	</xsl:template>
<!--
	<xsl:template match="//tei:distinct">parole distinte
		<span class="distinct">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

<!-- CODICE GIULIA PER LA TRASCRIZIONE
    <xsl:template match="text()[following::node()[self::text()[normalize-space() != ''] or self::tei:lb][1][self::tei:lb[@break='no']]
    ]">
    <xsl:variable name="normalized" select="normalize-space()"/>
    <xsl:if test="$normalized != ''">
        <xsl:variable name="lastNonSpace"
            select="substring($normalized, string-length($normalized))"/>
        <xsl:variable name="trimmedSuffix">
            <xsl:call-template name="substring-after-last">
                <xsl:with-param name="string" select="."/>
                <xsl:with-param name="delimiter" select="$lastNonSpace"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of
            select="substring(., 1, string-length(.) -
            string-length($trimmedSuffix))"
        />
    </xsl:if>
    </xsl:template>

    <xsl:template name="substring-after-last">
        <xsl:param name="string"/>
        <xsl:param name="delimiter"/>
        <xsl:choose>
            <xsl:when test="contains($string, $delimiter)">
                <xsl:call-template name="substring-after-last">
                    <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
                    <xsl:with-param name="delimiter" select="$delimiter"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
   </xsl:template>
   -->
</xsl:stylesheet>