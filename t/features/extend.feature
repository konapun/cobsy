Feature: Cobsy object extension by components

  Background:
    Given an object extension

  Scenario: Extending by a component array
    When I pass a component array
    Then I should get an object which is a clone of the object being extended with the additional components loaded
    And The resulting extended component should ignore duplicates
    But Duplicate components should be reinitialized with their original values

  Scenario: Extending by a component hash
    When I pass a component hash
    Then I should get an object which is a clone of the object being extended with the additional components loaded
    And The resulting extended component should ignore duplicates
    But Duplicate components should be reinitialized with their hash values
    
