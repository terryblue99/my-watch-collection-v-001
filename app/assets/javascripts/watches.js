$(document).ready(function() {
  attachListeners();
})

function attachListeners() {

  	$('a.load_watches').on('click', function(e) {

 	$.getJSON(this.href).success(function(json){
 		
			// clear the UL html (in case there were previous watches)
		  	let $ul = $("div.watches ul")
		  	$ul.html("") // emptied the UL
		  	
		  	//iterate over each watch within json
		  	json.forEach(function(watch){
		  		// with each watch data, append an LI to the UL with the watch content
		  		$ul.append(`<li class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></li>`)
			})
			
		})
		e.preventDefault()
	})
}
