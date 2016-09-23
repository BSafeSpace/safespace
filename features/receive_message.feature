Feature: Recieve a message to a buddy
    As a user 
    I want to be able to recieve messages from another user 
    So that I can know their thoughts and feelings

Background:
	Given the following Users exist:
    |username           |email                  |password           |
    |account_1          |account_1@berkeley.edu |12345678           |
    |account_2          |account_2@berkeley.edu |12345678           |

    When I am in account_1 browser
    Then I am logged in as account_1@berkeley.edu with 12345678
    And I follow "People"
    And I follow "Add Friend"
    When I am in account_2 browser
    Then I am logged in as account_2@berkeley.edu with 12345678
    And I follow "People"
    And I follow "Accept"
    Then I send message "Hello" to account_1
    
    
    Given the following Users exist:
    | username         | email                  | password    |
    | account_3        | account_3@berkeley.edu | 12345678   |
    
    When I am in account_1 browser
    And I follow "People"
    And I follow "Add Friend"
    And I log out
    When I am in account_3 browser
    Then I am logged in as account_3@berkeley.edu with 12345678
    And I follow "People"
    And I follow "Accept"

Scenario: Correct logged in user
	Given I am in account_2 browser
	And I follow "Chat"
	When I follow "account_1"
	Then I should see "Hello"

Scenario: Incorrect logged in user
	Given  I am in account_3 browser
	And I follow "Chat"
	When I follow "account_1"
	Then I should not see "Hello"