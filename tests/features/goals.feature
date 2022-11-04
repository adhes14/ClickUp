@api @goal
Feature: Goals

    @CM-01 @functional @getTeamId @deleteGoal
    Scenario: Verify that a new goal can be created (CM-01)
        Given the user sets the following body:
            | name | Goal New Name |
            | due_date | 1568036964079 |
            | description | Goal Description |
            | multiple_owners | false |
            | color | #32a852 |
        When the "owner" user sends a "POST" request to "/team/(team.id)/goal" endpoint
        Then the response status code should be 200
        And the response body of the goal should have the following values:
            | name | Goal New Name |
        And the schema response is verified with "GoalSchema"

    @CM-02 @functional @getTeamId @createGoal @deleteGoal
    Scenario: Verify that a goal can be updated (CM-02)
        Given the user sets the following body:
            | name | Updated Goal Name |
            | due_date | 1568044355026 |
            | description | Updated Goal Description |
            | multiple_owners | false |
        When the "owner" user sends a "PUT" request to "/goal/(goal.goal.id)" endpoint
        Then the response status code should be 200
        And the response body of the goal should have the following values:
            | name | Updated Goal Name |
            | due_date | 1568044355026 |
            | description | Updated Goal Description |
            | multiple_owners | false |
        And the schema response is verified with "GoalSchema"
    
    @CM-03 @functional @getTeamId @createGoal
    Scenario: Verify that a goal can be deleted (CM-03)
        When the "owner" user sends a "DELETE" request to "/goal/(goal.goal.id)" endpoint
        Then the response status code should be 200
        And the response body should be empty

    @CM-04 @functional @getTeamId @createGoal @deleteGoal
    Scenario: Verify that a goal can be read (CM-04)
        Given the "owner" user sends a "GET" request to "/goal/(goal.goal.id)" endpoint
        Then the response status code should be 200
        And the response body of the goal should have the following values:
            | name | new goal from huk |
            | description | Some description here..... |
            | multiple_owners | false |
            | color | #32a852 |