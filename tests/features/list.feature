Feature: Lists

    Defines scenarios for Lists feature

    Scenario: Verify a new List can be created (CP-01)
        Given the user sets the following body:
            | name          | New List         |
            | content       | New List Content |
            | due_date      | 1567780450202    |
            | due_date_time | false            |
            | priority      | 1                |
            | assignee      | 183              |
            | status        | red              |
