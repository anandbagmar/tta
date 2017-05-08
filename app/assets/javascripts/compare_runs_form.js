$(document).ready(function () {
    $("#compare_runs_form").validate();

    var productResponse = function (json_response) {
        $('.sub-element').remove();
        $('.test-element').remove();
        Utils.removeAttribute("#platform_select", "disabled");
        jQuery.each(json_response, function (key, productData) {
            var product_id = productData["id"];
            var productName = productData["name"];
            Utils.loadDropDown("#platform_select", product_id, product_id, productName, "sub-element");
        });
    };

    var productChange = function () {
        var product_id = ($("#product_select option:selected").val());
        var params = {url: "/get_platform_data", data: {product_id: product_id}, successCallback: productResponse};
        Utils.ajaxRequest(params);
    }

    var pLATFORMResponse = function (json_response) {
        $('.test-element').remove();
        Utils.removeAttribute("#test_category_select", "disabled");
        jQuery.each(json_response, function (key, testTypes) {
            var test_type = testTypes["test_category"];
            Utils.loadDropDown("#test_category_select", test_type, test_type, test_type, "test-element");
        });
    }

    var testTypeResponse = function (json_response) {
        $(".compare_date_one").remove();
        Utils.removeAttribute("#date_one_select", "disabled");
        var index = 1;
        json_response.sort(function (a, b) {
            return a["date_of_execution"] < b["date_of_execution"]
        });
        jQuery.each(json_response, function (key, compare_date) {
            var date = compare_date["date_of_execution"];
            date = date.replace("T", " ");
            date = date.replace("Z", " ");
            Utils.loadDropDown("#date_one_select", "date_one_" + index.toString(), date, date, "compare_date_one");
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
        var params = {url: "/get_test_types", data: {platform_id: platform_id}, successCallback: pLATFORMResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#test_category_select", "change", function () {
        var platform_id = ($("#platform_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        var params = {
            url: "/get_compare_dates",
            data: {platform_id: platform_id, test_category: test_category},
            successCallback: testTypeResponse
        };
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#date_one_select", "change", function () {
        var date1 = ($("#date_one_select option:selected").val());
        var dates = $("#date_one_select>option").map(function () {
            return $(this).val();
        });
        $(".compare_date_two").remove();
        for (i = 1; i < dates.length; i++) {
            Utils.loadDropDown("#date_two_select", "date_two_" + i.toString(), dates[i], dates[i], "compare_date_two");
        }
        var date2 = $("#date_two_select");
        date2.find("option[value='" + date1 + "']").remove();
        Utils.removeAttribute("#date_two_select", "disabled");
    });

});

