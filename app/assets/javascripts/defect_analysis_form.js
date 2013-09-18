$(document).ready(function () {
    $("#defect_analysis_form").validate();
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
        $('.specific-run').remove();
        Utils.removeAttribute("#sub_project_select", "disabled");
        jQuery.each(json_response, function (key, projectData) {
            var project_id = projectData["id"];
            var projectName = projectData["name"];
            Utils.loadDropDown("#sub_project_select", project_id, project_id, projectName, "sub-element");
        });
    };

    var subProjectResponse = function (json_response) {
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
        json_response = json_response.sort();
        var temp = [];
        for (i = 0; i < json_response.length; i++)  {
            temp.push(getFormattedDate(new Date(json_response[i].substring(0,10))));
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
            dateFormat: "yy-mm-dd",
            defaultDate: " ",
            beforeShowDay:function (date) {
                for (i = 0; i < temp.length; i++) {
                    return [($.inArray(getFormattedDate(date), temp) > -1), ''];
                }
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
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        var params = {url:"/get_run_dates", data:{subproject_id:sub_project_id, test_category:test_category}, successCallback:testCategoryResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#date", "change", function () {
        var selected_date = ($("#date").datepicker('getDate'));
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var test_category = ($("#test_category_select option:selected").val());
        if (test_category != "ALL") {
            var params = {url:"/get_specific_run", data:{subproject_id:sub_project_id, test_category:test_category, run_date:selected_date}, successCallback:runDateResponse};
            Utils.ajaxRequest(params);
        }
    });

})
;

