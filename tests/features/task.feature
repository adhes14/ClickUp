@api @task 
Feature: Task

    Defines scenarios for task feature
    @CK-001 @smoke @createTask @deleteTask @createSpace @createFolder @deleteFolder @getTeamId
    Scenario: A user can create a task (CK-001)
        Given the user sets the following file body:
        | fileName | createTask |
        When the "owner" user sends a "POST" request to "/list/217535144/task" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
          |name|New Task|
        And the schema response is verified with "taskSchema"

    @CK-002 @smoke @createTask @deleteTask @createSpace @createFolder @deleteFolder @getTeamId
    Scenario: A user can update a task (CK-002)
        Given the user sets the following file body:
        | fileName | updateTask |
        When the "owner" user sends a "PUT" request to "/task/3qv7fr5" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
          |name|Update Task|
        And the schema response is verified with "taskSchema"

    @CK-003 @smoke @createTask @deleteTask @createSpace @createFolder @deleteFolder @getTeamId
    Scenario: A user can get a task (CK-003)
        When the "owner" user sends a "GET" request to "/task/3qv7fr5" endpoint
        Then the response status code should be 200
        And the response body should have the following values:
          |name|Update Task|
        And the schema response is verified with "taskSchema"
