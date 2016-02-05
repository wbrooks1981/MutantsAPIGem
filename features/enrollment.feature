Feature: Enrollment
  As a user I want to work with the enrollment api

  Background:
    Given an alias of "Cyclops"
    And a name of "Scott Summers"
    And an ability of "Beams of energy from eyes"
    Given A term starts "2016-02-04"
    And A term ends "2016-04-04"
    Given I have a mutant
    And I have a term

  Scenario: Able to enroll mutant for a term
    When A mutant enrolls in a term
    Then the enrollment will be created

  Scenario: Able to add a mutant to a term
    When A mutant is added to a term
    Then the term will have the mutant

  Scenario: Able to retrieve all enrollments for a mutant
    Given A mutant is enrolled in a term
    When I retrieve all enrollments for a mutant
    Then the enrollments will be returned

  Scenario: Able to retrieve a specific enrollment for a mutant
    Given A mutant is enrolled in a term
    When I retrieve the enrollment
    Then enrollment will be returned

  Scenario: Able to retrieve all enrollments for a term
    Given A mutant is enrolled in a term
    When I retrieve all enrollments for a term
    Then the enrollments will be returned

  Scenario: Able to retrieve a specific enrollment for a term
    Given A mutant is enrolled in a term
    When I retrieve the enrollment
    Then enrollment will be returned

  Scenario: Able to create a term
    When I create the term
    Then the term will be created

  Scenario: Able to retrieve a term
    Given I have a term
    When I retrieve the term
    Then the term will be returned

  Scenario: Able to update a term
    Given  I have a term
    And A term ends "2016-06-04"
    When I update the term
    Then the term will be updated

  Scenario: Able to delete a term
    Given  I have a term
    When I delete the term
    Then the term will be deleted

  Scenario: Verify response on missing term start date
    Given I don't have a term start date
    And I create the term
    Then the term will not be created
    And the error with "begins_at" of "can't be blank"

  Scenario: Verify response on missing term end date
    Given I don't have a term end date
    And I create the term
    Then the term will not be created
    And the error with "ends_at" of "can't be blank"

    #defect
  Scenario: Verify response on term end date before start
    Given A term starts "2016-03-15"
    And A term ends "2016-02-10"
    And I create the term
    Then the term will not be created
    And the error with "ends_at" of "can't be before begins at"