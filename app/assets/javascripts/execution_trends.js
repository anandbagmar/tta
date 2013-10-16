$(document).ready(function () {
    $("#execution_trends_form").validate();
    $("#start_date").val("");
    $("#end_date").val("");

    var projectResponse = function (json_response) {
        $('.sub-element').remove();
        $('.test-element').remove();
        $('.class-name-element').remove();
        $("#start_date").val("");
        $("#end_date").val("");
        Utils.removeAttribute("#sub_project_select", "disabled");
        jQuery.each(json_response, function (key, projectData) {
            var project_id = projectData["id"];
            var projectName = projectData["name"];
            Utils.loadDropDown("#sub_project_select", project_id, project_id, projectName, "sub-element");
        });
    };

    var projectChange = function(){
        var project_id = ($("#project_select option:selected").val());
        var params = {url:"/get_sub_project_data", data:{project_id:project_id}, successCallback:projectResponse};
        Utils.ajaxRequest(params);
    }

    var subProjectResponse = function (json_response) {
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
        var sub_project_id = ($("#sub_project_select option:selected").val());
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
            var params = {url:"/get_class_names", data:{subproject_id:sub_project_id, test_category:test_category, start_date:start_date, end_date:end_date}, successCallback:testClassNameResponse};
            Utils.ajaxRequest(params);
        }
    });
});


