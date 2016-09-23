Feature: Show status of users
    As a user
    I want to be able to know if a user is online
    so that I know if I can get a prompt reply.
​
Background:
  
    Given the following Users exist:
    | username     | email              | password    |
    | user1        | user1@berkeley.edu | password1   |
    | user2        | user2@berkeley.edu | password2   |

Scenario: A user is offline
    When I am in user1 browser
    Then I am logged in as user1@berkeley.edu with password1
    And I follow "People"
    Then I should see "user2"
    Then I should see "Offline" in the selector "div.status-text"
    Then I should not see "Online" in the selector "div.status-text"

Scenario: A user is online
    When I am in user2 browser
    Then I am logged in as user2@berkeley.edu with password2

    Then I am in user1 browser
    Then I am logged in as user1@berkeley.edu with password1
    And I follow "People"
    Then I should see "Online" in the selector "div.status-text"
    Then I should not see "Offline" in the selector "div.status-text"
