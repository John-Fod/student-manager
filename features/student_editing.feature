Feature: Student Editing
  In order to keep my student records up to date
  As a teacher
  I want to edit a student profile

Background:
  Given the following teachers:
    | name        	| email                |
    | Akahige       | akahige@gmail.com    |

  Given the following schools:
  	| name				| headmaster	|
  	| Akahige's School 	| Akahige 		|

  Given the following students:
  	| name 				| school 				|
  	| Joe 				| Akahige's School 		|


#----- SUCCESSFULLY EDITING A STUDENT
#------------------------------------

  Scenario: A headmaster edits a student
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the edit student page for "Joe"
  	And I fill in "student_name" with "Joseph"
  	And I fill in "student_level" with "Pretty Good"
  	And I press "commit"
  	Then I should see a flash "notice" of "Student update successful."
  	And I should see a page title of "Joseph"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to edit a student without a name
  	Given I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joe"
    And I fill in "student_name" with ""
    And I fill in "student_level" with "Amazing"
  	And I press "commit"
    Then I should see an error message of "Name can't be blank"

  Scenario: A logged in user attempts to edit a student to give him the same name as another student
  	Given the following students:
  		| name 				| school 				|
  		| Bill 				| Akahige's School 		|
  	And I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joe"
    And I fill in "student_name" with "Bill"
    And I fill in "student_level" with "Amazing"
  	And I press "commit"
    Then I should see an error message of "Name has already been taken"