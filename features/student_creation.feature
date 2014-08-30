Feature: Student Creation
  In order to organize my students and schools
  As a teacher
  I want to create a student profile

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|


#----- SUCCESSFULLY CREATING A NEW STUDENT
#-----------------------------------------

  Scenario: A headmaster creates a new student
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the new student page for the school "Akahige's School"
  	And I fill in "student_name" with "John's Student"
  	And I fill in "student_level" with "Amazing"
  	And I press "commit"
  	Then I should see a flash "notice" of "Student creation successful."
  	And I should see a page title of "John's Student"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to create a student without a name
  	Given I am logged in as "akahige@gmail.com"
    When I am on the new student page for the school "Akahige's School"
    And I fill in "student_name" with ""
    And I fill in "student_level" with "Amazing"
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"


#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to add a student to a school
    When I am on the new student page for the school "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: A teacher attempts to add a student to a school that isn't his
    Given the following teachers:
      | name        | email                |
      | John      | john@gmail.com   |
    And I am logged in as "john@gmail.com"
    When I am on the new student page for the school "Akahige's School"
    Then I should see a flash "alert" of "You do not have permission to edit that school."