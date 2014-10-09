Feature: Class Session Creation
  In order to create a schedule of classes
  As a teacher
  I want to create class sessions

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com   |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|

  Given the following rooms:
  	| name 				| school 			| founding_teacher 	|
  	| Room 1 			| Akahige's School  | Akahige 			|

  Given the following periods:
  	| name 				| school 			| start_at 				|
  	| First Period		| Akahige's School 	| 09 					|


#----- VIEWING THE PERIODS ON THE SCHOOL'S SHOW PAGE
#---------------------------------------------------
	
  Scenario: A valid user can see the periods on his school's show page
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the show school page for "Akahige's School"
  	Then I should see the text "First Period" in the element ".period-schedule .period-row td a"


#----- ADDING CLASS SESSION FROM THE SCHOOL'S SHOW PAGE
#------------------------------------------------------

  Scenario: A valid user can add class sessions from his school's show page
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the show school page for "Akahige's School"
  	And I quickly add room "Room 1" for period "First Period" and teacher "Akahige"
  	Then I should see a flash "notice" of "Class session was successfully created."
  	And I should see the text "Room 1" in the element ".period-schedule .period-row .class-session"