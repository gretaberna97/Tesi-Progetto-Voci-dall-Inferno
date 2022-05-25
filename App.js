/*Inserire window.onload*/
function testOne(){
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "-10%";
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
	document.getElementById("Header").style.marginLeft = "-10%";
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
	SaxonJS.transform({
		stylesheetLocation: "stylehtml2.sef.json",
		sourceLocation: "TEI-ListPerson.xml"//,
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
	document.getElementById("mySidenav").style.width = "15%";
	document.getElementById("Info").style.marginLeft = "15%";
	document.getElementById("Testo").style.marginLeft = "15%";
	document.getElementById("footer").style.marginLeft = "15%";
	document.getElementById("Header").style.marginLeft = "15%";
}
  
  function closeNav() {
	document.getElementById("mySidenav").style.width = "0";
	document.getElementById("Info").style.marginLeft= "0";
	document.getElementById("Testo").style.marginLeft = "0";
	document.getElementById("footer").style.marginLeft = "0";
	document.getElementById("Header").style.marginLeft = "-10%";
  }