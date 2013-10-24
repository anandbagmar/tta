$(document).ready(function () {
    var disableAllTestCategoryFilters = function(){
        jQuery.each(document.getElementsByName("testSubCategory[]"),function(index,v){
            $("#"+v.id).attr("disabled","true");
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
        disableAllTestCategoryFilters();
    };

    var subProjectResponse = function (json_response) {
        disableAllTestCategoryFilters();
        jQuery.each(json_response, function (index, value) {
            Utils.removeAttribute("#"+value.split(" ").join("_"), "disabled");
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