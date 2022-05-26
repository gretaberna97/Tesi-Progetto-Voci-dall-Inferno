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
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: "AW1998.xml"//,
		//destination: "serialized"
	}, "async");
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
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: "AW1987.xml"//,
		//destination: "serialized"
	}, "async")
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

 