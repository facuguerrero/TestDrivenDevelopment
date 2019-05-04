Feature: Account locking after 3 failed login tries
  In order to get better security
  As an user
  I want my account to get locked for 24 hours after 3 consecutive failed login tries.

  Background:
    Given I am in the login page

  Scenario: Fail two logins in a row, then login successfully
    Given I have an account with email "user@test.com" and password "test_pass"
    When I try to login 2 times with email "user@test.com" and password "other_pass"
      And I try to login with email "user@test.com" and password "test_pass"
    Then I should be successfully logged in

  Scenario: Fail three logins in a row locks account
    Given I have an account with email "user@test.com" and password "test_pass"
    When I try to login 3 times with email "user@test.com" and password "other_pass"
    Then My account should be locked

  Scenario: Fail two logins in a row, then login successfully, login successfully, then fail again after logout and the account is not locked
    Given I have an account with email "user@test.com" and password "test_pass"
    When I try to login 2 times with email "user@test.com" and password "other_pass"
      And I try to login with email "user@test.com" and password "test_pass"
      And I logout
      And I try to login with email "user@test.com" and password "other_pass"
    Then My account should not be locked

  Scenario: Try to login after 24 hours of locking and login successfully
    Given I have an account with email "user@test.com" and password "test_pass"
      And The account was locked on 2018-10-20 18:20:22
    When I try to login with email "user@test.com" and password "test_pass" on 2018-10-21 18:20:23
    Then I should be successfully logged in

  Scenario: Try to login before 24 hours of locking and account is locked
    Given I have an account with email "user@test.com" and password "test_pass"
    And The account was locked on 2018-10-20 18:20:22
    When I try to login with email "user@test.com" and password "test_pass" on 2018-10-21 18:20:20
    Then My account should be locked

  Scenario: Fail three logins in a row locks account
    Given I have an account with email "user@test.com" and password "test_pass"
    When I try to login 3 times with email "user@test.com" and password "other_pass"
    Then My account should be locked