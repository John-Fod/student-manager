Feature: School Editing
  In order to update information about my school
  As a headmaster
  I want to edit my school

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|


#----- SUCCESSFULLY EDITING A SCHOOL
#-----------------------------------

  Scenario: A teacher edits his school
  	Given I am logged in as "akahige@gmail.com"
  	When I visit the edit school page for "Akahige's School"
  	And I fill in "school_name" with "Akahige's Top English Super School"
  	And I fill in "school_summary" with "This school only teaches English."
  	And I press "commit"
  	Then I should see a flash "notice" of "School update successful."
  	And I should see a page title of "Akahige's Top English Super School"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A teacher attemtpts to edit his school to have no name
  	Given I am logged in as "akahige@gmail.com"
  	When I visit the edit school page for "Akahige's School"
  	And I fill in "school_name" with ""
  	And I fill in "school_summary" with "This school only teaches English."
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to edit a school
  	When I visit the edit school page for "Akahige's School"
  	Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: A teacher attempts to edit a school that isn't his
  	Given the following teachers:
  		| name        | email                |
  		| John      | john@gmail.com   |
  	And I am logged in as "john@gmail.com"
  	When I visit the edit school page for "Akahige's School"
  	Then I should see a flash "alert" of "You do not have permission to edit that school."