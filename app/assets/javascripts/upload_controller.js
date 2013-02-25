var validateDate={

    checkForValidDate : function($form){

        var valid =true;
        var dateTime = $form.find(".date-field").find('option:selected');
        var errMsg = $form.find(".date-field").children('span');
        var year = dateTime[0].value;
        var month = dateTime[1].value;
        var day = dateTime[2].value;

        if(month < 1 || month > 12)
            valid = false;
        else {
            if (day < 1 || day > 31)
                valid = false;
            else if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31)
                valid = false;
            else if (month == 2) {
                var isLeap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
                if (day > 29 || (day == 29 && !isLeap)) {
                    valid = false;
                }
            }
        }

        if(valid==false)
            $(errMsg).show();
        else
            $(errMsg).hide();

        return valid;
    }
};


