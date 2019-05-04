Feature: Required experience
  In order to get employees
  As a job offerer
  I want to indicate the experience required to apply to my offers

  Background:
    Given I am logged in as job offerer

  Scenario: Create new offer with years experience field
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the "experience" field with "3"
    And confirm the new offer
    Then I should see "Offer created"
    And I should see "3" in the years experience field of "Programmer vacancy" offer

  Scenario: Create new offer with the years experience field empty
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I don’t fill the "experience" field
    And confirm the new offer
    Then I should see "Offer created"
    And I should see "Not Specified" in the years experience field of "Programmer vacancy" offer

  Scenario: Create new offer with the years experience as a string
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the "experience" field with "tres"
    And confirm the new offer
    Then I should see "Years of experience must be a positive number"

  Scenario: Create new offer with the years experience as a negative number
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the "experience" field with "-4"
    And confirm the new offer
    Then I should see "Years of experience must be a positive number"
