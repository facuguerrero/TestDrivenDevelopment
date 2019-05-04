Feature: Salary
  In order to get employees
  As a job offerer
  I want to indicate the salary of my offer.

  Background:
    Given I am logged in as job offerer

  Scenario: Create new offer with years salary field
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the "salary" field with "30000"
    And confirm the new offer
    Then I should see "Offer created"
    And I should see "30000" in the salary field of "Programmer vacancy" offer

  Scenario: Create new offer with the salary field empty
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I don’t fill the "salary" field
    And confirm the new offer
    Then I should see "Offer created"
    And I should see "Not Specified" in the salary field of "Programmer vacancy" offer

  Scenario: Create new offer with the salary as a string
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the "salary" field with "treinta"
    And confirm the new offer
    Then I should see "Salary must be a positive number"

  Scenario: Create new offer with the salary as a negative
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the "salary" field with "-30000"
    And confirm the new offer
    Then I should see "Salary must be a positive number"
