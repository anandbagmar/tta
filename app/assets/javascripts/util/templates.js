var Template = function () {
    var templates = {
        legendItem: '<div class="test-legend" id={{TestType}}><div class="rect" id={{TestTypeRect}}></div><span>{{TestTypeTitle}}</span></div>',
        pyramidPercent: '<span class="pyramidDetail" id={{TestTypePercent}}>{{PercentValue}} %</span>',
        pyramidDuration: '<span class="pyramidDetail" id={{TestTypeDuration}}>{{DurationValue}} Seconds</span>',
        errorListTemplate: '<ul class="error_list">{{ErrorList}}</ul>',
        defectErrorMessagesTemplate: '<span>{{ErrorName}}</span><div class="error_messages"><ul>{{ErrorMessageList}}</ul></div>',
        adminTableProductTemplate: '<tr class="tr_border"><td>{{Index}}</td><td>{{ProductName}}</td><td>{{PlatformName}}</td><td>{{TestCount}}</td></tr>',
        adminTablePlatformTemplate: '<tr><td>{{Index}}</td><td>{{ProductName}}</td><td>{{PlatformName}}</td><td>{{TestCount}}</td></tr>',
        compareTableRowTemplate: ' <tr>{{ClassNameColumns}}</tr>',
        compareTableColumnTemplate: ' <td width="50%">{{ClassName}}</td>'
    };

    return {
        render: function (template, data) {
            var regExp;
            for (var temp in data) {
                regExp = new RegExp("[{][{]" + temp + "[}][}]", 'g');
                template = template.replace(regExp, data[temp]);
            }
            return template;
        },
        getLegendItem: function () {
            return templates.legendItem;
        },
        getPyramidPercent: function () {
            return templates.pyramidPercent;
        },
        getPyramidDuration: function () {
            return templates.pyramidDuration;
        },
        getPyramidItem: function () {
            return templates.pyramidItem;
        },

        getDefectErrorMessagesTemplate: function () {
            return templates.defectErrorMessagesTemplate;
        },
        getErrorListTemplate: function () {
            return templates.errorListTemplate;
        },
        getAdminTableProductTemplate: function () {
            return templates.adminTableProductTemplate;
        },
        getAdminTablePlatformTemplate: function () {
            return templates.adminTablePlatformTemplate;
        },
        getCompareTableRowTemplate: function () {
            return templates.compareTableRowTemplate;
        },
        getCompareTableColumnTemplate: function () {
            return templates.compareTableColumnTemplate;
        }

    };
};
