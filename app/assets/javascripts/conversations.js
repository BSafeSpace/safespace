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
				window.location.replace("http://safespace-dev.herokuapp.com/");
			}
		},
		closeOnEscape: false,
		dialogClass: "liability-dialog",
		draggable: false,
		height: ($(window).height()) * 0.7,
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

	$('.ui-dialog-titlebar').css("background","#FFF2D8");

	$(".ui-dialog-buttonset button:contains('I agree')").addClass('btn').addClass('btn-success');
	$(".ui-dialog-buttonset button:contains('Cancel')").addClass('btn').addClass('btn-default');

	// Add Protocol button
	var $protocolContainer = $('<div class="protocol-container"></div>');
	$protocolContainer.appendTo($("body"));
	var $protocolButton = $('<input class="vertical-text btn btn-danger" type="button" value="new button" />');
	$protocolButton.appendTo($('.protocol-container'));

});
