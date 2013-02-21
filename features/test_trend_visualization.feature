Feature: Test Trend Visualization Flow

@javascript
Scenario: Complete Visualization Flow
  Given The User uploads data with following attributes
|proj    |sub_proj|ci_job       |osName |hostName |browser|environment|date_year|date_month|date_day|date_hour|date_minute  |logFile      |test_type       |
|Project1|SERRORS1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |January   |1       |12       |    12       |Err_test.zip |Unit Test       |
|Project1|SERRORS1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |February  |20      |12       |    12       |Err_test.zip |Integration Test|
|Project1|SERRORS1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012     |March     |15      |12       |    12       |Err_test.zip |Functional Test |
  When the user checks Pyramid View of "SERRORS1"
  Then the test Pyramid for "SERRORS1" is generated with layers of pyramid equal to legends displayed

  When User checks Defect Analysis Graph of "SERRORS1" with Date as "2012-01-01"
  Then the Defect Analysis table for "SERRORS1" is plotted

  When the user checks the Comparative Analysis of "PROJECT1" with Date-Range between "1990-12-12" and "2012-12-12"
  Then the comparative analysis graph for "PROJECT1" is generated with Date Range between "1990-12-12" and "2012-12-12"



