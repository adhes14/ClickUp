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

    @CJ-006 @CJ-007 @CJ-008 @CJ-009 @negative @getTeamId @createSpace @deleteSpaceB
    Scenario Outline:  A user cannot get a space <scenario> (<id>)
      When the "owner" user sends a "GET" request to "/space/<invalidData>" endpoint
      Then the response status code should be <code>
      Then the response body should have the following values:
          | err   | <err>   |
          | ECODE | <ECODE> |
    
      Examples:
          | id       | scenario               | invalidData | code | err                                          | ECODE     |
          | @CJ-006  | with empty space id    |             | 404  | Route not found                              | APP_001   |
          | @CJ-007  | from another team      | 88642614    | 401  | Team not authorized                          | OAUTH_027 |
          | @CJ-008  | with invalid id syntax | 5564fake    | 500  | invalid input syntax for integer: "5564fake" | OAuth_025 |
          | @CJ-009  | deleted                | (space.id)  | 404  | Space not found                              | PROJ_006  |    


    @CJ-0010 @CJ-0011 @negative @getTeamId @createSpace @deleteSpace
    Scenario Outline: A user cannot <scenario> (<id>)
      When the "owner" user sends a "GET" request to "/team/<endpoint>/space" endpoint
      Then the response status code should be <code>
      Then the response body should have the following values:
          | err   | <err>   |
          | ECODE | <ECODE> |

      Examples:
          | id       | scenario                               | endpoint    | code | err                                 | ECODE       |
          | @CJ-010  | get spaces with invalid team id syntax | (teamid)    | 400  | Team ID invalid                     | INPUT_001   |
          | @CJ-011  | get spaces with another user team id   | 31589777    | 401  | Team not authorized                 | OAUTH_023   |

    @CJ-012 @CJ-013 @negative
    Scenario Outline: Verify a user cannot get a space <title> token (<id>)
        When An invalid user sends a "GET" request to "/space/(space.id)" endpoint with the following header:
            | Authorization | <header> |
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id     | title           | header       | statusCode | errMessage                    | errCode   |
            | CJ-012 | without a       |              | 400        | Authorization header required | OAUTH_017 |
            | CJ-013 | with an invalid | pk_123456789 | 401        | Token invalid                 | OAUTH_025 |

    @CJ-014 @negative @getTeamId @createSpace @deleteSpace
    Scenario: A user cannot create a space with an exisiting space name (CJ-014) 
      Given the user sets the following file body:
          | fileName | createSpace |
      When the "owner" user sends a "POST" request to "/team/(team.id)/space" endpoint
      Then the response status code should be 400
      Then the response body should have the following values:
          | err   | Space with this name already exists |
          | ECODE | PROJECT_023                         |

    @CJ-015 @CJ-016 @negative @getTeamId @deleteSpace
    Scenario Outline: Verify a user cannot get a space <title> token (<id>)     
        Given the user sets the following file body:
            | fileName | createSpace |
        When An invalid user sends a "POST" request to "/team/(team.id)/space" endpoint with the following header:
            | Authorization | <header> |
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id     | title           | header       | statusCode | errMessage                    | errCode   |
            | CJ-015 | without a       |              | 400        | Authorization header required | OAUTH_017 |
            | CJ-016 | with an invalid | pk_123456789 | 401        | Token invalid                 | OAUTH_025 |

    @CJ-017 @CJ-018 @negative @getTeamId @createSpace @deleteSpace
    Scenario Outline: Verify a user cannot get a space <title> token (<id>)     
        Given the user sets the following file body:
            | fileName | updateSpace |
        When An invalid user sends a "PUT" request to "/space/(space.id)" endpoint with the following header:
            | Authorization | <header> |
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id     | title           | header       | statusCode | errMessage                    | errCode   |
            | CJ-017 | without a       |              | 400        | Authorization header required | OAUTH_017 |
            | CJ-018 | with an invalid | pk_123456789 | 401        | Token invalid                 | OAUTH_025 |