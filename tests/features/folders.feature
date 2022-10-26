Feature: Folders

    Defines scenarios for Folders feature

    Scenario: Verify a new folder can be created (CA-03)
        # Sets a body object for an API request
        Given the user sets the following body:
            | name | New Folder |
        # Sets type of user, verb type and the endpoint of the request
        When the "owner" user sends a "POST" request to "/space/55613801/folder" endpoint
        # Defines the response status
        Then the response status code should be 200
        # Sets a 2 dimension array for a response
        And the response body should have the following values:
            | name              | New Folder |
            | override_statuses | false      |
            | permission_level  | create     |
        # And the schema response is verified with "folderSchema"