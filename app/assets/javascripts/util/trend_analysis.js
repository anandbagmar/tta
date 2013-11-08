var ValidateStartDateIsLessThanEndDate = {

    checkForDates:function (form) {

        var valid = true;
        var start_date = form.find(".required-field-date-field").find('input[id$="start_date"]').val();
        var end_date = form.find(".required-field-date-field").find('input[id$="end_date"]').val();

        if (start_date >= end_date && start_date != "" && end_date != "")
            valid = false;

        var errMsg = form.find('.errormsg');
        if (valid == false)
            $(errMsg).show();
        else
            $(errMsg).hide();

        return valid;
    }
};

var Graph = {
    plot:function (start_date, end_date, result_set, y_axis_max_value, placeholder) {
        st_date = new Date(start_date);
        start_time = st_date.getTime()
        ed_date = new Date(end_date);
        end_time = ed_date.getTime()
        var data = [];
        var milli_second_per_day = 86400000;
        var multiple = ((end_time - start_time) / milli_second_per_day) / 10;
        if (multiple > 1)
            milli_second_per_day = milli_second_per_day * multiple;
        for (var index = start_time; index <= end_time; index += milli_second_per_day)
            data.push(index);
        var tick_set = [];
        for (var i = 0; i < data.length; i++) {
            tick_set.push(data[i]);
        }
        var data = [];
        resultData = jsonData.parse(result_set);
        for (sub_project in resultData) {
            data.push({
                label:sub_project,
                data:resultData[sub_project],
                lines:{show:true },
                points:{show:true},
                color:"#" + ((1 << 24) * Math.random() | 0).toString(16)
            });
        }
        $.plot($(placeholder),
            data,
            {
                xaxis:{
                    mode:"time",
                    ticks:tick_set,
                    timeformat:"%d-%b , %y",
                    minTickSize:[1, "year"],
                    min:start_time,
                    max:end_time + milli_second_per_day,
                    labelMargin:50,
                    timeZoneOffset:(new Date()).getTimezoneOffset()
                },
                yaxis:{
                    min:0,
                    max:y_axis_max_value,
                    labelMargin:30
                },
                grid:{
                    borderWidth:0,
                    hoverable:true,
                    clickable:true,
                    labelMargin:1,
                    mouseActiveRadius:8,
                    backgroundColor:{ colors:["#fff", "#eee"] },
                    minBorderMargin:40
                },
                legend:{
                    position:"ne",
                    show:true,
                    container:'#legendlabel'
                }

            }
        );

        function showTooltip(x, y, contents) {
            $('<div id="tooltip">' + contents + '</div>').css({
                position:'absolute',
                display:'none',
                top:y + 5,
                left:x + 5,
                border:'1px solid #fdd',
                padding:'2px',
                'background-color':'#fee',
                opacity:0.80
            }).appendTo("body").fadeIn(200);
        }

        var previousPoint = null;
        $(placeholder).bind("plothover", function (event, pos, item) {
            if (item) {
                if (previousPoint != item.dataIndex) {
                    previousPoint = item.dataIndex;
                    $("#tooltip").remove();
                    var x = new Date(item.datapoint[0]).toGMTString();
                    var y = item.datapoint[1].toPrecision(4);
                    var label = item.series.label;
                    showTooltip(item.pageX, item.pageY,label + " [ " + x + " , " + y + " % ]");
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;
            }
        });

    }

};