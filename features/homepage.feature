Feature: display home page when user is not logged in
 
  As a User that is not logged in
  So that I can see relevant goals and services that SafeSpace has to offer
  I want to be redirected to the home page.

Background: User is not logged in

Scenario: visit the SafeSpace home page
  Given I am not logged in
  When  I go to the SafeSpace home page
  Then I should see: About, Contact, Sign Up, Sign In, SafeSpace