@api @task 
Feature: Task

    Defines scenarios for task feature
    @CK-01 @deleteTask @functional @getTeamId @createSpace @createTask @deleteFolder @deleteSpace @createFolder
    Scenario: A user can create a task (CK-01)
        Given the user sets the following complete body:
        """
        {
    "name": "Another Task From Cucumber",
    "description": null,
    "status": "to do",
    "assignees": [],
    "tags": [],
    "parent": null,
    "priority": null,
    "due_date": null,
    "start_date": null,
    "time_estimate": null,
    "custom_fields": [],
    "linked_tasks": [],
    "team_id": "31593470",
    "project": {
        "id": "121647208",
        "name": "New Task Name",
        "hidden": false,
        "access": true
    },
    "task": {
        "id": "121647208",
        "name": "New Task Name",
        "hidden": false,
        "access": true
    },
    "space": {
        "id": "55621491"
    }
        }

        """   
        When the "owner" user sends a "POST" request to "/list/217535144/task" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
          |name|Another Task From Cucumber|
        And the schema response is verified with "taskSchema"

