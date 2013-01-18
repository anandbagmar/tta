var Template = function(){
    var templates = {
        legendItem:'<div class="test-legend" id={{TestType}}><div class="rect" id={{TestTypeRect}}></div><span>{{TestTypeTitle}}</span></div>',
        pyramidItem:'<div class="test-region" id={{TestTypeRegion}}>' +
            '<span id={{TestTypePercent}}>{{PercentValue}} %</span>' +
            '<span id={{TestTypeDuration}}>{{DurationValue}} Seconds</span>' +
            '<div class="test-triangle" id={{TestTypeTest}}></div>' +
          '</div>'
    };
    return {
        render: function(template,data){
            var regExp;
            for(var temp in data){
                regExp = new RegExp("[{][{]" + temp + "[}][}]",'g');
                template = template.replace(regExp,"'"+ data[temp] +"'");
            }
            return template;
        },
        getLegendItem: function(){
            return templates.legendItem;
        },
        getPyramidItem: function(){
            return templates.pyramidItem;
        }
    };
};
