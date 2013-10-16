$(document).ready(function () {
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
    $(document).delegate("#project_select", "change", function () {
        var project_id = ($("#project_select option:selected").val());
        var params = {url:"/get_sub_project_data", data:{project_id:project_id}, successCallback:projectResponse};
        Utils.ajaxRequest(params);
    });
});