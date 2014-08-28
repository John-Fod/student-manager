Feature: School Creation
  In order to organize my lessons and students
  As a teacher
  I want to create a school

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|


#----- SUCCESSFULLY FOUNDING A NEW SCHOOL
#----------------------------------------

  Scenario: A logged in user founds a school
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the "new_school" page
  	And I fill in "school_name" with "John's School"
  	And I fill in "school_summary" with "This is a school for me."
  	And I press "commit"
  	Then I should see a flash "notice" of "School founding successful."
  	And I should see a page title of "John's School"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to found a school without a name
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the "new_school" page
  	And I fill in "school_name" with ""
  	And I fill in "school_summary" with "This is a school for me."
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to found a school
    When I go to the "new_school" page
    Then I should see a flash "alert" of "You must be logged in to do that."