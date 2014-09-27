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
  	When I am on the delete school page for "Akahige's School"
  	And I follow "confirm_deletion"
  	Then I should see a flash "notice" of "School deletion successful."


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to delete a school
  	When I am on the delete school page for "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."


#---- STUDENTS AND ROOMS OF A DELETED SCHOOL
#-------------------------------------------

  Scenario: A headmaster deletes a school and the students of the school are deleted
    Given the following students:
      | name        | school              |
      | Joe         | Akahige's School    |
      | Mike        | Akahige's School    |
    And I am logged in as "akahige@gmail.com"
    And the school "Akahige's School" is deleted
    When I am on the page for the student "Joe" in the school "Akahige's School"
    Then I should see a page title of "Schools"
    And I should see a flash "alert" of "That school does not exist."

  Scenario: A headmaster deletes a school and the rooms of the school are deleted
    Given the following rooms:
      | name        | school            | founding_teacher  |
      | Room 1      | Akahige's School  | Akahige           |
    And I am logged in as "akahige@gmail.com"
    And the school "Akahige's School" is deleted
    When I am on the show room page for the room "Room 1" in the school "Akahige's School"
    Then I should see a flash "alert" of "That school does not exist."
    And I should see a page title of "Akahige"
