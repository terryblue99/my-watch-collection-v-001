
$(function() {
  attachListeners();
})

function attachListeners() {

	// check for when pagination links are clicked
	$(document).on("click", ".pagination a", function(e) {
		
		$thisHref = this.href

		// get watches stored in the database		
		$.getJSON(this.href).success(function(json){
			$count = 0
			$jsonLth = json.length
			// clear the div html's of previous watches data
		  	$(".watches").html("")
		  	$(".watches_paginate").html("")
		  	
		  	// iterate over each watch within json and add to the DOM
		  	json.forEach(function(watch){
		  		// append each watch data to the watches div
		  		$(".watches").append(`<h5 class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></h5>`)
				$count += 1
				// if this is the last watch, execute the index.js.erb file 
				// in the watches view to set pagination entries 
				if ($count == $jsonLth) {
					$.get($thisHref, null, null, "script")
				}
			})
		})
		e.preventDefault()
	})

  	$(document).on('click', '.load_complications a', () => loadComplications())  	

}

function loadComplications () {

}
