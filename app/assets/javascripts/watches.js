
$(function() {
  attachListeners();
})

function attachListeners() {

	// check for when pagination links are clicked
	$(document).on("click", ".pagination a", function(e) {

		// get watches stored in the database		
		$.getJSON(this.href).success(function(json){
			$count = 0
			$jsonLth = json.length
			// clear the div html (in case there were previous watches)
		  	$(".watches").html("")
		  	$(".watches_paginate").html("")
		  	debugger
		  	// iterate over each watch within json
		  	json.forEach(function(watch){
		  		// append each watch data to the watches div
		  		$(".watches").append(`<h5 class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></h5>`)
				$count += 1
				if ($count == json.length) {
					$.get("/", null, null, "script")
				}
			})
		  	debugger
			// alert("What the heck!!")
			// $("div.watches_paginate").html("#{j (render 'paginate')}")
			// debugger
			// // append the pagination process to each page
			// var $script = document.createElement( "script" )
			// $script.type = "text/javascript"
			// $script.innerHTML = '$("div.watches").append("<%= j (render("paginate")) %>")'
			// debugger
			// $("div.watches_paginate").append( $script.toString() )
			// debugger
			// '[object HTMLScriptElement]'
		})
		e.preventDefault()
	})

  	$(document).on('click', '.load_complications a', () => loadComplications())  	

}

function loadComplications () {

}
