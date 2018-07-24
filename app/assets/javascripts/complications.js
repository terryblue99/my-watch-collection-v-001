
// handlebars greater than helper
Handlebars.registerHelper('gt', function( a, b ){
	var next =  arguments[arguments.length-1];
	return (a > b) ? next.fn(this) : next.inverse(this);
})

$(function() {
  compListeners();
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

		e.preventDefault()	
	})

}

function loadComplications(e, $href, template) {

	$.getJSON($href)
	.success(function(json) {
		// load watch complications via handlebars template
		$(".complications").html(template(json))
	})
	.error(function(jqxhr, textStatus, error){
	    showError(jqxhr, textStatus, error)
	})
	e.preventDefault()
}

function showError(jqxhr, textStatus, error) {

	let err = textStatus + ', ' + error
	alert("Request Failed: " + err)
}
