// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {

    $("#compare_runs_form").validate();

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

//ON PAGE LOAD
var pageLoad = $(".serverData").html();
projects = makeValidJSON.validate(pageLoad);
projects = JSON.parse(projects);
loadProjectData("#project_select", projects);


        $(document).delegate("#project_select", "change", function () {
            var project_id = ($("#project_select option:selected").val());
            $.ajax({
                url:"/get_sub_project_data",
                data:{project_id:project_id},
                type:"GET",
                dataType:'json',
                success:function (json_response) {
                                $('.sub-element').remove();
                                $('.test-element').remove();
                                $("#sub_project_select").removeAttr("disabled");
                                jQuery.each(json_response, function (key, projectData) {
                                    var project_id = projectData["id"];
                                    var projectName = projectData["name"];
                                    $("#sub_project_select").append(
                                            $("<option></option>")
                                            .attr("id", project_id)
                                            .attr("value", project_id)
                                            .text(projectName)
                                            .attr("class", "sub-element")
                                            );
                                    });
                    }
            });

});

    $(document).delegate("#sub_project_select", "change", function () {
        var sub_project_id = ($("#sub_project_select option:selected").val());
        $.ajax({
                url:"/get_test_types",
                data:{subproject_id:sub_project_id},
                type:"GET",
                dataType:'json',
                success:function (json_response) {
                $('.test-element').remove();
                $("#test_types_select").removeAttr("disabled");
                jQuery.each(json_response, function (key, testTypes) {
                var test_type = testTypes["test_category"];
                $("#test_types_select").append(
                                                $("<option></option>")
                                                .attr("id", test_type)
                                                .attr("value", test_type)
                                                .text(test_type)
                                                .attr("class", "test-element")
                                              );
                });
               }
            });

    });


    $(document).delegate("#test_types_select","change",function(){
        var sub_project_id = ($("#sub_project_select option:selected").val());
        var test_category  = ($("#test_types_select option:selected").val());
        $.ajax({
            url:"/get_compare_dates",
            data: {subproject_id:sub_project_id,test_category:test_category},
            type:"GET",
            dataType:'json',
            success:function (json_response) {
                $(".compare_date_one").remove();
                $("#date_one_select").removeAttr("disabled");
                var index=1;
                jQuery.each(json_response, function (key, compare_date) {
                    var date = compare_date["date_of_execution"];
                    date=date.replace("T"," ");
                    date=date.replace("Z"," ");
                    //var d=new date(date);
                    $("#date_one_select").append(
                        $("<option></option>")
                            .attr("id","date_one_"+index.toString())
                            .attr("value", date)
                            .text(date)
                            .attr("class", "compare_date_one")
                    );

                   index++;
                });
            }
        });

    });


   $(document).delegate("#date_one_select","change",function(){
       var date1=  ($("#date_one_select option:selected").val());
       var dates = $("#date_one_select>option").map(function() { return $(this).val(); });
       $(".compare_date_two").remove();
       for(i=1;i<dates.length; i++) {
           $("#date_two_select").append(
               $("<option></option>")
                   .attr("id","date_two_"+i.toString())
                   .attr("value", dates[i])
                   .text(dates[i])
                   .attr("class", "compare_date_two")
           );
       }
       var date2 = $("#date_two_select");
       date2.find("option[value='"+date1+"']").remove();
       $("#date_two_select").removeAttr("disabled");
    });


});