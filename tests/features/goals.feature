# Feature: Goals

<<<<<<< HEAD
    Scenario: Verify that a new goal can be created (CM-01)
        Given the user sets the following body:
            | name | Goal New Name |
            | due_date | 1568036964079 |
            | description | Goal Description |
            | multiple_owners | false |
            | color | #32a852 |
        When the "owner" user sends a "POST" request to "/team/31589353/goal" endpoint
        Then the response status code should be 200
        And the response body of the goal should have the following values:
            | name | Goal New Name |
            
=======
#     Scenario: Verify that a new goal can be created (CM-01)
#         Given the user sets the following body:
#             | name | Goal New Name |
#             | due_date | 1568036964079 |
#             | description | Goal Description |
#             | multiple_owners | false |
#             | color | #32a852 |
#         When the "owner" user sends a "POST" request to "/team/31589353/goal" endpoint
#         Then the response status code should be 200
#         And the response body of the goal should have the following values:
#             | name | Goal New Name |
#         # And the schema response is verified with "folderSchema"
>>>>>>> 35b8549 (create a request manager and refactor create folder test)
