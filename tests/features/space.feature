@api @space
Feature: Space

    Defines scenarios for boards feature

    @CJ-001 @getTeamId @deleteSpace @functional @wip
    Scenario: A user can create a space (CJ-001)
      Given the user sets the following file body:
        | fileName | createSpace |
      When the "owner" user sends a "POST" request to "/team/(team.id)/space" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
        | name               | Another Space From Cucumber |
        | multiple_assignees | false                       |
      And the schema response is verified with "spaceSchema"

    @CJ-002 @getTeamId @createSpace @deleteSpace @functional @wip
    Scenario: A user can update a space (CJ-002)
      Given the user sets the following file body:
        | fileName | updateSpace |
      When the "owner" user sends a "PUT" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
          | name               | Updated Space Name |
          | multiple_assignees | true               |
      And the schema response is verified with "spaceSchema"
