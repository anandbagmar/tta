Feature: Upload data to view test pyramid

  Scenario: Hitting homepage through URL
    Given That the user enters "http://172.18.6.1:3000"
    Then  "Testing Trend Analysis" homepage should be open

    Given The user navigates to "UPLOAD TEST DATA" page
    When The user submits project details with "Unit Test" as test type
    Then "Project Successfully Saved!!" page is shown and the user navigates back to "HOME"

    Given The user navigates to "UPLOAD TEST DATA" page
    When The user submits project details with "Integration Test" as test type
    Then "Project Successfully Saved!!" page is shown and the user navigates back to "HOME"

    Given The user navigates to "UPLOAD TEST DATA" page
    When The user submits project details with "Functional Test" as test type
    Then "Project Successfully Saved!!" page is shown and the user navigates back to "HOME"

    Given The user navigates to "TEST PYRAMID VIEW" page
    When "SUBPROJ1" is selected
    Then the test Pyramid is generated

