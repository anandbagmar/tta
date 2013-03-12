var Utils={
    getRandomColor : function(){
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.round(Math.random() * 15)];
        }
        return color;
    },
    ajaxRequest: function(options){
        $.ajax({
            url:options.url,
            data:options.data||{},
            type:options.type || "GET",
            dataType: options.type || 'json',
            success: options.successCallback||function(){},
            failure: options.failureCallback||function(){}
        });
    }
};

var makeValidJSON = {
    validate : function(jsonData){
        var regExpQuote = new RegExp("&quot;", 'g'),
            regExpBackSlash = new RegExp("[\\\\]", 'g');
        jsonData = jsonData.replace(regExpQuote, "\"");
        jsonData = jsonData.replace(regExpBackSlash, "\\\\");
        jsonData = jsonData.replace(/[\n \t\r]+/g, ' ');
      return jsonData;
    }

};