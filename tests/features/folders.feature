@api @folder
Feature: Folders

    Defines scenarios for Folders feature

    @CA-01 @functional @smoke @getTeamId @createSpace @createFolder @deleteFolder @deleteSpace
    Scenario: Verify all folders into a space can be requested (CA-01)
        When the "owner" user sends a "GET" request to "/space/(space.id)/folder" endpoint
        Then the response status code should be 200
        And the quantity of "folders" found should be 1
        And Among all the "folders" found, the user saves one on position 0
        And the response body should have the following values:
            | name              | New Test Folder |
            | override_statuses | false           |
            | hidden            | false           |
            | permission_level  | create          |
        And the schema response is verified with "folderSchema"

    @CA-02 @functional @smoke @getTeamId @createSpace @createFolder @deleteFolder @deleteSpace
    Scenario: Verify a folder into a space can be requested (CA-02)
        When the "owner" user sends a "GET" request to "/folder/(folder.id)" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name              | New Test Folder |
            | override_statuses | false           |
            | hidden            | false           |
            | permission_level  | create          |
        And the schema response is verified with "folderSchema"

    @CA-03 @functional @smoke @getTeamId @createSpace @deleteFolder @deleteSpace
    Scenario: Verify a new folder can be created (CA-03)
        Given the user sets the following body:
            | name | New Folder |
        When the "owner" user sends a "POST" request to "/space/(space.id)/folder" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name              | New Folder |
            | override_statuses | false      |
            | hidden            | false      |
            | permission_level  | create     |
        And the schema response is verified with "folderSchema"

    @CA-04 @functional @smoke @getTeamId @createSpace @createFolder @deleteFolder @deleteSpace
    Scenario: Verify a new folder can be updated (CA-04)
        Given the user sets the following body:
            | name | Updated Folder Name |
        When the "owner" user sends a "PUT" request to "/folder/(folder.id)" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name              | Updated Folder Name |
            | override_statuses | false               |
            | hidden            | false               |
            | permission_level  | create              |
        And the schema response is verified with "folderSchema"

    @CA-05 @functional @smoke @getTeamId @createSpace @createFolder @deleteSpace
    Scenario: Verify a folder can be deleted (CA-05)
        When the "owner" user sends a "DELETE" request to "/folder/(folder.id)" endpoint
        Then the response status code should be 200
        And the response body should be empty

    @CA-06 @CA-07 @CA-08 @negative
    Scenario Outline: Verify a user cannot get a folder <tittle> id (<id>)
        When the "owner" user sends a "GET" request to "/folder/<invalidData>" endpoint
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle              | invalidData | statusCode | errMessage                                | errCode   |
            | CA-06 | without an          |             | 404        | Route not found                           | APP_001   |
            | CA-07 | with an invalid     | abcde       | 500        | invalid input syntax for integer: "abcde" | OAuth_025 |
            | CA-08 | with a non-existent | 999999999   | 401        | Team not authorized                       | OAUTH_027 |

    @CA-09 @CA-10 @negative @smoke @getTeamId @createSpace @createFolder @deleteFolder @deleteSpace
    Scenario Outline: Verify a user cannot get a folder <tittle> token (<id>)
        When the "<user>" user sends a "GET" request to "/folder/(folder.id)" endpoint
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle          | user             | statusCode | errMessage                    | errCode   |
            | CA-09 | without a       | withoutTokenUser | 400        | Authorization header required | OAUTH_017 |
            | CA-10 | with an invalid | invalidTokenUser | 401        | Token invalid                 | OAUTH_025 |