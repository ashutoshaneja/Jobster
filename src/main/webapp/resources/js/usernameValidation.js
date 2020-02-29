var warningText = document.getElementById('warning');

// Display capslock warning
$("input#username-input").on({
	  keydown: function(e) {
	    if (e.which === 32)
	      return false;
	  },
	  change: function() {
	    this.value = this.value.replace(/\s/g, "");
	  }
});

// Regex for Alphanumeric Username
$('input#username-input').on('keypress', function (event) {
    var regex = new RegExp("^[a-zA-Z0-9_]+$");
    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
    if (!regex.test(key)) {
       event.preventDefault();
       warningText.style.display = "block";
       return false;
    }
    else{
    	warningText.style.display = "none";
    }
});

// Hide Warning when clicked Backspace OR Delete key
$('input#username-input').on('keydown', function (event) {
	    var key = event.keyCode || event.charCode;

	    if( key == 8 || key == 46 ){
	    	warningText.style.display = "none";
	    }   
});