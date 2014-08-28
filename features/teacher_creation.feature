Feature: Teacher creation
  In order to keep track of my students and classes
  As a user of the student manager
  I want to create a teacher profile

Background:



#----- SUCCESSFULLY REGISTERING A NEW TEACHER
#--------------------------------------------

  Scenario: A non logged in user registers as a teacher
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "john@gmail.com"
    And I fill in "teacher_password" with "123"
    And I fill in "teacher_password_confirmation" with "123"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see a flash "notice" of "Sign up successful.  Welcome to Academer!"



#----- FORM VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to register as a teacher without an email address
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with ""
    And I fill in "teacher_password" with "123"
    And I fill in "teacher_password_confirmation" with "123"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see an error message of "Email can't be blank"

  Scenario: A non logged in user attempts to register as a teacher with an invalid email address
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "twenty-one"
    And I fill in "teacher_password" with "123"
    And I fill in "teacher_password_confirmation" with "123"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see an error message of "Email is invalid"

  Scenario: A non logged in user attempts to register as a teacher with an unavailable email address
    Given the following teachers:
      | name        | email                |
      | Akahige      | akahige@gmail.com    |
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "akahige@gmail.com"
    And I fill in "teacher_password" with "123"
    And I fill in "teacher_password_confirmation" with "123"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see an error message of "Email has already been taken"

  Scenario: A non logged in user attempts to register as a teacher without a name
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "akahige@gmail.com "
    And I fill in "teacher_password" with "123"
    And I fill in "teacher_password_confirmation" with "123"
    And I fill in "teacher_name" with ""
    And I press "commit"
    Then I should see an error message of "Name can't be blank"

  Scenario: A non logged in user attempts to register as a teacher without a password
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "akahige@gmail.com "
    And I fill in "teacher_password" with ""
    And I fill in "teacher_password_confirmation" with "123"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see an error message of "Password can't be blank"

  Scenario: A non logged in user attempts to register as a teacher with a password that is too short
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "akahige@gmail.com "
    And I fill in "teacher_password" with "1"
    And I fill in "teacher_password_confirmation" with "1"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see an error message of "Password is too short"

  Scenario: A non logged in user attempts to register as a teacher with a password confirmation that doesn't match
    When I am on the "new_teacher" page
    And I fill in "teacher_email" with "akahige@gmail.com "
    And I fill in "teacher_password" with "123"
    And I fill in "teacher_password_confirmation" with "456"
    And I fill in "teacher_name" with "John"
    And I press "commit"
    Then I should see an error message of "Password confirmation doesn't match Password"



#----- USER VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to register as a teacher
    Given the following teachers:
      | name        | email                |
      | Akahige      | akahige@gmail.com    |
    And I am logged in as "akahige@gmail.com"
    When I am on the "new_teacher" page
    Then I should see a flash "alert" of "You must first log out to do that."