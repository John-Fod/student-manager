Feature: Room Creation
  In order to organize my classes
  As a teacher
  I want to create a period

Background:
  Given the following teachers:
    | name          | email                |
    | Akahige       | akahige@gmail.com    |

  Given the following schools:
  	| name				       | headmaster	|
  	| Akahige's School 	 | Akahige 		|


#----- SUCCESSFULLY FOUNDING A NEW PERIOD
#--------------------------------------

  Scenario: A logged in user creates a period
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new period page for the school "Akahige's School"
  	And I fill in "period_name" with "First Period"
  	And I select "09 AM" from the dropdown "period_start_at_4i"
  	And I select "10 AM" from the dropdown "period_end_at_4i"
  	And I press "commit"
  	Then I should see a flash "notice" of "Period was successfully created."
  	And I should see a page title of "Akahige's School"

#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to create a period without a name
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new period page for the school "Akahige's School"
  	And I fill in "period_name" with ""
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to create a period
    When I am on the new period page for the school "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: An invalid teacher attempts to create a period
    Given the following teachers:
    | name        | email             |
    | John        | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I am on the new period page for the school "Akahige's School"
    Then I should see a flash "alert" of "You do not have permission to edit that school."


#----- DIRECT USER INPUT PROTECTION
#----------------------------------

  Scenario: A logged in teacher attempts to create a period in a school that doens't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the new period page for the school "This School Doesn't Exist"
    Then I should see a flash "alert" of "That school does not exist."