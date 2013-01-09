Feature: Upload data to view test pyramid and Comparative analysis graph

  Scenario: Test Pyramid Flow
  Scenario Outline: Uploading Data
    Given That the user visits the url "http://172.18.6.1:3000"
    When The user navigates to "UPLOAD TEST DATA" page
    And The user submits project details with "<proj>","<sub_proj>","<ci_job>","<osName>","<hostName>","<browser>","<environment>","<dateOfExecution>","<logDir>","<test_type>"
    Then The project is uploaded
  Examples:
      |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                         |test_type       |
      |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Unit Test       |
      |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Integration Test|
      |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Functional Test |

  Scenario: Generating graph
    Given The user navigates to "TEST PYRAMID VIEW" page
    When "SUBPROJ1" is selected
    Then the test Pyramid is generated

  Scenario: Comparative Analysis Flow
  Scenario Outline: Uploading Data
    Given That the user visits the url "http://172.18.6.1:3000"
    When The user navigates to "UPLOAD TEST DATA" page
    And The user submits project details with "<proj>","<sub_proj>","<ci_job>","<osName>","<hostName>","<browser>","<environment>","<dateOfExecution>","<logDir>","<test_type>"
    Then The project is uploaded
  Examples:
    |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                         |test_type       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Unit Test       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Integration Test|
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Functional Test |
    |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-01-01       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Unit Test       |
    |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-03-31       |/home/tta/Desktop/cuke_running/tta_12spec_results.zip|Integration Test|
  Scenario: Plotting graph
    Given The user navigates to "COMPARATIVE ANALYSIS" page
    When The user enters Date Range between "2012-01-01" and "2012-04-04" for "PROJECT1"
    Then The graph is plotted




