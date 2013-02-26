var ValidateStartDateIsLessThanEndDate={

    checkForDates : function($form){

        var valid =true;
        var start_date = $form.find(".date-field").find('#comparative_analysis_start_date').val();
        var end_date = $form.find(".date-field").find('#comparative_analysis_end_date').val();

        if(start_date>=end_date && start_date!="" && end_date!="")
            valid=false;

        var errMsg = $form.children('span');

        if(valid==false)
            $(errMsg).show();
        else
            $(errMsg).hide();

        return valid;
    }
};


