$(function() {

	// initialize Bootstrap Tooltips
	var $filterTooltip = $('#filter-tooltip');

	if (gon.doneTutFilter == false) {
		$(".filters-container.expose").css('z-index','9998');
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
		if ($('.result-names').children().length > 0) {
			$('#overlay').fadeIn(300);
			$('.profile-results-container.expose').css('z-index','9998');

			var $resultsTooltip = $('.friend-link').first();

	    	$resultsTooltip.attr('id', 'results-tooltip');

	    	$resultsTooltip.tooltip({
                container: 'body',
                html: true,
                trigger: 'manual',
                title: 'Add a buddy as a friend!',
                placement: 'right'
            }).tooltip('show');

		}
	}
	
});
