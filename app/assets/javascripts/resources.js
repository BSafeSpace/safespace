$(function() {
	$('.resource').on('click', '#cancel-btn', function() {
		var $resourceItem = $(this).parent().siblings('.resource-item');
	    $('.edit_resource').hide();
		$resourceItem.show();
		console.log('clicked');
	});
});