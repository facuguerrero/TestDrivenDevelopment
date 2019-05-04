Given(/^I am in the registration view$/) do
  visit '/register'
end

Given(/^my name is (.*)$/) do |name|
  fill_in('user[name]', :with => name)
end

Given(/^my email is (.*)$/) do |email|
  fill_in('user[email]', :with => email)
end

Given(/^I input (.*) in the (.*) field$/) do |password, field|
  fill_in("user[#{field}]", :with => password)
end

When(/^I click create$/) do
  click_button('Create')
end

Then(/^I should see the message "(.*?)"$/) do |message|
  page.should have_content(message)
end