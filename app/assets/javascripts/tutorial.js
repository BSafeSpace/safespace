$(function() {
	var doneTutFirst = false;

	if (gon.firstSignIn) {
		// initialize Bootstrap Tooltips
		var $filterTooltip = $('#filter-tooltip');
		$filterTooltip.tooltip('show');

		if (!doneTutFirst) {
			$(".expose").css('z-index','99999');
	    	$('#overlay').fadeIn(300);
		}
	    
		$('.filter-button').click(function(){
		    $('#overlay').fadeOut(300, function(){
		        $('.expose').css('z-index','1');
		    });
		    doneTutFirst = true;
		});

		console.log(gon.firstSignIn);
	}
	
});
