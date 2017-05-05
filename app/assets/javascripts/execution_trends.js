$(document).ready(function () {
    $("#execution_trends_form").validate();
    $("#start_date").val("");
    $("#end_date").val("");

    var productResponse = function (json_response) {
        $('.sub-element').remove();
        $('.test-element').remove();
        $('.class-name-element').remove();
        $("#start_date").val("");
        $("#end_date").val("");
        Utils.removeAttribute("#platform_select", "disabled");
        jQuery.each(json_response, function (key, productData) {
            var product_id = productData["id"];
            var productName = productData["name"];
            Utils.loadDropDown("#platform_select", product_id, product_id, productName, "sub-element");
        });
    };

    var productChange = function(){
        var product_id = ($("#product_select option:selected").val());
        var params = {url:"/get_platform_data", data:{product_id:product_id}, successCallback:productResponse};
        Utils.ajaxRequest(params);
    }

    var pLATFORMResponse = function (json_response) {
        $('.test-element').remove();
        $('.class-name-element').remove();
        Utils.removeAttribute("#test_category_select", "disabled");
        jQuery.each(json_response, function (key, testTypes) {
            var test_type = testTypes["test_category"];
            Utils.loadDropDown("#test_category_select", test_type, test_type, test_type, "test-element");
        });
    }

    var testClassNameResponse = function (json_response) {
        jQuery.each(json_response, function (key, classNames) {
            Utils.loadDropDown("#test_class_name_select", classNames["class_name"], classNames["class_name"], classNames["class_name"], "class-name-element");
        });
    }

    if ($("#product_select option:selected").val()) {
        productChange();
    }

    $(document).delegate("#product_select", "change", function () {
        productChange();
    });

    $(document).delegate("#platform_select", "change", function () {
        var platform_id = ($("#platform_select option:selected").val());
        var params = {url:"/get_test_types", data:{platform_id:platform_id}, successCallback:pLATFORMResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#test_category_select", "change", function () {
        Utils.removeAttribute("#start_date", "disabled");
        $("#start_date").datepicker({
            dateFormat:"yy-mm-dd",
            maxDate:0
        });

    });

    $(document).delegate("#start_date", "change", function () {
        Utils.removeAttribute("#end_date", "disabled");
        $('.class-name-element').remove();
        $("#end_date").datepicker({
            dateFormat:"yy-mm-dd",
            maxDate:0
        });
    });

    $(document).delegate("#end_date", "change", function () {
        $('.class-name-element').remove();
        var platform_id = ($("#platform_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        var start_date = ($("#start_date").datepicker('getDate'));
        var end_date = ($("#end_date").datepicker('getDate'));
        if (start_date > end_date) {
            if (!ValidateStartDateIsLessThanEndDate.checkForDates($("#execution_trends_form")))
                $("#test_class_name_select").attr("disabled", "true");
        }
        else {
            $(".errormsg").hide()
            Utils.removeAttribute("#test_class_name_select", "disabled");
            var params = {url:"/get_class_names", data:{platform_id:platform_id, test_category:test_category, start_date:start_date, end_date:end_date}, successCallback:testClassNameResponse};
            Utils.ajaxRequest(params);
        }
    });
});


