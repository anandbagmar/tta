var Template = function(){
    var templates = {
        legendItem:'<div id={{TestType}}><div id={{TestTypeRect}}></div><span>{{TestTypeTitle}}</span></div>',
        pyramidItem:'<div id={{TestTypeRegion}}><span id={{TestTypePercent}}>{{PercentValue}} %</span><span id={{TestTypeDuration}}>{{DurationValue}} Mins</span><div id={{TestTypeTest}}></div></div>'
//                                                    <div id="integration_region">
//                                                        <% if @percent_integration_test!="0.00" %>
//                                                            <p id="integration_percent">
//                                                                <%= @percent_integration_test %>%
//                                                                    </p>
//                                                                        <p id="integration_duration">
//                                                                            <%= @duration_integration %>Mins
//                                                                                </p>
//                                                                                    <% end %>
//                                                                                        <div id="integration_test">
//                                                                                            <div id="functional_region">
//                                                                                                <% if @percent_functional_test!="0.00" %>
//                                                                                                    <p id="functional_percent"><%= @percent_functional_test %>%</p>
//                                                                                                    <p id="functional_duration"><%= @duration_functional %>Mins</p>
//                                                                                                <% end %>
//                                                                                                    <div id="functional_test"></div>
//                                                                                            </div>
//                                                                                        </div>
//                                                </div>
//                                            </div>
//            </div>
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
