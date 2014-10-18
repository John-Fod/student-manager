Feature: Room Creation
  In order to organize my students
  As a teacher
  I want to create a room

Background:
  Given the following teachers:
    | name          | email                |
    | Akahige       | akahige@gmail.com    |

  Given the following schools:
  	| name				       | headmaster	|
  	| Akahige's School 	 | Akahige 		|


#----- SUCCESSFULLY FOUNDING A NEW ROOM
#--------------------------------------

  Scenario: A logged in user creates a room
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new room page for the school "Akahige's School"
  	And I fill in "room_name" with "X-men"
  	And I fill in "room_summary" with "These guys are a pain in the ass."
  	And I press "commit"
  	Then I should see a flash "notice" of "Room founding successful."
  	And I should see a page title of "X-men"

  Scenario: A logged in user creates a room and chooses to automatically schedule class sessions
    Given the following periods:
      | name        | school            | start_at        |
      | First       | Akahige's School  | 09              |
    And I am logged in as "akahige@gmail.com"
    When I am on the new room page for the school "Akahige's School"
    And I fill in "room_name" with "X-men"
    And I fill in "room_summary" with "These guys are a pain in the ass."
    And I select today's day of the week as the room's regular day
    And I select the period "First"
    And I check "autoschedule_class_sessions"
    And I choose the radio button "auto_schedule_period_1"
    And I press "commit"
    Then I should see a flash "notice" of "Room founding successful."
    And I should see a page title of "X-men"
    And I should see a class scheduled "1" week from today
    And I should see a class scheduled "2" week from today

#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to create a room without a name
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new room page for the school "Akahige's School"
  	And I fill in "room_name" with ""
  	And I fill in "room_summary" with "These guys are a pain in the ass."
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to create a room
    When I am on the new room page for the school "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: An invalid teacher attempts to create a room
    Given the following teachers:
    | name        | email             |
    | John        | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I am on the new room page for the school "Akahige's School"
    Then I should see a flash "alert" of "You do not have permission to edit that school."


#----- DIRECT USER INPUT PROTECTION
#----------------------------------

  Scenario: A logged in teacher attempts to create a room in a school that doens't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the new room page for the school "This School Doesn't Exist"
    Then I should see a flash "alert" of "That school does not exist."