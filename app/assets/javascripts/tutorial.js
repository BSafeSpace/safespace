$(function() {

	if (gon.firstSignIn) {
		// initialize Bootstrap Tooltips
		var $filterTooltip = $('#filter-tooltip');

		if (!gon.doneTutFilter) {
			$(".expose").css('z-index','99999');
	    	$('#overlay').fadeIn(300);
	    	$filterTooltip.tooltip('show');

	    	$('.filter-button').click(function(){
			    $('#overlay').fadeOut(300, function(){
			        $('.expose').css('z-index','1');
			        $filterTooltip.tooltip('hide');
			    });

			    $.ajax({
				   method: 'get',
				   url: '/profiles',
				   data: { doneTutFilter: true },
				   success: function(response) {
						console.log(response)
				   }
				});

			});
		}

		var $resultsTooltip = $('#results-tooltip');
		if (!gon.doneTutAddFriend) {
			$(".profile-results-container.expose").css('z-index','99999');
	    	$('#overlay').fadeIn(300);
	    	$resultsTooltip.tooltip('show');

	    	$('.add-friend').click(function(){
			    $('#overlay').fadeOut(300, function(){
			        $('.profile-results-container.expose').css('z-index','1');
			        $resultsTooltip.tooltip('hide');
			    });

			    $.ajax({
				   method: 'get',
				   url: '/profiles',
				   data: { doneTutAddFriend: true },
				   success: function(response) {
						console.log(response)
				   }
				});

			});
		}

	}
	
});
