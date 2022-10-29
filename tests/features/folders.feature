@api @folder
Feature: Folders

    Defines scenarios for Folders feature

    @CA-01 @functional @getTeamId @createSpace @createFolder @deleteFolder @deleteSpace
    Scenario: Verify all folders into a space can be requested (CA-01)
        When the "owner" user sends a "GET" request to "/space/(space.id)/folder" endpoint
        Then the response status code should be 200
        And the quantity of "folders" found is 1
        And the response body should have the following values:
            | name              | New Test Folder |
            | override_statuses | false           |
            | hidden            | false           |
            | permission_level  | create          |
        And the schema response is verified with "folderSchema"

    @CA-02 @functional @getTeamId @createSpace @createFolder @deleteFolder @deleteSpace
    Scenario: Verify a folder into a space can be requested (CA-02)
        When the "owner" user sends a "GET" request to "/folder/(folder.id)" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name              | New Test Folder |
            | override_statuses | false           |
            | hidden            | false           |
            | permission_level  | create          |
        And the schema response is verified with "folderSchema"

    @CA-03 @functional @getTeamId @createSpace @deleteFolder @deleteSpace
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