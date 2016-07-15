$(function() {

	$('.typeform-share').click(function() {
		console.log("launch button clicked");
		$('iframe').load(function(){
		    $(this).attr('id', 'something');
		    console.log("iframe loaded");
		});
	});

	$('iframe').load(function(){
	    $(this).attr('id', 'something');
	    console.log("iframe loaded");
	});

});

