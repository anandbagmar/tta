describe("ValidateDate",function(){
    it("returns true on valid date input", function(){
        loadFixtures("date_form.html");
        var el = $(".spec-date").val("2012-12-12"),
            valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(true);
    });
    it("should return false no Date is passed",function(){
        loadFixtures("date_form.html");
        var el = $(".spec-date").val("");
        var valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(false);
    });
    it("should return false if date selected from future",function(){
        loadFixtures("date_form.html");
        var dateObj = new Date();
        var futureDate = (dateObj.getFullYear()+1).toString()+"-12-12";
        var el = $(".spec-date").val(futureDate),
            valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(false);
    });
    it("should return false if date is not in proper format (yyyy-mm-dd)",function(){
        loadFixtures("date_form.html");
        var el = $(".spec-date").val("12-12-2012"),
            valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(false);
    });
    it("should return false if month is greater than 12 (yyyy-mm-dd)",function(){
        loadFixtures("date_form.html");
        var el = $(".spec-date").val("2012-32-12"),
            valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(false);
    });
    it("should return false if day is greater than 31 (yyyy-mm-dd)",function(){
        loadFixtures("date_form.html");
        var el = $(".spec-date").val("2013-12-33");
        var valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(false);
    });
    it("should return false if invalid Input is passed (Characters)",function(){
        loadFixtures("date_form.html");
        var el = $(".spec-date").val("asdf-as-@@");
        var valid = el?Utils.validateDate($("#sample_date_form")):false;
        expect(valid).toBe(false);
    });
});