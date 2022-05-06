var loc= window.location.href;
var url= new URL(loc);
var xmlid= url.searchParams.get("xmlid");
var obj = { "get":"https://memoriarchivio.org/getfilexml/",
        "put": "https://memoriarchivio.org/settestotxt/",
        "aut": "giulia"
};

var req = new XMLHttpRequest();

req.overrideMimeType('text/xml');

req.onreadystatechange = function(){
    if (req.readyState == 4) {
        if(req.status==200) {
			xmlDoc = req.responseXML; 
            token = req.getResponseHeader("token");
            testoid = req.getResponseHeader("testoid");
            user = req.getResponseHeader("userad");
            Transformation();
        }   
    }
}

req.open('GET', obj["get"]+xmlid, true); 

req.send();

function Transformation(){    
  
      SaxonJS.transform({
          stylesheetLocation: "stylehtml.sef.json",
          sourceNode: xmlDoc,
          initialTemplate: "main"
      }, "async")

  };

  function send(){
	  if(user=="admin"){
	    SaxonJS.transform({
	        stylesheetLocation: "styletext.sef.json",
	        sourceNode: xmlDoc,
	        destination: "serialized"
	    },"async")
	    .then(output => {
	      var result = output.principalResult;
	      var xhr = new XMLHttpRequest();
	      xhr.open("PUT",obj["put"] + testoid +'/' + token + obj["aut"], true);
	      xhr.setRequestHeader('Content-type','text/plain; charset=utf-8');
	      xhr.onload = function () {
	        if (xhr.readyState == 4 && xhr.status == "202") {
	          alert ("File inserito correttamente!");
	        } else {
	          console.log("File not found");
	        }
	      }
	      xhr.send(result);
	      });
	  }else{
		  alert("funzione abilitata solo per l'amministratore");
	  }
	 
  }


function notmore (desc) {
	desc.nextSibling.style.display = "none";
	desc.setAttribute("onclick", "more(this)");
  };
  

function more (desc) {
	desc.nextSibling.style.display = "inline";
	desc.setAttribute("onclick", "notmore(this)");
  };
  