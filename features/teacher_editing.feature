Feature: Teacher editing
  In order to keep update my profile to show other people
  As a teacher on student manager
  I want to edit my teacher profile

Background:
  Given the following teachers:
    | name          | email                |
    | Akahige      | akahige@gmail.com    |



#----- SUCCESSFULLY EDITING A TEACHER
#------------------------------------

  Scenario: A logged in teacher edits his profile
    Given I am logged in as "akahige@gmail.com"
    When I visit the edit teacher page for "Akahige"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see a page title of "John"
    And I should see a flash "notice" of "Teacher was successfully updated"



#----- FORM VALIDATIONS
#----------------------

  Scenario: A logged in teacher edits his profile with no name
    Given I am logged in as "akahige@gmail.com"
    When I visit the edit teacher page for "Akahige"
    And I fill in "teacher_name" with ""
    And I press "commit"
    Then I should see an error message of "Name can't be blank"



#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to edit a teacher
    When I visit the edit teacher page for "Akahige"
    Then I should see a flash "alert" of "You must be logged in to do that."

  Scenario: A logged in user attempts to edit another teacher
    Given the following teachers:
      | name          | email                |
      | John      | john@gmail.com    |
    And I am logged in as "john@gmail.com"
    When I visit the edit teacher page for "Akahige"
    Then I should see a flash "alert" of "You do not have permission to edit that teacher."