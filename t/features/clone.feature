Feature: Cobsy object cloning

  Background:
    Given an object being cloned

  Scenario: Extending by a component array
    When I call clone
    Then I should get an object which is a clone of the object being extended with the additional components loaded
