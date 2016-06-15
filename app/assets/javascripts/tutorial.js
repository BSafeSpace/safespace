$(function() {
	var isFiltered = false;

	if (gon.firstSignIn) {
		if (!isFiltered) {
			$(".expose").css('z-index','99999');
	    	$('#overlay').fadeIn(300);
		}
	    
		$('.filter-button').click(function(){
		    $('#overlay').fadeOut(300, function(){
		        $('.expose').css('z-index','1');
		    });
		    isFiltered = true;
		});

		console.log(gon.firstSignIn);
	}
	
});
