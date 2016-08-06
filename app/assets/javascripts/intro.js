$(function() {

	// $('.typeform-share').click(function() {
	// 	console.log("launch button clicked");
	// 	$('iframe').load(function(){
	// 	    $(this).attr('id', 'something');
	// 	    console.log("iframe loaded");
	// 	});

	// 	var delay=3000; // 3 seconds

	// 	setTimeout(function() {
	// 	  // show tooltip after 3 seconds (after typeform is loaded)
	// 	  $('#people-tooltip').tooltip({
 //            html: true,
 //            trigger: 'manual',
 //            title: "Done with your bio? Click People to connect with peers",
 //            placement: 'bottom'
 //          }).tooltip('show');

	// 	}, delay);

	// });

	$('iframe').load(function(){
	    $(this).attr('id', 'something');
	    console.log("iframe loaded");
	});

});

