$(function() {

	// initialize Bootstrap Tooltips
	var $filterTooltip = $('#filter-tooltip');
	var $defaultTooltip = $('#default-tooltip');

	if (gon.doneTutFilter == false) {
		$(".filters-container.expose").css('z-index','9998');
    	$('#overlay').fadeIn(300);

    	$filterTooltip.tooltip({
    		container: 'body',
            html: true,
            trigger: 'manual',
            title: 'Filters are automatically set to your profile characteristics, and you can click Default to reset them',
            placement: 'right'
    	}).tooltip('show');

    	$defaultTooltip.tooltip({
    		container: 'body',
            html: true,
            trigger: 'manual',
            title: 'Search for peers based on certain characteristics',
            placement: 'right'
    	}).tooltip('show');

    	$('#save-filters').click(function(){
		    $('#overlay').fadeOut(300, function(){
		        $('.filters-container.expose').css('z-index','1');
		        $filterTooltip.tooltip('hide');
		        $defaultTooltip.tooltip('hide');
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

	$('#save-filters').click(function() {
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
                title: 'Add a buddy as a friend',
                placement: 'right'
            }).tooltip('show');

		}
	}
	
});
