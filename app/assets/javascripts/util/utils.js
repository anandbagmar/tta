var Utils={
    getRandomColor : function(){
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.round(Math.random() * 15)];
        }
        return color;
    }
};

var removeQuotsFromJSON = {
    removeQuots : function(jsonData){
        var regExp = new RegExp("&quot;", 'g');
        jsonData = jsonData.replace(regExp, "\"");
        return jsonData;
    }
};