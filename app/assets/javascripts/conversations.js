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
	var $protocolButton = $('<div class="protocol-button vertical-text btn btn-danger">PROTOCOL</div>');
	$protocolButton.appendTo($('.protocol-container'));
	var $protocolMenu =  $('<div class="protocol-menu margin-negative"></div>');
	$protocolMenu.appendTo($('.protocol-container'));

	$protocolButton.click(function() {
		$protocolMenu = $('.protocol-menu');
		if ($protocolMenu.hasClass('margin-zero')) {
			$protocolMenu.removeClass('margin-zero');
			console.log('first toggle');
		} else {
			$protocolMenu.addClass('margin-zero');
			console.log('second toggle');
		}
	});

});
