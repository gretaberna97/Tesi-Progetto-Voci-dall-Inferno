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
                <xsl:for-each select="//tei:sourceDesc/tei:bibl">
                <a onclick="closeNav()"><xsl:attribute name="href"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute><xsl:value-of select="./tei:title[1]"/></a><br/>
                </xsl:for-each>
            </div>
        </xsl:result-document>
        <xsl:result-document href="#Info" method="ixsl:replace-content">
            <xsl:apply-templates select="//tei:sourceDesc" />
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

    <xsl:template match="//tei:sourceDesc">
            <h1>
                <xsl:text>Fonti di ausilio</xsl:text>
            </h1>
            <h2>
                <xsl:text>Fonti utilizzate per identificare luoghi e nomi</xsl:text>
            </h2>
            <xsl:for-each select="tei:bibl">
            <table><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                <tr><th><xsl:text>Titolo primario:</xsl:text></th><td><xsl:value-of select="./tei:title[1]"/></td></tr>
                <tr><th><xsl:text>Titolo secondario:</xsl:text></th><td><xsl:value-of select="./tei:title[2]"/></td></tr>
                <tr><th><xsl:text>Autore:</xsl:text></th><td><xsl:value-of select="./tei:author"/></td></tr>
                <tr><th><xsl:text>Versione:</xsl:text></th><td><xsl:value-of select="./@type"/></td></tr>
                <tr><th><xsl:text>Curatore:</xsl:text></th><td><xsl:value-of select="./tei:editor"/></td></tr>
                <tr><th><xsl:text>Luogo di pubblicazione:</xsl:text></th><td><xsl:value-of select="./tei:pubPlace"/></td></tr>
                <tr><th><xsl:text>Editore:</xsl:text></th><td><xsl:value-of select="./tei:publisher"/></td></tr>
                <tr><th><xsl:text>Data pubblicazione:</xsl:text></th><td><xsl:value-of select="./tei:date"/></td></tr>
            </table><br/>
            </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>