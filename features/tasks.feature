Feature: Manipulate tasks
  As a user
  I want manipulate tasks
  In order to organize them

  Scenario: Register task successfully
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a category with name "Feature" and color "ffa5a5"
    And I am on the "Sgtran" tasks page
    When I follow "New Task"
    And I fill in "Title" with "Create issues"
    And I fill in "Description" with "Create issues for kanban-roots project"
    And I select "5" from "Points"
    And I select "Feature" from "Category"
    And I select "" from "Position"
    And I press "Save"
    Then I should be on the projects board page
    And I should see "Task was successfully created."
    And I should see "Create issue"
    And "Sgtran" project should have "1" task

  Scenario: Try to register tasks with errors
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I am on the "Sgtran" tasks page
    When I follow "New Task"
    When I fill in "Title" with ""
    And I press "Save"
    Then I should see "Title can't be blank"

  Scenario: Tasks description should be rendered with Markdown syntax
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    When I am on the task edit page
    And I fill in "Description" with "## Some content here with _emphasis_"
    And I press "Save"
    And I go to the task page
    And I should see "Some content here" within the "h2" tag
    And I should see "emphasis" within the "em" tag

  Scenario: Edit a task
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    When I am on the task edit page
    And I fill in "Title" with "Close issue"
    And I press "Save"
    Then I should be on the projects board page
    Then I should see "Close issue"

  @javascript
  Scenario: Destroy task
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    When I am on the "Sgtran" tasks page
    And I follow "Destroy" and press ok at the pop-up
    Then I should be on the projects board page
    And The task should no longer exist

  Scenario: Add sponsors for a task
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    And I have a team
    And "Hugo Maia" belongs to the team
    And "Rodrigo Manhães" belongs to the team
    And the team works on this project
    When I am on the task edit page
    And I select "Hugo Maia" from "Sponsors"
    And I select "Rodrigo Manhães" from "Sponsors"
    And I press "Save"
    Then I should be on the projects board page
    And I should see "Task was successfully updated."
    And "Hugo Maia" should be a sponsor of the task
    And "Rodrigo Manhães" should be a sponsor of the task

