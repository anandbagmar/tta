var renderDefectTable = {

    renderTable: function (jsonDataSet, date) {
        $("#defect-analysis").css("display", "none");
        var platformName = "";
        var percentage = "";
        if (jsonDataSet != "") {
            $("#defect_analysis_table").css("display", "block");
            jsonDataSet = jsonData.parse(jsonDataSet);

            platformName = "<h1>" + "Platform : " + jsonDataSet.platform_name.toUpperCase() + "<br><br>Analysis Date : " + date + "</h1>";
            percentage = jsonDataSet.percentage;
            var tableResponse = jsonDataSet.errors;
            var test_category = "";
            var errorListData = "";
            var errorMessageData = "";
            var errorList;
            var errorPer = 0;
            for (var test_type in tableResponse) {
                if ((Object.keys(tableResponse[test_type][0]).length == 0)) {
                    $("#defect_analysis_table").append("<tr class='first'>" + "<td colspan='2'>" + test_type + "</td>" + "</tr>");
                    $("#defect_analysis_table").append("<tr class='table-list'><td> ----- NO FAILURES FOR THIS TEST CATEGORY ----- </td><td></td></tr>");
                }
                else {
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
            }

            $("#defect-analysis").css("display", "block");
            $(".color_codes").css("display", "block");
            $("#defect-analysis").prepend(platformName);

        }
        return false;
    }
};

