Feature: Strong passwords
  In order to have a less guessable password
  As a user
  I want my password to be at least 10 characters long, with at least a number, a lowercase letter and an uppercase letter

  Background:
    Given I am in the registration view
    And my name is Testing User
    And my email is testing-user@mail.com

  Scenario: Valid password
    Given I input a2A4567890 in the password field
    Given I input a2A4567890 in the password_confirmation field
    When I click create
    Then I should see the message "User created"

  Scenario: Invalid password, missing uppercase letter
    Given I input a234567890 in the password field
    Given I input a234567890 in the password_confirmation field
    When I click create
    Then I should see the message "Invalid password. Should have at least 10 characters with at least a number, a lowercase letter and an uppercase letter"

  Scenario: Invalid password, missing number
    Given I input aAbBcCdDeE in the password field
    Given I input aAbBcCdDeE in the password_confirmation field
    When I click create
    Then I should see the message "Invalid password. Should have at least 10 characters with at least a number, a lowercase letter and an uppercase letter"

  Scenario: Invalid password, missing lowercase letter
    Given I input 1A3B5C7D9E in the password field
    Given I input 1A3B5C7D9E in the password_confirmation field
    When I click create
    Then I should see the message "Invalid password. Should have at least 10 characters with at least a number, a lowercase letter and an uppercase letter"

  Scenario: Invalid password, not long enough
    Given I input a1Bdc3 in the password field
    Given I input a1Bdc3 in the password_confirmation field
    When I click create
    Then I should see "Invalid password. Should have at least 10 characters with at least a number, a lowercase letter and an uppercase letter"