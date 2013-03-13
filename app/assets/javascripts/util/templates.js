var Template = function () {
    var templates = {
        legendItem:'<div class="test-legend" id={{TestType}}><div class="rect" id={{TestTypeRect}}></div><span>{{TestTypeTitle}}</span></div>',
        pyramidPercent:'<span class="pyramidDetail" id={{TestTypePercent}}>{{PercentValue}} %</span>',
        pyramidDuration:'<span class="pyramidDetail" id={{TestTypeDuration}}>{{DurationValue}} Seconds</span>',
        errorListTemplate:'<ul class="error_list">{{ErrorList}}</ul>',
        defectErrorMessagesTemplate:'<span>{{ErrorName}}</span><div class="error_messages"><ul>{{ErrorMessageList}}</ul></div>',
        adminTableProjectTemplate:'<tr class="tr_border"><td>{{Index}}</td><td>{{ProjectName}}</td><td>{{SubProjectName}}</td><td>{{TestCount}}</td></tr>',
        adminTableSubprojectTemplate:'<tr><td>{{Index}}</td><td>{{ProjectName}}</td><td>{{SubProjectName}}</td><td>{{TestCount}}</td></tr>',
        compareTableTemplate:' <tr><td>{{ClassName}}</td></tr>'
    };

    return {
        render:function (template, data) {
            var regExp;
            for (var temp in data) {
                regExp = new RegExp("[{][{]" + temp + "[}][}]", 'g');
                template = template.replace(regExp, data[temp]);
            }
            return template;
        },
        getLegendItem:function () {
            return templates.legendItem;
        },
        getPyramidPercent:function () {
            return templates.pyramidPercent;
        },
        getPyramidDuration:function () {
            return templates.pyramidDuration;
        },

        getDefectErrorMessagesTemplate:function () {
            return templates.defectErrorMessagesTemplate;
        },
        getErrorListTemplate:function () {
            return templates.errorListTemplate;
        },
        getAdminTableProjectTemplate:function () {
            return templates.adminTableProjectTemplate;
        },
        getAdminTableSubProjectTemplate:function () {
            return templates.adminTableSubprojectTemplate;
        },
        getCompareTableTemplate:function () {
            return templates.compareTableTemplate;
        }

    };
};
