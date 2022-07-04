/* FUNZIONI DELL'APPLICAZIONE WEB SAXON-JS DER DOLMETSCHER */

/* Funzioni della Home Page invocate quando l'utente clicca uno dei pulsanti. A seconda del pulsante cliccato la funzione SaxonJS.transform() elaborarà diversamente il documento in input restituendo una pagina HTML personalizzata */

/* Funzione che si attiva quando l'utente clicca il pulsante "18 febbraio 1998" */
function testOne(){
	xmlDoc = "AW1998.xml"; /* Alla variabile globale viene assegnato come valore il nome del documento XML corrente (stringa) */
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1998.xml",
		initialTemplate: "main"
	}, "async")
	document.getElementById("Testo").style.display="inline";
}

/* Funzione che si attiva quando l'utente clicca il pulsante "4 febbraio 1987" */
function testTwo(){
	xmlDoc = "AW1987.xml"; /* Alla variabile globale viene assegnato come valore il nome del documento XML corrente (stringa) */
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: "AW1987.xml",
		initialTemplate: "main"
	}, "async")
	document.getElementById("Testo").style.display="inline";
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Lista persone" */
function peopleB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml2.sef.json",
		sourceLocation: "TEI-ListPerson.xml",
		initialTemplate: "main"
	}, "async")
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Fonti di ausilio" */
function fontiB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml3.sef.json",
		sourceLocation: "TEI-ListPerson.xml",
		initialTemplate: "main"
	}, "async")
	scroll(0,0); /* Metodo che fa scorrere su un particolare insieme di coordinate: in questo caso fa scorrere all'inizio della pagina */
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Lista luoghi" */
function placeB(){
	SaxonJS.transform({
		stylesheetLocation: "stylehtml4.sef.json",
		sourceLocation: "TEI-ListPlace.xml",
		initialTemplate: "main"
	}, "async")
	scroll(0,0); /* Metodo che fa scorrere su un particolare insieme di coordinate: in questo caso fa scorrere all'inizio della pagina */
}

/* Funzioni per la gestione dell'estensione e della chiusura del menù */
function openNav() {
  document.getElementById("mySidenav").style.width = "100%";
}
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

/* Dichiarazione della variabile globale xmlDoc utilizzata per il passaggio del nome del documento XML corrente */
var xmlDoc;

/* Funzioni delle sezioni di indagine invocate quando l'utente clicca uno dei pulsanti. A seconda del pulsante cliccato la funzione SaxonJS.transform() elaborarà diversamente il documento in input restituendo una sezione trascrizione "indagata" personalizzata */

/* Funzione che si attiva quando l'utente clicca il pulsante "Originale" per riavere la sezione trascrizione iniziale */
function indietro() {
	SaxonJS.transform({
		stylesheetLocation: "stylehtml.sef.json",
		sourceLocation: xmlDoc,	/* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Indaga il testo" */
function searchB() {
	style1();
	SaxonJS.transform({
        stylesheetLocation: "styletext.sef.json",
		sourceLocation: xmlDoc, /* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Fenomeni del parlato" */
function speechB() {
	style1();
	SaxonJS.transform({
        stylesheetLocation: "styletext2.sef.json",
		sourceLocation: xmlDoc, /* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Minuti" */
function minutiB() {
	SaxonJS.transform({
        stylesheetLocation: "styletext3.sef.json",
		sourceLocation: xmlDoc, /* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
	style2();
  }

/* Funzione che si attiva quando l'utente clicca il pulsante "Informatività" */
function infoB() {
	style1();
	SaxonJS.transform({
        stylesheetLocation: "styletext4.sef.json",
		sourceLocation: xmlDoc, /* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Termini e glosse" */
function glosseB() {
	SaxonJS.transform({
        stylesheetLocation: "styletext5.sef.json",
		sourceLocation: xmlDoc, /* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
	style2();
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Traduzioni" */
function tradB() {
	SaxonJS.transform({
        stylesheetLocation: "styletext6.sef.json",
		sourceLocation: xmlDoc, /* Passaggio del nome del documento XML corrente da elaborare memorizzato nella variabile xmlDoc */
		destination: "serialized",
		initialTemplate: "main"
	}, "async")
	style2();
}

/* Funzione che si attiva quando l'utente clicca il pulsante "Download" */
function download(){
  var a = document.body.appendChild(document.createElement("a"));
  var testoTrascrizione = document.getElementById("trascrizione").innerText; /* Memorizzazione del contenuto testuale dell'elemento con id "trascrizione" */
  string = xmlDoc.substring(0, 6);
  let isExecuted = confirm("Vuoi scaricare il testo della testimonianza?"); /* Visualizzazione di una finestra di dialogo con il messaggio, un pulsante OK e un pulsante Annulla */
  if (isExecuted) {
	a.download = string + '.txt';
	testoTrascrizione = testoTrascrizione.replace(/\n/g, "%0D%0A");
	a.href = "data:text/plain," + testoTrascrizione;
	a.click();
  }
}

/* Funzione che gestisce lo stile della trascrizione "indagata" con la legenda laterale */
function style1() {
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

/* Funzione che gestisce lo stile della trascrizione "indagata" senza la legenda laterale */
function style2() {
	document.getElementById("legenda").style.display="none";
	document.getElementById("trascrizione").style.marginLeft = "5%";
	document.getElementById("trascrizione").style.width = "88%";
	document.getElementById("download").style.display = "none";
	document.getElementById("indietro").style.display="inline-block";
	document.getElementById("indietro").style.backgroundColor="#4d4d4d";
	document.getElementById("indietro").style.color="white";
	document.getElementById("leg").style.display = "block";
}

/* Funzioni che gestiscono all'interno del div "Info" e del div "Testo" il direzionamento dell'utente alle pagine "Lista luoghi" o "Lista persone" a seconda del tipo dell'elemento cliccato */
document.getElementById("Info").addEventListener("click", function(e) {
	if(e.target && e.target.nodeName == "A" && e.target.className != "luoghi") {
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

/* Funzione che, tramite l'API Web Speech, riproduce i termini e le frasi in lingua straniera */
function copy(id) {
	var nodo = document.getElementById(id).innerText; /* Memorizzazione del contenuto testuale dell'elemento cliccato */
	var msg = new SpeechSynthesisUtterance();
	/* Indicazioni sul testo da riprodurre, sulla voce e sulla lingua da utilizzare e sulla velocità di riproduzione */
	msg.text = nodo;
	msg.rate = 0.7;
	msg.voice = speechSynthesis.getVoices().find(voice => /de(-|_)DE/.test(voice.lang));
	window.speechSynthesis.speak(msg); /* Riproduzione del contenuto testuale della variabile msg */
}