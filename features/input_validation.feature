Feature: Input validation	
	
	
	Scenario: User does not supply required fields on the defect analysis page		
		Given a user is on the "DEFECT ANALYSIS" page
		When the user clicks the "Plot" button 
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project 	|
		|This field is required. 	| Analysis Date	|

	
	Scenario: User supplies Sub-Project but not Analysis Date on the defect analysis page		

		Given a user is on the "DEFECT ANALYSIS" page		
		When the user specifies a Subproject		
		And the user clicks the "Plot" button		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Analysis Date	|	

		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project	|

	
	Scenario: User supplies Analysis Date but not Sub-project on the defect analysis page
		
		Given a user is on the "DEFECT ANALYSIS" page		
		And the user specifies the date -  "Analysis Date"		
		When the user clicks the "Plot" button
		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project 	|

		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Analysis Date	|
	
	
	Scenario: User supplies Analysis Date and  Sub-project on the defect analysis page
		
		Given a user is on the "DEFECT ANALYSIS" page		
		And the user specifies a Subproject
		And the user specifies the date -  "Analysis Date"		
		When the user clicks the "Plot" button		
		Then the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Analysis Date	|
		|This field is required. 	| Sub-Project	|


	
	Scenario: User does not supply sub-project on the Pyramid view page
		
		Given a user is on the "PYRAMID VIEW" page
		When the user clicks the "Plot" button
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project 	|

	
	
	Scenario: User supplies sub-project on the Pyramid view page
		
		Given a user is on the "PYRAMID VIEW" page
		And the user specifies a Subproject
		When the user clicks the "Plot" button
		Then the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project 	|

	
	
	Scenario: User does not supply dates and project on the Comparative Analysis Page	

		Given a user is on the "COMPARATIVE ANALYSIS" page
		When the user clicks the "Submit" button
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Start Date 	|
		|This field is required. 	| End Date 		|
		|This field is required. 	| Project 		|

	
	Scenario: User does not supply dates on the Comparative Analysis Page	
		Given a user is on the "COMPARATIVE ANALYSIS" page
		And the user specifies a Project
		When the user clicks the "Submit" button
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Start Date 	|
		|This field is required. 	| End Date 		|


	
	Scenario: User does not supply Project on the Comparative Analysis Page	
		Given a user is on the "COMPARATIVE ANALYSIS" page
		And the user specifies a Project
		When the user clicks the "Submit" button
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Start Date 	|
		|This field is required. 	| End Date 		|


	
	Scenario: Compare runs page scenario
		
		Given a user is on the "COMPARE RUNS" page
		When the user clicks the "Submit" button

		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Project 	    |

		Given the user specifies a Project
		When the user clicks the "Submit" button		

		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Sub-Project   |
		
		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Project 	    |


		Given the user specifies a Subproject
		When the user clicks the "Submit" button				
		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Test Types    |		
		
		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Project 	    |
		|This field is required. 	| Sub-Project   |

		
		Given the user specifies a Test Category
		When the user clicks the "Submit" button	
		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Date 1	    |
		
		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Project 	    |
		|This field is required. 	| Sub-Project   |
		|This field is required. 	| Test Types    |		


		Given the user specifies the date -  "Date 1"		
		When the user clicks the "Submit" button
		
		Then the user should see the message
		|message 					| field 		|
		|This field is required. 	| Date 2	    |

		And the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Project 	    |
		|This field is required. 	| Sub-Project   |
		|This field is required. 	| Test Types    |		
		|This field is required. 	| Date 1	    |


		Given the user specifies the date -  "Date 2"		
		When the user clicks the "Submit" button
		
		Then the user should not see the message
		|message 					| field 		|
		|This field is required. 	| Project 	    |
		|This field is required. 	| Sub-Project   |
		|This field is required. 	| Test Types    |		
		|This field is required. 	| Date 1	    |
		|This field is required. 	| Date 2	    |