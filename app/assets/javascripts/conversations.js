$('#chat-tooltip').click(function() {
	$.ajax({
	   method: 'get',
	   url: '/conversations/update_convo_id',
	   dataType: 'json',
	   data: { },
	   success: function(response) {
		// update conversation id meta tag
		console.log(response.convo_id);
		$('meta[name=conv-id]').attr("content", response.convo_id);
	   }
	});

	console.log("clicked");
});
