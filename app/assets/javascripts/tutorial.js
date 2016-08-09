$(function() {

	// Create Bio Modal
	if (gon.completedBio == false) {
		$('#tutorial-wrapper').css('z-index', '10003');
		$('#bio-overlay').fadeIn(300);

		$('.typeform-share').click(function() {
			console.log("launch button clicked");
			$('#bio-overlay').remove();
	        $('#tutorial-wrapper').remove();

	        var delay = 5000; // 5 seconds
			setTimeout(function() {
			  // start filter tutorial after 5 seconds (typeform should be fully loaded)
			  filterTutorial();
			}, delay);
	        
		});
	}

	// initialize Bootstrap Tooltips
	var $filterTooltip = $('#filter-tooltip');
	var $defaultTooltip = $('#default-tooltip');

	if (gon.completedBio && !gon.doneTutFilter) {
		filterTutorial();
	}

	function filterTutorial() {
		$(".filters-container.expose").css('z-index','9998');
    	$('.overlay').fadeIn(300);

    	$filterTooltip.tooltip({
    		container: 'body',
            html: true,
            trigger: 'manual',
            title: 'Click Default to set the filters to your profile characteristics. Click Save Filters to see your results.',
            placement: 'right'
    	}).tooltip('show');

    	$defaultTooltip.tooltip({
    		container: 'body',
            html: true,
            trigger: 'manual',
            title: 'Search for peers based on certain characteristics',
            placement: 'right'
    	}).tooltip('show');

    	$('#save-filters, .overlay').click(function(){
		    $('.overlay').fadeOut(300, function(){
		        $('.filters-container.expose').css('z-index','1');
		        $filterTooltip.tooltip('hide');
		        $defaultTooltip.tooltip('hide');
		    });

		    $.ajax({
			   method: 'get',
			   url: '/profiles',
			   data: { doneTutFilter: true },
			   complete: function(response) {
			   	addFriendTutorial();
			   }
			});

		});
	}

	$('#save-filters, .overlay').click(function() {
		if (gon.doneTutFilter && !gon.doneTutAddFriend) {
	    	addFriendTutorial();
		}
	});

	function addFriendTutorial() {
		if ($('.result-names').children().length > 0) {
			$('.overlay').fadeIn(300);
			$('.profile-results-container.expose').css('z-index','9998');

			var $resultsTooltip = $('.friend-link').first();

	    	$resultsTooltip.attr('id', 'results-tooltip');

	    	$resultsTooltip.tooltip({
                container: 'body',
                html: true,
                trigger: 'manual',
                template: '<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner tooltip-slim"></div></div>',
                title: 'Add a buddy to begin chatting',
                placement: 'right'
            }).tooltip('show');

		}
	}

	function chatTutorial() {
		$('#chat-tooltip').tooltip({
		    html: true,
		    trigger: 'manual',
		    title: 'Go here to start chatting with your friends!',
		    placement: 'bottom'
		}).tooltip('show');
	}
	
});
