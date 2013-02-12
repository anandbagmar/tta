$("document").ready(function () {
    $("#defect-analysis").css("display","none");
    $(".color_codes").css("display","none");
    var jsonData = $("#defect-analysis-data").text(),
        subProjectName = "";
    if (jsonData != "")
    {
        jsonData = JSON.parse(jsonData);
        subProjectName = "<h1>" + "Sub Project:" + jsonData.sub_project_name.toUpperCase() + "</h1>";
        percentage =""
        percentage =jsonData.percentage;
        var tableResponse = jsonData.errors;
        var errorListData = "";
        var errorMessageData= "";
        var errorList;
        var errorPer = 0;

        for (var message in tableResponse)
        {
            errorMessageData+="<td>"+message+"</td>"
            errorList=tableResponse[message];
            errorListData="<td colspan='2'>";
            for(var index= 0,len= errorList.length;index<len; index++ ){
                errorListData+="<span>"+errorList[index]+"</br></span>";
        }
            errorListData+="</td>"
            errorMessageData+="<td>"+percentage[errorPer]+"% </td>"
            errorPer++;
            $("#defect_analysis_table").append("<tr class='table-message'>"+errorMessageData+"</tr>");
            $("#defect_analysis_table").append("<tr class='table-list' >"+errorListData+"</tr>");
            errorMessageData ="";
            errorListData="" ;
        }
        $("#defect-analysis").css("display","block");
        $(".color_codes").css("display","block");
        $("#defect-analysis").prepend(subProjectName);

    }
    return false;
});

