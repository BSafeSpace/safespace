$(function() {
	var $chatBox = $('#messages');
	$('#chat').on('keyup', '#message_body', function(e) {
		if (e.which == 13) {
			// $chatBox.animate({ scrollTop: $chatBox.prop('scrollHeight')}, 1000);
	    }
	});

	// $chatBox.prop({ scrollTop: $chatBox.prop("scrollHeight") });

	$chatBox.mCustomScrollbar({
	    theme:"minimal-dark",
	    advanced:{ 
	    	updateOnContentResize: true,
	    	updateOnSelectorChange: "div" 
	    }
	});

	// focus on bottom messages in chat box
	$chatBox.mCustomScrollbar("scrollTo", 'bottom', {
		scrollInertia: 0
	});

});