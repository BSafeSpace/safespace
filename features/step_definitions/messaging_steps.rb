When (/^I send message (.*) to (.*)$/) do |message, user|
	step "When I am in a chat with #{user}"
	step "And I fill in \"message_body\" with #{message}"
    step "And I press \"Send\""
end

When (/^I log out$/) do
	steps %{
		When I follow "Log out"
	}
end

Given(/^user (.*) email (.*) password (.*) friend with user (.*) email (.*) password (.*)$/) do |user1,email1,pass1,user2,email2,pass2|
  steps %{
    When I am in user2 browser
    Then I am logged in as email2 with pass2
    And I follow "Chat"
    # And I follow "Add Friend"
    # When I am in user1 browser
    # Then I am logged in as email1 with pass1
    # And I follow "Chat"
    # And I follow "Accept"
  }
  @current_user = User.find_by(email: email1 )
end


Given(/^I am logged in as (.*) with (.*)$/) do |email1,password|
  steps %{
    When I am on the Sign In page
    And I fill in "Email" with "#{email1}"
    And I fill in "Password" with "#{password}"
    And I press "Log in"
  }
  @current_user = User.find_by(email: email1 )
end

Given(/^(.*) is (not )?appearing offline$/) do |user, online|
    @user = User.find_by(username: user)
    if online
        @user.appear_offline = false
        @user.save!
    else
        @user.appear_offline = true
        @user.save!
    end
end

When (/I am in a chat with (.*)$/) do |user2|
	params = ActionController::Parameters.new({
		sender_id: @current_user.id,
		recipient_id: User.find_by(username: user2).id
		})
	@conversation = Conversation.create!(params.permit(:sender_id,:recipient_id))
	visit conversation_messages_path(@conversation)
end

When /^I am in (.*) browser$/ do |name|
  Capybara.session_name = name
end

When /^(?!I am in)(.*(?= in)) in (.*) browser$/ do |step, name|
  When %(I am in #{name} browser)
  And step
end

And /^I setup a server for websocket$/ do
	setup_server
end
# Then /^I should see "([^"]*)" within "([^"]*)"$/ do |text, selector|
#   find(:xpath, "//#{selector}[contains(text(),'#{text}')]").should_not(be_nil, "Could not find the text '#{text}' within the selector '#{selector}'")
# end

Then (/^I should (not )?see "([^"]*)" in the selector "([^"]*)"$/) do |not_see, text, selector|
  if not_see
    page.should_not have_css(selector, :text => text)
  else
    page.should have_css(selector, :text => text)
  end
end

Given(/^I am not friends with (.*)$/) do |user|
end

When(/^I uncheck all checkboxes$/) do
end

When(/^I check "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
end