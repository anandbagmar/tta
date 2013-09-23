$(document).ready(function () {
    $("#execution_trends_form").validate();
    $("#execution_trends_form").submit(function () {
        return ValidateStartDateIsLessThanEndDate.checkForDates($("#execution_trends_form"));
    });
    var loadProjectData = function (Selector, project_json) {
        jQuery.each(project_json, function (key, projectData) {
            var project_id = projectData["id"];
            var projectName = projectData["name"];
            $(Selector).append(
                $("<option></option>")
                    .attr("id", project_id)
                    .attr("value", project_id)
                    .text(projectName)
                    .attr("class", "proj-element")
            );
        });
    }
    $('.proj-element').remove();
    $("#date").val("");
    var pageLoad = $(".serverData").html();
    projects = jsonData.parse(pageLoad);
    loadProjectData("#project_select", projects);

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

    var subProjectResponse = function (json_response) {
        $('.test-element').remove();
        $("#date").datepicker('setDate', null);
        Utils.removeAttribute("#test_category_select", "disabled");
        jQuery.each(json_response, function (key, testTypes) {
            var test_type = testTypes["test_category"];
            Utils.loadDropDown("#test_category_select", test_type, test_type, test_type, "test-element");
        });
    }

    var testClassNameResponse = function (json_response) {
        jQuery.each(json_response, function (key, classNames) {
            console.log(classNames);
            Utils.loadDropDown("#test_class_name_select", classNames["class_name"], classNames["class_name"], classNames["class_name"], "class-name-element");
        });
    }

    $(document).delegate("#project_select", "change", function () {
        var project_id = ($("#project_select option:selected").val());
        var params = {url:"/get_sub_project_data", data:{project_id:project_id}, successCallback:projectResponse};
        Utils.ajaxRequest(params);
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
        $("#end_date").datepicker({
            dateFormat:"yy-mm-dd",
            maxDate:0
        });
    });

    $(document).delegate("#end_date", "change", function () {
        Utils.removeAttribute("#test_class_name_select", "disabled");
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        var start_date = ($("#start_date").datepicker('getDate'));
        var end_date = ($("#end_date").datepicker('getDate'));
        console.log(start_date);
        console.log(end_date);
        var params = {url:"/get_class_names", data:{subproject_id:sub_project_id, test_category:test_category, start_date:start_date, end_date:end_date}, successCallback:testClassNameResponse};
        Utils.ajaxRequest(params);
    });
});


