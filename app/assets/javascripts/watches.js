
$(function() {
  attachListeners();
})

function attachListeners() {

	// check for when pagination links are clicked
	$(document).on("click", ".pagination a", function(e) {

		// get watches stored in the database		
		$.getJSON(this.href).success(function(json){
	
			// clear the div html (in case there were previous watches)
		  	$("div.watches").html("")
		  	$("div.watches_paginate").html("")
		  	
		  	// iterate over each watch within json
		  	json.forEach(function(watch){
		  		// append each watch data to the watches div
		  		$("div.watches").append(`<h5 class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></h5>`)
			})
			// append the pagination process to each page
			var $script = document.createElement( "script" )
			$script.type = "text/javascript"
			$script.innerHTML = '$("div.watches").append("<%= j (render("paginate")) %>")'
			$("div.watches_paginate").append( `'${$script}'` )

		})
		e.preventDefault()
	})

  	$(document).on('click', '.load_complications a', () => loadComplications())  	

}

function loadComplications () {

}
