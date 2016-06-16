$(function() {
	$('#chat').on('keyup', '#message_body', function(e) {
		if (e.which == 13) {
	        var chatBox = $('#messages');
			chatBox.animate({ scrollTop: chatBox.prop('scrollHeight')}, 1000);
	    }
	});
});