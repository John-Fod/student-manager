Feature: Student Editing
  In order to keep my student records up to date
  As a teacher
  I want to edit a student profile

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


#----- SUCCESSFULLY EDITING A STUDENT
#------------------------------------

  Scenario: A headmaster edits a student
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the edit student page for "Joe" in the school "Akahige's School"
  	And I fill in "student_name" with "Joseph"
  	And I fill in "student_level" with "Pretty Good"
  	And I press "commit"
  	Then I should see a flash "notice" of "Student update successful."
  	And I should see a page title of "Joseph"


#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to edit a student without a name
  	Given I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joe" in the school "Akahige's School"
    And I fill in "student_name" with ""
    And I fill in "student_level" with "Amazing"
  	And I press "commit"
    Then I should see a page title of ""
    Then I should see an error message of "Name can't be blank"

  Scenario: A logged in user attempts to edit a student to give him the same name as another student
  	Given the following students:
  		| name 				| school 				      |
  		| Bill 				| Akahige's School 		|
  	And I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joe" in the school "Akahige's School"
    And I fill in "student_name" with "Bill"
    And I fill in "student_level" with "Amazing"
  	And I press "commit"
    Then I should see an error message of "Name has already been taken"

  Scenario: A logged in teacher can give a student the same name as a student in another school
    Given the following schools:
      | name              | headmaster        |
      | Second School     | Akahige           |
    Given the following students:
      | name              | school            |
      | Joey              | Second School     |
    And I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joey" in the school "Second School"
    And I fill in "student_name" with "Joe"
    And I fill in "student_level" with "Not as good as the other Joe, who is in another school."
    And I press "commit"
    Then I should see a flash "notice" of "Student update successful."
    And I should see a page title of "Joe"

#----- USER VALIDATIONS
#----------------------

  Scenario: An invalid teacher attempts to edit a student in a school that isn't his
    Given the following teachers:
      | name       | email             |
      | John       | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I am on the edit student page for "Joe" in the school "Akahige's School"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "You do not have permission to edit that school."


  Scenario: A non logged in teacher attempts to edit a student
    When I am on the edit student page for "Joe" in the school "Akahige's School"
    Then I should see a page title of "Log In"
    And I should see a flash "alert" of "You must be logged in to do that."

#----- DIRECT INPUT VALIDATIONS
#------------------------------

  Scenario: A logged in teacher attempts to edit a student that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "xxx" in the school "Akahige's School"
    Then I should see a page title of "Akahige's School"
    And I should see a flash "alert" of "That student does not exist."

  Scenario: A logged in teacher attempts to edit a student in a school that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joe" in the school "xxx"
    Then I should see a page title of "Schools"
    And I should see a flash "alert" of "That school does not exist."    

  Scenario: A logged in teacher attempts to edit a student that doesn't exist in a school that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "xxx" in the school "xxx"
    Then I should see a page title of "Schools"
    And I should see a flash "alert" of "That school does not exist."   

  Scenario: A logged in teacher attempts to edit a student in a school the student doesn't belong to
    Given the following schools:
      | name              | headmaster        |
      | Second School     | Akahige           |
    And I am logged in as "akahige@gmail.com"
    When I am on the edit student page for "Joe" in the school "Second School"
    Then I should see a page title of "Second School"
    And I should see a flash "alert" of "That student does not exist."