displayTable = function (class_name_array) {
    var templates = new Template();
    var number_of_failing_tests = 0;
    if (class_name_array) {
        number_of_failing_tests = class_name_array.length;
    }
    var classNames = '<trxmlns="http://www.w3.org/1999/html"><th width="100%" colspan="2" style=" text-align: center;">CLASS-NAMES</th></tr>';
    var row = "";
    var CompareTableRowTemplate = templates.getCompareTableRowTemplate();
    var CompareTableColumnTemplate = templates.getCompareTableColumnTemplate();
    var MAXIMUM_COLUMNS = 2;

    for (var index = 0; index < number_of_failing_tests;) {
        for (var colIndex = 0; colIndex < MAXIMUM_COLUMNS; colIndex++) {
            row += templates.render(CompareTableColumnTemplate, {
                "ClassName":(index < number_of_failing_tests) ? class_name_array[index].class_name : ""
            });
            index++;
        }
        classNames += templates.render(CompareTableRowTemplate, {
            "ClassNameColumns":row
        });
        row = "";
    }
    return classNames;
}

compareResultsFor = function (type, tableTitle, date1, date2, class_name_array) {
    tableTitle = "<h2><b>" + tableTitle + "</b></h2>" + "<h3><b>Number of failing tests: " + class_name_array.length + "</b></h3>"
    $("#result_title_" + type).html(tableTitle);
    if (class_name_array.length != 0) {
        var classNames = displayTable(class_name_array);
        $("#result_table_" + type).html(classNames);
    }
}

var compareRuns = {
    renderView:function (compareJson) {
        var date1 = compareJson.dates[0];
        var date2 = compareJson.dates[1];

        var class_name_array;
        var tableTitle;

        class_name_array = compareJson.common_failures;
        tableTitle = "TEST-CASES FAILING IN BOTH RUNS (COMMON FAILURES)";
        compareResultsFor("common", tableTitle, date1, date2, class_name_array);

        class_name_array = compareJson.combined_total_failures;
        tableTitle = "ALL FAILING TEST-CASES (IN BOTH RUNS)";
        compareResultsFor("both", tableTitle, date1, date2, class_name_array);

        class_name_array = compareJson.test_case_records_for_date_one;
        tableTitle = "TEST-CASES FAILING ONLY ON DATE 1: " + date1;
        compareResultsFor("date1", tableTitle, date1, ".", class_name_array);

        class_name_array = compareJson.test_case_records_for_date_two;
        tableTitle = "TEST-CASES FAILING ONLY ON DATE 2: " + date2;
        compareResultsFor("date2", tableTitle, ".", date2, class_name_array);
    }
};
