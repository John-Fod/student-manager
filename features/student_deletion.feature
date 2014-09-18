Feature: Student Deleting
  In order to get rid of unneeded student records
  As a teacher
  I want to delete students

Background:
  Given the following teachers:
    | name        	| email                |
    | Akahige       | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	      |
  	| Akahige's School 	| Akahige 		|

  Given the following students:
  	| name 				| school 				      |
  	| Joe 				| Akahige's School 		|


#----- SUCCESSFULLY DELETING A STUDENT
#-------------------------------------

  Scenario: A headmaster deletes a student
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the delete student page for "Joe" in the school "Akahige's School"
  	And I follow "confirm_deletion"
  	Then I should see a flash "notice" of "Student deletion successful."
  	And I should see a page title of "Akahige's School"

#----- USER VALIDATIONS
#----------------------

  Scenario: An invalid teacher attempts to delete a student in a school that isn't his
    Given the following teachers:
      | name       | email             |
      | John       | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I am on the delete student page for "Joe" in the school "Akahige's School"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "You do not have permission to edit that school."


  Scenario: A non logged in teacher attempts to delete a student
    When I am on the delete student page for "Joe" in the school "Akahige's School"
    Then I should see a page title of "Log In"
    And I should see a flash "alert" of "You must be logged in to do that."

#----- DIRECT INPUT VALIDATIONS
#------------------------------

  Scenario: A logged in teacher attempts to delete a student that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the delete student page for "xxx" in the school "Akahige's School"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "That student does not exist."

  Scenario: A logged in teacher attempts to delete a student in a school that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the delete student page for "Joe" in the school "xxx"
    Then I should see a page title of "Schools"
    And I should see a flash "alert" of "That school does not exist."    

  Scenario: A logged in teacher attempts to delete a student that doesn't exist in a school that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the delete student page for "xxx" in the school "xxx"
    Then I should see a page title of "Schools"
    And I should see a flash "alert" of "That school does not exist."   

  Scenario: A logged in teacher attempts to delete a student in a school the student doesn't belong to
    Given the following schools:
      | name              | headmaster        |
      | Second School     | Akahige           |
    And I am logged in as "akahige@gmail.com"
    When I am on the delete student page for "Joe" in the school "Second School"
    Then I should see a page title of "Second School"
    And I should see a flash "alert" of "That student does not exist."