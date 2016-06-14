Feature: Sign Up Survey
    As a user I wanted to be able to sign up
    
Background: 
    Given I am on the Sign Up page
    
Scenario:
  
    When I fill in "Username" with "account_1"
    And I fill in "Email" with "rockers@berkeley.edu"
    And I fill in "Password" with "asdfghjk"
    And I fill in "Password confirmation" with "asdfghjk"
    And I press "Sign up"

