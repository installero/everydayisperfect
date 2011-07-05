// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var selectFieldGroupVariant = function(group_id){
  var variant_id;
  var element = $('#'+group_id);
  switch(element.attr('type')){
    case 'checkbox':
      variant_id = element.attr('checked') ? "true" : "false";
      break;
    case 'select-one':
    case 'hidden':
      variant_id = element.val();
      break;
    default:
  }
  $('#'+group_id+'_field_group .show_only').each(function(){$(this).hide()});
  $('#'+group_id+'_field_group .for_'+variant_id).each(function(){$(this).show()});
  $('#'+group_id+'_field_group .hide_only').each(function(){
      if($(this).hasClass('for_'+variant_id)) $(this).hide();
      else $(this).show();
  });
};
