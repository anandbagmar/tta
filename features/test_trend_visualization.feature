@ttv
Feature: Test Trend Visualization Flow

  @javascript

  Scenario: Pyramid Flow
    Given a User uploads data with following attributes
      | proj     | sub_proj | ci_job        | osName | hostName | browser | environment | date_year | date_month | date_day | date_hour | date_minute | logFile      | test_type        | test_report_type | test_sub_type    |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | January    | 1        | 12        | 12          | Err_test.zip | UNIT TEST        | JUnit            | UNIT TEST        |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | February   | 20       | 12        | 12          | Err_test.zip | INTEGRATION TEST | JUnit            | INTEGRATION TEST |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | March      | 15       | 12        | 12          | Err_test.zip | FUNCTIONAL TEST  | JUnit            | REGRESSION TEST  |
    When a team member checks Pyramid View of "SERRORS1"
    Then the test Pyramid for "SERRORS1" is generated
    Then the Pyramid table for "SERRORS1" is generated

  Scenario: Comparative analysis Flow
    Given a User uploads data with following attributes
      | proj     | sub_proj | ci_job        | osName | hostName | browser | environment | date_year | date_month | date_day | date_hour | date_minute | logFile      | test_type        | test_report_type | test_sub_type    |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | January    | 1        | 12        | 12          | Err_test.zip | UNIT TEST        | JUnit            | UNIT TEST        |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | February   | 20       | 12        | 12          | Err_test.zip | INTEGRATION TEST | JUnit            | INTEGRATION TEST |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | March      | 15       | 12        | 12          | Err_test.zip | FUNCTIONAL TEST  | JUnit            | REGRESSION TEST  |

    When a team member checks Comparative Analysis Graph of "PROJECT1" with Date Range between "2011-12-12" and "2012-12-12"
    Then the comparative analysis graph for "PROJECT1" is generated with Date Range between "2011-12-12" and "2012-12-12"


  Scenario:Defect analysis Flow
    Given a User uploads data with following attributes
      | proj     | sub_proj | ci_job        | osName | hostName | browser | environment | date_year | date_month | date_day | date_hour | date_minute | logFile      | test_type        | test_report_type | test_sub_type    |
      | PROJECT1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | January    | 1        | 12        | 12          | Err_test.zip | UNIT TEST        | JUnit            | UNIT TEST        |
      | PROJECT1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | February   | 20       | 12        | 12          | Err_test.zip | INTEGRATION TEST | JUnit            | INTEGRATION TEST |
      | PROJECT1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | March      | 15       | 12        | 12          | Err_test.zip | FUNCTIONAL TEST  | JUnit            | REGRESSION TEST  |
    When a team member checks Defect Analysis Graph of Project "PROJECT1" and Sub-Project "SERRORS1" with test category as "ALL" and Date as "2012-01-01"
    Then the Defect Analysis table for "SERRORS1" is plotted

  Scenario:Admin Page Details
    Given a User uploads data with following attributes
      | proj     | sub_proj | ci_job        | osName | hostName | browser | environment | date_year | date_month | date_day | date_hour | date_minute | logFile      | test_type        | test_report_type | test_sub_type    |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | January    | 1        | 12        | 12          | Err_test.zip | UNIT TEST        | JUnit            | UNIT TEST        |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | February   | 20       | 12        | 12          | Err_test.zip | INTEGRATION TEST | JUnit            | INTEGRATION TEST |
      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2012      | March      | 15       | 12        | 12          | Err_test.zip | FUNCTIONAL TEST  | JUnit            | REGRESSION TEST  |
    When a team member visits Admin Statistics Page
    Then all project's information is generated in tabular format

#  Scenario:Compare runs Flow
#    Given a User uploads data with following attributes
#      | proj     | sub_proj | ci_job        | osName | hostName | browser | environment | date_year | date_month | date_day | date_hour | date_minute | logFile      | test_type | test_report_type |
#      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2013      | March      | 3        | 12        | 12          | Err_test.zip | Unit Test |  JUnit      |
#      | Project1 | SERRORS1 | Run unit test | Mac    | Sailee   | IE      | DEV         | 2013      | March      | 5        | 12        | 12          | Err_test.zip | Unit Test |  JUnit      |
#    When a team member checks compare runs of "PROJECT1" "SERRORS1" "UNIT TEST" with Date as "2013-03-03 12:12:00" and "2013-03-05 12:12:00"
#    Then the compare runs for "SERRORS1" is plotted for Date ""2013-03-03 12:12:00 "" and ""2013-03-05 12:12:00 ""





