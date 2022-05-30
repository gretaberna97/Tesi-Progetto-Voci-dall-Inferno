/*Inserire window.onload*/
function testOne(){
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1998.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

function testTwo(){
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1987.xml"//,
		//initialTemplate: "main"
	}, "async")
	/*SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: "AW1987.xml"//,
		//destination: "serialized"
	}, "async")*/
}

function peopleB(){
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml2.sef.json",
		sourceLocation: "TEI-ListPerson.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

function fontiB(){
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml3.sef.json",
		sourceLocation: "TEI-ListPerson.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

function placeB(){
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml4.sef.json",
		sourceLocation: "TEI-ListPlace.xml"//,
		//initialTemplate: "menu"
	}, "async")
}

//Funzioni Greta
function notmore (desc) {
	desc.nextSibling.style.display = "none";
	desc.setAttribute("onclick", "more(this)");
  };

function more (desc) {
	desc.nextSibling.style.display = "inline";
	desc.setAttribute("onclick", "notmore(this)");
  };

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

  function closeNav2() {
	trans();
	document.getElementById("indaga").style.backgroundColor = "transparent";
	document.getElementById("indaga").style.width = "26%";
	document.getElementById("indaga").style.display= "block-inline";
	document.getElementById("indaga").style.marginLeft= "0%";
	document.getElementById("indaga").style.position = "-webkit-sticky";
	document.getElementById("indaga").style.top = "2%";
	document.getElementById("vocal").style.display= "none";
	document.getElementById("minuti").style.display= "none";
	scroll(0,0);
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function closeNav3() {
	trans();
	document.getElementById("vocal").style.backgroundColor = "transparent";
	document.getElementById("vocal").style.width = "26%";
	document.getElementById("vocal").style.display= "block-inline";
	document.getElementById("vocal").style.marginLeft= "0%";
	document.getElementById("vocal").style.position = "-webkit-sticky";
	document.getElementById("vocal").style.top = "2%";
	document.getElementById("indaga").style.display= "none";
	document.getElementById("minuti").style.display= "none";
	scroll(0,0);
	SaxonJS.transform({
        stylesheetLocation: "styletext2.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function closeNav4() {
	document.getElementById("indaga").style.width = "26%";
	document.getElementById("Testo").style.marginLeft = "0%";
	document.getElementById("minuti").style.backgroundColor = "transparent";
	document.getElementById("indaga").style.display= "none";
	document.getElementById("vocal").style.display= "none";
	scroll(0,0);
	SaxonJS.transform({
        stylesheetLocation: "styletext3.sef.json",
		sourceNode: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function trans() {
	document.getElementById("Testo").style.marginLeft = "0%";
	document.getElementById("trascrizione").style.marginLeft = "27.5%";
	document.getElementById("trascrizione").style.width = "64%";
	document.getElementById("legenda").style.padding = "2%";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "0%";
  }


 