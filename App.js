//"use strict";

function testOne(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1998.xml"//,
		//initialTemplate: "menu"
	}, "async")
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: "AW1998.xml",
		destination: "serialized"
	}, "async")
}

function testTwo(button){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1987.xml"//,
		//initialTemplate: "main"
	}, "async")
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: "AW1987.xml",
		destination: "serialized"
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
  