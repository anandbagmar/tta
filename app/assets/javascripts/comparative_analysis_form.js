$(document).ready(function () {
    var checkBoxResponse = function (id, ifchecked, ifunchecked) {
        $(id).change(function () {
            if ($(this).prop('checked')) {
                $('input[type="checkbox"]').each(function () {
                    $(this).prop('checked', ifchecked);
                });
                $(this).prop('checked', true);
                if (id == "#selectALL") {
                    $('#deselectALL').prop('checked', false);
                }
            } else {
                $('input[type="checkbox"]').each(function () {
                    $(this).prop('checked', ifunchecked);
                });
                $(this).prop('checked', false);
            }
        });
    };

    var disableAllTestCategoryFilters = function () {
        jQuery.each(document.getElementsByName("testSubCategory[]"), function (index, v) {
            $("#" + v.id).attr("disabled", "true");
        });
    };
    var productResponse = function (json_response) {
        $('.sub-element').remove();
        Utils.removeAttribute("#platform_select", "disabled");
        jQuery.each(json_response, function (key, productData) {
            var product_id = productData["id"];
            var productName = productData["name"];
            Utils.loadDropDown("#platform_select", product_id, product_id, productName, "sub-element");
        });
        Utils.loadDropDown("#platform_select", "ALL", "ALL", "ALL", "sub-element");
        //set default value "ALL" for platform
        $("#platform_select").val("ALL");
        pLATFORMChange();
    };

    var pLATFORMChangeResponse = function (json_response) {
        disableAllTestCategoryFilters();
        jQuery.each(json_response, function (index, value) {
            name = "#" + value.split(" ").join("_");
            Utils.removeAttribute(name, "disabled");
            $(name).attr("checked", "true");

        });
    };

    var pLATFORMChange = function () {
        var product_id = ($("#product_select option:selected").val());
        var platform_id = ($("#platform_select option:selected").val());
        var start_date = ($("#comparative_analysis_start_date").datepicker('getDate'));
        var end_date = ($("#comparative_analysis_end_date").datepicker('getDate'));
        var params = {url:"/test_category_mapping_list", data:{product_id:product_id, platform_id:platform_id,
            comparative_analysis_start_date:start_date, comparative_analysis_end_date:end_date}, successCallback:pLATFORMChangeResponse};
        Utils.ajaxRequest(params);
    };
    checkBoxResponse('#deselectALL', false, true);
    checkBoxResponse('#selectALL', true, false);

    $(document).delegate("#product_select", "change", function () {
        var product_id = ($("#product_select option:selected").val());
        var params = {url:"/get_platform_data", data:{product_id:product_id}, successCallback:productResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#platform_select", "change", function () {
        pLATFORMChange();
    });
});