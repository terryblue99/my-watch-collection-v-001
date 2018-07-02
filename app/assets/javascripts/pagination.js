
$(function() {
	
	$(".pagination a").click(function(e) {
		
		// clear the UL html (in case there were previous watches)
	  	let $ul = $("div.watches ul")
	  	$ul.html("") // emptied the UL

	    $.get(this.href, null, null, "script")

		e.preventDefault()
	})

})