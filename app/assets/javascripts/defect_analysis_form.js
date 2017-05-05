$(document).ready(function () {
    $("#defect_analysis_form").validate();
    $("#date").val("");

    var productResponse = function (json_response) {
        $('.sub-element').remove();
        $('.test-element').remove();
        $('.specific-run').remove();
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
        $('.specific-run').remove();
        $("#date").datepicker('setDate', null);
        Utils.removeAttribute("#test_category_select", "disabled");
        jQuery.each(json_response, function (key, testTypes) {
            var test_type = testTypes["test_category"];
            Utils.loadDropDown("#test_category_select", test_type, test_type, test_type, "test-element");
        });
        Utils.loadDropDown("#test_category_select", "ALL", "ALL", "ALL", "test-element");
    }

    var getFormattedDate = function (unformatteddate) {
        var dmy = unformatteddate.getDate() + "-" + (unformatteddate.getMonth() + 1) + "-" + unformatteddate.getFullYear();
        return dmy;
    }

    var testCategoryResponse = function (json_response) {
        $("#date").datepicker('setDate', null);
        json_response = json_response.sort();
        executionDates = [];
        for (i = 0; i < json_response.length; i++) {
            executionDates.push(getFormattedDate(new Date(json_response[i].substring(0, 10))));
        }
        $('.specific-run').remove();
        if ($("#test_category_select option:selected").val() == 'ALL') {
            $("#test_run_select").attr("disabled", "true");
        }
        else {
            Utils.removeAttribute("#test_run_select", "disabled");
        }
        Utils.removeAttribute("#date", "disabled");
        $("#date").datepicker({
            dateFormat:"yy-mm-dd",
            defaultDate:" ",
            beforeShowDay:function (date) {
                return [($.inArray(getFormattedDate(date), executionDates) > -1)];
            }
        });
    }

    var runDateResponse = function (json_response) {
        $('.specific-run').remove();
        var index = 1;
        json_response.sort(function (a, b) {
            return a < b
        });
        jQuery.each(json_response, function (key, metadata) {
            var date = metadata.substring(11, 19);
            Utils.loadDropDown("#test_run_select", "date_" + index.toString(), date, date, "specific-run");
            index++;
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
        var platform_id = ($("#platform_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        var params = {url:"/get_run_dates", data:{platform_id:platform_id, test_category:test_category}, successCallback:testCategoryResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#date", "change", function () {
        var selected_date = ($("#date").datepicker('getDate'));
        var platform_id = ($("#platform_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        if (test_category != "ALL") {
            var params = {url:"/get_specific_run", data:{platform_id:platform_id, test_category:test_category, run_date:selected_date}, successCallback:runDateResponse};
            Utils.ajaxRequest(params);
        }
    });

})
;

