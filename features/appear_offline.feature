Feature: Show status of users
    As a user
    I want to be able to appear offline
    so that I can only talk to the buddies I want to.

Background:
  
    Given the following Users exist:
    | username     | email              | password    |
    | user1        | user1@berkeley.edu | password1   |
    | user2        | user2@berkeley.edu | password2   |
     
    # And I am on the SafeSpace home page

Scenario: user1 appears offline
  
    Given I am in user1 browser
    And I am logged in as user1@berkeley.edu with password1
    And user1 is not appearing offline
    And I am on the SafeSpace home page
    And I follow "user1"
    And I follow "Appear Offline"
    
    When I am in user2 browser
    And I am logged in as user2@berkeley.edu with password2
    And I am on the search page
    Then I should see "user1"
    And I should see "Offline" in the selector "div.status-text"
    And I should not see "Online" in the selector "div.status-text"
    
Scenario: user1 appears online
    Given I am in user1 browser
    And I am logged in as user1@berkeley.edu with password1
    And user1 is appearing offline
    And I am on the SafeSpace home page
    And I follow "user1"
    And I follow "Appear Online"
    
    When I am in user2 browser
    And I am logged in as user2@berkeley.edu with password2
    And I follow "People"
    Then I should see "user1"
    And I should see "Online" in the selector "div.status-text"
    And I should not see "Offline" in the selector "div.status-text"