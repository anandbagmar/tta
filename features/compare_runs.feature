Feature: Compare Runs

Scenario: No failures on either days
	
	Given the following failure pattern
	|day1		|day2	|
	|none		|none	|		
	
	When I compare the runs
	
	Then I see the following failures listed
	|day1	| day2	| combined	| common	|
	|none	| none	| none		| none		|

Scenario: Failures only on day 1
	
	Given the following failure pattern
	|day1		|day2	|
	|class_001	|		|
	|class_002	|		|
	|class_003	|		|
	|class_004	|		|
	
	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2	| combined	| common	|
	|class_001	| none	| class_001	| none		|
	|class_002	|		| class_001	|			|
	|class_003	|		| class_001	|			|
	|class_004	|		| class_001	|			|


Scenario: Failures only on day 2

	Given the following failure pattern
	|day1		|day2		|
	|none		|class_001	|
	|			|class_002	|
	|			|class_003	|
	|			|class_004	|
	
	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined	| common	|
	|none		| class_001	| class_001	| none		|
	|			| class_002	| class_001	|			|
	|			| class_003	| class_001	|			|
	|			| class_004	| class_001	|			|

	
Scenario: Same failures on both days

	Given the following failure pattern
	|day1		|day2		|
	|class_001	|class_001	|
	|class_002	|class_002	|
	|class_003	|class_003	|
	|class_004	|class_004	|
	
	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined	| common	|
	|class_001	| class_001	| class_001	| class_001 |
	|class_002	| class_002	| class_002	| class_002	|
	|class_003	| class_003	| class_003	| class_003	|
	|class_004	| class_004	| class_004	| class_004	|


Scenario: Mutually exclusive failures

	Given the following failure pattern
	|day1		|day2		|
	|class_001	|class_003	|
	|class_002	|class_004	|
	
	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined	| common	|
	|class_001	| class_003	| class_001	| none		|
	|class_002	| class_004	| class_002	| 			|
	|			| 			| class_003	| 			|
	|			| 			| class_004	| 			|


Scenario: Some common failures

	Given the following failure pattern
	|day1		|day2		|
	|class_001	|class_003	|
	|class_002	|class_004	|
	|class_003	|class_005	|
	|class_004	|class_006	|

	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined	| common	|
	|class_001	| class_003	| class_001	| none		|
	|class_002	| class_004	| class_002	| 			|
	|class_003	| class_005	| class_003	| 			|
	|class_004	| class_006	| class_004	| 			|
	|			|			| class_005	|			|
	|			|			| class_006	|			|


Scenario: Day 1 failures are a subset of Day 2 failures

	Given the following failure pattern
	|day1		|day2		|
	|class_001	|class_001	|
	|class_002	|class_002	|
	|			|class_003	|
	|			|class_004	|

	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined	| common	|
	|class_001	| class_001	| class_001	| class_001	|
	|class_002	| class_002	| class_002	| class_002	|
	|			| class_003	| class_003	| 			|
	|			| class_004	| class_004	| 			|



Scenario: Day 2 failures are a subset of Day 1 failures

	Given the following failure pattern
	|day1		|day2		|
	|class_001	|class_001	|
	|class_002	|class_002	|
	|class_003	|			|
	|class_004	|			|

	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined	| common	|
	|class_001	| class_001	| class_001	| class_001	|
	|class_002	| class_002	| class_002	| class_002	|
	|class_003	| 			| class_003	| 			|
	|class_004	| 			| class_004	| 			|

