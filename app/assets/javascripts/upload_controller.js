var validateDate={

    checkForValidDate : function($form){

        var valid =true;
        var dateTime = $form.find(".date-field").find('option:selected');
        var errMsg = $form.find(".date-field").children('span')[0];
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
    },
    checkForFutureDate : function($form){

        var validFlag =true;

        var dateTime = $form.find(".date-field").find('option:selected');
        var errMsg = $form.find(".date-field").children('span')[1];
        var year = dateTime[0].value;
        var month = dateTime[1].value;
        var day = dateTime[2].value;
        var hour = dateTime[3].value;
        var minutes = dateTime[4].value;
        var currentDateTime = new Date();
        var currentYear = currentDateTime.getFullYear();
        var currentMonth = currentDateTime.getMonth()+1;
        var currentDay = currentDateTime.getDate();
        var currentHour = currentDateTime.getUTCHours();
        var currentMinutes = currentDateTime.getUTCMinutes();


        if (year > currentYear)
            validFlag = false;
        else if (year == currentYear)
        {
            if (month > currentMonth)
                validFlag = false;
            else if (month == currentMonth)
            {
                if (day > currentDay)
                    validFlag = false;
                else if (day == currentDay)
                {
                   if(hour>currentHour)
                        validFlag = false;
                    else if(hour == currentHour)
                   {
                        if (minutes > currentMinutes)
                            validFlag = false;
                   }

                }

            }

        }

        if(validFlag==false)
            $(errMsg).show();
        else
            $(errMsg).hide();
        return validFlag;
    }
};


