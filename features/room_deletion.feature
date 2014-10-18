Feature: Room DELETION
  In order to remove rooms I no longer need
  As a teacher
  I want to delete a room

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|

  Given the following rooms:
  	| name 				| school 			| founding_teacher 	|
  	| Room 1 			| Akahige's School  | Akahige 			|


#----- SUCCESSFULLY DELETING A NEW ROOM
#--------------------------------------

  Scenario: A logged in user deletes a room
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the delete room page for the school "Akahige's School" and the room "Room 1"
  	And I follow "confirm_deletion"
  	Then I should see a flash "notice" of "Room deletion successful."
  	And I should see a page title of "Akahige's School"




#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to delete a room
  	When I am on the delete room page for the school "Akahige's School" and the room "Room 1"
    Then I should see a page title of "Log In"
    And I should see a flash "alert" of "You must be logged in to do that."

  Scenario: An invalid teacher attempts to delete a room
  	Given the following teachers:
      | name       | email             |
      | John       | john@gmail.com    |
    And I am logged in as "john@gmail.com"
  	When I am on the delete room page for the school "Akahige's School" and the room "Room 1"
    Then I should see a page title of "John"
    And I should see a flash "alert" of "You do not have permission to edit that school."

  Scenario: An invalid teacher attempts to delete a room he doesn't own in a school he does
  	Given the following teachers:
      	| name       | email             |
      	| John       | john@gmail.com    |
    And the following schools:
  		| name				| headmaster	|
  		| John's School 	| John 		|
    And I am logged in as "john@gmail.com"
  	When I am on the delete room page for the school "John's School" and the room "Room 1"
    Then I should see a page title of "John's School"
    And I should see a flash "alert" of "That room does not exist."

  Scenario: An invalid teacher attempts to delete a room he owns in a school he doesn't
  	Given the following teachers:
      	| name       | email             |
      	| John       | john@gmail.com    |
    And the following schools:
  		| name				| headmaster|
  		| John's School 	| John 		|
  	And the following rooms:
  	| name 				| school 			| founding_teacher 	|
  	| John's Room		| John's School  	| John 			|
    And I am logged in as "john@gmail.com"
  	When I am on the delete room page for the school "Akahige's School" and the room "John's Room"
    Then I should see a page title of "John"
    And I should see a flash "alert" of "You do not have permission to edit that school."


#----- DIRECT USER INPUT PROTECTION
#----------------------------------

  Scenario: A logged in teacher attempts to delete a room in a school that doens't exist

  Scenario: A logged in teacher attempts to delete a room that doesn't exist in a school that does

  Scenario: A logged in teacher attempts to delete a room in a school the room doesn't belong to