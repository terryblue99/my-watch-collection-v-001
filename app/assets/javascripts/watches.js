
$(function() {
	$('a.load_watches').on('click', function(e) {
		$.ajax({
	      url: this.href,
	      dataType: 'script'
	    })
		e.preventDefault()
	})
})
