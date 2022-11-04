@api @task
Feature: Task

    Defines scenarios for task feature
    @CK-01 @deleteTask @smoke @getAssigneeId @getTeamId @createSpace @createFolder @createList @deleteList @deleteFolder @deleteSpace
    Scenario: A user can create a task (CK-01)
        Given the user sets the following body:
            | name            | Another Task From Cucumber    |
            | description     | New Task Description from API |
            | due_date        | 1508369194377                 |

        When the "owner" user sends a "POST" request to "/list/(list.id)/task" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name | Another Task From Cucumber |
        And the schema response is verified with "taskSchema"

    @CK-002 @deleteTask @smoke @getAssigneeId @getTeamId @createSpace @createFolder @createList @deleteList @deleteFolder @deleteSpace @createTask @wip
    Scenario: A user can update a task (CK-002)
        Given the user sets the following body:
            | name            | Task 2                        |
            | description     | Update Description of task 2  |
            | due_date        | 1508369194377                 |


        When the "owner" user sends a "PUT" request to "/task/(task.id)" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name            | Task 2                        |
            | description     | Update Description of task 2  |
        And the schema response is verified with "taskSchema"

    @CK-003 @deleteTask @smoke @getAssigneeId @getTeamId @createSpace @createFolder @createList @deleteList @deleteFolder @deleteSpace @createTask
    Scenario: A user can get a task (CK-003)
        When the "owner" user sends a "GET" request to "/task/(task.id)" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
            | name            | new task from hook            |
            | description     | Some description here.....    |
            | due_date        | 1568012400000                 |
        And the schema response is verified with "taskSchema"

