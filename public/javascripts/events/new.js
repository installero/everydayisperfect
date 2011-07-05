var selectFieldGroupVariant = function(group_id) {
  var element = $('#'+group_id);
  var variant_id = element.val();
  element.parent().parent().children('.field_group').children('.show_only').each(function(){$(this).hide()});
  element.parent().parent().children('.field_group').children('.for_'+variant_id).each(function(){$(this).show()});
  element.parent().parent().children('.field_group').children('.hide_only').each(function(){
    if($(this).hasClass('for_'+variant_id)) $(this).hide();
    else $(this).show();
  });
};

$(function() {
  var checkbox = $('#event_has_routine');
  checkbox.change(function() {
    var routine = (checkbox).attr('checked') ? "week" : "off";
    $('#event_routine').val(routine);
    selectFieldGroupVariant('event_routine');
  });

  $('#select_week').bind('click', function() {
    $('#select_week').parent().toggleClass('current');
    $('#select_month').parent().toggleClass('current');
    $('#event_routine').val('week');
    $(".for_month .one_line").each(function(index) {
      $(this).remove();
    });
    selectFieldGroupVariant('event_routine');
    return false;
  });

  $('#select_month').bind('click', function() {
    $('#select_week').parent().toggleClass('current');
    $('#select_month').parent().toggleClass('current');
    $('#event_routine').val('month');
    $(".weekdays input").each(function(index) {
      $(this).attr('checked', false);
      $('#event_week_repetition_'+index).remove();
    });
    $(".for_month #add_repetition").click();
    selectFieldGroupVariant('event_routine');
    return false;
  });
  
  $(".weekdays input").each(function(index) {
    $(this).change(function() {
      if ($(this).attr('checked')) {
        $(this).before('<input type="hidden" value="'+index+'" name="event[repetitions_attributes]['+index+'][day]" id="event_week_repetition_'+index+'">');
      } else {
        $('#event_week_repetition_'+index).remove();
      };
    });
  });

  selectFieldGroupVariant('event_routine');

  $('#event_start').datetimepicker($.extend($.datepicker.regional['ru'],{
    stepMinute: 5,
    minDate: +1
  }));
});

var counter = 1;

function add_fields(link, association, content) {
  var new_id = counter;
  counter++;
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));

  var destroy_link = $('#event_repetitions_attributes_' + new_id + '_day').parent().children('a');
  destroy_link.bind('click', function() {
    destroy_link.parent().remove();
    return false;
  });
}
