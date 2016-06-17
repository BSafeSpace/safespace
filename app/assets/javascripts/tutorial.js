$(function() {

	// initialize Bootstrap Tooltips
	var $filterTooltip = $('#filter-tooltip');

	if (!gon.doneTutFilter) {
		$(".filters-container.expose").css('z-index','99999');
    	$('#overlay').fadeIn(300);
    	$filterTooltip.tooltip('show');

    	$('.filter-button').click(function(){
		    $('#overlay').fadeOut(300, function(){
		        $('.filters-container.expose').css('z-index','1');
		        $filterTooltip.tooltip('hide');
		    });

		    $.ajax({
			   method: 'get',
			   url: '/profiles',
			   data: { doneTutFilter: true },
			   complete: function(response) {
			   	tutorial2();
			   }
			});

		});
	}

	$('.filter-button').click(function() {
		if (gon.doneTutFilter && !gon.doneTutAddFriend) {
	    	tutorial2();
		}
	});

	function tutorial2() {
		if ($('.results-container').children().length > 0) {
			$('#overlay').fadeIn(300);
			$('.profile-results-container.expose').css('z-index','99998');

			var $resultsTooltip = $('.profile-results-container.expose').children('.results-container').children().first();

	    	$resultsTooltip.attr('id', 'results-tooltip');

	    	$resultsTooltip.tooltip({
                container: 'body',
                html: true,
                trigger: 'manual',
                title: 'Add a buddy as a friend!',
                placement: 'right'
            }).tooltip('show');

	        console.log("expose");
		}
	}
	
});
