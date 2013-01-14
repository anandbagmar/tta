Feature: Upload data to view test pyramid and Comparative analysis graph



  @javascript
  Scenario: Test Pyramid Flow
  Scenario Outline: Uploading Data
    Given That the user visits the url "http://172.18.6.1:3000/"
    When The user navigates to "UPLOAD TEST DATA" page
    And The user submits project details with "<proj>","<sub_proj>","<ci_job>","<osName>","<hostName>","<browser>","<environment>","<dateOfExecution>","<logDir>","<test_type>"
    Then The project is uploaded
  Examples:
    |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                                                       |test_type       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Unit Test       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Integration Test|
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Functional Test |





  @javascript
  Scenario: Generating graph
    Given That the user visits the url "http://172.18.6.1:3000/"
    When The user navigates to "TEST PYRAMID VIEW" page
    Then "SUBPROJ1" is selected and the test Pyramid is generated




  @javascript
  Scenario: Comparative Analysis Flow
  Scenario Outline: Uploading Data
    Given That the user visits the url "http://172.18.6.1:3000/"
    When The user navigates to "UPLOAD TEST DATA" page
    And The user submits project details with "<proj>","<sub_proj>","<ci_job>","<osName>","<hostName>","<browser>","<environment>","<dateOfExecution>","<logDir>","<test_type>"
    Then The project is uploaded
  Examples:
    |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                                                       |test_type       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Unit Test       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Integration Test|
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Functional Test |
    |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Unit Test       |
    |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-03-31       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Integration Test|




  @javascript
  Scenario: Plotting graph
    Given That the user visits the url "http://172.18.6.1:3000/"
    When The user navigates to "COMPARATIVE ANALYSIS" page
    Then The user enters Date Range between "2012-01-01" and "2012-04-04" for "PROJECT1" and the graph is plotted