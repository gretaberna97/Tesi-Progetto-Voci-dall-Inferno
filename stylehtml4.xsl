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
                <img id="home" src="home.png" alt="Icona home"/>
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">X</a>
                <xsl:for-each select="//tei:listPlace/tei:place">
                    <a onclick="closeNav()" style="display:inline" class="place1"><xsl:attribute name="href"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute><xsl:value-of select="./tei:placeName"/></a><xsl:text>&#32;</xsl:text>
                </xsl:for-each>
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:listPlace" />
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
        <xsl:result-document href="#Header" method="ixsl:replace-content">
            <p>L'interprete</p>
            <p style="margin-top:-10%">Arminio Wachsberger</p>
        </xsl:result-document>
        <xsl:result-document href="#Menu" method="ixsl:replace-content">
            <button id="TestOne" onclick="testOne()">4 Febbraio 1998</button>
            <button id="TestTwo" onclick="testTwo()">18 Febbraio 1987</button>
            <button id="PeopleBut" onclick="peopleB()">Lista persone</button> 
            <button id="PlaceBut" onclick="placeB()">Lista luoghi</button>
            <button id="FontiBut" onclick="fontiB()">Fonti di ausilio</button>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#up" method="ixsl:replace-content">
        </xsl:result-document>
        <xsl:result-document href="#footer" method="ixsl:replace-content">
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="//tei:listPlace">
            <h1>
                <xsl:value-of select="tei:head" />
            </h1>
            <h2><xsl:text>Luoghi citati all'interno delle testimonianze</xsl:text></h2>
            <a id="linkm" href="https://www.google.com/maps/d/u/0/viewer?mid=1-3FZB_vW5iEmxq2r8d5liTzZS63K1A4&amp;ll=18.143803593704973%2C-0.5140074999999911&amp;z=2">Vedi interamente la mappa dei percorsi</a><br/><br/><br/>
            <img class="mappa" id="prima" src="mappa.png"/>
            <img class="mappa" src="mappa2.png"/>
            <!--<iframe id="mappa" href="https://www.google.com/maps/d/u/0/viewer?mid=1-3FZB_vW5iEmxq2r8d5liTzZS63K1A4&amp;amp;ll=18.14380359370496%2C-0.5140074999999911&amp;amp;z=2" src="https://www.google.com/maps/d/u/0/embed?mid=1-3FZB_vW5iEmxq2r8d5liTzZS63K1A4&amp;amp;ehbc=2E312F" width="800" height="700" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>--><br/><br/>
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
                    <xsl:choose>
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