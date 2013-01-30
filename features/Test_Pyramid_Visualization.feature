Feature: Test Pyramid Visualization

@javascript
Scenario: Test Pyramid Flow
  Given The User uploads data with following attributes
|proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logFile      |test_type       |
|Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |Err_test.zip |Unit Test       |
|Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |Err_test.zip |Integration Test|
|Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |Err_test.zip |Functional Test |
  When the user checks Pyramid View of "SUBPROJ1"
  Then the test Pyramid for "SUBPROJ1" is generated with layers of pyramid equal to legends displayed




#  @wip
#Scenario: Data prep
#  Given user is on the home page
#  When user uploads data with the following attributes
#  |table|
#  Then the user can see the test pyramid for sub-project
