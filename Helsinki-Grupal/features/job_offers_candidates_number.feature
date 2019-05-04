Feature: Show the number of candidates that applied to my offers.
  In order to get employees
  As a job offerer
  I want to know the number of candidates that applied to my offers


  Background:
    Given I am logged in as job offerer
      And only a "Web Programmer" offer exists in the offers list

  Scenario: Create a new offer and nobody applied to it yet.
    Given Nobody applied to my offer
    When I access my offers page
    Then I should see "0" in the applicants field of the offer

  Scenario: Show the number of candidates that applied to my offers
    Given I access the offers list page
    And I apply with "facu@gmail.com"
    When I access my offers page
    Then I should see "1" in the applicants field of the offer