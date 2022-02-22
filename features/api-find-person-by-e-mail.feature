# Created by hans at 06.12.21
Feature: Find a person by their e-mail address via the API

  A Customer Service Representatieve (CSR)
  can find a person by their e-mail address

  Background:
    # The following request url is valid for DELETE-ing and POST-ing the intial data
    Given a request url "http://localhost:5000/api/v1/persons"
    And the following persons are known
      | firstName           | lastName            | eMailAddress        |
      | Hans                | Vandenbogaerde      | hans.vdb@gmail.com  |
      | Nina                | Simone              | nina@baltimore.com  |
      | Deedee              | Bridgewater         | deedee@paris.fr     |

  Scenario: Find an existing person by their e-mail-address
    Given a request url "http://localhost:5000/api/v1/persons/hans.vdb@gmail.com"
    When the request sends GET
    Then the response status is 200
    And the response json at $.foundPerson contains "Hans Vandenbogaerde, hans.vdb@gmail.com"

  Scenario: Do not find a non-existing person by a fake e-mail-address
    Given a request url "http://localhost:5000/api/v1/persons/marc.rutte@gmail.com"
    When the request sends GET
    Then the response status is 404
    And the response json at $.unknown contains "marc.rutte@gmail.com"
