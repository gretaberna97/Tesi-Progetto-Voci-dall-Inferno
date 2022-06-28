function testOne(){
	xmlDoc = "AW1998.xml";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1998.xml",
		initialTemplate: "main"
	}, "async")
	document.getElementById("Testo").style.display="inline";
}

function testTwo(){
	xmlDoc = "AW1987.xml";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1987.xml",
		initialTemplate: "main"
	}, "async")
	document.getElementById("Testo").style.display="inline";
}

function peopleB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml2.sef.json",
		sourceLocation: "TEI-ListPerson.xml",
		initialTemplate: "main"
	}, "async")
}

function fontiB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml3.sef.json",
		sourceLocation: "TEI-ListPerson.xml",
		initialTemplate: "main"
	}, "async")
	scroll(0,0);
}


function placeB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml4.sef.json",
		sourceLocation: "TEI-ListPlace.xml",
		initialTemplate: "main"
	}, "async")
	scroll(0,0);
}

function openNav() {
  document.getElementById("mySidenav").style.width = "100%";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

var xmlDoc;

function indietro() {
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
}

  function closeNav2() {
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
  }

  function closeNav3() {
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext2.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
  }

  function minuti() {
	SaxonJS.transform({
        stylesheetLocation: "styletext3.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "88%";
	document.getElementById("download").style.display = "none";
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#4d4d4d";
	document.getElementById("indietro").style.color="white";
	document.getElementById("leg").style.display = "block";
  }

  function hide() {
		nodo.style.backgroundColor = "transparent";
		nodo.style.cursor = "default";
	  };

  function closeNav5() {
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext4.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
  }

  function glosse() {
	SaxonJS.transform({
        stylesheetLocation: "styletext5.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "88%";
	document.getElementById("download").style.display = "none";
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#4d4d4d";
	document.getElementById("indietro").style.color="white";
	document.getElementById("leg").style.display = "none";
  }

  function trad() {
	SaxonJS.transform({
        stylesheetLocation: "styletext6.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "88%";
	document.getElementById("download").style.display = "none";
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#4d4d4d";
	document.getElementById("indietro").style.color="white";
	document.getElementById("leg").style.display = "none";
  }

  function trans() {
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#4d4d4d";
	document.getElementById("indietro").style.color="white";
	document.getElementById("Testo").style.marginLeft = "0%";
	document.getElementById("trascrizione").style.marginLeft = "27.5%";
	document.getElementById("trascrizione").style.width = "65%";
	document.getElementById("legenda").style.display = "inline";
	document.getElementById("download").style.display = "none";
	document.getElementById("leg").style.display = "none";
  }

function download(){
  var a = document.body.appendChild(document.createElement("a"));
  var testoTraduzione = document.getElementById("trascrizione").innerText;
  string = xmlDoc.substring(0, 6);
  let isExecuted = confirm("Vuoi scaricare il testo della testimonianza?");
  if (isExecuted) {
	a.download = string + '.txt';
	testoTraduzione = testoTraduzione.replace(/\n/g, "%0D%0A"); 
	a.href = "data:text/plain," + testoTraduzione;
	a.click();
  }
}

document.getElementById("Info").addEventListener("click", function(e) {
	if(e.target && e.target.nodeName == "A") {
			fontiB();
}
});

document.getElementById("Testo").addEventListener("click", function(e) {
	if(e.target && e.target.nodeName == "A") {
		if(e.target.className=="people1"){
			peopleB();
		} else if (e.target.className=="place1") {
			placeB();
		} else if (e.target.className=="fonti")	 {
			fontiB();
		}
}
});

function copy(id) {
	var nodo = document.getElementById(id).innerText;
	var msg = new SpeechSynthesisUtterance();
	msg.text = nodo;
	msg.rate = 0.3;
	msg.voice = speechSynthesis.getVoices().find(voice => /de(-|_)DE/.test(voice.lang));
	window.speechSynthesis.speak(msg);
  }