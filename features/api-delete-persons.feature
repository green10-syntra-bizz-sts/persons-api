# Created by hans at 06.12.21
Feature: Delete all known persons via the API

  A Customer Service Representatieve (CSR)
  can delete all known persons

  Scenario: Delete all known persons
    Given a request url "http://localhost:5000/api/v1/persons"
    When the request sends DELETE
    Then the response status is 200
    And the response json at $.listPersons is false
