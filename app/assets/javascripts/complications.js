
// handlebars greater than helper
Handlebars.registerHelper('gt', function( a, b ){
	let next =  arguments[arguments.length-1];
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
		
		const $form = $(this)
    	const action = $form.attr("action")
    	const params = $form.serialize()
    	newComplication(e, action, params)
	})

}

function loadComplications(e, $href, template) {
	debugger
	$.getJSON($href)
	.success(function(json) {
		// load watch complications via handlebars template
		$(".complications").html(template(json))
	})
	.error(function(jqxhr, textStatus, error){
	    showError(jqxhr, textStatus, error)
	})
	// $.get($href, null, null, "script")
	e.preventDefault()
}

function newComplication(e, action, params) {
	
	function Complication(attributes) {

		this.id = attributes.id
		this.complication_name = attributes.complication_name
		this.watch_id = attributes.watch_id
	}

	Complication.prototype.renderComplication = function() {
		debugger
		html = ""
		html += `<h5><b><%= link_to "${this.complication_name}", description_path(${this.watch_id}, watch_id: ${this.watch_id}, comp_name: "${this.complication_name}", comp_id: ${this.id}) %></b></h5>`
		return html
	}

	$.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
  	})
  	.success(function(json) {
  		debugger
  		json.forEach(function(comp){
  			let complication = new Complication(comp)
  			let complicationData = complication.renderComplication()
  			$(".complications").append(complicationData)
  		})	
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
