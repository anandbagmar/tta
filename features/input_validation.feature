Feature: Input validation	
	@test1
	Scenario: User does not supply required fields in the defect analysis page		
		Given a user is on the "DEFECT_ANALYSIS" page
		When the user clicks the "Plot" button 
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project 	|
		|This field is required. 	| Analysis Date	|

	@test2
	Scenario: User supplies Sub-Project but not Analysis Date		

		Given a user is on the "DEFECT_ANALYSIS" page		
		When the user specifies a Subproject		
		And the user clicks the "Plot" button		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Analysis Date	|	

		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project	|

	@test3
	Scenario: User supplies Analysis Date but not Sub-project
		
		Given a user is on the "DEFECT_ANALYSIS" page		
		And the user specifies an Analysis Date		
		When the user clicks the "Plot" button
		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project	|

		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Analysis Date	|
	
	@test4
	Scenario: User supplies Analysis Date and  Sub-project
		
		Given a user is on the "DEFECT_ANALYSIS" page		
		When the user specifies a Subproject
		And the user specifies an Analysis Date		
		When the user clicks the "Plot" button
		
		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Analysis Date	|
		|This field is required. 	| Sub-Project	|