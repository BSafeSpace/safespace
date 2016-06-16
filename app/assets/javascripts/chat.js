$(function() {
	var $chatBox = $('#messages');
	$('#chat').on('keyup', '#message_body', function(e) {
		if (e.which == 13) {
			$chatBox.animate({ scrollTop: $chatBox.prop('scrollHeight')}, 1000);
	    }
	});

	$chatBox.prop({ scrollTop: $chatBox.prop("scrollHeight") });
});