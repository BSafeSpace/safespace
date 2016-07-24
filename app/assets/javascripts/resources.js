$(function() {
	$('.resource').on('click', '#cancel-btn', function() {
		var $resourceItem = $(this).parent().siblings('.resource-item');
	    $('.edit_resource').hide();
		$resourceItem.show();
		console.log('clicked');
	});

	$(".resources-sortable").sortable({
	    placeholder: 'resource-placeholder',
	    axis: "y",
	    revert: 150,
	    start: function(e, ui){
	        
	        placeholderHeight = ui.item.outerHeight();
	        ui.placeholder.height(placeholderHeight + 15);
	        $('<div class="resource-placeholder-animator" data-height="' + placeholderHeight + '"></div>').insertAfter(ui.placeholder);
	    
	    },
	    change: function(event, ui) {
	        
	        ui.placeholder.stop().height(0).animate({
	            height: ui.item.outerHeight() + 15
	        }, 300);
	        
	        placeholderAnimatorHeight = parseInt($(".resource-placeholder-animator").attr("data-height"));
	        
	        $(".resource-placeholder-animator").stop().height(placeholderAnimatorHeight + 15).animate({
	            height: 0
	        }, 300, function() {
	            $(this).remove();
	            placeholderHeight = ui.item.outerHeight();
	            $('<div class="resource-placeholder-animator" data-height="' + placeholderHeight + '"></div>').insertAfter(ui.placeholder);
	        });
	        
	    },
	    stop: function(e, ui) {
	        
	        $(".resource-placeholder-animator").remove();
	        
	    },
	});
});