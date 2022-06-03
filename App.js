function testOne(){
	xmlDoc = "AW1998.xml";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1998.xml"
	}, "async")
	document.getElementById("Testo").style.display="inline";
}

function testTwo(){
	xmlDoc = "AW1987.xml";
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1987.xml"
	}, "async")
	document.getElementById("Testo").style.display="inline";
}

function peopleB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml2.sef.json",
		sourceLocation: "TEI-ListPerson.xml"
	}, "async")
	scroll(0,0);
}

function fontiB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml3.sef.json",
		sourceLocation: "TEI-ListPerson.xml"
	}, "async")
}


function placeB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml4.sef.json",
		sourceLocation: "TEI-ListPlace.xml"
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
		destination: "serialized"
	}, "async")
}

  function closeNav2() {
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function closeNav3() {
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext2.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized"
	}, "async")
  }

  function minuti() {
	trans();
	SaxonJS.transform({
        stylesheetLocation: "styletext3.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized"
	}, "async")
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
		destination: "serialized"
	}, "async")
  }

  function glosse() {
	SaxonJS.transform({
        stylesheetLocation: "styletext5.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized"
	}, "async")
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "88%";
	document.getElementById("download").style.display = "none";
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#b30000";
	document.getElementById("indietro").style.color="white";
  }

  function trad() {
	SaxonJS.transform({
        stylesheetLocation: "styletext6.sef.json",
		sourceLocation: xmlDoc,
		destination: "serialized"
	}, "async")
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "88%";
	document.getElementById("download").style.display = "none";
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#b30000";
	document.getElementById("indietro").style.color="white";
  }

  function trans() {
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#b30000";
	document.getElementById("indietro").style.color="white";
	document.getElementById("Testo").style.marginLeft = "0%";
	document.getElementById("trascrizione").style.marginLeft = "27.5%";
	document.getElementById("trascrizione").style.width = "65%";
	document.getElementById("legenda").style.display = "inline";
	document.getElementById("download").style.display = "none";
	document.getElementById("leg").style.display = "none";
  }

function download(){
  const generatedText = document.getElementById("trascrizione").innerText;
  string = xmlDoc.substring(0, 6);
  const a = document.createElement('a');
  let isExecuted = confirm("Vuoi scaricare il testo della testimonianza?");
  if (isExecuted) {
	a.href = `data:text/plain,${generatedText}`;
	a.download = string+'.txt';
	document.body.appendChild(a);
	a.click();
  }
}

document.getElementById("Info").addEventListener("click", function(e) {
	var link;
	var stringa;
	if(e.target && e.target.nodeName == "A") {
		if(e.target.className=="people1"){
			link = e.target.getAttribute("href");
			stringa = link.substr(1);
			SaxonJS.transform({
				stylesheetLocation: "stylehtml2.sef.json",
				sourceLocation: "TEI-ListPerson.xml"
			}, "async")
			.then (stringa => {
				document.getElementById(stringa).style.backgroundColor="red";
			})
			/*non vede ancora il nuovo albero Dom*/
			document.getElementById("Testo").style.display="none";
		} else if (e.target.className=="place1") {
			placeB();
			link = e.target.getAttribute("href");
			stringa = link.substr(1);
			placeB();
			document.getElementById("Testo").style.display="none";
			document.getElementById(stringa).style.backgroundColor="red";
		}
}
});

document.getElementById("Testo").addEventListener("click", function(e) {
	var link;
	var stringa;
	if(e.target && e.target.nodeName == "A") {
		if(e.target.className=="people1"){
			link = e.target.getAttribute("href");
			stringa = link.substr(1);
			peopleB();
			/*non vede ancora il nuovo albero Dom*/
			document.getElementById("Testo").style.display="none";
			document.getElementById(stringa).style.backgroundColor="red";
		} else if (e.target.className=="place1") {
			placeB();
			link = e.target.getAttribute("href");
			stringa = link.substr(1);
			placeB();
			document.getElementById("Testo").style.display="none";
			document.getElementById(stringa).style.backgroundColor="red";
		}
}
});

function copy(id) {
	/* Get the text field */
	var nodo = document.getElementById(id).innerText;
	/* Copiare un elemento
	navigator.clipboard.writeText(nodo);*/
	var msg = new SpeechSynthesisUtterance();
	msg.text = nodo;
	msg.lang = 'en-us';
	msg.voice = speechSynthesis.getVoices().find(voice => /de(-|_)DE/.test(voice.lang));
	window.speechSynthesis.speak(msg);
  }

  
  