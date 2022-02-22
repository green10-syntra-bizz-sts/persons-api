# Created by hans at 06.12.21
Feature: List all known persons via the API

  A Customer Service Representatieve (CSR)
  can list all known persons

  Scenario: List all known persons
    # The following request url is valid for DELETE-ing POST-ing the initial data too
    Given a request url "http://localhost:5000/api/v1/persons"
    And the following persons are known
      | firstName           | lastName            | eMailAddress        |
      | Hans                | Vandenbogaerde      | hans.vdb@gmail.com  |
      | Nina                | Simone              | nina@baltimore.com  |
      | Deedee              | Bridgewater         | deedee@paris.fr     |
    When the request sends GET
    Then the response status is 200
    And the response json at $.listPersons[0].eMailAddress contains "hans.vdb@gmail.com"
    And the response json at $.listPersons[1].eMailAddress contains "nina@baltimore.com"
    And the response json at $.listPersons[2].eMailAddress contains "deedee@paris.fr"
