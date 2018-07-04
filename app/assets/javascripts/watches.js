
$(function() {
  attachListeners();
})

function attachListeners() {

	$(document).on("click", ".pagination a", function(e) {
		// get watches stored in the database
		// $.get(this.href, null, null, "script")

		$.getJSON(this.href).success(function(json){
		
			// clear the UL html (in case there were previous watches)
		  	// let $ul = $("div.watches ul")
		  	// $ul.html("") // emptied the UL
		  	
		  	//iterate over each watch within json
		  	json.forEach(function(watch){
		  		// with each watch data, append an LI to the UL with the watch content
		  		$("div.watches").append(`<h5 class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></h5>`)
			})
		
		})
		e.preventDefault()
	})

  	$(document).on('click', '.load_complications a', () => loadComplications())  	

}

function loadComplications () {

}
