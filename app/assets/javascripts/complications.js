
// execute the compListeners function when the document is ready
$(function() {
  compListeners()
})

function compListeners() {

	$(document).on("click", "a.complications_link", function(e) {
		
		$(this).css("color", "red")
		let $href = this.href
    	let id = e.target.id;
    	// handlebars process
		let templateSource = $("#complications").html()
		let template = Handlebars.compile(templateSource)

    	if ( id === "load_complications"){
    		$(".add_complications_form").html("")
			loadComplications(e, $href, template)
        }
        if ( id === "complications_form"){	
			loadComplications(e, $href, template)
			// execute the show.js.erb file in the watches view
			// to load the complications form
			$.get($href, null, null, "script")
			e.preventDefault()
        }	

	})

	$(document).on("click", "a.back", function(e){
		// navigate to previous page when 'back' link clicked
		parent.history.back()
		e.preventDefault()
	})

	$(document).on("submit", "form#new_complication", function(e) {
		
		const $form = $(this)
    	const action = $form.attr("action")
    	const params = $form.serialize()
    
    	newComplication(e, action, params, $form)
	})

}

function loadComplications(e, $href, template) {
	// get the complications, returned as a json object
	$.getJSON($href) 
	.done(function(json) {
		// sort the json object on complication name ascending
		json.complications.sort(function(a, b) {
		    return sortJson(a.complication_name, b.complication_name)
		})
		// load watch complications via handlebars template
		$(".complications").html(template(json))
	})
	.fail(function(jqxhr, textStatus, errorThrown){
	    showError(jqxhr, textStatus, errorThrown)
	})
	e.preventDefault()
}

function newComplication(e, action, params, $form) {
	// create a Complication prototype object and add a function to the prototype to format the complication data and append it to the DOM
	class Complication {

		constructor(attributes) {

			this.id = attributes.id
			this.complication_name = attributes.complication_name
			this.watch_id = attributes.watch_id

		}

		renderComplication() {
			
			let html = ""
			html += `<h5><b><a href="/complications/${this.watch_id}/description?comp_id=${this.id}&watch_id=${this.watch_id}"> ${this.complication_name} </a></b></h5>`
			return html
		}
		
	}

	$.ajax({ 
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
  	})
  	.done(function(json) {
  		
  		if (json.length > 0) {
	  		json.forEach(function(comp){
	  			let complication = new Complication(comp)
	  			let complicationData = complication.renderComplication()
	  			
	  			if ($(".text-danger")[0]){
	  				// no complications on this watch as yet, as denoted by a displayed message,
	  				// so remove the message before displaying the new complication/s
	  				$(".text-danger")[0].innerText = ""
				    $(".complications").append(complicationData)
				} else {	
				    $(".complications").append(complicationData)
				   }
				// execute the show.js.erb file in the watches view
				// to reload the complications form
	  			$.get(action, null, null, "script")
	  		})

	  	} else {
	  		// Update Watch button clicked and no complication/s selected
	  		// so execute the show.js.erb file in the watches view
	  		// to reload the complications form
	  		$.get(action, null, null, "script")
	  	}		
  	})
  	.fail(function(){
	    // Check for presence of both complication_name and complication_description
	    // when adding a new complication
	    if ($form.context[5].value !== null && $form.context[6].value == "" || 
	    	$form.context[6].value !== null && $form.context[5].value == "") 
	    	{
	    		alert("Both Complication name AND Complication description must be present!")
	    	}
	    else 
	    	{	// The complication being added as a new one already exists in the database
	    		alert("Check if the complication already exists in the list!")
			}
	    // execute the show.js.erb file in the watches view
		// to reload the complications form
	    $.get(action, null, null, "script")
	})
  	e.preventDefault()
}

function sortJson(a, b) {
  
  a = a.toLowerCase()
  b = b.toLowerCase()

  return (a < b) ? -1 : (a > b) ? 1 : 0
}

function showError(jqxhr, textStatus, errorThrown) {

	let err = textStatus + ', ' + errorThrown
	alert("Request Failed: " + err)
}
