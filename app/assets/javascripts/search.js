$(function() {
  $( "#slider-range" ).slider({
    range: true,
    min: 16,
    max: 60,
    values: [ 16, 60 ],
    slide: function(event, ui) {
      $( "#age-range" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
    },
    change: function(event, ui) {
      $('input#q_age_gteq').val(ui.values[0])
      $('input#q_age_lteq').val(ui.values[1])
    }
  });
  $( "#age-range" ).val( $( "#slider-range" ).slider( "values", 0 ) + " - " + $( "#slider-range" ).slider( "values", 1 ) );
  $('input#q_age_gteq').val(16)
  $('input#q_age_lteq').val(60)

  $('#toggle-profiles').click(function() {
    $('input#q_online_or_all_profiles').prop('checked', !$('input#q_online_or_all_profiles').is(':checked'));
    $('input[name=commit').click()
  });
});
