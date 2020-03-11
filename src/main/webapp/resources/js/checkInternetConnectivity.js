var isOnline = window.navigator.onLine;
if (isOnline) {
  console.log('online');
} else {
  console.log('offline');
}

// Add event listener offline to detect network loss.
window.addEventListener("offline", function(e) {
	alert("Offline");
	
    showPopForOfflineConnection();
});

// Add event listener online to detect network recovery.
window.addEventListener("online", function(e) {
	console.log('online in event listener..');
	alert("online");
    hidePopAfterOnlineInternetConnection();
});

function hidePopAfterOnlineInternetConnection(){
    // Enable to text field input
    $("#input-movie-name").prop('disabled', false);
    // Enable the search button responsible for triggering the search activity
    $("#search-button").prop('disabled', false);
    // Hide the internet connection status pop up. This is shown only when connection if offline and hides itself after recovery.
    $('#internet-connection-status-dialogue').trigger('close');
}

function showPopForOfflineConnection(){
    // Disable the text field input
    $("#input-movie-name").prop('disabled', true);
    // Disable the search button responsible for triggering search activity.
    $("#search-button").prop('disabled', true);
    // Show the error with appropriate message title and description.
    $(".main-error-message").html("Connection Error");
    $("#snackbar").html("It seems that your Internet Connection if offline.Please verify and try again later.");
    $(".extra-error-message").html("(This popup will automatically disappear once connection comes back to life)");
    // Addition of extra design to improve user experience when connection goes off.
    $('#internet-connection-status-dialogue').lightbox_me({
        centered: true,
        overlaySpeed:"slow",
        closeClick:false,
        onLoad: function() {
        }
    });
}