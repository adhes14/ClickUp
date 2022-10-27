Feature: Task

    Defines scenarios for task feature

    Scenario: A user can create a task (CK-01)
        Given the user sets the following complete body:
        """
        {
    "name": "Another Task From Cucumber",
    "text_content": null,
    "description": null,
    "status": "to do",
    "assignees": [],
    "watchers": [],
    "checklists": [],
    "tags": [],
    "parent": null,
    "priority": null,
    "due_date": null,
    "start_date": null,
    "points": null,
    "time_estimate": null,
    "custom_fields": [],
    "dependencies": [],
    "linked_tasks": [],
    "team_id": "31593470",
    "url": "https://app.clickup.com/t/3qa16f3",
    "permission_level": "create",
    "list": {
        "id": "217535144",
        "name": "New List Name",
        "access": true
    },
    "project": {
        "id": "121647208",
        "name": "New Task Name",
        "hidden": false,
        "access": true
    },
    "folder": {
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