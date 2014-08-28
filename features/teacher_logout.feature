Feature: Teacher logout
  In order to keep my work secure
  As a teacher
  I want to logout of my account

Background:
  Given the following teachers:
    | name        | email                |
    | Akahige      | akahige@gmail.com    |



#----- SUCCESSFULLY LOGOUT
#-------------------------

  Scenario: A valid teacher logs out
    Given I am logged in as "akahige@gmail.com"
    When I go to the "logout" page
    Then I should see a flash "notice" of "Logout successful."



#----- USER VALIDATIONS
#----------------------

  Scenario: A non logged in user attempts to logout
    When I go to the "logout" page
    Then I should see a flash "alert" of "You must be logged in to do that."