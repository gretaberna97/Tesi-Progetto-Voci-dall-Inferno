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
                <img id="home" src="home.png" alt="Icona home" onclick="nascondi()"/>
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <xsl:for-each select="//tei:person">
                    <a class="people1" onclick="closeNav()" style="display:inline;font-size:25px"><xsl:attribute name="href"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute>
                    <xsl:if test="tei:persName/tei:forename[not(@type='religious')] and tei:persName/tei:forename[not(@type='alternative')]">
						<xsl:value-of select="tei:persName/tei:forename[not(@type='religious')]"/>
						<xsl:text>&#32;</xsl:text>
                    </xsl:if>
                    <xsl:if test="tei:persName/tei:forename[@type='unknown'] and tei:persName/tei:surname[@type='unknown']">
                        <xsl:text>UNKNOWN: </xsl:text><xsl:value-of select="tei:persName/tei:addName"/>
                    </xsl:if>
                     <xsl:if test="tei:persName/tei:surname">
						<xsl:value-of select="tei:persName/tei:surname"/>
                    </xsl:if></a><xsl:text>&#32;</xsl:text>
                </xsl:for-each>
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:listPerson" />
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content"><br/>
            <p>Edizione digitale delle testimonianze di</p><span>Arminio Wachsberger</span>
            <p>Realizzata da Greta Bernardoni per il progetto <span>Voci dall'Inferno</span></p><br/>
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
            <img id="upimg" src="up.png" alt="Icona up"/>
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
        <xsl:result-document href="#up" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:listPerson">
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
                    <th><xsl:text>Informazioni:</xsl:text></th>
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
                            <xsl:choose>
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
                                                        
                                <xsl:choose><!--codice funzionante ma brutto-->
                                <xsl:when test=".[@source='#Rigano2015']">
                                    <li><b><xsl:text>Fonte: </xsl:text></b>
                                    <a>
				                    <xsl:attribute name="href">#Rigano2015</xsl:attribute><xsl:text>Rigano, 2015</xsl:text>
			                        </a></li>
                                </xsl:when>
                                <xsl:when test=".[@source='#Katz1973']">
                                    <li><b><xsl:text>Fonte: </xsl:text></b>
                                    <a>
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