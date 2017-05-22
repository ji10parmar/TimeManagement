Feature: Returning user can login

Background: 

	Given the user "Nike" exists with email "Nike@gmail.com" and password "Secret"
	And I am on the home page

Scenario: User login with Name
	
	When I follow "Login"
	And I fill in "Name or email" with "Nike"
	And I fill in "Password" with "Secret"
	And I press "Log In"
	Then I should be on the dashboard
	And I should see "Welcome, you are now logged in as Nike"