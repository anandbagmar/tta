$(document).ready(function () {
    $("#compare_runs_form").validate();

    var projectResponse = function (json_response) {
        $('.sub-element').remove();
        $('.test-element').remove();
        Utils.removeAttribute("#sub_project_select", "disabled");
        jQuery.each(json_response, function (key, projectData) {
            var project_id = projectData["id"];
            var projectName = projectData["name"];
            Utils.loadDropDown("#sub_project_select", project_id, project_id, projectName, "sub-element");
        });
    };

    var projectChange = function () {
        var project_id = ($("#project_select option:selected").val());
        var params = {url:"/get_sub_project_data", data:{project_id:project_id}, successCallback:projectResponse};
        Utils.ajaxRequest(params);
    }

    var subProjectResponse = function (json_response) {
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

    if ($("#project_select option:selected").val()) {
        projectChange();
    }

    $(document).delegate("#project_select", "change", function () {
        projectChange();
    });

    $(document).delegate("#sub_project_select", "change", function () {
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var params = {url:"/get_test_types", data:{subproject_id:sub_project_id}, successCallback:subProjectResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#test_category_select", "change", function () {
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        var params = {url:"/get_compare_dates", data:{subproject_id:sub_project_id, test_category:test_category}, successCallback:testTypeResponse};
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

