# Created by hans at 06.12.21
Feature: Add a person via the API

  A Customer Service Representative (CSR)
  can add a person with firstname, lastname and emailaddress
  The CSR will be provided with a unique id

  Scenario: add a person to the known persons
    Given a request url "http://localhost:5000/api/v1/persons"
    And a request json payload
    """
      {
        "firstName": "Billie",
        "lastName": "Holliday",
        "eMailAddress" : "billy@holliday.inn"
      }
    """
    When the request sends POST
    Then the response status is 201
    And the response json at \$\.\._id is a hexadecimal number
    And the response json at $..firstName contains "Billie"
    And the response json at $..lastName contains "Holliday"
    And the response json at $..eMailAddress contains "billy@holliday.inn"
