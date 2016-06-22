$(function() {
	var $chatBox = $('#messages');
	$('#chat').on('keyup', '#message_body', function(e) {
		if (e.which == 13) {
			// $chatBox.animate({ scrollTop: $chatBox.prop('scrollHeight')}, 1000);
			$('.custom-scroll').mCustomScrollbar({
			    theme:"minimal-dark"
			});
			$chatBox.mCustomScrollbar("scrollTo", 'bottom', {
				scrollInertia: 1000
			});
	    }
	});

	// $chatBox.prop({ scrollTop: $chatBox.prop("scrollHeight") });

	// initialize scrollbars
	$('.custom-scroll').mCustomScrollbar({
	    theme:"minimal-dark"
	});

	// focus on bottom messages in chat box
	$chatBox.mCustomScrollbar("scrollTo", 'bottom', {
		scrollInertia: 0,
		advanced:{ updateOnSelectorChange: "true" }
	});

});