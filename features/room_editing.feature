Feature: Room Editing
  In order to update my rooms
  As a teacher
  I want to edit a room

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


#----- SUCCESSFULLY EDITING A NEW ROOM
#-------------------------------------

  Scenario: A logged in user edits a room
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the edit room page for the school "Akahige's School" and the room "Room 1"
  	And I fill in "room_name" with "First Room"
  	And I fill in "room_summary" with "This was the first the room, it needs a better name."
  	And I press "commit"
  	Then I should see a flash "notice" of "Room update successful."
  	And I should see a page title of "First Room"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to edit a room without a name
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the edit room page for the school "Akahige's School" and the room "Room 1"
  	And I fill in "room_name" with ""
  	And I fill in "room_summary" with "These guys are a pain in the ass."
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to edit a room
    When I am on the edit room page for the school "Akahige's School" and the room "Room 1"
    Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: An invalid teacher attempts to edit a room
    Given the following teachers:
    | name        | email             |
    | John        | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I am on the edit room page for the school "Akahige's School" and the room "Room 1"
    Then I should see a flash "alert" of "You do not have permission to edit that school."


#----- DIRECT USER INPUT PROTECTION
#----------------------------------

  Scenario: A logged in teacher attempts to edit a room in a school that doens't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit room page for the school "Non-School" and the room "Room 1"
    Then I should see a flash "alert" of "That school does not exist."
    And I should see a page title of "Akahige"

  Scenario: A logged in teacher attempts to edit a room that doesn't exist in a school that does
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit room page for the school "Akahige's School" and the room "Non-Room"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "That room does not exist."

  Scenario: A logged in teacher attempts to edit a room in a school the room doesn't belong to
  	Given the following schools:
  	| name				    | headmaster	|
  	| Second School 	| Akahige 		|
  	And I am logged in as "akahige@gmail.com"
    When I am on the edit room page for the school "Second School" and the room "Room 1"
    Then I should see a page title of "Second School"
    And I should see a flash "alert" of "That room does not exist."