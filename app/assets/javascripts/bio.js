$('iframe').load(function(){
    $('body').contents().find("body").html('my_new_content');
    console.log("iframe loaded");
});

$('.typeform-share').click(function() {
	$('iframe').attr('id', 'something');
	console.log("iframe loaded");
});

$('.click-me').click(function() {
	console.log("got clicked");
})
