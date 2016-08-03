$(function() {
	// initialize dropdown preference tooltips
	$('#email-tooltip').tooltip({
	  container: 'body',
	  html: true,
	  trigger: 'hover',
	  template: '<div class="tooltip dropdown-tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
	  title: 'Why are we asking for your email on an anonymous site? We want to make sure that only Berkeley students are allowed to join. However, <strong>your identity and information will be kept anonymous.</strong>',
	  placement: 'right'
	});

	// Reveal Passcode for Peer Counselor Sign Up
	$('#counselor-link').click(function() {
		$('#counselor-passcode').show();
	});
});
