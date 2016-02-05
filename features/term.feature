Feature: Terms
  As a user I want to work with the terms api

  Background:
    Given A term starts "2016-02-04"
    And A term ends "2016-04-04"

  Scenario: Able to retrieve all terms
    When I retrieve all terms
    Then a list of terms will be returned

  Scenario: Able to create a term
    When I create the term
    Then the term will be created

  Scenario: Able to retrieve a mutant
    Given I have a term
    When I retrieve the term
    Then the term will be returned

  Scenario: Able to update a mutant
    Given  I have a term
    And A term ends "2016-06-04"
    When I update the term
    Then the term will be updated

  Scenario: Able to delete a term
    Given  I have a term
    When I delete the term
    Then the term will be deleted

  Scenario: Verify response on missing start date
    Given I don't have a term start date
    And I create the term
    Then the term will not be created
    And the error with "begins_at" of "can't be blank"

  Scenario: Verify response on missing end date
    Given I don't have a term end date
    And I create the term
    Then the term will not be created
    And the error with "ends_at" of "can't be blank"

  Scenario: Verify response on end date before start
    Given A term starts "2016-03-01"
    And A term ends "2016-02-01"
    And I create the mutant
    Then the mutant will not be created
    And the error with "ends_at" of "can't be before begins at"