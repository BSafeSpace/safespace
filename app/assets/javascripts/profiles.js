$(function() {
  //initialize scrollbars
  $('.custom-scroll').mCustomScrollbar({
      theme: "minimal-dark"
  });

  // initialize dropdown preference tooltips
  $('.dropdown-pref').tooltip({
      container: 'body',
      html: true,
      trigger: 'hover',
      template: '<div class="tooltip dropdown-tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
      title: 'If you want to see this category higher in the results, select 1 to 4, 1 being the highest. Leave at 0 if you have no preference. ',
      placement: 'right'
  });

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

  $('#toggle-online-profiles').click(function() {
    $('input#q_online_or_all_profiles').prop('checked', !$('input#q_online_or_all_profiles').is(':checked'));
    $('input[name=commit').click();
  });

  $('#recommend-sort').click(function() {
    $('select#q_s_0_name>option:eq(3)').prop('selected', true);
    $('select#q_s_0_dir>option:eq(2)').prop('selected', true);
    $('input[name=commit').click()
  });

  $('#age-sort').click(function() {
    $('select#q_s_0_name>option:eq(1)').prop('selected', true);
    $('input[name=commit').click()
  });

  $('#name-sort').click(function() {
    $('select#q_s_0_name>option:eq(2)').prop('selected', true);
    $('input[name=commit').click()
  });
});

var bindOnlineToggle = function() {
  $('#toggle-online-profiles').click(function() {
    $('input#q_online_or_all_profiles').prop('checked', !$('input#q_online_or_all_profiles').is(':checked'));
    $('input[name=commit').click();
  });
}

var bindRecommendSort = function() {
  $('#recommend-sort').click(function() {
    $('select#q_s_0_name>option:eq(3)').prop('selected', true);
    $('select#q_s_0_dir>option:eq(2)').prop('selected', true);
    $('input[name=commit').click()
  });
}

var bindSort = function(sortId, checkPos) {
  $(sortId).click(function() {
    var selectId = 'select#q_s_0_name>option:eq(' + checkPos + ')'
    $(selectId).prop('selected', true);
    $('input[name=commit').click()
  });
}

var updateSearchContent = function(searchFormContent, searchResultsContent) {
  $('.search-field').remove();
  $('.filters-container').append(searchFormContent);

  $('.pagination').remove()
  $('.results-container').remove();
  $('.profile-results-container').append(searchResultsContent);
}

var bindAgeSlider = function() {
  $( "#slider-range" ).slider({
    range: true,
    min: 16,
    max: 60,
    values: [ $('input#q_age_gteq').val(), $('input#q_age_lteq').val() ],
    slide: function(event, ui) {
      $( "#age-range" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
    },
    change: function(event, ui) {
      $('input#q_age_gteq').val(ui.values[0])
      $('input#q_age_lteq').val(ui.values[1])
    }
  });
  $( "#age-range" ).val( $( "#slider-range" ).slider( "values", 0 ) + " - " + $( "#slider-range" ).slider( "values", 1 ) );
}

var disableSort = function(sortId) {
  $(sortId).parent().addClass("disabled")
}



