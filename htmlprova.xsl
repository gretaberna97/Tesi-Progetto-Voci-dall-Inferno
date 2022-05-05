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
        <xsl:result-document href="#Testo">
            <br /> <br />
            <xsl:apply-templates select="//tei:text" />
        </xsl:result-document>-->
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

            <tr>
                <th><xsl:text> Date:</xsl:text></th> <td> <xsl:value-of select="//tei:recording/tei:date" /> </td>
            </tr>
            <tr>
                <th><xsl:text> Type of record : </xsl:text></th><td><xsl:value-of select="//tei:recording/@type" /></td>
            </tr>
            <xsl:for-each select="//tei:recording[1]/tei:respStmt">
                <tr>
                    <th><xsl:value-of select="./tei:resp" />:</th> <td> <xsl:value-of select="./tei:name" /> </td>
                </tr>
            </xsl:for-each>
            <tr>
                <th><xsl:text> Number of records: </xsl:text></th> <td><xsl:value-of select="count(//tei:recording)" /><xsl:text> della durata di: </xsl:text>
                <xsl:for-each select="//tei:recording/@dur">
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
                <th><xsl:text> Broadcast : </xsl:text></th>
                <td><ul>
                    <li><xsl:text> Author: </xsl:text><xsl:value-of select="//tei:author" /></li>
                    <li><xsl:text> Date: </xsl:text><xsl:value-of select="//tei:bibl/tei:date" /></li>
                    <li>
                        <xsl:if test="count(//tei:bibl//tei:title)=1">
                            <xsl:text> Title: </xsl:text><xsl:value-of select="//tei:bibl/tei:title" />
                        </xsl:if>
                    </li>
                </ul></td>
            </tr>
            <tr>
                <th><xsl:text> Note: </xsl:text></th><td><xsl:value-of select="//tei:note" /></td>
            </tr>
    </xsl:template>

    <xsl:template match="//tei:profileDesc">
        <table>
            <br /> <br /> <br /> <br />
            <tr>
                <th><xsl:text> Creation:</xsl:text></th> <td> <xsl:value-of select="tei:creation" /> </td>
            </tr>   
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
<!--
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


    <xsl:template match="//tei:sic" />
        
    <xsl:template match="//tei:orig" />
    
    <xsl:template match="//tei:abbr" />

    <xsl:template match="//tei:del" />

    

    <xsl:template
    match="text()[
    following::node()[
    self::text()[normalize-space() != ''] or
    self::tei:lb]
    [1]
    [self::tei:lb[@break='no']]
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