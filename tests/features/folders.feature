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

    @CA-09 @CA-10 @negative
    Scenario Outline: Verify a user cannot get a folder <tittle> token (<id>)
        When the "<user>" user sends a "GET" request to "/folder/(folder.id)" endpoint
        When An invalid user sends a "GET" request to "/folder/(folder.id)" endpoint with the following header:
            | Authorization | <header> |
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle          | user             | header       | statusCode | errMessage                    | errCode   |
            | CA-09 | without a       | withoutTokenUser |              | 400        | Authorization header required | OAUTH_017 |
            | CA-10 | with an invalid | invalidTokenUser | pk_123456789 | 401        | Token invalid                 | OAUTH_025 |

    @CA-11 @CA-12 @CA-13 @negative
    Scenario: Verify a user cannot get all folders <tittle> space id (<id>)
        When the "owner" user sends a "GET" request to "/space/<invalidData>/folder" endpoint
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle              | invalidData | statusCode | errMessage                              | errCode   |
            | CA-11 | without a           |             | 404        | Route not found                         | APP_001   |
            | CA-12 | with an invalid     | abc         | 500        | invalid input syntax for integer: "abc" | OAuth_025 |
            | CA-13 | with a non-existent | 9999999999  | 401        | Team not authorized                     | OAUTH_027 |

    @CA-14 @CA-15 @CA-16 @negative
    Scenario: Verify a user cannot create a folder <tittle> space id (<id>)
        When the "owner" user sends a "POST" request to "/space/<invalidData>/folder" endpoint
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle              | invalidData | statusCode | errMessage                              | errCode   |
            | CA-14 | without a           |             | 404        | Route not found                         | APP_001   |
            | CA-15 | with an invalid     | abc         | 500        | invalid input syntax for integer: "abc" | OAuth_025 |
            | CA-16 | with a non-existent | 9999999999  | 401        | Team not authorized                     | OAUTH_027 |

    @CA-17 @CA-18 @CA-19 @negative
    Scenario: Verify a user cannot update a folder <tittle> folder id (<id>)
        When the "owner" user sends a "PUT" request to "/folder/<invalidData>" endpoint
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle              | invalidData | statusCode | errMessage                              | errCode   |
            | CA-17 | without a           |             | 404        | Route not found                         | APP_001   |
            | CA-18 | with an invalid     | abc         | 500        | invalid input syntax for integer: "abc" | OAuth_025 |
            | CA-19 | with a non-existent | 9999999999  | 401        | Team not authorized                     | OAUTH_027 |


    @CA-20 @CA-21 @CA-22 @negative
    Scenario: Verify a user cannot delete a folder <tittle> folder id (<id>)
        When the "owner" user sends a "DELETE" request to "/folder/<invalidData>" endpoint
        Then the response status code should be <statusCode>
        And the response body should have the following values:
            | err   | <errMessage> |
            | ECODE | <errCode>    |

        Examples:
            | id    | tittle              | invalidData | statusCode | errMessage                              | errCode   |
            | CA-20 | without a           |             | 404        | Route not found                         | APP_001   |
            | CA-21 | with an invalid     | abc         | 500        | invalid input syntax for integer: "abc" | OAuth_025 |
            | CA-22 | with a non-existent | 9999999999  | 401        | Team not authorized                     | OAUTH_027 |

    @CA-23 @negative @getTeamId @createSpace @deleteFolder @deleteSpace
    Scenario: Verify a user cannot create a folder with a space as a name (CA-23)
        Given the user sets the following file body:
            | fileName | createInvalidFolder |
        When the "owner" user sends a "POST" request to "/space/(space.id)/folder" endpoint
        Then the response status code should be 400
        And the response body should have the following values:
            | err   | Project name invalid |
            | ECODE | CAT_021              |