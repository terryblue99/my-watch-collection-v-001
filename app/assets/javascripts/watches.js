
$(function() {
  attachListeners();
})

function attachListeners() {

	$(document).on("click", ".pagination a", function(e) {

		// get watches stored in the database		
		$.getJSON(this.href).success(function(json){
		
			// clear the div html (in case there were previous watches)
		  	$("div.watches").html("")
		  	
		  	// iterate over each watch within json
		  	json.forEach(function(watch){
		  		// append each watch data to the watches div
		  		$("div.watches").append(`<h5 class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></h5>`)
			})
		
		})
		e.preventDefault()
	})

  	$(document).on('click', '.load_complications a', () => loadComplications())  	

}

function loadComplications () {

}
