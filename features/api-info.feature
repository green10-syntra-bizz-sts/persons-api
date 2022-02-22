
# Created by hans at 06.12.21

Feature: Request API-inf

  A developer can request API Info

  Scenario: request all known API-info
    Given a request url "http://localhost:5000/api/v1/info"
    When the request sends GET
    Then the response status is 200
    And the response json at $..links contains "/api/v1/persons"
    And the response json at $..version contains "v1"
    And the response json at $..methods contains "GET, POST, DELETE"


