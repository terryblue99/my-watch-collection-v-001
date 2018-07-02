
$(function() {
	debugger
	$(".pagination a").click(function(e) {
		debugger
		// $(".pagination").html("Page is loading...")
	    $.ajax({
	    	url: this.href,
	    	dataType: "script"
	    });

		e.preventDefault()
	})

})