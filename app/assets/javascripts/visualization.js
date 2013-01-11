$(document).ready(function(){
  validateForm = function(form){
    var requiredFields = $('#'+form.FormId + " .required-field"),
        index, validFlag = true;
    for(index=0,len=requiredFields.length;index<len;index++){
      var $fieldParent = $(requiredFields[index]),
          field = $fieldParent.children()[0],
          errorMsg = $fieldParent.children('span');
      if(field.value==""){
        $(field).css({
          outline:"1px solid red",
          outlineStyle: "dotted",
          outlineOffset: "-1px"
        });
        $(errorMsg).show();
        validFlag = false;
      }
      else{
        $(field).css({outline:"0px solid red"});
        $(errorMsg).hide();
      }
    }
    return validFlag;
  };
  $("#submit-btn").on('click',function(e){
    if(validateForm({'FormId':'comparative-analysis-form'}))
      $("#form-submit").trigger('click');
    return false;
  });

});