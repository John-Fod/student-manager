Feature: Home page navigation
  In order to easily navigate
  As a user that is either logged in or not
  I want to see the right links for navigation

Background:
  Given the following teachers:
    | teachername  | email                |
    | Akahige      | akahige@gmail.com    |


  Scenario: Viewing student manager's home page
    When I am on the "home" page

  Scenario: A non logged in user sees the links to register and login
    Given I am on the "home" page
    Then I should see the text "Register" in the element "#session-options"
    And I should see the text "Login" in the element "#session-options"
    And I should not see the text "Logout" in the element "#session-options"

  Scenario: A logged in user sees the link to logout
  	Given I am logged in as "akahige@gmail.com"
    And I am on the "teachers" page
  	Then I should not see the text "Register" in the element "#session-options"
  	And I should not see the text "Login" in the element "#session-options"
  	And I should see the text "Logout" in the element "#session-options"