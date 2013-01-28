Feature: Comparative Analysis Graph Visualization

  @javascript
  Scenario: Comparative Analysis Flow

    Given The User uploads data with following attributes
      |proj    |sub_proj|ci_job       |osName |hostName |browser|environment|dateOfExecution  |logDir                                                                  |test_type       |
      |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/sample.zip                      |Unit Test       |
      |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-02-20       |/var/lib/go-agent/pipelines/Development/sample.zip                      |Integration Test|
      |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-03-15       |/var/lib/go-agent/pipelines/Development/sample.zip                      |Functional Test |
      |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/sample.zip                      |Unit Test       |
      |Project1|SubProj2|Run unit test|Mac    |Sanchar  |IE     |DEV        |2012-03-31       |/var/lib/go-agent/pipelines/Development/sample.zip                      |Integration Test|

    When the user checks the Comparative Analysis of "PROJECT1" with Date-Range between "1990-12-12" and "2012-12-12"
    Then the comparative analysis graph for "PROJECT1" is generated with Date Range between "1990-12-12" and "2012-12-12"
