$(document).ready(function () {
    $("#category_filters").hide();
    var projectResponse = function (json_response) {
        $('.sub-element').remove();
        Utils.removeAttribute("#sub_project_select", "disabled");
        jQuery.each(json_response, function (key, projectData) {
            var project_id = projectData["id"];
            var projectName = projectData["name"];
            Utils.loadDropDown("#sub_project_select", project_id, project_id, projectName, "sub-element");
        });
    };

    var createLabel = function (labelElement) {
        var label = document.createElement('label');
        label.appendChild(document.createTextNode(labelElement));
        return label;
    };

    var createCheckBox = function (checkboxElement) {
        var newCheckbox = document.createElement("input");
        newCheckbox.type = "checkbox";
        newCheckbox.value = checkboxElement;
        newCheckbox.name = "testSubCategory[]";
        return newCheckbox;
    };

    var createSubCategoryCheckbox = function (value){
        sub_category_label=createLabel(value);
        data = document.createElement("td");
        sub_category_label.appendChild(createCheckBox(value));
        data.appendChild(sub_category_label);
        return data;
    }

    var subProjectResponse = function (json_response) {
        $("#category_filters").show();
        $('#categories').empty();
        jQuery.each(json_response, function (key, projectData) {
            category_label=createLabel(key);
            row=document.createElement("tr");
            row.appendChild(category_label);
            $("#categories").append(row);
            jQuery.each(projectData, function (index, value) {
                row.appendChild(createSubCategoryCheckbox(value));
            });
        });
    };

    $(document).delegate("#project_select", "change", function () {
        var project_id = ($("#project_select option:selected").val());
        var params = {url:"/get_sub_project_data", data:{project_id:project_id}, successCallback:projectResponse};
        Utils.ajaxRequest(params);
    });

    $(document).delegate("#sub_project_select", "change", function () {
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var start_date = ($("#comparative_analysis_start_date").datepicker('getDate'));
        var end_date = ($("#comparative_analysis_end_date").datepicker('getDate'));
        var params = {url:"/test_category_mapping_list", data:{sub_project_id:sub_project_id, comparative_analysis_start_date:start_date, comparative_analysis_end_date:end_date}, successCallback:subProjectResponse};
        Utils.ajaxRequest(params);
    });
});