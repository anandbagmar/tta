Feature: Defect Analysis

  Scenario: Defect Analysis Flow

    Given The User uploads data with following attributes
      |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                                               |test_type       |
      |Project1|SErrors1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-12-12       |/var/lib/go-agent/pipelines/Development/sample.zip |Unit Test       |
    When User checks Defect Analysis Graph of "SERRORS1" with Date as "2012-12-12"
    Then the Defect Analysis table for "SERRORS1" is plotted




#    When the user checks the Comparative Analysis of "PROJECT1" with Date-Range between "2012-01-01" and "2012-04-04"
#    Then the comparative analysis graph for "PROJECT1" is generated with Date Range between "2012-01-01" and "2012-04-04"





#
#  @javascript
#  Scenario: Defect Analysis Flow
#    Given That the user visits the url "http://localhost:3000/"
#    And The user navigates to "UPLOAD TEST DATA" page
#    When The user submits project details with "error_file","serror_file","unit test","mac","Sailee","IE","DEV","2012-01-01","/Users/sanchari/Desktop/Copy of new_test.xml.zip","Unit Test"
#    And The user navigates back to "DEFECT ANALYSIS" page
#    And The user selects "SERROR_FILE" as Sub-Project with "2012-01-01" as Analysis Date
#    Then the Defect Analysis table for "SERROR_FILE" is plotted
