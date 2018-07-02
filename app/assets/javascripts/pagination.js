
$(function() {
	
	$(document).on("click", ".pagination a", function(e) {
		
		// clear the div html (in case there were previous watches)
	  	// let $div = $("div.watches")
	  	// $div.html("") // emptied the div

	    $.get(this.href, null, null, "script")

		e.preventDefault()
	})

})