@api @space
Feature: Space

    Defines scenarios for boards feature

    @CJ-001 @getTeamId @deleteSpace @functional
    Scenario: A user can create a space (CJ-001)
      Given the user sets the following file body:
        | fileName | createSpace |
      When the "owner" user sends a "POST" request to "/team/(team.id)/space" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
        | name               | Another Space From Cucumber |
        | multiple_assignees | false                       |
      And the schema response is verified with "spaceSchema"

    @CJ-002 @getTeamId @createSpace @deleteSpace @functional
    Scenario: A user can update a space (CJ-002)
      Given the user sets the following file body:
        | fileName | updateSpace |
      When the "owner" user sends a "PUT" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
          | name               | Updated Space Name |
          | multiple_assignees | true               |
      And the schema response is verified with "spaceSchema"

    @CJ-003 @functional @getTeamId @createSpace @wip
    Scenario: A user can delete a space (CJ-003)
      When the "owner" user sends a "DELETE" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should be empty

    @CJ-004 @functional @getTeamId @createSpace @deleteSpace @wip
    Scenario: A user can get a created space (CJ-003)
      When the "owner" user sends a "GET" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
        | name               | New Space from hook |
        | multiple_assignees | true                |
      And the schema response is verified with "spaceSchema"
