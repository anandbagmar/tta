var renderDefectTable = {

    renderTable:function (jsonData) {
        $("#defect-analysis").css("display", "none");
        var subProjectName = "";
        var percentage = "";
        if (jsonData != "") {
            $("#defect_analysis_table").css("display","block");
            jsonData = makeValidJSON.validate(jsonData);
            jsonData = JSON.parse(jsonData);

            subProjectName = "<h1>" + "Sub Project:" + jsonData.sub_project_name.toUpperCase() + "</h1>";
            percentage = jsonData.percentage;
            var tableResponse = jsonData.errors;
            var test_category = "";
            var errorListData = "";
            var errorMessageData = "";
            var errorList;
            var errorPer = 0;

           for (var test_type in tableResponse) {
                test_category += "<td colspan='2'>" + test_type + "</td>"
                for (var index = 0, len = tableResponse[test_type].length; index < len; index++) {
                    for (var message in tableResponse[test_type][index]) {
                        errorMessageData += "<td>" + message + "</td>"
                        errorList = (tableResponse[test_type][index][message])
                        errorListData = "<td colspan='2'>";
                        for (var count = 0, len = errorList.length; count < len; count++) {
                            errorListData += "<span>" + errorList[count] + "</br></span>";
                        }
                        errorListData += "</td>"
                        errorMessageData += "<td>" + percentage[errorPer] + "% </td>"
                        errorPer++;
                        $("#defect_analysis_table").append("<tr class='first'>" + test_category + "</tr>");
                        $("#defect_analysis_table").append("<tr class='table-message'>" + errorMessageData + "</tr>");
                        $("#defect_analysis_table").append("<tr class='table-list' >" + errorListData + "</tr>");
                        errorMessageData = "";
                        errorListData = "";
                        test_category = "";
                    }
                }
            }

            $("#defect-analysis").css("display", "block");
            $(".color_codes").css("display", "block");
            $("#defect-analysis").prepend(subProjectName);

        }
        return false;
    }
};

