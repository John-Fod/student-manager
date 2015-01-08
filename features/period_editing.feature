Feature: Room Editing
  In order to update my periods
  As a teacher
  I want to edit a period

Background:
  Given the following teachers:
    | name      		  | email                	|
    | Akahige     		| akahige@gmail.com   	|

  Given the following schools:
  	| name				       | headmaster	|
  	| Akahige's School 	 | Akahige 		|

  Given the following periods:
  	| name 				    | school 			            | start_at 				|
  	| First Period		| Akahige's School 		    | 09 					    |


#----- SUCCESSFULLY EDITING A NEW ROOM
#-------------------------------------

  Scenario: A logged in user edits a period
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the edit period page for the school "Akahige's School" and the period "First Period"
  	And I fill in "period_name" with "The First Period"
  	And I press "commit"
  	Then I should see a flash "notice" of "Period was successfully updated."
  	And I should see a page title of "The First Period"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to edit a period without a name
  	Given I am logged in as "akahige@gmail.com"
    When I am on the edit period page for the school "Akahige's School" and the period "First Period"
  	And I fill in "period_name" with ""
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to edit a period
    When I am on the edit period page for the school "Akahige's School" and the period "First Period"
    Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: An invalid teacher attempts to edit a period
    Given the following teachers:
    | name        | email             |
    | John        | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I am on the edit period page for the school "Akahige's School" and the period "First Period"
    Then I should see a flash "alert" of "You do not have permission to edit that school."


#----- DIRECT USER INPUT PROTECTION
#----------------------------------

  Scenario: A logged in teacher attempts to edit a period in a school that doens't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit period page for the school "Non School" and the period "First Period"
    Then I should see a flash "alert" of "That school does not exist."
    And I should see a page title of "Akahige"

  Scenario: A logged in teacher attempts to edit a period that doesn't exist in a school that does
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit period page for the school "Akahige's School" and the period "Non Period"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "That period does not exist."

  Scenario: A logged in teacher attempts to edit a period in a school the period doesn't belong to
  	Given the following schools:
  	| name				    | headmaster	|
  	| Second School 	| Akahige 		|
  	And I am logged in as "akahige@gmail.com"
    When I am on the edit period page for the school "Second School" and the period "First Period"
    Then I should see a page title of "Second School"
    And I should see a flash "alert" of "That period does not exist."