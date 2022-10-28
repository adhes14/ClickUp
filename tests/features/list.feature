@api @list
Feature: Lists

    Defines scenarios for Lists feature
    @CP-01 @deleteList @functional
    Scenario: Verify a new List can be created (CP-01)
        Given the user sets the following body:
            | name          | New List         |
            | content       | New List Content |
            | due_date      | 1567780450202    |
            | due_date_time | false            |
            | priority      | 1                |
            | assignee      | 49633402         |
            | status        | red              |
        When the "owner" user sends a "POST" request to "/folder/121610261/list" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name              | New List              |
            | content           | New List Content      |
        And the schema response is verified with "listSchema"