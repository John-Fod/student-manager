Feature: Class Session Creation
  In order to create a schedule of classes
  As a teacher
  I want to create class sessions

Background:
  Given the following teachers:
    | name         | email                |
    | Akahige      | akahige@gmail.com    |

  Given the following schools:
  	| name				      | headmaster	|
  	| Akahige's School 	| Akahige 		|

  Given the following students:
    | name        | school              |
    | Joe         | Akahige's School    |

  Given the following rooms:
  	| name 				| school 			      | founding_teacher 	|
  	| Room 1 			| Akahige's School  | Akahige 			    |

  Given the following periods:
  	| name 				    | school 			      | start_at 				|
  	| First Period		| Akahige's School 	| 09 					    |


#----- VIEWING THE PERIODS ON THE SCHOOL'S SHOW PAGE
#---------------------------------------------------
	
  Scenario: A valid user can see the periods on his school's show page
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the show school page for "Akahige's School"
  	Then I should see the text "First Period" in the element ".period-schedule .period-row td a"


#----- ADDING CLASS SESSIONS FROM THE ADD CLASS SESSION PAGE
#-----------------------------------------------------------

  Scenario: A valid user adds a new class session
    Given I am logged in as "akahige@gmail.com"
    When I am on the new class session page for the school "Akahige's School"
    And I fill in "class_session_name" with "New Class Session"
    And I select "Akahige" from the dropdown "class_session[teacher_id]"
    And I select "First Period" from the dropdown "class_session[period_id]"
    And I press "commit"
    Then I should see a flash "notice" of "Class session was successfully created."
    And I should see the text "New Class Session" in the element ".period-schedule .period-row .class-session"

  Scenario: A valid user adds a new class session to a room
    Given I am logged in as "akahige@gmail.com"
    When I am on the new class room session page for the school "Akahige's School" and the room "Room 1"
    And I fill in "class_session_name" with "New Class Session"
    And I select "Akahige" from the dropdown "class_session[teacher_id]"
    And I select "First Period" from the dropdown "class_session[period_id]"
    And I press "commit"
    Then I should see a flash "notice" of "Class session was successfully created."
    And I should see the text "New Class Session" in the element ".period-schedule .period-row .class-session"

  Scenario: A valid user adds a new class session to a school with no rooms
    Given the following schools:
      | name              | headmaster  |
      | Roomless          | Akahige     |
    And the following students:
      | name        | school              |
      | Joe         | Roomless            |
    And the following periods:
      | name            | school            | start_at        |
      | Period One      | Roomless          | 09              |
    And I am logged in as "akahige@gmail.com"
    When I am on the new class session page for the school "Roomless"
    And I fill in "class_session_name" with "New Class Session"
    And I select "Akahige" from the dropdown "class_session[teacher_id]"
    And I select "Period One" from the dropdown "class_session[period_id]"
    And I press "commit"
    Then I should see a flash "notice" of "Class session was successfully created."
    And I should see the text "New Class Session" in the element ".period-schedule .period-row .class-session"


#----- ADDING CLASS SESSION FROM THE SCHOOL'S SHOW PAGE
#------------------------------------------------------

  Scenario: A valid user can add class sessions from his school's show page
  	Given I am logged in as "akahige@gmail.com"
  	When I am on the show school page for "Akahige's School"
  	And I quickly add room "Room 1" for period "First Period" and teacher "Akahige"
  	Then I should see a flash "notice" of "Class session was successfully created."
  	And I should see the text "Room 1" in the element ".period-schedule .period-row .class-session"

#----- USER VALIDATIONS
#----------------------

  Scenario: A valid user attempts to make a class session in a school he doesn't own
    Given the following teachers:
      | name         | email                |
      | John         | john@gmail.com       |
    And the following schools:
      | name              | headmaster  |
      | John's School     | John        |
    And I am logged in as "akahige@gmail.com"
    When I am on the new class session page for the school "John's School"
    Then I should see a flash "alert" of "You do not have permission to edit that school."
    And I should see a page title of "Akahige"

  Scenario: A non logged in user attempts to make a class session
    When I am on the new class session page for the school "Akahige's School"
    Then I should see a flash "alert" of "You must be logged in to do that."
    And I should see a page title of "Log In"

#----- VALIDATIONS
#-----------------

  Scenario: A valid user attempts to make a class session with a teacher who is unavailable because of another class
    Given the following class sessions today:
      | school            | room        | period            | teacher    |
      | Akahige's School  | Room 1      | First Period      | Akahige    |
    And I am logged in as "akahige@gmail.com"
    When I am on the new class session page for the school "Akahige's School"
    And I fill in "class_session_name" with "New Class Session"
    And I select "Akahige" from the dropdown "class_session[teacher_id]"
    And I select "First Period" from the dropdown "class_session[period_id]"
    And I press "commit"
    Then I should see an error message of "Period has already been taken"

  Scenario: A valid user attempts to add a new class session to a school with no rooms and no periods
    Given the following schools:
      | name              | headmaster  |
      | Roomless          | Akahige     |
    And the following students:
      | name        | school              |
      | Joe         | Roomless            |
    And I am logged in as "akahige@gmail.com"
    When I am on the new class session page for the school "Roomless"
    And I fill in "class_session_name" with "New Class Session"
    And I select "Akahige" from the dropdown "class_session[teacher_id]"
    And I press "commit"
    Then I should see an error message of "Period can't be blank"

#-----DIRECT INPUT VALIDATIONS
#-----------------------------

  Scenario: A valid user attempts to make a class in a school that doesn't exist
    Given I am logged in as "akahige@gmail.com"
    When I am on the new class session page for the school "Non-School"
    Then I should see a flash "alert" of "That school does not exist."
    And I should see a page title of "Akahige"

  Scenario: A valid user attempts to make a class in a school that exists with a room that doesn't
    Given I am logged in as "akahige@gmail.com"
    When I am on the new class room session page for the school "Akahige's School" and the room "Non-Room"
    Then I should see a flash "alert" of "That room does not exist."
    And I should see a page title of "Akahige's School"

  Scenario: A valid user attempts to make a class in a school that exists with a room from another school
    Given the following schools:
      | name              | headmaster  |
      | School 2          | Akahige     |
    And the following students:
      | name        | school              |
      | Bob         | School 2            |
    And the following rooms:
      | name        | school            | founding_teacher  |
      | Room 2      | ASchool 2         | Akahige           |
    And I am logged in as "akahige@gmail.com"
    When I am on the new class room session page for the school "Akahige's School" and the room "Room 2"
    Then I should see a flash "alert" of "That room does not exist."
    And I should see a page title of "Akahige's School"

  Scenario: A valid user attempts to make a class in a school that doesn't exist with a room that does
    Given I am logged in as "akahige@gmail.com"
    When I am on the new class room session page for the school "Non-School" and the room "Room 1"
    Then I should see a flash "alert" of "That school does not exist."
    And I should see a page title of "Akahige"