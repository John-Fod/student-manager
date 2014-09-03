Feature: Room Creation
  In order to organize my students
  As a teacher
  I want to create a room

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|


#----- SUCCESSFULLY FOUNDING A NEW ROOM
#--------------------------------------

  Scenario: A logged in user founds a school
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new room page for the school "Akahige's School"
  	And I fill in "room_name" with "X-men"
  	And I fill in "room_summary" with "These guys are a pain in the ass."
  	And I press "commit"
  	Then I should see a flash "notice" of "Room founding successful."
  	And I should see a page title of "X-men"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to found a school without a name
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new room page for the school "Akahige's School"
  	And I fill in "room_name" with ""
  	And I fill in "room_summary" with "These guys are a pain in the ass."
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to found a school
    When I am on the new room page for the school "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."