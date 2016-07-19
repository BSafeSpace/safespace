$(function() {

	$('.typeform-share').click(function() {
		console.log("launch button clicked");
		$('iframe').load(function(){
		    $(this).attr('id', 'something');
		    console.log("iframe loaded");
		});

		$('#people-tooltip').tooltip({
            html: true,
            trigger: 'manual',
            title: "Done with your bio? Let's go to the People page to connect with peers!",
            placement: 'bottom'
        }).tooltip('show');
	});

	$('iframe').load(function(){
	    $(this).attr('id', 'something');
	    console.log("iframe loaded");
	});

});

