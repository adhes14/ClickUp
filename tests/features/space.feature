@api @space
Feature: Space

    Defines scenarios for boards feature

    @CJ-001 @smoke @functional @getTeamId @deleteSpace
    Scenario: A user can create a space (CJ-001)
      Given the user sets the following file body:
        | fileName | createSpace |
      When the "owner" user sends a "POST" request to "/team/(team.id)/space" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
        | name               | Another Space From Cucumber |
        | multiple_assignees | false                       |
      And the schema response is verified with "spaceSchema"

    @CJ-002 @smoke @functional @getTeamId @createSpace @deleteSpace
    Scenario: A user can update a space (CJ-002)
      Given the user sets the following file body:
        | fileName | updateSpace |
      When the "owner" user sends a "PUT" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
          | name               | Updated Space Name |
          | multiple_assignees | true               |
      And the schema response is verified with "spaceSchema"

    @CJ-003 @smoke @functional @getTeamId @createSpace
    Scenario: A user can delete a space (CJ-003)
      When the "owner" user sends a "DELETE" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should be empty

    @CJ-004 @smoke @functional @getTeamId @createSpace @deleteSpace
    Scenario: A user can get a created space (CJ-003)
      When the "owner" user sends a "GET" request to "/space/(space.id)" endpoint
      Then the response status code should be 200
      And the response body should have the following values:
        | name               | Another Space From Cucumber |
        | multiple_assignees | false                       |
      And the schema response is verified with "spaceSchema"

    @CJ-005 @smoke @functional @getTeamId @createSpace @deleteSpace
    Scenario: Verify all spaces into a team can be requested (CJ-005)
      When the "owner" user sends a "GET" request to "/team/(team.id)/space" endpoint
      Then the response status code should be 200
      And the quantity of "spaces" found should be 1
      And Among all the "spaces" found, the user saves one on position 0
      And the response body should have the following values:
          | name               | Another Space From Cucumber |
          | multiple_assignees | false                       |
      And the schema response is verified with "spaceSchema"

    @CJ-006 @negative
    Scenario: A user cannot get spaces with invalid team id (CJ-006)
      When the "owner" user sends a "GET" request to "/team/(teamid)/space" endpoint
      Then the response status code should be 400
      Then the response body should have the following values:
          | err   | Team ID invalid |
          | ECODE | INPUT_001       |

    @CJ-007 @negative @getTeamId @createSpace @deleteSpace
    Scenario: A user cannot get a space with empty space id (CJ-007)
      When the "owner" user sends a "GET" request to "/space" endpoint
      Then the response status code should be 404
      Then the response body should have the following values:
          | err   | Route not found |
          | ECODE | APP_001         |

    @CJ-008 @negative
    Scenario: A user cannot get a space from another user (CJ-008)
      When the "owner" user sends a "GET" request to "/space/88642614" endpoint
      Then the response status code should be 401
      Then the response body should have the following values:
          | err   | Team not authorized |
          | ECODE | OAUTH_027           |

    @CJ-009 @negative
    Scenario: A user cannot get a space with invalid space id syntax (CJ-009)
      When the "owner" user sends a "GET" request to "/space/5564fake" endpoint
      Then the response status code should be 500
      Then the response body should have the following values:
          | err   | invalid input syntax for integer: "5564fake" |
          | ECODE | OAuth_025                                    |

    @CJ-010 @smoke @negative @getTeamId @createSpace @deleteSpace
    Scenario: A user cannot create a space with an exisiting space name (CJ-010) 
      Given the user sets the following file body:
          | fileName | createSpace |
      When the "owner" user sends a "POST" request to "/team/(team.id)/space" endpoint
      Then the response status code should be 400
      Then the response body should have the following values:
          | err   | Space with this name already exists |
          | ECODE | PROJECT_023                         |

    @CJ-011 @smoke @negative @getTeamId @createSpace @deleteSpaceB
    Scenario: A user cannot get a deleted space (CJ-011)
      When the "owner" user sends a "GET" request to "/space/(space.id)" endpoint
      Then the response status code should be 404
      Then the response body should have the following values:
          | err   | Space not found |
          | ECODE | PROJ_006        |