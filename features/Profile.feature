Feature: User can view own profile

Background: 

	Given the user "mike" exists with email "mike@gmail.com" and password "secret"
	And I am on the home page

Scenario: User views own profile
	
	When I follow "Login"
	And I fill in "Name or email" with "mike"
	And I fill in "Password" with "secret"
	And I press "Log In"
	Then I should be on the dashboard
	And I should see "Welcome, you are now logged in as mike"
	When I follow "Profile"
	Then I should be on the profile page
	