var Pyramid = {
    plotIdealPyramid:function (jsonData) {
        var typeOfTests = jsonData.test_types,
            templates = new Template(),
            pyramidItemTemplate = templates.getPyramidItem(),
            pyramidData = "";

        for (var index = 0, len = typeOfTests.length; index < len; index++) {
            if (typeOfTests[index].percent == 0.0)
                continue;
            var testName = typeOfTests[index].test_name;
            pyramidData += templates.render(pyramidItemTemplate, {
                "TestTypeRegion":testName.split(' ')[0].toLowerCase() + "_region",
                "TestTypeTest":testName.split(' ')[0].toLowerCase() + "_test"
            });
        }

        $("#ideal_pyramid").html(pyramidData);

        var bodyHeight = 500,
            bodyWidth = 500,
            baseTriangleHeight = parseInt(bodyHeight) / 2,
            triangleHeights = [],
            zIndex = 100;

        var previousHeight = 0;
        for (index = 0, len = typeOfTests.length; index < len; index++) {
            var percentBasedHeight = parseInt(baseTriangleHeight) * parseInt(typeOfTests[index].percent) / 100;
            previousHeight = percentBasedHeight + previousHeight;
            triangleHeights.push(previousHeight);
        }

        $("#ideal_pyramid").css({
            "width":baseTriangleHeight,
            "height":baseTriangleHeight
        });

        previousHeight = 0;
        for (index = 0, len = typeOfTests.length; index < len; index++) {
            var testName = typeOfTests[index].test_name.split(' ')[0].toLowerCase();
            var seq_no = typeOfTests[index].seq_no;
            var color = ["", "#DB7093", "#008080", "#DAA520", "#CD853F", "#808000", "#191970", "#4B0082", "#A0522D"];

            color = color[parseInt(seq_no / 100)];
            $("#" + testName + "_test").css({
                "border-bottom-width":triangleHeights[index] + "px",
                "border-left-width":triangleHeights[index] + "px",
                "border-right-width":triangleHeights[index] + "px",
                "border-top-width":"0px",
                "border-color":"transparent transparent " + color,
                "border-style":"solid"
            });


            $("#" + testName + "_region").css({
                "z-index":zIndex.toString()
            });
            zIndex--;
        }
    },
    plotBlockPyramid:function (productJson) {
        var unknownTestTypes = productJson.unknown_test_types;
        var test_category = productJson.test_types;
        if ((unknownTestTypes != null) && (test_category.length == 0)) {

            plotPyramidWithUnknownTestCategory(unknownTestTypes);
        }
        else if ((unknownTestTypes == null) && (test_category.length != 0)) {
            plotPyramidWithKnownTestCategory(productJson);
        }
        else {
            plotPyramidWithUnknownTestCategory(unknownTestTypes);
            plotPyramidWithKnownTestCategory(productJson);
        }
    }
};

plotPyramidWithUnknownTestCategory = function (unknownTestTypes) {
    var message = "The following Test Types are not being supported currently. <br>";
    for (var count = 0; count < unknownTestTypes.length; count++) {
        message += unknownTestTypes[count] + "<br>";
    }
    message += 'Please drop a mail stating the order to <a href="mailto:tta@thoughtworks.com">tta@thoughtworks.com</a>';
    $("#display_message").css("display", "block");
    $("#display_message").html(message);
};

plotPyramidWithKnownTestCategory = function (productJson) {
    var renderString = "";
    var table_header = "";
    var table_content = "";
    var final_content = "";
    var proj_title = "";

    table_header = "<tr class='table_header'> <th>TEST TYPES</th> <th>NUMBER OF TESTS</th> <th style='width: 10%;'>TOTAL RUN TIME (HH:MM:SS:MS)</th> <th>TEST TYPE %</th> <th>PASSING %</th> </tr>";
    var typeOfTests = productJson.test_types,
        width = 400,
        height = 400;
    proj_title = "<h3>Test-Pyramid for : " + productJson.platform_name.toUpperCase() + "</h3><br>";
    var pyramidItems = [];
    var bottom = 0;
    for (var index = 0, len = typeOfTests.length; index < len; index++) {
        if (typeOfTests[index].percent == 0.0) {
            continue;
        }
        var color = ["", "#DB7093", "#008080", "#DAA520", "#CD853F", "#808000", "#191970", "#4B0082", "#A0522D"];

        currentItem = {};
        currentItem.testName = typeOfTests[index].test_name.split(' ')[0];
        currentItem.percent = typeOfTests[index].percent;
        currentItem.triangleWidth = currentItem.percent / 100 * width;
        currentItem.triangleHeight = currentItem.percent / 100 * height;
        var seq_no = typeOfTests[index].seq_no;
        currentItem.color = color[parseInt(seq_no / 100)];
        currentItem.no_of_test = typeOfTests[index].no_of_test;
        currentItem.total_run_time = typeOfTests[index].duration;
        currentItem.pass_percent = typeOfTests[index].percentage_passing;
        table_content = "<tr> <td" + " style='background:" + currentItem.color + "'>" + currentItem.testName + "</td> <td>" + currentItem.no_of_test + "</td>";
        table_content += "<td>" + currentItem.total_run_time + "</td><td>" + currentItem.percent + " %</td> <td>" + currentItem.pass_percent + " %</td> </tr>";
        renderString += "<div class='pyramidItem' " +
            "style= 'left: -" + currentItem.triangleHeight / 2 + "px; " +
            "bottom:" + (bottom) + "px;'>";
        renderString += "<div id=\'" + currentItem.testName + "_div\' class='trapezoid' " +
            "style='width:" + currentItem.triangleWidth + "px; " +
            "border-bottom-width:" + currentItem.triangleWidth + "px; " +

            "border-bottom-color:" + currentItem.color + ";'></div>";
        renderString += "</div>";
        pyramidItems.push(currentItem);
        bottom += currentItem.triangleHeight - index - 1;
        final_content = table_content + final_content;
    }
    renderString += "<div id='pyramid-overlay' style='display:block;'></div> ";
    $('#proj_title').append(proj_title);
    $('#block_pyramid').append(renderString);
    $('#pyramidTable').append(table_header);
    $('#pyramidTable').append(final_content);

    var bodyHeight = $('body').css('height'),
        baseTriangleHeight = parseInt(bodyHeight) / 2;

};
