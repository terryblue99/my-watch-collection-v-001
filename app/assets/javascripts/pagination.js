
$(function() {
	
	$(document).on("click", ".pagination a", function(e) {
	  	
	    $.get(this.href, null, null, "script")

		e.preventDefault()
	})
})