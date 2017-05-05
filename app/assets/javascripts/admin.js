var ExternalDashboard = {
    renderTable:function (jsonDataSet) {
        var added_urls;
        added_urls = jsonData.parse(jsonDataSet);
        var tableElement = document.getElementById("url-table");

        if (added_urls.length == 0) {
            tableElement.innerHTML += "<tr><td>No URLS added</td></tr>"
        }
        else {
            for (index = 0; index < added_urls.length; index++) {
                tableElement.innerHTML += "<tr><td style=' width: 24%; '>" + added_urls[index]["name"] +
                    "<td>" + added_urls[index]["link"] + "</td>" + "</td></tr>";
            }
        }
    },
    renderButtons:function (externalDashboardURLs) {
        var divElement = document.getElementById("external-dashboard-url");
        var divIFrame = document.getElementById("external-dashboard-frame");

        for (i = 0; i < externalDashboardURLs.length; i++) {
            var newButton = document.createElement('button');
            var buttonName = externalDashboardURLs[i]["name"]
            var buttonValue = externalDashboardURLs[i]["link"];
            newButton.setAttribute("type", "button");
            newButton.setAttribute("value", buttonValue);
            newButton.setAttribute("id", buttonName);
            newButton.innerHTML = buttonName.toUpperCase();
            newButton.onclick = function () {
                divIFrame.innerHTML = "<iframe src=" + this.value +
                    " style='width: 100%; height: 470px;'></iframe>"
            };
            divElement.appendChild(newButton);
        }
    }
};

var ProductStatistics = {
    renderTable:function (jsonDataSet) {
        tableData = jsonData.parse(jsonDataSet);
        if (tableData != "") {
            if ('message' in tableData) {
                var message = "<h3>" + tableData["message"] + "</h3>";
                $("#display_message").html(message);
                $("#display_message").show();
            }
            else {
                $("#product_data_table").show();
                var templates = new Template();
                var productTemplate = templates.getAdminTableProductTemplate();
                var pLATFORMTemplate = templates.getAdminTablePlatformTemplate();
                var renderTableData = "<tr><th>No</th><th>PRODUCT NAME </th><th>PLATFORM NAME </th> <th> TEST UPLOAD COUNT</th></tr>";
                var index = 1;
                jQuery.each(tableData, function (key, productData) {
                    product_name = productData[0]['product_name'];
                    platforms = productData[1]['platforms']
                    count = productData[2]['test_count'];
                    renderTableData += templates.render(productTemplate, {
                        "Index":index,
                        "ProductName":product_name,
                        "PlatformName":"",
                        "TestCount":""
                    });
                    for (var i = 0; i < platforms.length; i++) {
                        renderTableData += templates.render(pLATFORMTemplate, {
                            "Index":"",
                            "ProductName":"",
                            "PlatformName":platforms[i],
                            "TestCount":count[i]
                        });
                    }
                    index++;
                })
                $('#product_data').html(renderTableData);
            }
        }
    }
};