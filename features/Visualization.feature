Feature: Upload data to view test pyramid ,Comparative analysis graph and Defect Analysis

  @javascript
  Scenario: Test Pyramid Flow
  Scenario Outline: Uploading Data
    Given That the user visits the url "http://localhost:3000/"
    When The user navigates to "UPLOAD TEST DATA" page
    And The user submits project details with "<proj>","<sub_proj>","<ci_job>","<osName>","<hostName>","<browser>","<environment>","<dateOfExecution>","<logDir>","<test_type>"
    Then The project is uploaded
  Examples:
    |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                                             |test_type       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/sample.zip |Unit Test       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/var/lib/go-agent/pipelines/Development/sample.zip |Integration Test|
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/var/lib/go-agent/pipelines/Development/sample.zip |Functional Test |

  @javascript
  Scenario: Generating graph
    Given That the user visits the url "http://localhost:3000/"
    And The user navigates to "TEST PYRAMID VIEW" page
    When "SUBPROJ1" is selected
    Then the test Pyramid for "SUBPROJ1" is generated with layers of pyramid equal to legends displayed

  @javascript
  Scenario: Blank Selection In Pyramid View
    Given That the user visits the url "http://localhost:3000/"
    When The user navigates to "TEST PYRAMID VIEW" page
    And The User clicks on the "Plot" button
    Then error message should be displayed

  @javascript
  Scenario: Blank Selection In Defect Analysis
    Given That the user visits the url "http://Localhost:3000"
    When The user navigates to "DEFECT ANALYSIS" page
    And The User clicks on the "Plot" button
    Then error message for defect analysis should be displayed


   @wip
  Scenario: Error-Message Checking On UPLOAD PAGE
    Given That the user visits the url "http://localhost:3000"
    And The user navigates to "UPLOAD TEST DATA" page
    When The user submits project details with "proj1","sub_proj1","ci_job1","osName1","hostName1","browser1","environment1","dateOfExecution1","/var/lib/go-agent/pipelines/Development/sample.zip","test_type1"
    And The User clicks on the "Clear All" button
    And The User clicks on the "submit_button" button
    Then Appropriate Error Messages are displayed

  @javascript
  Scenario: Comparative Analysis Flow
  Scenario Outline: Uploading Data
    Given That the user visits the url "http://localhost:3000/"
    When The user navigates to "UPLOAD TEST DATA" page
    And The user submits project details with "<proj>","<sub_proj>","<ci_job>","<osName>","<hostName>","<browser>","<environment>","<dateOfExecution>","<logDir>","<test_type>"
    Then The project is uploaded
  Examples:
    |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                                             |test_type       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/sample.zip |Unit Test       |
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/var/lib/go-agent/pipelines/Development/sample.zip |Integration Test|
    |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/var/lib/go-agent/pipelines/Development/sample.zip |Functional Test |
    |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/sample.zip |Unit Test       |
    |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-03-31       |/var/lib/go-agent/pipelines/Development/sample.zip |Integration Test|

  @wip
  @javascript
  Scenario: Plotting graph
    Given That the user visits the url "http://localhost:3000/"
    And The user navigates to "COMPARATIVE ANALYSIS" page
    When The user enters Date Range between "2012-01-01" and "2012-04-04" for "PROJECT1"
    Then the graph is plotted with the "PROJECT1"
    And Start Date and End Date as "2012-01-01" and "2012-04-04" respectively

    @javascript
    Scenario: Error-Messages Check on COMPARATIVE ANALYSIS PAGE
      Given That the user visits the url "http://localhost:3000"
      And The user navigates to "COMPARATIVE ANALYSIS" page
      When The User clicks on the "Plot" button
      Then Error messages should be seen




