Feature: Test Pyramid Visualization

@javascript
Scenario: Test Pyramid Flow1
  Given The User uploads data with following attributes
|proj    |sub_proj|ci_job       |osName |hostName |browser|environment|date_year|date_month|date_day|date_hour|date_minute  |logFile      |test_type       |
|Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |January   |1       |12       |    12       |Err_test.zip |Unit Test       |
|Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |February  |20      |12       |    12       |Err_test.zip |Integration Test|
|Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |March     |15      |12       |    12       |Err_test.zip |Functional Test |
  When the user checks Pyramid View of "SUBPROJ1"
  Then the test Pyramid for "SUBPROJ1" is generated with layers of pyramid equal to legends displayed


  Scenario: Test Pyramid Flow2
    Given The User uploads data with following attributes
      |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|date_year|date_month|date_day|date_hour|date_minute  |logFile      |test_type       |
      |Projectabc|SubProjabc|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |January   |1       |12       |    12       |Err_test.zip |123       |

    When the user checks Pyramid View of "SUBPROJABC"
    Then the appropriate error message is displayed for "SUBPROJABC"



