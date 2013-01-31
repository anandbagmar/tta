Feature: Defect Analysis

  Scenario: Defect Analysis Flow

    Given The User uploads data with following attributes
      |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logFile     |test_type       |
      |Project1|SErrors1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-12-12       |Err_test.zip|Unit Test       |
    When User checks Defect Analysis Graph of "SERRORS1" with Date as "2012-12-12"
    Then the Defect Analysis table for "SERRORS1" is plotted





