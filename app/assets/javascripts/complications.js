
$(function() {
  compListeners()
})

function compListeners() {

	$(document).on("click", "a.load_complications", function(e) {	
	
		$href = this.href
		// handlebar process
		let templateSource = $("#complications").html()
		let template = Handlebars.compile(templateSource)

		loadComplications(e, $href, template)
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
    	
    	newComplication(e, action, params)
	})

}

function loadComplications(e, $href, template) {
	
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
	// execute the show.js.erb file in the watches view
	// to load the complications form
	$.get($href, null, null, "script")
	e.preventDefault()
}

function newComplication(e, action, params) {
	
	class Complication {

		constructor(attributes) {

			this.id = attributes.id
			this.complication_name = attributes.complication_name
			this.watch_id = attributes.watch_id

		}

	}

	Complication.prototype.renderComplication = function() {
		
		html = ""
		html += `<h5><b><a href="/comlications/${this.watch_id}/description?comp_id=${this.id}&watch_id=${this.watch_id}"> ${this.complication_name} </a></b></h5>`
		return html
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
	  				// no complications on this watch as yet as denoted by a displayed message,
	  				// so remove the message before displaying new complication/s
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
  	.fail(function(jqxhr, textStatus, errorThrown){
	    showError(jqxhr, textStatus, errorThrown)
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
