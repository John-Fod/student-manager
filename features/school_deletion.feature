Feature: School Creation
  In order to get rid of schools I'm not using
  As a headmaster
  I want to delete schools

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|


#----- SUCCESSFULLY DELETING A SCHOOL
#------------------------------------

  Scenario: A headmaster deletes a school
  	Given I am logged in as "akahige@gmail.com"
  	When I visit the delete school page for "Akahige's School"
  	And I follow "confirm_deletion"
  	Then I should see a flash "notice" of "School deletion successful."


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to delete a school
  	When I visit the delete school page for "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."