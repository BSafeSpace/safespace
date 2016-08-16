$(function() {
	var $filterReady =  $('<a class="ready-btn filter-ready tutorial-btn btn btn-success btn-lg">\
    							<ul>\
				                    <li><span><i class="fa fa-check fa-lg"></i></span></li>\
				                    <li><span>Got it!</span></li>\
				                </ul>\
    						</a>');

	var $addFriendReady =  $('<a class="ready-btn add-friend-ready tutorial-btn btn btn-success btn-lg">\
    							<ul>\
				                    <li><span><i class="fa fa-check fa-lg"></i></span></li>\
				                    <li><span>Got it!</span></li>\
				                </ul>\
    						</a>');

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

		$filterReady.appendTo($('.overlay'));

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

    	$('#save-filters, .overlay').bind('click.filterOverlay', function(){
    		console.log("clicked filter overlay");
    		// Check if overlay clicked is from add friend tutorial
    		if ( $('.filters-container.expose').css('z-index') == '9998' ) {
    			$('.overlay').unbind('click.filterOverlay');
    			$('.filter-ready').remove();
    			$('.overlay').fadeOut(300, function(){
			        $('.filters-container.expose').css('z-index','1');
			        $filterTooltip.tooltip('hide');
			        $defaultTooltip.tooltip('hide');
			    });
			    console.log("filters container z-index 9998");

			    $.ajax({
				   method: 'get',
				   url: '/profiles',
				   data: { doneTutFilter: true },
				   success: function(response) {
				   	$('.overlay').fadeIn(300, function() {
				   		$('.profile-results-container').tooltip({
				    		container: 'body',
				            html: true,
				            trigger: 'manual',
				            title: 'Based on the traits you selected, a list of potential buddies will appear',
				            placement: 'left'
				    	}).tooltip('show');
				    	$filterReady.appendTo($('.overlay'));
				   	});


			    	$('.overlay').bind('click.potentialBuddiesOverlay', function() {
			    		console.log('intermediary tooltip');
			    		$('.overlay').unbind('click.potentialBuddiesOverlay');
			    		$('.filter-ready').remove();
			    		$('.tooltip').remove();
		  				$(this).fadeOut(300);
			    		addFriendTutorial();
			    	});
				   }
				});
    		}
		    

		});
	}

	$('#save-filters').click(function() {
		// If user comes back to page without finishing tutorial
		if (gon.doneTutFilter && !gon.doneTutAddFriend) {
	    	addFriendTutorial();
		}

	});

	function addFriendOverlay() {
		$('.overlay').click(function() {
		  console.log("clicked results overlay");
		  $('.tooltip').remove();
		  $('.overlay').fadeOut(300, function(){
		      $('.profile-results-container.expose').css('z-index', '1');
		      $('.overlay').hide();
		      $addFriendReady.remove();
		      console.log("fade overlay");
		  });

		  $.ajax({
		     method: 'get',
		     url: '/profiles',
		     data: { doneTutAddFriend: true },
		  });

		  gon.doneTutAddFriend = true;
		  chatTutorial();
		});
	}

	function addFriendTutorial() {
		if ($('.result-names').children().length > 0) {
			$('.overlay').fadeIn(300);
			$addFriendReady.appendTo($('.overlay'));
			$('.profile-results-container.expose').css('z-index','9998');
			addFriendOverlay();

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
		$('#tutorialFinish').modal('show');
	    $('#chat-tooltip').tooltip({
	        html: true,
	        trigger: 'manual',
	        title: 'Go here to start chatting with your friends!',
	        placement: 'bottom'
	    }).tooltip('show');
	    console.log("chat tutorial");
	}
	
});
