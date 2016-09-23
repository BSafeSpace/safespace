Feature: sign in to user account

    As a new user
    So that I can use other features of SafeSpace
    I want to be able to sign in with my username and password

Background:
  
    Given the following Users exist:
    
    |username          |email                   |password           |
    |my_account        |my_account@berkeley.edu |qwertyuiop         |
    
    And I am on the Sign In page

Scenario: Sign in with correct username and password pair
    When I fill in "Email" with "my_account@berkeley.edu"
    And I fill in "Password" with "qwertyuiop"
    And I press "Log in"
    Then I should see "my_account"

Scenario: Sign in with incorrect username and password pair
    When I fill in "Email" with "does_not_exist@berkeley.edu"
    And I fill in "Password" with "qwerty1212sa"
    And I press "Log in"
    Then I should see "Invalid email or password"


    

    
  