@ttv @javascript
Feature: Test Trend Visualization Flow

  Scenario: Pyramid Flow
    Given a User uploads data with following attributes
      | product_name | platform_name | version | branch  | ci_job_name          | ci_build_number | environment | browser_or_device    | os       | host_machine    | test_category | test_sub_category | test_report_type | execution_year | execution_month | execution_day | execution_hour | execution_minute | log_file     |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST     | UNIT TEST         | JUnit            | 2017           | January         | 1             | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 173             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST     | UNIT TEST         | JUnit            | 2017           | January         | 11            | 14             | 40               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 174             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST     | UNIT TEST         | JUnit            | 2017           | February        | 12            | 12             | 12               | Err_test.zip |
    When a team member checks Pyramid View of "ANDROID"
    Then the test Pyramid for "ANDROID" is generated
    Then the Pyramid table for "ANDROID" is generated

  Scenario: Comparative analysis Flow
    Given a User uploads data with following attributes
      | product_name | platform_name | version | branch  | ci_job_name          | ci_build_number | environment | browser_or_device    | os       | host_machine    | test_category    | test_sub_category | test_report_type | execution_year | execution_month | execution_day | execution_hour | execution_minute | log_file     |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST        | UNIT TEST         | JUnit            | 2017           | January         | 1             | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | INTEGRATION TEST | INTEGRATION TEST  | JUnit            | 2017           | January         | 1             | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | FUNCTIONAL TEST  | ACCEPTANCE TEST   | JUnit            | 2017           | February        | 1             | 12             | 12               | Err_test.zip |
    When a team member checks Comparative Analysis Graph of "PRODUCT1" and platform "ANDROID" with Date Range between "12-12-2016" and "12-12-2017"
    Then the comparative analysis graph for "PRODUCT1" is generated with Date Range between "2016-12-12" and "2017-12-12"

  Scenario:Defect analysis Flow
    Given a User uploads data with following attributes
      | product_name | platform_name | version | branch  | ci_job_name          | ci_build_number | environment | browser_or_device    | os       | host_machine    | test_category    | test_sub_category | test_report_type | execution_year | execution_month | execution_day | execution_hour | execution_minute | log_file     |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST        | UNIT TEST         | JUnit            | 2017           | January         | 19            | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | INTEGRATION TEST | INTEGRATION TEST  | JUnit            | 2017           | February        | 20            | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | FUNCTIONAL TEST  | ACCEPTANCE TEST   | JUnit            | 2017           | March           | 15            | 12             | 12               | Err_test.zip |
    When a team member checks Defect Analysis Graph of Product "PRODUCT1" and Platform "ANDROID" with test category as "ALL" and Date as "01-01-2017"
    Then the Defect Analysis table for "ANDROID" is plotted

  Scenario:Admin Page Details
    Given a User uploads data with following attributes
      | product_name | platform_name | version | branch  | ci_job_name          | ci_build_number | environment | browser_or_device    | os       | host_machine    | test_category    | test_sub_category | test_report_type | execution_year | execution_month | execution_day | execution_hour | execution_minute | log_file     |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST        | UNIT TEST         | JUnit            | 2017           | January         | 19            | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | INTEGRATION TEST | INTEGRATION TEST  | JUnit            | 2017           | February        | 20            | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | FUNCTIONAL TEST  | ACCEPTANCE TEST   | JUnit            | 2017           | March           | 15            | 12             | 12               | Err_test.zip |
    When a team member visits Admin Statistics Page
    Then all product information is generated in tabular format

  Scenario:Compare runs Flow
    Given a User uploads data with following attributes
      | product_name | platform_name | version | branch  | ci_job_name          | ci_build_number | environment | browser_or_device    | os       | host_machine    | test_category | test_sub_category | test_report_type | execution_year | execution_month | execution_day | execution_hour | execution_minute | log_file     |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST     | UNIT TEST         | JUnit            | 2017           | March           | 3             | 12             | 12               | Err_test.zip |
      | Product1     | Android       | 210     | release | android_release_test | 172             | local       | samsungj2, samsungj5 | 5.1, 7.0 | ci_machine_name | UNIT TEST     | UNIT TEST         | JUnit            | 2017           | March           | 5             | 12             | 12               | Err_test.zip |

    When a team member checks compare runs of "PRODUCT1" "ANDROID" "UNIT TEST" with Date as "2017-03-03 12:12:00" and "2017-03-05 12:12:00"
    Then the compare runs for "ANDROID" is plotted for Date "2017-03-03 12:12:00" and "2017-03-05 12:12:00"
