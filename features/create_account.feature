Feature: create a new user account
  
    As an individual suffering from depression
    So I can talk to others like myself
    I want to be able to create an account on SafeSpace
 
Background:
    
    Given the following Users exist:
    |username           |email                  |password           |
    |account_1          |account_1@berkeley.edu |qwertyuiop         |

    And I am on the Sign Up page

Scenario: create an account with existing username
    When I fill in "Username" with "account_1"
    And I fill in "Email" with "rockers@berkeley.edu"
    And I fill in "Password" with "asdfghjk"
    And I fill in "Password confirmation" with "asdfghjk"
    And I press "Sign up"
    And I should see "Username has already been taken"

Scenario: create an account with existing email
    When I fill in "Username" with "new_account"
    And I fill in "Email" with "account_1@berkeley.edu"
    And I fill in "Password" with "asdfghjk"
    And I fill in "Password confirmation" with "asdfghjk"
    And I press "Sign up"
    And I should see "Email has already been taken"

Scenario: create an account with new username and email
    When I fill in "Username" with "new_account"
    And I fill in "Email" with "new_account@berkeley.edu"
    And I fill in "Password" with "asdfghjk"
    And I fill in "Password confirmation" with "asdfghjk"
    And I press "Sign up"
    And I should see "signed up successfully"

Scenario: create an account with non-berkeley email
    When I fill in "Username" with "new_account"
    And I fill in "Email" with "new_account@gmail.com"
    And I fill in "Password" with "asdfghjk"
    And I fill in "Password confirmation" with "asdfghjk"
    And I press "Sign up"
    And I should see "Must use berkeley.edu email"

Scenario: create an account with different password confirmation
    When I fill in "Username" with "new_account"
    And I fill in "Email" with "new_account@gmail.com"
    And I fill in "Password" with "asdfghjk"
    And I fill in "Password confirmation" with "qwertyuiop"
    And I press "Sign up"
    And I should see "Password confirmation doesn't match Password"

    
  