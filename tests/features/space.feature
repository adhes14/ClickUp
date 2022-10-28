Feature: Space

    Defines scenarios for boards feature

    @deleteSpace
    Scenario: A user can create a space (CJ-001)
        Given the user sets the following complete body:
        """
        {
  "name": "Another Space From Cucumber",
  "multiple_assignees": false,
  "features": {
    "due_dates": {
      "enabled": true,
      "start_date": false,
      "remap_due_dates": true,
      "remap_closed_due_date": false
    },
    "time_tracking": {
      "enabled": false
    },
    "tags": {
      "enabled": true
    },
    "time_estimates": {
      "enabled": true
    },
    "checklists": {
      "enabled": true
    },
    "custom_fields": {
      "enabled": true
    },
    "remap_dependencies": {
      "enabled": true
    },
    "dependency_warning": {
      "enabled": true
    },
    "portfolios": {
      "enabled": true
    }
  }
}
        """   
        When the "owner" user sends a "POST" request to "/team/31589386/space" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
          |name|Another Space From Cucumber|
        And the schema response is verified with "spaceSchema"
