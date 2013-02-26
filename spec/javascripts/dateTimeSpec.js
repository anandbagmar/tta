//= require 'jquery'

describe("ValidateDate",function(){
    it("returns true on valid date for February during a non-leap year", function(){
        loadFixtures("feb_non_leap_year_valid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(true);
    });
    it("returns false on wrong date for February during a non-leap year", function(){
        loadFixtures("feb_non_leap_year_invalid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
    it("returns true on valid date for February during a leap year", function(){
        loadFixtures("feb_leap_year_valid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(true);
    });
    it("returns false on wrong date for February during a leap year", function(){
        loadFixtures("feb_leap_year_invalid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
    it("returns true on valid day", function(){
        loadFixtures("valid_date_check.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(true);
    });
    it("returns false on invalid day", function(){
        loadFixtures("invalid_date_check.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
});
