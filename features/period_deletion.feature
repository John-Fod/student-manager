Feature: Period DELETION
  In order to remove periods I no longer need
  As a teacher
  I want to delete a period

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|

  Given the following periods:
  	| name 				    | school 			            | start_at 				|
  	| First Period			| Akahige's School 		    	| 09 				    |


#----- SUCCESSFULLY DELETING A PERIOD
#--------------------------------------

  Scenario: A logged in user deletes a period
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the delete period page for the school "Akahige's School" and the period "First Period"
  	And I follow "confirm_deletion"
  	Then I should see a flash "notice" of "Period was successfully deleted."
  	And I should see a page title of "Akahige's School"




#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to delete a period
  	When I am on the delete period page for the school "Akahige's School" and the period "First Period"
    Then I should see a page title of "Log In"
    And I should see a flash "alert" of "You must be logged in to do that."

  Scenario: An invalid teacher attempts to delete a period
  	Given the following teachers:
      | name       | email             |
      | John       | john@gmail.com    |
    And I am logged in as "john@gmail.com"
  	When I am on the delete period page for the school "Akahige's School" and the period "First Period"
    Then I should see a page title of "John"
    And I should see a flash "alert" of "You do not have permission to edit that school."

  Scenario: An invalid teacher attempts to delete a period he doesn't own in a school he does
  	Given the following teachers:
      	| name       | email             |
      	| John       | john@gmail.com    |
    And the following schools:
  		| name				| headmaster	|
  		| John's School 	| John 		|
    And I am logged in as "john@gmail.com"
  	When I am on the delete period page for the school "John's School" and the period "First Period"
    Then I should see a page title of "John's School"
    And I should see a flash "alert" of "That period does not exist."

  Scenario: An invalid teacher attempts to delete a period he owns in a school he doesn't
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
  	When I am on the delete period page for the school "Akahige's School" and the period "First Period"
    Then I should see a page title of "John"
    And I should see a flash "alert" of "You do not have permission to edit that school."


#----- DIRECT USER INPUT PROTECTION
#----------------------------------

  Scenario: A logged in teacher attempts to delete a period in a school that doens't exist
    Given I am logged in as "akahige@gmail.com"
  	When I am on the delete period page for the school "Non-School" and the period "First Period"
    Then I should see a page title of "Akahige"
    And I should see a flash "alert" of "That school does not exist."

  Scenario: A logged in teacher attempts to delete a period that doesn't exist in a school that does
    Given I am logged in as "akahige@gmail.com"
  	When I am on the delete period page for the school "Akahige's School" and the period "Non-Period"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "That period does not exist."

  Scenario: A logged in teacher attempts to delete a period in a school the period doesn't belong to
    Given the following schools:
      | name                 | headmaster        |
      | Redbeards's School   | Akahige           |
    And the following periods:
  		| name 				    | school 			            	| start_at 				|
  		| Start Period			| Redbeards's School 		    	| 09 				    |
    And I am logged in as "akahige@gmail.com"
    When I am on the delete period page for the school "Akahige's School" and the period "Start Period"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "That period does not exist."

  Scenario: A logged in teacher attempts to delete a period that doesn't exist in a school he doesn't own
    Given the following teachers:
      | name       | email             |
      | John       | john@gmail.com    |
    And the following schools:
      | name        | headmaster  |
      | John's School   | John    |
    And the following periods:
  		| name 				    | school 			            	| start_at 				|
  		| Start Period			| Redbeards's School 		    	| 09 				    |
    And I am logged in as "john@gmail.com"
    When I am on the delete room page for the school "Akahige's School" and the room "Non-Period"
    Then I should see a page title of "John"
    And I should see a flash "alert" of "You do not have permission to edit that school."