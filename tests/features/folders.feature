Feature: Folders

    Defines scenarios for Folders feature

    Scenario: A user can create a folder ()
        Given the user sets the following body:
            | name | New Folder |
        When the "owner" user sends a "POST" request to "/space/55613801/folder" endpoint
        # Then the response status code should be 200
        # And the response body should have the following values:
        #     | name | New Folder |
        # And the schema response is verified with "folderSchema"