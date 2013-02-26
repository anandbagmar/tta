var Template = function(){
    var templates = {
      legendItem:'<div class="test-legend" id={{TestType}}><div class="rect" id={{TestTypeRect}}></div><span>{{TestTypeTitle}}</span></div>',
      pyramidItem:'<div class="test-region" id={{TestTypeRegion}}>' +
          '<span id={{TestTypePercent}}>{{PercentValue}} %</span>' +
          '<span id={{TestTypeDuration}}>{{DurationValue}} Seconds</span>' +
          '<div class="test-triangle" id={{TestTypeTest}}></div>' +
        '</div>',
      errorListTemplate:'<ul class="error_list">{{ErrorList}}</ul>',
      defectErrorMessagesTemplate:'<span>{{ErrorName}}</span><div class="error_messages"><ul>{{ErrorMessageList}}</ul></div>',
      adminTableProjectTemplate: '<tr class="tr_border"><td>{{Index}}</td><td>{{ProjectName}}</td><td>{{SubProjectName}}</td><td>{{TestCount}}</td></tr>',
      adminTableSubprojectTemplate: '<tr><td>{{Index}}</td><td>{{ProjectName}}</td><td>{{SubProjectName}}</td><td>{{TestCount}}</td></tr>'
    };
    return {
        render: function(template,data){
            var regExp;
            for(var temp in data){
                regExp = new RegExp("[{][{]" + temp + "[}][}]",'g');
                template = template.replace(regExp,data[temp]);
            }
            return template;
        },
        getLegendItem: function(){
            return templates.legendItem;
        },
        getPyramidItem: function(){
            return templates.pyramidItem;
        },
        getDefectErrorMessagesTemplate:function(){
          return templates.defectErrorMessagesTemplate;
        },
        getErrorListTemplate: function(){
          return templates.errorListTemplate;
        },
        getAdminTableProjectTemplate: function(){
            return templates.adminTableProjectTemplate;
        },
        getAdminTableSubProjectTemplate: function(){
            return templates.adminTableSubprojectTemplate;
        }

    };
};
