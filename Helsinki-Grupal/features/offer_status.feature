Feature: Offer status
  In order to know an offer's status
  As an offering user
  I want to be able to indicate how an offer ended

  Background:
    Given I am logged in
      And I own an offer with title "A Test Job Offer"

  Scenario: Status column visible
    Then I should see "Status" in My Offers

  Scenario: Button complete in my offers
    When I access My Offers page
      And I click Complete in "A Test Job Offer"
    Then I should be in the complete form page

  Scenario: Offer with status active is shown in JobOffers
    Given The offer's status is "Active"
    When I access the offers list page
    Then I should see "A Test Job Offer"

  Scenario: Offer with status "Hired In" is not shown in JobOffers
    Given The offer's status is "Hired In"
    When I access the offers list page
    Then I should not see "A Test Job Offer"

  Scenario: Offer with status "Hired Out" is not shown in JobOffers
    Given The offer's status is "Hired Out"
    When I access the offers list page
    Then I should not see "A Test Job Offer"

  Scenario: Offer with status "Closed" is not shown in JobOffers
    Given The offer's status is "Closed"
    When I access the offers list page
    Then I should not see "A Test Job Offer"

  Scenario: Offer with status "Expired" is not shown in JobOffers
    Given The offer's status is "Expired"
    When I access the offers list page
    Then I should not see "A Test Job Offer"

  Scenario: Set "Hired In" status in an offer
    Given I am in the complete form page
      And I choose "Hired In" option
    When I click the Complete button
    Then I should be in MyOffers page
      And I should see "Hired In" in "A Test Job Offer" status field

  Scenario: Set "Hired Out" status in an offer
    Given I am in the complete form page
      And I choose "Hired Out" option
    When I click the Complete button
    Then I should be in MyOffers page
      And I should see "Hired Out" in "A Test Job Offer" status field

  Scenario: Set "Closed" status in an offer
    Given I am in the complete form page
      And I choose "Closed" option
    When I click the Complete button
    Then I should be in MyOffers page
      And I should see "Closed" in "A Test Job Offer" status field

  Scenario: Set "Expired" status in an offer
    Given The offer has expired
    When I access My Offers page
    Then I should see "Expired" in "A Test Job Offer" status field

  Scenario: "Active" in an offer
    Given The offer's status is "Active"
    When I access My Offers page
    Then I should see "Active" in "A Test Job Offer" status field