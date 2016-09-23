$('.conversations.index').ready(function() {
	$.ajax({
	   method: 'get',
	   url: '/conversations/update_convo_id',
	   dataType: 'json',
	   data: { },
	   success: function(response) {
		// update conversation id meta tag
		$('meta[name=conv-id]').attr("content", response.convo_id);
	   }
	});

	// Listen to dynamic message clicks
	$('body').on('click', '.message', function() {
	    console.log("clicked message");
	    var conv_id = $('.chat').data('conv-id');
	    var message_id = $(this).data('message-id');
	    var $message_container = $(this).parent();
	    $.get("/conversations/" + conv_id + "/messages/get_message_time", { message_id: message_id }, function (data) {
	    	var message_time = data.message_time;
	    	var $message_time = $('<div class="message-time curr-message-time">\
						             <small class="text-muted message-date">' + message_time + '</small>\
						          	</div>');
	    	var $message = $message_container.children().first();

	    	// Check if message time is already displayed or if the message clicked is the first message. 
	    	if ( $('.curr-message-time').length == 0 && !$message_container.parent().prev().hasClass('message-time') ) {
	    		if ($('.message-time-active').length > 0) {
	    			$('.message-time-active').removeClass('message-time-active');
	    		} else {
	    			$message_container.parent().before($message_time);
	    			$message.addClass('message-time-active');
	    		}
	    	}
            console.log($message_container.text());
        });
	});

	// Remove message time if user clicks away.
	$('.chat').click(function(event) {
		$('.curr-message-time').remove();
	})

	// Submit recommendation form on button click
	$('#rec-btn').click(function() {
		$('#new_recommendation').submit();
	});

	// Show liability dialog if new session
	if (Cookies.get('agree_chat_liability') == null) {
		console.log('hello');
		var $dialog = $('<div id="dialog-confirm" title="Reminder">\
						  <p>By clicking <em>I agree,</em> you agree to the following:</p>\
						  <ul>\
						    <li>I am not homicidal or suicidal. (If you are, we strongly urge you to speak with a professional).</li>\
						    <li>I understand that no action can be taken towards any users who make inappropriate or hurtful comments as all users are anonymous.</li>\
						    <li>I am a UC-Berkeley student.</li>\
						    <li>I understand that the chat is intended for peer to peer support and not for diagnosis or therapy.</li>\
						    <li>I understand that I am here as a peer to listen and share experiences. I will help others connect to resources/professionals if need be. </li>\
						  </ul>\
						</div>');
		$dialog.dialog({
			buttons: {
				"I agree": function() {
					$( this ).dialog( "close" );
					Cookies.set('agree_chat_liability', 'true');
				},
				Cancel: function() {
					window.location.replace("http://safespace-dev.herokuapp.com/");
				}
			},
			closeOnEscape: false,
			dialogClass: "liability-dialog",
			draggable: false,
			height: ($(window).height()) * 0.7,
			modal: true,
			open: function(event, ui) {
				// Set opacity of parent window
				$( ".ui-widget-overlay" ).css( "opacity", 0.90 );
				$( ".ui-widget-overlay" ).css( "z-index", 0 );
				// Hide close button on modal dialog
				$( ".ui-dialog-titlebar-close" ).css( "display", 'none' );
			},
			resizable: false,
			width: ($(window).width()) * 0.7
		});
	}

	$('.ui-dialog-titlebar').css("background","#FFF2D8");

	$(".ui-dialog-buttonset button:contains('I agree')").addClass('btn').addClass('btn-success');
	$(".ui-dialog-buttonset button:contains('Cancel')").addClass('btn').addClass('btn-default');

	// Protocol Button 
	var $protocolContainer = $('<div class="protocol-container"></div>');
	$protocolContainer.appendTo($("body"));
	var $protocolButton = $('<div class="protocol-button vertical-text btn btn-danger btn-lg">PROTOCOL</div>');
	$protocolButton.appendTo($protocolContainer);
	var $protocolMenu =  $('<div class="protocol-menu margin-negative"></div>');
	$protocolMenu.appendTo($('.protocol-container'));
	$protocolMenu.html('<h3>Mention of suicide? Please send your peer these resources.</h3>\
						<div class="copy-container input-group">\
							<h4>Crisis Support Services of Alameda County. 24/7</h4>\
							<input class="input-number suicide-input" id="alameda-number" type="text" value="1-800-309-2131" />\
							<div class="copy-button btn btn-success btn-lg" id="alameda-copy">Paste into Chat</div>\
							<h4>Crisis Text Line. Free, 24/7, confidential.</h4>\
							<input class="input-number suicide-input" id="crisis-text-number" type="text" value="Text “GO” to 741741" />\
							<div class="copy-button btn btn-success btn-lg" id="crisis-text-copy">Paste into Chat</div>\
						</div>'
						);

	// Expand Protocol Menu on Protocol Button Click
	$protocolButton.click(function() {
		$protocolMenu = $('.protocol-menu');
		if ($protocolMenu.hasClass('margin-zero')) {
			$protocolMenu.removeClass('margin-zero');
			console.log('first toggle');
		} else {
			$protocolMenu.addClass('margin-zero');
			console.log('second toggle');
		}
	});

	// "Disable" the horizontal scroll.
	var $body = $(document);
    $body.bind('scroll', function() {
        if ($body.scrollLeft() !== 0) {
            $body.scrollLeft(0);
        }
    });

    // Recommend button tutorial
	$(".recommend-button").tooltip({
      container: 'body',
      html: true,
      trigger: 'hover',
      template: '<div class="tooltip dropdown-tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
      title: 'If you believe your Chat Buddy would benefit more by speaking to a Peer Counselor, make a recommendation.',
      placement: 'left'
  	});

	// Download Chat tutorial
	$(".download-chat").tooltip({
      container: 'body',
      html: true,
      trigger: 'hover',
      template: '<div class="tooltip dropdown-tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
      title: 'Your chat will be deleted every seven days to protect your privacy, so you have the option to save the current week’s chat.',
      placement: 'left'
  	});

  	// Mute Button tutorial
  	$(".mute").tooltip({
      container: 'body',
      html: true,
      trigger: 'hover',
      template: '<div class="tooltip dropdown-tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
      title: 'You can Mute and Unmute a user whenever you want. You won’t be able to contact each other if they are muted.',
      placement: 'left'
  	});

  	$(".mute").on('click', function() {
  		$(this).tooltip('hide')
  	})

  	// Block tutorial
  	$(".block-button").tooltip({
      container: 'body',
      html: true,
      trigger: 'hover',
      template: '<div class="tooltip dropdown-tooltip" id="block-button-tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
      title: 'If this person deserves to be deleted off SafeSpace permanently for inappropriate or hurtful language, BLOCK them.',
      placement: 'left'
  	});

	// Select input on click
	$(".suicide-input").click(function () {
	   $(this).select();
	});

	// Copy number into message input on copy button click
	$('#alameda-copy').click(function() {
	    // copyToClipboardMsg($(this), document.getElementById("alameda-number"), "msg");
	    $('#message_body').val('Here is the number for the Crisis Support Services of Alameda County: ' + $('#alameda-number').val());
	});

	// Copy number into message input on copy button click
	$('#crisis-text-copy').click(function() {
	    // copyToClipboardMsg($(this), document.getElementById("crisis-text-number"), "msg");
	    $('#message_body').val("Here is the Crisis Text Line: " + $('#crisis-text-number').val());
	});

	function copyToClipboardMsg(copyButton, elem, msgElem) {
		var succeed = copyToClipboard(elem);
	    var msg;
	    if (!succeed) {
	        msg = "Copy not supported or blocked.  Press Ctrl+c to copy."
	    } else {
	        msg = "Text copied to the clipboard."
	        copyButton.text('Copied!');
	    }
	    if (typeof msgElem === "string") {
	        msgElem = document.getElementById(msgElem);
	    }
	    // msgElem.innerHTML = msg;
	    // setTimeout(function() {
	    //     msgElem.innerHTML = "";
	    // }, 2000);
	}

	function copyToClipboard(elem) {
		  // create hidden text element, if it doesn't already exist
	    var targetId = "_hiddenCopyText_";
	    var isInput = elem.tagName === "INPUT" || elem.tagName === "TEXTAREA";
	    var origSelectionStart, origSelectionEnd;
	    if (isInput) {
	        // can just use the original source element for the selection and copy
	        target = elem;
	        origSelectionStart = elem.selectionStart;
	        origSelectionEnd = elem.selectionEnd;
	    } else {
	        // must use a temporary form element for the selection and copy
	        target = document.getElementById(targetId);
	        if (!target) {
	            var target = document.createElement("textarea");
	            target.style.position = "absolute";
	            target.style.left = "-9999px";
	            target.style.top = "0";
	            target.id = targetId;
	            document.body.appendChild(target);
	        }
	        target.textContent = elem.textContent;
	    }
	    // select the content
	    var currentFocus = document.activeElement;
	    target.focus();
	    target.setSelectionRange(0, target.value.length);
	    
	    // copy the selection
	    var succeed;
	    try {
	    	  succeed = document.execCommand("copy");
	    } catch(e) {
	        succeed = false;
	    }
	    // restore original focus
	    if (currentFocus && typeof currentFocus.focus === "function") {
	        currentFocus.focus();
	    }
	    
	    if (isInput) {
	        // restore prior selection
	        elem.setSelectionRange(origSelectionStart, origSelectionEnd);
	    } else {
	        // clear temporary content
	        target.textContent = "";
	    }
	    return succeed;
	}

});
