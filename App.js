/*Inserire window.onload*/
function zero() {
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
}

function testOne(){
	zero();
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1998.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

function testTwo(){
	zero();
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1987.xml"//,
		//initialTemplate: "main"
	}, "async")
}

function peopleB(){
	zero();
	SaxonJS.transform({
		stylesheetLocation: "stylehtml2.sef.json",
		sourceLocation: "TEI-ListPerson.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

function fontiB(){
	zero();
	SaxonJS.transform({
		stylesheetLocation: "stylehtml3.sef.json",
		sourceLocation: "TEI-ListPerson.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

function placeB(){
	zero();
	SaxonJS.transform({
		stylesheetLocation: "stylehtml4.sef.json",
		sourceLocation: "TEI-ListPlace.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

//Funzioni Greta
  function openNav() {
	document.getElementById("mySidenav").style.width = "20%";
	document.getElementById("Info").style.marginLeft = "20%";
	document.getElementById("Testo").style.marginLeft = "20%";
	document.getElementById("footer").style.marginLeft = "20%";
	document.getElementById("Header").style.marginLeft = "20%";
}
  
  function closeNav() {
	document.getElementById("mySidenav").style.width = "0";
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
  }

  var xhttp = new XMLHttpRequest();
  var xmlDoc;
  xhttp.onreadystatechange = function() {
	  if (this.readyState == 4 && this.status == 200) {
		  myFunction(this);
	  }
  };
  
  function myFunction(xml) {
	  xmlDoc = xml.responseXML;
  }

xhttp.open('GET', "AW1987.xml", true); 
xhttp.send();

function indietro() {
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
}

  function closeNav2() {
	closeNav();
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function closeNav3() {
	trans();
	closeNav();
	SaxonJS.transform({
        stylesheetLocation: "styletext2.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function minuti() {
	trans();
	closeNav();
	SaxonJS.transform({
        stylesheetLocation: "styletext3.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function hide(nodo) {
		nodo.style.backgroundColor = "transparent";
		nodo.style.cursor = "default";
	  };

  function closeNav5() {
	trans();
	closeNav();
	SaxonJS.transform({
        stylesheetLocation: "styletext4.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function glosse() {
	closeNav();
	SaxonJS.transform({
        stylesheetLocation: "styletext5.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "86%";
  }

  function trans() {
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#b30000";
	document.getElementById("indietro").style.color="white";
	document.getElementById("Testo").style.marginLeft = "0%";
	document.getElementById("trascrizione").style.marginLeft = "27.5%";
	document.getElementById("trascrizione").style.width = "64%";
	document.getElementById("legenda").style.display = "inline";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
	document.getElementById("download").style.display = "none";
  }


 