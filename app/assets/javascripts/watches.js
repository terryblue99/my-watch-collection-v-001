$(document).ready(function() {
  attachListeners();
});

function attachListeners() {

  $('a.load_watches').on('click', function(e) {
		$.ajax({
	      url: this.href,
	      dataType: 'script'
	    })
		e.preventDefault()
	})

  $('a.navbar-brand').on('click', function(e) {
		$.ajax({
	      url: this.href,
	      dataType: 'script'
	    })
		e.preventDefault()
	})
}
