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
    var projectResponse = function (json_response) {
        $('.sub-element').remove();
        Utils.removeAttribute("#sub_project_select", "disabled");
        jQuery.each(json_response, function (key, projectData) {
            var project_id = projectData["id"];
            var projectName = projectData["name"];
            Utils.loadDropDown("#sub_project_select", project_id, project_id, projectName, "sub-element");
        });
        Utils.loadDropDown("#sub_project_select", "ALL", "ALL", "ALL", "sub-element");
        //set default value "ALL" for sub project
        $("#sub_project_select").val("ALL");
        subProjectChange();
    };

    var subProjectChangeResponse = function (json_response) {
        disableAllTestCategoryFilters();
        jQuery.each(json_response, function (index, value) {
            name = "#" + value.split(" ").join("_");
            Utils.removeAttribute(name, "disabled");
            $(name).attr("checked", "true");

        });
    };

    var subProjectChange = function () {
        var project_id = ($("#project_select option:selected").val());
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var start_date = ($("#comparative_analysis_start_date").datepicker('getDate'));
        var end_date = ($("#comparative_analysis_end_date").datepicker('getDate'));
        var params = {url:"/test_category_mapping_list", data:{project_id:project_id, sub_project_id:sub_project_id,
            comparative_analysis_start_date:start_date, comparative_analysis_end_date:end_date}, successCallback:subProjectChangeResponse};
        Utils.ajaxRequest(params);
    };
    checkBoxResponse('#deselectALL', false, true);
    checkBoxResponse('#selectALL', true, false);

    $(document).delegate("#project_select", "change", function () {
        var project_id = ($("#project_select option:selected").val());
        var params = {url:"/get_sub_project_data", data:{project_id:project_id}, successCallback:projectResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#sub_project_select", "change", function () {
        subProjectChange();
    });
});