$(document).ready(function () {
    $('.test-element').remove();

    var setDefaultTestSubCategory = function (json_response) {
        $("#test_sub_category_select").val(json_response["test_sub_category"]);
    }

    var load = function (json_response) {
        Utils.removeAttribute("#test_sub_category_select", "disabled");
        $('.test-element').remove();
        jQuery.each(json_response, function (key, testTypes) {
            var test_type = testTypes["test_sub_category"];
            Utils.loadDropDown("#test_sub_category_select", test_type, test_type, test_type, "test-element");
        });
    }

    var testCategoryChangeResponse = function () {
        var test_category = ($("#test_category_select option:selected").val());
        var params = {url: "/get_test_sub_category", data: {test_category: test_category}, successCallback: load};
        Utils.ajaxRequest(params);
        var sub = {
            url: "/get_default_test_sub_category",
            data: {test_category: test_category},
            successCallback: setDefaultTestSubCategory
        };
        Utils.ajaxRequest(sub);
    }

    if ($("#test_category_select").val() != "") {
        testCategoryChangeResponse();
    }

    $(document).delegate("#test_category_select", "change", function () {
        testCategoryChangeResponse();
    });


});

var validateDate = {

    checkForValidDate: function ($form) {

        var valid = true;
        var dateTime = $form.find(".date-field").find('option:selected');
        var errMsg = $form.find(".date-field").children('span')[0];
        var year = dateTime[0].value;
        var month = dateTime[1].value;
        var day = dateTime[2].value;

        if (month < 1 || month > 12)
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

        if (valid == false)
            $(errMsg).show();
        else
            $(errMsg).hide();

        return valid;
    },
    checkForFutureDate: function ($form) {

        var validFlag = true;

        var dateTime = $form.find(".date-field").find('option:selected');
        var errMsg = $form.find(".date-field").children('span')[1];
        var year = dateTime[0].value;
        var month = dateTime[1].value;
        var day = dateTime[2].value;
        var hour = dateTime[3].value;
        var minutes = dateTime[4].value;
        var currentDateTime = new Date();
        var currentYear = currentDateTime.getFullYear();
        var currentMonth = currentDateTime.getMonth() + 1;
        var currentDay = currentDateTime.getDate();
        var currentHour = currentDateTime.getHours();
        var currentMinutes = currentDateTime.getMinutes();


        if (year > currentYear)
            validFlag = false;
        else if (year == currentYear) {
            if (month > currentMonth)
                validFlag = false;
            else if (month == currentMonth) {
                if (day > currentDay)
                    validFlag = false;
                else if (day == currentDay) {
                    if (hour > currentHour)
                        validFlag = false;
                    else if (hour == currentHour) {
                        if (minutes > currentMinutes)
                            validFlag = false;
                    }

                }

            }

        }

        if (validFlag == false)
            $(errMsg).show();
        else
            $(errMsg).hide();
        return validFlag;
    }
};

var validateFile = {
    checkForValidFileType: function ($form) {
        var valid = true;
        var err_file = $form.find(".invalid-file-type");
        var file_path = $form.find("#logDirectory").val();
        if (file_path != "") {
            var extension = file_path.split(".").pop();
            if (extension != "zip")
                valid = false;
        }

        if (valid == false)
            $(err_file).show();
        else
            $(err_file).hide();
        return valid;
    }
};


