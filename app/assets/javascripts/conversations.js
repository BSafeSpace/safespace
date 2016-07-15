$('.conversations.index').ready(function() {
	$.ajax({
	   method: 'get',
	   url: '/conversations/update_convo_id',
	   dataType: 'json',
	   data: { },
	   success: function(response) {
		// update conversation id meta tag
		$('meta[name=conv-id]').attr("content", response.convo_id);
	   }
	});

	$('#rec-btn').click(function() {
		$('#new_recommendation').submit();
	});

	$( "#dialog-confirm" ).dialog({
		buttons: {
			"I agree": function() {
				$( this ).dialog( "close" );
			},
			Cancel: function() {
				window.location.replace("http://www.webtechnologyinc.com");
			}
		},
		closeOnEscape: false,
		draggable: false,
		height: ($(window).height()) * 0.8,
		modal: true,
		open: function(event, ui) {
			// Set opacity of parent window
			$( ".ui-widget-overlay" ).css( "opacity", 0.90 );
			$( ".ui-widget-overlay" ).css( "z-index", 0 );
			// Hide close button on modal dialog
			$( ".ui-dialog-titlebar-close" ).css( "display", 'none' );
		},
		resizable: false,
		width: ($(window).width()) * 0.7
		});

});
