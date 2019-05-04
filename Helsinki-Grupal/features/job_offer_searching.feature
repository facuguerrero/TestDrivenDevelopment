Feature: Field wide searching
  In order to find offers
  As a job candidate
  I want to indicate be able to search over all of an offers fields

  Background:
    Given a "Web Programmer" offer exists in the offers list located in Buenos Aires with description "Good Conditions"
    And a "Java Developer" offer exists in the offers list located in Goodmayes with description "Free food"
    And I access the job offer page

  Scenario: Search matches location of one offer
    Given I input "Bue" in the search box
    When I click search
    Then I should see "Web Programmer" in Job Offers

  Scenario: Search matches location of an offer and description of another
    Given I input "good" in the search box
    When I click search
    Then I should see "Web Programmer" in Job Offers
    And I should see "Java Developer" in Job Offers

  Scenario: Search matches title of one offer
    Given I input "dev" in the search box
    When I click search
    Then I should see "Java Developer" in Job Offers