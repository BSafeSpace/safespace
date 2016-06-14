Feature: See Chat page when signed in

    As a user 
    I want to be able to see my chats
    So that I can see my conversations with other users

Background:
  
    Given the following Users exist:
    
    | username     | email              | password    |
    | user1        | user1@berkeley.edu | password1   |

Scenario: User is signed in
    Given I am on the Sign In page
    And I fill in "Email" with "user1@berkeley.edu"
    And I fill in "Password" with "password1"
    And I press "Log in"
    Then I should be on the SafeSpace home page
    And I should see "Chat"

Scenario: User is not signed in
    Given I am on the SafeSpace home page
    Then I should not see "Chat"
    


 
