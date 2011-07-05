// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('.header ul input').each(function(index) {
    $(this).change(function() {
      if($(this).attr('id') == 'select_week') {
        var year = $(this).val().split('_')[0];
        var month = $(this).val().split('_')[1];
        var day = $(this).val().split('_')[2];
        var week = $.datepicker.iso8601Week(new Date(year, 1-month, day));
        $(this).val(year+'_'+week);
      };

      window.location.href = '/events?'+$(this).attr('id').split('_')[1]+'='+$(this).val();
    });
  });
});
