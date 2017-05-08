var Utils = {
    getRandomColor: function () {
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.round(Math.random() * 15)];
        }
        return color;
    },
    ajaxRequest: function (options) {
        $.ajax({
            url: options.url,
            data: options.data || {},
            type: options.type || "GET",
            dataType: options.dataType || 'json',
            success: options.successCallback || function () {
            },
            failure: options.failureCallback || function () {
            }
        });
    },
    loadDropDown: function (Selector, id, value, text, class_name) {
        $(Selector).append(
            $("<option></option>")
                .attr("id", id)
                .attr("value", value)
                .text(text)
                .attr("class", class_name)
        )
    },

    removeAttribute: function (Selector, attribute_name) {
        $(Selector).removeAttr(attribute_name);
    }

};

var jsonData = {
    parse: function (jsonData) {
        var regExpQuote = new RegExp("&quot;", 'g'),
            regExpGreaterThan = new RegExp("=&gt;", 'g'),
            regExpLessThan = new RegExp("=&lt;", 'g'),
            regExpBackSlash = new RegExp("[\\\\]", 'g');
        jsonData = jsonData.replace(regExpQuote, "\"");
        jsonData = jsonData.replace(regExpBackSlash, "\\\\");
        jsonData = jsonData.replace(regExpGreaterThan, ":");
        jsonData = jsonData.replace(regExpLessThan, ":");
        jsonData = jsonData.replace(/[\n \t\r]+/g, ' ');
        jsonData = JSON.parse(jsonData);
        return jsonData;
    }

};