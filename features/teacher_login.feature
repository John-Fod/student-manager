Feature: Teacher login
  In order to come back to work I have been doing from anywhere in the world
  As a teacher
  I want to loggin to my account

Background:
  Given the following teachers:
    | teachername  | email                |
    | Akahige      | akahige@gmail.com    |



#----- SUCCESSFULLY LOGIN
#------------------------

  Scenario: A non logged in user logs in as a teacher with an email
    When I am on the "new_session" page
    And I fill in "email" with "akahige@gmail.com"
    And I fill in "password" with "123"
    And I press "commit"
    Then I should see a flash "notice" of "Login successful."

  Scenario: A non logged in user logs in as a teacher with a teachername
    When I am on the "new_session" page
    And I fill in "email" with "Akahige"
    And I fill in "password" with "123"
    And I press "commit"
    Then I should see a flash "notice" of "Login successful."



#----- UNSUCCESSFULLY LOGIN
#--------------------------

  Scenario: A non logged in user attempts to login as a teacher with a bad password
    When I am on the "new_session" page
    And I fill in "email" with "akahige@gmail.com"
    And I fill in "password" with "456"
    And I press "commit"
    Then I should see a flash "alert" of "Invalid email or password."

  Scenario: A non logged in user attempts to login as a teacher with a bad username
    When I am on the "new_session" page
    And I fill in "email" with "john@gmail.com"
    And I fill in "password" with "123"
    And I press "commit"
    Then I should see a flash "alert" of "Invalid email or password."



#----- FORM VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to login without entering an email or username
    When I am on the "new_session" page
    And I fill in "email" with ""
    And I fill in "password" with "123"
    And I press "commit"
    Then I should see a flash "alert" of "Invalid email or password."


  Scenario: A non logged in user attempts to login without entering a password
    When I am on the "new_session" page
    And I fill in "email" with "akahige@gmail.com"
    And I fill in "password" with ""
    And I press "commit"
    Then I should see a flash "alert" of "Invalid email or password."



#----- USER VALIDATIONS
#----------------------

  Scenario: A logged in user attempts to register as a teacher
    Given I am logged in as "akahige@gmail.com"
    When I am on the "new_session" page
    Then I should see a flash "alert" of "You must first log out to do that."