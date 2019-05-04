Given(/^I am in the login page$/) do
  visit '/login'
end

Given(/^I have an account with email "(.+)" and password "(.+)"$/) do |email, pass|
  @user = User.find(email)
  @user.nil? ? nil : @user.destroy
  @user = User.new
  @user.id = rand(100_000)
  @user.name = 'a_test_user'
  @user.email = email
  @user.password = pass
  @user.save
end

Given(/^The account was locked on (.*)$/) do |date|
  @locking_date = DateTime.parse(date)
  @user.login_tries = 3
  @user.save
end

When(/^I try to login ([0-9]+) times with email "(.*)" and password "(.*)"$/) do |times, email, pass|
  tries = times.to_i
  i = 0
  while i < tries do
    i += 1
    fill_in('user[email]', :with => email)
    fill_in('user[password]', :with => pass)
    click_button('Login')
  end
end

When(/^I try to login with email "(.*)" and password "(.*)"$/) do |email, pass|
  fill_in('user[email]', :with => email)
  fill_in('user[password]', :with => pass)
  click_button('Login')
end

When(/^I try to login with email "(.*)" and password "(.*)" on (.*)$/) do |email, pass, date|
  login_date = DateTime.parse(date)
  time_diff = @locking_date - login_date
  if time_diff.abs > 1
    time_diff *= -1
  end
  @user.lock_deadline = DateTime.now - time_diff
  @user.save
  fill_in('user[email]', :with => email)
  fill_in('user[password]', :with => pass)
  click_button('Login')
end

When(/^I logout$/) do
  visit '/logout'
  visit '/login'
end

Then(/^I should be successfully logged in$/) do
  page.should have_content(@user.email)
end

Then(/^My account should be locked$/) do
  page.should have_content('Your account has been locked')
end

Then(/^My account should not be locked$/) do
  page.should have_content('Invalid credentials')
end