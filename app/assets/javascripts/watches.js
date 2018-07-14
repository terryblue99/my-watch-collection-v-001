
$(function() {
  attachListeners();
})

function attachListeners() {

	$(document).on("click", ".pagination a", function(e) {	
		$href = this.href
		pagination(e, $href)
	})

	$(document).on("click", "a.show_watch", function(e) {	
		$href = this.href
		// handlebar process
		let templateSource = $("#watch-template").html()
		let template = Handlebars.compile(templateSource)

		showWatch(e, $href, template)
	})
}
 
function pagination(e, $href) {
	// get watches stored in the database		
	$.getJSON($href).success(function(json){
		// clear the div html's of previous watches data
	  	$(".watches").html("")
	  	$(".watches_paginate").html("")
	  	// iterate over each watch within json and add to the DOM
	  	json.forEach(function(watch){
	  		// append each watch data to the watches div
	  		$(".watches").append(`<h5 class="text-success">${watch.watch_maker}: <b><a href="/watches/${watch.id}">${watch.watch_name}</a></b></h5>`)
		})
		// execute the related js.erb file in the watches view
		// to set pagination entries (index.js.erb / most_maker.js.erb)
		$.get($href, null, null, "script")
	})
	e.preventDefault()
}



function showWatch(e, $href, template) {
	
	$(".load_watch").html("")
	// get a watch stored in the database	
	$.getJSON($href)
	.success(function(json) {
		// load watch details via handlebars template
		$(".load_watch").html(template(this))
	})
	.error(function(jqxhr, textStatus, error){
	    let err = textStatus + ', ' + error;
	    alert("Request Failed: " + err);
	})
	// $.ajax({
	// url: $href,
	// type: "GET",
	// dataType: "json"
	// }).done(function(json) {
	//     alert("JSON Data: " + json )
	// }).fail(function(jqxhr, textStatus, error){
	//     let err = textStatus + ', ' + error
	//     alert("Request Failed: " + err)
	// })
	e.preventDefault()
}


