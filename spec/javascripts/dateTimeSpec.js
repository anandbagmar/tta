//= require 'jquery'

describe("ValidateDate", function () {
    it("returns true on valid date for February during a non-leap year", function () {
        loadFixtures("feb_non_leap_year_valid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(true);
    });
    it("returns false on wrong date for February during a non-leap year", function () {
        loadFixtures("feb_non_leap_year_invalid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
    it("returns true on valid date for February during a leap year", function () {
        loadFixtures("feb_leap_year_valid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(true);
    });
    it("returns false on wrong date for February during a leap year", function () {
        loadFixtures("feb_leap_year_invalid_date.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
    it("returns true on valid day", function () {
        loadFixtures("valid_date_check.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(true);
    });
    it("returns false on invalid day", function () {
        loadFixtures("invalid_date_check.html");
        var valid = validateDate.checkForValidDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
    it("returns false for entering future date", function () {
        loadFixtures("future_date.html");
        var valid = validateDate.checkForFutureDate($("#uploadForm"));
        expect(valid).toBe(false);
    });
    it("returns true     for entering future date", function () {
        loadFixtures("valid_date_check.html");
        var valid = validateDate.checkForFutureDate($("#uploadForm"));
        expect(valid).toBe(true);
    });

});


describe("ValidateStartDateIsLessThanEndDate", function () {
    it("returns true if start date is less than end date", function () {
        loadFixtures("start_date_less_than_end_date.html");
        var valid = ValidateStartDateIsLessThanEndDate.checkForDates($("#comparative-analysis-form"));
        expect(valid).toBe(true);
    });

    it("returns false if end date is less than start date", function () {
        loadFixtures("end_date_less_than_start_date.html");
        var valid = ValidateStartDateIsLessThanEndDate.checkForDates($("#comparative-analysis-form"));
        expect(valid).toBe(false);
    });


    it("returns false if end date is equal to start date", function () {
        loadFixtures("end_date_equal_to_start_date.html");
        var valid = ValidateStartDateIsLessThanEndDate.checkForDates($("#comparative-analysis-form"));
        expect(valid).toBe(false);
    });

});
