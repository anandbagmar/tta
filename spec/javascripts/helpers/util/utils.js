var Utils={
    getRandomColor : function(){
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.round(Math.random() * 15)];
        }
        return color;
    },
    validateDate : function($form){
        var valid = true;
        if(!$form)
            valid = false;
        var dates = $form.find(".date-field>input[type='text']");
        for(index=0,len=dates.length;index<len;index++){
            var dateFields = (dates[index].value).split('-'),
                today = new Date(),
                datePassed = new Date(dates[index].value);
            if(dateFields.length != 3 ){
                valid = false;
            }
            if(!parseInt(dateFields[0])||!parseInt(dateFields[1])||!parseInt(dateFields[2])){
                valid=false;
            }
            if(parseInt(dateFields[0]) > parseInt(today.getFullYear()) || parseInt(dateFields[0]) < 1900){
                valid = false;
            }
            if(parseInt(dateFields[1]) > 12 || parseInt(dateFields[1]) < 1){
                valid=false;
            }
            if(parseInt(dateFields[2]) > 31 || parseInt(dateFields[2]) < 1){
                valid = false;
            }
            if(datePassed.getTime()>today.getTime()){
                valid = false;
            }
            if(valid === false){
                dates.siblings('.error-msg').show();
                return valid;
            }
        }
        return valid;
    }
};