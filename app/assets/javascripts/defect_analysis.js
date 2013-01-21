$("document").ready(function () {
    var jsonData = $("#defect-analysis-data").text(),
        subProjectName = "";
    if (jsonData != "") {
        jsonData = JSON.parse(jsonData);
        subProjectName = "<h1>" + "Sub Project:" + jsonData.sub_project_name.toUpperCase() + "</h1>";

        var errors = jsonData.errors,
            templates = new Template(),
            errorListData = "",
            errorMessageData = "",
            defectErrorMessageTemplate = templates.getDefectErrorMessagesTemplate(),
            errorListTemplate = templates.getErrorListTemplate();
        for (var errorName in errors) {
            if (errorName == "")
                continue;
            var errorMessages = errors[errorName];
            errorMessageData = "";
            for (index = 0, len = errorMessages.length; index < len; index++) {
              errorMessageData += "<li>"+errorMessages[index]+"</li>";
            }
            errorMessageData = templates.render(defectErrorMessageTemplate, {
                "ErrorName":errorName,
                "ErrorMessageList":errorMessageData.replace("'", " ")
            });
          errorListData += "<li class='clearfix'>"+errorMessageData+"</li>";
        }
        errorListData = templates.render(errorListTemplate, {
            "ErrorList":errorListData
        });

//        $("#defect-analysis-table").html(subProjectName + errorListData);
        $("#defect-analysis-table").prepend(subProjectName);
        $("#defect-analysis-table").append(errorListData);
    }
    return false;
});